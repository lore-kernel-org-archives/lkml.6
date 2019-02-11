Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94ACC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88032146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyTJPG/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfBKJWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:22:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34548 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfBKJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:21:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so13928656wmd.1;
        Mon, 11 Feb 2019 01:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fwD0w9cY6pAqgprkGqKHjvaIM0lWzxAak4iqngIDanE=;
        b=QyTJPG/Bx/k2DgyeqFolci5TCnumOLVhB6okYdjDW2ie1kneDcXMMhJEOneqSRvWwP
         DldyUsX+E0iI5swA+sWqYeikX8sAeCbzFUjALZBe8i1S8Ihj9J2Ai8v8eI6q7Be4HNmO
         vHoZtXAUI+90kaxejbRrKJcZMLF7Tj7GyruKxNPN7otIlmWRV5BSwelqHhWUVmEeM4zK
         47LS+vurw1O4EHF2GLuFPhWxxj3inkzkxLLeicprL7sDXknvKJxbXHMyPub1VWM6Ddwj
         I1zRR/LchiJ7EqGZC0dtdYSjTNXme1B+ProKtjbWTYZnew08nXjt/NldLTTZO8NB+bRc
         W1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fwD0w9cY6pAqgprkGqKHjvaIM0lWzxAak4iqngIDanE=;
        b=e/vLJbYq5v6rAS1XLy9nYl5oQZ5oQ1DWnBdbmulZ5DTyccw4GAvcucO71IsvBBpQ2Z
         eTU2/Klm5RNQygnI3ZzAbSOBH/JCKwBdHz2MTsqxt9zd/PS5EmV0AVcAT63vtM72LG7q
         8vHWaxJz986jKAGTWRZCJkS4JRXpWh62SK3f1sOceGiwofx9aAG+PvQwqYhtvh5dpnkP
         ChZW9PvRyrchhoL/qKHVUTNJZstFUHUn1Pk3ilazO6quFSlMIZnv22AR9IM+LdOFaPnv
         7hjLU44zeEAy9Lq/ZXEGqe6xz7mJEuci92gxU2eallZsXG7U8cx+/qcogFoDsn1TEIo5
         uOww==
X-Gm-Message-State: AHQUAuZFCGZIHEVtGiLtBNzYmoB3vXD9R6SFnGPZByPW+qFBBtYuoYXy
        E3gEhxEolBRqWDeBjcDWbsCuTVI/xBs=
X-Google-Smtp-Source: AHgI3IbI8Pp3O5chVjMuKPKEycPJpQtScjVPz5GgOvT4cXuGkW8JSB+BgetdDfEqZniD2hysWJ0lXQ==
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr25834299wrx.79.1549876913504;
        Mon, 11 Feb 2019 01:21:53 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
        by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 01:21:53 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 5/7] ARM: dts: suniv: Add SPI device-tree nodes
Date:   Mon, 11 Feb 2019 12:21:11 +0300
Message-Id: <d1f0bd8af72b0902bc1d44a0df64a844b00fa895.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner suniv F1C100s has similar SPI controller as sun8i H3.
F1C100s has no dedicated mod clock, instead it uses AHB bus clock.

Add support for both SPI0 and SPI1.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index 953228c..1b332d9 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -143,5 +143,31 @@
 			resets = <&ccu RST_BUS_UART2>;
 			status = "disabled";
 		};
+
+		spi0: spi@1c05000 {
+			compatible = "allwinner,suniv-f1c100s-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c05000 0x1000>;
+			interrupts = <10>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_BUS_SPI0>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi@1c06000 {
+			compatible = "allwinner,suniv-f1c100s-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c06000 0x1000>;
+			interrupts = <11>;
+			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_BUS_SPI1>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 };
-- 
2.7.4

