Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1838BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD092145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PNIlueBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD092145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeJSQr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:47:58 -0400
Received: from mail-eopbgr680078.outbound.protection.outlook.com ([40.107.68.78]:41712
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726816AbeJSQr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qt6z71QumGnPMpDJh1gwz4xmkfwI7cHsKYlNVmyK3H4=;
 b=PNIlueBA5bIbniSs4uWZFvDAJmhQl8DNLdLKPztmsB9KDik01LYcFSgt9+AX4KJ9y5qu4dr5Nk0GmAp1jhsMo6g1X5RSEcVSYPa0YIw9MIZ9H2FQMxxMqHZUN8qaP0sXA5z/p+wOrVT/Q1iIc3OCM9UUa/rBvhPNq0NLZU2tOY0=
Received: from MWHPR02CA0048.namprd02.prod.outlook.com (2603:10b6:301:60::37)
 by SN6PR02MB4335.namprd02.prod.outlook.com (2603:10b6:805:a4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.31; Fri, 19 Oct
 2018 08:42:44 +0000
Received: from BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by MWHPR02CA0048.outlook.office365.com
 (2603:10b6:301:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.29 via Frontend
 Transport; Fri, 19 Oct 2018 08:42:44 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT006.mail.protection.outlook.com (10.152.76.239) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Fri, 19 Oct 2018 08:42:43 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQMl-0003mo-31; Fri, 19 Oct 2018 01:42:43 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQMf-000245-VX; Fri, 19 Oct 2018 01:42:38 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9J8gRSL002495;
        Fri, 19 Oct 2018 01:42:27 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQMU-00022V-K9; Fri, 19 Oct 2018 01:42:27 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH 1/3] firmware: xilinx: Add reset API's
Date:   Sat, 20 Oct 2018 14:11:05 +0530
Message-ID: <20181020084107.28251-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181020084107.28251-1-nava.manne@xilinx.com>
References: <20181020084107.28251-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(76176011)(316002)(51416003)(426003)(2616005)(336012)(2906002)(11346002)(50226002)(305945005)(446003)(7696005)(476003)(36756003)(186003)(6346003)(1076002)(9786002)(106002)(47776003)(77096007)(106466001)(26005)(81166006)(63266004)(2201001)(39060400002)(50466002)(81156014)(8676002)(36386004)(8936002)(14444005)(16586007)(110136005)(48376002)(486006)(5660300001)(478600001)(126002)(356004)(6666004)(107986001)(921003)(83996005)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4335;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT006;1:msaX6rrKLMgl7l521kewJfZGJ5hBsDFWzjEPI9JiDkrLMLQeyWYwMBWvqhx5a90pB9GD88IxJCtPazbfjOpbPeACvgvmyCk3F+pmfh4Fa7Gnw1HcM7D7yNBZPaVEY0Lf
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdd49c35-b0d3-4e66-46cc-08d6359ed669
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN6PR02MB4335;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;3:5tfnU2qam/xvVZxT5747J6aqVRHtXsi0M2FKP8qAdsOwN8UN7qh6K2w6agcq4DFsdrConz4cSSd3ROOqVf/hF5K6MlHtZADSs+iILLkVCaZrjcU1BW0vAIyBKPjhOKKvMj5k7V+6DoaRqdSz5JWcehx8yh4RmUYEuuXg0xXM/OfwH/aISzUyRejGhu6Vw2lBH17d7aEEvVVOQhN1kUe0fDHN8A4mXv2K+0c8qquheHa6rIO/D6Yxhq7xIWzV97rEztmh2K197Krl0glGt1lRF7YaJfVI4s37FE33CIF+ZytQz+gjsfNH3u4f/F+U0y0n6HVmQ9ba/tqXeldEpSnFL5CguZnapkl3mAQmmd9JqY4=;25:MoHLrqqDBxZmh4mJFcb990Brj392lQeo7fvu/V8MPixsB0DFFu4fWfcZGqd1PWJGARyAAYfnpCUWZtEHUBUgu98X7x54xjBdJY7zZQ+D5l5ttKorx0IBIk+IEtdi6oeR/wV4ndEx/wIAkkkT1fVbgvpEeLD5U66rCwTpGEtgfebPAui+XvGBCXN7/QM90/RY2h1ZARipDY31G1sJ/O8qNQ7lgrd1hTyjvuGvGJXKpombpJck/w7LvKI33y5iLVcm6OP87F5OWmpGjO+cs9SjPAFafoB1SX+PVWSFcpczJJ40ofLs6O6OwoNJaMb2se5QAJDjlT1pRzy6XcGBMTCexA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4335:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;31:I1C057DBveDg8Df3628lIDtGGlWs63sh58XikpRfIe8e/oaFWxs3Jij2x+XeX50RUn8W0KQIjGh0kRvuRIMUuBQiclFkPR8iQIFxY+VaJpioYUr6UXY3mfBjRaUFg717KljuATl9CVDkv9cbl8I3aC8rIXw7ruY+P4+xs/MW1Yw60R5BNyQQA0TOB9wAQ39JzNUeLGm9/vorvcNUGLUVIy59lVYnzAQM8D3oZdiBuhA=;20:9TGcKnO4FFrRzf4yVFukmE9wUuFZ49VHYU1slnyyrGwgZIwZCHv2R9tXdAbIO3cnPB9qSxUTrp5au3jbuhp+yzB2Y2hQ4uig5eXrkhDlD3+ytJw6LEXG6ic/H47LEZj5IltjUd1UnoGaittu3qcj36WpHs6cWJfndoEXrB4qg+VZ1xZgf6fJrMKZ1qhM7vghJCl7XhCCJX0SIimquABIEbQx00YqILW+PIqbwCOHcTqKdN0aig+bLH/xMNxGKfSAeKQfuT8c05Gs0XygeOQsPJR8qzb4Vg6XnNBUixs8vwNelNvbPM5gYcdQeaCnKDF5NUoRjkH96zAvlcbwg40V1jkcb08eHwC5kizdhC0GiC6BLWaPLQM1vRg8jVGu2yeWJNYZ7spdWMqYvDhrnPaapNUc5Qq3sGx/G57UBXlqHELKkHE9fYB6dt+PLQOhBtwxrUd/6qjMyEErnGiIII+wjBNs3lmjv2VpIroTNilEzxVhGqf8h4zoj5aS4B9+1fN5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4335DB3E9B37E2B1961C2F11C2F90@SN6PR02MB4335.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB4335;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4335;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;4:huXkowuS15wjduhu+PF6eVTs+wkmnmADtkk55gzLTcXt9oo3hN8kCtN7or3SitfkgzEgP6DZDZMLQAxcQsuwUznf/tDB0tFy3CWfsXGkvlCJ5qaek7IeerVsRiljioW+/j9s8kLUc1AVVcC/Q8VVTFS8g2x++ENegeKnFjKWDePGJFGwZJKu+yAs8Z+wnZTHHdRB7PC3lA4zUMtd1kwB2AtMdRv5fUZ0OldZKzKefLz6nJU/SYHDmTegxnzyFwZrZgQmoxGlNpRwYIonDnrKbo8pQIbdsj2cJr/BrDPPwXNeQMmrWytIaxnDqDJQbKQY
X-Forefront-PRVS: 0830866D19
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4335;23:khbUxgMxllxJBcxVSHcw2qYZSGsMttGsYlNb5fPa3?=
 =?us-ascii?Q?mYEl70QBVPLEyiZQsCEeVIodCPfML2TeJOTi5vuGLbwthr5F3G0d0R0mPVXi?=
 =?us-ascii?Q?uxZghV6lM1tLudoEQgaEBFKjochr7QUb57MyOh5xiy8Mw1m4WKmLJQgnUcB4?=
 =?us-ascii?Q?+PnKGNn6o9HuOwEC/7lVD9b/NDqJDJRREouAzEChnIDusewS2nDqGtey2fBk?=
 =?us-ascii?Q?t3kavrxSrcXSj8By3PaZnepAvQ9dUioXEJ5+77BC1J8cAsEZzvt4wUZSQNXe?=
 =?us-ascii?Q?umdw8nXjUIjUpeA9gsirAgQ50AAMBtqhEyJCx9vzomY6zYrNpBMA6RTfAIQ3?=
 =?us-ascii?Q?nMPlU6l66XKlNXl1C9/VtpOsuoyS0a7QFZmT6CwwiVPIdoCiWWNQ9bUxZ9fN?=
 =?us-ascii?Q?5l6AGmjI6h43QM7hA+ah2RDBOTOSMDOOmjf4NtgPuAoxZFbGaxcAIi36DeRH?=
 =?us-ascii?Q?SJmiTgi9m8X3LeEZskc0KySbSwpddv/yXRhYdsgXNBkJILg1SyjyzEsWcdLt?=
 =?us-ascii?Q?h2g2jtDAdhdyggRdS7+sDYwB1y6hetFsI1hSu9TZNFrcjZnZu53gegjJetla?=
 =?us-ascii?Q?RWgZDBY3DeNUpgpvJZlMhrUr7m6ayDKCiMyaqHnF92e9w5uXs6YrRe7V1RzK?=
 =?us-ascii?Q?TSj0Swi5sgXtH0Rcwoqi9POndXDp5GMTgWdj2YNd/PpItxUd8lRQQRBEfaNA?=
 =?us-ascii?Q?Rwxdtk5TN+C6nIxt7ncGTrIw86Xc+9IkH45pvumAWXIZUW83Fj/U5zsXbmjg?=
 =?us-ascii?Q?zT6hn27X+V6Q+4RmWacetgUhoEz2I4Qh4BPhNT219GPDWd7bjwBws15e7qHq?=
 =?us-ascii?Q?qdxw6WIBjnffbXxQ+gXdV0G7BqetY8ZfJPoVsVGM/OTi5YZ1ZKc/7HYLuH/C?=
 =?us-ascii?Q?4RPt3Wb89R76IAO95txrpq7aTHE9ibSSKdznc6rkWfB6IoyH04GrFwJ4jVti?=
 =?us-ascii?Q?GP95sEecw+mj3kr6LOo5xMKAUcQ7MzbSbcyOGwW10ZZR9b2rOb9ANwWDKkG4?=
 =?us-ascii?Q?0Xbmse8udZvTnwIYiKi/X06PXgg+i6Mh1NrOWgbUK3mDjQBy+AhmVjjdur55?=
 =?us-ascii?Q?NneF2tRyp6FXLSHArQKIafxopg9oNL4nYroRAM13v4YiKMFDKW2irWrDPyz6?=
 =?us-ascii?Q?UEFUGHv5f7x4LBGybU490RibIAF4HbqnH78Wlxh0FzFatGEQh4yiPDQLcNwT?=
 =?us-ascii?Q?V69869BpET92JD7CIB6OShc9lJunfCR9lRLEyalZ3Fwj7WJ0GAI8HoCyg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 2K2l+uiuKvbpWpLJcmtdFoVTiVebwhn//+00IPGuhsLFgjPluQjlYGBNHmm7qNvdGZabRJpvX14vD7ACEO/sPA1Uw9xGGK2FUID/+bdEXzX7sIlNM8Ip8+0QhyMq9jZM5CVgsqkf3ZXM6Uucfe62+u8ChDCfd16BcGy3H888G58twWgpz5x+qWNZo5AoYWOjadkG2IfLiAFgEOm9+i8wFNGUkm9NHHSyiRwNBxv4AFXz/KqR5SsFUN2Oxyn6/+YEZzU92c/24OVfsfspgCX0n0m9Va/SXZ2PIx2qMa0YfGsGEL81zWbNDMLzkEb3iIQVdBOcUGVdoEhozZVZgKe+RBRKeL4bTBFsuMoslCXRfeg=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;6:3n8SZTHZRMqKlfQuTnKqLruJfDsQlSZaH7AtNHYc5DzgCGraAZYqQn2kSZSgf4PStoiMhyt+l7Rb3OKWMse76G7NSViSUFgAm0OfMvByRtGXFawuMX7FRmMIIfoe35Sc5so1QlFf5JRdee3l2T4lknOlL8U64ydja09I/WqIKyfTfw9+k4jGprAWRb1rX42ukDBxd9mL1Xr7OXVNu1dccA+ua2BLXOUy9ADpxATetet3oSL5qINW4bBztnavsm/0ggZNHmffE3QiK07OOWXJ5PBouRAyDfLRvtGDqbV8pbvTiaTlCwEkDBwzrdNldnhxsUM41hZtNtVnQUnWsJBM6SD89hLmQRkwl4EKC/xp6m/Mzmo12tjDJ/wuGC8T44d64apZqQA1fh+xnpmkDsl4x9v/PX402x9NpkqF+9EbhYeQFvqlLk8qOddVfQTFFa3RlAtEBoyHtdaf5daVAnGUag==;5:zEMgJthfKJRy3rOo+0lXXU4XhKUdXHgbOcU3g+9kvDO/Msc1rDQBdi7g0NpG5VMWTCJzKLAjMfjrXs/2JMwPxKMNqOiYIcVo8VSo1pLw9zyGhIQY8eMPkzSjE8dB3qCHyYEHl7+iDUfxrikRZmyG4I+7CRggWYZOcwMye/Zq1UE=;7:XnM7r8C2fVmFyO8x5S+vRWZTiZr+rhNhDx3MrfaLAe3/n0TfpnV+oybkqSubXQ6tvUH06bWX/OKY560f1CaSdy0vZVNtu7ep9wtaOiYKJHIqyP0sfqVtbr2Q8ohH/gCRU0inhIPzb003sGAvDl6uQw8RHU6boQFLq3IfB06C/bImddjN+/bC+N9nKmwOjyJr/xN/UOLJv2RrMQg/fRUlZZ0f4lwWNsPAycs3vovROM2Tb+PqG8mTmRYFPT/s+gv+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 08:42:43.5332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd49c35-b0d3-4e66-46cc-08d6359ed669
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch Adds reset API's to support release, assert
and status functionalities by using firmware interface.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v1:
		-None.

Changes for RFC-V3:
                -None.

Changes for RFC-V2:
                -New Patch.

 drivers/firmware/xilinx/zynqmp.c     |  40 ++++++++
 include/linux/firmware/xlnx-zynqmp.h | 136 +++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 84b3fd2eca8b..cd13b0686dda 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -428,6 +428,44 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
+ * @reset:		Reset to be configured
+ * @assert_flag:	Flag stating should reset be asserted (1) or
+ *			released (0)
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
+				  const enum zynqmp_pm_reset_action assert_flag)
+{
+	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_reset_get_status - Get status of the reset
+ * @reset:      Reset whose status should be returned
+ * @status:     Returned status
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
+				      u32 *status)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!status)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, reset, 0,
+				  0, 0, ret_payload);
+	*status = ret_payload[1];
+
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -440,6 +478,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.reset_assert = zynqmp_pm_reset_assert,
+	.reset_get_status = zynqmp_pm_reset_get_status,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 015e130431e6..29d83cacac6f 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_RESET_ASSERT = 17,
+	PM_RESET_GET_STATUS,
 	PM_QUERY_DATA = 35,
 	PM_CLOCK_ENABLE,
 	PM_CLOCK_DISABLE,
@@ -73,6 +75,137 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_ATTRIBUTES,
 };
 
+enum zynqmp_pm_reset_action {
+	PM_RESET_ACTION_RELEASE,
+	PM_RESET_ACTION_ASSERT,
+	PM_RESET_ACTION_PULSE,
+};
+
+enum zynqmp_pm_reset {
+	ZYNQMP_PM_RESET_START = 999,
+	ZYNQMP_PM_RESET_PCIE_CFG,
+	ZYNQMP_PM_RESET_PCIE_BRIDGE,
+	ZYNQMP_PM_RESET_PCIE_CTRL,
+	ZYNQMP_PM_RESET_DP,
+	ZYNQMP_PM_RESET_SWDT_CRF,
+	ZYNQMP_PM_RESET_AFI_FM5,
+	ZYNQMP_PM_RESET_AFI_FM4,
+	ZYNQMP_PM_RESET_AFI_FM3,
+	ZYNQMP_PM_RESET_AFI_FM2,
+	ZYNQMP_PM_RESET_AFI_FM1,
+	ZYNQMP_PM_RESET_AFI_FM0,
+	ZYNQMP_PM_RESET_GDMA,
+	ZYNQMP_PM_RESET_GPU_PP1,
+	ZYNQMP_PM_RESET_GPU_PP0,
+	ZYNQMP_PM_RESET_GPU,
+	ZYNQMP_PM_RESET_GT,
+	ZYNQMP_PM_RESET_SATA,
+	ZYNQMP_PM_RESET_ACPU3_PWRON,
+	ZYNQMP_PM_RESET_ACPU2_PWRON,
+	ZYNQMP_PM_RESET_ACPU1_PWRON,
+	ZYNQMP_PM_RESET_ACPU0_PWRON,
+	ZYNQMP_PM_RESET_APU_L2,
+	ZYNQMP_PM_RESET_ACPU3,
+	ZYNQMP_PM_RESET_ACPU2,
+	ZYNQMP_PM_RESET_ACPU1,
+	ZYNQMP_PM_RESET_ACPU0,
+	ZYNQMP_PM_RESET_DDR,
+	ZYNQMP_PM_RESET_APM_FPD,
+	ZYNQMP_PM_RESET_SOFT,
+	ZYNQMP_PM_RESET_GEM0,
+	ZYNQMP_PM_RESET_GEM1,
+	ZYNQMP_PM_RESET_GEM2,
+	ZYNQMP_PM_RESET_GEM3,
+	ZYNQMP_PM_RESET_QSPI,
+	ZYNQMP_PM_RESET_UART0,
+	ZYNQMP_PM_RESET_UART1,
+	ZYNQMP_PM_RESET_SPI0,
+	ZYNQMP_PM_RESET_SPI1,
+	ZYNQMP_PM_RESET_SDIO0,
+	ZYNQMP_PM_RESET_SDIO1,
+	ZYNQMP_PM_RESET_CAN0,
+	ZYNQMP_PM_RESET_CAN1,
+	ZYNQMP_PM_RESET_I2C0,
+	ZYNQMP_PM_RESET_I2C1,
+	ZYNQMP_PM_RESET_TTC0,
+	ZYNQMP_PM_RESET_TTC1,
+	ZYNQMP_PM_RESET_TTC2,
+	ZYNQMP_PM_RESET_TTC3,
+	ZYNQMP_PM_RESET_SWDT_CRL,
+	ZYNQMP_PM_RESET_NAND,
+	ZYNQMP_PM_RESET_ADMA,
+	ZYNQMP_PM_RESET_GPIO,
+	ZYNQMP_PM_RESET_IOU_CC,
+	ZYNQMP_PM_RESET_TIMESTAMP,
+	ZYNQMP_PM_RESET_RPU_R50,
+	ZYNQMP_PM_RESET_RPU_R51,
+	ZYNQMP_PM_RESET_RPU_AMBA,
+	ZYNQMP_PM_RESET_OCM,
+	ZYNQMP_PM_RESET_RPU_PGE,
+	ZYNQMP_PM_RESET_USB0_CORERESET,
+	ZYNQMP_PM_RESET_USB1_CORERESET,
+	ZYNQMP_PM_RESET_USB0_HIBERRESET,
+	ZYNQMP_PM_RESET_USB1_HIBERRESET,
+	ZYNQMP_PM_RESET_USB0_APB,
+	ZYNQMP_PM_RESET_USB1_APB,
+	ZYNQMP_PM_RESET_IPI,
+	ZYNQMP_PM_RESET_APM_LPD,
+	ZYNQMP_PM_RESET_RTC,
+	ZYNQMP_PM_RESET_SYSMON,
+	ZYNQMP_PM_RESET_AFI_FM6,
+	ZYNQMP_PM_RESET_LPD_SWDT,
+	ZYNQMP_PM_RESET_FPD,
+	ZYNQMP_PM_RESET_RPU_DBG1,
+	ZYNQMP_PM_RESET_RPU_DBG0,
+	ZYNQMP_PM_RESET_DBG_LPD,
+	ZYNQMP_PM_RESET_DBG_FPD,
+	ZYNQMP_PM_RESET_APLL,
+	ZYNQMP_PM_RESET_DPLL,
+	ZYNQMP_PM_RESET_VPLL,
+	ZYNQMP_PM_RESET_IOPLL,
+	ZYNQMP_PM_RESET_RPLL,
+	ZYNQMP_PM_RESET_GPO3_PL_0,
+	ZYNQMP_PM_RESET_GPO3_PL_1,
+	ZYNQMP_PM_RESET_GPO3_PL_2,
+	ZYNQMP_PM_RESET_GPO3_PL_3,
+	ZYNQMP_PM_RESET_GPO3_PL_4,
+	ZYNQMP_PM_RESET_GPO3_PL_5,
+	ZYNQMP_PM_RESET_GPO3_PL_6,
+	ZYNQMP_PM_RESET_GPO3_PL_7,
+	ZYNQMP_PM_RESET_GPO3_PL_8,
+	ZYNQMP_PM_RESET_GPO3_PL_9,
+	ZYNQMP_PM_RESET_GPO3_PL_10,
+	ZYNQMP_PM_RESET_GPO3_PL_11,
+	ZYNQMP_PM_RESET_GPO3_PL_12,
+	ZYNQMP_PM_RESET_GPO3_PL_13,
+	ZYNQMP_PM_RESET_GPO3_PL_14,
+	ZYNQMP_PM_RESET_GPO3_PL_15,
+	ZYNQMP_PM_RESET_GPO3_PL_16,
+	ZYNQMP_PM_RESET_GPO3_PL_17,
+	ZYNQMP_PM_RESET_GPO3_PL_18,
+	ZYNQMP_PM_RESET_GPO3_PL_19,
+	ZNQMP_PM_RESET_GPO3_PL_20,
+	ZYNQMP_PM_RESET_GPO3_PL_21,
+	ZYNQMP_PM_RESET_GPO3_PL_22,
+	ZYNQMP_PM_RESET_GPO3_PL_23,
+	ZYNQMP_PM_RESET_GPO3_PL_24,
+	ZYNQMP_PM_RESET_GPO3_PL_25,
+	ZYNQMP_PM_RESET_GPO3_PL_26,
+	ZYNQMP_PM_RESET_GPO3_PL_27,
+	ZYNQMP_PM_RESET_GPO3_PL_28,
+	ZYNQMP_PM_RESET_GPO3_PL_29,
+	ZYNQMP_PM_RESET_GPO3_PL_30,
+	ZYNQMP_PM_RESET_GPO3_PL_31,
+	ZYNQMP_PM_RESET_RPU_LS,
+	ZYNQMP_PM_RESET_PS_ONLY,
+	ZYNQMP_PM_RESET_PL,
+	ZYNQMP_PM_RESET_PS_PL0,
+	ZYNQMP_PM_RESET_PS_PL1,
+	ZYNQMP_PM_RESET_PS_PL2,
+	ZYNQMP_PM_RESET_PS_PL3,
+	ZYNQMP_PM_RESET_END
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -99,6 +232,9 @@ struct zynqmp_eemi_ops {
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+	int (*reset_assert)(const enum zynqmp_pm_reset reset,
+			    const enum zynqmp_pm_reset_action assert_flag);
+	int (*reset_get_status)(const enum zynqmp_pm_reset reset, u32 *status);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.18.0

