Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1017744-1523541386-2-17886058710646028565
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
    1523541386; b=tqAdPXspZG1gQubeaGaetdIFMCoXU6VnLpHk0IaZya8okwJI4L
    3ohOzUjuAUPGud3IFMjdrVW9K47jt8DrR+C2lpRbuVjwvjapweLfSDYLr2GKlSH+
    HIToF9IAiNDbEyvqiaZemuLkgUqk9/D1XccoxBMKXaFhxnpkt3MWYDSGat/D0vmD
    CnIsiNfM6zO3JMUcI26eWHDFstnz/UQFrxlU7ts5sz6Ys/91Weo2qnIKWoAdZGps
    vbWU8IORYoWkUbBRmjz9peTiFiwfIyY1HyqGlnvz5Bm4CegEt4TSNcTYEejzycM7
    Pa7Nv95Ympnadks/L3HY96zawKNBNVrgFYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523541386; bh=
    BeESklhJy5Ww8izn94HlucYjmN5h6rjlTKzrbG12al0=; b=DAW6J3GmN4f+U442
    2Owan2INFUvfX2pTehEgQ+k3uiywsJrEDxbjxx3WU7oFIBZZGMFfw1V2VWKaNxC4
    DtJYbLd1p2T+oOA2qmaUSK6p/1BvjODZ6I7brNH3OaTaIwjAq0IaPo0Ser89J/vs
    DQCF9SjUMZi1XUn45qnQz4ZMqvGAWLllci/SJJneL5q4//876oEY6otUixcy2KcV
    z/aepR90D7N0QaJ1Tnwoj7osz6PRKP+8CbEEv7ksvwufiobzgjSrEYvUYk+gCTDG
    Y+Jl29B+jmGD7cFmoximlTOO3LbUGIN7rtvKdMSPI0CdPycfQjSKVJp4BdooqK31
    KqKIPQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=v0V/o4Cp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=VZc2zjDE x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Dnu7fpwz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=v0V/o4Cp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=VZc2zjDE x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Dnu7fpwz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOUR/TQVqULJnHEAtogyDHTicWDEig5RggtDxruyn2M5fDXhUkk0Za5CMgeBwSFDq/MzsUdzYfCXm7RNNmI4TPwyJwE0H+LGYteNIF9Sn8RA+xqoGT4M
    Xwi1cm8WwLUZ9llGg1ZJQbLpjoQt9JqNMtESXR5Qs4lge6hpzqJmjQMf6tC36lx6xmLJBzCCFrEz9/9XnwQNwo4i6EMTeC51ipwpTMzPyetFYHM/xYaFyyeq
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=rR3N6wF2ypCZ4i_Y_DoA:9
    a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeDLNz5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 09:55:57 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:57986 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752807AbeDLNzy (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 12 Apr 2018 09:55:54 -0400
X-Google-Smtp-Source: AIpwx48syZENwRqzgo09M7WUStD73Y3HrzDvyhCFRvoR5eGYRUOlPTkNWgPPuKhgP0iNja0IOeGZ0Q==
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
Subject: [PATCH 4/4] dt-bindings: Document the DT bindings for lan78xx
Date: Thu, 12 Apr 2018 14:55:36 +0100
Message-Id: <1523541336-145953-5-git-send-email-phil@raspberrypi.org>
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

The Microchip LAN78XX family of devices are Ethernet controllers with
a USB interface. Despite being discoverable devices it can be useful to
be able to configure them from Device Tree, particularly in low-cost
applications without an EEPROM or programmed OTP.

Document the supported properties in a bindings file, adding it to
MAINTAINERS at the same time.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 .../devicetree/bindings/net/microchip,lan78xx.txt  | 44 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt

diff --git a/Documentation/devicetree/bindings/net/microchip,lan78xx.txt b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
new file mode 100644
index 0000000..e7d7850
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
@@ -0,0 +1,44 @@
+Microchip LAN78xx Gigabit Ethernet controller
+
+The LAN78XX devices are usually configured by programming their OTP or with
+an external EEPROM, but some platforms (e.g. Raspberry Pi 3 B+) have neither.
+
+Please refer to ethernet.txt for a description of common Ethernet bindings.
+
+Optional properties:
+- microchip,eee-enabled: if present, enable Energy Efficient Ethernet support;
+- microchip,led-modes: a two-element vector, with each element configuring
+  the operating mode of an LED. The values supported by the device are;
+  0: Link/Activity
+  1: Link1000/Activity
+  2: Link100/Activity
+  3: Link10/Activity
+  4: Link100/1000/Activity
+  5: Link10/1000/Activity
+  6: Link10/100/Activity
+  7: RESERVED
+  8: Duplex/Collision
+  9: Collision
+  10: Activity
+  11: RESERVED
+  12: Auto-negotiation Fault
+  13: RESERVED
+  14: Off
+  15: On
+- microchip,tx-lpi-timer: the delay (in microseconds) between the TX fifo
+  becoming empty and invoking Low Power Idles (default 600).
+
+Example:
+
+	/* Standard configuration for a Raspberry Pi 3 B+ */
+	ethernet: usbether@1 {
+		compatible = "usb424,7800";
+		reg = <1>;
+		microchip,eee-enabled;
+		microchip,tx-lpi-timer = <600>;
+		/*
+		 * led0 = 1:link1000/activity
+		 * led1 = 6:link10/100/activity
+		 */
+		microchip,led-modes = <1 6>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 2328eed..b637aad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14482,6 +14482,7 @@ M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/usb/lan78xx.*
+F:	Documentation/devicetree/bindings/net/microchip,lan78xx.txt
 
 USB MASS STORAGE DRIVER
 M:	Alan Stern <stern@rowland.harvard.edu>
-- 
2.7.4

