Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66597C04EBF
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3206E20817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NGrSHrzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3206E20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeKREiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:38:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55473 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbeKREh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:37:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so1553002wmc.5;
        Sat, 17 Nov 2018 10:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ppvykqhx2WpW0A8bR4cTRb1FLIr5iSS8at3Gbm/YSHc=;
        b=NGrSHrzDKaCiiawKNQZKyPwdNOkhhnioxdQVcnlpz2A/nNCHGe7T1nOuyzSEwXMBjQ
         xjXKi1V53BV94Yz1rBIAtZMl93vPMK7HrAcbJTMK9xOzFAX0hKxpBVitJvKhY003OSwe
         QcpVFd9CyZiqxhNSxs2ZjlrsFK4+SFy134UaGfSM1wPtTlg4ohs4ui1FRHLrHYIQ4coh
         QpVBU1+OVKBLWVNh/ABVnlUZejX61Bg2kbTyoHAorVkCkm9giz9q/m46J8XgFflNZHZ6
         kBQly3x7cvt8Z1al4D6g2QdV6fsu/YumoYtjZ+L1Q0A7OO3V8vvksn3ZtXFV8rsvoDsH
         Pzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ppvykqhx2WpW0A8bR4cTRb1FLIr5iSS8at3Gbm/YSHc=;
        b=DxEbgEY0FvsvzWtJTC29e1tzLJ8wmcJ3g3Oz06nmcsKP/CdE9/qKl1hSWzKDC5sfYE
         LYDksm+BHvY/hgaYK1/C5sPAFTkj2aUJA9REtCwOaMGCrC4knEL+aWSbAKz3kEMQh3/1
         ehxrnXQ/nP0va7NO9gcbrzMt/+BHmLkLQ+tAAc+DJrtWjjFW1DcKc+DEB+o+e1O1EfpI
         D/Hbza+fUxQ/k7mZU1fxCx5S1vKLvjjeTBvxLkMYL7ZpHSm+A5FGDS/BiWAbcmsZrPhg
         q49o1WnETK+uxUJihJzW+jZVL2DCxLRSiKX/dnf7qAO//9oiRo4TIJp2TqewLYAspH1Y
         yf1g==
X-Gm-Message-State: AA+aEWbrfWKSwLfHrcaiy0Gq/5doLNScxnZsRlorWhwu9dRUFP0yvcU3
        kHP5AtkEup7aIFb1UwLyhrxAaRA6urw=
X-Google-Smtp-Source: AJdET5c3yXcWqbszHinJUkd8RJrg845TSZcHTRXAy70kZoOxZqufALatocnCCVbbSiNEB3nXKyvyCA==
X-Received: by 2002:a1c:a5c8:: with SMTP id o191mr798433wme.150.1542478827864;
        Sat, 17 Nov 2018 10:20:27 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100C991D5C7C405D3EC.dip0.t-ipconnect.de. [2003:dc:d717:a100:c991:d5c7:c405:d3ec])
        by smtp.googlemail.com with ESMTPSA id e8-v6sm63631232wmf.22.2018.11.17.10.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:20:27 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 7/7] net: phy: icplus: allow configuring the interrupt function on IP101GR
Date:   Sat, 17 Nov 2018 19:20:07 +0100
Message-Id: <20181117182007.14791-8-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP101GR is a 32-pin QFN package variant of the IP101G/IP101GA
Ethernet PHY. Due to it's limited amount of pins the RXER (receive
error) and INTR32 (interrupt) functions share pin 21.
By default the PHY is configured to output the "receive error" status on
pin 21. Depending on the board layout and requirements we may want to
re-configure the PHY to output the interrupt signal there.

The mode of pin 21 can be configured in the "Digital I/O Specific
Control Register" (register 29), bit 2:
- 0 = RXER function
- 1 = INTR(32) function

Depending on the devicetree configuration we will now:
- change the mode to either ther RXER or INTR32 function
- keep the SEL_INTR32 value set by the bootloader (default) if no
  configuration is provided (to ensure that we're not breaking existing
  boards)

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/phy/icplus.c | 71 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/icplus.c b/drivers/net/phy/icplus.c
index 3dc8bbbe746b..a27e15cb3366 100644
--- a/drivers/net/phy/icplus.c
+++ b/drivers/net/phy/icplus.c
@@ -25,6 +25,7 @@
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
+#include <linux/property.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -48,6 +49,23 @@ MODULE_LICENSE("GPL");
 #define IP101A_G_IRQ_DUPLEX_CHANGE	BIT(1)
 #define IP101A_G_IRQ_LINK_CHANGE	BIT(0)
 
+#define IP101G_DIGITAL_IO_SPEC_CTRL			0x1d
+#define IP101G_DIGITAL_IO_SPEC_CTRL_SEL_INTR32		BIT(2)
+
+/* The 32-pin IP101GR package can re-configure the mode of the RXER/INTR_32 pin
+ * (pin number 21). The hardware default is RXER (receive error) mode. But it
+ * can be configured to interrupt mode manually.
+ */
+enum ip101gr_sel_intr32 {
+	IP101GR_SEL_INTR32_KEEP,
+	IP101GR_SEL_INTR32_INTR,
+	IP101GR_SEL_INTR32_RXER,
+};
+
+struct ip101a_g_phy_priv {
+	enum ip101gr_sel_intr32 sel_intr32;
+};
+
 static int ip175c_config_init(struct phy_device *phydev)
 {
 	int err, i;
@@ -184,14 +202,64 @@ static int ip175c_config_aneg(struct phy_device *phydev)
 	return 0;
 }
 
+static int ip101a_g_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct ip101a_g_phy_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (device_property_read_bool(dev, "icplus,select-rx-error"))
+		priv->sel_intr32 = IP101GR_SEL_INTR32_RXER;
+	else if (device_property_read_bool(dev, "icplus,select-interrupt"))
+		priv->sel_intr32 = IP101GR_SEL_INTR32_INTR;
+	else
+		priv->sel_intr32 = IP101GR_SEL_INTR32_KEEP;
+
+	phydev->priv = priv;
+
+	return 0;
+}
+
 static int ip101a_g_config_init(struct phy_device *phydev)
 {
-	int c;
+	struct ip101a_g_phy_priv *priv = phydev->priv;
+	int err, c;
 
 	c = ip1xx_reset(phydev);
 	if (c < 0)
 		return c;
 
+	/* configure the RXER/INTR_32 pin of the 32-pin IP101GR if needed: */
+	switch (priv->sel_intr32) {
+	case IP101GR_SEL_INTR32_RXER:
+		err = phy_modify(phydev, IP101G_DIGITAL_IO_SPEC_CTRL,
+				 IP101G_DIGITAL_IO_SPEC_CTRL_SEL_INTR32, 0);
+		if (err < 0)
+			return err;
+		break;
+
+	case IP101GR_SEL_INTR32_INTR:
+		err = phy_modify(phydev, IP101G_DIGITAL_IO_SPEC_CTRL,
+				 IP101G_DIGITAL_IO_SPEC_CTRL_SEL_INTR32,
+				 IP101G_DIGITAL_IO_SPEC_CTRL_SEL_INTR32);
+		if (err < 0)
+			return err;
+		break;
+
+	default:
+		/* Don't touch IP101G_DIGITAL_IO_SPEC_CTRL because it's not
+		 * documented on IP101A and it's not clear whether this would
+		 * cause problems.
+		 * For the 32-pin IP101GR we simply keep the SEL_INTR32
+		 * configuration as set by the bootloader when not configured
+		 * to one of the special functions.
+		 */
+		break;
+	}
+
 	/* Enable Auto Power Saving mode */
 	c = phy_read(phydev, IP10XX_SPEC_CTRL_STATUS);
 	c |= IP101A_G_APS_ON;
@@ -257,6 +325,7 @@ static struct phy_driver icplus_driver[] = {
 	.name		= "ICPlus IP101A/G",
 	.phy_id_mask	= 0x0ffffff0,
 	.features	= PHY_BASIC_FEATURES,
+	.probe		= ip101a_g_probe,
 	.config_intr	= ip101a_g_config_intr,
 	.did_interrupt	= ip101a_g_did_interrupt,
 	.ack_interrupt	= ip101a_g_ack_interrupt,
-- 
2.19.1

