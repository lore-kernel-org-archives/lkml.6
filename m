Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25065ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC1F20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oAaIyYB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC1F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbeGRLee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:34:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43310 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbeGRLed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:34:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id v13-v6so1831406pgr.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2W8QooujicID2WN4ebTX45RVVmoJDAJIJF/0URF7seQ=;
        b=oAaIyYB5IQL4hrWE4l5gZIO9mWiChnvbqf0vfBMu8xnfsn58fXxCulTlwKN+BDhA4A
         uJhE9RnrXtBefNywFZDvxvfavsJT3jv9iYdC5UjRd9JiGyolvBsrkNT1hku5MHrzEtHO
         uFth3qRESH62z5UT9m8/7p8LVVjCr/tEnq7Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2W8QooujicID2WN4ebTX45RVVmoJDAJIJF/0URF7seQ=;
        b=IbRu2og7X+ZDGHUoWnPAA0qHB1NKK1NmoXaFtR+weTjioKqURfANAQx4o52wLHE/Dc
         MXDPfwfGfptLxzmEuoC79NisvpVNpCDN2BoVqGZxa3t/OkAVi8r3tu2q6+l9AtfVHfk9
         9IlILVenXFLiFmPE+K0v7jtAqHJScWpfH//OPIvdgI9ziPg3p4X3hS+ap1f6gFYlSmUX
         9OCAkdwy26tVpxgrhJkLJb+tykne1/tw2QsDf2Jwo4Sr8OdzXyX9YCFqq7lhfpufOiXk
         CaFZ34CMujKh42ftHkQgcPKA2N6vkxicHjS+BwJw7VIViyQ94HIhEzY8xOWnD8vZG2sQ
         kaFQ==
X-Gm-Message-State: AOUpUlFbdzXvp/yMS2y8nsL85Y41nN6GRQ80lv0WtKRZqxtkKMsiCdyM
        4ioEfjp0D2LIMdvmi4aPQgMDVA==
X-Google-Smtp-Source: AAOMgpcMEIwqhVGlIykTm5Dp2mfs/AZHBDIoRTEx9fjkBQuInwanu6GR1mhvFnw3oAqQw0yt2Y8+2w==
X-Received: by 2002:a63:f953:: with SMTP id q19-v6mr5202110pgk.292.1531911433023;
        Wed, 18 Jul 2018 03:57:13 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:57:12 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 18/18] arm64: dts: allwinner: a64: sopine: Enable HDMI output
Date:   Wed, 18 Jul 2018 16:24:58 +0530
Message-Id: <20180718105458.22304-19-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable all necessary HDMI pipeline nodes with HDMI out
connector on sopine board.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- Enable all pipeline components
Changes for v2:
- none

 .../allwinner/sun50i-a64-sopine-baseboard.dts | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index c21f2331add6..050e0ff92145 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -61,6 +61,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	reg_vcc1v8: vcc1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8";
@@ -69,6 +80,10 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -86,6 +101,17 @@
 	status = "okay";
 };
 
+&hdmi {
+	hvcc-supply = <&reg_dldo1>;
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &mdio {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -93,6 +119,10 @@
 	};
 };
 
+&mixer1 {
+	status = "okay";
+};
+
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
@@ -138,6 +168,10 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&tcon1 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.17.1

