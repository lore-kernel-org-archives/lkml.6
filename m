Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeCWMbZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:31:25 -0400
Received: from mx.socionext.com ([202.248.49.38]:10375 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751768AbeCWMbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:31:22 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/2] net: ethernet: ave: add UniPhier PXs3 support
Date: Fri, 23 Mar 2018 21:30:37 +0900
Message-Id: <1521808237-3623-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521808237-3623-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1521808237-3623-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string and SoC data for ethernet controller on
UniPhier PXs3 SoC.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/socionext/sni_ave.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index f5c5984..0b3b7a4 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1701,6 +1701,10 @@ static const struct ave_soc_data ave_ld20_data = {
 	.is_desc_64bit = true,
 };
 
+static const struct ave_soc_data ave_pxs3_data = {
+	.is_desc_64bit = false,
+};
+
 static const struct of_device_id of_ave_match[] = {
 	{
 		.compatible = "socionext,uniphier-pro4-ave4",
@@ -1718,6 +1722,10 @@ static const struct of_device_id of_ave_match[] = {
 		.compatible = "socionext,uniphier-ld20-ave4",
 		.data = &ave_ld20_data,
 	},
+	{
+		.compatible = "socionext,uniphier-pxs3-ave4",
+		.data = &ave_pxs3_data,
+	},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_ave_match);
-- 
2.7.4
