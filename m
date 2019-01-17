Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B448C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7D32054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SY8UCb2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfAQKcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:32:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45765 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfAQKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:32:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so10335098wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M+aR/gi/5Y1MXmA3l33o5cCv3DhvJKA6RGHAmdL+89w=;
        b=SY8UCb2S0aaTYBSBMrVuMWUti2aRFjdJweUYsAczAg3S2YJp00MXuhAArZwOAZjBxd
         qft3/c49Rg2REcF/2R9S/TjNJTA5IfGfZqfB1ES3VWlREWlmgk0/7qtLrsNsTnKdnmJY
         g0+lczJRdclQGr6CJRcLx2lH6xIOyuHTsR4d8sn8QvZlBv1+mX+zRuXL3agPBvX1SuKR
         ZKZfKaHa5XDLr9/KqSoEN+PePn894BZV6z5cBBgc4PJPI3dXZ/vrrOqaTka+yjTBJzeT
         UgWpUG4NSqmMuyXMvNho7IXujzPlw6o+ACnBj3DAcb/9dkN7pxr5SdEOvby5qv+Tzyvr
         d2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+aR/gi/5Y1MXmA3l33o5cCv3DhvJKA6RGHAmdL+89w=;
        b=HyaX04uYeC85eDhLuQe6d1TjDgM4uolBzzI7wl3CL3vr/mUMuFUw73gACFneHd+i1E
         CXy33LWBkU6GxqdQBDnydVh0f8wTL7iCJVp1uZLYIQCUu23WTbRMrsJiKWXfuCm/C5Ho
         L98xECLScesfloH9sX/ovP67JfoJ+GIbTD6y2r0hyHDmw5+D2sVx8tdKIpvloGDmZ80e
         ntRyWGaWSFYq6EvVNaz19YdgqjbrOkwkonHy6+Q3RoS2F1EtojBa8Jti1V+KlWLMA82e
         Oz73rGHvGD2nTTiKXcbTr5rqg4/M2pGxK/bgedrcZjJOW0Kqdhu7Y2QNl0fECrFhklYV
         O51A==
X-Gm-Message-State: AJcUukc4a+zGka9ydd4NipdIpAam8km73+hFTRj0WDx47p93kLmwCFmS
        mnC2pyYxV5rMA1HKiM8gVN28oQ==
X-Google-Smtp-Source: ALg8bN4YkpBB3huWK8lh1EuyQGOrr2d5EI1/BmoKj3CHaog7uoztiS6ucApg5SKmsOqikCI0cSvs+A==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr11891258wrm.223.1547721120855;
        Thu, 17 Jan 2019 02:32:00 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id 143sm77658107wml.14.2019.01.17.02.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 02:32:00 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 2/2] arm64: dts: meson: g12a: add uart_ao_a pinctrl
Date:   Thu, 17 Jan 2019 11:31:51 +0100
Message-Id: <20190117103151.3349-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117103151.3349-1-jbrunet@baylibre.com>
References: <20190117103151.3349-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the always on UART pinctrl setting to the g12a soc DT and
use it for the u200 reference design

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-g12a-u200.dts |  2 ++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi    | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index c44dbdddf2cf..f2afd0bf3e28 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -25,5 +25,7 @@
 
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 39ad2bbaa162..bd24de947a5b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -140,6 +140,24 @@
 					gpio-controller;
 					#gpio-cells = <2>;
 				};
+
+				uart_ao_a_pins: uart_a_ao {
+					mux {
+						groups = "uart_ao_a_tx",
+							 "uart_ao_a_rx";
+						function = "uart_ao_a";
+						bias-disable;
+					};
+				};
+
+				uart_ao_a_cts_rts_pins: uart_ao_a_cts_rts {
+					mux {
+						groups = "uart_ao_a_cts",
+							 "uart_ao_a_rts";
+						function = "uart_ao_a";
+						bias-disable;
+					};
+				};
 			};
 		};
 
-- 
2.20.1

