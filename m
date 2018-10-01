Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BF3C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D42E2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZgIbjQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D42E2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeJARHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:07:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38309 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbeJARHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:07:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so6749026wme.3;
        Mon, 01 Oct 2018 03:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tDB01RtK4t5o5xeWOtV4XTHQiqoJjaKRLQ0ID10bxt4=;
        b=iZgIbjQtbkG6fsKt3GFX0KTJKEXSHHnBsVH0EYEsXQuOtFw89z1WmXqpBrZvRsKL7x
         zhAJrjWXzuQdnqxA2JUFlZTxgc3Or8G46lVck71kfkq6rOKgN58d7CQYIRdKQCJ6NPFX
         vRc6f3I/N5LR5NqNAGCct7Dp0t9N87z0RVpycLyPwR5bXocODDf+fPliCXJkeliXGek/
         R+yVVc7zkGhcNJnexkL/f8gK7cDRvPMO7ekVIPdHOGGJSdvnv9ePVGr/LIRKMdseMzuP
         p6K3V9L+3bRJv3Cai9va9+HKtQG8OTtuf5myXmo5v3J6RgiFJgjkK1MJOd6e19I2EJh5
         nnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDB01RtK4t5o5xeWOtV4XTHQiqoJjaKRLQ0ID10bxt4=;
        b=Xm7bCDPEiIQEK3dab67DDLVuSiwO3VEpoJGZuI8fsa34OyUruw64YyPYYA9kX5a7d4
         RZY2ocskottIU9ByX4tGPjcChGX1riBduV9rWFI+SJPI+AimILZHHNK/y9pzrLld9H8W
         9g9BlQg5VQnkNBwQhRI9O2Y5Knbe/qWF71wdQQgP5bdNCeoVi0jDezoIgyTkk9opjN8w
         mX8LQZn9t65aWBQYOzXwTVHLGcE7mJVJLuT16zo2d3KcS7N35MR3MUTrS43rLgnbXEuG
         BmKr5MDUvDx7sU6kxRPpeu4M4zevnG7BF47hyoPeJbHWiqvbtffEASILMlXWRSGRiC0i
         5iSg==
X-Gm-Message-State: ABuFfohZGIpg3pk7yzohZx0kkt3T54dXv3trDkBYY+ycoWlzxL1E/ksq
        b8flexQE/p41dsikfBWfd54=
X-Google-Smtp-Source: ACcGV63AhYMUpXDLSm7vagHB9Yh++Tn01D2DOArn2tGa+qneeWPbz8rosFNnmJT3P6MsD0qhK/NWrQ==
X-Received: by 2002:a7b:c00a:: with SMTP id c10-v6mr3420813wmb.73.1538389828755;
        Mon, 01 Oct 2018 03:30:28 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id g8-v6sm2461169wmf.45.2018.10.01.03.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 03:30:28 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 7/7] MIPS: Add Realtek RTL8186 SoC support
Date:   Mon,  1 Oct 2018 13:29:52 +0300
Message-Id: <20181001102952.7913-8-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001102952.7913-1-yasha.che3@gmail.com>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Realtek RTL8186 SoC is a MIPS based SoC
used in some home routers [1][2].

The hardware includes Lexra LX5280 CPU with a TLB,
two Ethernet controllers, a WLAN controller and more.

With this patch, it is possible to successfully boot
the kernel and load userspace on the Edimax BR-6204Wg
router.
Network drivers support will come in future patches.

This patch includes:
- New MIPS rtl8186 platform (mostly DT based)
- defconfig file
- MIPS zboot UART support
- Device tree files for the RTL8186 SoC and Edimax BR-6204Wg
router

[1] https://www.linux-mips.org/wiki/Realtek_SOC#Realtek_RTL8186
[2] https://wikidevi.com/wiki/Realtek_RTL8186

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/Kbuild.platforms                    |   1 +
 arch/mips/Kconfig                             |  17 +++
 arch/mips/boot/compressed/uart-16550.c        |   5 +
 arch/mips/boot/dts/Makefile                   |   1 +
 arch/mips/boot/dts/realtek/Makefile           |   4 +
 arch/mips/boot/dts/realtek/rtl8186.dtsi       |  86 ++++++++++++++
 .../dts/realtek/rtl8186_edimax_br_6204wg.dts  |  45 +++++++
 arch/mips/configs/rtl8186_defconfig           | 112 ++++++++++++++++++
 arch/mips/include/asm/mach-rtl8186/rtl8186.h  |  37 ++++++
 arch/mips/rtl8186/Makefile                    |   2 +
 arch/mips/rtl8186/Platform                    |   7 ++
 arch/mips/rtl8186/irq.c                       |   8 ++
 arch/mips/rtl8186/prom.c                      |  15 +++
 arch/mips/rtl8186/setup.c                     |  80 +++++++++++++
 arch/mips/rtl8186/time.c                      |  10 ++
 15 files changed, 430 insertions(+)
 create mode 100644 arch/mips/boot/dts/realtek/Makefile
 create mode 100644 arch/mips/boot/dts/realtek/rtl8186.dtsi
 create mode 100644 arch/mips/boot/dts/realtek/rtl8186_edimax_br_6204wg.dts
 create mode 100644 arch/mips/configs/rtl8186_defconfig
 create mode 100644 arch/mips/include/asm/mach-rtl8186/rtl8186.h
 create mode 100644 arch/mips/rtl8186/Makefile
 create mode 100644 arch/mips/rtl8186/Platform
 create mode 100644 arch/mips/rtl8186/irq.c
 create mode 100644 arch/mips/rtl8186/prom.c
 create mode 100644 arch/mips/rtl8186/setup.c
 create mode 100644 arch/mips/rtl8186/time.c

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index ac7ad54f984f..2793741f05e5 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -27,6 +27,7 @@ platforms += pmcs-msp71xx
 platforms += pnx833x
 platforms += ralink
 platforms += rb532
+platforms += rtl8186
 platforms += sgi-ip22
 platforms += sgi-ip27
 platforms += sgi-ip32
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bbeabd6b0a80..2f2ef09a1961 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -344,6 +344,23 @@ config MACH_DECSTATION
 
 	  otherwise choose R3000.
 
+config MACH_RTL8186
+	bool "Realtek RTL8186 SoC"
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_HAS_CPU_LX5280
+	select DMA_NONCOHERENT
+	select SYS_SUPPORTS_ZBOOT_UART16550
+	select SYS_HAS_EARLY_PRINTK
+	select USE_GENERIC_EARLY_PRINTK_8250
+	select USE_OF
+	select COMMON_CLK
+	select RTL8186_IRQ
+	select RTL8186_TIMER
+	select BUILTIN_DTB
+	help
+	  Realtek RTL8186 SoC support.
+
 config MACH_JAZZ
 	bool "Jazz family of machines"
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
index aee8d7b8f091..99314df48718 100644
--- a/arch/mips/boot/compressed/uart-16550.c
+++ b/arch/mips/boot/compressed/uart-16550.c
@@ -35,6 +35,11 @@
 #define IOTYPE unsigned int
 #endif
 
+#ifdef CONFIG_MACH_RTL8186
+#define UART0_BASE 0xbd0100c3
+#define PORT(offset) (UART0_BASE + (4 * offset))
+#endif
+
 #ifndef IOTYPE
 #define IOTYPE char
 #endif
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 1e79cab8e269..50dc192bbde5 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -11,6 +11,7 @@ subdir-y	+= ni
 subdir-y	+= pic32
 subdir-y	+= qca
 subdir-y	+= ralink
+subdir-y	+= realtek
 subdir-y	+= xilfpga
 
 obj-$(CONFIG_BUILTIN_DTB)	:= $(addsuffix /, $(subdir-y))
diff --git a/arch/mips/boot/dts/realtek/Makefile b/arch/mips/boot/dts/realtek/Makefile
new file mode 100644
index 000000000000..654c3a8da574
--- /dev/null
+++ b/arch/mips/boot/dts/realtek/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_MACH_RTL8186)	+= rtl8186_edimax_br_6204wg.dtb
+
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/realtek/rtl8186.dtsi b/arch/mips/boot/dts/realtek/rtl8186.dtsi
new file mode 100644
index 000000000000..d172999a42a6
--- /dev/null
+++ b/arch/mips/boot/dts/realtek/rtl8186.dtsi
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "realtek,rtl8186-soc";
+
+	interrupt-parent = <&intc>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "lexra,lx5280";
+			reg = <0>;
+			clocks = <&cpu_clk>;
+			d-cache-size = <8192>;
+			i-cache-size = <8192>;
+			d-cache-line-size = <16>;
+			i-cache-line-size = <16>;
+			tlb-entries = <16>;
+		};
+	};
+
+	cpu_clk: cpu_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>; /* Stub. Varies with boards */
+	};
+
+	sysclk: sysclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <22000000>; /* 22MHz */
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1d010000 0x1000>;
+
+		intc: interrupt-controller@1d010000 {
+			compatible = "realtek,rtl8186-intc";
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			reg = <0x0 0x8>;
+		};
+
+		timer {
+			compatible = "realtek,rtl8186-timer";
+			interrupts = <0>;
+			clocks = <&sysclk>;
+
+			reg = <0x50 0x30>;
+		};
+
+		uart0: serial@1d0100c3 {
+			compatible = "ns16550a";
+			reg = <0xc3 0x20>;
+			reg-io-width = <1>;
+			reg-shift = <2>;
+			interrupts = <3>;
+			clocks = <&cpu_clk>;
+			fifo-size = <16>;
+
+			status = "disabled";
+		};
+
+		uart1: serial@1d0100e3 {
+			compatible = "ns16550a";
+			reg = <0xe3 0x20>;
+			reg-io-width = <1>;
+			reg-shift = <2>;
+			interrupts = <3>;
+			clocks = <&cpu_clk>;
+			fifo-size = <16>;
+
+			status = "disabled";
+		};
+	};
+};
+
diff --git a/arch/mips/boot/dts/realtek/rtl8186_edimax_br_6204wg.dts b/arch/mips/boot/dts/realtek/rtl8186_edimax_br_6204wg.dts
new file mode 100644
index 000000000000..c28edb83de4e
--- /dev/null
+++ b/arch/mips/boot/dts/realtek/rtl8186_edimax_br_6204wg.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+/include/ "rtl8186.dtsi"
+
+/ {
+	compatible = "edimax,br-6204wg", "realtek,rtl8186-soc";
+	model = "Edimax BR-6204Wg";
+
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x01000000>; /* 16MB */
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,38400n8";
+	};
+
+	flash0: flash@1e000000 {
+		compatible = "cfi-flash";
+		reg = <0x1e000000 0x200000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		bank-width = <2>;
+
+		partition@0 {
+			label = "bootloader+defaults";
+			reg = <0x0 0x8000>;
+			read-only;
+		};
+		partition@8000 {
+			label = "settings";
+			reg = <0x8000 0x8000>;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&cpu_clk {
+	clock-frequency = <180000000>; /* 180MHz */
+};
diff --git a/arch/mips/configs/rtl8186_defconfig b/arch/mips/configs/rtl8186_defconfig
new file mode 100644
index 000000000000..03be44de770d
--- /dev/null
+++ b/arch/mips/configs/rtl8186_defconfig
@@ -0,0 +1,112 @@
+CONFIG_MACH_RTL8186=y
+CONFIG_HZ_100=y
+CONFIG_MIPS_ELF_APPENDED_DTB=y
+CONFIG_KERNEL_XZ=y
+# CONFIG_SWAP is not set
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_SGETMASK_SYSCALL is not set
+# CONFIG_FHANDLE is not set
+# CONFIG_SHMEM is not set
+# CONFIG_AIO is not set
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+# CONFIG_STACKPROTECTOR_STRONG is not set
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_MSDOS_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_MQ_IOSCHED_DEADLINE is not set
+# CONFIG_MQ_IOSCHED_KYBER is not set
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_NET_FOU=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
+# CONFIG_BRIDGE_NETFILTER is not set
+# CONFIG_NETFILTER_INGRESS is not set
+CONFIG_NF_CONNTRACK=y
+# CONFIG_NF_CONNTRACK_PROCFS is not set
+# CONFIG_NF_CT_PROTO_DCCP is not set
+# CONFIG_NF_CT_PROTO_SCTP is not set
+# CONFIG_NF_CT_PROTO_UDPLITE is not set
+CONFIG_NF_CONNTRACK_IPV4=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP_NF_FILTER=y
+CONFIG_IP_NF_TARGET_SYNPROXY=y
+CONFIG_IP_NF_NAT=y
+CONFIG_IP_NF_TARGET_MASQUERADE=y
+CONFIG_BRIDGE=y
+# CONFIG_BRIDGE_IGMP_SNOOPING is not set
+CONFIG_NET_SCHED=y
+CONFIG_NET_SCH_FQ_CODEL=y
+CONFIG_NET_SCH_DEFAULT=y
+CONFIG_DEFAULT_FQ_CODEL=y
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK_RO=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_NETDEVICES=y
+# CONFIG_NET_CORE is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVMEM is not set
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_FILE_DIRECT=y
+# CONFIG_SQUASHFS_ZLIB is not set
+CONFIG_SQUASHFS_XZ=y
+CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_REDUCED=y
+CONFIG_DEBUG_INFO_SPLIT=y
+CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_PANIC_TIMEOUT=10
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_FTRACE is not set
+CONFIG_DEBUG_ZBOOT=y
+# CONFIG_CRYPTO_ECHAINIV is not set
+# CONFIG_CRYPTO_HW is not set
+# CONFIG_XZ_DEC_X86 is not set
+# CONFIG_XZ_DEC_POWERPC is not set
+# CONFIG_XZ_DEC_IA64 is not set
+# CONFIG_XZ_DEC_ARM is not set
+# CONFIG_XZ_DEC_ARMTHUMB is not set
+# CONFIG_XZ_DEC_SPARC is not set
diff --git a/arch/mips/include/asm/mach-rtl8186/rtl8186.h b/arch/mips/include/asm/mach-rtl8186/rtl8186.h
new file mode 100644
index 000000000000..d699b25c7854
--- /dev/null
+++ b/arch/mips/include/asm/mach-rtl8186/rtl8186.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_RTL8186_H
+#define __ASM_RTL8186_H
+
+#include <linux/compiler.h>
+
+#define RTL8186_REG_BASE ((void __iomem *)0xbd010000)
+#define RTL8186_REGISTER(offset) (RTL8186_REG_BASE + offset)
+
+/* Watchdog registers */
+#define RTL8186_CDBR        RTL8186_REGISTER(0x58)
+#define RTL8186_WDTCNR      RTL8186_REGISTER(0x5C)
+
+/* UART addresses */
+#define RTL8186_UART0_BASE  RTL8186_REGISTER(0xC3)
+#define RTL8186_UART1_BASE  RTL8186_REGISTER(0xE3)
+
+/* GPIO registers */
+#define RTL8186_GPABDATA    RTL8186_REGISTER(0x120)
+#define RTL8186_GPABDIR     RTL8186_REGISTER(0x124)
+#define RTL8186_GPABIMR     RTL8186_REGISTER(0x128)
+#define RTL8186_GPABISR     RTL8186_REGISTER(0x12C)
+#define RTL8186_GPCDDATA    RTL8186_REGISTER(0x130)
+#define RTL8186_GPCDDIR     RTL8186_REGISTER(0x134)
+#define RTL8186_GPCDIMR     RTL8186_REGISTER(0x138)
+#define RTL8186_GPCDISR     RTL8186_REGISTER(0x13C)
+#define RTL8186_GPEFDATA    RTL8186_REGISTER(0x140)
+#define RTL8186_GPEFDIR     RTL8186_REGISTER(0x144)
+#define RTL8186_GPEFIMR     RTL8186_REGISTER(0x148)
+#define RTL8186_GPEFISR     RTL8186_REGISTER(0x14C)
+#define RTL8186_GPGDATA     RTL8186_REGISTER(0x150)
+#define RTL8186_GPGDIR      RTL8186_REGISTER(0x154)
+#define RTL8186_GPGIMR      RTL8186_REGISTER(0x158)
+#define RTL8186_GPGISR      RTL8186_REGISTER(0x15C)
+
+
+#endif /* __ASM_RTL8186_H */
diff --git a/arch/mips/rtl8186/Makefile b/arch/mips/rtl8186/Makefile
new file mode 100644
index 000000000000..010f38349aa6
--- /dev/null
+++ b/arch/mips/rtl8186/Makefile
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+obj-y := prom.o setup.o irq.o time.o
diff --git a/arch/mips/rtl8186/Platform b/arch/mips/rtl8186/Platform
new file mode 100644
index 000000000000..5c23cfbffc62
--- /dev/null
+++ b/arch/mips/rtl8186/Platform
@@ -0,0 +1,7 @@
+#
+# RTL8186
+#
+platform-$(CONFIG_MACH_RTL8186) += rtl8186/
+cflags-$(CONFIG_MACH_RTL8186)   += -I$(srctree)/arch/mips/include/asm/mach-rtl8186
+load-$(CONFIG_MACH_RTL8186)     += 0xffffffff80010000
+zload-$(CONFIG_MACH_RTL8186)    += 0xffffffff80800000
diff --git a/arch/mips/rtl8186/irq.c b/arch/mips/rtl8186/irq.c
new file mode 100644
index 000000000000..f158bfe25bca
--- /dev/null
+++ b/arch/mips/rtl8186/irq.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/irqchip.h>
+
+void __init arch_init_irq(void)
+{
+	irqchip_init();
+}
diff --git a/arch/mips/rtl8186/prom.c b/arch/mips/rtl8186/prom.c
new file mode 100644
index 000000000000..0ec7979a23f9
--- /dev/null
+++ b/arch/mips/rtl8186/prom.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+
+#include <asm/setup.h>
+#include <asm/mach-rtl8186/rtl8186.h>
+
+void __init prom_init(void)
+{
+	setup_8250_early_printk_port((unsigned long)RTL8186_UART0_BASE, 2,
+				     10000);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
diff --git a/arch/mips/rtl8186/setup.c b/arch/mips/rtl8186/setup.c
new file mode 100644
index 000000000000..ac3a0e982493
--- /dev/null
+++ b/arch/mips/rtl8186/setup.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
+
+#include <asm/reboot.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/bootinfo.h>
+
+#include <asm/mach-rtl8186/rtl8186.h>
+
+const char *get_system_type(void)
+{
+	return "Realtek RTL8186";
+}
+
+void rtl8186_machine_restart(char *command)
+{
+	/* Disable all interrupts */
+	local_irq_disable();
+
+	/* Use watchdog to reset the system */
+	writel(0x10, RTL8186_CDBR);
+	writel(0x00, RTL8186_WDTCNR);
+
+	for (;;)
+		;
+}
+
+#define GPIO_A2 BIT(2)
+#define GPIO_A3 BIT(3)
+#define GPIO_A7 BIT(7)
+#define GPIO_A8 BIT(8)
+
+/* Temporary hack until rtl8186-gpio driver is implemented */
+void __init rtl8186_edimax_br6204wg_setup_leds(void)
+{
+	unsigned int gpabdir, gpabdata;
+
+	gpabdir = readl(RTL8186_GPABDIR);
+	gpabdata = readl(RTL8186_GPABDATA);
+
+	writel(gpabdir | (GPIO_A2 | GPIO_A3), RTL8186_GPABDIR);
+
+	gpabdata &= ~GPIO_A2; /* Turn on A2 - green PWR */
+	gpabdata |= GPIO_A3;  /* Turn off A3 - orange WLAN */
+	writel(gpabdata, RTL8186_GPABDATA);
+}
+
+void __init *plat_get_fdt(void)
+{
+	if (fw_passed_dtb)
+		return (void *)fw_passed_dtb;
+
+	return NULL;
+}
+
+void __init plat_mem_setup(void)
+{
+	void *dtb;
+
+	_machine_restart = rtl8186_machine_restart;
+
+	dtb = plat_get_fdt();
+	if (!dtb)
+		panic("no dtb found");
+
+	__dt_setup_arch(dtb);
+}
+
+void __init device_tree_init(void)
+{
+	unflatten_and_copy_device_tree();
+
+	if (of_machine_is_compatible("edimax,br-6204wg"))
+		rtl8186_edimax_br6204wg_setup_leds();
+}
diff --git a/arch/mips/rtl8186/time.c b/arch/mips/rtl8186/time.c
new file mode 100644
index 000000000000..78062b588bb3
--- /dev/null
+++ b/arch/mips/rtl8186/time.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/clocksource.h>
+#include <linux/of_clk.h>
+
+void __init plat_time_init(void)
+{
+	of_clk_init(NULL);
+	timer_probe();
+}
-- 
2.19.0

