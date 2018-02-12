Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518419347; cv=none;
        d=google.com; s=arc-20160816;
        b=OOf8XbTn2ZS5HtkmHbu5azdWEMCd1EPJ5yy4ix4fWgTlBtXtHMihx3oVv6yEQMo2Mp
         WuGsz7N6JU89HaVcz53onxBM92cvIAA5ord0vrZn9dQjSqdtc+vvZ8AZjThq2Xzx0mv6
         2D3ta1QUb1H/oFWeR38NqgTF52HFH/05E33pR+TcSZaCHPboyv37TxZkoaeRa7+V4K7c
         vkBTzxXWQFvrqW6NCPoMUiQ7sZTlUU1YwSspUhrUjvYVAW8XBh/nsq86Lr4RMIRhnqbb
         rIwvufYpvCZRRGUzBlhFRWijnoyjRIJoXv30zYqEl125OD0Wcpy6uswOfOr5KKNZyilI
         q0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=eNpEXsIVrxsQO6RsHiKZUBXRoHWgwzXkOWOw6UdhmSA=;
        b=d/MikNeE5FWZVv8f5UhJ6hbnoZgjgEQw7XaHGYbXn38rwLNneTlNTP43o0dl4amASY
         jw16BgQ7hy7jg0kXs+ECV/7RWfY1cU5w49JkwJiI/ueUNrsLvkiG5vtiUJ10OPsLWFrj
         jdhfEKv6n1OBC3V1ty3H1e+BB6iY8T1Cl3TPT8d51/SYxS9EUVYU5ABZ82KxzuKg1bXc
         BssjFJ3cOIf/sZ3/aSlBpH7n6rB/2SEftq0Srs0ubzB2K4Dlx1VoElBzaLs/CNOT55Rg
         4iEt754qqyah0fRzzgNhbAC5IbOAomqJncvhzTf+fRQDFYAa7ksp1twIuxZU/DdYGq3Y
         RxXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eyEtR+oW;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eyEtR+oW;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x225MFW9YU/IWzWAbLohYh8a3i3xFZ6o/5qgadDlMFrkxLehkPAjH9xrguNfmmvfLNryVIGhLag==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Lee Jones <lee.jones@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>,
	Cyril Bur <cyrilbur@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Lei YU <mine260309@gmail.com>
Subject: [PATCH 1/3] dt-bindings: aspeed-lpc: Document LPC Host Interface Controller
Date: Mon, 12 Feb 2018 17:38:45 +1030
Message-Id: <20180212070847.32387-2-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212070847.32387-1-joel@jms.id.au>
References: <20180212070847.32387-1-joel@jms.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592178085601098938?=
X-GMAIL-MSGID: =?utf-8?q?1592178085601098938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The LPC Host Interface Controller is part of a BMC SoC that is used for
communication with the host.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/mfd/aspeed-lpc.txt         | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
index 514d82ced95b..94a31de109c4 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
@@ -109,6 +109,46 @@ lpc: lpc@1e789000 {
 	};
 };
 
+BMC Node Children
+==================
+
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
 Host Node Children
 ==================
 
-- 
2.15.1
