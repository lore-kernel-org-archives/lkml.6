Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29511C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED73D20828
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnJOrBNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeL2Ndq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 08:33:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35077 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeL2Ndl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 08:33:41 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so19496843edx.2;
        Sat, 29 Dec 2018 05:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+VCBySQXhTipKQxLBqodKfMWCHahqpPnV/2FwaZKvSU=;
        b=VnJOrBNmue5O1PtnKiJd63+LT/iFauDAvwKw8er3zs8zahN67/i0CX17jsC0w1dRmq
         lT2D6DPEEs/OL6Fem9t5ic1LruQyXG7ABxEXAe41gstAzeFrtRwSmLH+akGaaMC0LJCe
         V+ZQIc0D2VsPoTLpBl3gdryCpdS7B0iFrsE3jB36ZsGxpf1+x2l4Oavz6TjfGQwRTbPu
         lrQ7NA63eVK5DmNnqDg/VsnMlsC30oeSLDn5qgdMYmej/wGq8Qo7M7OztCA3YpNl8QSi
         WQ1llXJrsmZOL/siYNlLDYcigWyESKkOPSCSy7qrV1wQFM8XKvfCzyOZB/4oxPiHHh/v
         qBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+VCBySQXhTipKQxLBqodKfMWCHahqpPnV/2FwaZKvSU=;
        b=GoVujRqcKL9dPBNlMmiy+XCEyxyMQ1RESSHwQZsgANQO2CFv+1pAjVpybxLhAI+etM
         uRhL0Okxw09Ro2B6LUddZp6zsB781p4rFt2f7/9nfhTtLWnBFzvcbJangTOYpiOiMNIn
         GAOuIs+X3dJ4a5YjQGKhJTzVfXvJ7ayo1puN6LeZLR4wLzW+3ZwFb/axpGcZ43SGaARu
         wEG6xWvfrt9NfY/J2SKBIXGKYUQYVNRr32972WXJ1+bPV+bNFITezTT4Ej9heNxh06eL
         ZCYi9kMfaCQ/qNcDLgf+HCSw7BdMT6TtwsYqjleJcIXJIEH68/HdM3VQHwk9qJIA/wbQ
         B6rw==
X-Gm-Message-State: AA+aEWagGHlWGr93C4QIdxxLR0kppO57C5a4clJ31aLtyErXMKXITIyN
        rYELOgaydst2x0HFXpBssT0=
X-Google-Smtp-Source: AFSGD/V6HJRw3Vzsiaq98oDpDoYv9GVOGWVNVzOI44C9EZh1rRPMFha91360Py5UrN8MQSqeTZo82g==
X-Received: by 2002:a05:6402:1286:: with SMTP id w6mr26493428edv.53.1546090419242;
        Sat, 29 Dec 2018 05:33:39 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d7-v6sm8023063ejx.68.2018.12.29.05.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 05:33:38 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 5/7] ARM: dts: rockchip: add rk3066 vop display nodes
Date:   Sat, 29 Dec 2018 14:33:16 +0100
Message-Id: <20181229133318.18128-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181229133318.18128-1-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Yao <mark.yao@rock-chips.com>

This patch adds the core display subsystem and vop nodes to rk3066.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index b6b3a77da..653127a37 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -44,6 +44,11 @@
 		};
 	};
 
+	display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vop0_out>, <&vop1_out>;
+	};
+
 	sram: sram@10080000 {
 		compatible = "mmio-sram";
 		reg = <0x10080000 0x10000>;
@@ -57,6 +62,48 @@
 		};
 	};
 
+	vop0: vop@1010c000 {
+		compatible = "rockchip,rk3066-vop";
+		reg = <0x1010c000 0x19c>;
+		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_LCDC0>,
+			 <&cru DCLK_LCDC0>,
+			 <&cru HCLK_LCDC0>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		power-domains = <&power RK3066_PD_VIO>;
+		resets = <&cru SRST_LCDC0_AXI>,
+			 <&cru SRST_LCDC0_AHB>,
+			 <&cru SRST_LCDC0_DCLK>;
+		reset-names = "axi", "ahb", "dclk";
+		status = "disabled";
+
+		vop0_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	vop1: vop@1010e000 {
+		compatible = "rockchip,rk3066-vop";
+		reg = <0x1010e000 0x19c>;
+		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_LCDC1>,
+			 <&cru DCLK_LCDC1>,
+			 <&cru HCLK_LCDC1>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		power-domains = <&power RK3066_PD_VIO>;
+		resets = <&cru SRST_LCDC1_AXI>,
+			 <&cru SRST_LCDC1_AHB>,
+			 <&cru SRST_LCDC1_DCLK>;
+		reset-names = "axi", "ahb", "dclk";
+		status = "disabled";
+
+		vop1_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	i2s0: i2s@10118000 {
 		compatible = "rockchip,rk3066-i2s";
 		reg = <0x10118000 0x2000>;
-- 
2.11.0

