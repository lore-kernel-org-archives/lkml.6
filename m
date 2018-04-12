Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1055825-1523541445-2-3973537825697111409
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
    1523541445; b=w8CfsxSuuuY+ivGvKHvlwYHVY5rzXojNC1Uv7Me0JFmcV1rbFB
    8VZh2ee56yzl8s03uxW9fAikeU5dYuE4ZOZ5ZE58q43W1teOKJc7QrzAqR/0F2gV
    c5v5ntlsUsmf8JX04p5/Nqwxz8V5+2VYkhgmRMdVi/C2ZO9Tg5trgrhMLAI83ye7
    kzrCvztaIqvc4hVu5YYGky4x9DNvIpYXGBI0y/pzUWk60raFhq5rjhVl8qnYdNXv
    ICvo6Q7Om+G1IJxIyhUMcdaDSi5uV+otjWJfGh2myyY+Gui6QOBHWptkmcyT0nEw
    YGwjNuu6bG36xMyQ0VM6Ioklnm24Lo/1xSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523541445; bh=
    jAIqk8w2Ay7mUkhm7dVfWGjshIQFOYG/caFWTUPyOQo=; b=fXdBU+7ZbE8g7Msg
    6LOgDGR7YrTW5kCYaUrr0/01eVXHqiiRB7hIr+5IteRUYrMM7V/9dUEhh/sfwth1
    OFIpXRpirTz1acIW6hrgvJ0H8jZj6MPnuyX2sPnQg+FuJjvhhcU9gACTbxQljN1x
    MiaU+wBCNQcYCbZ2HY9jJZf1VdSz2bkNZR9LFlj5Y8gzbqOI8M0nEFkw0MQTU8Qv
    5b3YfxNRRN7+EyLGeFYAChmE32TlMtBgdrDojAzrYHIzFZyPDR75J6JgX7DRo8mM
    RUf4SI9OKF6GpeQ2W2HRIifI9P3+8nXXq9vWIJ6l7YeR0Ewd6NB+CQ4pYblOnjsu
    XphMRQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=JA1iweld x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=MZBNz9Lo x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ttQ5lJYr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=JA1iweld x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=MZBNz9Lo x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ttQ5lJYr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLKZCPo8d+KyrSsz03F3MBy0ncX7gVGM0Pz43aZ7sNdL8TT1BlnnnUlsioZMBYMXp4xs+uN2WKSpBl9s9TbqwACRgunZ3jrEv0dac9U0gzrCws9rcqA2
    bRvq5Gje7k5IM2FvULuG2zv0uZKfw8Kmbu8dgkc+xx3SA9lXC1WADvE23Cx92GfJ5+afOMlD0guF6Gdq5o3KluFgTJ1+ihDJeW5nrwkdg2gGpH7LBtS2bb5+
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=t1SWG2IIN98EioMOmmAA:9
    a=LKc_HMSrIGDSxEuJ:21 a=atpsK4A-0hmYneNR:21 a=x8gzFH9gYPwA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeDLN5V (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 09:57:21 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:31869 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752428AbeDLNzu (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 12 Apr 2018 09:55:50 -0400
X-Google-Smtp-Source: AIpwx48KIEnmbig7Yilk62E+ISZrDFoK7qo83QTD8+vwFgrEeN8krpAIuIuZrcCAT16UJWHm2ECWlA==
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
Subject: [PATCH 1/4] lan78xx: Read MAC address from DT if present
Date: Thu, 12 Apr 2018 14:55:33 +0100
Message-Id: <1523541336-145953-2-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
References: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_07:,,
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
 drivers/net/usb/lan78xx.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 55a78eb..d2727b5 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -37,6 +37,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/microchipphy.h>
 #include <linux/phy.h>
+#include <linux/of_net.h>
 #include "lan78xx.h"
 
 #define DRIVER_AUTHOR	"WOOJUNG HUH <woojung.huh@microchip.com>"
@@ -1651,34 +1652,35 @@ static void lan78xx_init_mac_address(struct lan78xx_net *dev)
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
+		const u8 *mac_addr;
 
-			addr_lo = addr[0] | (addr[1] << 8) |
-				  (addr[2] << 16) | (addr[3] << 24);
-			addr_hi = addr[4] | (addr[5] << 8);
-
-			ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
-			ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
+		mac_addr = of_get_mac_address(dev->udev->dev.of_node);
+		if (mac_addr) {
+			/* valid address present in Device Tree */
+			ether_addr_copy(addr, mac_addr);
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

