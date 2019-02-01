Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71289C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F65920857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="KL7Mx/DN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfBAGgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 01:36:14 -0500
Received: from forward100p.mail.yandex.net ([77.88.28.100]:43452 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfBAGgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 01:36:12 -0500
Received: from mxback5o.mail.yandex.net (mxback5o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1f])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 8E68E598299C;
        Fri,  1 Feb 2019 09:36:08 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback5o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id D5wPg38RU2-a8xiqL3W;
        Fri, 01 Feb 2019 09:36:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1549002968;
        bh=2wiqs9zxe3W64theQBSX1Wi8qaLxM4kryOcr6IFsFbg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=KL7Mx/DNeZeaDpKmm1rZ9lOGyFc62Osl2YZUKjT9Sw9yeY7zSblcPthMAQVt87MjR
         Sdomyur9gDVKn8Z3MLVs3x8wt7W5746KHUgSyr1DDf/Gimdg7jAlw/Oc8YhuIKfAlF
         DFDjzrbqzS3egQ0uHRbRYOR1i87X4ckcgmNeC+Wo=
Authentication-Results: mxback5o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 5VfXSCstdQ-a1VOTSbl;
        Fri, 01 Feb 2019 09:36:06 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 1/3] clk: loongson1: add configuration option for loongson1 clks
Date:   Fri,  1 Feb 2019 14:35:38 +0800
Message-Id: <20190201063540.19636-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201063540.19636-1-jiaxun.yang@flygoat.com>
References: <20190128152052.3047-1-jiaxun.yang@flygoat.com>
 <20190201063540.19636-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch introduces options for loongson1 clocks so we can
select the driver we need.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/clk/Kconfig            |  1 +
 drivers/clk/Makefile           |  2 +-
 drivers/clk/loongson1/Kconfig  | 27 +++++++++++++++++++++++++++
 drivers/clk/loongson1/Makefile |  7 ++++---
 4 files changed, 33 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clk/loongson1/Kconfig

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e5b2fe80eab4..136d3d73c6df 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -298,6 +298,7 @@ source "drivers/clk/imgtec/Kconfig"
 source "drivers/clk/imx/Kconfig"
 source "drivers/clk/ingenic/Kconfig"
 source "drivers/clk/keystone/Kconfig"
+source "drivers/clk/loongson1/Kconfig"
 source "drivers/clk/mediatek/Kconfig"
 source "drivers/clk/meson/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 8a9440a97500..7d29e545caf0 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -76,7 +76,7 @@ obj-y					+= imx/
 obj-y					+= ingenic/
 obj-$(CONFIG_ARCH_K3)			+= keystone/
 obj-$(CONFIG_ARCH_KEYSTONE)		+= keystone/
-obj-$(CONFIG_MACH_LOONGSON32)		+= loongson1/
+obj-y					+= loongson1/
 obj-y					+= mediatek/
 obj-$(CONFIG_COMMON_CLK_AMLOGIC)	+= meson/
 obj-$(CONFIG_MACH_PIC32)		+= microchip/
diff --git a/drivers/clk/loongson1/Kconfig b/drivers/clk/loongson1/Kconfig
new file mode 100644
index 000000000000..e2220332d797
--- /dev/null
+++ b/drivers/clk/loongson1/Kconfig
@@ -0,0 +1,27 @@
+menu "Loongson-1 Clock drivers"
+	depends on MACH_LOONGSON32
+
+config LOONGSON1_CLOCK_COMMON
+	bool
+
+config LOONGSON1_CLOCK_LS1B
+	bool "Loongson 1B driver"
+	default y
+	select LOONGSON1_CLOCK_COMMON
+	help
+	  Support the clocks provided by the clock hardware on Loongson-1B
+	  and compatible SoCs.
+
+	  If building for a Loongson-1B SoC, you want to say Y here.
+
+config LOONGSON1_CLOCK_LS1C
+	bool "Loongson 1C driver"
+	default y
+	select LOONGSON1_CLOCK_COMMON
+	help
+	  Support the clocks provided by the clock hardware on Loongson-1C
+	  and compatible SoCs.
+
+	  If building for a Loongson-1C SoC, you want to say Y here.
+
+endmenu
diff --git a/drivers/clk/loongson1/Makefile b/drivers/clk/loongson1/Makefile
index b7f6a16390e0..9240189183ff 100644
--- a/drivers/clk/loongson1/Makefile
+++ b/drivers/clk/loongson1/Makefile
@@ -1,3 +1,4 @@
-obj-y				+= clk.o
-obj-$(CONFIG_LOONGSON1_LS1B)	+= clk-loongson1b.o
-obj-$(CONFIG_LOONGSON1_LS1C)	+= clk-loongson1c.o
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_LOONGSON1_CLOCK_COMMON)	+= clk.o
+obj-$(CONFIG_LOONGSON1_CLOCK_LS1B)	+= clk-loongson1b.o
+obj-$(CONFIG_LOONGSON1_CLOCK_LS1C)	+= clk-loongson1c.o
-- 
2.20.1

