Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513171-2-3088750936743399287
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.66', Host='mail-pl0-f66.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513171; b=mxRTr+HRUPYGEmWKT9OkitzBXSQC5KkF5pf+pgOv7qmeL7R
    /UdVprq/5ckVUcmiB10A1IVJlzdQjqX1X85xFrXkfFEtpRqAvw+rU45lIWMLQZoH
    8EjbGFfVzz+LsgeMqO0aWbKhaxSRWaq0HIJDMBGdg1U9GsMumQxVHqF3YDns54WZ
    H8yG3IbIRRrFRKYb0juYa+Z27molHbKGWrlXyX055geTNboNqkLUaj04qlgDw3tE
    tMkd0vd2MAV7ouKcQz08kfH89PtLe7HWnN2f7w03SouoiCUWjoFSpyypPQagz1V+
    zUQvxp8l0g+uuWH6vTbAEMX7KcdHVcoDKy5GC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513171; bh=TdAszDI1EBEEdDcAeh9sUJlASfMTp5o/PuyITYit3nw=; b=I
    i+A/zuStyLy6/LmXifR6mDCfzyGyKrO/c8Y8lpl7zGaUkYNOt3IKGJqRdTu77dtB
    MZrWY/2GUG0T652xj+CQojCAsjN1umfLx2L/4bk72JB68TeYcI2Jm6JKeL0A/jlR
    TF+8z4w/wzeNtjYSy16x3WIf8qKjAyDub13eAF9dgJYmcdE9ThLCJGW4Jf80wqxQ
    3WwnhToHZllo2yDl6UAs/GJZiVISqB1BERcDHwMQ0Np9NxOuC0s8SiCd5NW9p1Qx
    WbBkvZNwgdtbth6N3m79EoLcL1dazx2noJ3IqEtSeTcqmryEyiJUkPX2ao4eskHn
    5GB77WgFDiAnxkbAeZWtw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OLmi/Gnr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.66 (mail-pl0-f66.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f66.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bfKvuWiS;
    x-ptr=pass x-ptr-helo=mail-pl0-f66.google.com x-ptr-lookup=mail-pl0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OLmi/Gnr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.160.66 (mail-pl0-f66.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pl0-f66.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bfKvuWiS;
    x-ptr=pass x-ptr-helo=mail-pl0-f66.google.com x-ptr-lookup=mail-pl0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x225EwwWLntg8c94e5oV1ik9AruKfs4Pmhq/Nff2A8e54Lcn8rdh0GlPWScai2o1n1wkw9BjBBw==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: greentime@andestech.com,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	tglx@linutronix.de,
	jason@lakedaemon.net,
	marc.zyngier@arm.com,
	robh+dt@kernel.org,
	netdev@vger.kernel.org,
	deanbo422@gmail.com,
	devicetree@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	dhowells@redhat.com,
	will.deacon@arm.com,
	daniel.lezcano@linaro.org,
	linux-serial@vger.kernel.org,
	geert.uytterhoeven@gmail.com,
	linus.walleij@linaro.org,
	mark.rutland@arm.com,
	greg@kroah.com,
	ren_guo@c-sky.com,
	rdunlap@infradead.org,
	davem@davemloft.net,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: green.hu@gmail.com,
	Vincent Chen <vincentc@andestech.com>
Subject: [PATCH v7 27/37] nds32: Device tree support
Date: Tue, 13 Feb 2018 17:09:31 +0800
Message-Id: <a9e28f586833d476a05d4f5258b6db6b8acc639f.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support for device tree.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/boot/dts/Makefile  |  8 ++++
 arch/nds32/boot/dts/ae3xx.dts | 85 +++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/devtree.c   | 19 ++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 arch/nds32/boot/dts/Makefile
 create mode 100644 arch/nds32/boot/dts/ae3xx.dts
 create mode 100644 arch/nds32/kernel/devtree.c

diff --git a/arch/nds32/boot/dts/Makefile b/arch/nds32/boot/dts/Makefile
new file mode 100644
index 000000000000..d31faa8a1d50
--- /dev/null
+++ b/arch/nds32/boot/dts/Makefile
@@ -0,0 +1,8 @@
+ifneq '$(CONFIG_NDS32_BUILTIN_DTB)' '""'
+BUILTIN_DTB := $(patsubst "%",%,$(CONFIG_NDS32_BUILTIN_DTB)).dtb.o
+else
+BUILTIN_DTB :=
+endif
+obj-$(CONFIG_OF) += $(BUILTIN_DTB)
+
+clean-files := *.dtb *.dtb.S
diff --git a/arch/nds32/boot/dts/ae3xx.dts b/arch/nds32/boot/dts/ae3xx.dts
new file mode 100644
index 000000000000..bb39749a6673
--- /dev/null
+++ b/arch/nds32/boot/dts/ae3xx.dts
@@ -0,0 +1,85 @@
+/dts-v1/;
+/ {
+	compatible = "andestech,ae3xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+
+	chosen {
+		stdout-path = &serial0;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "andestech,n13", "andestech,nds32v3";
+			reg = <0>;
+			clock-frequency = <60000000>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	intc: interrupt-controller {
+		compatible = "andestech,ativic32";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
+
+	clock: clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <30000000>;
+	};
+
+	apb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		serial0: serial@f0300000 {
+			compatible = "andestech,uart16550", "ns16550a";
+			reg = <0xf0300000 0x1000>;
+			interrupts = <8>;
+			clock-frequency = <14745600>;
+			reg-shift = <2>;
+			reg-offset = <32>;
+			no-loopback-test = <1>;
+		};
+
+		timer0: timer@f0400000 {
+			compatible = "andestech,atcpit100";
+			reg = <0xf0400000 0x1000>;
+			interrupts = <2>;
+			clocks = <&clock>;
+			clock-names = "PCLK";
+		};
+	};
+
+	ahb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		L2: cache-controller@e0500000 {
+			compatible = "andestech,atl2c";
+			reg = <0xe0500000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		mac0: ethernet@e0100000 {
+			compatible = "andestech,atmac100";
+			reg = <0xe0100000 0x1000>;
+			interrupts = <18>;
+		};
+	};
+};
diff --git a/arch/nds32/kernel/devtree.c b/arch/nds32/kernel/devtree.c
new file mode 100644
index 000000000000..bdce0fe5af9f
--- /dev/null
+++ b/arch/nds32/kernel/devtree.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/bug.h>
+#include <linux/printk.h>
+#include <linux/of_fdt.h>
+
+void __init early_init_devtree(void *params)
+{
+	if (!params || !early_init_dt_scan(params)) {
+		pr_crit("\n"
+			"Error: invalid device tree blob at (virtual address 0x%p)\n"
+			"\nPlease check your bootloader.", params);
+
+		BUG_ON(1);
+	}
+
+	dump_stack_set_arch_desc("%s (DT)", of_flat_dt_get_machine_name());
+}
-- 
2.16.1
