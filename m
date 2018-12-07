Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29BAC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A6220672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hLOpTpQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A6220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeLGSdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:33:54 -0500
Received: from mail-eopbgr690063.outbound.protection.outlook.com ([40.107.69.63]:32896
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbeLGSdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDnizgfYqp6wLw9XVqxV157d8z6a+5tLUC+pjIclqwg=;
 b=hLOpTpQAoT0bFYqKy7y2KlO9Nnb4LGNE4Qf1/2coh0oZcuPXUDKtGHGpF9WMHilfx3nHxXToInZM7fGJ6iQqDBCwE5EuN1yskd5OiI6GuFtVa3vBAizOUf/9fbdlZ9/BA29Dpm0Ur12kXUO9PtBg8ncGf3klNyMPgLzb8i5WTXo=
Received: from MWHPR02CA0018.namprd02.prod.outlook.com (2603:10b6:300:4b::28)
 by DM6PR02MB4332.namprd02.prod.outlook.com (2603:10b6:5:2a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17; Fri, 7 Dec
 2018 18:33:47 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by MWHPR02CA0018.outlook.office365.com
 (2603:10b6:300:4b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.19 via Frontend
 Transport; Fri, 7 Dec 2018 18:33:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.17
 via Frontend Transport; Fri, 7 Dec 2018 18:33:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gVKwX-0005bx-Rg; Fri, 07 Dec 2018 10:33:41 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gVKwS-0001uC-OS; Fri, 07 Dec 2018 10:33:36 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gVKwM-0001ry-6V; Fri, 07 Dec 2018 10:33:30 -0800
From:   Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] ASoC: xlnx: Add i2s driver
Date:   Sat, 8 Dec 2018 00:02:37 +0530
Message-ID: <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(199004)(189003)(11346002)(14444005)(2201001)(50226002)(76176011)(36386004)(356004)(7696005)(51416003)(81166006)(486006)(426003)(126002)(110136005)(336012)(47776003)(8676002)(81156014)(2616005)(476003)(8936002)(9786002)(77096007)(26005)(186003)(446003)(106002)(478600001)(16586007)(63266004)(48376002)(316002)(50466002)(36756003)(305945005)(5660300001)(106466001)(2906002)(7416002)(39060400002)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4332;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT046;1:R16U+d+s8LKxcU/MDcqehZzFTcNdsRgYNYmOBnNpDsqzQRZj2fMxuchx3sU1uVTlxkATIOC42xhhckcrPMdeyk2vNdAHN5HfZ5kXuLrZFMEuq5i23hhiZi6po1WbwJDN
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4141a880-bde8-4ba4-064b-08d65c7285f2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR02MB4332;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;3:H6SomrF+Z1aWiHrZlxISoJpWkvsNrvprlV9nQZR8O+JywXiNYG5BU/S/b3j7Ail2HvrYX/9DUf4+2L9uvo7CREVbxpQShf2FOYEurV5P49Q/RcBuRr8JZp8I4U4x8D3onHT2bXfX353ltI5SkSnfacsDM7riGO+1GizUrg202rlow9+PzRbzd7xk8J+XPgXIlnoUOndtsbR59wL/TErkxN0sloptDiTFgafu1drT3l2L0yrl7Yuz6feBnSWnBml2P4CJoueCMLBoxW328FzPleEank3tR0QI+VEN72hZtm4FusgBOHR0b0XA+elUzvkWQ9nDYTxdQxVA9/pnDUqnElOL4KLkKlTZOa2VfFDbzC4=;25:SRzHh2u+P+cjh0WhropLsUhHwtV+VPqTfKrKAz0znu/wHd+I7SGYGA2sWs1STI/yI+7ovXwdV7wrsP9t5FMKNfSiLA7aZAPfxU776J9gkmBEeIq1rTCKe4vCjg+80vxHQNuJ8N1nF7JAdKU1mWKExOnxJ/0NGQAUw5T1s5fzd2SWMoZyRE7bVKEiy5LfPpMWsI1lteNgIHO189Xo1+9nveySGlwsPUCusFH7zTuQX6FjvqcwiQyU9FjCPZe/o6pb7ir0mp6Nwya31oC1UUzUyolE637o2NZkxVQGgNwL3p7VYctAVV0e4qddk6QNKh0XKrZ8B+JVHi31+37oVqeRAQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4332:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;31:RCsH12z4TAgPdOV08ZB+z0KAjgWx0131JZq07oRw0S+MDxSXjBSrWBhhEqovG7owE9N+aq6bwXVHPZkpu//hHX1VKcnc7aTORtDqWeohpnDfiN8BbnyQROW/Z/1SxupfkeD7zTM7Bs7bsE3ZPhakzFWy93UdD230o5Kr/krNLv+NgqPt4fvkpm5D9ZtH1QLUlxtJ42jIcB0Y2H1lw4eHnxJFbkl2HgPlJNO7MD4OJQE=;20:6GjFRo0WSS89uyMpUwBk/uFCGDJX0hvwbxJTyOYwmt9BnryOsnOKQR8BysqNH48Jr6ESrQjEmsb+36VC67Fhs8/ZGKo4nJhG1k45wFIYwpu1NOmq8xo/rfpY7CJ5FccckNqhhEZ/prC1lQ2jFd/tro4H9V5vFxkgOTHD2FRz2NpyyQBg6zTVz7sfwt94hGaHhUDmuRIEqf+lX8cdYh3DSOy4i2VMQ/HP56EzJQjmx3miYBuSZ0P8oDIi1Px9fcsFrW9R4B+xgYgQc6muggoEZ5RsZ/iJJ1ouXpv8yvI8X84w2xJtRmht5tU+k/u+Rn8K0/RIUmfUHGVv12QXLn/wGLw6yasvUDAVwj5p6SrgKW2EYrr0ets0wZXJ5rMQ866dveWhY+gZ7uAVsx+spbi4uROSaWeF0MiCIXEVMFadqLPeg3EhtLK9AwGvMvduM7FQGa/1xyQyW8a8uPlRqHKzTVcP5ijPheJ2xBVP9yDE5/AOUTXfFe62v32WAXO9VzY+
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4332FF2CD822E79E40D076E2BAAA0@DM6PR02MB4332.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(93006095)(93004095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4332;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4332;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;4:1ifSCkZmDoppGwMnzSdFdWbW/CJsYcvJQv3kTgWvHuzP2D8ApYiLeHkbLWMmGfn9sS6xiQzaInt8A12HQdbS7A/X92aZVUlcLWbiqZ9eFPzq0MTxhzkwVKb6yhSh+fJkYfF4p1gP0vAWaIkO54MeY0SEJlnvFrok/vYgMzCIANmKI1VOAB14zCZhpEc1mBWYXtpLOCRmnG40Hr+/1kywrIJLZL6moZRFiyXXsjuBSmbF3VzKj0gTWYv0wmcb45l4IcSj5S9IroOG/sF0JMsukw==
X-Forefront-PRVS: 0879599414
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4332;23:N3PfwCOssoiMUVYXG9j8JsZz3sK2Pnp9ZzkxBocSW?=
 =?us-ascii?Q?NJXw90vyaA9gZ8psMHLf2z24SnHOLqFGsoRyJzdZtmEeKFHOFGBDWqkLsb25?=
 =?us-ascii?Q?RKB6OdVXJfRgG48FTiZcPEtxmqVOpZ52n+QWtCzvJIksE5oAlwDBK3x8WK5s?=
 =?us-ascii?Q?aJ2SwHbLODDkg8C/USLmDaDsGXsqgThNkLBHGTkPjBntXHMh7H7PGnbfWu6H?=
 =?us-ascii?Q?/RxmsoKNO18TfDJz0yW3YbceEQbv8fI1AGjnj7WM3FFZqCEY8/ljnKHtn7Yw?=
 =?us-ascii?Q?VUIpJzNn5QaZtlz0cMsasoyQwYttUY3Hy+jI97nTnL4sIJAPjlgX9LgxdrFu?=
 =?us-ascii?Q?5mI6i9kCRasdL/DQShVooxXFiy498JCFSN2P41zCGCJfHeTWFPUIwrmbNoSh?=
 =?us-ascii?Q?EjJOX6d4pdq2jeCCEUukBUSDoFnWWGHT8s2s7WyVImNMEK7vRbGvRVGOekin?=
 =?us-ascii?Q?oW7yLfGO+04q0AwbdlgJTsK1U6kc95MOeTJS1nLusrgfZ8qw2cWPr0od0CsH?=
 =?us-ascii?Q?HBIqr41UqxGfGHrdtI/t1kaHOuxz64cS4dhyAUrpQ+JyMx7MvKresjDxXcSs?=
 =?us-ascii?Q?S236VhLJBOReXnA7pko7+508Es3u5C07RDTfEjMC66Vg2wLHq8ByymV4eIO4?=
 =?us-ascii?Q?b7lgFIm3OE8ysTdkaMDcPb48zvgxKGZQJzl8NbidY8bBwsdTbVeFQPRoZk5O?=
 =?us-ascii?Q?jyr9BlNzlVySj1ucGye5vc1+IE8QiOyHRRbZLvz7dVenbLPuvQ/0YfWjSE3O?=
 =?us-ascii?Q?NKvaayrDm59CwRfm2d9LVHRMjAcC/0GulBBdXxi3d2cqMErCVyqjVtN7GmF+?=
 =?us-ascii?Q?9RCmLoc8EjRvxu8HvG/hZEishZ3AmtfVxRZrN14NWI8bS1skxkMEQUqrD+t6?=
 =?us-ascii?Q?f/DwMZwjP8w7+GiB2823Z0uAN0JQKsZTotin7HLPD3c5tEtM893FnUnNrPEL?=
 =?us-ascii?Q?WPVSDZ+OOzZh8Jj+LwQro+XAJs3A+CGpeVYwxVuO7E7EeVmPMcz0SzlsgdaW?=
 =?us-ascii?Q?kRfotwMcZScQ0VjoijJKhHkj81EMYff6LjfCiXiHMjnzOLhwkU4fLvZ5KZU+?=
 =?us-ascii?Q?L782UycXfrQb4llISeI0Ew4lqAri1ZnzFOQQPUx1ujdbbEXJvlgDpdKrtzyQ?=
 =?us-ascii?Q?QNC1u6DDkU=3D?=
X-Microsoft-Antispam-Message-Info: 3I21es9rCZySX0Un1YMvx/Rkk5To6SAq4Scg1zcIaCoeG+eC78A7sqbhLMtgoj5IOhIdh8s05+9/AQMEvY9lQhh7RkBrBJUN1TTBXY0WdTCl9HyAePbNrYKInFZgiosdPj6RUuJYwFalWQMn01oV+BckEE+s3VLgPoZ7v8xtllEgx/fXcQtFuCMkjfviPKzGEBIu62gNH2wLVlPk2nmle03zpS7mu4xn9F2VUd21J5T+slykuSlBK5kKgrQ/7hpR8SlHLnTNJC8K67DwlpFpMZOOkJtdNvgl2FxKXJ88bdZ+q/u6WXbwuT4XzEaqMBFQSDcP7RWVKOocCifi73v10yF07+Lpe/ak9ZRU+j0gOpk=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;6:dNTAKZbh2+V9yuj+noF3xtma+h3rxkjU9nOy5hVkP40V3xTjmy3vUuDHfx++m9TcsrVc9dFgBckro5IJMkbQIHPlbNLhhpHpWxsXytqn7CMq2aoZP6rvnbh7LomOnIqswVru1kZjuZCAEVFEBqIBqtSDPiNRtpsHluJnlSB6cqSK6MzKBWayqelrUXhQ97l7XTAqTZzie8SbclTLzDI1UWbYsjGCYzWeUSMYZwheuYRDw59wDEqxNQo6foTnm+yAA/F6vXHySfWoqfDgMV7VPm5fVAlHODiTD7jamhIDDmnrqgh+wJtuDSF3ja3XJaKSovaSfb7DoTkUE/1ALSEAw9i98vTkpxReZy7PZsg4+euj2YHdum7LuyyImQtuZF+36kPMSnacfjtuRSbT5DLOLXsuUcVuHoM5B/Ykm5P8blWSsDvk7dq01qMlwFs6HIfR0fdnPFEd/U3X6jyBcNMEIQ==;5:A86nuMR1H3yumG+0Qh4zAnYwpaD2Z8VVaf+Uw5bvZpNqa5FulV4sgTgDKLjvI/3yDDOCc4SlnQ2stizCp5H0l89WujpsedAgO5k97hcYo/nWoCTBzBXUmq6mTurJiE1yoIhc6dtVnwW9aHKX2UC8zti7ZCn0smFg4LL1IUQ0yJE=;7:IBQO5oMczZ200wcRnCBdkWTGAIYXl4fE9Vz4CVYpj05wBlTX+yS/Hwmihw9hnJKMb1BYRTZv8HowPxkjjwH7iMSpDgQQU2VfIrA2CojbqPERqxZNa5Nvpxp4ET2fAYHsjy3yUN4UBZC3LCdWjpciyw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2018 18:33:42.5729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4141a880-bde8-4ba4-064b-08d65c7285f2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2S IP instance can work in transmitter/playback or receiver/capture mode
exclusively. The patch registers corresponding instance as ASoC component
with audio framework.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 sound/soc/xilinx/xlnx_i2s.c | 185 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 sound/soc/xilinx/xlnx_i2s.c

diff --git a/sound/soc/xilinx/xlnx_i2s.c b/sound/soc/xilinx/xlnx_i2s.c
new file mode 100644
index 0000000..d4ae9ef
--- /dev/null
+++ b/sound/soc/xilinx/xlnx_i2s.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx ASoC I2S audio support
+ *
+ * Copyright (C) 2018 Xilinx, Inc.
+ *
+ * Author: Praveen Vuppala <praveenv@xilinx.com>
+ * Author: Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#define DRV_NAME "xlnx_i2s"
+
+#define I2S_CORE_CTRL_OFFSET		0x08
+#define I2S_I2STIM_OFFSET		0x20
+#define I2S_CH0_OFFSET			0x30
+#define I2S_I2STIM_VALID_MASK		GENMASK(7, 0)
+
+static int xlnx_i2s_set_sclkout_div(struct snd_soc_dai *cpu_dai,
+				    int div_id, int div)
+{
+	void __iomem *base = snd_soc_dai_get_drvdata(cpu_dai);
+
+	if (!div || (div & ~I2S_I2STIM_VALID_MASK))
+		return -EINVAL;
+
+	writel(div, base + I2S_I2STIM_OFFSET);
+
+	return 0;
+}
+
+static int xlnx_i2s_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params,
+			      struct snd_soc_dai *i2s_dai)
+{
+	u32 reg_off, chan_id;
+	void __iomem *base = snd_soc_dai_get_drvdata(i2s_dai);
+
+	chan_id = params_channels(params) / 2;
+
+	while (chan_id > 0) {
+		reg_off = I2S_CH0_OFFSET + ((chan_id - 1) * 4);
+		writel(chan_id, base + reg_off);
+		chan_id--;
+	}
+
+	return 0;
+}
+
+static int xlnx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			    struct snd_soc_dai *i2s_dai)
+{
+	void __iomem *base = snd_soc_dai_get_drvdata(i2s_dai);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		writel(1, base + I2S_CORE_CTRL_OFFSET);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		writel(0, base + I2S_CORE_CTRL_OFFSET);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops xlnx_i2s_dai_ops = {
+	.trigger = xlnx_i2s_trigger,
+	.set_clkdiv = xlnx_i2s_set_sclkout_div,
+	.hw_params = xlnx_i2s_hw_params
+};
+
+static const struct snd_soc_component_driver xlnx_i2s_component = {
+	.name = DRV_NAME,
+};
+
+static const struct of_device_id xlnx_i2s_of_match[] = {
+	{ .compatible = "xlnx,i2s-transmitter-1.0", },
+	{ .compatible = "xlnx,i2s-receiver-1.0", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xlnx_i2s_of_match);
+
+static int xlnx_i2s_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	void __iomem *base;
+	struct snd_soc_dai_driver *dai_drv;
+	int ret;
+	u32 ch, format, data_width;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+
+	dai_drv = devm_kzalloc(&pdev->dev, sizeof(*dai_drv), GFP_KERNEL);
+	if (!dai_drv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ret = of_property_read_u32(node, "xlnx,num-channels", &ch);
+	if (ret < 0) {
+		dev_err(dev, "cannot get supported channels\n");
+		return ret;
+	}
+	ch = ch * 2;
+
+	ret = of_property_read_u32(node, "xlnx,dwidth", &data_width);
+	if (ret < 0) {
+		dev_err(dev, "cannot get data width\n");
+		return ret;
+	}
+	switch (data_width) {
+	case 16:
+		format = SNDRV_PCM_FMTBIT_S16_LE;
+		break;
+	case 24:
+		format = SNDRV_PCM_FMTBIT_S24_LE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (of_device_is_compatible(node, "xlnx,i2s-transmitter-1.0")) {
+		dai_drv->name = "xlnx_i2s_playback";
+		dai_drv->playback.stream_name = "Playback";
+		dai_drv->playback.formats = format;
+		dai_drv->playback.channels_min = ch;
+		dai_drv->playback.channels_max = ch;
+		dai_drv->playback.rates	= SNDRV_PCM_RATE_8000_192000;
+		dai_drv->ops = &xlnx_i2s_dai_ops;
+	} else if (of_device_is_compatible(node, "xlnx,i2s-receiver-1.0")) {
+		dai_drv->name = "xlnx_i2s_capture";
+		dai_drv->capture.stream_name = "Capture";
+		dai_drv->capture.formats = format;
+		dai_drv->capture.channels_min = ch;
+		dai_drv->capture.channels_max = ch;
+		dai_drv->capture.rates = SNDRV_PCM_RATE_8000_192000;
+		dai_drv->ops = &xlnx_i2s_dai_ops;
+	} else {
+		return -ENODEV;
+	}
+
+	dev_set_drvdata(&pdev->dev, base);
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &xlnx_i2s_component,
+					      dai_drv, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "i2s component registration failed\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "%s DAI registered\n", dai_drv->name);
+
+	return ret;
+}
+
+static struct platform_driver xlnx_i2s_aud_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = xlnx_i2s_of_match,
+	},
+	.probe = xlnx_i2s_probe,
+};
+
+module_platform_driver(xlnx_i2s_aud_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Praveen Vuppala  <praveenv@xilinx.com>");
+MODULE_AUTHOR("Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>");
-- 
2.7.4

