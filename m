Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588F1C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3C220869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWc+ebAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3C220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeKSAjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:39:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39190 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeKSAjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:39:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id b13so29283036wrx.6;
        Sun, 18 Nov 2018 06:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M/F13hGIu6S2eKou90/ihwML11eeJAohnt+PY+W3ikI=;
        b=KWc+ebAMFpSDwHa+Wscdbm4TWle004geS1F/h03C7rCNkag5OOms9gHcAfVQ79BCmX
         ImmjV1hHKJb02HCpuzgp6jtX0/i39TysRPJ3nFs0rerMH5JTFmdnOpPt4BInjAUQCPrH
         /Wyh+WOo6tIzgbT1TTiwh4799aPudOdRqCyuSieyE3yMlmT9Ot9UVHvCeOhW5zv+pZQU
         KRMnvTtGqwhD6qLutwpMPETomV7qk8z0ObIRVLduccg17pJOcTLYpOUJwj+Zsf6lcCsU
         I+qynYkK1u5EiYahkjzpzj1LOjyRonb8GexkKCP2PhgBImw3DDVIpdyNRQ7Qtbw+4hZe
         Fmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M/F13hGIu6S2eKou90/ihwML11eeJAohnt+PY+W3ikI=;
        b=RJksr/fw4zxx+4LB0nvTxh+Fgwly5g5VIPnri5hUhLk8TSGvBh4k/i6r4qV6Jj6HAi
         UnRlca8zt4cum5ePO/bTzJ7GWQnO2Hj1k1mT7p+3+HcLJxCfLqAAugQKddCRw7A8HuMU
         FrGLpDYjCCvGv6feoTAyE98DdxvFDbpqgiDhaG3Izern9vj3XORX8ylAPPefq9KcsGuK
         gN7BbrmqYbaWh9a49uvd+OmzIjmYo1BQNnUZ8FvRRm11/0S2SmnQL/qcUc7Tp/EIxMkl
         DouZCVEAhE6UktwzJSAWhdx1KLCDJDUr+7Ql3+9w22Z6stUGgpydNSC4IX7dCVxFLuE5
         ytyg==
X-Gm-Message-State: AGRZ1gI/NnrzRYX/MxpmaPPR2o2qdizBYICWg1WZDH1510GpyQd08JQO
        NwWTSrnmfeX5Dvtoue4MuPMUNaUMITQ=
X-Google-Smtp-Source: AJdET5dmvQgjtLTdgYELhpVu9TxCjgW845Q6s1kkJwz076HlDvPzGxSDnFbUe2LkUd/ovgy4Sow9Fg==
X-Received: by 2002:adf:fbc6:: with SMTP id d6-v6mr16040993wrs.241.1542550724466;
        Sun, 18 Nov 2018 06:18:44 -0800 (PST)
Received: from ThinkPad.home ([185.219.176.209])
        by smtp.gmail.com with ESMTPSA id d4sm29814412wrp.89.2018.11.18.06.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 06:18:43 -0800 (PST)
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
Subject: [RFC PATCH v2 14/14] ARM: suniv: f1c100s: add device tree for Lichee Pi Nano
Date:   Sun, 18 Nov 2018 17:17:13 +0300
Message-Id: <b0e8e28b5da944e2891e569fe122e1e097a11fd7.1542546735.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
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

