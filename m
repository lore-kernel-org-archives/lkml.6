Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-705158-1524066371-2-9655940235584000151
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
    1524066370; b=bSzVY4NpCCA0PiSby8HzlPqSe+rv7HXmu1f/LNfE+X3SMh7XzV
    s2ograGEQmJ3BzQJ9Vczp4TInCuFHl3fSoRT53/Np2ADSg3rdT/BkyLe2b4rw1/i
    4vdy1EgdlfzaR75bRIheq9P1riKBjpbsjzgtwQmAH/Tidp4TgNFvwheojLNo8OQT
    IaapUxYGeTMqD3fIOvPPekZlmsMrG9hESfEBe6S2bGqYY+p1KbyvlFFq0qz2sChj
    AxvZqRX1vcUFLZ0DXJD6jmjgbAJIdFuRPng1Ekhad+mzkr229oyL7pwzquotMaHe
    NRhAV2u5LJt9gRllDED10LkhnOcGGhiE3F/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524066370; bh=
    83Wzvq174Cf2bB+KE6CMITP9QFH2DtyLGuUYMtN1JKE=; b=vzezDpvixqtcTyaq
    BAUg1cl2vLZBkufNqlOiT0VwqVer/jsPROYBQB9Rri53ufE8N5y+RT8TgiUq0qAy
    apsKQpUlR21w3pGlWaN/cTiCYC6Kv0fd3qr8PX8JVvLqatP+MnujuDXLTXM3YHD9
    gbnKX4q2O+ZQc5Vu3l0v8MRoNw+AuBfMs3VDHDVFVwJDwWlfmGn7mMAxo/TE+bev
    EF4+dVcmogXOTkM1AL4enhiMSfUBywfBHDDrFh4qGWL5ENsXMH5qJUzHkOQFD/LN
    nJ7By1jJF/SJe4oLJHueppfFUS4iWlvZuZvwaC6t7z22VSBAU066xMh66sbqdMg+
    oG04TQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=s7VJWtnv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=xPukQPD9 x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jU1/Ac8t;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=s7VJWtnv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=xPukQPD9 x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jU1/Ac8t;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGq8Yg979VT8NONWBmj0qSaSRd/3j1qm06SEaAxBKy6WnoTZq8xGfOLtIEBd50HJgeiZ113XvxGvvd8p8XsuGZeFDAZmWAhFaNsGzG1NBgfF5eGAQ83f
    +410kO+/VCz6NEAwg30WWRF1RRwbGiH1/nfH+4OwXziKi29+MjOTT85Fbrn/xEr9iHsAvqFF2kpHAJgD3VKcI252cZtMFdgEOynYGrvgksO3OQgoabhERMa0
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=rR3N6wF2ypCZ4i_Y_DoA:9
    a=jxZx6lgZFPa5cjI9:21 a=72gBT8irSmoT_CpO:21 a=x8gzFH9gYPwA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbeDRPpl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 11:45:41 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:5767 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753941AbeDRPpg (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 18 Apr 2018 11:45:36 -0400
X-Google-Smtp-Source: AIpwx49FepXo2Ntwt7KsxmxmYBtFYPcqZlnz5SczesDyBo6RXY/u12twqLnYs4F47NypoTfr8b45YQ==
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
Subject: [PATCH v2 3/3] dt-bindings: Document the DT bindings for lan78xx
Date: Wed, 18 Apr 2018 16:45:23 +0100
Message-Id: <1524066323-109628-4-git-send-email-phil@raspberrypi.org>
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

The Microchip LAN78XX family of devices are Ethernet controllers with
a USB interface. Despite being discoverable devices it can be useful to
be able to configure them from Device Tree, particularly in low-cost
applications without an EEPROM or programmed OTP.

Document the supported properties in a bindings file.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 .../devicetree/bindings/net/microchip,lan78xx.txt  | 44 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt

diff --git a/Documentation/devicetree/bindings/net/microchip,lan78xx.txt b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
new file mode 100644
index 0000000..fa68f9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
@@ -0,0 +1,44 @@
+Microchip LAN78xx Gigabit Ethernet controller
+
+The LAN78XX devices are usually configured by programming their OTP or with
+an external EEPROM, but some platforms (e.g. Raspberry Pi 3 B+) have neither.
+The Device Tree properties, if present, override the OTP and EEPROM.
+
+Required properties:
+- compatible: Should be one of "usb424,7800", "usb424,7801" or "usb424,7850".
+
+Optional properties:
+- local-mac-address:   see ethernet.txt
+- mac-address:         see ethernet.txt
+- microchip,led-modes: a 0..4 element vector, with each element configuring
+  the operating mode of an LED. Omitted LEDs are turned off. Allowed values
+  are defined in "include/dt-bindings/net/microchip-78xx.h".
+
+Example:
+
+/* Standard configuration for a Raspberry Pi 3 B+ */
+&usb {
+	usb1@1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb1_1@1 {
+			compatible = "usb424,2514";
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ethernet: usbether@1 {
+				compatible = "usb424,7800";
+				reg = <1>;
+				local-mac-address = [ 00 11 22 33 44 55 ];
+				microchip,led-modes = <
+					LAN78XX_LINK_1000_ACTIVITY
+					LAN78XX_LINK_10_100_ACTIVITY
+				>;
+			};
+		};
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 9c9bc63..5352bbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14572,6 +14572,7 @@ M:	Woojung Huh <woojung.huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/microchip,lan78xx.txt
 F:	drivers/net/usb/lan78xx.*
 F:	include/dt-bindings/net/microchip-78xx.h
 
-- 
2.7.4

