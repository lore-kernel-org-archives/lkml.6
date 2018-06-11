Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id aQLaOh8eHlsQOQAAmS7hNA
	; Mon, 11 Jun 2018 07:01:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EF238607E4; Mon, 11 Jun 2018 07:01:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G4uquk/2"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 316D8606FA;
	Mon, 11 Jun 2018 07:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 316D8606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932496AbeFKHBT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:01:19 -0400
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:55025
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932407AbeFKHAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMOyeuv3INqCBVDhua7djyaTw3VXh2HVkh+tgpsaZfU=;
 b=G4uquk/2q+RTfYArvsEniPKW5KzmEcgXyrl+lhQukGsZQSgXJUjn12qoIZDONNO6ID+XtJb4EyVaGOVDKaIJyV+9mvgntcncrjoiRIaf936ZbBR3zzrxlJgYov4Q0B0JUlWKRlPJtLhkiPmoOFfxJH1/uBLCMER8ikXeYfK5+08=
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3217.eurprd04.prod.outlook.com (2603:10a6:206:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Mon, 11 Jun 2018 07:00:28 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: vkoul@kernel.org, s.hauer@pengutronix.de, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v3 5/6] dmaengine: imx-sdma: remove the maximum limation for bd numbers
Date: Mon, 11 Jun 2018 22:59:32 +0800
Message-Id: <1528729173-28684-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
References: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0159.apcprd02.prod.outlook.com
 (2603:1096:201:1f::19) To AM5PR04MB3217.eurprd04.prod.outlook.com
 (2603:10a6:206:7::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3217;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;3:RBAFK5/bmlateew3DpxR6UJ/5f8ipVNTVXfx+bC4Qa/zNmD8fzLcug+/IbYr3BdijdXeTiFOPhs4bimL5594OSM6T9YX0HInp8Cv6hWdIDCCKl7FXExeGNKhznxjtR1KTe8KDeR1gFi1LoMKo1exUj/D7JkGCsyihO8vSMw/HEsZfmQg3NhdNTHVbuDNtJSH7yrIC5S9Ijpq8Cbc3bg780NeyIjZmUm7SFn9ZQos1fGdao85tF0zJxES2hP0K8rV;25:HYz8I/FB/mKdb5bxcB8XTyAV5XVyx2oyAoGFBHSxwROZSmID+XqS0PKSpuU9vUh+nTzpdFT5gnH41ySpQwFMXU1plO83bW3bQDoyXEP6iMKNhTG8+eSheylLPuYTwwhBlHgw863U5eBai1sHt3PQCSznx+pWsYDunNZsXc7z5qwXo7vAFrYUNI0vvBmrpUoRIyUNzjrZ+qukE8d5IBsECy9Itkz+VQoluvLNhUBEF3lceYE+kdMjv2DxFu5PMVACtv8j8NoFtgkcY3igozyFCrxYiw7e8VtdM7XdxUCMu1uNHNQ175+H4YwXRApaP5HwdFCoHLZwuEMRjsU5NZaW1w==;31:QpaJCFgN97EtWlre1pGPWY9rzl9qb0WcbqmIGCELjWC4MyMezW7hRlUAMrXmc+DG0U+y7SN9VvLG12GLUZSrKOX+l28kC+3hRtAubQq/njjzoGTfIm0n5o3nNgfhhTdpAx6zpd5yU80UZgGt3Q1qw4KY4wJwYEKhmzldZYclRFJ70xv/yYMJamt5GIL6LtT3WdvvKJvwT4yb4KM5myxD2PNqH+3FO4nATSkxIjAxVSk=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3217:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;20:OZGSeq8XKz4M4uTPbhnhtpW008TM5+8UN8VVcLSE4N3FxodzfW47F3+0gv9SQj4bxd7EBFHjOLV1E3KzMSypdA8kqC3IXb4fIWGaumb4E6LUosSaIO4nZEkn3fMqI3sVokWpcoWAghNA1wW14QOak5vhlvrptOeMQn3690Q6Lernideryn05/uU2T3xUUs+kcAau3SSzIUeh/FKILKUth8DnAD/bIAbSXuXDlzCNHa0E5KnCkv9Sp9UoBlffxOE19Kg4H7jfP5XpQ+fmd815IP3Ff4lvCWn9cSx2RNUXc1HU7ykkevksSvncSjFlI915KrT9OFJBE9/6hrPK25/0xiVzMtrAHO3utZQv4OAUKRYNgBHP7Ie/h7wU6V6Y8MKFJ9Wt0+SZcqGQ1OzN97qunlq0BFNXv5k+hsWTtNz6tFG0tu4ig3WzoJkc3CniFUBwDP6NibVM/oar1tbptilWjEF+1NdMwOCraleQdOKoMLF7uZYPXCvK8eq2/w4PcRMT;4:xi+GSgx9h8CJZi4SzuXoh5rpGvggKZkxEcaDoFoPmXPaS34EgL8sUzNs/VnHgZEHBgxwfazVmIfAFBLriLmF7ycDWSZKr4B3B10LRUXp+hVOeWVdvq1mcwgkxVDYM/Ekt9myCMlUv6WSP4za6UiKecXCafJhVHf6QMjjnZAm/ag2GjXWHDqJDHDFdhN/sMcBUPOWSS1Je/XpNRi1eUVpJUzkQuyS2R/oaU14veie4IKS/nWKcSHSLuccCDw8g2xwp05J6h9jAxx43s63Tm7Hq36EqioZP77CuYjG4xA9rUsjlWsZBJPrZ6YtEmANzoZV
X-Microsoft-Antispam-PRVS: <AM5PR04MB32177AEFB63B8D8E8CF203A989780@AM5PR04MB3217.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3217;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3217;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(396003)(366004)(39860400002)(189003)(199004)(5660300001)(7736002)(51416003)(76176011)(52116002)(97736004)(478600001)(16586007)(68736007)(48376002)(36756003)(50466002)(316002)(2906002)(386003)(6506007)(81156014)(4326008)(86362001)(476003)(106356001)(66066001)(8676002)(16526019)(6486002)(105586002)(486006)(2616005)(956004)(6666003)(3846002)(47776003)(53936002)(50226002)(186003)(446003)(26005)(6512007)(6116002)(81166006)(25786009)(305945005)(11346002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3217;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3217;23:qsOFyn1jp+Chvg1l9oMxuA/FqN+hrX/VD5oK5826D?=
 =?us-ascii?Q?sIMVoFSXDoC8B5hUigKH6LSJYmvc9+QyhJ5SwWcu4F8rnguBfHUEf6SAxOzG?=
 =?us-ascii?Q?6e1LOBpJFPiACRcfWU6EPC49m5W+DYsBk+e2j+j9cCvd/LKYK4if+qsqWL43?=
 =?us-ascii?Q?7b/IoZk4d0a/kVdKzC2hin9/K5RCzR7ydSUY90brFZ7bqLzdHG+e3mtwSXJG?=
 =?us-ascii?Q?1u6M6yTN9wBD4F7tJLN8XFCnNZkWeoFUIIR5RfCQHeNmr91wN9QwN72O5fah?=
 =?us-ascii?Q?pa5uHJLYdQQzMN2NtWPIqiU5h1hBNqclHy2tSzX9HF62yZ7noapUJ8NM5mq8?=
 =?us-ascii?Q?jkl3xq2Sxyi7qSvxDQr81FOEyuLScrY1zJljrUNI6uGdR2ZJFHObnaMvafku?=
 =?us-ascii?Q?1fv2yHNBsUtyYopWOdRuJkiBO1v3EtFt6YnaT3z9B193XYK9bPL0UF8OwIlR?=
 =?us-ascii?Q?CDt+YjWWooXigtDbGQUf4a7uvlrRkXIpNsAcxHPfssg7Cuomv/QWAf9TlJCU?=
 =?us-ascii?Q?s7x2BFMzYBksuIBMIrf7obV5Qw5oypSKX1oR8qayNPzIL3Jn/x71fF9VktVH?=
 =?us-ascii?Q?OUDufa261Ap8gtioqyLAX967LKXgpghKys7SxV0mNOW6Qz61QNf1v5pLnsjO?=
 =?us-ascii?Q?j8WALTk/C2g90+TOSQsJX+aaCbN3G6Qv+cakmTs8J44rk2h8tqZ1hyS9BcXF?=
 =?us-ascii?Q?oRo2N3HnYtZMQOc/fE3Ofi2sLwdMP+RNd8873iWU4xfPUve26yfwlNVPlNzO?=
 =?us-ascii?Q?OOi8set2x4JyjhcY+RmCtbR2etRA+NlcA/vy3cTaIA6/hov8cOYul2WNjP2S?=
 =?us-ascii?Q?hl3E6EZks3cxTvdFWmBf/Pcq/O6XSWVbbPJc7DVoJWWDQGqkgs9d60pvceT2?=
 =?us-ascii?Q?V0ZxTRiOqKBHaoKyvrn/oX4xpnKa44Vp5CJnQHnnTXSiEnHxwuUq5LKLp8EE?=
 =?us-ascii?Q?PHwOLhh7Fmd8WlQGaYsIG9E0Z9ZZuOzIKCG1pfKbrcAf+CPwnNuLPidQyojT?=
 =?us-ascii?Q?uLWxzxIOkp4oh6V+ARhlbB9qhhwbbduG4wHYp6UIMnbTfFEBvfP/eoNDv94Q?=
 =?us-ascii?Q?qI/lu3JfC5VpAsSZfOqDxBM18uUIcnwECoxNUWsIDDwY+W+fOHWCH9TfLZJe?=
 =?us-ascii?Q?rSRnDtcptTU2TMzboXXkGwQEYYbdHZH0XxtyvJR/GS6nL/05u9B6Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: sQ98aOBmIi79GhhZ2C7IfArwQRT6rTB6QUDvnIukE3J1wtfWg1o4TkIkIOGifuto/kodoHV4MeAlxrfWQPGBFCiny4SP/hKla5dtrP53Nsl4y0UUa+0hqZPW+DMDjlWGOAIIq7Qr7whk78AuaZDFtKisfbR0loBciWAddUb+kZ/IoicXHNfqqqcloLg0U5eD
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;6:YfleYr7BEDK/HFzLh7mEsIgIfxrTmKAL4UE3lZGOBjhKX1EMSqS91ismx65bgvg7QfTORotKF4oYgOnBCOEjTKbQu8dbONfZgfa9CnQqrnFNLbK6Ai9vvdNeaSkaebxoMUxO1qZRQDh94PVsZRJpsWbRVHy1Oiit52oSPskt3v9gPOmLr1Rl3pqj0d763SWbCBNuPYS3L9UfAtLvuRaOy9J/RKNGXxbkerYFdfXGUdVg+ZWT7nJPbpfeMBecctvRy6r0GqH6qFwTOS6czDKqksIufd4rSQc4bK4GM6tfKszaNTWIocDxDNYomXp7SdannfuvTIV2obYb3kd4V0oFt6bOMTUkiZmzgXAs8xkrm0tyk4nSPj64k91mQqH6F0wCx8ojnr9l1CX4QEKU4kdTSYzv+kJYsoTyqxzFxjg0xhVcEpd1HhSU64WdJ7agVOaTVj4W3Ay6uWPlYK4R/m744Q==;5:l6y/Bx2zHZpIo1ASyLgKyHagFmIeH/Y7MnvcD82XU7GklwD5SleWYGC9pB/9JuAo4VUspy1v15PznIr/uWO3JJXtPBp9SfG1WKUZhR5OX0ewx+XhowCawprFgAMOAuBIQl6fRuqECDJKHjxLMfjo/nXvC+PaIXQlfyIHxjXmWbs=;24:/3V9F+FXcFyfxHOtclHWiaGXS33587lOfP6v5D+2ej/fARQtQwqICs58vMOTzdh1j85FV9lupnKxLQtW0zZwKv//nYDzG0g0uEN2kHcrfgU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;7:Edp+qbI4vJbXF+wM/dB6dZk20x2KIh6meci4jjioI8CoWkuNIE3BQNEtpKhysk3YBup1+oCOgpGgqgGpBMd85R810RB315EJjIEDrmeRov9+lzF/5yLGRyVw28f4FKJsvi7//nOB8zrfZumZCx+IQ7L19zpL63YDjWIiIev+uV3PDa6ybWK2e9fwWXOmlIIDfg3/NbVhgbunwDD75da8XFO2T1iKVZT2Xhf4zhdd4mwAE9+rQ9RR6AVRf/nxn07r
X-MS-Office365-Filtering-Correlation-Id: 986c48e8-3e07-4523-c387-08d5cf690501
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 07:00:28.1404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 986c48e8-3e07-4523-c387-08d5cf690501
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3217
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
index f150b38..0b0588d2 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -292,7 +292,6 @@ struct sdma_context_data {
 	u32  scratch7;
 } __attribute__ ((packed));
 
-#define NUM_BD (int)(PAGE_SIZE / sizeof(struct sdma_buffer_descriptor))
 
 struct sdma_engine;
 
@@ -1296,13 +1295,6 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
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
@@ -1412,12 +1404,6 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
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
