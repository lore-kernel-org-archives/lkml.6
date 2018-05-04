Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-336646-1525448863-2-14793560542408029145
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525448863; b=V4IxKv6u2OuxTKDNPB+rIOtAQVXggC0KeEB2JcHZS0t2FdXzTR
    F5/45JzVNynykOSMBbG1l05WAoZV5hLJt2/OI1fCq0cVHxfCIsV/dj97el53tH+o
    Lts10iy/6U9Sw+JGxjX462HVlxBOFGBLdedVDkTWzaGZteks88cvgKJ+t1jiChPm
    hg2aOuvVLtLRDQQm91QBxlfkOb65sQXuA8zj1tknCVdyzvrkexTIb9pOIVa7TA8Z
    VrJbXKDcP0ejNB5cjDXRoflcYtGs+oQQUhoW7LTsvNsquWb9xITQR1NeW0TiNicl
    IB1rq+I8KZUR1s2hPtidTF6fYutF1aLHBV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525448863; bh=ZegAp2OK4D1KlzCwVpkcg6nuZHFMgA
    MblTbcVCux9zk=; b=VzC27o2MT+Rl40VsAl93RftcXI9HFE0Fj7W9mP31Ap4KZw
    qcI2hd0Je/7BN+2I041+yJ3a/efVcZFKBwe5vDIEbsRRBBz0L6uNXp7ZIc1pbGHg
    rBGdgNhz9is/p6IlFUt4BX0KOABUJwRAmifxo5H4w7iyUOzfsHRi50kPxNs4V8H8
    o8vb2547O934R6hUOVcLZwPD0Dr10McKWxr0xErcrsZ/6/IUIx306UMcvf5IU9Vc
    Umgy6v1xnjlAWQtkVbHzE5Bkais9bfQ/2eBeCFO3Iz9sZf7tc2woKzguoAsp6Ja9
    Q4oN6NXk2EcVKC5snB4zumZH+ywBgqJYLVKvz0cA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=microchip.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=microchip.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHvCNMW5Xvcvcnkhckw3EhTUhlJ8SQZi6naA6XEzuhNVzcpAjUgdgaojtBOnjaERTNjv672/PQdOknB1y2YzzodufEJYkUr3g0Xrx4bPj0lHCdzHEh/U
    dU/AbR8fCD5tWGGU6AP6ZRb1oCNut0frQpdgJMnUgOPfG1eggizcjflOWMTpgvNWKQlERtNzCUcFoy1m/UR9vyXmniA9pW0Aq/vBOoJ9WyMZM8SIGfMXdVAm
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8
    a=VwQbUJbxAAAA:8 a=934eDyrJE40F_U7Zu78A:9 a=EyhVBviKNY4GdBGF:21
    a=k4aceutm-ReiwuOL:21 a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbeEDPqc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 11:46:32 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:15955 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbeEDPqb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 May 2018 11:46:31 -0400
X-IronPort-AV: E=Sophos;i="5.49,363,1520924400";
   d="scan'208";a="14509198"
From: Radu Pirea <radu.pirea@microchip.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>
CC: <lee.jones@linaro.org>, <broonie@kernel.org>,
        <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <jslaby@suse.com>, <gregkh@linuxfoundation.org>,
        <richard.genoud@gmail.com>, Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v2 4/6] dt-bindings: add binding for at91-usart in spi mode
Date: Fri, 4 May 2018 18:47:12 +0300
Message-ID: <20180504154714.5109-5-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504154714.5109-1-radu.pirea@microchip.com>
References: <20180504154714.5109-1-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These are bindings for at91-usart IP in spi spi mode. There is no support for
internal chip select. Only kind of chip selects available are gpio chip
selects.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 .../bindings/spi/microchip,at91-usart-spi.txt | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt

diff --git a/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
new file mode 100644
index 000000000000..b68a3bec4121
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
@@ -0,0 +1,28 @@
+* Universal Synchronous Asynchronous Receiver/Transmitter (USART) in SPI mode
+
+Required properties:
+- #size-cells      : Must be <0>
+- #address-cells   : Must be <1>
+- compatible: Should be "atmel,at91rm9200-usart" or "atmel,at91sam9260-usart"
+- reg: Should contain registers location and length
+- interrupts: Should contain interrupt
+- clocks: phandles to input clocks.
+- clock-names: tuple listing input clock names.
+	Required elements: "usart"
+- cs-gpios: chipselects (internal cs not supported)
+- at91,usart-mode: AT91_USART_MODE_SPI (found in dt-bindings/mfd/at91-usart.h)
+
+Example:
+	#include <dt-bindings/mfd/at91-usart.h>
+
+	spi0: spi@f001c000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "atmel,at91rm9200-usart", "atmel,at91sam9260-usart";
+		at91,usart-mode = <AT91_USART_MODE_SPI>;
+		reg = <0xf001c000 0x100>;
+		interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&usart0_clk>;
+		clock-names = "usart";
+		cs-gpios = <&pioB 3 0>;
+	};
-- 
2.17.0

