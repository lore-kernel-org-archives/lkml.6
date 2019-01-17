Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13BDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0932054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Bqj58vkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfAQKcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:32:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41776 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbfAQKcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:32:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so10355992wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59lSFWiKXUet4YBV9ctjDOXoipeUSkvqSc4ERhu10Hk=;
        b=Bqj58vkKOyRYZCoMa5TrckC29HjEgfW6Ls+PRJ/0QM4b22jpGTvgdFOA2HS+Id4y3c
         C1shCH1rHGsIpweCdGhNZetg5vXVVh/3Zr8I9h8Xo3nVJFDh48k3LGZA0gX5gXLuv/sn
         B2piQrauOXroZ74Tq5FuzpCPNMv7mge0L1kauNPUU1iZjBVuuiYc0ltDoCNReSRcKeFo
         uCg9JMsSDIjAyTUxbOYaKlzr9RWdyJpS1OSXHc3yMRBXwhTaTnjdwO+Sg2C983QcXWk2
         FvHfNm98G/qmRnPQyR11XtRl3Cvsu0WoczXM0gT8wEQT5rsnax5C6cmEyVzC/Bnq0scg
         yANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59lSFWiKXUet4YBV9ctjDOXoipeUSkvqSc4ERhu10Hk=;
        b=N0roMw0r5aLVkornXeBFFx/4lzuuyLq5nzapdhvJZNAZBBsOHyENPfQbICNsCMqr1o
         NX/0pjsse+Ax3zGB6fOLivKF9M98I4DBOgCyOr+TpU7fnys26yubDDeXCfLqixzhJjb0
         n7GK/z37Dwl2942nIOnfQeWerjKxPGHQ56FxFc8aAHNvRKVazF8d//vISXpANIfxQiCa
         iJLCrZRlUT25k0VPD4gQ8GtEn2TENgANwLW8gwpHeohLfQzkijecPSvL6o/6M1q/aOIo
         DtY5+3MR6H4QPWmqRP4BV1hxp8j+IIh+MLHsepYFUH5g+fH/fYDpww3jj/U8r5qt8iiq
         Vm2A==
X-Gm-Message-State: AJcUukdaeVLl2PIqm7EcHCXmAi2R9fSaNAhJ5Y/cW2UZtwmvigf3/1dc
        CujCrXT49MMStvZ3pdbFIHuYmQ==
X-Google-Smtp-Source: ALg8bN7s5VbZn0Sj44pkmrn8b87kVUa+xpO0SLvjkz+eDt0L3Y83kMydB5RFWeXiNPPeVFe/8+FvNg==
X-Received: by 2002:adf:8143:: with SMTP id 61mr10995914wrm.47.1547721119612;
        Thu, 17 Jan 2019 02:31:59 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id 143sm77658107wml.14.2019.01.17.02.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 02:31:59 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 1/2] arm64: dts: meson: g12a: add pinctrl support controllers
Date:   Thu, 17 Jan 2019 11:31:50 +0100
Message-Id: <20190117103151.3349-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117103151.3349-1-jbrunet@baylibre.com>
References: <20190117103151.3349-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the peripheral and always-on pinctrl controllers to the g12a soc.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 49 +++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 2aea5ba62fee..39ad2bbaa162 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -84,6 +84,29 @@
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xff634400 0x0 0x400>;
+
+			periphs_pinctrl: pinctrl@40 {
+				compatible = "amlogic,meson-g12a-periphs-pinctrl";
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges;
+
+				gpio: bank@40 {
+					reg = <0x0 0x40  0x0 0x4c>,
+					      <0x0 0xe8  0x0 0x18>,
+					      <0x0 0x120 0x0 0x18>,
+					      <0x0 0x2c0 0x0 0x40>,
+					      <0x0 0x340 0x0 0x1c>;
+					reg-names = "gpio",
+						    "pull",
+						    "pull-enable",
+						    "mux",
+						    "ds";
+					gpio-controller;
+					#gpio-cells = <2>;
+				};
+
+			};
 		};
 
 		hiu: bus@ff63c000 {
@@ -94,6 +117,32 @@
 			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1400>;
 		};
 
+		rti: bus@ff800000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xff800000 0x0 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x1000>;
+
+			ao_pinctrl: pinctrl@14 {
+				compatible = "amlogic,meson-g12a-aobus-pinctrl";
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges;
+
+				gpio_ao: bank@14 {
+					reg = <0x0 0x14 0x0 0x8>,
+					      <0x0 0x1c 0x0 0x8>,
+					      <0x0 0x24 0x0 0x14>;
+					reg-names = "mux",
+						    "ds",
+						    "gpio";
+					gpio-controller;
+					#gpio-cells = <2>;
+				};
+			};
+		};
+
 		uart_AO: serial@ff803000 {
 			compatible = "amlogic,meson-gx-uart",
 				     "amlogic,meson-ao-uart";
-- 
2.20.1

