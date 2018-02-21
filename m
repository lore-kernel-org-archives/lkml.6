Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x224ocLKrAUrnYlcuaSXkksmpA7MlZeZUI/gEkkwW2iXyyQGUBp6Gp0T5sXN3N/w/0hn90a2S
ARC-Seal: i=1; a=rsa-sha256; t=1519229779; cv=none;
        d=google.com; s=arc-20160816;
        b=xC6EZSfxuoVmAAR9ankSD7tO76m9UGHobejTXqX3T2qtWYn+ouzoXzISR2pyllmJJy
         Z+Jk5E2zkp+SQQTep+n60CIgOu3AhgyLjgo1kkA2CHsPbZQgS1YNH9euYUPxXSQjDzxg
         /i31ctXebYCEuJaGW8O00Jxpd5cgNi+QjT4+ON6n5GH4kIstWTwJWyuuMK3AQMLA66er
         gOKPglUbKaP4YCtsiPXrhnTBpdhZIm+dYIKAunwaib+n0IM40tmRPKbzYeVbL2NTQeBL
         S/Y+tFTBCLc029N6BGiNDmXKye/k13zCqACsM3glOoo3nnsK4rT8RBOib8xgxjdpsdlV
         Av6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=QcdtKuWi+7QJMQIgBldCy1FjhrDdcM8kbAnl58atcGo=;
        b=yJ23EfhK3Ez+3tWAY1yV5i3vXpaWVKqX53/mXLvndaZ2FYzMCcauzNujIwoZhsNFo3
         NcazVWb6pmUtishI3wFZuDjGrec31uTBlDT8DDAF99T9jSqyEUdMZu4CATXOAE4WRVoK
         yN+khxALVGlwDgOnjVMKVtFopyDEQPWGFtJsYIiPXAwbTeO06CBelpn3snaC3jjSQSXZ
         I3jR08QSbu3A99lu9P3BJaInef6XwxOxDrvf4GBPCOQgPY93ZuEjmgsOKcoLrLgzsaVv
         1/ZzmAmdvjN9HNQntZcWuXzH0TaS6EaZPbbJyz4yQ8+3nC0/m0bSmOu4qF+d4qsc1Fba
         T9VQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="29617845"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: joel@jms.id.au,
	andrew@aj.id.au,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	benh@kernel.crashing.org,
	andrew@lunn.ch
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	openbmc@lists.ozlabs.org,
	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v2 3/8] [PATCH 3/8] ARM: dts: aspeed: peci: Add PECI node
Date: Wed, 21 Feb 2018 08:16:01 -0800
Message-Id: <20180221161606.32247-4-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027885195370131?=
X-GMAIL-MSGID: =?utf-8?q?1593027885195370131?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds PECI bus/adapter node of AST24xx/AST25xx into
aspeed-g4 and aspeed-g5.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 25 +++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index b0d8431a3700..077b4d6795b8 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -29,6 +29,7 @@
 		serial3 = &uart4;
 		serial4 = &uart5;
 		serial5 = &vuart;
+		peci0 = &peci0;
 	};
 
 	cpus {
@@ -250,6 +251,13 @@
 				};
 			};
 
+			peci: peci@1e78b000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1e78b000 0x60>;
+			};
+
 			uart2: serial@1e78d000 {
 				compatible = "ns16550a";
 				reg = <0x1e78d000 0x20>;
@@ -290,6 +298,23 @@
 	};
 };
 
+&peci {
+	peci0: peci-bus@0 {
+		compatible = "aspeed,ast2400-peci";
+		reg = <0x0 0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <15>;
+		clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
+		clock-frequency = <24000000>;
+		msg-timing-nego = <1>;
+		addr-timing-nego = <1>;
+		rd-sampling-point = <8>;
+		cmd-timeout-ms = <1000>;
+		status = "disabled";
+	};
+};
+
 &i2c {
 	i2c_ic: interrupt-controller@0 {
 		#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 40de3b66c33f..5d3b5e177a32 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -29,6 +29,7 @@
 		serial3 = &uart4;
 		serial4 = &uart5;
 		serial5 = &vuart;
+		peci0 = &peci0;
 	};
 
 	cpus {
@@ -301,6 +302,13 @@
 				};
 			};
 
+			peci: peci@1e78b000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1e78b000 0x60>;
+			};
+
 			uart2: serial@1e78d000 {
 				compatible = "ns16550a";
 				reg = <0x1e78d000 0x20>;
@@ -341,6 +349,23 @@
 	};
 };
 
+&peci {
+	peci0: peci-bus@0 {
+		compatible = "aspeed,ast2500-peci";
+		reg = <0x0 0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <15>;
+		clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
+		clock-frequency = <24000000>;
+		msg-timing-nego = <1>;
+		addr-timing-nego = <1>;
+		rd-sampling-point = <8>;
+		cmd-timeout-ms = <1000>;
+		status = "disabled";
+	};
+};
+
 &i2c {
 	i2c_ic: interrupt-controller@0 {
 		#interrupt-cells = <1>;
-- 
2.16.1
