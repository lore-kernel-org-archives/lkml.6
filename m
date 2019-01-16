Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E21C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CDE20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sdNmOfjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392861AbfAPMk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:40:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42714 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392836AbfAPMkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:40:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so6728050wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 04:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SKzOiXnEB8V8kNaFY7oKymTvoiedc8KfN1lhPOUJLQ=;
        b=sdNmOfjysUBiHQzQOlVgU9thQydqg7F9721m/P1nntU/bI87Q05/SdSZPbtinWIhvw
         YB/cfPs/Xic9YIF45uUf0Ledm7NaJXEanw2hrwp/22RG8s4Vs8jYevkn10iDOtG6Lopf
         Gne5XMBYU1FJM1HrpznZnwRpjepE9EZu6Obyo2cUQnBg+Lc9D68J4D+cCEcDzD3b8FyU
         FwUFeDf7N7cgMixQhAFXhP4t4WvqmhtHcWbF1Muqk0X8j8ycwOMnPmwbMtd+c9n6tNwe
         nVSegEppOLUWzhYNRRe834fre/pmExe4UI/JivQ0AHnO5LGA6qVLWlKCb8qiA1mqFA2N
         doyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SKzOiXnEB8V8kNaFY7oKymTvoiedc8KfN1lhPOUJLQ=;
        b=VhcqFjMUu/yJUl64FI1wqvQw2VrvksqvB8Si1XgjnhHzj+rEinD2kN3COmL41/q8mP
         3wyUa0AUMtLrKrGs3cgKv6aPJGlEO5zrGTN4erR+nlZm+BE8LtqmBpBvCIZuMJk5kGdU
         dESe+j9/eBz7rUXTtFfdVgO+eVimxLVaYcqbHuND7TSYYkwZ/J4on51l8zPrRg7lA7Dj
         JzSrvZbmC7FiJDnuWXsYaHI6Nv4oNvj5haG/wRfF/tZDGubyB5x4fSX+CSRcqvNK/A2c
         6lfGkk7EwQlxByb6txsCxFR0Uf3T5mrGOamiXrAO96xR/gqK68OaSS6+eydDiODvIGYy
         GE2Q==
X-Gm-Message-State: AJcUukekowhMVDdvkms8qQjihY8A81ocN2/ox8mFO4hTwmsL+t8lguP+
        j1goV25TUIJNgZm2LAPahAr2SA==
X-Google-Smtp-Source: ALg8bN6yLrI0OTJGtrbuy9q9DabN1JFPLpuKV1aLSXgp6noeMQiOcpXxpCoePzh9jihsnvankH7iMA==
X-Received: by 2002:adf:9382:: with SMTP id 2mr7302974wrp.269.1547642451498;
        Wed, 16 Jan 2019 04:40:51 -0800 (PST)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id q3sm80304040wrn.84.2019.01.16.04.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 04:40:50 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: meson-gx: add support for simplefb
Date:   Wed, 16 Jan 2019 13:40:30 +0100
Message-Id: <20190116124030.16882-3-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116124030.16882-1-mjourdan@baylibre.com>
References: <20190116124030.16882-1-mjourdan@baylibre.com>
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
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 22 +++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |  6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 44c5c51ff1fa..a6ffdbba37b9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -50,6 +50,28 @@
 		};
 	};
 
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		simplefb_cvbs: framebuffer-cvbs {
+			compatible = "amlogic,simple-framebuffer",
+				     "simple-framebuffer";
+			amlogic,pipeline = "vpu-cvbs";
+			power-domains = <&pwrc_vpu>;
+			status = "disabled";
+		};
+
+		simplefb_hdmi: framebuffer-hdmi {
+			compatible = "amlogic,simple-framebuffer",
+				     "simple-framebuffer";
+			amlogic,pipeline = "vpu-hdmi";
+			power-domains = <&pwrc_vpu>;
+			status = "disabled";
+		};
+	};
+
 	cpus {
 		#address-cells = <0x2>;
 		#size-cells = <0x0>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index a7b883ced0a8..a60d3652beee 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -784,6 +784,12 @@
 	resets = <&reset RESET_SD_EMMC_C>;
 };
 
+&simplefb_hdmi {
+	clocks = <&clkc CLKID_HDMI_PCLK>,
+		 <&clkc CLKID_CLK81>,
+		 <&clkc CLKID_GCLK_VENCI_INT0>;
+};
+
 &spicc {
 	clocks = <&clkc CLKID_SPICC>;
 	clock-names = "core";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index d5c3d78aafeb..3093ae421b17 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -787,6 +787,12 @@
 	resets = <&reset RESET_SD_EMMC_C>;
 };
 
+&simplefb_hdmi {
+	clocks = <&clkc CLKID_HDMI_PCLK>,
+		 <&clkc CLKID_CLK81>,
+		 <&clkc CLKID_GCLK_VENCI_INT0>;
+};
+
 &spicc {
 	clocks = <&clkc CLKID_SPICC>;
 	clock-names = "core";
-- 
2.20.1

