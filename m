Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED49C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A786F2086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1hELC5u6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A786F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeIHTtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:49:32 -0400
Received: from mail-eopbgr710067.outbound.protection.outlook.com ([40.107.71.67]:43835
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727616AbeIHTta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdXXzuY3CnCbq2sIB0pAtoYcz6Rj3DG5Cr+brd4PlQ8=;
 b=1hELC5u6Vewi4jWoY1qh1whBhX3iDSpjcKC9Stal3a/IHJgLCQ7E4u62NOcTN0aKxYtH1CS5/YQRVcWbFMDzTzihzpZ+d2nVjf9+PSsaAKPowEFAmPk1DQZXjxCZPjFgZsI3CvgslNuVq2O8j4bqDTEcmBhmpaCESUNcvd0qrDA=
Received: from BL0PR02CA0087.namprd02.prod.outlook.com (2603:10b6:208:51::28)
 by BLUPR02MB503.namprd02.prod.outlook.com (2a01:111:e400:88c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.17; Sat, 8 Sep
 2018 15:03:22 +0000
Received: from CY1NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BL0PR02CA0087.outlook.office365.com
 (2603:10b6:208:51::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.16 via Frontend
 Transport; Sat, 8 Sep 2018 15:03:22 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT045.mail.protection.outlook.com (10.152.75.111) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Sat, 8 Sep 2018 15:03:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54122 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyeld-000210-9F; Sat, 08 Sep 2018 08:03:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelY-0004pQ-0F; Sat, 08 Sep 2018 08:03:16 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w88F388Y027667;
        Sat, 8 Sep 2018 08:03:08 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyelQ-0004oU-9Z; Sat, 08 Sep 2018 08:03:08 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 76F0A604BD; Sat,  8 Sep 2018 20:33:07 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v4 3/8] usb: dwc3: make controller clear transfer resources after complete
Date:   Sat, 8 Sep 2018 20:33:01 +0530
Message-ID: <1536418986-16609-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(47776003)(54906003)(110136005)(48376002)(8936002)(106002)(50466002)(305945005)(5660300001)(90966002)(50226002)(316002)(6666003)(356003)(36756003)(6266002)(11346002)(2616005)(476003)(486006)(478600001)(446003)(126002)(39060400002)(8676002)(4326008)(63266004)(6346003)(51416003)(2906002)(16586007)(81166006)(81156014)(76176011)(106466001)(42186006)(336012)(36386004)(186003)(426003)(103686004)(52956003)(26005)(107886003)(107986001)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB503;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT045;1:qquKnuKbEy6poPg2E+JsBgmIpAkFI15OURBCfkPHb18jjWEcpbkpcRbm0c0TQ12CGuwvZgZazvjjiCSRFLQWZ0tz3Vyryh031uYMgXCeA0NmdmK/oiJm05pCYYdfrKQ4
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1626d3c-7599-4d68-80ab-08d6159c3835
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR02MB503;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB503;3:4rXKuyVuAO44CqRJegwQOXGMv7bkFsl1YPFYlVIySISJY5sizG56w494lEeJyt8Hdqgf5UaA+3Z8PtdUpcy5DrWB2SKvVTmyQJCOCBXhBLkwvsC32qgJ+H15ECbxfER7ZuYEv3CEzLaef6i33qguxBU70d6M7uwFmVdM0474Rs7YsbZ9ft3nNogB9WZLGXYPQnrtgCk9+4Zx3CGpr2FgSJwxJLX41syjUnypbv9LokCqSK3uv2RhRQ673692RwDNP9J+lyHBXeGmdU/QRnP7S5LmEYfQ6x5uNIgKsa6SfsOCQ5pqY3p+mwyEvgapQmQgC1s/vJTuqmmnIa/U4UFBiy5cKhHirglKiLKwXaNDxu4=;25:4t7hfph5oK5WbwPoeYb6HiFOFN+62+buFUCMK7AQEWaHc7y4g7hAPhjxoa4CK1rYyhTBJeD4Q/POhlOWIVzy3TcB/6pMqj6hRR8WC6+5G9oH/V3/gPA15YyrzqK47kUXJ75FgAbfBUBC+b3qjhdb92w+6xdHB0pkqAB3+j9Sy7DoqoN9BhVYoo5Vzc10J3VJC3xTpsSOrPLl8CwZkTfsxF9xXrQPW+YQp1JgItLEWmeTqB5G9lPzIprH5xl6Qk4vQJkk8flaMHcOYe92vTKck3x4hJV198BUmHK9sxY9AY8U8s2lQRi/aMl+mO0re6zTjnKZkCl7ELk150ViHeuleg==
X-MS-TrafficTypeDiagnostic: BLUPR02MB503:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB503;31:Mh4qES1W9SwOcoTXmfgBxvB5asn0dXmzqzJitACU0Vbf//q6NuTFYF371apZqDeq658lsUn8KrY/fZj+n7IQ7BFKU2XclH85WlEDx4Wbwd0KDKZzEzqW0q8SOCQrCZxD/YP1jm9k0WPYmty/BD3qA5J7doTr296hMB/UNi8QPp25ozB40dzAleE46+z9+k7t3iTJC28i+XldTIaroc4rBXR1Ta/WluojylyGK3mmxvA=;20:Jdz7NvC7IYlJ/5W31R7qO7spwK6CTC0NZG9EbAMFCc8t138SU+KA8abwEaUjT4ygyhaoI6pzWf1S2Gpsgk+kjK2gDMBkXoMQNdn+iN+r8TSVxURSDfAdiBluVFl83tUJDDEGd+KoytisrnL5WH+Eba8e1x7HsJwdm1WP5yK17QSOXVRYft0ELVALt+v957IJGemhaCKkuTLw/Uk4QPUCo+dulWKXuhvw3q76tDD+v1ug8MerxL937yXG+c6ekb7Me+vv5nlh+b8i9pOKO0EOi31neFkIN7RBAeEeMmaWr3nL+wO9gEIm1RJnCW6Qq+Fc21tTdEvE3teDsBYJ0KlDMydlPHoBZkpRbTW+SDKrmXkWi744zL7ePz54NISbVcC1uR32NFNKC6wCNqVdgCt5fMGG6Gksrzg+skAz/QWxElnwwJJTDiaom5ETLThg9ttAFJuWfQ3d8BouT8F4MMmasjGAdbg/8gxBLKoL+tnUtnXlGQHsdgxydQjckBbriEiA
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB503EB0BDCD0C16E52CE037EA7070@BLUPR02MB503.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231344)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BLUPR02MB503;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB503;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB503;4:S7PM8hl3uyvmy3GjTR4tzBfCXO4EsaL7w7pCDciCFHR5iaohbd2qg+5RS5NDpyl5XTlkLKOhZcaU0EHQfW8g7jObOHRHFGhteNIQn56niOmz4GhFLYzwAZPPcptyxsxU2a5J2nqz6+nMUMAEoP+ij7z9yOQQAwKnKdAjNdf36SM1HmR1NaQgqW91f15P26GE6NRPAKuwdRuEMJcSFBsUP2ocu5qSoRDHcMRkj/AV6JR05DPkcPTMemjMEJgjB1zNmmZZb+AYo1/ksc85GEkxgwaQ3vKq9q9Go/0llaQvQFy8LApPzodDnlKleQIXINw4
X-Forefront-PRVS: 07891BF289
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB503;23:n3tu5mLur4xk9Nwk6JpvnbeQvmgCeV0gWt6V/hXzBv?=
 =?us-ascii?Q?WEgJTM0x7Qc11bE5PC506hbM/UatAySZd5UXmhppJrsgxGJztaqhlhMVaXJH?=
 =?us-ascii?Q?L6/mCMbFSRU7BmwxthkVN9z/8ANjG7vIxY9TKG2ALZ6UweE3yXlyLnehHnwn?=
 =?us-ascii?Q?2132PM5V80aO7Muu9IB4Cu06EkShT4iS2bIPWnia/ufRmJkj2e6c9/VAv5Bh?=
 =?us-ascii?Q?j7hk3XtCSuerhWlrmMG3Ta9/21byxU8gm4sVg2VqbKXSH/eaGf+0UZKb7ptm?=
 =?us-ascii?Q?DSBTnfFX8kU/o0xXs0GkyV86rf8HK5wzImAXP2dvJAD67mAJ0Z5RSWcK/riW?=
 =?us-ascii?Q?PYMt02i+cwCS9kfqgyCKKDIMUStmZ6YmtP4iOWTnmHgYPeYX+ygDlB41oUHN?=
 =?us-ascii?Q?X2y3nwJ2SdtszFgZbib43HbEFUH7ndYIKJt93iC1yMBkaYhqTZ6eMZ53LAzM?=
 =?us-ascii?Q?S/IWEkcSd4DRaQsXcOjPoKqNG5q5opCFvJnbks3bjjcCPNG4TJ1QJmecOrMC?=
 =?us-ascii?Q?YMYDTTuFRLWMbwgbNfOCaMBBt6NW8qRw1w5krOVNJgbJqa0x9A5n5Lpgm7Xy?=
 =?us-ascii?Q?OUc9V1oFeLH6DcYz+3k81LcYluJiMqxIA2/ieZMQY/n+v5Rby2cOZr8EIILB?=
 =?us-ascii?Q?VC+GZsAzI0IPaP8U/u8GFQROsxixrnIxo27rqfDgCDWafu+ZurTGnJIZ4tdL?=
 =?us-ascii?Q?fqe9G6OffrmIcxdw2uAgYGuwrY/KGbkTqNIEuwDTDi9vZ2/SqIjYP+rNASmB?=
 =?us-ascii?Q?nQcmua6w9BCeiKQSgDq/QgCgFfMjhn47sXtsoH9zG/vkSOpG2nC9rRrInxHU?=
 =?us-ascii?Q?fhHv+YYlN7dbDDfItQrza6h1pn+QdqyitP9zczzg2lz+tLCGp1Cp0WrzcOti?=
 =?us-ascii?Q?j0JSgXxTuQvQrTJ4x1sXKji0HHKK+yAPnWTae3o2x/VcY5r9OykE+6dpauD+?=
 =?us-ascii?Q?1WV35mpBOYc6xO5kcm3hzZjiVEZwvejSa7TkEC56O/ShJWkcQp0+hOgpRyAQ?=
 =?us-ascii?Q?1jdSx7vkHAm+W24KCYs5Ylf69Z/U/jUSI4JCoS0VyeNoE0aqjZ6zeLhx6uk8?=
 =?us-ascii?Q?vrXoLB/+OzsbS43A+NFTFTiXc3E052x10ekdurbu/n4iKX/vq1A2LFWC0fEM?=
 =?us-ascii?Q?IQyuT93f63+aiCp4oFRPLZ1V1tubLSZfmhDdIgMH4eA089JWuaquYF7Lh0Wa?=
 =?us-ascii?Q?VytQd4mzra+8+Q+esV9xReJ7oggF/dBgp/OYYwYIwSvMbI7Ub+A+iFwwSJQD?=
 =?us-ascii?Q?B8pC/lRIIcigW1FxL534jEwUpUbBf3/S5fvSZjO14vQqk8T2FIqm0wHNBgUH?=
 =?us-ascii?Q?X8rGBQY0f82oG0bfilIRmuXevqYvia0jQu7LFtX2uK?=
X-Microsoft-Antispam-Message-Info: NlFChSLnvmjyJz2og1NUKKyBAyf8mKOhtIMktj3E2kMVEUebCpILcjt9JlFxT+FWFonxBnY16eASFSkRFZvSwgTZZEfTYfujHuzdRVgVGRTrPXZY/Xxg/Pj7YU/ZoK2TZrfGXkF7klJkios2MAZnEWXDqnrro/PN0v0RuM6N+c7KCIT/zk85/V7iU08j9Y/F/cJAQ+xzHgTV2r5Wf3Eq0CHTUHAvRf5JGx6MGefJZkgQAvD+GpoOhuaocxAz3svUQDC6s2W/JMCTWzVID4xyOwfBiwmfChmDuz3emw0evnWBLniqhal8Hd70PyFL539pOqFHF4STF1zoyZbcu7Jid9/SM1VHUKttS5576Om6tfo=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB503;6:iZgXhsXIGcQ8f4+KgXVJQEdVbuepGqYhMw4TgK7txdX1/hASEoeNmqTGSkttvpLIoWTaqf3IYmRjN9u8171+x72Th4wpAHSZ+kMcxEIP96dxFKcERTwbtRgHfrrweCJRoBppJOWnlcSo9SM+B41uVvHlhOkHYmR7XqqHRxh9kvRKLrj2mwAA5+dHyCt41/znC9tT2pWbtC6k5J3Nf1JRw37tZOdY2YphDhMWbpcX0xeST9uiKajbZE1//fhgyHgvh99cRh+eb8hwmSWoCs33142ZR+PibmSEMo1GfVoKjRTqoqh7T4IeyD+w9AfSMTmPFdiBlsCb6ifFMmYupbmEtese+Us0FTVvKTyUoHHfKWCW5OTK1reL/ERi0o09c2oLuEmBu4SzmdqiA9auJ0r3kZV6FcBY2ayYJwJ78wAv7b8EIKSYDex15I0lEWYeKjxV5YZ/OBDE84WWLHAq4ewSXw==;5:p4ao0DNz/jyxpsw8ANkPU0d0XfcDK579hTL66ZQPHvX1Kox2V4e7dVrSBC2vzSPy304CTRokW4pjsimvTaabixnNmTmwm6cF3zOMDxADBqc68JXtm6qsKZQAba3Vmismm+c4Z6NOrVHv/2sVQL3D6U3nnqfyJONf6lODOsJkW4Q=;7:1CdOd9jixgrkAzeaLJ5olJyreUHrqi1hj/pCDuItjO5Wu1zsfDImD/0QJX2rlHTJ911j+rl/L0dRV+JDmbJIujnp3XGWyZkA389Yd5PD9ivhiDNL0lZL17cEYfcRhy+h5AaFE72gLq517q4rgBMlvDntM7yme2xWI3aXBWundjK+JxMk7j9J1ci0D7cHOIuRaRpLsrtRV1HN2mXzvPb3+5A3mPLpE3PLHsYkU0z53nviNQiLsxLSe+S1/uGA881s
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2018 15:03:21.7396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1626d3c-7599-4d68-80ab-08d6159c3835
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To start transfer with another stream id, controller needs to free
previously allocated transfer resource. This will be automatically
done by the controller at the time of XferComplete Event. This
patch updates the code to issue XferComplete event once all transfers
are done by setting LST bit in the ctrl field of the last TRB.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v4:
	1. None

 Changes in v3:
	1. Added the changes suggested by "Thinh Nguyen"

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 43d63a8..13ea282 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -571,7 +571,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 
 	if (usb_ss_max_streams(comp_desc) && usb_endpoint_xfer_bulk(desc)) {
 		params.param1 |= DWC3_DEPCFG_STREAM_CAPABLE
-			| DWC3_DEPCFG_STREAM_EVENT_EN;
+			| DWC3_DEPCFG_STREAM_EVENT_EN
+			| DWC3_DEPCFG_XFER_COMPLETE_EN;
 		dep->stream_capable = true;
 	}
 
@@ -995,6 +996,15 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
 
+	/*
+	 * To issue start transfer on another stream, controller need to free
+	 * previously acquired transfer resource. Setting the LST bit in
+	 * last TRB makes the controller clear transfer resource for that
+	 * endpoint, allowing to start another stream on that endpoint.
+	 */
+	else if (dep->stream_capable)
+		trb->ctrl |= DWC3_TRB_CTRL_LST;
+
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
 		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
 
@@ -2268,7 +2278,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_IOC)
+	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
 		return 1;
 
 	return 0;
@@ -2457,6 +2467,11 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	}
 
 	switch (event->endpoint_event) {
+	case DWC3_DEPEVT_XFERCOMPLETE:
+		if (!dep->stream_capable)
+			break;
+		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+		/* Fall Through */
 	case DWC3_DEPEVT_XFERINPROGRESS:
 		dwc3_gadget_endpoint_transfer_in_progress(dep, event);
 		break;
@@ -2472,7 +2487,6 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		}
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
-	case DWC3_DEPEVT_XFERCOMPLETE:
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
 	}
-- 
2.1.1

