Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6FDECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D898D2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PQj0/Sun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D898D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbeGPVIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:08:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33684 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbeGPVIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:08:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so10900162wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 13:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udC57cn5u9c5i2H+v2VgFK64mvVakVjvjdgnIegpQpI=;
        b=PQj0/Sunui1BSvH25lVGr6/UO3BaQfz7ej9gMU33s679QSXLKod72ZHrqvPM2wf2hG
         kK36HvKwYASt8HHAHea0koaDDL5jgDs4mX0muZL+O6kJQXIMqf/2TaRcR9yn48rmHaqa
         x1dtUaUTcX6TpPiIVV0RiQK/cgAlJs9n3wkvU4EMnbUKpu6vsZw6MGkD17aFMnamKDlt
         P2Gw23rpK/X14fMU5EvO24SvsZlN9zXh20f7k48Qq+p9Qpdbzx7eBr09CXxvKe+PZ205
         F/C9XTUk3Ca6Zm6IaA1y2OSQmBfYOBKBchoDdICE4ibiio7kB3tgbPmzzo2MTnHYCYfv
         iMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=udC57cn5u9c5i2H+v2VgFK64mvVakVjvjdgnIegpQpI=;
        b=NPtM3yIvJE1aZsRBew+sQ00Wj2PcWI4Scy3ytnkyChC3d9/ii4XDiokJtYrytILryj
         Y2K7K0eSpqr10oiuyyI6SzpWGEUIPaS7JVxqGBUeXDOz4yhFFAGJ3TuzKCsD5Ar57K89
         tRyFzqa1oTC/yt10ozZNRmu+5sxow3uVYnGet6ORa26FkFI1RfLfj8MPkMRiziJW8WGC
         egd7L6EYBUPKLICKTnGT94DRkaQ+EDwZk9DU1FfSsymF88b1D1INfPgii4vAKsUcPaUL
         ZGa67A6l8kSm3tWzZ3UkauR8bp9qfq3XCoiG6hGglIiZnwi7Fg3wVEebvfJgNBYJM/5B
         Ml+Q==
X-Gm-Message-State: AOUpUlGuftL0Vic4+2gtpXx3O9GBqIe+xEiJcSrCuA99oQ9Sjf4UlMZb
        QGOLuFl31wSP835GCFr5pootxg==
X-Google-Smtp-Source: AAOMgpdXvsSm+MrHJ8E1Uh0wdGSpTQiu+T+m1FMVmxRNp3yYod/x0lEwwxDY4A9/HlsZJhAN0yds5g==
X-Received: by 2002:a1c:c541:: with SMTP id v62-v6mr10966011wmf.57.1531773546764;
        Mon, 16 Jul 2018 13:39:06 -0700 (PDT)
Received: from bender.home (LFbn-MAR-1-570-38.w90-118.abo.wanadoo.fr. [90.118.15.38])
        by smtp.gmail.com with ESMTPSA id j43-v6sm53533686wrj.1.2018.07.16.13.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 13:39:06 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     tony@atomide.com, daniel.lezcano@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        aford173@gmail.com, drivshin@awxrd.com
Subject: [RFC PATCH 1/4] ARM: dts: am33xx: Add all fck timer clocks
Date:   Mon, 16 Jul 2018 22:38:59 +0200
Message-Id: <1531773542-15736-2-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing fck clock to all timer nodes of the AM33XX dtsi.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9cd62bc2..e8e665d 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -541,6 +541,8 @@
 			reg = <0x48042000 0x400>;
 			interrupts = <69>;
 			ti,hwmods = "timer3";
+			clocks = <&timer3_fck>;
+			clock-names = "fck";
 		};
 
 		timer4: timer@48044000 {
@@ -548,6 +550,8 @@
 			reg = <0x48044000 0x400>;
 			interrupts = <92>;
 			ti,hwmods = "timer4";
+			clocks = <&timer4_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -556,6 +560,8 @@
 			reg = <0x48046000 0x400>;
 			interrupts = <93>;
 			ti,hwmods = "timer5";
+			clocks = <&timer5_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -564,6 +570,8 @@
 			reg = <0x48048000 0x400>;
 			interrupts = <94>;
 			ti,hwmods = "timer6";
+			clocks = <&timer6_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -572,6 +580,8 @@
 			reg = <0x4804a000 0x400>;
 			interrupts = <95>;
 			ti,hwmods = "timer7";
+			clocks = <&timer7_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
-- 
2.7.4

