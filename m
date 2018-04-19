Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3613687-1524157273-2-7133947533507821192
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
    1524157273; b=qnBPeLk2I/jCTKkLSchQwqschi72F78k5lAhVFIyhJdUwa/QRw
    f5GYE3PL/zVf+65kB18e+mYPpYpxt2PnBAu7L22jAR4lPgGf4KmG6XWP6QtC3Ly8
    znCNxxu2NsDPHsOh0Y2M5rtQ7reSglaDXEG09DtpJNWaMEKcPnvTOI1UM/WQ4+XX
    1PVPN/+BIQnLqWQewm7kpdZDIa3QBYZqrZG9Yqg7tVCiCqdfqaLdrCEnmHpRt6FM
    7gFIu9tgZPvsR0jy466G0ojs6XSIxjwifKCb1IzedW8DywHc7Xc4C/wp3WNPkIs9
    5tbH0NH2FrCf7MfjGkonh80Jkq6J4Ew0ZN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524157273; bh=
    d/Ngm5ybOIDbEO6Gtt52uCXXwH/YNeTdCRectghgtpc=; b=A5gcrDSt8SA7qSrE
    +ql2HjvAczBQvbT3bo5B8oOgAWk2zBAFc/t1LI35c2V7RtxEYSPS373Sxii5a79y
    X53mwV/UEttl5CEjjtpqZQXVM/ziE9IpxiTe7yeUBOv/CVziMTf8/pK8fIl48vVc
    GyNp9clZ7E3TE47l1eU+UuL8p9NC0LPTIqHHNHbLb4FC4L4tImGctvxGIqznn1CY
    BVSnu2JXMOYd11BAx4xlyW6yDQoQflxBPaVW/dkqgTZTr4RlLcJCR+qS3uGMj1Ej
    pZLAs06dCSjtaygUly0pGmcOaOe1y5UNRIdW8nW6zsjqS8Z/lidx0rd1WI6PMRq2
    PLRfZQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=PSfskWQo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=h+m/pICT x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X88kmH31;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=PSfskWQo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=h+m/pICT x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X88kmH31;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCt7ZPcr721Jt3wEtv6Y7SN35ozdmBqGn4wKKZxP9SelpicyfSGDMAU2wfwxPxn0g62q2ivaVOu0r8+57OWLw/RGVvi2JnPkuzo5e80TDbGIHTnAztVd
    nnpE07TENYUzzTFWsvlUW/owKud7fkSn+7m05vPRud18EpbUXhTF4OLVtCZWqQMf+1hODQKgGThZydqWATlE5xPgv3PkQ3GH7r4nHWHgYkKezmRmLwjiEUNP
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=zRq2MqN_qeGhU6OCN1IA:9
    a=bURvOVKSVW1xKLNO:21 a=uWAfTbR6BzG1SPmn:21 a=x8gzFH9gYPwA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753579AbeDSRBF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 13:01:05 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:33758 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753503AbeDSRAN (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 19 Apr 2018 13:00:13 -0400
X-Google-Smtp-Source: AIpwx48t81/ZHBPmtlMLnRM/K7nG4gEMtxJoXIQcPcLLDePImwipLar5P+eF/3swVC4AGkih8HjSnA==
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
Subject: [PATCH v4 3/3] dt-bindings: Document the DT bindings for lan78xx
Date: Thu, 19 Apr 2018 17:59:40 +0100
Message-Id: <1524157180-27276-4-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524157180-27276-1-git-send-email-phil@raspberrypi.org>
References: <1524157180-27276-1-git-send-email-phil@raspberrypi.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/net/microchip,lan78xx.txt  | 54 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt

diff --git a/Documentation/devicetree/bindings/net/microchip,lan78xx.txt b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
new file mode 100644
index 0000000..76786a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
@@ -0,0 +1,54 @@
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
+
+Optional properties of the embedded PHY:
+- microchip,led-modes: a 0..4 element vector, with each element configuring
+  the operating mode of an LED. Omitted LEDs are turned off. Allowed values
+  are defined in "include/dt-bindings/net/microchip-lan78xx.h".
+
+Example:
+
+/* Based on the configuration for a Raspberry Pi 3 B+ */
+&usb {
+	usb-port@1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb-port@1 {
+			compatible = "usb424,2514";
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ethernet: ethernet@1 {
+				compatible = "usb424,7800";
+				reg = <1>;
+				local-mac-address = [ 00 11 22 33 44 55 ];
+
+				mdio {
+					#address-cells = <0x1>;
+					#size-cells = <0x0>;
+					eth_phy: ethernet-phy@1 {
+						reg = <1>;
+						microchip,led-modes = <
+							LAN78XX_LINK_1000_ACTIVITY
+							LAN78XX_LINK_10_100_ACTIVITY
+						>;
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 23735d9..91cb961 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14572,6 +14572,7 @@ M:	Woojung Huh <woojung.huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/microchip,lan78xx.txt
 F:	drivers/net/usb/lan78xx.*
 F:	include/dt-bindings/net/microchip-lan78xx.h
 
-- 
2.7.4

