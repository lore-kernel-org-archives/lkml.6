Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AA8C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46C2217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDwinDgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfAYLaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:30:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41334 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfAYLaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:30:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so9894864wrs.8;
        Fri, 25 Jan 2019 03:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VvuZ8hl8eBYpxwbsEYMwOLTbpcQiEop8FkF1ZB8j4vU=;
        b=aDwinDgZaneohOEdSdVIr9sq/a0yhoAyH6G2GA6zRRwDtgIiwim64mMJlvmbej7HTJ
         MdFklTQ/BMwrY/Xy5cYoTT3s00zbSk8Qkv/1RBFAhHlji8Rs428MCw733RP6xtt4UdKF
         KgUswniYgntTzjYvH7FxPmL0fsVZK2JP7kVtgy92Tju7ksggqpdiaHE811a7wlMUiqhi
         8Di/e7D7hDrYE7f34jJ5+pU+NfgUcI+dYQ8/ArFWxaUPfQGXxc7L445T9Hu2tovAWW4g
         h/ryfA+W/w9oTw6aaoX4wnjoh1pbCLqrgDQWrbaflDQ6Rwq1RR8YZrjt4xsalb9GQ+d2
         pf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VvuZ8hl8eBYpxwbsEYMwOLTbpcQiEop8FkF1ZB8j4vU=;
        b=tbYSPhzz6gPTvQgXMM4faCgJKm1ubfye16vXP+qX08HxODnQEGnCqnQzHAvGYWAatK
         EaXnewzxTlS+Lg6cRRF+Z6ylxcsWNan4vBuiWPi5p0MGoN7dsuQSijeMuSkWOoVCVJw7
         cibaIBe/NyD9EnqlX4vhG/C/HLYP5rgr2jIhS/nq5CZmMROIgUz403y9RTItOcLO6Pru
         lGABVitFqQ97jE5ooQmaXiBNFICrpbhG7g4dj1hJoW6EO6gq+kHS5l1uPgS5liVZAPPf
         6+N6fjH0AFrn9jRQ1r4+ZzJVHAZsy4nsPqgbHMUeRNcxITRmkoPQDsIL672otf3e3Cwa
         2PAg==
X-Gm-Message-State: AJcUukejgN/YoaIyEkyRE4BzwbeoTWmPjj57yIJC2seB9q7PRCx1LfO5
        MKALOwMx8oCOasuNhHHWwD0=
X-Google-Smtp-Source: ALg8bN5kP8CCimu+yM+jrVF1LZTOJbkENulywLNpVnt7TmMwQwf1WOn2+Ig2ytAtV84jqVXimsBz6w==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr11509763wrj.58.1548415820353;
        Fri, 25 Jan 2019 03:30:20 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id z17sm80107397wrv.2.2019.01.25.03.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:30:19 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arm64: tegra: Add XUSB and pad controller on Tegra186
Date:   Fri, 25 Jan 2019 12:30:11 +0100
Message-Id: <20190125113013.11447-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125113013.11447-1-thierry.reding@gmail.com>
References: <20190125113013.11447-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Adds the XUSB pad and XUSB controllers on Tegra186.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 135 +++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 22815db4a3ed..09d3b0d60e41 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -338,6 +338,141 @@
 		status = "disabled";
 	};
 
+	padctl: padctl@3520000 {
+		compatible = "nvidia,tegra186-xusb-padctl";
+		reg = <0x0 0x03520000 0x0 0x1000>,
+		      <0x0 0x03540000 0x0 0x1000>;
+		reg-names = "padctl", "ao";
+
+		resets = <&bpmp TEGRA186_RESET_XUSB_PADCTL>;
+		reset-names = "padctl";
+
+		status = "disabled";
+
+		pads {
+			usb2 {
+				clocks = <&bpmp TEGRA186_CLK_USB2_TRK>;
+				clock-names = "trk";
+				status = "disabled";
+
+				lanes {
+					usb2-0 {
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+
+					usb2-1 {
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+
+					usb2-2 {
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+				};
+			};
+
+			hsic {
+				clocks = <&bpmp TEGRA186_CLK_HSIC_TRK>;
+				clock-names = "trk";
+				status = "disabled";
+
+				lanes {
+					hsic-0 {
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+				};
+			};
+
+			usb3 {
+				status = "disabled";
+
+				lanes {
+					usb3-0 {
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+
+					usb3-1 {
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+
+					usb3-2 {
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+				};
+			};
+		};
+
+		ports {
+			usb2-0 {
+				status = "disabled";
+			};
+
+			usb2-1 {
+				status = "disabled";
+			};
+
+			usb2-2 {
+				status = "disabled";
+			};
+
+			hsic-0 {
+				status = "disabled";
+			};
+
+			usb3-0 {
+				status = "disabled";
+			};
+
+			usb3-1 {
+				status = "disabled";
+			};
+
+			usb3-2 {
+				status = "disabled";
+			};
+		};
+	};
+
+	usb@3530000 {
+		compatible = "nvidia,tegra186-xusb";
+		reg = <0x0 0x03530000 0x0 0x8000>,
+		      <0x0 0x03538000 0x0 0x1000>;
+		reg-names = "hcd", "fpci";
+
+		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&bpmp TEGRA186_CLK_XUSB_HOST>,
+			 <&bpmp TEGRA186_CLK_XUSB_FALCON>,
+			 <&bpmp TEGRA186_CLK_XUSB_SS>,
+			 <&bpmp TEGRA186_CLK_XUSB_CORE_SS>,
+			 <&bpmp TEGRA186_CLK_CLK_M>,
+			 <&bpmp TEGRA186_CLK_XUSB_FS>,
+			 <&bpmp TEGRA186_CLK_PLLU>,
+			 <&bpmp TEGRA186_CLK_CLK_M>,
+			 <&bpmp TEGRA186_CLK_PLLE>;
+		clock-names = "xusb_host", "xusb_falcon_src", "xusb_ss",
+			      "xusb_ss_src", "xusb_hs_src", "xusb_fs_src",
+			      "pll_u_480m", "clk_m", "pll_e";
+
+		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_XUSBC>,
+				<&bpmp TEGRA186_POWER_DOMAIN_XUSBA>;
+		power-domain-names = "xusb_host", "xusb_ss";
+		nvidia,xusb-padctl = <&padctl>;
+
+		status = "disabled";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
 	fuse@3820000 {
 		compatible = "nvidia,tegra186-efuse";
 		reg = <0x0 0x03820000 0x0 0x10000>;
-- 
2.19.1

