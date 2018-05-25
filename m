Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965913AbeEYKiu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:38:50 -0400
Received: from mail-eopbgr10099.outbound.protection.outlook.com ([40.107.1.99]:9952
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965532AbeEYKip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:38:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        linux-imx@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>
Subject: [PATCH V3 1/4] clk: bulk: add of_clk_bulk_get()
Date: Fri, 25 May 2018 18:37:20 +0800
Message-Id: <1527244643-10736-2-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
References: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0069.apcprd03.prod.outlook.com
 (2603:1096:203:52::33) To VI1PR04MB4224.eurprd04.prod.outlook.com
 (2603:10a6:803:3e::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4224;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;3:d+7WJguJEfk1joBVR3aYM733HU6TD9NahSwRMCEz/PLE3ZBStEOJcB9OrAtu9V2LcCz4h45qqzi2AalMmJzSehQITcjDWdX9KGaxshTDTn/5Ne+T7BDjgBstyWsVGbg+AWx9wbdJr8+xWwSZtij6K289GnOX24aPZiz/k+ArDb8hnUM00cFNhQAxHNffXzFuE1+HXON+6Su8pvfXPYKIZznouG0kOcMzSggCSWHupiVEh5RBaVq3C5N8Nf7ozSSW;25:qH1xNLdvWxTHILN3ZdDyyUAaoKdsivu/nwwq/uvGdw8IdhXiqIpvooVwdUOuy5WXLp/1F7BJ2BtWNW/OqM/MNXAqa38vY2fWE/0iQHO7pSOy29Jv0oXUCIQAqE3jW6aJhXSvS921tRJlKP8gS20JgtCXc3uxC1Qa8VXGKGmg+voe0kvcgG4hi+lANUYzsXFSNhj2ZOElBasThz/HhjZEvrpaeywUSIL+OwrsI9ejp8W5f2X57oae654d5cCOSe1HZ+m6ttXSV5R2l/NcLbOWm8BjU2cWdCvDsaYDwr12grZqbXrYJKt8OfA3ywZA2nouyJyms4wzHNiKyC8ULFB8vA==;31:6BwJiESptl05P5aicjwTWXXIdiRWC68EN+QylAgK7NmmgKTCmHRGCUh7L/UXXRltchiNm7lNqfpMOHV9lnjNuXBPRI/b5++k0ConuX9aTMhWxEFUBhfiC4QoaCpMUi28+2Y2XqcCs+pofgSjd1CmNOtTeoK9dJcjTughJxYVdV2+GoppbaN2jJ/Gjri+jNhzrtwpJvDXRf5LFT81ImQ61EukHAZErUJTP79G2tHTg10=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4224:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;20:opEmB/FZ4neGicX+8o0h7i0uIsSM3KL1iebxCKXTCmW0iGO25ND3AvfvBI4Jc9Nx8wzp+tf0ocpaOeh7vvcuozaPYDxrcvy6jaaWsUQTPbKZMA7c9YNaZ+uSlRCPJ2lk04ptQuUQmZovElN0ofYoP/UPllL7lNN9XDVxy2vsmg3geoAbbgT4xF+SVQRvhImrFERY9Ebmq38jPURgs5oHc72c3aMZEEbg9ZSXOjTtlo7CkpdoLNweeUw++dvv4rdOpkLvQ083Y718clnsIDKFNa5SCzThFEVqZxZc2ruSG8raNdBoooIXjoq/0eATgSoUQgXJkWhm1b3N8+WsmxYkcDw9kssPtNcZRBCcRbT3LcrZg33Wr6my75tzzkW+2rbaVDxwykHQ6vRCf2KutdEzupBc/abdrl5ECZpCt+0uPZZPvlIwGCRO4aTpSSfg3hHfzpt164SA51VFuezbtdApEvlNGwHTT1m1SvoQGY1y4bVs9HzSKJKgpJbmY65CM71G;4:MxZ2cN1Hj6y7K7nmUAR1u5H6e6htyOmHpyOk0kaxX1CFBnB2xj6ss4fQR5REv9jA+I8WQSzN/eW8A1aJFTne8ygoPKrMRXNGlaA5KhjIl8LT9kMLoOEQmi8Y6y7NSlw1hfac8WmpPM4P1vW2gOHKWRjXHujXIKC/m6ytJTJvHtNM8KoOEFBLMNFMpt41AdQC85MYlzt3HJefLxOsPQ8zJ0xf/GIpuqhAd1zQ5U+lLmwFmzqCdh7rsigc3YLTnxIHFWvG4vj6zICXSBfRZ0EdvKaiAGYZ/kYbZrOUYgnObJmTBcNhH02Qn2/UFdB0fgMn
X-Microsoft-Antispam-PRVS: <VI1PR04MB4224ED28DFCD6BA01D44C90380690@VI1PR04MB4224.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4224;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4224;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(199002)(189002)(20776003)(69226001)(63696002)(47776003)(74876001)(62966002)(74706001)(36756003)(77096001)(77156001)(76786001)(76796001)(81542001)(42186004)(93136001)(92566001)(46102001)(64706001)(81342001)(92726001)(48376002)(77982001)(59766001)(56816005)(33646001)(80022001)(66066001)(76482001)(90146001)(89996001)(65816001)(87936001)(56776001)(88136002)(54316002)(74366001)(44376005)(87286001)(87266001)(50226001)(4396001)(47976001)(50986001)(95666003)(49866001)(47736001)(51856001)(50466002)(85306002)(79102001)(85852003)(83072002)(21056001)(97336001)(94946001)(93516002)(95416001)(94316002)(86362001)(97186001)(80976001)(93916002)(81686001)(83322001)(19580405001)(81816001)(31966008)(74662001)(19580395003)(53806001)(74502001)(47446002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB4224;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4224;23:6gaeaXK7Enj+utZL+yygqv3WLoChUxxieXXsSn9CD?=
 =?us-ascii?Q?n/gkq2FDzbuPEBrWYT+Dn+56RLwBTa6eC/8pyD1Drs7vi0C9TpWR++QWSDxp?=
 =?us-ascii?Q?RVraotA4QsjOvCc2j5IQD6Y9RI7jN6PMXvGQ80Q8+zRGwxcxaPbbEYkIBBdj?=
 =?us-ascii?Q?xxWOcY9b4Mx6/Wi/GB9xT1JXki3E5gzleP/YGobL3srjh8dZeERiKaeg7Bx0?=
 =?us-ascii?Q?0At8DWxMPjtBHIytAF+KHARLEJWCtUMO2fTmdSFV6CEAZrTQploOfuoqFN65?=
 =?us-ascii?Q?oHml/GigoE0MVgGXUk9Y31sX7mrKn6p4HJc+bdC47P8fRB3mipXN6ET2mqzj?=
 =?us-ascii?Q?5pNjcSpdGiy1KgcG7byc9nPy7HxwPeSbxjowrJNAwYGkeCmTtqis6qAWopH2?=
 =?us-ascii?Q?khjRcGNGbFfgPcvcX2dVglzlK3eX5m7ZuSEGDw9jm6fmtYlnRlqvnzXe5LxR?=
 =?us-ascii?Q?RP1WTNBgUiF37+ebUoQrS4ZuFnH9joBa8/mTfgoCuRYml+jU8Ng6pRgs8e8L?=
 =?us-ascii?Q?PU/EX6vaj6J/8volLKZugOSse/iMaZhH1PCGj8PdaRcHG9NCozp7FSKl2sUX?=
 =?us-ascii?Q?Zm4/5AvMwlazGS9B2lwR8ZRgZ90E3EPEMRWA8NP8C7jirfBlGSFGJRV3f6KP?=
 =?us-ascii?Q?sdkwJupK5kAu+4SGGTfGx0Abe6l9s2VFYwKxYOxQtpqjepnQku02ku7Uuk1Z?=
 =?us-ascii?Q?+m1MVvrianCvDmatT3TCkfj6gJ29C7QOgp2cgaHO8rNPGJzjS2dGQAbKA6qL?=
 =?us-ascii?Q?nN5hO5KFkfBcAHwTlY1ZuMeIsesWl50cKoYTyObTk+m3FiQMNCnaYkZTEozx?=
 =?us-ascii?Q?U6BwyvAxDVA+iIZS7EQv0vou6V0D5//ZltqIYl+rM1kL+E2c+8Sks/G7adzE?=
 =?us-ascii?Q?20VuryjMNeTZCHTARUeidExcXg4MZVf6vMFMDIT4gJR4SXrECiKeG587YeKz?=
 =?us-ascii?Q?77+BHjlo/aYej1gPDSCG5CVMnB/qKy0F3kn1biA5Kw68W5oD1tjq/isjqcc1?=
 =?us-ascii?Q?wJPllvlHXce0syy2miI1jFNL0OPD+WDe5/ePtA6SFl9QKSfnwwxkPb/pZwYL?=
 =?us-ascii?Q?ICYWNb1D3H7zwEOTMUuO7kJyf35NjODVKQuyNnOZXfU1a0NTfug94pcztIbv?=
 =?us-ascii?Q?E/89yfxoP5Gg1zBc+nofYxPHlQlAmgXKWC73IY2CD3ts/q9GEmgbq4hvnIWv?=
 =?us-ascii?Q?jRt84S3dtpIgWPGmip1xfcKQGUxt8BGosv24J0LYK/fCVRBaIThbPhgWkdeA?=
 =?us-ascii?Q?YfgOldOrKRL3xRaKBD++H+RKvKFTstYXbo35zKcGrn6Wu2sbQSiWRsHhYFHM?=
 =?us-ascii?Q?igq+xcZgVtN8gpqel4cG3GRBZIzWdZB5NLfft4rfU+SfvCBDxdvJxLOZs5CR?=
 =?us-ascii?Q?a5/QHMrcvhiWmXarUxW9gL6v/H7ck2YGcqNtPBzkVOADdWu2+QtWvfLwVVge?=
 =?us-ascii?Q?CmeKc7rIC+eZa025Vd9PeZBfevct/OnQyqhK3s+ByEYzzPlGBOd/qNB1cSWz?=
 =?us-ascii?Q?9VzsIrUmYFiSV0rFkuoNjU9ss1mqW0vORH3eEpf6Gm+MFEIBdyLCDW+9D0nI?=
 =?us-ascii?Q?jh8sVFZGxag79b777CmxKH3Ul8hu2wsMPisnLYj29wGj5706+0l/0m9Cn9uG?=
 =?us-ascii?Q?jg2H/q5rbSurh0hAMYL9JUUYRFkRctE31CcPCYycZj6UBhJZfjfLEb3CTzQQ?=
 =?us-ascii?Q?BVLykPN7nZKpXcLSF5uXEmf8duChsO0aOnNwYa3E1TS24OcSAMBZd099oG3y?=
 =?us-ascii?Q?eJwnM08h4SjggVhM4mBqMXPTF+/uwnIqfqm4+Me4unqJxsiSIs=3D?=
X-Microsoft-Antispam-Message-Info: Oylfwi0JaESMuZoypxa0KBuDx9rKruAKdCzoaliCBB9y3XUGsgNxRb/tPPppfOwNJHOSH/28vK4JVu7GIyb7RkqsDcIBjy87qSQnN6Qal0WwPcfBjfLRanbTvwfyh1rtCLhVpxvfl7YQ21zjKbUlnYURdfVvOEz+VKxmDAJG1IKVAwWSfRzt2TOWn4wlG2GI
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;6:5oHENKrvN6NfmL+/vzAqFoPW3xVlHDcFqqEPEsBBmGZsiD+fbgKWpPfmSHKk3RBazyl71sV3Wb1t8wXxiXT/xEpSLl0+7rvC7YWp/fOnQMOEcaCs2DSj9oAAfLq6s8tJKUC+7HBtkPR4Rs17qlmj0FD7t0S0O7ysyN/Q3ZmjjfID/IXMF1SWtczSlFhSjcSov0bSq12lupFJvpaDdssorncWpn9+XVVQPRaKdK8xmhVV5OTixaJWmgkR2iMnxYZyx5MSXVF8wOwQTcHqveTl0THWRmfnYX+1nxo0Dkw9JjSwWjyw1gKOrIaFY5jbfPWrphf2ZJOp42OeiaigYfLVBX0iPxKaXw1sytOsxRK9aC3Yi/EybVUCjapnuC+LYQ3rUnHVDNfLm2gDCRAtF6M3U4UvST6qkC1Rur/mQtAYVJX1Gjx4rxMoLFBNFvi+CgTnpXQfByu08bDjmt+m4dJHwA==;5:+vmuYn41qcn0b6/zNCXVlG9X21MGjM+I8gZShq2j+WVThdXpgY4AriRZHOnTSBNKcvz0fFkxSkgLrJTU7iB75tw9hjVvfchHTL8OW6B1O8Fejy/BGUyXjlhM51qnCZJKM4RXxRlJs7iPbKeOC/4TkFiGevGQThW3kCqJjMOSinQ=;24:syeYZOJxNT60AvvjDzW3GK7dac6gNV+MRMgmT6RE2Kda2JYmccu1SitdSDQAdpQbcsK8/sx1BwVoejymF3TwcuDN14MmGXhEjdjI120ThKU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;7:G/F17pYqVI2Lij31zFRV7ynufUjMvY+FfAoflkcw0w6Hdb9Ib+dokdk847rBYYXwPwNldTKqx9VAu7n9GFAYwQsGTd5VmpPwK8hAG01F7N1n+kr+OGqMKBWYCBxZkYOIp5HCP7JN2+SELXublzL3bF3jLcDFOzxDgrv8ozERF6noCJ0nKbzvMJ1MnHFRtpx0d2twVE87mITxMafgWHrxb8n6KoSsZHMcoeSmngzDsl2RGc5HRCZCYOH+AJCfmEkM
X-MS-Office365-Filtering-Correlation-Id: 0e44c906-8c06-445e-ca45-08d5c22bafcd
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 10:38:39.9799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e44c906-8c06-445e-ca45-08d5c22bafcd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4224
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'clock-names' property is optional in DT, so of_clk_bulk_get() is
introduced here to handle this for DT users without 'clock-names'
specified. Later clk_bulk_get_all() will be implemented on top of
it and this API will be kept private until someone proves they need
it because they don't have a struct device pointer.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Russell King <linux@arm.linux.org.uk>
Reported-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2->v3:
 * remove #if define condition
 * remove EXPORT_SYMBOL
---
 drivers/clk/clk-bulk.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 6904ed6..4460ac5 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -19,6 +19,35 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/of.h>
+
+static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
+					struct clk_bulk_data *clks)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < num_clks; i++)
+		clks[i].clk = NULL;
+
+	for (i = 0; i < num_clks; i++) {
+		clks[i].clk = of_clk_get(np, i);
+		if (IS_ERR(clks[i].clk)) {
+			ret = PTR_ERR(clks[i].clk);
+			pr_err("%pOF: Failed to get clk index: %d ret: %d\n",
+			       np, i, ret);
+			clks[i].clk = NULL;
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	clk_bulk_put(i, clks);
+
+	return ret;
+}
 
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
-- 
2.7.4
