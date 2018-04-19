Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3414120-1524151178-2-2378524605170965623
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524151177; b=KKDgo+759Xzw9ZOdNd+hdc2RJmU7m3a39xkMVgf+NyArx3DAiF
    CrvPgI0fVFlMFFCEfGue+ywauTcYns+g1HFRmNv2+f7L2A2GvhLk6x01AthBziXF
    U075nFNecO6mPdGBsxtdeyjuJ5n3M3kAiqe66jvOfOS50fD22HfkccYuRLnlXCYx
    ogDzsLtLUHsYcRUg0j6jx8FerthQBGfMPAAzSS8QUI+WbH+ogOBl9QrF0owbvqeX
    GLeA+Hx9iAsVQCjAt7T4ZPNtidZI5nIGZlh3ciPf33eJQglSRnK9huVGriq15niQ
    3kJ9tD8f9l3VVN6VIlLuSMuVdVAcFsyOdvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524151177; bh=
    J7k2HZG3P72DbHAzIwow9xNVFxB0Bb55S7ZbD5VM3QA=; b=lVCtD8pnl0wR7kpw
    d1vdJK/jJcVK73R9C+p+ciGex6Nv4CZdo8KnJTnkXvdu3Q/VuE3CrseysGd0UvbN
    Fcg4sKlzt0rWiMZfj7X+n4Brb1ARc6XYTVtwQn17UwVghC5X0rCmqcQ3ijh0JwJZ
    wD5/FCxDl5Uvr5BfgE/sKdqvejwESzl3QQhNSWBvqNmEHlfAQEeW5pm3PH/h0bd0
    zXnqoorRnuEnv2ptFsWru1bs0Y3qSSafAyN92b7B2U9UNF0J3H1c+CCLvf8DgO9n
    LyI6FjGZnrQCbaEHzqdT9S71hlH3cSP3CnZxAd76JAo0jkHzgAL/pyPiNKXXgLxF
    3cFe2Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=cS2ahNP+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=pwe2Zxhs x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uV0uLqEX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=cS2ahNP+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=pwe2Zxhs x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uV0uLqEX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPHUiMjfgK1oj45i+RkPF6trf68Gq/INPkIAEB+MFkoomgDWHCMxT36l7QzliGzF3C6nk78K7/zlkM7B2se0d76StmGj8tJKYq+Bf9e7C4rBI/x7g+zi
    zjKjr9to8cXceqG4pbIrnAX/t7DoNksnDLddh5+NA/56ggpyeUUGH26uLeBRBYJO8pehJ6sbSotELJc+VcpbtOx1HeDhwzEyidFf6OKp9+UIcNzURNh+Tm3Y
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=w00BvIrj0aWh6mdj-2AA:9
    a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbeDSPTS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 11:19:18 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:41725 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752765AbeDSPSF (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 19 Apr 2018 11:18:05 -0400
X-Google-Smtp-Source: AIpwx4+hCo5WeQ0Cc5Eca4ozYQqCXEg3wh060uCM4CB2gsVFovYtj89Ohw3unORKRukD6iY2YvWfrA==
From: Phil Elwell <phil@raspberrypi.org>
To: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Phil Elwell <phil@raspberrypi.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH resend v3 2/3] lan78xx: Read LED states from Device Tree
Date: Thu, 19 Apr 2018 16:16:58 +0100
Message-Id: <1524151019-82823-3-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524151019-82823-1-git-send-email-phil@raspberrypi.org>
References: <1524151019-82823-1-git-send-email-phil@raspberrypi.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add support for DT property "microchip,led-modes", a vector of zero
to four cells (u32s) in the range 0-15, each of which sets the mode
for one of the LEDs. Some possible values are:

    0=link/activity          1=link1000/activity
    2=link100/activity       3=link10/activity
    4=link100/1000/activity  5=link10/1000/activity
    6=link10/100/activity    14=off    15=on

These values are given symbolic constants in a dt-bindings header.

Also use the presence of the DT property to indicate that the
LEDs should be enabled - necessary in the event that no valid OTP
or EEPROM is available.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 MAINTAINERS                                 |  1 +
 drivers/net/phy/microchip.c                 | 25 ++++++++++++++++++++++
 drivers/net/usb/lan78xx.c                   | 32 ++++++++++++++++++++++++++++-
 include/dt-bindings/net/microchip-lan78xx.h | 21 +++++++++++++++++++
 include/linux/microchipphy.h                |  3 +++
 5 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/net/microchip-lan78xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b60179d..23735d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14573,6 +14573,7 @@ M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/usb/lan78xx.*
+F:	include/dt-bindings/net/microchip-lan78xx.h
 
 USB MASS STORAGE DRIVER
 M:	Alan Stern <stern@rowland.harvard.edu>
diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index 0f293ef..ef5e160 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -20,6 +20,8 @@
 #include <linux/ethtool.h>
 #include <linux/phy.h>
 #include <linux/microchipphy.h>
+#include <linux/of.h>
+#include <dt-bindings/net/microchip-lan78xx.h>
 
 #define DRIVER_AUTHOR	"WOOJUNG HUH <woojung.huh@microchip.com>"
 #define DRIVER_DESC	"Microchip LAN88XX PHY driver"
@@ -70,6 +72,8 @@ static int lan88xx_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
 	struct lan88xx_priv *priv;
+	u32 led_modes[4];
+	int len;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -77,6 +81,27 @@ static int lan88xx_probe(struct phy_device *phydev)
 
 	priv->wolopts = 0;
 
+	len = of_property_read_variable_u32_array(dev->of_node,
+						  "microchip,led-modes",
+						  led_modes,
+						  0,
+						  ARRAY_SIZE(led_modes));
+	if (len >= 0) {
+		u32 reg = 0;
+		int i;
+
+		for (i = 0; i < len; i++) {
+			if (led_modes[i] > 15)
+				return -EINVAL;
+			reg |= led_modes[i] << (i * 4);
+		}
+		for (; i < ARRAY_SIZE(led_modes); i++)
+			reg |= LAN78XX_FORCE_LED_OFF << (i * 4);
+		(void)phy_write(phydev, LAN78XX_PHY_LED_MODE_SELECT, reg);
+	} else if (len == -EOVERFLOW) {
+		return -EINVAL;
+	}
+
 	/* these values can be used to identify internal PHY */
 	priv->chip_id = phy_read_mmd(phydev, 3, LAN88XX_MMD3_CHIP_ID);
 	priv->chip_rev = phy_read_mmd(phydev, 3, LAN88XX_MMD3_CHIP_REV);
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a823f01..6b03b97 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -37,6 +37,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/microchipphy.h>
 #include <linux/phy.h>
+#include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include "lan78xx.h"
 
@@ -1760,6 +1761,7 @@ static int lan78xx_mdiobus_write(struct mii_bus *bus, int phy_id, int idx,
 
 static int lan78xx_mdio_init(struct lan78xx_net *dev)
 {
+	struct device_node *node;
 	int ret;
 
 	dev->mdiobus = mdiobus_alloc();
@@ -1788,7 +1790,13 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
 		break;
 	}
 
-	ret = mdiobus_register(dev->mdiobus);
+	node = of_get_child_by_name(dev->udev->dev.of_node, "mdio");
+	if (node) {
+		ret = of_mdiobus_register(dev->mdiobus, node);
+		of_node_put(node);
+	} else {
+		ret = mdiobus_register(dev->mdiobus);
+	}
 	if (ret) {
 		netdev_err(dev->net, "can't register MDIO bus\n");
 		goto exit1;
@@ -2077,6 +2085,28 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 	mii_adv = (u32)mii_advertise_flowctrl(dev->fc_request_control);
 	phydev->advertising |= mii_adv_to_ethtool_adv_t(mii_adv);
 
+	if (phydev->mdio.dev.of_node) {
+		u32 reg;
+		int len;
+
+		len = of_property_count_elems_of_size(phydev->mdio.dev.of_node,
+						      "microchip,led-modes",
+						      sizeof(u32));
+		if (len >= 0) {
+			/* Ensure the appropriate LEDs are enabled */
+			lan78xx_read_reg(dev, HW_CFG, &reg);
+			reg &= ~(HW_CFG_LED0_EN_ |
+				 HW_CFG_LED1_EN_ |
+				 HW_CFG_LED2_EN_ |
+				 HW_CFG_LED3_EN_);
+			reg |= (len > 0) * HW_CFG_LED0_EN_ |
+				(len > 1) * HW_CFG_LED1_EN_ |
+				(len > 2) * HW_CFG_LED2_EN_ |
+				(len > 3) * HW_CFG_LED3_EN_;
+			lan78xx_write_reg(dev, HW_CFG, reg);
+		}
+	}
+
 	genphy_config_aneg(phydev);
 
 	dev->fc_autoneg = phydev->autoneg;
diff --git a/include/dt-bindings/net/microchip-lan78xx.h b/include/dt-bindings/net/microchip-lan78xx.h
new file mode 100644
index 0000000..0742ff0
--- /dev/null
+++ b/include/dt-bindings/net/microchip-lan78xx.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DT_BINDINGS_MICROCHIP_LAN78XX_H
+#define _DT_BINDINGS_MICROCHIP_LAN78XX_H
+
+/* LED modes for LAN7800/LAN7850 embedded PHY */
+
+#define LAN78XX_LINK_ACTIVITY           0
+#define LAN78XX_LINK_1000_ACTIVITY      1
+#define LAN78XX_LINK_100_ACTIVITY       2
+#define LAN78XX_LINK_10_ACTIVITY        3
+#define LAN78XX_LINK_100_1000_ACTIVITY  4
+#define LAN78XX_LINK_10_1000_ACTIVITY   5
+#define LAN78XX_LINK_10_100_ACTIVITY    6
+#define LAN78XX_DUPLEX_COLLISION        8
+#define LAN78XX_COLLISION               9
+#define LAN78XX_ACTIVITY                10
+#define LAN78XX_AUTONEG_FAULT           12
+#define LAN78XX_FORCE_LED_OFF           14
+#define LAN78XX_FORCE_LED_ON            15
+
+#endif
diff --git a/include/linux/microchipphy.h b/include/linux/microchipphy.h
index eb492d4..8e4015e 100644
--- a/include/linux/microchipphy.h
+++ b/include/linux/microchipphy.h
@@ -70,4 +70,7 @@
 #define	LAN88XX_MMD3_CHIP_ID			(32877)
 #define	LAN88XX_MMD3_CHIP_REV			(32878)
 
+/* Registers specific to the LAN7800/LAN7850 embedded phy */
+#define LAN78XX_PHY_LED_MODE_SELECT		(0x1D)
+
 #endif /* _MICROCHIPPHY_H */
-- 
2.7.4

