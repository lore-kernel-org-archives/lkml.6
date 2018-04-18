Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-732471-1524066469-2-4573027321435240132
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524066469; b=ADuxDnXz4+56Ky8CIDzGMH6DStUmTfkU4LdUH0Bmsvu/AVdFqq
    gdJcnomLeEnc553MluHq1wKuEZ/+qPmjpnD8p/tmnjewnEpiI09nj4bH37JbR5ei
    xhTqnQEuoVa0v2/EkQM6ooMZtuwtuKV+NdfK4sOUGk7LXpqimj1jLz1SYDHb6mx9
    11R9wN+FTGD8j3lzmLtWzm5CFDvq18GRrm84QMhaCFOmVtLxQaTR9nLls8A0+AHI
    9VvU3KIJt6AXU2PxOEdAkZh8CIKYf6x2icHeB+WdtYOIhNQJ5i1TVYInuqgSDLEi
    fTye3JgLRvtkEb6jp1X+7SK1ZqJr4k7bnzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524066469; bh=
    GYc1l4AIQp5AQtrFf6sg3RFz/bXzM6p3ldh6W0CyfAg=; b=uacEHw/2AhOSlZCs
    zeTigqRCkYqBPm8Ss8YvrYcNeYB5m22QZSNzju6WOJfiv8pynIOz3zmBbBS1cB1w
    dTPkPmADlKk9p7RTgS2++QldJtITU+IaTJfIL1z3vf07EGBXVfEGukWWpdiN/qa8
    OZYyYPAJGo4d5a/de1uCTWm8KJRA5fnSQfY5D3+gXy/YgAkeG+fRYYp/Evkcabk7
    3KiOyh63CINFtBnIYkeKOyNuYVOJFtjIIbC9HufzLxg8/SsRMmwxnatktbi63vnI
    ZvCfzmocz19bq0j4kd7xPq8fxy+BjZcE/5mMpwSEnpdrtUqSIlB5gYTFM+8I5ftG
    IgDS+w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=THFLmCRB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=asb3FqFU x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ShGS29kR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=THFLmCRB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=asb3FqFU x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ShGS29kR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEmNtrysUHxLrYj04VECOplAxlI2PVobZQu2tI1dhgBDqRpEhrhBiYYGv/8hdCka6aVjssl9QOY73mE3dRkTFN8mKTVqZmOmGnWVh42vE87OHoPX6LDR
    x21QCZVibT6kY2Ze8+FkJFT8P/E/tAR03GkfaCWJO0X3h2kHdc6IqoEbgO3X6byLAK5VQKy+dVxGe8ICzR/rQRnsw/w/qHcTzoDY/5N1DzddbjY/huJDa4u9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=v2Eu6r7vXz3y-6LD1LEA:9
    a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbeDRPqe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 11:46:34 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:48270 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753657AbeDRPpd (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 18 Apr 2018 11:45:33 -0400
X-Google-Smtp-Source: AIpwx48qPDz4uOcyHO1E0Zt/NqKrVqxOQ19iysfYc8bBRt8UVzmpBBa9KY0cQDOmUorUPGLMMmVSag==
From: Phil Elwell <phil@raspberrypi.org>
To: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH v2 2/3] lan78xx: Read LED states from Device Tree
Date: Wed, 18 Apr 2018 16:45:22 +0100
Message-Id: <1524066323-109628-3-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524066323-109628-1-git-send-email-phil@raspberrypi.org>
References: <1524066323-109628-1-git-send-email-phil@raspberrypi.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_03:,,
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
 MAINTAINERS                              |  1 +
 drivers/net/usb/lan78xx.c                | 35 ++++++++++++++++++++++++++++++++
 include/dt-bindings/net/microchip-78xx.h | 21 +++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 include/dt-bindings/net/microchip-78xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b60179d..9c9bc63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14573,6 +14573,7 @@ M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/usb/lan78xx.*
+F:	include/dt-bindings/net/microchip-78xx.h
 
 USB MASS STORAGE DRIVER
 M:	Alan Stern <stern@rowland.harvard.edu>
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a823f01..f47ffea 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -38,6 +38,7 @@
 #include <linux/microchipphy.h>
 #include <linux/phy.h>
 #include <linux/of_net.h>
+#include <dt-bindings/net/microchip-78xx.h>
 #include "lan78xx.h"
 
 #define DRIVER_AUTHOR	"WOOJUNG HUH <woojung.huh@microchip.com>"
@@ -74,6 +75,9 @@
 #define LAN78XX_EEPROM_MAGIC		(0x78A5)
 #define LAN78XX_OTP_MAGIC		(0x78F3)
 
+/* This register is specific to the LAN7800 and LAN7850 embedded PHYs */
+#define LAN78XX_PHY_LED_MODE_SELECT	29
+
 #define	MII_READ			1
 #define	MII_WRITE			0
 
@@ -2005,6 +2009,8 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 {
 	int ret;
 	u32 mii_adv;
+	u32 led_modes[4];
+	int len;
 	struct phy_device *phydev;
 
 	phydev = phy_find_first(dev->mdiobus);
@@ -2077,6 +2083,35 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 	mii_adv = (u32)mii_advertise_flowctrl(dev->fc_request_control);
 	phydev->advertising |= mii_adv_to_ethtool_adv_t(mii_adv);
 
+	len = of_property_read_variable_u32_array(dev->udev->dev.of_node,
+						  "microchip,led-modes",
+						  led_modes,
+						  0,
+						  ARRAY_SIZE(led_modes));
+	if (len >= 0) {
+		u32 reg = 0;
+		int i;
+
+		for (i = 0; i < len; i++) {
+			if (led_modes[i] > 15) {
+				ret = -EINVAL;
+				goto error;
+			}
+			reg |= led_modes[i] << (i * 4);
+		}
+		for (; i < ARRAY_SIZE(led_modes); i++)
+			reg |= LAN78XX_FORCE_LED_OFF << (i * 4);
+		(void)phy_write(phydev, LAN78XX_PHY_LED_MODE_SELECT, reg);
+
+		/* Ensure the LEDs are enabled */
+		lan78xx_read_reg(dev, HW_CFG, &reg);
+		reg |= HW_CFG_LED0_EN_ | HW_CFG_LED1_EN_;
+		lan78xx_write_reg(dev, HW_CFG, reg);
+	} else if (len == -EOVERFLOW) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	genphy_config_aneg(phydev);
 
 	dev->fc_autoneg = phydev->autoneg;
diff --git a/include/dt-bindings/net/microchip-78xx.h b/include/dt-bindings/net/microchip-78xx.h
new file mode 100644
index 0000000..dcf4a43
--- /dev/null
+++ b/include/dt-bindings/net/microchip-78xx.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DT_BINDINGS_MICROCHIP_LAN78XX_H
+#define _DT_BINDINGS_MICROCHIP_LAN78XX_H
+
+/* LED modes */
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
-- 
2.7.4

