Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5308DECDE45
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7A3208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpFlil4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7A3208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeJVFN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:13:58 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38950 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbeJVFN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id p11-v6so2376835lfc.6;
        Sun, 21 Oct 2018 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tWzv0d5FugDUKV37/6bOSJudJz4wanydeDntdPB6yA=;
        b=SpFlil4e7QeqcqOyx63r0+UTqCHuOGGKvveCc7JG9SsgXuFDJMjfkVjXcc8bjOJzlu
         nvWhGe3bK7fgz8Vja3tc5ftYeo9V5TYG+PQtNwi2BVgVPjpTPmkAtXBYGzs/A2Mg6Jo0
         IqubQcti7tC6ck9GrR/iSXcdZ+SN5M0E2k9J8PadJ4DbpnNLbxxKpuNceoLRJyQ3eFrV
         l8ex3/dlIMA8TIRDjzMkat1RRr3u0y/zhIGtRrl3P5oDfhTWPUYiTOARITJhBHgkxGZM
         m28hrCr+JyyrsAFCVtXTZBZTXZGSY4Fn4RPGHqGSW3RfsZ/+WlRxWAFXTqoWlv8cGRHX
         g44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tWzv0d5FugDUKV37/6bOSJudJz4wanydeDntdPB6yA=;
        b=JLe5eNnCBKnT3JPLMI2TDr1V4vFTrh0Sf2ZjjNvRSssZRZcgzX5DVw/i+KUGu78mKC
         v4hOn4iu77RTVw5qQOUgMKDPavp7yuiULXLoerSk6PJi/NIkwWsjYqnnOM5TDaHbvb3W
         5qygZ81A1robNLIR1hLR/2S0G/PfCFrnR/cJHDk82pyLtOXHP/SYIu7ZJ40URlzYUvBq
         1qnf7nGEoOA6ZMiAHpbS1A1sZAtYSzSLNM6wCR4mYfYY1y2+HeQsKxfHu+7mp1LNy4d9
         zewJAvj/yIPqbzNnfC03hwPoDnopvZNwhDWCYz28F/RJ6WXVa3jZfoiXsUzQobLUjiPV
         Tevg==
X-Gm-Message-State: ABuFfojOTrdLNPMBV48gDJoinBkXN3QoLOVTSIdPKmL69mUQwAL5x6f+
        XgABNpsVBLFveWpFkWhBsf7Kpeoy
X-Google-Smtp-Source: ACcGV62H4kTBYKEqjCqMav6OTCRVrTfoLcv9xBdUhFway8rBWBpMuAySkLLK5PakdPAc1Svax1A25w==
X-Received: by 2002:a19:4f04:: with SMTP id d4-v6mr7376798lfb.121.1540155497776;
        Sun, 21 Oct 2018 13:58:17 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 13/17] ARM: dts: tegra20: ventana: Setup voltage regulators for DVFS
Date:   Sun, 21 Oct 2018 23:54:57 +0300
Message-Id: <20181021205501.23943-14-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021205501.23943-1-digetx@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set min/max regulators voltage and add CPU node that hooks up CPU with
voltage regulators.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-ventana.dts | 31 +++++++++++++++++++--------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index f44551e2d9d0..ef9cdd7335ae 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -419,17 +419,19 @@
 					regulator-always-on;
 				};
 
-				sm0 {
+				core_vdd_reg: sm0 {
 					regulator-name = "vdd_sm0,vdd_core";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1300000>;
+					regulator-coupled-with = <&rtc_vdd_reg>;
+					regulator-coupled-max-spread = <150000>;
 					regulator-always-on;
 				};
 
-				sm1 {
+				cpu_vdd_reg: sm1 {
 					regulator-name = "vdd_sm1,vdd_cpu";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
+					regulator-min-microvolt = <750000>;
+					regulator-max-microvolt = <1125000>;
 					regulator-always-on;
 				};
 
@@ -449,10 +451,13 @@
 					regulator-always-on;
 				};
 
-				ldo2 {
+				rtc_vdd_reg: ldo2 {
 					regulator-name = "vdd_ldo2,vdd_rtc";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
+					regulator-min-microvolt = <950000>;
+					regulator-max-microvolt = <1300000>;
+					regulator-coupled-with = <&core_vdd_reg>;
+					regulator-coupled-max-spread = <150000>;
+					regulator-always-on;
 				};
 
 				ldo3 {
@@ -704,4 +709,12 @@
 			 <&tegra_car TEGRA20_CLK_CDEV1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	cpus {
+		cpu0: cpu@0 {
+			cpu-supply = <&cpu_vdd_reg>;
+			core-supply = <&core_vdd_reg>;
+			rtc-supply = <&rtc_vdd_reg>;
+		};
+	};
 };
-- 
2.19.0

