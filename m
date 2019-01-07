Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28545C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD572089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y9L8sBmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfAGJxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:53:31 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40208 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfAGJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:53:21 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so247249edr.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 01:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SKzOiXnEB8V8kNaFY7oKymTvoiedc8KfN1lhPOUJLQ=;
        b=Y9L8sBmEUN0ssnruN1jgw0AIE0tp2H1pffnw2gT/arl0ktarhfuXwpE1/QgyXQoMQD
         naiDwBew62y9TlHWhboXrcpQ8pMhwGkV/Sfc6N6TJiftPc+BtMupzxtIeC7g+YlAAnHi
         B2vs04jImVZ96RoUJopKX7Y7JeMmjmnocng2hrpKR+peOKqRpMeyTSKxemDGUZsx0dn0
         bagXDRaiqNWVB+xJriYjRRzg9N6uk0DeiPiDnxEdYPl73lXmYI8WVUdydVAsAdBiVIpE
         +8x5IEePR3U7YFwNH8RwuFKehhuNhnz1KvUuuaXuaAYPi/nPMxeNdcGKbgUCGD7gWjet
         2hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SKzOiXnEB8V8kNaFY7oKymTvoiedc8KfN1lhPOUJLQ=;
        b=Up6V3N1K4EGBe1BdZdQWBjWUt2oJ+GAQIqtYpLSZOZxKxgNYH+fj0+E/Fm9YJxNv9t
         M20rPuY8ix2goOGvzqsOejKavY6kJ7LZqRMxh/2Egtg2gQyReDct3mUscw61uZstQB7Q
         E7CAMzgRz5LLufzktZMFWDlTteRSDwPliLd8Tznt6cC9R3+9a+GzlQaaPHb2zMmKbXXO
         dYS27Y+ipzaPNbMciB4mFAtE8p+jRp0mhfwG4FLZZxK29iWbsCT8VVuVwO9r6SVQSqo3
         CavJGq6Zou6EQoIkqyzn3P48jJvDfvoYHqF7q0h5F0QoB1tqqHWrrOAc90EoG8wWHGs8
         CO+g==
X-Gm-Message-State: AA+aEWa7pOKhCB85w1wqqs4kX+0kCixXECduc6y7Rh6m706Ca22XdJ25
        455hiCw1X+Ts8NHXlx3GVAflhg==
X-Google-Smtp-Source: AFSGD/UouQf+f6JhSLbTJ6InMkLtv/eLnEguNHKAaQBHw2rmmmUtjEgi9dofj3ItJ8A6Of1kOqDa5g==
X-Received: by 2002:a50:f098:: with SMTP id v24mr55022704edl.78.1546854800261;
        Mon, 07 Jan 2019 01:53:20 -0800 (PST)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id f6sm35737049ede.53.2019.01.07.01.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 01:53:19 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: meson-gx: add support for simplefb
Date:   Mon,  7 Jan 2019 10:53:07 +0100
Message-Id: <20190107095307.15233-3-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107095307.15233-1-mjourdan@baylibre.com>
References: <20190107095307.15233-1-mjourdan@baylibre.com>
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

