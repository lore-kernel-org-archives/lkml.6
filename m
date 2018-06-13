Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CCDCAC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9AA2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="m4YXlSzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9AA2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934322AbeFMGhS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:37:18 -0400
Received: from mail-co1nam03on0083.outbound.protection.outlook.com ([104.47.40.83]:35699
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754476AbeFMGgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJk4IqF1b+WW1YP5PxE8gtGAJEMC3Sh+nrv8slWFhxU=;
 b=m4YXlSzpDelAR4iQ893FpKQRywPaKtBOJbnsnP7C+O7Uxkhkfm+2FQHWB2oc2vcBZTGbAT/v6PIe+soQBBNT5caIcr6zlhBkMtlD+jLio2sRTJIxe1MgH+5vJ4fcpeK9P/5C4YVY3zJjbsSppPMsDV3/YV52InMPqSPYid1nlS0=
Received: from CY4PR02CA0041.namprd02.prod.outlook.com (2603:10b6:903:117::27)
 by SN6PR02MB4960.namprd02.prod.outlook.com (2603:10b6:805:99::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.18; Wed, 13 Jun
 2018 06:36:03 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by CY4PR02CA0041.outlook.office365.com
 (2603:10b6:903:117::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Wed, 13 Jun 2018 06:36:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Wed, 13 Jun 2018 06:36:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fSzNx-0005SG-Pv; Tue, 12 Jun 2018 23:36:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fSzNs-0001Z5-Mz; Tue, 12 Jun 2018 23:35:56 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5D6ZsIw031111;
        Tue, 12 Jun 2018 23:35:54 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fSzNp-0001Yi-Uo; Tue, 12 Jun 2018 23:35:54 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 1D73BB208D4; Wed, 13 Jun 2018 12:05:53 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] net: emaclite: Fix MDIO bus unregister bug
Date:   Wed, 13 Jun 2018 12:05:17 +0530
Message-ID: <1528871719-1681-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39380400002)(39860400002)(2980300002)(438002)(189003)(199004)(186003)(11346002)(8936002)(50226002)(5660300001)(26005)(36756003)(2616005)(106466001)(36386004)(52956003)(90966002)(59450400001)(81156014)(47776003)(81166006)(476003)(76176011)(446003)(2201001)(51416003)(8676002)(103686004)(126002)(305945005)(50466002)(6266002)(486006)(336012)(106002)(63266004)(6666003)(54906003)(110136005)(478600001)(356003)(48376002)(7049001)(4326008)(316002)(42186006)(16586007)(2906002)(426003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4960;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT003;1:YICyQt6fy+Z98OwiHJ93OUAnh3LFKNmXWF5D9Z/M5vdJLOheqNd2k54t9jVGfRvJWpvRSbIpUp2Mtl/xJMCXWsM1ZU0YfOih7eVnD619SWAqRaMYXxtmGzKkLYQjIoHR
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 691621ed-f73d-4346-92c8-08d5d0f7eeec
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN6PR02MB4960;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4960;3:SXiksMb8kpGHRw5bT2tyEzCbrCp8jho3gpZxr19/oxl/1YOagrayPiHENFbfpwrjHho0H05kP0zML31q0hfI86meCTKvpIy4cNBIygeBsPj95JqaPcCG6DiXyukWuX7p3qTtkGKhx4ZPeVSsrMqlQmgyO+sKhRJKZcwSTAElLCUZGwMuy+3VxzRONISL22pWjHwKalHHJZ5Clw5jPVLdxPFOpgQz5UjT1pI3UFB+FQEqMKPyo/CsPjViKmX/XkUgEHYm96SC13ST4pHSy+XPinOs//TVkO1pkPcibkH274bh9cXgYqSOvdiUbgiy+SChUL3YseRik5IGJXKohfJEfAMkS/M3IAyWrZqIIql7nYE=;25:ntQmpKTzlNejapj7AfwZaeJw0fZFs42YCxlv2wKBSRsgDjnh/imnRCmKmc46m6NbXc1g5UG5Uc/96QjI4HhJ+P9pBcxDE8475GWS6h6LLUvSi5U7qzK0LVKvo9fLCmiFBdC6BqR3vpazIEX4MsDXTZFiVCxmQKyUKbWfSDw7QQJprz3oeAN8CJlhKqac7Rd+AhKfOkUUhjohE1GG5rRBdyEj/XNvr6j8SA0cgVeW2HKL0KAURzdYRaKfBGX7SX+vP0Sir2uM6+LV+o903UJ2xaMx94o8LdNV2AZjx/B84Zlueax5+kzraPlZN2tM4QnfDXEsl+D6Np+tP9oIdkl3fA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4960:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4960;31:Fu2EXNMUTtPLnbxI+5fHyCOfPTarngqZ22H/ll9JmnZPBa9UfrO4RI52f/c9tuywwzxsqtaoOd8j2P7GAQHCHiLq+V+RCFMvCBDyIVQ/VqwqzfMo6bJeLdZHRL6AYY1KuNBpovSroAMYDto/TJlnfcMScGtCrViPCpsp2UgXAeIKl4Gqr0JWs9Rbw3qzJzSw03Yo0DoCitexEcHVvrgWYBS+or1H4W3f1vXs2fzjutk=;20:S81VgLu0AsZedG42BgarCW0Ixp6i2mxrCD7xo0SQj4Gi4QjhP6Aim996pYdRB9QHtwZ3R3ErDa5M/XrQqYcYtfKuqHnco4v5rbbjcQcZZ1fMMqStjf2wBNGbsus8+2XeOlLUCJvdWH1xgV5il/VHHXiF2gtpscMs8coBu/WgknxzOGIvYvPuKY4xqIOcU2JpfpLqnG5sGB8r2vAfuS33F1wJ1mzkqiNzVC3BQO0lbHKzkuBI3tQxdSP0bCOIP0yjIPldTQPIGnISY/EM0uWdfPbXUd6fcb2eQCi3hZjORUVAHiqi09jBZk9ptqvsxD0DC+2Mofm62UQlf0YBMGrP+o0jz7ok38U2U/nmQt/n5fAJChpqBy3lep3AD2Bqx6pff8ZzWUfNo+o8+g0FNWcc5WNOcPttsaPBwg8Eh0j2Hq4XD8E+jpz9NlyOCanM7tjzLXpo6DLrSqjzYl0n1e16tO+WW+gj5pyw3+QpbwVdB9AYjT/w5pwIAS3wVGpnV0oB
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4960132E57DD0F15F01465B5C77E0@SN6PR02MB4960.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4960;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4960;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4960;4:YnOIGJL1HAN/l/kYsr2ZMbLYl+5K/tDGI/K8oTFWHRmAvRUMKG+7QTW32esloKaSaYt7c3tLy9aoDvsSVX3ejQlNRM1B57MPKc20mx/4cdavArhQB20TKEuzgXX/O/Bl8ORDt1sTDTbW/H5A0py/8R8DS2856mUx42yH5PzAUwWbgYhocIiif3asC5WDfVbL72cfOubBYadzZ1UlG/OtEz2Bf9F9DYKOSZsEw/eRDofC8xBodTUZOEeIAcHNWNPaCqdya4Hfx1tthSvJNlln1pvoJPVuLrktDmx1oTIGYX/A13gg5VKpyGGapRnCs9D/
X-Forefront-PRVS: 07025866F6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4960;23:WlCN4eOV1628htQFLSn66+c11n9S4kkRMGdkfipPZ?=
 =?us-ascii?Q?OOhh+KWFUZUsk+YYSFY+/5Coa4SqgOkS7sEHoZx5K/6Xiera7PaNRrkGna3k?=
 =?us-ascii?Q?vhqgRDrb1vcc+0Cz1IQSzkCe/8Pp9vNrRkbpKafdVD7b622plKh44CNcdU6C?=
 =?us-ascii?Q?bjRerhvrlY4ads5QbwXogNzVhlw72jVs8hCeakbsFM0KCNeHko3fP7Rd+INc?=
 =?us-ascii?Q?ci7Z2yLPNnssL7d1ioQq+VOp82MqteKPtdX7dgL5CXRgP2lsIiBxGlxrHqZN?=
 =?us-ascii?Q?R3QWWK9ezU9oeakVkO8t3y5yE9GX6cBZDBKH0FT2BkbcgQA0wEHtx3Ka98ve?=
 =?us-ascii?Q?PbBZa1QbqyuwtlzldjMJufxemfJx61f5+7Ro9whTFJFTbGbT3Lclmb0uQKNr?=
 =?us-ascii?Q?0y0UQMqwh/uljAlhc5IvAtfAwROYZhqAUMO9nb4tYm0VhJc4XID8bhaZlNaT?=
 =?us-ascii?Q?ACWQ4Cs221yQ+R+y3PSxBU+GGwBBGOHbBjNqvxIpVjhXVC7Na0cEXpGusmEc?=
 =?us-ascii?Q?KYkCJzXPLM3eIszix+HNruSd5rnYyhP42+/50r0cqznEGP+Nrs2eLjjLlx5+?=
 =?us-ascii?Q?DtIUVC543XdNMM7lJkWfPttHXbDUr7UcbTe+XA56SjGmwP2yzqPOt5U4kyt4?=
 =?us-ascii?Q?nAJxf9Xx2xvxWDdc+lBtAvNlr0kW+KDaUCnhpJX75hRsJ21d0fLEv4IMvKmR?=
 =?us-ascii?Q?5gyPl+rNO+bkNmtUTi2uNuyQ640CtAeWROhXw3JLft6yq+2HjAF9tp0r/g34?=
 =?us-ascii?Q?EmG6ZPoecFB8064uI3NJUnR9rrQ+lP55G3qOd2H/z9OSjJRmG19kUWatNdkl?=
 =?us-ascii?Q?5DyFugYHsG8zGlkvJxqFf6uYdCJfqQStv+vhGz3b7H7U24zXGjiWG8lvZQoq?=
 =?us-ascii?Q?nblvlrqbV6WZGI6kZbbdT60IXSUO0v4PokwExoi0sVlKiblSmPG+7S4HKY3/?=
 =?us-ascii?Q?96SE9jpfdYvjfd3nP3+QkPnPVZ2hmmTTWvHJh8354sv/v9zuBlI44btFE3f6?=
 =?us-ascii?Q?dbSzpwa+xvdTgt8hBz+ypSuqOr87vTH1tiUsAOTVdFYP4lE+mkFJBc3m/UhE?=
 =?us-ascii?Q?zAkLEc/kmZMXllaO0+sk2UrlS2QrXa6OihGsWlxqhJ8O2O7rJEYhEkC+KT8j?=
 =?us-ascii?Q?+CS6cLD/kS43sQQ6KAB7j8sg1mEmIcASkmxmOMF9eBP8V2oQkMFaukMiD/Y9?=
 =?us-ascii?Q?atptOXiVAH8wlxlR5rc/nKnEEG7cBpUFF9i?=
X-Microsoft-Antispam-Message-Info: gcb1JIEBbJ+2YWjDTdAIluTd7Tnx+yt+wiaitIR2Tt/4KXoB78d08iIkWvszVJ8u6K/Kwx5u2bsJYnsUVIJn6hI9Egv42rD/InToz78HzluyX94udyrO3U//o9CJlI5QMVFM5ZnZi0tsx3DXuw0qymX8VS8Vjr9mE0yxbTUpLRYhL8fwt+ObSG1iUeSr5STc
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4960;6:oRexqBdZfJO8hSOBfJ7ZtlCtZ5sbozqtsr3QNAHzbMpTx061tS9PRsz01NGSujQ6jL9XraVpW9Q85p0YBKu9Po+ua+Ek7255sAC7p/1DwmP/KrZYxS3xuHtdXNyy2Eo4EzY6PjmB28e4hZ+zyEfVARmNfjKBIYlhhxGWGZoP2nT5gw1svzNPptDwxaETRw2fheeHuDCFctFjaQJcc/ywoMKXFy1Mrhr50QOfADZ5WVaN+htJ97wrKD7u/XBO0kVrq8Z1Ft40oSzGvUM26cVLTyJ8h/JmiudpS0SR2Mx05FC7digLQMsNfRgDd12owVWUPsONCHr9OIrLgpOmVrhfOezIX8DqaECtD+A//x+VB2mcddcu3GBsdwDoKBPSFxSb1M09v2qHHT44t8DWiSOPPYO0oYnce46Syqd4EbyALiLWT+UNs2mtP/uJrSuXogVHjSObDV1pstNA3zBqObgdiw==;5:GKLJY2z2Tiqekax+4hQjjpoCnw/LjdxnJm+GgjTO1ivqswizva2HizIkKgvqXKOyyzhC9PxsCRa0Tz27l3PS7tyna7BsZky0PZ7W6QeEM3q7XW5JHBLgD4NTd53OIkXxDWfwEesoH6tlqWq1g8dUzgIbLsrmSFodYFqYmayoL9c=;24:a5a8H9e2wEDoZkndm0qt7YkJxcoAyhgdGkUJJcAoEo4yTrD/I0ix1+RktMSLHpLKGsBBFQ+i5M6V4dDOZyOeV21e8aUFkAW2K9tfgZs9Xxg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4960;7:QEHmkJYyaD4tNFq4f8pNVpL5TL3PZ+IApGNtqrfC+IeNcYqdaHn5s7wGVJrNIUCHpS4QFrDjCdM8dYWd0R59Nrn273fkiTCAqg2x9hpJ1T6Dv+M2kmN49OOjWeUOIWGH5ImhBRMJ/khKRoujP4U9UD9XoM96vRSGUM+P2Fudzuq3lS0gLVu12cnGMBjlfYAaKMx6bjGYpuUb/f2JSNffnwRQ4AtjeXRM19hVD4vih33Jy9nWCd+sUYguJdyw2RxQ
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 06:36:02.4899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 691621ed-f73d-4346-92c8-08d5d0f7eeec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4960
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 'has_mdio' flag is not used,sequence insmod->rmmod-> insmod
leads to failure as MDIO unregister doesn't happen in .remove().
Fix it by checking MII bus pointer instead.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 37989ce..06eb6c8 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1191,7 +1191,7 @@ static int xemaclite_of_remove(struct platform_device *of_dev)
 	struct net_local *lp = netdev_priv(ndev);
 
 	/* Un-register the mii_bus, if configured */
-	if (lp->has_mdio) {
+	if (lp->mii_bus) {
 		mdiobus_unregister(lp->mii_bus);
 		mdiobus_free(lp->mii_bus);
 		lp->mii_bus = NULL;
-- 
1.7.1

