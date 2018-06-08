Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id n/QeB6cSGltwZAAAmS7hNA
	; Fri, 08 Jun 2018 05:46:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DE00E608BF; Fri,  8 Jun 2018 05:46:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bvm+tQAG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 71ADF608FD;
	Fri,  8 Jun 2018 05:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71ADF608FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbeFHFqG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:46:06 -0400
Received: from mail-db5eur01on0082.outbound.protection.outlook.com ([104.47.2.82]:27840
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751116AbeFHFp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t47oYiaUvB4i7kDw7KrXGOkigzx+5tPkgvKMIMHUtq4=;
 b=bvm+tQAGmX+ApuMxn6oPrDv/7b/NLgFowW4nvss4U3NuuUQTtFwLSaEuaWvB1cwGy3zX3QNDtTRsTZIQVTYSDpENAarj7PZ8L9kiqsLATpBvnFdvvZz+9bqf/7Yg1qP8905nHRIcalv6l8AL5Sk/U5eofwx7DKFJk0aydosapRg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3232.eurprd04.prod.outlook.com (2603:10a6:802:6::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.14; Fri, 8 Jun 2018 05:45:53 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: vkoul@kernel.org, s.hauer@pengutronix.de, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v2 4/5] dmaengine: imx-sdma: remove the maximum limation for bd numbers
Date: Fri,  8 Jun 2018 21:44:49 +0800
Message-Id: <1528465490-19684-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528465490-19684-1-git-send-email-yibin.gong@nxp.com>
References: <1528465490-19684-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:202:2::24) To VI1PR04MB3232.eurprd04.prod.outlook.com
 (2603:10a6:802:6::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3232;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;3:ScQ3hb5UdD9oQyRq63N6to6wBzLuuGfLX+fnlSY5IUvVaMA+LdzD7QLAGN9vKYy0TOuQiaQLxeCjblfc7jRvGUn8851BhoRF9mg5WP2Fxhw80woRktJJwtX/JAVMjtLRUbKYzhO5wTpkn0qONEipObCA4/KawDmA3+XoNnCkFf1I33pOPNAupIvoCg9E3SnUe9B3aySVInM2Gv30YsAxiKrAsvoCYywF/FnyBgCICmua/j5wH0yO7g2OFR7LE//L;25:QaNIdjVuE43zU9eA2Q1a6AHdaszQ9GU3/Q/BmS1kndy7okpjDxA3NdBd0LT5i14Ukt22Tn2BWp37T+jMpBC1Nt8oPmLEcTjsXZvi/s8wHwLMufemgUEhzfbiWD20Vh/NYLHZ+jMBlIgQ6XCj7i4eGGD1Jojr4jaEZYpMVmrEyUtyiFgiaTpIgR09pXvoLyyG6BySUmXNcOqDVZQtcEZtsgUw09uuHndqQiJoz9tmYMJEW0Mki2+uvUSBvTk5+RkdfyA8yKf55MbXrZEpSPf3MyU+BvniNEAUzOa8icWVWnNJEfAUX7529sOvc5x5b44gmoK8Mjbnf5wPghrppeNDCA==;31:5PHTxlvYijKsbya8TRyYhCZW6mn36WOn0+GmfaDlLD21MoUGSYNtqfjTfGXoa4LgRE3P7f7BPjjSki3AldfKA67r2MISXGhyTn3rLlf5ZZ6e10K70Fnjw7IiXBwr98OFSHaqdDzC6jtxp1TeZueKPdt+xlmVMjgJe0aBe/6igvRTjuTPyQpQJQDqScK4arpZtppf7rTi0YZUB+D9Iizv0KTdq5LT4wfOU4yYvBd3Ipo=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3232:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;20:A9As87/pGXsZBaB23tx8aS0ufjNzNPsOTGkryyNlk6JLYHlkDGbLplzhlLgfUj1jHZIunhrToTVMZtRmEoQSyzMfzk9wzl5NiAlKayrO8K0KrveZbR7T871UEnEQ8ZN/bDpejz9+rJYbR1BfjkCUpXMjeNxsptQ4Ct/ePVAAD5FCOFV95g2UP5eEa+qGnnXQefiYtwolYFVCXoz6t/oZByXoL23Qqvq8zarTkhsFE+fYxnHrHaapCfPurNXAN6OyeXx+00SSLToMVQvkNXarrqM/1Jl6uNMs33/JTlt9qMjtXrM1Ysu5VeRO87XOX0o/MACb7n3hPhM5dzPSb7n04lIfuSIbrJ73Zz7ViiqkPdfJOLXQ/bDBy9uHlUmIW6Y6b7aglzpaF9CCq6+HvZOwCJ/sdDGYdniHU1owCmtpNWvcgQL9A/oUqt0OeWfMtOsIM/ALb5Z9Xxl2PRornabDPNx+tIA3Q8x9BBOBuxa+r7UikMz/lf2OuUJNpiIsfXQ4;4:mIbih5HtIWL3QVwxJOH0gPHN6T1KHMMB8P29QPQiHN+1/c8m0I/jS/9LlvjJQ7NkYkNQGzDnPUwndKIqd37uwvO6hoiz4ijPUiZqhUm+9GtMFyRSwCvUz83IAXfXs0A7z2kr4aJpVJWza6s6QCsIwIwInlbjaNj+PDmBB+FoOxBYL0krSGIFDBBP1fKZLH3tZ1dohhbCsDqHOYSSNFRDUCftOLZOTfW89ENLal9QUQXpWi/OhR0v8YmOKLSCr0wOF3EkTHlE+o54XWQsUyCzVqsply8l5oSuL2ZSKMLfbqYg1FraO+OQWeNPO3rG6EPc
X-Microsoft-Antispam-PRVS: <VI1PR04MB3232D13D9AB56E99784BBCB1897B0@VI1PR04MB3232.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3232;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3232;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39380400002)(39860400002)(346002)(199004)(189003)(11346002)(6512007)(386003)(186003)(66066001)(48376002)(2906002)(3846002)(6116002)(68736007)(16586007)(52116002)(36756003)(97736004)(53936002)(76176011)(86362001)(25786009)(51416003)(26005)(316002)(4326008)(81156014)(2616005)(956004)(446003)(476003)(50226002)(486006)(81166006)(6506007)(106356001)(7736002)(8936002)(8676002)(5660300001)(478600001)(16526019)(6486002)(47776003)(105586002)(50466002)(305945005)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3232;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3232;23:ib/tDRJtH/HUPb7KBKE2bXuXZr+HvblU51Cqot755?=
 =?us-ascii?Q?h/6pd+RyHJXAH9FB+auIIVQzYAJgWWjEejaw4GUvWghWlgnko6C0n6YkqdmK?=
 =?us-ascii?Q?AIf2mBKIBtVH0JVHfS6tbTrSbv7lgyzIpCH4UfQoO36aRYGjJI9/+bgCpZcx?=
 =?us-ascii?Q?V3FmfiLahrIZ9xJScrzSlg9Tibeu2bwVZ0OTL/UqGJ+WBIxUsVlWT/xxmGS1?=
 =?us-ascii?Q?NFE8bnUa59qo2jstHWKq6XNO51YyglL1IitzJsBcFLMZNL/CWh5y3uh6YET3?=
 =?us-ascii?Q?/OZgyFRUf9uNJ5+2sVktGL9LT3AhZdW8vX3sz8mYtV0GPYfJ/qx1e6TCewJX?=
 =?us-ascii?Q?vKAb3gNOOODJFUStdaS8MqK/hFKHkqinOI8XY8ismm0ml2HAQ45+/TX36bEn?=
 =?us-ascii?Q?ZaVkkG27jcB+UeI64ODOgChrpbc5qO55defCSvLj3ajIQfpZC4D/p4uz+y3T?=
 =?us-ascii?Q?pDMCSN36plxUbTLjzTfNJ6GKafWz9eYZFP3vqJ5fT4pg8DwhUgmKcdy22MM8?=
 =?us-ascii?Q?Q4MpeE3C12EjwHmOktAKPWeMV1rWFIym3zggS4d3tznis3iJaQgZQ5fCZzaI?=
 =?us-ascii?Q?beWvTUKvdqh3hmKfiPuhyMwAvcnFhB2C5mKibDJMgXH311G9WhTpM/RH7qoj?=
 =?us-ascii?Q?niZvJwCprpnKDOf6xi/1/4j4d71iNcczmsVQJ75OstlJy05bc1AVfDT2hwCE?=
 =?us-ascii?Q?/9oMWh4pY0axr89lKHt7k8bauJguNUHUF9x7FLLlg2As1rY9h2KnJTbQJbkc?=
 =?us-ascii?Q?2yWI5hNaq+G9Z4KCiQiNho7M3fFVVaFJunym+ICLYAtNrZZiD1mD505tHHnw?=
 =?us-ascii?Q?o64iuGUfxgi4zq7tdfMy2pXdOnkvFVujt77SuBLoMDvBmG4sBWmte0IIrcHw?=
 =?us-ascii?Q?zw73Kc/tgbSmze20MpmTft7hqIrNIrriGybizIX3fF5AKvP7lcpa6cD0/sty?=
 =?us-ascii?Q?zq5X3ZAvnYudHqr+aj4VgU05NkeIQ6aEQaqMm/Rew0PA1K7hHWldYvZPTO94?=
 =?us-ascii?Q?BxxJeqecXcQAeFkI/3ExqFWLbIURpFaNUAiMIjhI1BYHsU1PEpG/R/MV89VP?=
 =?us-ascii?Q?3wygmWyyvpHLhQtOE8YCeQkR6TbgMUkEF2ERXadZ4L3JtVlAuXR8yuJEhggf?=
 =?us-ascii?Q?h/H8HN79+TWbj90K5NWFwgkmZFNtPAi07Ty+RpF2F4oKgFnaq6Qxg=3D=3D?=
X-Microsoft-Antispam-Message-Info: ty2gq4iHYxcO3IfBGRSzTeurvO5r0m6XRtHLzeNtP4MijiibWst48nkwqdhQ4Xha2ExMwdn+02gKqJJ8Ci62QE0Wu/otDn0XUUVM7r3pW65PTk1p6t90B9iNvDXqcETTKwjOWet7IYovTv5dROjf+k7qnHXHUA6tEL3vgVOtHsVH1OuSP9D8SuGTk/RCY+8x
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;6:OQyOSS8tUg4zCW1KefIMYaRCNOkqPplA6sWC7Uk7ieM/ruWnw/untzJ8hKlKb/PzKkI3BZApGlq/9yZfmTCf/qmb9edFAWb4wH/znwVKZZlsiUZ+cEJVZSLB4TsG9sKVMc2b0Nxm4nlNp2FmRmS7lgVnhK0qvvNl/RPbqWn9wY+wyTyDWD9f33hqdqCQ2WGD7Qx0JFI8RlNvzVamEcPC2pu5A/cwMIKlrOw25IfeX9bJ1rdv7Ami4mClfUTfvy7+GnqugbTCg9DQZ6BdECebgkkSUp+nrU1/MlEl6R13DzH8w/o3KGyIASgwMNdMLzld/ZODjztV6BrIjj/Fd1DKm4MnvqAVpKkwZx2c++C7w2GVMsKJtZjPHKkgK2MA/gN8gGf2t1VGsdTKke2L2gtwyDGqL5OuEdV9uVRc+/y5eRpUEZC+DTgokGnhOf2QGX5IhCuasFPXNbmXUo3WLcVt0g==;5:Cze0oklqGsa2PE74sL5i834DPI9/YXKh8kW/WOh6MYhlcTTZlRcNl1LLEC8YXvkMIA6bF+hxcVKrxpZwBnJ5Ny3Ar313gUVHiYqp603rSFIn3m1MxaFL6KnqB6E4kTWdSd8tmfANdPp3rklfpXG6OiRUt3sdEtSbNKHjpnMOvg8=;24:YIyKSWT8ABIRslGsO+l6Sq0GyN23+HRqH/T52ve7ybXsgakQ3Zbrv1SptsWfgEa0StdI0OGTwUKxfv4mm7ac3rSoHRoIDVCrl3lfgJVmt5s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;7:pSoTDDt1MsDOHV0GAMWG0eSE4dD1wnQZkdCVa5nOp+Ogrnw+i9NBUW8BNXzp8wRR7GX/hAWNrfLhxy919Ed6FUhau/NM1A5qJb3g2s1sD0wbhooLKagGzrzpy4k/HklbjhQ7sJZOeUdk9ILKI/KQponYtqIWAzClQ0rbqJ8nB0u9Lc/midwEUR5nv99yqBvQBjkYfzs5tnZVCVnn5ES/bOLAiOUg0NFcsCFFlgeIS//VCHOhs5GJtp6Ru45a5RcI
X-MS-Office365-Filtering-Correlation-Id: e21951f3-8e3a-46df-aa5e-08d5cd031a97
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 05:45:53.4411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e21951f3-8e3a-46df-aa5e-08d5cd031a97
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No this limitation now after virtual dma used since bd is allocated
dynamically instead of static.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 6faec89..afaee72 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -292,7 +292,6 @@ struct sdma_context_data {
 	u32  scratch7;
 } __attribute__ ((packed));
 
-#define NUM_BD (int)(PAGE_SIZE / sizeof(struct sdma_buffer_descriptor))
 
 struct sdma_engine;
 
@@ -1297,13 +1296,6 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	if (ret)
 		goto err_bd_out;
 
-	if (sg_len > NUM_BD) {
-		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
-				channel, sg_len, NUM_BD);
-		ret = -EINVAL;
-		goto err_bd_out;
-	}
-
 	desc->chn_count = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct sdma_buffer_descriptor *bd = &desc->bd[i];
@@ -1413,12 +1405,6 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	if (ret)
 		goto err_bd_out;
 
-	if (num_periods > NUM_BD) {
-		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
-				channel, num_periods, NUM_BD);
-		goto err_bd_out;
-	}
-
 	if (period_len > 0xffff) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
 				channel, period_len, 0xffff);
-- 
2.7.4
