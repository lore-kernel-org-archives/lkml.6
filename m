Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890D0C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7162086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ml9BC6eM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7162086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeIHTtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:49:53 -0400
Received: from mail-eopbgr730076.outbound.protection.outlook.com ([40.107.73.76]:19045
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727608AbeIHTtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz3na9iWZchYjpyX2mh0Owz4vmHzUIGY5zRph6sdHhY=;
 b=Ml9BC6eMpYYomC5K16sQnDUKEgkOSnCCML9f8m+4jJfq7pkGgHjyW3S8GwI2JKq5GEtt9gXdndrUk5Bl4DjEUyjX6Ww8pMTfZBlquqfyI2qwuJh/MwvLmRpSBUwKQ3d9+iFIXBxJiu0JNDTTPbMqTda89HjUmHYxrzCtmb5TI+Q=
Received: from BYAPR02CA0058.namprd02.prod.outlook.com (2603:10b6:a03:54::35)
 by DM2PR02MB510.namprd02.prod.outlook.com (2a01:111:e400:2422::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Sat, 8 Sep
 2018 15:03:22 +0000
Received: from SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BYAPR02CA0058.outlook.office365.com
 (2603:10b6:a03:54::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14 via Frontend
 Transport; Sat, 8 Sep 2018 15:03:21 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT025.mail.protection.outlook.com (10.152.72.87) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Sat, 8 Sep 2018 15:03:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelc-0002ch-MF; Sat, 08 Sep 2018 08:03:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelX-0004pQ-Ij; Sat, 08 Sep 2018 08:03:15 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w88F39JW031608;
        Sat, 8 Sep 2018 08:03:09 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyelR-0004of-04; Sat, 08 Sep 2018 08:03:09 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 2A75A60493; Sat,  8 Sep 2018 20:33:08 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v4 7/8] usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl fields
Date:   Sat, 8 Sep 2018 20:33:05 +0530
Message-ID: <1536418986-16609-8-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(305945005)(336012)(76176011)(106466001)(6346003)(356003)(26005)(2616005)(36756003)(51416003)(50466002)(63266004)(48376002)(478600001)(81156014)(81166006)(36386004)(426003)(6266002)(42186006)(16586007)(11346002)(316002)(103686004)(50226002)(47776003)(52956003)(446003)(110136005)(54906003)(107886003)(106002)(4326008)(476003)(486006)(14444005)(126002)(5660300001)(2906002)(90966002)(39060400002)(8676002)(6666003)(186003)(8936002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR02MB510;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT025;1:kx0FgZlXOiRzKd4R7BpPbAHZrtiE5qBeSS0iVmQJq4gJfUEFlmSjb5vTqYYIe+lNJhZA3Q5RunSHBoiU6LK3Yv/2D+63HVYkQDa/lfYcvI20XOI395C93GtkBO0H7QcZ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bc7bee1-06ed-4551-08c9-08d6159c37b7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM2PR02MB510;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB510;3:s+IQst9e8zclytvgaN79ld5JCiuKrAnxuom2VVF98AEqg4CsZCPkIU5rYABv9kTJDOSXmaSkXZ7iFO/kbGYvePX3aDGtylMs6Awn29A6hr5JCvCR77Pgik2rwUpnHue7iGIahrlc6J8oo6vQYrPpZvyiENfoWLuhPQK4/+iuQ+dFv2j8Z2Ka1tX7zIkdso5XWETyEQRXLoGQ6eGBg4lzy2g7adHPPruwDNZnmQdp3GZmmKTGrO+LaLWLgoelW88sfpyzmCaIDRretLxfbTAD7pR2DNIAdb5n1twZX2dynaxkkJSliciiALhajiJOzNM554zy6KSUsUJgfEy7HSNMuMAlTZq5Fgclpn4peuC8eVU=;25:zvzY/XTLouL43fZKpgFFpMJsEkUGYm2C/mCDeRem/12qGMh/n7VwqQTDGLPeVWAYrR0wYG2puQGePQnqta2o5Ixd6Bsx/euZh7gH8Dg7yXrTkU4f0MTUVbED9Zfugz0oduUhGOqyplrQGNrsGporWqZZIy/uJaB5DRzV1p4a9ZXHN7hbJyg+JiRVpqBxObe0ySsWLTcakeMpMzlOT/sZ8ttxhsYUlNW8vUADu/89e3vEx6gHeVBisFzqxsQegebJrpXv3Kc/ewxbr66frZtfy7okUbCnb/ZSuWpsSvAFyNxH2FxfC6cJs7asbH5Juzid7f9jAHiOdC1gZ7IFzjbbXw==
X-MS-TrafficTypeDiagnostic: DM2PR02MB510:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB510;31:mMI+gA4oBEj4ydcVPXWGqOsV+2qrlqW2dIbSPLps84/ePq2yp/AylY1uMGdIo6iYoZ++Wr8iWKI7N6tdWcofveConIW3uyzpHAjK327sVfX/tEkIpbKQ4fMe06kVE2+7U54H0jn+0/qki06hzt1RoKMjvMw2F5T0Yo4dv+xex+Zqy7vLtYKBsTzG1ku0lg9BM68JwUDsWLRFhGHKmle/Lhbvl5vZ7yC9ofuC6n6Tr4w=;20:MwV19hBLm2vvVldnpZgfWJYkSz4jlF23gfJNhZC4FlZESiv//fGhkC0+akTWxi9PPm7p3egJ26s07eiAo3sWJkSDOj6XybLfFkXMRMQSPcCHh5hw/max5zfqpYbv4f4fMsny9/h0+49qN9FZORFHFGzpo/TvGAqAUYeq2a5Dj4xIIhat23bN3la3CvL3KBw2ahmj6Woz5QWbVE+A7G03Of7B/dFqYHRqKPogJWWKrVmRTcJMBU4GyVee7gyRFcRWcLnoxPMF+LcxNynf3W5lXvTALeHl8vZsfEsUi22yBXFiGB0XlqXgJYiJ6RJH/aPMX2kMBXUBOmtuaH57qDo+qQXHoG8BZcjeb2BDnPWClX1Q7vbs2yf6GC0j4BKzNqy+SoMhsnqwQrbM/iVmk7QQMtIOEqplk70UChrEQ7F1wuh8n+9ynPklHOE3bjo6SK1OWRybcb4rlfyRzYw/v7Pi05Qvw/HoaA9tPqgJ4Uj38twEMQvaKM6WIt6/geVe869p
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM2PR02MB510B749A32934A5C6CE0662A7070@DM2PR02MB510.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231344)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DM2PR02MB510;BCL:0;PCL:0;RULEID:;SRVR:DM2PR02MB510;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB510;4:o/M1ofztGQjWK0wLvB1nq8eZad+mxbi589Bh450509LhNE6wrcFWljlUJ0eLx/oIEDt15VJIFbQLfy+Hv2y4sO3aZBxSDeXNVlPafBLp8dgEYFWbn1MepJkYrtTY7RbW4JXHK5obLRx9zgywjG84LgYuVbLyi9QC6Spp6gdDajvxnSXKJ6jZWD+YB3c1QGL3a4NRflrkYy8JPDurApJvKfkGD0u93sNLJqWSppHBOx32c9OHKi7tgvn7QlA5LuuFBx2S/NUJKJ/4opKWfSkXMXo6c19b8KGKdI3v9tJV3F/XJSKlI7OXnfPh5omj7IvQ
X-Forefront-PRVS: 07891BF289
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR02MB510;23:31p9q8/pPjGG/cDhKm79dP278CsY3ASst15iVPRcUM?=
 =?us-ascii?Q?5JX9Kl9X0qhIR53k2lkX3I0Yk6TbPvInmIaMQwbNI5fEdJHVk4NUiaRdyWiY?=
 =?us-ascii?Q?tRx7VlqLZYu5eYi9jLwbuRupSRUy9gOpWoD7NmA5qpHmLf2q4DFn0Oivg0SS?=
 =?us-ascii?Q?JGKB0fyNXZWpLHn8YUWJwg8Gzt7wntqi0O3sHzQN1fFoAeZXamktZkMG5+8f?=
 =?us-ascii?Q?zDEDYDKRMp1peiXUHHPOASg+2pCDlfA50naO/KNLg0oMIAMTxEwBGXjYxv0w?=
 =?us-ascii?Q?NJzm+wm8VIF9rzKT5+ezuoFf3w56SG1PBQaQurYaAhg4oiGlfzhlOVTN1Wp/?=
 =?us-ascii?Q?yf0STuvZLfiWo4TU8JIzZrXNEWB5xRvzCTCXOzCVEXQJZ3jPQxBkq+/OWtbA?=
 =?us-ascii?Q?N/fTGejp/OlOvREpidNAWqRA9QiqLh2lD8foWbciOmKmWV78UtNMe8PS69Y7?=
 =?us-ascii?Q?GDbmku9O5kpWwVqQ4FdGS5YP1J/od8+8rTNFyu6tUCebQZrdj8huGb4s0Cvk?=
 =?us-ascii?Q?KQ9lemDBCHp1+PF5hKMd/SU43rOFN3YYNFlZ28gRz+5G869h2TCbU2xvlTre?=
 =?us-ascii?Q?oRfBYwwrK0w7SjPeflQBiUh6NFvf4E31cBuvDB919oXO0g4t+GncEApS/um1?=
 =?us-ascii?Q?Ee34A1WSSdtbbYWam7dU4BzB1R0nFDFp2L0UpqeSp9Jv65RaHVtvVBw8DROZ?=
 =?us-ascii?Q?UQ/eI4DLOfLqxHHKd4+vVmZnMNpPBD7bNrHjaDU3G2PJGIAepPV1yrWdHfY4?=
 =?us-ascii?Q?5h5DD0EawosNMDYFXY//PtfoIG5BCkonVlgkGD+rOFTujG/cWdFPi1V1d0aA?=
 =?us-ascii?Q?ArjHDkw7G9NVk+ynOirnPR7Jtd9FDVsifRmRr6WPojHH1JNDLfQXuVXVUpnC?=
 =?us-ascii?Q?YaoxCnJsPeEC0+2C8FENLO54EXymE+GiddVzQukXlv9xiYW44T9Y0unG1r82?=
 =?us-ascii?Q?0J67zPFyT+g+G7vH+uPqInutwcFZvmpcVy+3R6H0kh4FLZukP/OXnuE+6+kW?=
 =?us-ascii?Q?oOQRHtdYaBfU2cUsOn+CH6kufpD3Ss9WMtf6EZcWTDqPdgFsbeHsaEoxjZwX?=
 =?us-ascii?Q?ZC+Snyz+bsZZzqXy8umBxH3OQpyth56CCiGMPY5M2WfchZdD68LUZAEX6QLU?=
 =?us-ascii?Q?AClFrpQ/nXx6mBM/QnCXaWtjcwzPpcNnVB0wWgh0vcwdpudJq5UzwadAGYAT?=
 =?us-ascii?Q?hCi246WKCN0wtI0aekzLHMnYkK03UKDEE8?=
X-Microsoft-Antispam-Message-Info: d+7pBimbv+UAv6byzl0H/m9OWxJoM0i2lbS96GjrbCMuaeJ/4+KwYegbm35GQMnQGzaSmG3jai0gjUdFgbFRqU+kkPCULPMe4xvCsXbze7XI8zz0TP8OQzLZfse/6UGhBrxZMKheYLSZvmnSrapVLVXN99fcArsjl8gYhmReQCtMv4dPHyqhE7DwE0bXGoFfSeJwzNou9Ch0cRmSzv75ZY3yf2nRROYYNDsL2hulrtbiSefeySjhlxnwAisO8ROsy1tHHnyaUALlbCe0hPrRQ+Kv1vId9zpfvvZMbZlH2EtVPaPYteQF1EbtLCM54LsZtZC3apgoBxVEnQ03znp3pS9mfCvEztNldxtjdYgPoyM=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB510;6:vAW+I80CQl9y2jcQV0kLx7A5Xdn/X6L+/bqGVMGqE98cs/ORcRCD6rSXG9EqZ05jvlCEa7zLWl5FiKbRhxEStDEezvZtZg/99vY4pQS1dAfjM6o15FyPY8TTS1FPw1aa87BMapZuQl3LtrYMGUWgT0LEgpI8XROLc+A1KQSCY+b5jBurXva4ijBoCc3uw+eFNnsHNVf7//ketMc7xqAeKdrT79dIut7r559OxQMFdsbo6umGG6ugKNOn6KV4hy68J0nbPwKffDvMKI6NGwVUPVnB6UB2dYsUnKkOXMsNjNTVzXdHfOWQGlIW8yubLRPixkg4a6vfjklepprIDbv7Q28tGFzp2pIf1UrcZKEpO7BYJF5RZYm9f26VNSecI6eborQ1IMVJFvcr7pe8Gu9rz8QJkc+KK65GwSqXlLFZ/McRgIZzyLvL8saGpeYd+ToZmAO2wqmFGstbZM5AzKeuxw==;5:UoQesP2L5OstM97/tQ7dioRgQ/DoXaTrokXUmaj+X41bnZbQukMdPm/pLs0zRgkHudtai6n01734MCKvtgOwTt2jL20zOTZr/wBxMoWke9eWjpGUN6W84crBkxJwk8GInPL7aNjB505DcI5lON8N6B1QtVbbOUjBWXgTmZP7XdA=;7:jQj2Db9NsO+pip5hDulrN6Dg0YjAiSCvC4w3VH9gQhYyYrRsLeLh9Yh6+/EU+f8JOC0Y1SGT9HVQf6b/o7PB31QxMfD/DO1P+o/0XPQqe/Y7LSUen+/i63quKkGZKvt4tV4rwpClpc71f/XrPp9VJtoAuq0CtNfS0sDrlIH6NyJ/wpo7XNcHGty2Nx/0a2F4k9BLSnObRqx0ls8hgy6k2gmicpGN22SE8/qb4Yn90ir76QXSd2I7kNs6X4dAZs10
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2018 15:03:21.0515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc7bee1-06ed-4551-08c9-08d6159c37b7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR02MB510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The present code in dwc3_gadget_ep_reclaim_completed_trb() will check
for IOC/LST bit in the event->status and returns if IOC/LST bit is
set. This logic doesn't work if multiple TRBs are queued per
request and the IOC/LST bit is set on the last TRB of that request.
Consider an example where a queued request has multiple queued TRBs
and IOC/LST bit is set only for the last TRB. In this case, the Core
generates XferComplete/XferInProgress events only for the last TRB
(since IOC/LST are set only for the last TRB). As per the logic in
dwc3_gadget_ep_reclaim_completed_trb() event->status is checked for
IOC/LST bit and returns on the first TRB. This makes the remaining
TRBs left unhandled.
To aviod this, changed the code to check for IOC/LST bits in both
event->status & TRB->ctrl. This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c50cad8..6b6bdd2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2299,7 +2299,12 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
+	if ((event->status & DEPEVT_STATUS_IOC) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_IOC))
+		return 1;
+
+	if ((event->status & DEPEVT_STATUS_LST) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
 
 	return 0;
-- 
2.1.1

