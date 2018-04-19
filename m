Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274038-1524148358-2-11314618079831784115
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
    1524148357; b=sO2ZExjyQ/+rRs+pxubIJxEG7JXFX9JHkuZt6EskkzTyGSX5i7
    4K+688sEJwQKjMWp5nwBCua5/aVKb0d6dowzrd8ki6DatcDaXKUhHHnc6WTBqnNe
    6A/fLZQFME9zlCKP1OtRCaRMseaf5zgNohvMmogpShEUxlF98M7BekG19ECZjVSy
    ojnhkernPJeOVJg8oXTKyoeVrHE5iDgaI+dBSq6zADAo8I4qZF0Ie+NJrpOJqX4z
    jCekltIWbZgHIP4lS99aAiju8h7SOA28PTRTTqVm/nkbtXKacDFcHsfhbLllhtZr
    tvWv6ZDwxP/nblAaahV6xtxQtU92+Juoht0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524148357; bh=
    7pOe2kl85zuVbcN5/9ZHo+sqWDigCXbd4AZ3PhDY1R8=; b=w+XLpPtjEYw7zL9p
    lV8ACaHCeTmFTj5QyJQKyfsDZ3snEQRnQ6i6g1np1T+DbSwdjBkIr1LrGJf96llV
    Ay9qfeY09PLcqF+nOrANiVDJux6uhbSOKzW6TY7LPCsoLqJKWJxp7CsEsCHshD3Z
    j23Pn7x+WGtmO6gWXb+lGLzUBISR2eAZr8ZsiK2OStvj55cbq5/Fjzasfizz6eLn
    PKUINDhpOZvJcAWBxIacLX0ZtsGp3s7ej3pUugMhW02eq9mjB34M5tYRdNAzeoWd
    v54Pb8b9kDblVCsWbytmKLd6mF7bFX6fDZ8YyfV8K/y+vzu1t5uumEL7l9WcvVYp
    xFpkeg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=Va8S0xDM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=shDcZsAU x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YxWxDFEf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=Va8S0xDM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=shDcZsAU x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YxWxDFEf;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ7PhhWCOfBG1X2gmLVKSZrsoplaSVbRf0Mj6tod4gx9Fsin/0YPzRFhjhdQKfTL1Hghfxd3DW71uTmthAVVdrBLvDr/mXYJmr0qwpyXMiBus97a4jmR
    lgbV9SHclDhwtoEyJ+YhHszzIAHFvHS3twUMzfrFQ1gTeS0oKt6vvOEGqDX+i9AJeoZbTP4+Sc9UPpuJWtmyv10XRMSi2sCP11Mm9HcbJxckVIJnZPHok6h/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=rR3N6wF2ypCZ4i_Y_DoA:9
    a=GBO4_o2OZE_o7MNm:21 a=6cc50G5iDQA5SUGw:21 a=x8gzFH9gYPwA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753178AbeDSOc3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:32:29 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:12006 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753088AbeDSOcZ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 19 Apr 2018 10:32:25 -0400
X-Google-Smtp-Source: AIpwx48e1M+GVXx8c1EAdGaNFWIS8H+JOZqY8nkd0lZVmZt/wyxoIr9T61y8e71d1AS8XJUHRen2EQ==
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
Subject: [PATCH v3 3/3] dt-bindings: Document the DT bindings for lan78xx
Date: Thu, 19 Apr 2018 15:32:05 +0100
Message-Id: <1524148325-78945-5-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524148325-78945-1-git-send-email-phil@raspberrypi.org>
References: <1524148325-78945-1-git-send-email-phil@raspberrypi.org>
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
---
 .../devicetree/bindings/net/microchip,lan78xx.txt  | 54 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt

diff --git a/Documentation/devicetree/bindings/net/microchip,lan78xx.txt b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
new file mode 100644
index 0000000..a5d701b
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
+
+				mdio {
+					#address-cells = <0x1>;
+					#size-cells = <0x0>;
+					eth_phy: ethernet-phy@1 {
+						reg = <1>;
+						microchip,led-modes = <
+						 	LAN78XX_LINK_1000_ACTIVITY
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

