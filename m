Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752413-1526035093-2-1750093038314979355
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526035093; b=ONq1lYahmFLP5is5UKLInNcZP4Ir7daczQTwOBv8L+tRKw++QA
    a+QGcxqkuU/ddm7g1xMxWWNGQ7vRTnUm3dHUXXjQVkebigaRtjHwI9Tv846E3Igi
    BDXjXq3TfeP6oZHvocspvUukRvIJi4ON61jHIU15Djfi336vzDvz2zg51mfVMCYi
    MX/e7EyZoFpeSCtKJBXmYfmR5QJSLSqcVLUYjSd/YUX+U2KyoRASP6e2FfCqYIRf
    QkZlNSt6G34rxVe7Hp7tCsLcy9tmxU8/XAZvQoVthMZsZWZ5CrIx5cCCBvb5/nj9
    pi2lOHMZv6wL80G5ezVzzwUFQtfB+0KFrP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526035093; bh=ZegAp2OK4D1KlzCwVpkcg6nuZHFMgA
    MblTbcVCux9zk=; b=Jj2ONV4xOlqvwa+VowLSYI4tvqmWIMlQQBWEDo4AfKdJmn
    0OS3iuNdZuRwjxYezsDXryTkkM4cqxmJNF+IRs03mSKhYMtU4oh8ALoZ9YK0fHH0
    aKABmehXLVo8TtbGaDUDP5LwLCUnhOSszYJ3QWOGZov4NRCLwFAsQuMkap9OdQPy
    BoixLA5z67QFOB45/8NoRF5zQVzv4Sej9SNK0AUsiq+B/Rol0u9c8xq7wNYrGOyM
    jSdyhCaXGGaTVlugJU8ZH5ADVefjF5Jpyvt2e/fpzyP5j8TcsC8zgimKVpfZDXw3
    QNUuB9zDaKsEH5ZRWygQGHQfuJDwkDIu4r3Xb8Wg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfP5lgw/47sXVXOyAc4kuNPz2V0g4myJt0t7HYrliF8f9jx4HieBv2zz+HuQHMVk71Fr56ix2onY9Enj4Il4i8Wlu9JZISXuPMZw+jGlgMzAAOQ1t3B5E
    lAwqZLPbJGZ1+BoHsn5ssCo1B5o7rf+ydi+F/qKEkrVmmdllBnhl5zkX3zrtyefJeaT21BQQh2EHYhjotijcM9+pEKb0ORHmWBYLZJPirRJSsLqEK+WbX6OZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8
    a=VwQbUJbxAAAA:8 a=934eDyrJE40F_U7Zu78A:9 a=EyhVBviKNY4GdBGF:21
    a=k4aceutm-ReiwuOL:21 a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753053AbeEKKhg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 06:37:36 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:41815 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753024AbeEKKhd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 May 2018 06:37:33 -0400
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="11960902"
From: Radu Pirea <radu.pirea@microchip.com>
To: <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC: <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <richard.genoud@gmail.com>,
        <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <broonie@kernel.org>, Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v3 4/6] dt-bindings: add binding for at91-usart in spi mode
Date: Fri, 11 May 2018 13:38:20 +0300
Message-ID: <20180511103822.31698-5-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511103822.31698-1-radu.pirea@microchip.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
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

