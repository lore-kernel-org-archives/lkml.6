Return-Path: <neil@brown.name>
X-Google-Smtp-Source: AG47ELszn1CZ9AcGudidtf84MX5LJqL+8BJgHFUHTcQdS3Us67UL+KgLErilRJnKzKjuSsDZnG0e
ARC-Seal: i=1; a=rsa-sha256; t=1521059069; cv=none;
        d=google.com; s=arc-20160816;
        b=fukzhfF+jr0g7ekL0Qbbzf0FpISR/3M6bkwCBQubrRhtFfN9q2GUzCshDKSeBYpehS
         z6nmwv3u1nI+bUSRK5KboNj101sVy+AEhYgfKQ4qwVn9kk/YxM7BpM3wijGDis0xD0rc
         0bW1r7jMgfGfyO/QLognmMZv8UAvXaLZVbnj9SoxuYjwlGwX6Qdl7iFtpoc5vZvoXVVn
         aG3O182vvoP5+c5R0MR6NWNEBUtTthDT7yI2TJKNwHngILjcbWC18D39CHNQcJnVyOMh
         Ju+jYgAurt3e2CkgLe9tfmatF4hKuf1cr441HfZZ1V/SEA69J4tkQS9OBcLm+fa4wUTK
         Amow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=1Xj+TkCizEcIPs3xIrz0Rh6qze9YompC1Y1eTA+rnCM=;
        b=s0UzoxrCr8DuOqSLkz/UrRY9C/lfbXpZws4p2qu1Zq2k9b7ZK/O1YG1PlaCQfK9TSc
         8TKFArkJheNApBqGvlJJFEXy/CEnnZl86ne1wN1iG4QicV1/uTCS0HN/GaUpwTxAgWgq
         +jX1xKMicLDwaskpzJ7HFLMJDhT76fiplDJp+ZSyHMMMswh6s3iYPunRzo3P20aF3BXR
         KJA05WZoHFpR2aQRzpFuoH6muDEtWWXlYYM53lLOxYVttQdIlJzekVTuQrgQRufTtnUi
         wvOFrFt+42Ae9fj3kSxfE2clZO6UkzWZyANAU1aIv6qDCgGi+slK82mre2tu3/GwOXGu
         cxdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 15 Mar 2018 07:22:36 +1100
Subject: [PATCH 13/13] staging: mt7621-dts: add dts files
Cc: devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
 John Crispin <blogic@openwrt.org>
Message-ID: <152105895643.22262.366168303739943777.stgit@noble>
In-Reply-To: <152105892255.22262.1902152685410223215.stgit@noble>
References: <152105892255.22262.1902152685410223215.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594946034961186216?=
X-GMAIL-MSGID: =?utf-8?q?1594946034961186216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add device tree source for mt7621 and gnubee1 to
make testing easier.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/Kconfig                |    2 
 drivers/staging/Makefile               |    1 
 drivers/staging/mt7621-dts/Kconfig     |    5 
 drivers/staging/mt7621-dts/Makefile    |    3 
 drivers/staging/mt7621-dts/TODO        |    5 
 drivers/staging/mt7621-dts/gbpc1.dts   |  143 ++++++++++
 drivers/staging/mt7621-dts/mt7621.dtsi |  471 ++++++++++++++++++++++++++++++++
 7 files changed, 630 insertions(+)
 create mode 100644 drivers/staging/mt7621-dts/Kconfig
 create mode 100644 drivers/staging/mt7621-dts/Makefile
 create mode 100644 drivers/staging/mt7621-dts/TODO
 create mode 100644 drivers/staging/mt7621-dts/gbpc1.dts
 create mode 100644 drivers/staging/mt7621-dts/mt7621.dtsi

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index d9cddad71da2..6dac0c1fecf4 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -134,4 +134,6 @@ source "drivers/staging/mt7621-mmc/Kconfig"
 
 source "drivers/staging/mt7621-eth/Kconfig"
 
+source "drivers/staging/mt7621-dts/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 2a7defcd6836..2634228aeaa2 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -59,3 +59,4 @@ obj-$(CONFIG_SOC_MT7621)	+= mt7621-spi/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dma/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-mmc/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-eth/
+obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
diff --git a/drivers/staging/mt7621-dts/Kconfig b/drivers/staging/mt7621-dts/Kconfig
new file mode 100644
index 000000000000..94a9e16c0b92
--- /dev/null
+++ b/drivers/staging/mt7621-dts/Kconfig
@@ -0,0 +1,5 @@
+config DTB_GNUBEE1
+	bool "GnuBee1 NAS"
+	depends on SOC_MT7621 && DTB_RT_NONE
+	select BUILTIN_DTB
+
diff --git a/drivers/staging/mt7621-dts/Makefile b/drivers/staging/mt7621-dts/Makefile
new file mode 100644
index 000000000000..195eba4a5c65
--- /dev/null
+++ b/drivers/staging/mt7621-dts/Makefile
@@ -0,0 +1,3 @@
+dtb-$(CONFIG_DTB_GNUBEE1)      += gbpc1.dtb
+
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/drivers/staging/mt7621-dts/TODO b/drivers/staging/mt7621-dts/TODO
new file mode 100644
index 000000000000..15803132c1ea
--- /dev/null
+++ b/drivers/staging/mt7621-dts/TODO
@@ -0,0 +1,5 @@
+
+- ensure all usage matches code
+- ensure all features used are documented
+
+Cc: NeilBrown <neil@brown.name>
\ No newline at end of file
diff --git a/drivers/staging/mt7621-dts/gbpc1.dts b/drivers/staging/mt7621-dts/gbpc1.dts
new file mode 100644
index 000000000000..515c7cbdd15e
--- /dev/null
+++ b/drivers/staging/mt7621-dts/gbpc1.dts
@@ -0,0 +1,143 @@
+/dts-v1/;
+
+#include "mt7621.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	compatible = "gnubee,gb-pc1", "mediatek,mt7621-soc";
+	model = "GB-PC1";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x1c000000>, <0x20000000 0x4000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,57600";
+	};
+
+	palmbus: palmbus@1E000000 {
+		i2c@900 {
+			status = "okay";
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <20>;
+
+		reset {
+			label = "reset";
+			gpios = <&gpio0 18 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_RESTART>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		system {
+			label = "gb-pc1:green:system";
+			gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
+		};
+
+		status {
+			label = "gb-pc1:green:status";
+			gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
+		};
+
+		lan1 {
+			label = "gb-pc1:green:lan1";
+			gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
+		};
+
+		lan2 {
+			label = "gb-pc1:green:lan2";
+			gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&sdhci {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+
+	m25p80@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+		m25p,chunked-io = <32>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0x0 0x30000>;
+			read-only;
+		};
+
+		partition@30000 {
+			label = "u-boot-env";
+			reg = <0x30000 0x10000>;
+			read-only;
+		};
+
+		factory: partition@40000 {
+			label = "factory";
+			reg = <0x40000 0x10000>;
+			read-only;
+		};
+
+		partition@50000 {
+			label = "firmware";
+			reg = <0x50000 0xFB0000>;
+		};
+
+	};
+};
+
+&sysclock {
+			compatible = "fixed-clock";
+			clock-frequency = <90000000>;
+};
+
+&cpuclock {
+			compatible = "fixed-clock";
+			clock-frequency = <900000000>;
+};
+
+&pcie {
+	status = "okay";
+};
+
+&ethernet {
+	//mtd-mac-address = <&factory 0xe000>;
+	gmac1: mac@0 {
+		compatible = "mediatek,eth-mac";
+		reg = <0>;
+		phy-handle = <&phy1>;
+	};
+
+	mdio-bus {
+		phy1: ethernet-phy@1 {
+			reg = <1>;
+			phy-mode = "rgmii";
+		};
+	};
+};
+
+&pinctrl {
+	state_default: pinctrl0 {
+		gpio {
+			ralink,group = "wdt", "rgmii2", "uart3";
+			ralink,function = "gpio";
+		};
+	};
+};
diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt7621-dts/mt7621.dtsi
new file mode 100644
index 000000000000..a6b17ea9ade8
--- /dev/null
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -0,0 +1,471 @@
+#include <dt-bindings/interrupt-controller/mips-gic.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "mediatek,mt7621-soc";
+
+	cpus {
+		cpu@0 {
+			compatible = "mips,mips1004Kc";
+		};
+
+		cpu@1 {
+			compatible = "mips,mips1004Kc";
+		};
+	};
+
+	cpuintc: cpuintc@0 {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		compatible = "mti,cpu-interrupt-controller";
+	};
+
+	aliases {
+		serial0 = &uartlite;
+	};
+
+	cpuclock: cpuclock@0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+
+		/* FIXME: there should be way to detect this */
+		clock-frequency = <880000000>;
+	};
+
+	sysclock: sysclock@0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+
+		/* FIXME: there should be way to detect this */
+		clock-frequency = <50000000>;
+	};
+
+	palmbus: palmbus@1E000000 {
+		compatible = "palmbus";
+		reg = <0x1E000000 0x100000>;
+		ranges = <0x0 0x1E000000 0x0FFFFF>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sysc: sysc@0 {
+			compatible = "mtk,mt7621-sysc";
+			reg = <0x0 0x100>;
+		};
+
+		wdt: wdt@100 {
+			compatible = "mtk,mt7621-wdt";
+			reg = <0x100 0x100>;
+		};
+
+		gpio@600 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			compatible = "mtk,mt7621-gpio";
+			reg = <0x600 0x100>;
+
+			gpio0: bank@0 {
+				reg = <0>;
+				compatible = "mtk,mt7621-gpio-bank";
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio1: bank@1 {
+				reg = <1>;
+				compatible = "mtk,mt7621-gpio-bank";
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio2: bank@2 {
+				reg = <2>;
+				compatible = "mtk,mt7621-gpio-bank";
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+
+		i2c: i2c@900 {
+			compatible = "mediatek,mt7621-i2c";
+			reg = <0x900 0x100>;
+
+			clocks = <&sysclock>;
+
+			resets = <&rstctrl 16>;
+			reset-names = "i2c";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c_pins>;
+		};
+
+		i2s: i2s@a00 {
+			compatible = "mediatek,mt7621-i2s";
+			reg = <0xa00 0x100>;
+
+			clocks = <&sysclock>;
+
+			resets = <&rstctrl 17>;
+			reset-names = "i2s";
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 16 IRQ_TYPE_LEVEL_HIGH>;
+
+			txdma-req = <2>;
+			rxdma-req = <3>;
+
+			dmas = <&gdma 4>,
+				<&gdma 6>;
+			dma-names = "tx", "rx";
+
+			status = "disabled";
+		};
+
+		memc: memc@5000 {
+			compatible = "mtk,mt7621-memc";
+			reg = <0x300 0x100>;
+		};
+
+		cpc: cpc@1fbf0000 {
+			     compatible = "mtk,mt7621-cpc";
+			     reg = <0x1fbf0000 0x8000>;
+		};
+
+		mc: mc@1fbf8000 {
+			    compatible = "mtk,mt7621-mc";
+			    reg = <0x1fbf8000 0x8000>;
+ 		};
+
+		uartlite: uartlite@c00 {
+			compatible = "ns16550a";
+			reg = <0xc00 0x100>;
+
+			clocks = <&sysclock>;
+			clock-frequency = <50000000>;
+
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 26 IRQ_TYPE_LEVEL_HIGH>;
+
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			no-loopback-test;
+		};
+
+		spi0: spi@b00 {
+			status = "disabled";
+
+			compatible = "ralink,mt7621-spi";
+			reg = <0xb00 0x100>;
+
+			clocks = <&sysclock>;
+
+			resets = <&rstctrl 18>;
+			reset-names = "spi";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi_pins>;
+		};
+
+		gdma: gdma@2800 {
+			compatible = "ralink,rt3883-gdma";
+			reg = <0x2800 0x800>;
+
+			resets = <&rstctrl 14>;
+			reset-names = "dma";
+
+			interrupt-parent = <&gic>;
+			interrupts = <0 13 4>;
+
+			#dma-cells = <1>;
+			#dma-channels = <16>;
+			#dma-requests = <16>;
+
+			status = "disabled";
+		};
+
+		hsdma: hsdma@7000 {
+			compatible = "mediatek,mt7621-hsdma";
+			reg = <0x7000 0x1000>;
+
+			resets = <&rstctrl 5>;
+			reset-names = "hsdma";
+
+			interrupt-parent = <&gic>;
+			interrupts = <0 11 4>;
+
+			#dma-cells = <1>;
+			#dma-channels = <1>;
+			#dma-requests = <1>;
+
+			status = "disabled";
+		};
+	};
+
+	pinctrl: pinctrl {
+		compatible = "ralink,rt2880-pinmux";
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinctrl0 {
+		};
+
+		i2c_pins: i2c {
+			i2c {
+				ralink,group = "i2c";
+				ralink,function = "i2c";
+			};
+		};
+
+		spi_pins: spi {
+			spi {
+				ralink,group = "spi";
+				ralink,function = "spi";
+			};
+		};
+
+		uart1_pins: uart1 {
+			uart1 {
+				ralink,group = "uart1";
+				ralink,function = "uart1";
+			};
+		};
+
+		uart2_pins: uart2 {
+			uart2 {
+				ralink,group = "uart2";
+				ralink,function = "uart2";
+			};
+		};
+
+		uart3_pins: uart3 {
+			uart3 {
+				ralink,group = "uart3";
+				ralink,function = "uart3";
+			};
+		};
+
+		rgmii1_pins: rgmii1 {
+			rgmii1 {
+				ralink,group = "rgmii1";
+				ralink,function = "rgmii1";
+			};
+		};
+
+		rgmii2_pins: rgmii2 {
+			rgmii2 {
+				ralink,group = "rgmii2";
+				ralink,function = "rgmii2";
+			};
+		};
+
+		mdio_pins: mdio {
+			mdio {
+				ralink,group = "mdio";
+				ralink,function = "mdio";
+			};
+		};
+
+		pcie_pins: pcie {
+			pcie {
+				ralink,group = "pcie";
+				ralink,function = "pcie rst";
+			};
+		};
+
+		nand_pins: nand {
+			spi-nand {
+				ralink,group = "spi";
+				ralink,function = "nand1";
+			};
+
+			sdhci-nand {
+				ralink,group = "sdhci";
+				ralink,function = "nand2";
+			};
+		};
+
+		sdhci_pins: sdhci {
+			sdhci {
+				ralink,group = "sdhci";
+				ralink,function = "sdhci";
+			};
+		};
+	};
+
+	rstctrl: rstctrl {
+		compatible = "ralink,rt2880-reset";
+		#reset-cells = <1>;
+	};
+
+	clkctrl: clkctrl {
+		compatible = "ralink,rt2880-clock";
+		#clock-cells = <1>;
+	};
+
+	sdhci: sdhci@1E130000 {
+		status = "disabled";
+
+		compatible = "ralink,mt7620-sdhci";
+		reg = <0x1E130000 0x4000>;
+
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	xhci: xhci@1E1C0000 {
+		status = "okay";
+
+		compatible = "mediatek,mt8173-xhci";
+		reg = <0x1e1c0000 0x1000
+		       0x1e1d0700 0x0100>;
+		reg-names = "mac", "ippc";
+
+		clocks = <&sysclock>;
+		clock-names = "sys_ck";
+
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 22 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	gic: interrupt-controller@1fbc0000 {
+		compatible = "mti,gic";
+		reg = <0x1fbc0000 0x2000>;
+
+		interrupt-controller;
+		#interrupt-cells = <3>;
+
+		mti,reserved-cpu-vectors = <7>;
+
+		timer {
+			compatible = "mti,gic-timer";
+			interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
+			clocks = <&cpuclock>;
+		};
+	};
+
+	nand: nand@1e003000 {
+		status = "disabled";
+
+		compatible = "mtk,mt7621-nand";
+		bank-width = <2>;
+		reg = <0x1e003000 0x800
+			0x1e003800 0x800>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	ethsys: syscon@1e000000 {
+		compatible = "mediatek,mt7621-ethsys",
+			     "syscon";
+		reg = <0x1e000000 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	ethernet: ethernet@1e100000 {
+		compatible = "mediatek,mt7621-eth";
+		reg = <0x1e100000 0x10000>;
+
+		clocks = <&sysclock>;
+		clock-names = "ethif";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		resets = <&rstctrl 6 &rstctrl 23>;
+		reset-names = "fe", "eth";
+
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
+
+		mediatek,ethsys = <&ethsys>;
+
+		mediatek,switch = <&gsw>;
+
+		mdio-bus {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			phy1f: ethernet-phy@1f {
+				reg = <0x1f>;
+				phy-mode = "rgmii";
+			};
+		};
+	};
+
+	gsw: gsw@1e110000 {
+		compatible = "mediatek,mt7621-gsw";
+		reg = <0x1e110000 0x8000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 23 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pcie: pcie@1e140000 {
+		compatible = "mediatek,mt7621-pci";
+		reg = <0x1e140000 0x100
+			0x1e142000 0x100>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_pins>;
+
+		device_type = "pci";
+
+		bus-range = <0 255>;
+		ranges = <
+			0x02000000 0 0x00000000 0x60000000 0 0x10000000 /* pci memory */
+			0x01000000 0 0x00000000 0x1e160000 0 0x00010000 /* io space */
+		>;
+
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH
+				GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH
+				GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
+
+		status = "disabled";
+
+		resets = <&rstctrl 24 &rstctrl 25 &rstctrl 26>;
+		reset-names = "pcie0", "pcie1", "pcie2";
+		clocks = <&clkctrl 24 &clkctrl 25 &clkctrl 26>;
+		clock-names = "pcie0", "pcie1", "pcie2";
+
+		pcie0 {
+			reg = <0x0000 0 0 0 0>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			device_type = "pci";
+		};
+
+		pcie1 {
+			reg = <0x0800 0 0 0 0>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			device_type = "pci";
+		};
+
+		pcie2 {
+			reg = <0x1000 0 0 0 0>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			device_type = "pci";
+		};
+	};
+};
