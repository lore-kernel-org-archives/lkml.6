Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1055825-1523541401-2-17748237911573538540
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
    1523541400; b=Zs8viJ76veyrig6I7wocKJj2ShSn2z4fnSSNDw8vB9AiDRZszD
    vZkW7i8Ikdq5Y1va/FegFsDHViU/ynsA7xrWj3bqBNcwhH6B4uMVBuMs1bM/1N/k
    DF3EpEGcrn8yaiHJtVpkOsVgkO/Tf62jqemOuSQY6pBD1XJyVwrXUjyJOtkFMUC8
    iG7EqU/I/gnBaIWDFq8SThlVboU5veG3AR8b+0bQnhPgieAG26fDAtaevfWPtjd8
    jc4zs0Di9kU8QpqF8Ij87LCRPtnmnB38ZIMBBynr7t3JSHMs9GrIYMsZa/cXYxPz
    590axCIzlMwqum4wVhjy+j9S3ls5zTbHbyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523541400; bh=
    r+uT/Fu4OIlLT3K/6VmwBSZyPcNuKPYyHbW5AzteV84=; b=YzuGMOFuUnzTDuml
    TzXc/7TVlvHPfgHpcijQBVWgXUo5SNhUlRW/4xLxYX9K+E4HDhSQ+ceWA58w7E9O
    rL3GkAQLH8VCr/9PeL19Gu2qHmA0dRr9YtB5cit+kMsHKM/l1rseqvoPy2GZOIzV
    EbMx7PAns5S4IN4Buy/tWpES12u7L7zxNfiXKZIIF62aZyc47HXT3HhbCr5cdP7W
    E6c4B5H3/2Jx1C30UmHHV2eIrFJiJvZ6yd1aqQfNasrrd65tl99qrhfNtOEHfrvH
    ken41tEge60yfoRATmJQ0zkjJ8/Pko4BTf3tl7CXM3emMfMtZz8477dteAEAdKpi
    srXxZA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=DEQPuLVL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=Upghw51M x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=loCThmuc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=DEQPuLVL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=Upghw51M x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=loCThmuc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN7ex3SATrcbOMvVWdp/YBu82pB8K8JCGfGN0BJ1KvH+eDJoXI1aMv/MGco4wzFuYldeWPkYxq2WZN573uiCwi0TWOvwpL59Oa/lGT6ADFUAJ6wyF46A
    Fil1WqHl6rC/uN1xEsqOQmqsKOcCskzQp1ttkim8MSK/KE8WbSp/dqVow/Bp8GHz0UaMOgT1jhUkf2zGDuRR+QimFPAAWyoe6+kgJEYvpP9dF9A5Hi7iEsxH
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=VwQbUJbxAAAA:8 a=Rv0l-qJOiZx3OMaltcMA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDLNz4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 09:55:56 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:40376 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752469AbeDLNzx (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 12 Apr 2018 09:55:53 -0400
X-Google-Smtp-Source: AIpwx4/I13SRLBBXPdxRhv1YW8FnZT7+Fhb71U4UYlbjKF1BkerMW/L0h0GOs3+H6I6z6iSoynMkUg==
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
Subject: [PATCH 3/4] lan78xx: Read LED modes from Device Tree
Date: Thu, 12 Apr 2018 14:55:35 +0100
Message-Id: <1523541336-145953-4-git-send-email-phil@raspberrypi.org>
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

Add support for DT property "microchip,led-modes", a vector of two
cells (u32s) in the range 0-15, each of which sets the mode for one
of the two LEDs. Some possible values are:

    0=link/activity          1=link1000/activity
    2=link100/activity       3=link10/activity
    4=link100/1000/activity  5=link10/1000/activity
    6=link10/100/activity    14=off    15=on

Also use the presence of the DT property to indicate that the
LEDs should be enabled - necessary in the event that no valid OTP
or EEPROM is available.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/net/usb/lan78xx.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index d98397b..ffb483d 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2008,6 +2008,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 {
 	int ret;
 	u32 mii_adv;
+	u32 led_modes[2];
 	struct phy_device *phydev;
 
 	phydev = phy_find_first(dev->mdiobus);
@@ -2097,6 +2098,25 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		(void)lan78xx_set_eee(dev->net, &edata);
 	}
 
+	if (!of_property_read_u32_array(dev->udev->dev.of_node,
+					"microchip,led-modes",
+					led_modes, ARRAY_SIZE(led_modes))) {
+		u32 reg;
+		int i;
+
+		reg = phy_read(phydev, 0x1d);
+		for (i = 0; i < ARRAY_SIZE(led_modes); i++) {
+			reg &= ~(0xf << (i * 4));
+			reg |= (led_modes[i] & 0xf) << (i * 4);
+		}
+		(void)phy_write(phydev, 0x1d, reg);
+
+		/* Ensure the LEDs are enabled */
+		lan78xx_read_reg(dev, HW_CFG, &reg);
+		reg |= HW_CFG_LED0_EN_ | HW_CFG_LED1_EN_;
+		lan78xx_write_reg(dev, HW_CFG, reg);
+	}
+
 	genphy_config_aneg(phydev);
 
 	dev->fc_autoneg = phydev->autoneg;
-- 
2.7.4

