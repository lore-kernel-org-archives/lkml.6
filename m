Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9108C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED0F20664
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow28vRWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED0F20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeKYSes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:34:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32810 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbeKYSer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:34:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id 79so14282136wmo.0;
        Sat, 24 Nov 2018 23:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M/F13hGIu6S2eKou90/ihwML11eeJAohnt+PY+W3ikI=;
        b=Ow28vRWFMqhCe9RDklX4Urr/mIYYB5ijsm7gfO5Nl/1DYPaP7gSPB4A8QCrZCyodS8
         +btrQ78i2HCUJ0hFWkB6pBd7MgNQ+4/5d1XCkOFR3sdGxqLu2XR2QwOLrk17Ew4iC1eF
         j6f/6DcIuuXjKRVjtR+g/qKYmbU7edNRD0+djqvsscSZjD6bdMU3krxhUGTukjprWXY7
         hBo48vq65drNcDbm01RRM7tTxDdYLxvyhhotFZrDr7bmn31uxgmNFGfqw698gQZQJhoo
         Pj45rM0cqK3kd4iSJWFiJOvLue/EAsfkHjHw9UQgv/XWD8/YOrK3Yvi4lBUBK1b9D60a
         qHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M/F13hGIu6S2eKou90/ihwML11eeJAohnt+PY+W3ikI=;
        b=HGuUKANAO0dGDOVLO70DKhanXVkb8abbATEJOJQHmE8ggCF3tTQDFmo4oKJ8Peh/kw
         fudZsZzs4KALYqcCHEQrUzL9x+/trjod8cr/hx8RM7IyT0yN0gJMj0xo5oHDMa1aXXKi
         yUOD37ZD6M37bEhX4u+ulQUBPshqDm+iASsUnDLsD7GEAN8ZA3upmBdC0g/2GS+5uDn3
         tw4NyTyIP0dceqz0zcTQQbeGKNTfW5+N2TQJgkC8OzyXmtmUaSFUyNIebBX4SM9t7vF+
         GhYxYeaulr49VrW5FrJfwXAE8HwzsOBVvwL4Nr9HOPdCAFtCEd6qPobEAEpcMM3hfmZo
         EFqQ==
X-Gm-Message-State: AGRZ1gLCWzlZ4uwQa+v3NE/QBC4LpqzUN7gjSd2ELHnGsNgsKVhZzdlf
        UGlbMxRvyLFjJLPgogilcm4g5ZbFPA0=
X-Google-Smtp-Source: AJdET5cV30zRR7LzsC00vXPSI2yXLTbdugx9NIAjvchEgC7rcYI6hERPmzjRBlvq2cyOpxLRIUNfHw==
X-Received: by 2002:a1c:23c1:: with SMTP id j184mr19419975wmj.16.1543131857346;
        Sat, 24 Nov 2018 23:44:17 -0800 (PST)
Received: from localhost.localdomain ([185.219.177.224])
        by smtp.gmail.com with ESMTPSA id 6-v6sm12296780wmg.19.2018.11.24.23.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 23:44:16 -0800 (PST)
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
Subject: [RFC PATCH v4 17/17] ARM: suniv: f1c100s: add device tree for Lichee Pi Nano
Date:   Sun, 25 Nov 2018 10:43:20 +0300
Message-Id: <7026f63df56684afb81443ed7cae6313d0dba71e.1543131714.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lichee Pi Nano is a F1C100s board by Lichee Pi.

Add initial device tree for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
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
index 0000000..6ae5ccc
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
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
-- 
2.7.4

