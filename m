Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-732471-1524066404-2-7287017519767625997
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524066403; b=NYwe+Rpf7KVGrR/Stc1MP6+Z1YUjQnocWcD1Eyswvq7/SrRE7U
    hhI5ObkXn9U5ghAfUFLo5vNyWsBNVMmEA2q5WCqX3Gyf/NieFb61pBBr89RSzkfv
    CYwxMcnmkxNY9qctk89N9Zr4dj0eGrnDfe27i4SOYxUj2uLxFm0uFSLC7IFGL+Dm
    XaPkYFqreYgPLFzeRB59szkDYwafsORr+Gd7zCJSkMPd/p+6Nn2ApG+4ERIEHxf1
    IpiAm9aYloFQ+r9HGWCJemGKtFiNJMU+J192jIMM02AZCfd/y5QRF+X9xI2q/1EP
    8tQTGNqT7nh/ftOOK08ZafGBr/K3JmqoVJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524066403; bh=
    n2Ws518Owa3IJI4hXcC0im34gO1xAMBClQVZY2WFtPc=; b=fMT9AtmJ7lkJQv3g
    uTENcpUIzgcZ5PwvQvwpCcMuTCRacYFCOMIX5qBl+Yj2gSr4gICf/egmzNLcu7jF
    aD08o2+h79xoelv6iNmrgwS272/o2U0+K4JB+DR8TDQiZSuunDcwxK1CNOHs5DIY
    jo3iQ0ApB76DunUJZmZhMZJjJ9gaw9rIjg8vs0r87m5f1gl2uvoxgucHDNTSmfDf
    ZYZfTLdqFq/spU3EyGZI0hQpfQRLeeYuPOA6ctBN40FuMaRENFqsinM1MnkDgqyf
    eU6D641BUwkT4Cy5RQRM8ophPQoZewJFIAo5mRQZnG/hUHa3dEXLkiiP/jmR4Qq6
    Grrh6w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=af4rytZs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=PwVMtgqo x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KHD0b8+7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=af4rytZs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=PwVMtgqo x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KHD0b8+7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHSjqiAizZXoZiEOCvyO2ya3slsoKETKkmc2unxnR1X681GxZ8lUFhPxzI/eQQmcXmTvHquDEgH7pyO7nuUv/ZBZPOto1iligFas1jna4uWRePUGmVGz
    M1iXdolHd0YgdEI2y87FWYLfduCeqbOBmDblKe7+XPkRUUNiWOxW3999l6yYKeziN9G3bqD+kgewoYSbZHv1K/GfTX2U9SpLm2ChHPkEwBrDl/1ybJD649Bo
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=ROtsYTQvONTiMNvWuDkA:9
    a=HoxxFJXVrSfGih9s:21 a=zI8jaF3KVClHV97Q:21 a=x8gzFH9gYPwA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeDRPqg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 11:46:36 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:18970 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753296AbeDRPpc (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 18 Apr 2018 11:45:32 -0400
X-Google-Smtp-Source: AIpwx4951zmk3Fm6Ea5OfpmMQXQjYV45XZhMoVWI8QNxAE7V++WRXq3WpU/kiBbHQtnpgRnvfUtDfg==
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
Subject: [PATCH v2 1/3] lan78xx: Read MAC address from DT if present
Date: Wed, 18 Apr 2018 16:45:21 +0100
Message-Id: <1524066323-109628-2-git-send-email-phil@raspberrypi.org>
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

There is a standard mechanism for locating and using a MAC address from
the Device Tree. Use this facility in the lan78xx driver to support
applications without programmed EEPROM or OTP. At the same time,
regularise the handling of the different address sources.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/net/usb/lan78xx.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 0867f72..a823f01 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -37,6 +37,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/microchipphy.h>
 #include <linux/phy.h>
+#include <linux/of_net.h>
 #include "lan78xx.h"
 
 #define DRIVER_AUTHOR	"WOOJUNG HUH <woojung.huh@microchip.com>"
@@ -1652,34 +1653,31 @@ static void lan78xx_init_mac_address(struct lan78xx_net *dev)
 	addr[5] = (addr_hi >> 8) & 0xFF;
 
 	if (!is_valid_ether_addr(addr)) {
-		/* reading mac address from EEPROM or OTP */
-		if ((lan78xx_read_eeprom(dev, EEPROM_MAC_OFFSET, ETH_ALEN,
-					 addr) == 0) ||
-		    (lan78xx_read_otp(dev, EEPROM_MAC_OFFSET, ETH_ALEN,
-				      addr) == 0)) {
-			if (is_valid_ether_addr(addr)) {
-				/* eeprom values are valid so use them */
-				netif_dbg(dev, ifup, dev->net,
-					  "MAC address read from EEPROM");
-			} else {
-				/* generate random MAC */
-				random_ether_addr(addr);
-				netif_dbg(dev, ifup, dev->net,
-					  "MAC address set to random addr");
-			}
-
-			addr_lo = addr[0] | (addr[1] << 8) |
-				  (addr[2] << 16) | (addr[3] << 24);
-			addr_hi = addr[4] | (addr[5] << 8);
-
-			ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
-			ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
+		if (!eth_platform_get_mac_address(&dev->udev->dev, addr)) {
+			/* valid address present in Device Tree */
+			netif_dbg(dev, ifup, dev->net,
+				  "MAC address read from Device Tree");
+		} else if (((lan78xx_read_eeprom(dev, EEPROM_MAC_OFFSET,
+						 ETH_ALEN, addr) == 0) ||
+			    (lan78xx_read_otp(dev, EEPROM_MAC_OFFSET,
+					      ETH_ALEN, addr) == 0)) &&
+			   is_valid_ether_addr(addr)) {
+			/* eeprom values are valid so use them */
+			netif_dbg(dev, ifup, dev->net,
+				  "MAC address read from EEPROM");
 		} else {
 			/* generate random MAC */
 			random_ether_addr(addr);
 			netif_dbg(dev, ifup, dev->net,
 				  "MAC address set to random addr");
 		}
+
+		addr_lo = addr[0] | (addr[1] << 8) |
+			  (addr[2] << 16) | (addr[3] << 24);
+		addr_hi = addr[4] | (addr[5] << 8);
+
+		ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
+		ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
 	}
 
 	ret = lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
-- 
2.7.4

