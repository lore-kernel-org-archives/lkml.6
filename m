Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43352C67838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0131B2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qnmlEEqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0131B2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeLJJGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:06:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51482 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeLJJGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:06:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id s14so10083348wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 01:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/iFO9ro52MfQgXBg7sbtK9Q+GjTD65WMy8mc1LZAJI=;
        b=qnmlEEqDy9HdDvus57/G5BdLOXqj6Tt/3om5CgcTwvfsYh0W7xG0wjdTfCFqu2wtjN
         M+zxoyBJS5trVxIpGjE4LyQkNkxP8MvsS1QDP8aJ5xRfwFJ4M1GkGBC4at+c/0qHVyDM
         GDMiTgSm4lXk0wXEIzFClHj9jsnc/Wl9wDaqYyqhEr7f1EMkxWLx41mbofewNeuajK/g
         KKdU/xH5Tw/uzK8akj+mw1ZXhx1yrQZKHz41i/8kNvSYtc1SDN0lc24hlN0UKM18j76h
         zSfTxs271Pkjs5iNIpZJvdAprAxyKNj/ZfTXdkWN2MsFLGvAOVPeCtNxa61i9/to96q1
         TVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/iFO9ro52MfQgXBg7sbtK9Q+GjTD65WMy8mc1LZAJI=;
        b=tWWGB6K7t9CYE8dEBuAvmPKzbNaA1MunuF1NVmGx4idiq2hYsa7IRD5IY4jJGs15iL
         utOrtiiOxunzGhmSyghpo2a1EpwDgnfSWKVV0HIqRAzUakYPbf/CfcInZHJJUQuAbUTW
         nAK+tnz8yY2W0/CtNMzRaisjP15Qh1HgenC5GElWBNq1zT72FzydDMvSohAfHDi9fZUN
         GScEpgNQdmm7P2sRG7/0fyFPRjcXlzVReAPNNGfwIncWGKv/EWMYW2nu2IKP1MUtOeu1
         vuysrdS2gnGjzBiWEEUaxjzyTmO2RS83hxW12a7y5GSsSiKWwFt/gr7XQbKNPT7JB64P
         vgkQ==
X-Gm-Message-State: AA+aEWYl97Pao7zgOZDi/Xa7RDdcw7eH4HNFiWxNS7M1HbOAJE0nepcC
        gFvZH1LnVUCRI0+1pIz1tQGExw==
X-Google-Smtp-Source: AFSGD/VusClaUcF5HcoQLnPCwhOSfRe01bWinz30a94mxKWWkzNEdw189dXQLbo85UBX8ST5A7L8uA==
X-Received: by 2002:a1c:1550:: with SMTP id 77mr10459677wmv.100.1544432809836;
        Mon, 10 Dec 2018 01:06:49 -0800 (PST)
Received: from localhost.localdomain (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id 14sm15856555wmv.36.2018.12.10.01.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 01:06:49 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: meson-gx: add support for simplefb
Date:   Mon, 10 Dec 2018 10:06:40 +0100
Message-Id: <20181210090640.4495-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210090640.4495-1-mjourdan@baylibre.com>
References: <20181210090640.4495-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SimpleFB allows transferring a framebuffer from the firmware/bootloader
to the kernel, while making sure the related clocks and power supplies
stay enabled.

Add nodes for CVBS and HDMI Simple Framebuffers.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 25 +++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 25 +++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 1ade7e486828..4bc7dd5ba141 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -13,6 +13,31 @@
 / {
 	compatible = "amlogic,meson-gxbb";
 
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer@0 {
+			compatible = "amlogic,simple-framebuffer",
+				     "simple-framebuffer";
+			amlogic,pipeline = "vpu-cvbs";
+			power-domains = <&pwrc_vpu>;
+			status = "disabled";
+		};
+
+		framebuffer@1 {
+			compatible = "amlogic,simple-framebuffer",
+				     "simple-framebuffer";
+			amlogic,pipeline = "vpu-hdmi";
+			clocks = <&clkc CLKID_HDMI_PCLK>,
+				 <&clkc CLKID_CLK81>,
+				 <&clkc CLKID_GCLK_VENCI_INT0>;
+			power-domains = <&pwrc_vpu>;
+			status = "disabled";
+		};
+	};
+
 	soc {
 		usb0_phy: phy@c0000000 {
 			compatible = "amlogic,meson-gxbb-usb2-phy";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 8f0bb3c44bd6..f7ef8e0cf96e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -13,6 +13,31 @@
 / {
 	compatible = "amlogic,meson-gxl";
 
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer@0 {
+			compatible = "amlogic,simple-framebuffer",
+				     "simple-framebuffer";
+			amlogic,pipeline = "vpu-cvbs";
+			power-domains = <&pwrc_vpu>;
+			status = "disabled";
+		};
+
+		framebuffer@1 {
+			compatible = "amlogic,simple-framebuffer",
+				     "simple-framebuffer";
+			amlogic,pipeline = "vpu-hdmi";
+			clocks = <&clkc CLKID_HDMI_PCLK>,
+				 <&clkc CLKID_CLK81>,
+				 <&clkc CLKID_GCLK_VENCI_INT0>;
+			power-domains = <&pwrc_vpu>;
+			status = "disabled";
+		};
+	};
+
 	soc {
 		usb0: usb@c9000000 {
 			status = "disabled";
-- 
2.19.2

