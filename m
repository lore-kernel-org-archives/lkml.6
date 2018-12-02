Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49A0C65BAE
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3FF20881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC/uSZjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3FF20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLBUYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:24:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39850 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbeLBUYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:24:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so10059781wra.6;
        Sun, 02 Dec 2018 12:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tcTFGjWSUDe1a3RfhkbtIH7npTtVBEiYc3Nl7JTQJUI=;
        b=MC/uSZjZ7eRKFBAaN+33BMvkhzE5N4F60Bef5bi+CJ5Q1axeeIyMA3ePctjjb85bn7
         F4HsvD6byMCepTr4LZnKSn5aHDIBNMPiwcuDFLkfCD3ZYAbgeE3B/2e3BPxZ2s0/ZaNj
         b/nvK3E78p+TprpDBPTZezlOeyZOriS6rSsFtJhO8deE/ROvxUGAj3dyGsvMhXawMzTS
         o7xupjwn9Ylhv4I732X22oeNg/WcwNK5q7KfJ65bcJbkcVujiMZ46t5/BGuoSD3MfPWy
         EPGtMC6iuQZvHGwKuV+mfnG0radtQrJXtJdhEzryiN3kEnlP6yuBxEBpS/UhOhIVvcxs
         pw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tcTFGjWSUDe1a3RfhkbtIH7npTtVBEiYc3Nl7JTQJUI=;
        b=LX15osXIo7xjpmVCF+IJIXacdaE3aN/U8/yfD+U68x0wM0njmR2NIUo41+NoOZ0dVB
         I1+PYDsaFps64d7IRvxY4OW0+srairCOjS0vdf9VC7xVKMULrdJDxVqfQb3lKUkav3nM
         GIxvU7hcfoxYNyIQxsodtJ/PzpR/BFDCRjjkOtqnDhZYjTn9mEIo4Cg1Ixgf6Vn73bfc
         EyrDYFUcmfN0pTcT1NKIoMalNEwIfFWlgcLzhei2k1422tlg5RECLUNvS+dwJ93f3NqT
         y+xwgZf00vTD1k1U2g9ypOEaVJuh4Tfkn6tx767vL0F2ryPdd1QqzFVRcWbUPAxkEVpK
         rd6g==
X-Gm-Message-State: AA+aEWYH4S2bjtlep9f9RAMS8h2SXG6DLDCeVYAv+e4jtZE9s/PeR8Hv
        MP0BfkVZWVIz1N7BERL0Y3UvX3ZpGX8=
X-Google-Smtp-Source: AFSGD/XCOkDZxjraQA52Ty23Cet8GSvlWVOKBCI002RoLX4C/iyPpbDhESnWACNj/xn6/Cr0FWnHGg==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr11447772wrs.281.1543782280631;
        Sun, 02 Dec 2018 12:24:40 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 12:24:40 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [PATCH v6 17/17] ARM: suniv: f1c100s: add device tree for Lichee Pi Nano
Date:   Sun,  2 Dec 2018 23:23:51 +0300
Message-Id: <125b26f154ad1373179d67fcde30df056e883ac8.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lichee Pi Nano is a F1C100s board by Lichee Pi.

Add initial device tree for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/Makefile                        |  2 ++
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts | 26 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b0e966d..2b96a5b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1066,6 +1066,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
 	sun9i-a80-cubieboard4.dtb
+dtb-$(CONFIG_MACH_SUNIV) += \
+	suniv-f1c100s-licheepi-nano.dtb
 dtb-$(CONFIG_ARCH_TANGO) += \
 	tango4-vantage-1172.dtb
 dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
diff --git a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
new file mode 100644
index 0000000..a1154e6
--- /dev/null
+++ b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
+/*
+ * Copyright 2018 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+/dts-v1/;
+#include "suniv-f1c100s.dtsi"
+
+/ {
+	model = "Lichee Pi Nano";
+	compatible = "licheepi,licheepi-nano", "allwinner,suniv-f1c100s";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pe_pins>;
+	status = "okay";
+};
-- 
2.7.4

