Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zHBEOhYeHlsWNwAAmS7hNA
	; Mon, 11 Jun 2018 07:00:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D426B607A4; Mon, 11 Jun 2018 07:00:38 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OiFv65I4"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5C105607E4;
	Mon, 11 Jun 2018 07:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C105607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932447AbeFKHAe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:00:34 -0400
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:55025
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932092AbeFKHA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DfVRO9dbfMpLUZgK2+SwfcvpBrq+/+4dsa0n7UJ1gw=;
 b=OiFv65I4sGVBmlpcaq9v0f37EEjjgvUOxgVvOyW6yHq+dK1p+eabbuMGNiV3nNahO9j6E/CbLPiSHMhtA57E3KcCjzw4nT5w5cF6GLxWCuZ5Wv8mSdHPq6mgx4t7lF9gyeYYZ845sanHHENiWg1pC0701ct1fxG3FIp+O20Ur/c=
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3217.eurprd04.prod.outlook.com (2603:10a6:206:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Mon, 11 Jun 2018 07:00:22 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: vkoul@kernel.org, s.hauer@pengutronix.de, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v3 3/6] Revert "dmaengine: imx-sdma: fix pagefault when channel is disabled during interrupt"
Date: Mon, 11 Jun 2018 22:59:30 +0800
Message-Id: <1528729173-28684-4-git-send-email-yibin.gong@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;3:IAxRcaw9WMI5JNUY4rHvgtyWrdCy0k3JbFzXfeAwSfJZpBzfqD/EXWt0U9SRlgFE/KpbN+ZL/lRQ7XV5jdaDyVyCMRC1CuXEZAfsOeHOBlQEdjRuZYlfVTf9n1OjdzAsSYzBSkarl18h8Hl2qE7meo6yql2Rg9uyIoFa9HgQ1c58ZY+WyPifTyOTULAJyxY/jPIAhkhy1sdKQiezJKA9qsuOFcCpEqUSnKz1hA9oKgd5tMAz2K5KDtM5vABP+KfR;25:r8KiFipi+QYDfdBomVWoolwj4CEWeUVKjNq5aZXI8EuUf9TPL3z4S7FOqbGkJTAwgaL6TW0mBZWVpv88vmeqmbqTiFAG20MYJvunHnn0QP8URkeXadd43G8Actu7LDlIYLsOJ0Inil65o8OkeQBnAlEaSinWYESMwE8/aa5yO6A3HK3V6de6AHj7w0Wms0QNsrZOucSwCgzJrotqCi3nbE+vlwuxAgWLUm9nsqPCZwOKl8A1O/5Gxnmac81+GfUKD3a46WKHbcTNhO6txYdZVb8O8PCAw7+LrmwM68prQxxMjXBZKoU1me9IXdV0K/5c7JfI5z4yzRBK26a2qfuBqA==;31:n/T7jboDLuTo9IMLAU64G9C1EiGnAQ/CY0JOLUBrFp2xjZI3RSL+/Cm9CeBd2flo3RsoPMje/PvDPYoCJQWtU3ycqum8pxdCJZpqT6kk1loYiZsDheJYKFWh8d+ovHXdBJ5icI5UdUBXauGBWJC9LELrPCfmDZTq9/T9e77L3QBXnhqJ27MvRdO8/8YUwVc/HZzFkYpxgSTELfk+VguTEyUPJNFLPiZIAYXG3wH6x1E=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3217:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;20:DX/biakpJFcG7wC0vmqAk6O2Q56cykxHf5WS7F9VEQg4JZTfh06dwnkfFhoCDvYsla3tVbszQiLE56BYQkkoHsrDM12UCzeBpTY91jsr7R0FAYeH4zxH0FTFLyQKfJD0QNPk0Smzz/b2UYasrdgYhXvRXqYqgOBQpRASiexLT+Jz2UtHumlf5NfxyWM2WtRoJeE6dqcH6IbzeVjW6brjenrxi1OCYmV0XKYbmv3swrooNTEsY+DjJX2DmWPABTfYgRZFFM1fk0RSFBSwm44A0qX3YifrMB0BNzYKxAk42oyjScKdm4BmcOaH4lvDf1X9B3I7IaKTIJ7+S5tjycvuEuZryq8HONyirSiZTYEy5uzZFBOviyKF6CbnjrAHO52SwO1wtcPmHZnIsnMeaR3YJ9jwFqt46SOUsdN1ufVXg/xdpCV850dswtqIOPPQQJ191BlDfb5PEk+Rd2GilmML+BW1K/aLcKKNOVmRQz4M8S7VeLliJI2sxZbgUCfkq8eJ;4:4malttFQndNS6J5hoIG9jPVHSu0Swz2xD/z8gPb4AFOHq912GwLDyLwr3cyBl3GEzFpsLE5OZ0v9VCIHTozSVrSqd8VCLzV2lp+IPXnDLHpZQMwZlCHUkPtkaBHmDqfhXQf9DanTBIN+Oc1mNhU/EKcRC/ulcJ6e3BMLJH+RymqvRQ5aGg90ygRcgefI87Nwd/qkLHA1OSDUr0zUoDcq4JpCgN6NoDQ8D/BSLzo/ZsCni/zuHDctmF1zl8r8H0Nf0BHIFZWF1xI05HGNZsYZyaG1IcWw69wY3ON76J2wbqz2HKkwVsJ8HIqjOhGpQ0mq
X-Microsoft-Antispam-PRVS: <AM5PR04MB3217429BDE5D377175358A4989780@AM5PR04MB3217.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3217;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3217;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(396003)(366004)(39860400002)(189003)(199004)(5660300001)(7736002)(51416003)(76176011)(52116002)(97736004)(478600001)(16586007)(68736007)(48376002)(59450400001)(36756003)(50466002)(316002)(2906002)(386003)(6506007)(81156014)(4326008)(86362001)(575784001)(476003)(106356001)(66066001)(8676002)(16526019)(6486002)(105586002)(486006)(2616005)(956004)(6666003)(3846002)(47776003)(53936002)(50226002)(186003)(446003)(26005)(6512007)(6116002)(81166006)(25786009)(305945005)(11346002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3217;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3217;23:1WxkjY3inp2qY4rqNEm36QVj8xo5Uf5kbqCjeMsC9?=
 =?us-ascii?Q?biaFOG1pVPh8VDY+cQfex7jIxwI7qXEQz+sifXNvUzATjkxSyh+/mHJ47tkv?=
 =?us-ascii?Q?fxSf65rL6U0GW0QKBZMVEmeDsbR6yl4KC9n2hosprcmElSu8F4yuCQAQaIsq?=
 =?us-ascii?Q?qBOq81QnWQ44KqzLOVdAwNISs+8Y57g2PlEunn3Qut0Xmb4Gd19kza8oUG10?=
 =?us-ascii?Q?FbBRBqX+uUMobEKh4gpVbTYiiDaz1E03dI1URDMiltj8cbd8kdZ9XXki89TH?=
 =?us-ascii?Q?OmxILI0tcnvVg+qEEdkNEHzKNU4SnRCYT/zLgGNtBdrUAJew1aRhIy5OuGNr?=
 =?us-ascii?Q?1w2wb9+4PFIrSxC5Wn47Fu9J+IdV0bvaw+rwHaRjukoQRdnAIb4XmDHbbdbE?=
 =?us-ascii?Q?86XTYWLbGycgxV9DIuXJNiW8ZQ/1p2X1YMvs8sa5C51iGM418qmCFU9xYSKA?=
 =?us-ascii?Q?M4lGOik8jeFAfw85QnzvG2i/G9ZqR4Sl0/kksb4uKByUJhnw4VI0BA6d00Un?=
 =?us-ascii?Q?EXABx0m0RsVv4iJPjbybZ/5Q32mzK+wfFF1XK06qk897drbwzU4s1umnLoE/?=
 =?us-ascii?Q?7SIKi7wD8du6P9a/qUaKneb2NnvIkqagSBJoGqZvSXNSnLZiVGELQ6g2cTr7?=
 =?us-ascii?Q?KvcvCOZaEVWtFrNbgay78sB+Fg4ghs86Uo5lzni41+yJ3ev0dBGEhmIyO/xb?=
 =?us-ascii?Q?d18DQToL/JX7xkZ33jjyVUEFCej7voJGVTd3wx7x2xZs54mMUfuGNIL+u69j?=
 =?us-ascii?Q?DuyIRLFU15ddezt2U2eiLwf3oHtox0e+Et+BhM5KlaeAvO4TPErVD3eHeZem?=
 =?us-ascii?Q?UtyWQ/H2NYn0rEt/OYVmqtEphw4lVH5fU9yJqV6B8rWIhS8qtzMoYeamwEZM?=
 =?us-ascii?Q?WX6ULbtv9QqQw6dSQCV+cbqGq06gd5JVzsvMVZYFFMbCeJV8qGaPtNy1UVuC?=
 =?us-ascii?Q?B8QI4kqN6vkxyAB9Ale6Sb+Tx2uXExzoLU9GJZWrNYKFVs8FVieyV2zRDrdS?=
 =?us-ascii?Q?zQcBaWlkxMUCo+SodDn2eyPprFDnN3qGyLXUw/ZglrC/vCSRbNEaf06jB+D0?=
 =?us-ascii?Q?7FkKEkWXuhhEgAsuMU+Lm2NHrX8WrzP+bNfz9QRbUU1id/wuFw9elqFUwGgD?=
 =?us-ascii?Q?Z0B8NZTYfN5Nxgd9+3TmOGn97vOFKXs93BQ3/RQqmgDeRkAlFh3ygAUsb2Si?=
 =?us-ascii?Q?psveErAkElcKX67ryf7Rp1SXbAzHJZaVl7+?=
X-Microsoft-Antispam-Message-Info: n22HpXlbOFef6OA0PlISJ3uFuF/4hStZao09vj3dzZ1c3u5lFutzFrMKjaJHIvVLLypj2pBs8fmsZnBmoWwyiY/nJzqYpr+Et3Y2QKw/U8k/CVMyev7UQf/fXbQHLB+68hQM9DRFN7QkHFFDE8gy2jHDD6ZuufzlHUWiBiuNXoMlS2Pz/FxJqq480MsF039g
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;6:Xsfbix6Ft+rYT2jsOquabfzKIqN1J8ANQ/fddmLhInqNCbWpFl7GvI9yOFQfy+a8n7ZqEbUPXMFyCoRi9YlSxzdgYzD9h30Dl6D9Cyjt9ngb3e+oRVfZ0WvGo+v8eCX5gicD/rR85HwDh7kY59jgVh6kyGXYnfTr7jo4Ze1306xcLP/JZNmxhEB690YF1YOw7TxjuZ0KRrybw+ScknbhEmAUQowDNnTi7Uebbk3sVV08Ua5y2Disw27yULXW/A6bwuDlKzAndyybY+4j4VZrmbi8hl6e27UhwzN2vSFOj2jTmIcz2bPzoBVAiiLjSsUIs1+fcdzybbPCrlNdIVWqQj/NZNEfM5GzQz3LnuKxjs/32fRhkhLEY8E2fdlyLyUjbB3RMo4DhH4cDcRIydDDOwhWdgk0QGk/Smb8hBLaLSeWx0z8tTgy5jf80tuEoU7N8jMJZ/0pmkMeOi/r3PB4pw==;5:BhOKGr2Dg0dA2HaPDRdKv/S61/Tis4ryhzVgy276Kq6QNBgTaO+ZD6AyseQ43vQQfwtyBAFynaViXIDkFqNyKd6dsIcvMlZBhe4e3ZI62AMjRk6ZlyfpXK+P7DJxL3+XywHawo+pkwXrdRaJJKxRotYaPJVaTcn/TCsSUcoCEUM=;24:LEkXPqipkssNjxGOhIZ4zKJoVfa45L/39mr1n081GBoX0bCmOqLqjnazxa3jHUpdA3qO6ERF6cs3G9AsLfkvTmHkQSbFiPnhnMu4vnxGXEU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;7:2tuwegnk3HIi4jY1BdCGAXQbiiNhR0XtzHDy1Z4GzA/B0s2GjyHw8W4T/GY6Hk/GGvCyn3EoThSUOTtCGPs/XKRm+4/mN/6As7Uu+7TO+rl6Jj0nAZbcO2h1u0YWFbQ9e3APyIclWMnkTm+OA+8TDriswuV91Vxu59bgo9+rBYocNUl5SESpbc2CvjOMM325k6RcRUXCYMO+0kW//Pxhcv8McRzp+wccBUD13roJERUbps/XngxLZOrX92dy9afI
X-MS-Office365-Filtering-Correlation-Id: 25453042-2809-4e75-76eb-08d5cf690169
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 07:00:22.1091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25453042-2809-4e75-76eb-08d5cf690169
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2746e2c389f9d50043d21e2204270403efb9d62f.
Don't need this patch anymore,since we can easily check 'sdmac->desc' to avoid
handling dma interrupt after channel disabled if virt-dma used.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 474c105..e0af8ee 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -352,7 +352,6 @@ struct sdma_channel {
 	spinlock_t			lock;
 	enum dma_status			status;
 	struct imx_dma_data		data;
-	bool				enabled;
 };
 
 #define IMX_DMA_SG_LOOP		BIT(0)
@@ -613,14 +612,7 @@ static int sdma_config_ownership(struct sdma_channel *sdmac,
 
 static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 {
-	unsigned long flags;
-	struct sdma_channel *sdmac = &sdma->channel[channel];
-
 	writel(BIT(channel), sdma->regs + SDMA_H_START);
-
-	spin_lock_irqsave(&sdmac->lock, flags);
-	sdmac->enabled = true;
-	spin_unlock_irqrestore(&sdmac->lock, flags);
 }
 
 /*
@@ -738,14 +730,6 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 	struct sdma_buffer_descriptor *bd;
 	int error = 0;
 	enum dma_status	old_status = sdmac->status;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sdmac->lock, flags);
-	if (!sdmac->enabled) {
-		spin_unlock_irqrestore(&sdmac->lock, flags);
-		return;
-	}
-	spin_unlock_irqrestore(&sdmac->lock, flags);
 
 	/*
 	 * loop mode. Iterate over descriptors, re-setup them and
@@ -1006,15 +990,10 @@ static int sdma_disable_channel(struct dma_chan *chan)
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
 	int channel = sdmac->channel;
-	unsigned long flags;
 
 	writel_relaxed(BIT(channel), sdma->regs + SDMA_H_STATSTOP);
 	sdmac->status = DMA_ERROR;
 
-	spin_lock_irqsave(&sdmac->lock, flags);
-	sdmac->enabled = false;
-	spin_unlock_irqrestore(&sdmac->lock, flags);
-
 	return 0;
 }
 
-- 
2.7.4
