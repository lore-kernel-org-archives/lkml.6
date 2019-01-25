Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F8DC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCB1217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QskVF/Kk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfAYLa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:30:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45830 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfAYLaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:30:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so9866752wrr.12;
        Fri, 25 Jan 2019 03:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wsFMYnQVROXFGge9r2lQVfbIp4Bz8dAyrnsFbHGou2E=;
        b=QskVF/KkFzoOPm1Bru1aQpgPKQ3xKLtsJO3byC/MqMH/7M5wVkzs+QTO0syDqKIE/J
         IFyLbQsy09dEF0fkQCLnHmKC+OEK/wdLHIZ9YvDS/qFEjiLcCyu4rZk6ZPlflASR8y6k
         zN0qpg9UFM19z9EOQG0oMBZk1+BKlVamSBRFhR5ZuHHqO8sp4B2oHbSpaWOmW3B2XlsR
         J2kPNcG13VUVxSjgYLSBR/xPErUGUoXQFFpdG/nDrwl2B4wj6C9Z7yaagbezI5S1SWIg
         lhfUlFI94u18R/s3Sr8Fz3cmtmYM2Chmug6/lcJqTKd7wHav3dESu/DiTGmkNSOcTgWe
         OTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wsFMYnQVROXFGge9r2lQVfbIp4Bz8dAyrnsFbHGou2E=;
        b=cchdyJEWUN79olApPKdM0WkSCNsGlg3EfD9eoJuj+zs1gTnkjRCeqR+OhPLrJkXbeg
         okSUB+rQM53E/a76cTf5prYb1Z3nEgCEupi+KuAVjI6P2eTz84giC0VXfFrYLJJQm1VD
         +ZyVW/j/2UGvjtQv208gBsOXuTiSdEA7vHkbqCh1Zp5QXjVMyKfM7Tygk6sT+yBlnBmV
         GbrONDahpG4XyL5mMSqsm6WM0du+RUlNxuoWW4aCoorW3iWAEZiMvfR6JLalXX0x9+aL
         FudDJQ+6KliugxGT8idxSuWIStsg3p2ZJNNDZBRjYxyk4REFO+3vvNBs78XGEOxzcf2b
         iIEQ==
X-Gm-Message-State: AJcUukc/FtVIqskVjSmYIMg05gloANnP27G3fnSz0vc4pK/Bq0q8VjoX
        WVXoEr+1m2HWdeTODJ4Duba4VX7ABhk=
X-Google-Smtp-Source: ALg8bN6P7RUB/BIGPVkJGL/hu54KVEg2Py/nuUeyfk3XR36mQhHWjnNuXbzqWuGpSwLmCXsJhmx7yg==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr7805350wrq.265.1548415823365;
        Fri, 25 Jan 2019 03:30:23 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id l19sm61715585wme.21.2019.01.25.03.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:30:22 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: tegra: Remove regulator hacks on Jetson TX2
Date:   Fri, 25 Jan 2019 12:30:13 +0100
Message-Id: <20190125113013.11447-6-thierry.reding@gmail.com>
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

Various regulators were marked as always-on for Jetson TX2. At this
point, all of the regulators are properly hooked up, so this workaround
is no longer required.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 23 -------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
index eb64d9be3231..0b62f80b0e86 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -266,43 +266,30 @@
 						regulator-name = "AVDD_DSI_CSI_1V2";
 						regulator-min-microvolt = <1200000>;
 						regulator-max-microvolt = <1200000>;
-						/* XXX */
-						regulator-always-on;
-						regulator-boot-on;
 					};
 
 					vdd_1v8: sd2 {
 						regulator-name = "VDD_1V8";
 						regulator-min-microvolt = <1800000>;
 						regulator-max-microvolt = <1800000>;
-						/* XXX */
-						regulator-always-on;
-						regulator-boot-on;
 					};
 
 					vdd_3v3_sys: sd3 {
 						regulator-name = "VDD_3V3_SYS";
 						regulator-min-microvolt = <3300000>;
 						regulator-max-microvolt = <3300000>;
-						/* XXX */
-						regulator-always-on;
-						regulator-boot-on;
 					};
 
 					vdd_1v8_pll: ldo0 {
 						regulator-name = "VDD_1V8_AP_PLL";
 						regulator-min-microvolt = <1800000>;
 						regulator-max-microvolt = <1800000>;
-						/* XXX */
-						regulator-always-on;
-						regulator-boot-on;
 					};
 
 					ldo2 {
 						regulator-name = "VDDIO_3V3_AOHV";
 						regulator-min-microvolt = <3300000>;
 						regulator-max-microvolt = <3300000>;
-						/* XXX */
 						regulator-always-on;
 						regulator-boot-on;
 					};
@@ -329,18 +316,12 @@
 						regulator-name = "VDD_HDMI_1V05";
 						regulator-min-microvolt = <1050000>;
 						regulator-max-microvolt = <1050000>;
-						/* XXX */
-						regulator-always-on;
-						regulator-boot-on;
 					};
 
 					vdd_pex: ldo8 {
 						regulator-name = "VDD_PEX_1V05";
 						regulator-min-microvolt = <1050000>;
 						regulator-max-microvolt = <1050000>;
-						/* XXX */
-						regulator-always-on;
-						regulator-boot-on;
 					};
 				};
 			};
@@ -388,10 +369,6 @@
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 
-			/* XXX */
-			regulator-always-on;
-			regulator-boot-on;
-
 			gpio = <&pmic 1 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 
-- 
2.19.1

