Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754422AbeBURPP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:15:15 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:55853 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbeBURPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:15:14 -0500
Date: Wed, 21 Feb 2018 18:15:04 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/19] ARM64: dts: Add R-Car Salvator-x M3-N support
Message-ID: <20180221171504.dac7yikrqfnjiiog@verge.net.au>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-10-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdVDCga8htL+UD3P0Kzt9-OQ6hof+szGOiV9d0gwxGExqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVDCga8htL+UD3P0Kzt9-OQ6hof+szGOiV9d0gwxGExqQ@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 04:46:23PM +0100, Geert Uytterhoeven wrote:
> On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > Add basic support for R-Car Salvator-X M3-N (R8A77965) board.
> >
> > Based on original work from:
> > Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Magnus Damm <damm+renesas@opensource.se>
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied with prefix updated to

"arm64: dts: renesas:"

There was some fuzz applying this patch, the result is as follows.

From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH] arm64: dts: renesas: Add R-Car Salvator-x M3-N support

Add basic support for R-Car Salvator-X M3-N (R8A77965) board.

Based on original work from:
Takeshi Kihara <takeshi.kihara.df@renesas.com>
Magnus Damm <damm+renesas@opensource.se>

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/Makefile                |  1 +
 arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index c885eef4e660..9ea5ec0daeba 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-es1-h3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-m3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-xs.dtb
+dtb-$(CONFIG_ARCH_R8A77965) += r8a77965-salvator-x.dtb
 dtb-$(CONFIG_ARCH_R8A77970) += r8a77970-eagle.dtb r8a77970-v3msk.dtb
 dtb-$(CONFIG_ARCH_R8A77980) += r8a77980-condor.dtb
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
new file mode 100644
index 000000000000..75d890d91df9
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Salvator-X board with R-Car M3-N
+ *
+ * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
+ */
+
+/dts-v1/;
+#include "r8a77965.dtsi"
+#include "salvator-x.dtsi"
+
+/ {
+	model = "Renesas Salvator-X board based on r8a77965";
+	compatible = "renesas,salvator-x", "renesas,r8a77965";
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+};
-- 
2.11.0
