Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E492C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD5E214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaF/rI5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD5E214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387482AbeKVFHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733287AbeKVFHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so6730342wrx.9;
        Wed, 21 Nov 2018 10:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M/F13hGIu6S2eKou90/ihwML11eeJAohnt+PY+W3ikI=;
        b=WaF/rI5YaAiC6Be4ION3zIdcmRcT0wK3yJggGSt4OR52ELy0Oh9X32BAzuWYKVcLVd
         /fhuQoaZjimZIwZ2WkZUp6p4FlVczn4QM3jAQK+YSD0REpu9uTolpPuau/70eC9vI3TP
         IaCK80dhTU3RGViu8Eze6iC4ZY1js8cFQYqDe0yB03S1Cg8M6rLkeTyk8trjUX5ro61S
         P8NBYN3XjijmBmgmKB/5wGoILDiY0ZhBKt1UkswED9ehAjUqJPFFc7IwwrHWci5j8F4C
         1uly2g5TRfZV4VWtqGV/5UZj00k2JQ8iT5UlMdZhn3d4IOgoJSY7QUtZ7gJ5YxkhmdED
         6yJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M/F13hGIu6S2eKou90/ihwML11eeJAohnt+PY+W3ikI=;
        b=DVdmPfAnkyvvHq2euDL0mW5VA99p6teBzf6wugOKiHylmC2hI/98W8uZloYcinM+xA
         vzqa/s8RcmhsXHNyWBb6ldCt762OpSzXKx+4rdJUsK4YJCWL+wGStMTJMLbU4JhM3OvS
         JWHUHH8qwM5SLNvMLT382UC0XR798YI3WcKF0hkYZH2qF6L3vSmrw7JEfhLMP92gL6Ds
         f8LbeEfi0ua0/TNqTenyk4PmNnOwk1EEMjHIRMXcpd7J3Lq1CRlOlwwjXdfcVpTmEQjj
         ToieOegUdSFA1MwYfs82AAVv8Fkjwe0JleQjsfuFSdPKm5fFZXIo3Wav5ruG1LILJDfI
         DcEw==
X-Gm-Message-State: AA+aEWZ9WFNkcfRn7gYQCPWXxRNJliZ4G7pk7siaIJ7XWV1mOcpm7arj
        n+37H+qG23Cz8K7syMfqpj9ySKh3QoE=
X-Google-Smtp-Source: AFSGD/WNN0/BvDKGjxA6x/1axaU+fHY3lPbOGGy7AQLmXHGuaC7/ZyoE+pssjYydhgLci+4LrfQEjg==
X-Received: by 2002:adf:f4c2:: with SMTP id h2mr6693932wrp.21.1542825135253;
        Wed, 21 Nov 2018 10:32:15 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:32:14 -0800 (PST)
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
Subject: [RFC PATCH v3 17/17] ARM: suniv: f1c100s: add device tree for Lichee Pi Nano
Date:   Wed, 21 Nov 2018 21:30:50 +0300
Message-Id: <055b2e09b14ff1699f2ed8fc879a6e9cfa9c5270.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
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

