Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE312ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773E520850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hrobqEGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773E520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeGRLeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:34:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41560 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbeGRLeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:34:16 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so1871486ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GngJWncHTwgugLmvJ5NxV3HAYsyJrLptdh02EiBtwSE=;
        b=hrobqEGl4UNoXEe+Jjh7l0OxKjF0PWg11SN113OZKDTTwXIJDszUQ+rkRx2SRD8R+X
         Xb2sJT0DUDkAsC0o6q1oYG7dvxnz0QFBIPAroNVibzTonZI8qFLEM9FeIa4xN1lAqnFP
         4MmA7DyMi3upLaTP+rHJu8dPtvIF+EY1nHZBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GngJWncHTwgugLmvJ5NxV3HAYsyJrLptdh02EiBtwSE=;
        b=k+Bx0e5Gr/Y5xkKxVvEzoNmqTduS7rlrLHApdjwG6WXlB0u2hsRjVyDZbmiEiFiZ1N
         dKiJYHDUHgNNKhBk3bZ5YRctMw0VJ+wWtHOuFDVpLDKpGUCrgXsaPioYB3HwGVbSXgmy
         XNcza57jITjeVkFQbOPrytYxrC5WQdt7JVNJnbSjKbONSesu/cJcoZxcghwYBjaXpxho
         +Y7pNsrEksPw9ozRo+ACmKgusZbrAIXx+d0hokTQi4L81Py2y2iQsbtUCGPH3FUefzud
         nWneu01HouR891Va3JWPRmGseMNKCW8DUyODnY7YSUra3NXjMFl3pJe8T0VfB9xafBdz
         SG7A==
X-Gm-Message-State: AOUpUlHa19I47M+3dFBtIEEm3MLob9uN32DKrHFA19V4aX4SiamcbsVa
        qUOfjmph9FC0Z4NgkcrSY0TCzQ==
X-Google-Smtp-Source: AAOMgpd0lYAo6frlaerPWHvHzZDUefGtwPqzmGTjwrCt8w+knt9GcULqVCCuDyISYwyUqG7Txy0jaA==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2-v6mr5360764plb.179.1531911416501;
        Wed, 18 Jul 2018 03:56:56 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:56:56 -0700 (PDT)
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
Subject: [PATCH v3 15/18] arm64: dts: allwinner: a64: orangepi-win: Enable HDMI output
Date:   Wed, 18 Jul 2018 16:24:55 +0530
Message-Id: <20180718105458.22304-16-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable all necessary HDMI pipeline nodes with HDMI out
connector on Orangepi-win board.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- Enable all pipeline components
Changes for v2:
- none

 .../dts/allwinner/sun50i-a64-orangepi-win.dts | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 1221764f5719..5bd80b116039 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -57,12 +57,42 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
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
+};
+
+&de {
+	status = "okay";
 };
 
 &ehci1 {
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
+&mixer1 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -195,6 +225,10 @@
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

