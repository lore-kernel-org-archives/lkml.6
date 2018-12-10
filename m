Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14614C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C927E20880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ihkzGFbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C927E20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeLJNWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:22:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53095 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeLJNWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:22:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so10855031wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uBjdffJIS6e81RZXl0D/cVk1PRz+k7NxIO5RxlBhn+w=;
        b=ihkzGFbddzBhg7/l98TR3HElWWrO7AG3D5dq2YA45xQZqkZ8mucv9c45zqYilltaHA
         qdPCJYzke/x2SyUCfzPW351/KNQ4i853vaPH9lvPQ/pM/ynE6nH8tsi9+KS+mAsEnVmf
         A0q0qvIzGpxE9KFTIRP/LJ+rnfGrfX/GgnJXulyu5nJ1xBNjewiuErZPMASk0QwUU3pz
         iCxesQcHicy3VTNhEB9MZHosmhlAb4vz55RyDasb1KF9TC4U6SXp+D7Pn6mP7RqXpXtJ
         Dsf/vLX2Up+Oby27kPdZLlDWu2SLnWd3XX8lPD/vrAYUKoq5iVbT9nxJJwr7ki+wDR6V
         0EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uBjdffJIS6e81RZXl0D/cVk1PRz+k7NxIO5RxlBhn+w=;
        b=bBK/SFg+J7jFAv5qqxYG+oTXXhwUxfiItQLyv4FAzd3fNhKFGv3rNWIS9Y5UCktC6Y
         vrTirPIv6KDrIOaR5wNrKhpV4UYYR7v0k/FsQVlBGpOYfST9tS5Ns5zIdaFUXuvvWfNy
         3aKRHlctOJrng1GcALAbN5xHdCxIe4rZXNsnxtO67k+hdHXpVcoTVCiYeIF6TiaEBETC
         QaSAmuR6O4GqIQGLe+hpAyzsJ4ksj++HV+FDljHXv43MtRe8BBqvWPHHxMZX5ZDsavo3
         JzLPY3en5RTPcu4FdLG2f9zh2EroyBIYRNsNj3xpBIqdTacKVcMYfE1nGIBdUBEbB5Cu
         Z1gw==
X-Gm-Message-State: AA+aEWY4XifMkvg2ygD+IFZbrEQY5JPGsdV9fDVeYWI8OdOrkAuAX7+4
        R+Saurv/LNo3VMjai6VWvWzq4TXhJC78kYNk
X-Google-Smtp-Source: AFSGD/VNKgkJdWqMIdXGD3Xop2viNm6jJ/VTo9k/ZE2rcJTd/CFg0jW+zJt4sl4Ns8NHop4RRUZdMQ==
X-Received: by 2002:a1c:ad43:: with SMTP id w64mr10122640wme.32.1544448152953;
        Mon, 10 Dec 2018 05:22:32 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l3sm11208424wru.36.2018.12.10.05.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 05:22:31 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] arm64: dts: meson-gxm: Add Mali-T820 node
Date:   Mon, 10 Dec 2018 14:22:27 +0100
Message-Id: <20181210132227.29262-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210132227.29262-1-narmstrong@baylibre.com>
References: <20181210132227.29262-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

The Amlogic Meson GXM SoC embeds an ARM Mali T820 GPU.

This patch adds the node with all the needed properties to power
on the GPU.

This has been tested with the work-in-progress PanFrost project
aiming support for ARM Mali Midgard and later GPUs.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index 247888d68a3a..35e59d390903 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -91,6 +91,33 @@
 		reset-names = "phy";
 		status = "okay";
 	};
+
+	mali: gpu@c0000 {
+		compatible = "amlogic,meson-gxm-mali", "arm,mali-t820";
+		reg = <0x0 0xc0000 0x0 0x40000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "gpu", "mmu", "job";
+		clocks = <&clkc CLKID_MALI>;
+		resets = <&reset RESET_MALI_CAPB3>, <&reset RESET_MALI>;
+
+		/*
+		 * Mali clocking is provided by two identical clock paths
+		 * MALI_0 and MALI_1 muxed to a single clock by a glitch
+		 * free mux to safely change frequency while running.
+		 */
+		assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
+				  <&clkc CLKID_MALI_0>,
+				  <&clkc CLKID_MALI>; /* Glitch free mux */
+		assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
+					 <0>, /* Do Nothing */
+					 <&clkc CLKID_MALI_0>;
+		assigned-clock-rates = <0>, /* Do Nothing */
+				       <666666666>,
+				       <0>; /* Do Nothing */
+	};
 };
 
 &clkc_AO {
-- 
2.19.2

