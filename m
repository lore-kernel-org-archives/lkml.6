Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1342DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD06F20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oyrriys4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD06F20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeK2JiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:38:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46725 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbeK2Jhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so27906200wrt.13;
        Wed, 28 Nov 2018 14:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VkawJcjcjc12DBJtCZ++/73BzJMuRi7b2X8pVhsSCeI=;
        b=Oyrriys4rQM2qdpSCl1tTkvP/Bly613Qg7GKQoqDATUEHBY8frBenNn6oY6QjQbHJ+
         MBqksQGQHupvZGH6/xEORU6/KemExYUbJCLswVQVDMkzRrPWzIUt6GRIA4MKgSxf4Nus
         dDblImO3mvbNl3EkkTFEM9gtcy3YSeHJJ9M/d/OZzhkrbL325Ghno9dDzjP9DQNCrbF7
         +Rorg/CvfI7Y7ULB3D9yBH/ys+NoWLOUp7bJr9Uenft0iR1zoa1TGcCv/dpRkUZiqD5p
         qYlKzx4qqS3tfYBCSSyKTiFhrveLQqp4fhCEb/1mBDAqS9sgWIuyJPZMWGCkdSWcEVIu
         3Jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VkawJcjcjc12DBJtCZ++/73BzJMuRi7b2X8pVhsSCeI=;
        b=h9W4sCbr2d+EIlMIyVVVQ7SFY9Tpv8WhviYYUJOxmLehoRZQ6xHUbjCNGDzzbpA4Nn
         wXAJJe1ls+py0ZppPv7vUiPDgGImifylRD0Is6MlnwdaF+YcT+jZgnRreZ5A+0FjjOfR
         ik0pO2E35a/CxvbxF1hk4Ta8fkGwH8pL0WqZR4bNGmU8v71LKkVah3/5eeF70ya11IH3
         mIgR/1ZXUmYQdSKpzYtnnnj5/arSpWkf4ZBuA9Uah6cd+FBm3xi7th4cnTsMh1iuq2FB
         u9Nsh5O/eSicW5QZPq/OV5MIcfeX3DQxQn0jVX7QdMVEBu4FtaaDCcC/c3hQRVuHrkMJ
         eeQA==
X-Gm-Message-State: AA+aEWauZ7aKVf7Da8YDsj3iiN5GS24QksNRivy90CSjlgQ61uB12May
        d3BIljCBSU6yMn2mZqsaM3KzVKRPD4w=
X-Google-Smtp-Source: AFSGD/Uxsu+Y0EMsKrB6JTECxsPrsZdGjz+3V2e3l7ZIrHxnePDCnUeJlI9i6PzUfHrUastuRGRiZg==
X-Received: by 2002:adf:f449:: with SMTP id f9mr33586513wrp.40.1543444480846;
        Wed, 28 Nov 2018 14:34:40 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.239])
        by smtp.gmail.com with ESMTPSA id g198sm180244wmd.23.2018.11.28.14.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:40 -0800 (PST)
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
Subject: [PATCH v5 17/17] ARM: suniv: f1c100s: add device tree for Lichee Pi Nano
Date:   Thu, 29 Nov 2018 01:33:27 +0300
Message-Id: <d7d83183c481102f30dfde7fadb9ce3db8ac43e2.1543443475.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
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

