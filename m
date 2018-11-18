Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2BEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C225208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PdNEUxHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C225208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeKSHpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:45:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38777 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbeKSHpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:45:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id e3-v6so29963978wrs.5;
        Sun, 18 Nov 2018 13:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVAxFp5X4mpzjt3Nh1E/gfpgmeABdZs1CUdVie96+vM=;
        b=PdNEUxHDq2nWlrjoxOm5peVfCv/lxnvA0zElH6tNgOoMIs7e10ITu+JiospSLitDCa
         4UmGF7keeMoClGR88jBdTiHWQjc+xIbpAsjhDVp0PSCX7VDXbRUBWSknDujhvXSvSJ4m
         Fnyh5kfDTUw98PxNlyiKmealIQiYrGKcQ+06XHtFqcT2xTzrghpoI61yadbU2TgTtRF0
         hVWqWtefCNFvcBaA5MZZ20qVZTX6ef0/fPAp0xNY/u8DRlGbIR+MA/6m0vScSdkxS8ih
         DqVbYvTHCAHszuY2rLZWu0toERYOx630FONoHcnLaE6MVoIsUlSqBysXQ3xkfEpigQna
         D4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVAxFp5X4mpzjt3Nh1E/gfpgmeABdZs1CUdVie96+vM=;
        b=SJSyQxxKfLSlQUlHFmrGLe6Jngj+hAOicvJ1mzRs4WpqEIgozT5kI27HoQxvd0oR9z
         dm4J6sk32Z2WCKqEsG+oadwP35XGd8dWDPcZu4DTdORt50hQQbweNmxOunD0rTPV1ROb
         uQf0zBNVhG1WSFR5D37xizxaTXbjlJnKIDyltyXPSMplSpRyFx3ecd+BySAFY6iF4zYa
         BwKM4fH9qWpVnIuBwTC0/pcIBvIcc8BB6ah5p9VTMhIqOiOA877UJGH5e0u8pva82AtN
         XRBql4TLSYHIDzuHx36CeE8KQg/ODsErfhVbBjqwTHmlBdiWWq0EKCzguAs7spF7D+Z4
         T3cg==
X-Gm-Message-State: AA+aEWYdixXObkuCw4nXbHqWsUiTXtUwynmwoaTkwmQ4IPkSJ2sOdQjt
        Ihp5IBdjZSLsOQl4qNPT8TdyYGDbXsE=
X-Google-Smtp-Source: AFSGD/VSaqPQ5U/O544tiCIt+L6Xb0lihmm7tXtjq9xA7vn+/w2PgS6nQjEIxSGgulbsOJ1TzSuJkg==
X-Received: by 2002:adf:9dd2:: with SMTP id q18mr8124826wre.12.1542576260109;
        Sun, 18 Nov 2018 13:24:20 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A10029D7537EB9A16C22.dip0.t-ipconnect.de. [2003:dc:d717:a100:29d7:537e:b9a1:6c22])
        by smtp.googlemail.com with ESMTPSA id d4sm31835649wrp.89.2018.11.18.13.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 13:24:19 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, mark.rutland@arm.com,
        robh+dt@kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 7/7] net: phy: icplus: allow configuring the interrupt function on IP101GR
Date:   Sun, 18 Nov 2018 22:23:59 +0100
Message-Id: <20181118212359.32414-8-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
References: <20181118212359.32414-1-martin.blumenstingl@googlemail.com>
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
- error out if conflicting configuration is given (RXER and INTR32 mode
  are enabled at the same time)

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/phy/icplus.c | 81 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/icplus.c b/drivers/net/phy/icplus.c
index 3dc8bbbe746b..7d5938b87660 100644
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
@@ -184,14 +202,74 @@ static int ip175c_config_aneg(struct phy_device *phydev)
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
+	/* Both functions (RX error and interrupt status) are sharing the same
+	 * pin on the 32-pin IP101GR, so this is an exclusive choice.
+	 */
+	if (device_property_read_bool(dev, "icplus,select-rx-error") &&
+	    device_property_read_bool(dev, "icplus,select-interrupt")) {
+		dev_err(dev,
+			"RXER and INTR mode cannot be selected together\n");
+		return -EINVAL;
+	}
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
@@ -257,6 +335,7 @@ static struct phy_driver icplus_driver[] = {
 	.name		= "ICPlus IP101A/G",
 	.phy_id_mask	= 0x0ffffff0,
 	.features	= PHY_BASIC_FEATURES,
+	.probe		= ip101a_g_probe,
 	.config_intr	= ip101a_g_config_intr,
 	.did_interrupt	= ip101a_g_did_interrupt,
 	.ack_interrupt	= ip101a_g_ack_interrupt,
-- 
2.19.1

