Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EA4C04ABB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E196D218F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="S0UJ4jQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E196D218F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeHQP2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:28:43 -0400
Received: from mail-eopbgr730078.outbound.protection.outlook.com ([40.107.73.78]:37312
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727253AbeHQP23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW/TM3HfZwR3V0buY5fWklYWPNve4Tw/9sI8Yj4KLeU=;
 b=S0UJ4jQDrOb7LR8n/TkdgZodP8yS6uFmxP4eK4+tEF3jdCqP9gZHswds0v26Gff1PS6A9QI6yescyNDmNhuK/ZugP2PckWjREF3jpN2npJvrKVXPzYGUGht+8Y+aCve2samcR2eTRNlRTXCPxKGtN3+TtKWLMAeYOjgqxfNaoT8=
Received: from SN6PR02CA0010.namprd02.prod.outlook.com (2603:10b6:805:a2::23)
 by DM5PR0201MB3510.namprd02.prod.outlook.com (2603:10b6:4:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Fri, 17 Aug
 2018 12:25:06 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by SN6PR02CA0010.outlook.office365.com
 (2603:10b6:805:a2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Fri, 17 Aug 2018 12:25:06 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Fri, 17 Aug 2018 12:25:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42346 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoP-0008VM-B9; Fri, 17 Aug 2018 05:25:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoK-0000U3-AM; Fri, 17 Aug 2018 05:25:00 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7HCOvvH024711;
        Fri, 17 Aug 2018 05:24:57 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fqdoG-0000TN-W0; Fri, 17 Aug 2018 05:24:57 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 0CE8B604FF; Fri, 17 Aug 2018 17:54:55 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2 0/8] usb: dwc3: Fix broken BULK stream support to dwc3 gadget driver
Date:   Fri, 17 Aug 2018 17:54:47 +0530
Message-ID: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(376002)(136003)(2980300002)(438002)(189003)(199004)(36386004)(4326008)(52956003)(48376002)(36756003)(103686004)(186003)(26005)(6666003)(14444005)(6346003)(5660300001)(336012)(8936002)(50226002)(47776003)(107886003)(6266002)(486006)(476003)(126002)(426003)(2616005)(39060400002)(50466002)(106466001)(356003)(478600001)(90966002)(8676002)(81166006)(81156014)(305945005)(63266004)(2906002)(51416003)(110136005)(106002)(54906003)(42186006)(316002)(16586007)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3510;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT055;1:OQyc7TRTW+7HRr/3zZC0NEiz+ho9K8dBlDiuquB0kDqHWm1LT11oYJqpSFNt/Q+cp5xMy3E7Ic2uGTBMxOzaGWp+ytoRUylk4csv/b8vayu4O7hS/TsziYxn8BdoGu7j
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59997fcb-7614-4bc2-def3-08d6043c7707
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;3:we55lKFWM97jBNZuUfGm5NZ4lhyzMbXvguCEwUXESu0f0J0ZH24yD5lGZlcZHbTEbG2kirZMBisa2o4lrDJtAAXyWySdOlY3INE6now3Mk2a7jbARbi/HgoI5BZx92NXu/9ZqLDQ/tmDNp6gzZnf2mDbCGgZkJywPQhDwIFiYbWOcZb6Q1BFEjZgjIUa1rKS/PB9FE0yLGFM6ZN3qjKAisb0RiRYA95W7f54Y5wtdU1hK8723/J1A9kmDCOayB0xuMXdE4knU2Il4UnBza3OXvI+R0oiOGaLm6QVkWFs4FR/MA8O8LOqd+wBQw0bLcRi5UmfSM1kesila6BWhNBN2c97YCBoKQ7Yr1TAArahfF0=;25:t1OJ4r8Nm4WoZgdulYSOs4ZadkszgD7vtH2it7R/6GQVucwtTrfpVrXDasKMYXGy7giALfpM1RyOHeqRBofPgm6bR95dsjswTZsBqyvwFHjMft1HGYPFanKCMRKLsEWVyOuPhjpEHujrJufCHkPWvqJJ2KUra8rcDq4n+5VvwceVVZdnIvEbpWDslrpooEvRb7E1cn17ftRyTSDVhLa+fGQh6mjEGnJYOqdQg40m2pdd9uD00dIUaB/IE3zV7zxRWykxAC4y6rT6zO0DtoV7NAxnCxci6raUU+Q+q64l7Hmlh5+1NgvFmuiaJJefznYB/kcATqnkimZ9moazzbykkw==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3510:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;31:mDMZr8tJ4BGqbFBHQl/A1L5PwrOuQoxpCHo9wehpipjbfrBEqv+Pi/tUtTDPXnU63qJS9SyX5aUxNkfnv3Ip/ghzPrSNZEpu96gDJ4Xp1p+me7FJ0lqIH7PAO9dG+xbdlkFOlu80Tqe4dIo/KkLvNLs4iT/pdhu8VwYb6NpGGaDwKiZHsPqtWyeh21vSuMKQmNjAFhFpqTmfoX4BFn8ffxIW+LhwidR/9fj6s61O0tg=;20:nxwAl1GcdmRYKXM3+jG8pcMcok0zGmS1g3x0DCYTyj+Zx97IBbvBjy4OBJOWPORn7U3gk6e7b2Gkss/rw2eKjEZ5jO122/+x1jjzV2QbajBvdA9ApgD7UuL5xEaf1JEa5xDw/xBZC43HJHT6cT6XpvFMNUBq5tdCcClGYgKoQ9CXbsKgXj1eEnO0VorxhA1GZ+zKA7jDhAv0TEQoDwmiSqazCsTJczmtfFH64wfCHmatO/Iolf9FLv89yDk2GHMCQ02pYMtJSJP5pD5Q9o4VejhAqxa4ELUrZ2kFdt+G6VwW+p6rGxWFl2Ji7cnJ+679bDg1wmtzpoMVn22ZnoRi5we0TSyYkICQtQSPSTqNkhmTQnOZWtJdK4qFj9h+E6ELS7KmSsLPFtmlFvqOM1JZs3lp6aXGXFPbkIWPItN5SBUuO9w5QnueC+iAO++88YoA2NWqzfhgNckA2WWSfaSS0nJT0+8ofDHmw+kuhrzGhg/hTqURRgw6lGqwMCxFTNS5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB351018D07275746D5AF5DAEDA73D0@DM5PR0201MB3510.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM5PR0201MB3510;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;4:p43NKHRD8/839mQQnKXCRz4qRlaRDp5RWP1pdPQ5/agi/10exJHXeQLsRHuPRkRDNTcZRrTrHwFzOp3Eoybo9YuzKtmwwxK/+XV794U0NghfZ9t0KZyQ/oIkiIn/STpYDj/GVodcDTmU4+hMRxcNAjxo3DERydMb2DcJ6S9DBg7mgSRly/RI5I0wt9+E9Ivel8OPoCX5siC4Dn55bP+F9a8VvkyGDkVRWCbBs9u1Ma/n+7MzYx3jNzp+W3j4k5xASF2VEKtNjhRNvIKK3ABVAw==
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3510;23:T3dDJv8S/jmuroDVxUsBum8vZVHPu5iNgLVBNCe?=
 =?us-ascii?Q?mXyx5GaegcMNLmaapvx91I6a7qzNDD9cyP2sxQOEc5j0mFhxRSz3bpXIGvxQ?=
 =?us-ascii?Q?vmQe7ZuJCredTNaxJeXLxPiiyQ4pOwfSo4NUFLDvYRUXXYtUGc3uSNBe+Yo0?=
 =?us-ascii?Q?xnEShMKCXvPEl6WtUSCsy51mQ7UlPXcHAUxWPfHUoiPoiwxAl7g0e+p4QAWP?=
 =?us-ascii?Q?hP4f6nOhIMhoEdWJ6NHrn7MhhT4Dr+uG/+OtIZWI0w+hGXo/2AX0rnbr7jBI?=
 =?us-ascii?Q?3M8xqtx8bc+QqFMSdOGsUQ55VsqvL0BwMK/ePCewmzQxPNBG34rofpQlD2Dm?=
 =?us-ascii?Q?tjDwVGqCRIaApUqaHBIjJmj3xjnQbKJRWAQr1XOEHAGYVLDqsCm8It5/hPZH?=
 =?us-ascii?Q?h+kda/6OxdaRSjZkYkVEAq2iELL4xs1qVKm1d96vcb7IkJEIyfy91wuPNQk4?=
 =?us-ascii?Q?GLoneqbOqBN4WPh+P4NpXCvcV7m/ziQdwD9N+iopMU9+fYTPhkuBgKbU+YWc?=
 =?us-ascii?Q?LJGz13vfMGy0JOGZMRTCyLFBAryaiM9WxTMyLKmKR7i6cd7NiWcApuDS7YTt?=
 =?us-ascii?Q?3sfVvc2z+Cc/SE32D4j8/DmyArBGk4tKhwWcGwZmVXI2ZvvoST7zAIjloLa5?=
 =?us-ascii?Q?Uk4s235wwDQQy/rYulR/jXTvicaR80XKWnXq5xs478qd/3pXe3yJnc/02+q4?=
 =?us-ascii?Q?AdbU3m2pEhe5uyrRVME5IA6kg6ujikWo66duQb2HkNi5o0zX9g/e+5HH7sOw?=
 =?us-ascii?Q?2UzbpiM1jAK6eoclhh5/tPXAt1UkQ83nKUKXj2HfVZp2gKtXCSV1SlxLFMYP?=
 =?us-ascii?Q?QuXcPucwWrg8K5T1wYDJBENzkSLPjqbdIHw6mu1CtRTPNPDstZLTnTmSQYll?=
 =?us-ascii?Q?tBaOic5dHmeSCrU9JU4uCBQAai7LPDf/tGX9ktKTkae956f1P1X7VEnuLJah?=
 =?us-ascii?Q?2rndNsSXyZ2RFGmEFaa7Z12uflvAv9qBR1Q9DL5SwkApAKrkPv+6tK9jitWw?=
 =?us-ascii?Q?szsptlGhUzQpZmhhGmNTNQY9MHoYvlm70SlHv/RIsD/ImcH0fVjMX0hi+u4T?=
 =?us-ascii?Q?v4mUHFASSa7Z/q+KHCJAb8AX2rtO6F9hBSuIXJ53Kp8Gbc8Sn2gEZVbGuU4p?=
 =?us-ascii?Q?sF/mBTfaEZAJ2BrPkVOwSeJPH80Q8NdX/d6fl8jcWquIu1pw7M6HvbTEXGXD?=
 =?us-ascii?Q?dz3JmjmCO7MnHXAU=3D?=
X-Microsoft-Antispam-Message-Info: kpFADjtvBeGyZwCUXisw5+qZFjtm4qzwgxgiKT1DRpY8rHJqJLH+gtWWgTLt701miVZUg6/n4Er0S2QNwShRpcJyUCi13GwrfiJGM+Z26XbD9wzjRh86HBlHkTpctPpapjMl9CY17g+juihRuC+kkaSromaup3mBZrMLK1OZ0oZmut6B5Nflsr0oGaYvSY3+0u1M6HExyrdW6Bc4pMyKQkp5RyH2nwWfA66Mo8jYZhW5Yc/TaeyGaEX7iD2ZGcfPD+ROmZN6KkHVGitvqqQ0kzLGq33fqWO/Nx66qbeS/mWrJSPtVgUF61+Dq8qrx0nvry7i6FgrbRIKPgUkJXF9u2B606DzQqzUvd7mjkvb1JQ=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;6:Pjxq3qsQmqDK69MKbbErRfo2rXsr7J004mKFlYw5xleo0yKf/lTXseaxV22sLABfpXOfukas64Oz0w1FZCs0fCtlmXYlhXHdFV92TJe+YKM6HKxovnlkN6RxNCAO+8TltsuS1k+ALtqydAnpqUShTUl97nbnjxst0LIFLu8A7of+WYCjv1+btCysZrJ9WqtK13c0iTsht7D57MIylJX6Lh7/9GTAn9axcg/Xdo7ewXEOVqCvYcuaMguZxTyEJuP/ZDokupkpZkGvUMvaw53exWG4KLpS0oeXtEhgnz+be+xvmLp+P5ofyJ7DIRwHupkaSIF+Lk2QDmjTCshjk6kVUq1YPAszDp4M+1G2ybQmqYqNL+Bf/Ph4X3ByAwu5OObYg6X01Uq9MKyyMESpsou3LbMQU2gSTq7xJW1uHK0/h338AJl+iht7pIzCH8+0qaW39eFCJ+EiugxOptOBMFuqbg==;5:lnuaysQ44SyBXi+8gQs0Q6EWqu3cTMJJzQTdLxE+QBGAhM1Qc8OV/qON1Yyaw6M7cPk7ssrSDA1JNBRPm0hTqIX/z+SrPSdmffsevred4z0pNUuzOpdsEbX3NfRzCKgCobc3Po54oFqesfeiY86psuf1AjT8UeofkQ1cc4MCe+s=;7:7JIe1ikSrIgw1xF4KCJX1y7QTWgjs5e9sBl/yDWMBTfpkSw6C3oEZaQDCCCg9JFUfRy+8i0h8fYN98yzJq5oZPST0dQd1NSsN0oBCXTwdtqG0X0SFyZIrn93SCblr0OkKs8slbdrZ2TEPG3S4HlLu9XoeekPtTQc3DCbge48WrIyak3Cln+zUwH4BqZWCN3YpN2Lmfbo2F6qyM9ASr58mDcKwqV9i1yI0LylOVE5ygFpCIkfcSs3bvHXV+dKtzKJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 12:25:05.9338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59997fcb-7614-4bc2-def3-08d6043c7707
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patch series fixes the broken BULK streaming support in
dwc3 gadget driver.

Changes in v2:
	1. Added "usb: dwc3:" in subject heading

Anurag Kumar Vulisha (8):
  usb: dwc3: Correct the logic for checking TRB full in
    __dwc3_prepare_one_trb()
  usb: dwc3: update stream id in depcmd
  usb: dwc3: make controller clear transfer resources after complete
  usb: dwc3: implement stream transfer timeout
  usb: dwc3: don't issue no-op trb for stream capable endpoints
  usb: dwc3: check for requests in started list for stream capable
    endpoints
  usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl
    fields
  usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints

 drivers/usb/dwc3/core.h   |  7 +++++
 drivers/usb/dwc3/gadget.c | 78 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 78 insertions(+), 7 deletions(-)

-- 
2.1.1

