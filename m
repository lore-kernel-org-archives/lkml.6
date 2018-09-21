Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5016C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8266521536
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPvL8pXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8266521536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbeIUFwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:52:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38785 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeIUFwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:52:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id r77-v6so47410pgr.5;
        Thu, 20 Sep 2018 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wLEa9L9+uIpVjMdvxvvuhRN0Lx0zc0BWe2klPFWo4dM=;
        b=RPvL8pXl4kxwCq4rG1WicHc3cGKaqDzzQdQxM9k6kTBfyH+xQEBBHrwbqQMj92Cvdb
         sRxgHtPwLfpz6ldnuDwy+xC9FZvgoyjCb8tbFXPeuRmuubesBSzaKL+mVe7r5DxXUjdL
         8eJRIXZUwXzjDTn9pLNK/cSp15IcWM9K7V09Lt8JzX33CvVZt0hrvNaUcNSBjR26iYb5
         JT6c9FUAT43tiLN4fz5+0tH6Tg1yIT2BWM/HQB+fa6W6SSPM2ti2oTW5n452mGIvD2yt
         sHAfDKSOAQ1S6vJvaguZWRhhiqhCBkjR8k/jYs78xu190gF/RQVhCaSxrxQhG88ink9/
         /JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wLEa9L9+uIpVjMdvxvvuhRN0Lx0zc0BWe2klPFWo4dM=;
        b=COrgMhpuThY/NOImiWS0omNr8Ba/+thERPS6fQLFHWJt8ExIdPlIdhOwQvkJ/LmdZD
         K4Ov3oHfHYmj5hAYwkpYHWzlVx3tfa9ZrCJv+lX7SxEO81fVnHQwpOn5EIFfjzoVVsYi
         w6z1E0HJ2Iot6SLbwKY1QeEpdGylqrjaEJFFjFh6Aq56TsAnYgrnYAoVFlZqXoRj9h+m
         H8UnebQyL2Wj42V0wHhGljMfXhgrZIJ0uMEEVCdeUf6xesC+VvDrTBD8IqLVIjEyD8Xg
         eioo+8f4ovp3dpADb45YtU57HIopJ5xVbesIbJ3L7EmnWS9eb1+WTGnI6UPP6JwtpDZu
         oCdw==
X-Gm-Message-State: APzg51CB6lWKGj94HAvQwZg7pXbgvktJ6f5zDZ96STd7vZtEAH0Pg5AU
        6Bjq8ZH4Qqxnk2jfgmuyqig+Pbfd
X-Google-Smtp-Source: ANB0VdYCWVjmnmXuQbUmSDi8LJbCbN8EPwKL5TuUy8RY6aAjj4CfxwsfcANz6ow6B6x992ag1tcN1g==
X-Received: by 2002:a63:10c:: with SMTP id 12-v6mr38478606pgb.62.1537488365178;
        Thu, 20 Sep 2018 17:06:05 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 130-v6sm6630508pgd.66.2018.09.20.17.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:06:04 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: phy: mdio-bcm-unimac: Allow configuring MDIO clock divider
Date:   Thu, 20 Sep 2018 17:05:40 -0700
Message-Id: <20180921000542.26022-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the configuration of the MDIO clock divider when the Device Tree
contains 'clock-frequency' property (similar to I2C and SPI buses).
Because the hardware may have lost its state during suspend/resume,
re-apply the MDIO clock divider upon resumption.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/net/brcm,unimac-mdio.txt         |  3 +
 drivers/net/phy/mdio-bcm-unimac.c             | 83 ++++++++++++++++++-
 2 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt b/Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt
index 4648948f7c3b..e15589f47787 100644
--- a/Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt
+++ b/Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt
@@ -19,6 +19,9 @@ Optional properties:
 - interrupt-names: must be "mdio_done_error" when there is a share interrupt fed
   to this hardware block, or must be "mdio_done" for the first interrupt and
   "mdio_error" for the second when there are separate interrupts
+- clocks: A reference to the clock supplying the MDIO bus controller
+- clock-frequency: the MDIO bus clock that must be output by the MDIO bus
+  hardware, if absent, the default hardware values are used
 
 Child nodes of this MDIO bus controller node are standard Ethernet PHY device
 nodes as described in Documentation/devicetree/bindings/net/phy.txt
diff --git a/drivers/net/phy/mdio-bcm-unimac.c b/drivers/net/phy/mdio-bcm-unimac.c
index 8d370667fa1b..80b9583eaa95 100644
--- a/drivers/net/phy/mdio-bcm-unimac.c
+++ b/drivers/net/phy/mdio-bcm-unimac.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/clk.h>
 
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -45,6 +46,8 @@ struct unimac_mdio_priv {
 	void __iomem		*base;
 	int (*wait_func)	(void *wait_func_data);
 	void			*wait_func_data;
+	struct clk		*clk;
+	u32			clk_freq;
 };
 
 static inline u32 unimac_mdio_readl(struct unimac_mdio_priv *priv, u32 offset)
@@ -189,6 +192,35 @@ static int unimac_mdio_reset(struct mii_bus *bus)
 	return 0;
 }
 
+static void unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
+{
+	unsigned long rate;
+	u32 reg, div;
+
+	/* Keep the hardware default values */
+	if (!priv->clk_freq)
+		return;
+
+	if (!priv->clk)
+		rate = 250000000;
+	else
+		rate = clk_get_rate(priv->clk);
+
+	div = (rate / (2 * priv->clk_freq)) - 1;
+	if (div & ~MDIO_CLK_DIV_MASK) {
+		pr_warn("Incorrect MDIO clock frequency, ignoring\n");
+		return;
+	}
+
+	/* The MDIO clock is the reference clock (typicaly 250Mhz) divided by
+	 * 2 x (MDIO_CLK_DIV + 1)
+	 */
+	reg = unimac_mdio_readl(priv, MDIO_CFG);
+	reg &= ~(MDIO_CLK_DIV_MASK << MDIO_CLK_DIV_SHIFT);
+	reg |= div << MDIO_CLK_DIV_SHIFT;
+	unimac_mdio_writel(priv, reg, MDIO_CFG);
+}
+
 static int unimac_mdio_probe(struct platform_device *pdev)
 {
 	struct unimac_mdio_pdata *pdata = pdev->dev.platform_data;
@@ -217,9 +249,26 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (PTR_ERR(priv->clk) == -EPROBE_DEFER)
+		return PTR_ERR(priv->clk);
+	else
+		priv->clk = NULL;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	if (of_property_read_u32(np, "clock-frequency", &priv->clk_freq))
+		priv->clk_freq = 0;
+
+	unimac_mdio_clk_set(priv);
+
 	priv->mii_bus = mdiobus_alloc();
-	if (!priv->mii_bus)
-		return -ENOMEM;
+	if (!priv->mii_bus) {
+		ret = -ENOMEM;
+		goto out_clk_disable;
+	}
 
 	bus = priv->mii_bus;
 	bus->priv = priv;
@@ -253,6 +302,8 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 
 out_mdio_free:
 	mdiobus_free(bus);
+out_clk_disable:
+	clk_disable_unprepare(priv->clk);
 	return ret;
 }
 
@@ -262,10 +313,37 @@ static int unimac_mdio_remove(struct platform_device *pdev)
 
 	mdiobus_unregister(priv->mii_bus);
 	mdiobus_free(priv->mii_bus);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int unimac_mdio_suspend(struct device *d)
+{
+	struct unimac_mdio_priv *priv = dev_get_drvdata(d);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int unimac_mdio_resume(struct device *d)
+{
+	struct unimac_mdio_priv *priv = dev_get_drvdata(d);
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	unimac_mdio_clk_set(priv);
 
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(unimac_mdio_pm_ops,
+			 unimac_mdio_suspend, unimac_mdio_resume);
+
 static const struct of_device_id unimac_mdio_ids[] = {
 	{ .compatible = "brcm,genet-mdio-v5", },
 	{ .compatible = "brcm,genet-mdio-v4", },
@@ -281,6 +359,7 @@ static struct platform_driver unimac_mdio_driver = {
 	.driver = {
 		.name = UNIMAC_MDIO_DRV_NAME,
 		.of_match_table = unimac_mdio_ids,
+		.pm = &unimac_mdio_pm_ops,
 	},
 	.probe	= unimac_mdio_probe,
 	.remove	= unimac_mdio_remove,
-- 
2.17.1

