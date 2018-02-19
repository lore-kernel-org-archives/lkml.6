Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519025086; cv=none;
        d=google.com; s=arc-20160816;
        b=g8hk6hEXPcfHJp9SpkbgoCTLQby40c53tJMDgG2yR3E4BW/GX64YD01eW644eFhFFl
         FgdQgWb8jCelkWeBovzp37A+ayMYvL1NDV+Tx7tfp2cTP3HW2hEnf14+3cVwoCpba7vK
         joJ1DSHwcZr5ZDp/V5jIzdisR7I9mTf6f5hw6PaSWWIckgraAGuYH6/TIK1AGCLF0Wlr
         nUpCCYW+8wXrGuzM3G+DCi+UC3mZokrki1itYAFDtismfmJyhS3bfcgi2LDaHPJWNNHb
         KKgQvxyXKmEX93EykcShkVZ47c4jQVHh8iYGM1htBZgsomIc37t5DMJV76LgBTvC2pQT
         dWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=tZFg/IZta6nugTj/dTirBEO0g/WAhdCuEkjt5MXATSc=;
        b=Y5rt2D2HkTid0Px5Vd2wr9MfP5CBiZ9TfXqa8WPD3j55nfKdM1bt+roYUEcbAIQVlC
         oBDwW8UXIIOzES2TKGQAY0kPuuq4wkz7ctDPW0FPlMeZK2/dPHOY8ykquxEKcqFZe06S
         JBzJvuGd7pnsu+guvRGqYgBBlX7MYnfY3+8INPTrw1r8Vzh/7GFm91IFPqhptQso4nRZ
         s6lT3YAglg9iAXaIxbL+iYcUqP1lm4FymBCPhEIV5498TU1MtEZR1Lz5Sd+qs2/FTw39
         opQI6euzahcJOI2lssZY5OJKUxE1DqbmBm6upMkZX8BqpwysfVmWuwugvWtoo/XvKYgJ
         FTiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=o8fiYaz4;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=o8fiYaz4;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x226YRJazxhB8OYNr6PeWbjs9uhsPg1frRisNM2NIE1WlYmpXPr3WDh8ICgD4QhhITTjovXS5rA==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Lee Jones <lee.jones@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>,
	Cyril Bur <cyrilbur@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Lei YU <mine260309@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: aspeed-lpc: Document LPC Host Interface Controller
Date: Mon, 19 Feb 2018 17:54:20 +1030
Message-Id: <20180219072422.22733-2-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180219072422.22733-1-joel@jms.id.au>
References: <20180219072422.22733-1-joel@jms.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592813249308453980?=
X-GMAIL-MSGID: =?utf-8?q?1592813249308453980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The LPC Host Interface Controller is part of a BMC SoC that is used for
communication with the host.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
 - Move the content to below the Host Node Children heading
 - Add Rob's review tag
---
 .../devicetree/bindings/mfd/aspeed-lpc.txt         | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
index 514d82ced95b..69aadee00d5f 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
@@ -109,9 +109,50 @@ lpc: lpc@1e789000 {
 	};
 };
 
+BMC Node Children
+==================
+
+
 Host Node Children
 ==================
 
+LPC Host Interface Controller
+-------------------
+
+The LPC Host Interface Controller manages functions exposed to the host such as
+LPC firmware hub cycles, configuration of the LPC-to-AHB mapping, UART
+management and bus snoop configuration.
+
+Required properties:
+
+- compatible:	One of:
+		"aspeed,ast2400-lpc-ctrl";
+		"aspeed,ast2500-lpc-ctrl";
+
+- reg:		contains offset/length values of the host interface controller
+		memory regions
+
+- clocks:	contains a phandle to the syscon node describing the clocks.
+		There should then be one cell representing the clock to use
+
+- memory-region: A phandle to a reserved_memory region to be used for the LPC
+		to AHB mapping
+
+- flash:	A phandle to the SPI flash controller containing the flash to
+		be exposed over the LPC to AHB mapping
+
+Example:
+
+lpc-host@80 {
+	lpc_ctrl: lpc-ctrl@0 {
+		compatible = "aspeed,ast2500-lpc-ctrl";
+		reg = <0x0 0x80>;
+		clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
+		memory-region = <&flash_memory>;
+		flash = <&spi>;
+	};
+};
+
 LPC Host Controller
 -------------------
 
-- 
2.15.1
