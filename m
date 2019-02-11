Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CF1C282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625ED20863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxZ3E1TE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfBKJVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:21:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40094 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKJVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:21:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id q21so15681862wmc.5;
        Mon, 11 Feb 2019 01:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kouOcgNi61HTRl9hVkQr6BVwZ6zXz4ll84P22bRURRY=;
        b=nxZ3E1TEGoQjfdA8uEkVGBINdi30O9EuQ/4tMIcDcZHxYSh5WvSlsOvgCud3kcuSzg
         5rXlmZ1z0I1FV0VhYkz4uezpr2SlxjE0/claa4nMeSU2MigRU56yXDepa/EVFTO6UXgE
         usw+y79CTHwNlYwmLmm2yOLyTUBPa84Ija/Zd1NvuFTuHrjMiQLVSD0ZbSH4pb9QdbHm
         jVwH2Mw1KSIPEZ6v69uVzsyqh/nJj0AczX0AAe40ioZS7QwQ1fM7FcTz8D8Oyblhx5ut
         izMBDzvlc3MetW20GxidHULJGVzT+EyHmZKg+RUyvqFtmMToouev9/tCfwUooQjCycm7
         M2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kouOcgNi61HTRl9hVkQr6BVwZ6zXz4ll84P22bRURRY=;
        b=j9PG8Y3/5qSHHRwImxCS/dFcVuXBTxzb6zECP3NjEyt02velchS77BYjMOzBaqhzZq
         FLBCX1DXHydIgaJH0MB5e3shTA4Yk0HM0Why1iMCxGgE8Any1iBA8qLB1ek/civNn2f9
         bFbYpWjYmgG+ZFyQ2TTBaWZ0Ajd3dJWGAtcHmdAJAdZNpswMYxEbTKan14McJ/FNxsIl
         C3o2ImMS5A1yG0Xy2L7RLWnpJM/1ZkEkAf721xaa35SXoMByX9XEtXyETv2gLSUR52dp
         Re7rOwlRjJP52uzTeI7GARAhsAusVJp3qssOAbkoxxb6MGTgYyQ/ui8EZOvfkqKNO/TW
         AS5A==
X-Gm-Message-State: AHQUAubvOXwAevLQ0/zIXnYO8c/WncmAujMU5MMxiaRmQZRImt0r6qPg
        0dEeTTow6UwNEWfnvDtOjpwcF8ycS/A=
X-Google-Smtp-Source: AHgI3IaJ8EMjjtLQ9xm5fWXo4hyjggK8WDV+q7h2jv4C0j66gduhBvULOd222vN7DxTLt0qMvzJ7nA==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr27397974wrw.123.1549876909938;
        Mon, 11 Feb 2019 01:21:49 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
        by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 01:21:49 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 3/7] ARM: dts: suniv: Add dt-binding headers for F1C100s
Date:   Mon, 11 Feb 2019 12:21:09 +0300
Message-Id: <7ad73fd5c2664a50722cf0771512433483a629ca.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dt-binding headers for F1C100s merged now. So add them back to dtsi.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index 6100d3b..953228c 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -4,6 +4,9 @@
  * Copyright 2018 Mesih Kilinc <mesihkilinc@gmail.com>
  */
 
+#include <dt-bindings/clock/suniv-ccu-f1c100s.h>
+#include <dt-bindings/reset/suniv-ccu-f1c100s.h>
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -82,7 +85,7 @@
 			compatible = "allwinner,suniv-f1c100s-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <38>, <39>, <40>;
-			clocks = <&ccu 37>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
@@ -114,8 +117,8 @@
 			interrupts = <1>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 38>;
-			resets = <&ccu 24>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
 			status = "disabled";
 		};
 
@@ -125,8 +128,8 @@
 			interrupts = <2>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 39>;
-			resets = <&ccu 25>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
 			status = "disabled";
 		};
 
@@ -136,8 +139,8 @@
 			interrupts = <3>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 40>;
-			resets = <&ccu 26>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
 			status = "disabled";
 		};
 	};
-- 
2.7.4

