Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 775DCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8C820693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8C820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933312AbeFLFl1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:41:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:62700 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933164AbeFLFlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:41:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 22:41:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="56366546"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2018 22:41:13 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com
Cc:     linux-mips@linux-mips.org, qi-ming.wu@intel.com,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/7] MIPS: intel: Add initial support for Intel MIPS SoCs
Date:   Tue, 12 Jun 2018 13:40:30 +0800
Message-Id: <20180612054034.4969-4-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180612054034.4969-1-songjun.wu@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hua Ma <hua.ma@linux.intel.com>

Add initial support for Intel MIPS interAptiv SoCs made by Intel.
This series will add support for the GRX500 family.

The series allows booting a minimal system using a initramfs.

Signed-off-by: Hua ma <hua.ma@linux.intel.com>
Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  36 ++++
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/intel-mips/Makefile             |   3 +
 arch/mips/boot/dts/intel-mips/easy350_anywan.dts   |  20 +++
 arch/mips/boot/dts/intel-mips/xrx500.dtsi          | 196 +++++++++++++++++++++
 arch/mips/configs/grx500_defconfig                 | 165 +++++++++++++++++
 .../asm/mach-intel-mips/cpu-feature-overrides.h    |  61 +++++++
 arch/mips/include/asm/mach-intel-mips/ioremap.h    |  39 ++++
 arch/mips/include/asm/mach-intel-mips/irq.h        |  17 ++
 .../asm/mach-intel-mips/kernel-entry-init.h        |  76 ++++++++
 arch/mips/include/asm/mach-intel-mips/spaces.h     |  29 +++
 arch/mips/include/asm/mach-intel-mips/war.h        |  18 ++
 arch/mips/intel-mips/Kconfig                       |  22 +++
 arch/mips/intel-mips/Makefile                      |   3 +
 arch/mips/intel-mips/Platform                      |  11 ++
 arch/mips/intel-mips/irq.c                         |  36 ++++
 arch/mips/intel-mips/prom.c                        | 184 +++++++++++++++++++
 arch/mips/intel-mips/time.c                        |  56 ++++++
 19 files changed, 974 insertions(+)
 create mode 100644 arch/mips/boot/dts/intel-mips/Makefile
 create mode 100644 arch/mips/boot/dts/intel-mips/easy350_anywan.dts
 create mode 100644 arch/mips/boot/dts/intel-mips/xrx500.dtsi
 create mode 100644 arch/mips/configs/grx500_defconfig
 create mode 100644 arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/ioremap.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/irq.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/spaces.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/war.h
 create mode 100644 arch/mips/intel-mips/Kconfig
 create mode 100644 arch/mips/intel-mips/Makefile
 create mode 100644 arch/mips/intel-mips/Platform
 create mode 100644 arch/mips/intel-mips/irq.c
 create mode 100644 arch/mips/intel-mips/prom.c
 create mode 100644 arch/mips/intel-mips/time.c

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index ac7ad54f984f..bcd647060f3e 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -12,6 +12,7 @@ platforms += cobalt
 platforms += dec
 platforms += emma
 platforms += generic
+platforms += intel-mips
 platforms += jazz
 platforms += jz4740
 platforms += lantiq
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 225c95da23ce..c82cebeb6192 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -404,6 +404,41 @@ config LANTIQ
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 
+config INTEL_MIPS
+	bool "Intel MIPS interAptiv SoC based platforms"
+	select ARCH_HAS_RESET_CONTROLLER
+	select ARCH_SUPPORTS_MSI
+	select BOOT_RAW
+	select CEVT_R4K
+	select COMMON_CLK
+	select CPU_MIPS32_3_5_EVA
+	select CPU_MIPS32_3_5_FEATURES
+	select CPU_MIPSR2_IRQ_EI
+	select CPU_MIPSR2_IRQ_VI
+	select CSRC_R4K
+	select DMA_NONCOHERENT
+	select GENERIC_ISA_DMA
+	select GPIOLIB
+	select HW_HAS_PCI
+	select IRQ_MIPS_CPU
+	select MFD_CORE
+	select MFD_SYSCON
+	select MIPS_CPU_SCACHE
+	select MIPS_GIC
+	select PCI_DRIVERS_GENERIC
+	select RESET_CONTROLLER
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_CPU_MIPS32_R3_5
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_MIPS_CPS
+	select SYS_SUPPORTS_MULTITHREADING
+	select SYS_SUPPORTS_ZBOOT
+	select TIMER_OF
+	select USE_OF
+
 config LASAT
 	bool "LASAT Networks platforms"
 	select CEVT_R4K
@@ -1010,6 +1045,7 @@ source "arch/mips/bcm47xx/Kconfig"
 source "arch/mips/bcm63xx/Kconfig"
 source "arch/mips/bmips/Kconfig"
 source "arch/mips/generic/Kconfig"
+source "arch/mips/intel-mips/Kconfig"
 source "arch/mips/jazz/Kconfig"
 source "arch/mips/jz4740/Kconfig"
 source "arch/mips/lantiq/Kconfig"
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 1e79cab8e269..05f52f279047 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -3,6 +3,7 @@ subdir-y	+= brcm
 subdir-y	+= cavium-octeon
 subdir-y	+= img
 subdir-y	+= ingenic
+subdir-y	+= intel-mips
 subdir-y	+= lantiq
 subdir-y	+= mscc
 subdir-y	+= mti
diff --git a/arch/mips/boot/dts/intel-mips/Makefile b/arch/mips/boot/dts/intel-mips/Makefile
new file mode 100644
index 000000000000..b16c0081639c
--- /dev/null
+++ b/arch/mips/boot/dts/intel-mips/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_DTB_INTEL_MIPS_GRX500)	+= easy350_anywan.dtb
+obj-y	+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/arch/mips/boot/dts/intel-mips/easy350_anywan.dts b/arch/mips/boot/dts/intel-mips/easy350_anywan.dts
new file mode 100644
index 000000000000..40177f6cee1e
--- /dev/null
+++ b/arch/mips/boot/dts/intel-mips/easy350_anywan.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/mips-gic.h>
+#include <dt-bindings/clock/intel,grx500-clk.h>
+
+#include "xrx500.dtsi"
+
+/ {
+	model = "EASY350 ANYWAN (GRX350) Main model";
+	chosen {
+		bootargs = "earlycon=lantiq,0x16600000 clk_ignore_unused";
+		stdout-path = "serial0";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x20000000 0x0e000000>;
+	};
+};
diff --git a/arch/mips/boot/dts/intel-mips/xrx500.dtsi b/arch/mips/boot/dts/intel-mips/xrx500.dtsi
new file mode 100644
index 000000000000..04a068d6d96b
--- /dev/null
+++ b/arch/mips/boot/dts/intel-mips/xrx500.dtsi
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "intel,xrx500";
+
+	aliases {
+		serial0 = &asc0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "mti,interaptiv";
+			clocks = <&cpuclk>;
+			reg = <0>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "mti,interaptiv";
+			reg = <1>;
+		};
+	};
+
+	cpu_intc: interrupt-controller {
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	gic: gic@12320000 {
+		compatible = "mti,gic";
+		reg = <0x12320000 0x20000>;
+
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		/*
+		 * Declare the interrupt-parent even though the mti,gic
+		 * binding doesn't require it, such that the kernel can
+		 * figure out that cpu_intc is the root interrupt
+		 * controller & should be probed first.
+		 */
+		interrupt-parent = <&cpu_intc>;
+		mti,reserved-ipi-vectors = <56 8>;
+	};
+
+	cgu0: cgu@16200000 {
+		compatible = "syscon";
+		reg = <0x16200000 0x100000>;
+
+		clock {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			osc0: osc0 {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <40000000>;
+				clock-output-names = "osc40M";
+			};
+
+			pll0a: pll0a {
+				#clock-cells = <0>;
+				compatible = "fixed-factor-clock";
+				clock-mult = <0x3C>;
+				clock-div = <1>;
+				clocks = <&osc0>;
+				clock-output-names = "pll0a";
+			};
+
+			pll0b: pll0b {
+				#clock-cells = <0>;
+				compatible = "fixed-factor-clock";
+				clock-mult = <0x32>;
+				clock-div = <1>;
+				clocks = <&osc0>;
+				clock-output-names = "pll0b";
+			};
+
+			pll3: pll3 {
+				#clock-cells = <0>;
+				compatible = "fixed-factor-clock";
+				clock-mult = <0x64>;
+				clock-div = <1>;
+				clocks = <&osc0>;
+				clock-output-names = "lcpll3";
+			};
+
+			pll0aclk: pll0aclk {
+				#clock-cells = <1>;
+				compatible = "intel,grx500-pll0a-clk";
+				clocks = <&pll0a>;
+				reg = <0x8>;
+				clock-output-names = "cbm", "ngi",
+				"ssx4", "cpu0";
+			};
+
+			pll0bclk: pll0bclk {
+				#clock-cells = <1>;
+				compatible = "intel,grx500-pll0b-clk";
+				clocks = <&pll0b>;
+				reg = <0x38>;
+				clock-output-names = "pae", "gswip", "ddr",
+				"cpu1";
+			};
+
+			ddrphyclk: ddrphyclk {
+				#clock-cells = <0>;
+				compatible = "fixed-factor-clock";
+				clock-mult = <2>;
+				clock-div = <1>;
+				clocks = <&pll0bclk DDR_CLK>;
+				clock-output-names = "ddrphy";
+			};
+
+			pcieclk: pcieclk {
+				#clock-cells = <0>;
+				compatible = "intel,grx500-pcie-clk";
+				clocks = <&pll3>;
+				reg = <0x98>;
+				clock-output-names = "pcie";
+			};
+
+			cpuclk: cpuclk {
+				#clock-cells = <0>;
+				compatible = "intel,grx500-cpu-clk";
+				clocks = <&pll0aclk CPU0_CLK>,
+				<&pll0bclk CPU1_CLK>;
+				reg = <0x8>;
+				clock-output-names = "cpu";
+			};
+
+			clkgate0: clkgate0 {
+				#clock-cells = <1>;
+				compatible = "intel,grx500-gate0-clk";
+				reg = <0x114>;
+				clock-output-names = "gate_xbar0", "gate_xbar1",
+				"gate_xbar2", "gate_xbar3", "gate_xbar6",
+				"gate_xbar7";
+			};
+
+			clkgate1: clkgate1 {
+				#clock-cells = <1>;
+				compatible = "intel,grx500-gate1-clk";
+				reg = <0x120>;
+				clock-output-names = "gate_vcodec", "gate_dma0",
+				"gate_usb0", "gate_spi1", "gate_spi0",
+				"gate_cbm", "gate_ebu", "gate_sso",
+				"gate_gptc0", "gate_gptc1", "gate_gptc2",
+				"gate_urt", "gate_eip97", "gate_eip123",
+				"gate_toe", "gate_mpe", "gate_tdm", "gate_pae",
+				"gate_usb1", "gate_gswip";
+			};
+
+			clkgate2: clkgate2 {
+				#clock-cells = <1>;
+				compatible = "intel,grx500-gate2-clk";
+				reg = <0x130>;
+				clock-output-names = "gate_pcie0", "gate_pcie1",
+				"gate_pcie2";
+			};
+
+			voiceclk: voiceclk {
+				#clock-cells = <0>;
+				compatible = "intel,grx500-voice-clk";
+				clock-frequency = <8192000>;
+				reg = <0xc4>;
+				clock-output-names = "voice";
+			};
+
+			i2cclk: i2cclk {
+				#clock-cells = <0>;
+				compatible = "intel,grx500-gate-dummy-clk";
+				clock-output-names = "gate_i2c";
+			};
+		};
+	};
+
+	asc0: serial@16600000 {
+		compatible = "lantiq,asc";
+		reg = <0x16600000 0x100000>;
+
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&pll0aclk SSX4_CLK>, <&clkgate1 GATE_URT_CLK>;
+		clock-names = "freq", "asc";
+	};
+};
diff --git a/arch/mips/configs/grx500_defconfig b/arch/mips/configs/grx500_defconfig
new file mode 100644
index 000000000000..d353b74dddcd
--- /dev/null
+++ b/arch/mips/configs/grx500_defconfig
@@ -0,0 +1,165 @@
+CONFIG_INTEL_MIPS=y
+CONFIG_DTB_INTEL_MIPS_GRX500=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_SCHED_SMT=y
+# CONFIG_MIPS_MT_FPAFF is not set
+CONFIG_MIPS_CPS=y
+CONFIG_KSM=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
+CONFIG_CLEANCACHE=y
+CONFIG_FRONTSWAP=y
+CONFIG_CMA=y
+CONFIG_CMA_DEBUGFS=y
+CONFIG_ZSWAP=y
+CONFIG_ZBUD=y
+CONFIG_Z3FOLD=y
+CONFIG_ZSMALLOC=y
+CONFIG_PGTABLE_MAPPING=y
+CONFIG_HOTPLUG_CPU=y
+CONFIG_NR_CPUS=2
+CONFIG_HZ_100=y
+# CONFIG_SECCOMP is not set
+CONFIG_CROSS_COMPILE=""
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_DEFAULT_HOSTNAME="GRX500"
+CONFIG_SYSVIPC=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_RCU_EXPERT=y
+CONFIG_LOG_BUF_SHIFT=18
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_INITRAMFS_ROOT_UID=11609386
+CONFIG_INITRAMFS_ROOT_GID=2222
+# CONFIG_RD_GZIP is not set
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+CONFIG_INITRAMFS_COMPRESSION_XZ=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL_SYSCALL=y
+# CONFIG_FHANDLE is not set
+# CONFIG_AIO is not set
+CONFIG_BPF_SYSCALL=y
+CONFIG_USERFAULTFD=y
+CONFIG_EMBEDDED=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_CC_STACKPROTECTOR_STRONG=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_BLK_DEV_BSGLIB=y
+CONFIG_BLK_DEV_INTEGRITY=y
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET6_XFRM_MODE_BEET is not set
+# CONFIG_IPV6_SIT is not set
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IPV6_SUBTREES=y
+CONFIG_IPV6_MROUTE=y
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_MARK=y
+CONFIG_NETFILTER_XT_MARK=m
+CONFIG_NETFILTER_XT_TARGET_LOG=m
+CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
+CONFIG_NETFILTER_XT_MATCH_COMMENT=m
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
+CONFIG_NETFILTER_XT_MATCH_LIMIT=m
+CONFIG_NETFILTER_XT_MATCH_MAC=m
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
+CONFIG_NETFILTER_XT_MATCH_STATE=m
+CONFIG_NETFILTER_XT_MATCH_TIME=m
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_NAT=m
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_TARGET_REDIRECT=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_NF_CONNTRACK_IPV6=m
+CONFIG_IP6_NF_IPTABLES=m
+CONFIG_IP6_NF_FILTER=m
+CONFIG_IP6_NF_TARGET_REJECT=m
+CONFIG_IP6_NF_MANGLE=m
+CONFIG_ATM=m
+CONFIG_ATM_BR2684=m
+CONFIG_DMA_CMA=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=4
+CONFIG_BLK_DEV_RAM_SIZE=8192
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+# CONFIG_CONSOLE_TRANSLATIONS is not set
+# CONFIG_VT_CONSOLE is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVMEM is not set
+CONFIG_SERIAL_LANTIQ=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+# CONFIG_HWMON is not set
+# CONFIG_VGA_CONSOLE is not set
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_VIRTIO_MENU is not set
+# CONFIG_MIPS_PLATFORM_DEVICES is not set
+CONFIG_COMMON_CLK_INTEL=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXPORTFS_BLOCK_OPS=y
+# CONFIG_MANDATORY_FILE_LOCKING is not set
+CONFIG_QUOTA=y
+# CONFIG_PRINT_QUOTA_WARNING is not set
+CONFIG_AUTOFS4_FS=y
+CONFIG_FSCACHE=y
+CONFIG_FSCACHE_STATS=y
+CONFIG_FSCACHE_OBJECT_LIST=y
+CONFIG_CACHEFILES=y
+CONFIG_PROC_KCORE=y
+# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_PROC_CHILDREN=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_XATTR=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_XATTR=y
+CONFIG_SQUASHFS_LZ4=y
+CONFIG_SQUASHFS_LZO=y
+CONFIG_SQUASHFS_XZ=y
+CONFIG_NLS=y
+CONFIG_PRINTK_TIME=y
+CONFIG_BOOT_PRINTK_DELAY=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+CONFIG_FRAME_WARN=2048
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_UNUSED_SYMBOLS=y
+CONFIG_DEBUG_FS=y
+CONFIG_HEADERS_CHECK=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_VM=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_DEBUG_STACKOVERFLOW=y
+CONFIG_DEBUG_RT_MUTEXES=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+# CONFIG_RCU_TRACE is not set
+CONFIG_LATENCYTOP=y
+# CONFIG_FTRACE is not set
+CONFIG_ATOMIC64_SELFTEST=y
+CONFIG_TEST_KSTRTOX=y
+# CONFIG_EARLY_PRINTK is not set
+CONFIG_CRYPTO_CCM=y
+CONFIG_CRYPTO_GCM=y
+# CONFIG_CRYPTO_ECHAINIV is not set
+CONFIG_CRYPTO_ARC4=y
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC_CCITT=y
+CONFIG_CRC16=y
+CONFIG_LIBCRC32C=y
+CONFIG_IRQ_POLL=y
diff --git a/arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h b/arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h
new file mode 100644
index 000000000000..ac5f3b943d2a
--- /dev/null
+++ b/arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This file was derived from: include/asm-mips/cpu-features.h
+ *	Copyright (C) 2003, 2004 Ralf Baechle
+ *	Copyright (C) 2004 Maciej W. Rozycki
+ *	Copyright (C) 2018 Intel Corporation.
+ */
+
+#ifndef __ASM_MACH_INTEL_MIPS_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_INTEL_MIPS_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_has_tlb		1
+#define cpu_has_4kex		1
+#define cpu_has_3k_cache	0
+#define cpu_has_4k_cache	1
+#define cpu_has_tx39_cache	0
+#define cpu_has_sb1_cache	0
+#define cpu_has_fpu		0
+#define cpu_has_32fpr		0
+#define cpu_has_counter		1
+#define cpu_has_watch		1
+#define cpu_has_divec		1
+
+#define cpu_has_prefetch	1
+#define cpu_has_ejtag		1
+#define cpu_has_llsc		1
+
+#define cpu_has_mips16		0
+#define cpu_has_mdmx		0
+#define cpu_has_mips3d		0
+#define cpu_has_smartmips	0
+#define cpu_has_mmips		0
+#define cpu_has_vz		0
+
+#define cpu_has_mips32r1	1
+#define cpu_has_mips32r2	1
+#define cpu_has_mips64r1	0
+#define cpu_has_mips64r2	0
+
+#define cpu_has_dsp		1
+#define cpu_has_dsp2		0
+#define cpu_has_mipsmt		1
+
+#define cpu_has_vint		1
+#define cpu_has_veic		0
+
+#define cpu_has_64bits		0
+#define cpu_has_64bit_zero_reg	0
+#define cpu_has_64bit_gp_regs	0
+#define cpu_has_64bit_addresses	0
+
+#define cpu_has_cm2		1
+#define cpu_has_cm2_l2sync	1
+#define cpu_has_eva		1
+#define cpu_has_tlbinv		1
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	32
+#define cpu_scache_line_size()	32
+
+#endif /* __ASM_MACH_INTEL_MIPS_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-intel-mips/ioremap.h b/arch/mips/include/asm/mach-intel-mips/ioremap.h
new file mode 100644
index 000000000000..99b20ed0b457
--- /dev/null
+++ b/arch/mips/include/asm/mach-intel-mips/ioremap.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2014 Lei Chuanhua <Chuanhua.lei@lantiq.com>
+ *  Copyright (C) 2018 Intel Corporation.
+ */
+#ifndef __ASM_MACH_INTEL_MIPS_IOREMAP_H
+#define __ASM_MACH_INTEL_MIPS_IOREMAP_H
+
+#include <linux/types.h>
+
+static inline phys_addr_t fixup_bigphys_addr(phys_addr_t phys_addr,
+					     phys_addr_t size)
+{
+	return phys_addr;
+}
+
+/*
+ * TOP IO Space definition for SSX7 components /PCIe/ToE/Memcpy
+ * physical 0xa0000000 --> virtual 0xe0000000
+ */
+#define GRX500_TOP_IOREMAP_BASE			0xA0000000
+#define GRX500_TOP_IOREMAP_SIZE			0x20000000
+#define GRX500_TOP_IOREMAP_PHYS_VIRT_OFFSET	0x40000000
+
+static inline void __iomem *plat_ioremap(phys_addr_t offset, unsigned long size,
+					 unsigned long flags)
+{
+	if (offset >= GRX500_TOP_IOREMAP_BASE &&
+	    offset < (GRX500_TOP_IOREMAP_BASE + GRX500_TOP_IOREMAP_SIZE))
+		return (void __iomem *)(unsigned long)
+			(offset + GRX500_TOP_IOREMAP_PHYS_VIRT_OFFSET);
+	return NULL;
+}
+
+static inline int plat_iounmap(const volatile void __iomem *addr)
+{
+	return (unsigned long)addr >= (unsigned long)GRX500_TOP_IOREMAP_BASE;
+}
+#endif /* __ASM_MACH_INTEL_MIPS_IOREMAP_H */
diff --git a/arch/mips/include/asm/mach-intel-mips/irq.h b/arch/mips/include/asm/mach-intel-mips/irq.h
new file mode 100644
index 000000000000..12a949084856
--- /dev/null
+++ b/arch/mips/include/asm/mach-intel-mips/irq.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2014 Lei Chuanhua <Chuanhua.lei@lantiq.com>
+ *  Copyright (C) 2018 Intel Corporation.
+ */
+
+#ifndef __INTEL_MIPS_IRQ_H
+#define __INTEL_MIPS_IRQ_H
+
+#define MIPS_CPU_IRQ_BASE	0
+#define MIPS_GIC_IRQ_BASE	(MIPS_CPU_IRQ_BASE + 8)
+
+#define NR_IRQS 256
+
+#include_next <irq.h>
+
+#endif /* __INTEL_MIPS_IRQ_H */
diff --git a/arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h b/arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h
new file mode 100644
index 000000000000..3893855b60c6
--- /dev/null
+++ b/arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Chris Dearman (chris@mips.com)
+ * Leonid Yegoshin (yegoshin@mips.com)
+ * Copyright (C) 2012 Mips Technologies, Inc.
+ * Copyright (C) 2018 Intel Corporation.
+ */
+#ifndef __ASM_MACH_INTEL_MIPS_KERNEL_ENTRY_INIT_H
+#define __ASM_MACH_INTEL_MIPS_KERNEL_ENTRY_INIT_H
+
+	.macro  platform_eva_init
+
+	.set    push
+	.set    reorder
+	/*
+	 * Get Config.K0 value and use it to program
+	 * the segmentation registers
+	 */
+	mfc0    t1, CP0_CONFIG
+	andi    t1, 0x7 /* CCA */
+	move    t2, t1
+	ins     t2, t1, 16, 3
+	/* SegCtl0 */
+	li      t0, ((MIPS_SEGCFG_UK << MIPS_SEGCFG_AM_SHIFT) |              \
+		(5 << MIPS_SEGCFG_PA_SHIFT) | (2 << MIPS_SEGCFG_C_SHIFT) |   \
+		(1 << MIPS_SEGCFG_EU_SHIFT)) |                               \
+		(((MIPS_SEGCFG_MSK << MIPS_SEGCFG_AM_SHIFT) |                \
+		(0 << MIPS_SEGCFG_PA_SHIFT) |                                \
+		(1 << MIPS_SEGCFG_EU_SHIFT)) << 16)
+	ins     t0, t1, 16, 3
+	mtc0    t0, $5, 2
+
+	/* SegCtl1 */
+	li      t0, ((MIPS_SEGCFG_UK << MIPS_SEGCFG_AM_SHIFT) |              \
+		(1 << MIPS_SEGCFG_PA_SHIFT) | (2 << MIPS_SEGCFG_C_SHIFT) |   \
+		(1 << MIPS_SEGCFG_EU_SHIFT)) |                               \
+		(((MIPS_SEGCFG_UK << MIPS_SEGCFG_AM_SHIFT) |                 \
+		(2 << MIPS_SEGCFG_PA_SHIFT) |                                \
+		(1 << MIPS_SEGCFG_EU_SHIFT)) << 16)
+	ins     t0, t1, 16, 3
+	mtc0    t0, $5, 3
+
+	/* SegCtl2 */
+	li      t0, ((MIPS_SEGCFG_MUSUK << MIPS_SEGCFG_AM_SHIFT) |           \
+		(0 << MIPS_SEGCFG_PA_SHIFT) |                                \
+		(1 << MIPS_SEGCFG_EU_SHIFT)) |                               \
+		(((MIPS_SEGCFG_MUSK << MIPS_SEGCFG_AM_SHIFT) |               \
+		(0 << MIPS_SEGCFG_PA_SHIFT)/*| (2 << MIPS_SEGCFG_C_SHIFT)*/ | \
+		(1 << MIPS_SEGCFG_EU_SHIFT)) << 16)
+	ins     t0, t1, 0, 3
+	mtc0    t0, $5, 4
+
+	jal     mips_ihb
+	mfc0    t0, $16, 5
+	li      t2, 0x40000000      /* K bit */
+	or      t0, t0, t2
+	mtc0    t0, $16, 5
+	sync
+	jal     mips_ihb
+
+	.set    pop
+	.endm
+
+	.macro	kernel_entry_setup
+	sync
+	ehb
+	platform_eva_init
+	.endm
+
+	.macro	smp_slave_setup
+	sync
+	ehb
+	platform_eva_init
+	.endm
+
+#endif /* __ASM_MACH_INTEL_MIPS_KERNEL_ENTRY_INIT_H */
diff --git a/arch/mips/include/asm/mach-intel-mips/spaces.h b/arch/mips/include/asm/mach-intel-mips/spaces.h
new file mode 100644
index 000000000000..abce53a65157
--- /dev/null
+++ b/arch/mips/include/asm/mach-intel-mips/spaces.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Leonid Yegoshin (yegoshin@mips.com)
+ * Copyright (C) 2012 MIPS Technologies, Inc.
+ * Copyright (C) 2014 Lei Chuanhua <Chuanhua.lei@lantiq.com>
+ * Copyright (C) 2018 Intel Corporation.
+ */
+
+#ifndef _ASM_INTEL_MIPS_SPACES_H
+#define _ASM_INTEL_MIPS_SPACES_H
+
+#include <linux/sizes.h>
+
+#define PAGE_OFFSET		_AC(0x60000000, UL)
+#define PHYS_OFFSET		_AC(0x20000000, UL)
+
+/* No Highmem Support */
+#define HIGHMEM_START		_AC(0xffff0000, UL)
+
+#define FIXADDR_TOP		((unsigned long)(long)(int)0xcffe0000)
+
+#define IO_SIZE			_AC(0x10000000, UL)
+#define IO_SHIFT		_AC(0x10000000, UL)
+
+/* IO space one */
+#define __pa_symbol(x)		__pa(x)
+
+#include <asm/mach-generic/spaces.h>
+#endif /* __ASM_INTEL_MIPS_SPACES_H */
diff --git a/arch/mips/include/asm/mach-intel-mips/war.h b/arch/mips/include/asm/mach-intel-mips/war.h
new file mode 100644
index 000000000000..1c95553151e1
--- /dev/null
+++ b/arch/mips/include/asm/mach-intel-mips/war.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MIPS_MACH_INTEL_MIPS_WAR_H
+#define __ASM_MIPS_MACH_INTEL_MIPS_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_INTEL_MIPS_WAR_H */
diff --git a/arch/mips/intel-mips/Kconfig b/arch/mips/intel-mips/Kconfig
new file mode 100644
index 000000000000..35d2ae2b5408
--- /dev/null
+++ b/arch/mips/intel-mips/Kconfig
@@ -0,0 +1,22 @@
+if INTEL_MIPS
+
+choice
+	prompt "Built-in device tree"
+	help
+	  Legacy bootloaders do not pass a DTB pointer to the kernel, so
+	  if a "wrapper" is not being used, the kernel will need to include
+	  a device tree that matches the target board.
+
+	  The builtin DTB will only be used if the firmware does not supply
+	  a valid DTB.
+
+config DTB_INTEL_MIPS_NONE
+	bool "None"
+
+config DTB_INTEL_MIPS_GRX500
+	bool "Intel MIPS GRX500 Board"
+	select BUILTIN_DTB
+
+endchoice
+
+endif
diff --git a/arch/mips/intel-mips/Makefile b/arch/mips/intel-mips/Makefile
new file mode 100644
index 000000000000..9f272d06eecd
--- /dev/null
+++ b/arch/mips/intel-mips/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_INTEL_MIPS)	+= prom.o irq.o time.o
diff --git a/arch/mips/intel-mips/Platform b/arch/mips/intel-mips/Platform
new file mode 100644
index 000000000000..b34750eeaeb0
--- /dev/null
+++ b/arch/mips/intel-mips/Platform
@@ -0,0 +1,11 @@
+#
+# MIPs SoC platform
+#
+
+platform-$(CONFIG_INTEL_MIPS)			+= intel-mips/
+cflags-$(CONFIG_INTEL_MIPS)			+= -I$(srctree)/arch/mips/include/asm/mach-intel-mips
+ifdef CONFIG_EVA
+	load-$(CONFIG_INTEL_MIPS)		= 0xffffffff60020000
+else
+	load-$(CONFIG_INTEL_MIPS)		= 0xffffffff80020000
+endif
diff --git a/arch/mips/intel-mips/irq.c b/arch/mips/intel-mips/irq.c
new file mode 100644
index 000000000000..00637a5cdd20
--- /dev/null
+++ b/arch/mips/intel-mips/irq.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Intel Corporation.
+ */
+#include <linux/init.h>
+#include <linux/irqchip.h>
+#include <linux/of_irq.h>
+#include <asm/irq.h>
+
+#include <asm/irq_cpu.h>
+
+void __init arch_init_irq(void)
+{
+	struct device_node *intc_node;
+
+	pr_info("EIC is %s\n", cpu_has_veic ? "on" : "off");
+	pr_info("VINT is %s\n", cpu_has_vint ? "on" : "off");
+
+	intc_node = of_find_compatible_node(NULL, NULL,
+					    "mti,cpu-interrupt-controller");
+	if (!cpu_has_veic && !intc_node)
+		mips_cpu_irq_init();
+
+	irqchip_init();
+}
+
+int get_c0_perfcount_int(void)
+{
+	return gic_get_c0_perfcount_int();
+}
+EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
+
+unsigned int get_c0_compare_int(void)
+{
+	return gic_get_c0_compare_int();
+}
diff --git a/arch/mips/intel-mips/prom.c b/arch/mips/intel-mips/prom.c
new file mode 100644
index 000000000000..9407858ddc94
--- /dev/null
+++ b/arch/mips/intel-mips/prom.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2014 Lei Chuanhua <Chuanhua.lei@lantiq.com>
+ * Copyright (C) 2016 Intel Corporation.
+ */
+#include <linux/init.h>
+#include <linux/export.h>
+#include <linux/of_platform.h>
+#include <linux/of_fdt.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <asm/mips-cps.h>
+#include <asm/smp-ops.h>
+#include <asm/dma-coherence.h>
+#include <asm/prom.h>
+
+#define IOPORT_RESOURCE_START   0x10000000
+#define IOPORT_RESOURCE_END     0xffffffff
+#define IOMEM_RESOURCE_START    0x10000000
+#define IOMEM_RESOURCE_END      0xffffffff
+
+const char *get_system_type(void)
+{
+	return "Intel MIPS interAptiv SoC";
+}
+
+void prom_free_prom_memory(void)
+{
+}
+
+static void __init prom_init_cmdline(void)
+{
+	int i;
+	int argc;
+	char **argv;
+
+	/*
+	 * If u-boot pass parameters, it is ok, however, if without u-boot
+	 * JTAG or other tool has to reset all register value before it goes
+	 * emulation most likely belongs to this category
+	 */
+	if (fw_arg0 == 0 || fw_arg1 == 0)
+		return;
+
+	argc = fw_arg0;
+	argv = (char **)KSEG1ADDR(fw_arg1);
+
+	arcs_cmdline[0] = '\0';
+
+	for (i = 0; i < argc; i++) {
+		char *p = (char *)KSEG1ADDR(argv[i]);
+
+		if (argv[i] && *p) {
+			strlcat(arcs_cmdline, p, sizeof(arcs_cmdline));
+			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
+		}
+	}
+}
+
+static int __init plat_enable_iocoherency(void)
+{
+	int supported = 0;
+
+	if (mips_cps_numiocu(0) != 0) {
+		/* Nothing special needs to be done to enable coherency */
+		pr_info("Coherence Manager IOCU detected\n");
+		/* Second IOCU for MPE or other master access register */
+		write_gcr_reg0_base(0xa0000000);
+		write_gcr_reg0_mask(0xf8000000 | CM_GCR_REGn_MASK_CMTGT_IOCU1);
+		supported = 1;
+	}
+
+	/* hw_coherentio = supported; */
+
+	return supported;
+}
+
+static void __init plat_setup_iocoherency(void)
+{
+#ifdef CONFIG_DMA_NONCOHERENT
+	/*
+	 * Kernel has been configured with software coherency
+	 * but we might choose to turn it off and use hardware
+	 * coherency instead.
+	 */
+	if (plat_enable_iocoherency()) {
+		if (coherentio == IO_COHERENCE_DISABLED)
+			pr_info("Hardware DMA cache coherency disabled\n");
+		else
+			pr_info("Hardware DMA cache coherency enabled\n");
+	} else {
+		if (coherentio == IO_COHERENCE_ENABLED)
+			pr_info("Hardware DMA cache coherency unsupported, but enabled from command line!\n");
+		else
+			pr_info("Software DMA cache coherency enabled\n");
+	}
+#else
+	if (!plat_enable_iocoherency())
+		panic("Hardware DMA cache coherency not supported!");
+#endif
+}
+
+static void free_init_pages_eva_intel(void *begin, void *end)
+{
+	free_init_pages("unused kernel", __pa_symbol((unsigned long *)begin),
+			__pa_symbol((unsigned long *)end));
+}
+
+static void plat_early_init_devtree(void)
+{
+	void *dtb;
+
+	/*
+	 * Load the builtin devicetree. This causes the chosen node to be
+	 * parsed resulting in our memory appearing
+	 */
+	if (fw_passed_dtb) /* used by CONFIG_MIPS_APPENDED_RAW_DTB as well */
+		dtb = (void *)fw_passed_dtb;
+	else if (__dtb_start != __dtb_end)
+		dtb = (void *)__dtb_start;
+
+	if (dtb)
+		__dt_setup_arch(dtb);
+}
+
+void __init plat_mem_setup(void)
+{
+	ioport_resource.start = IOPORT_RESOURCE_START;
+	ioport_resource.end = ~0UL; /* No limit */
+	iomem_resource.start = IOMEM_RESOURCE_START;
+	iomem_resource.end = ~0UL; /* No limit */
+
+	set_io_port_base((unsigned long)KSEG1);
+
+	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+
+	plat_early_init_devtree();
+	plat_setup_iocoherency();
+
+	if (IS_ENABLED(CONFIG_EVA))
+		free_init_pages_eva = free_init_pages_eva_intel;
+	else
+		free_init_pages_eva = 0;
+}
+
+void __init device_tree_init(void)
+{
+	if (!initial_boot_params)
+		return;
+
+	unflatten_and_copy_device_tree();
+}
+
+#define CPC_BASE_ADDR		0x12310000
+
+phys_addr_t mips_cpc_default_phys_base(void)
+{
+	return CPC_BASE_ADDR;
+}
+
+void __init prom_init(void)
+{
+	prom_init_cmdline();
+
+	mips_cpc_probe();
+
+	if (!register_cps_smp_ops())
+		return;
+
+	if (!register_cmp_smp_ops())
+		return;
+
+	if (!register_vsmp_smp_ops())
+		return;
+}
+
+static int __init plat_publish_devices(void)
+{
+	if (!of_have_populated_dt())
+		return 0;
+	return of_platform_populate(NULL, of_default_bus_match_table, NULL,
+				    NULL);
+}
+arch_initcall(plat_publish_devices);
diff --git a/arch/mips/intel-mips/time.c b/arch/mips/intel-mips/time.c
new file mode 100644
index 000000000000..77ad4014fe9d
--- /dev/null
+++ b/arch/mips/intel-mips/time.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Intel Corporation.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/of.h>
+
+#include <asm/time.h>
+
+static inline u32 get_counter_resolution(void)
+{
+	u32 res;
+
+	__asm__ __volatile__(".set	push\n"
+			     ".set	mips32r2\n"
+			     "rdhwr	%0, $3\n"
+			     ".set pop\n"
+			     : "=&r" (res)
+			     : /* no input */
+			     : "memory");
+
+	return res;
+}
+
+void __init plat_time_init(void)
+{
+	unsigned long cpuclk;
+	struct device_node *np;
+	struct clk *clk;
+
+	of_clk_init(NULL);
+
+	np = of_get_cpu_node(0, NULL);
+	if (!np) {
+		pr_err("Failed to get CPU node\n");
+		return;
+	}
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get CPU clock: %ld\n", PTR_ERR(clk));
+		return;
+	}
+
+	cpuclk = clk_get_rate(clk);
+	mips_hpt_frequency = cpuclk / get_counter_resolution();
+	clk_put(clk);
+
+	write_c0_compare(read_c0_count());
+	pr_info("CPU Clock: %ldHz  mips_hpt_frequency %dHz\n",
+		cpuclk, mips_hpt_frequency);
+	timer_probe();
+}
-- 
2.11.0

