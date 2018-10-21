Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805FAECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4205C2082C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3MDfV5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4205C2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeJVFNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:13:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43160 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeJVFNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id r8-v6so35097877ljc.10;
        Sun, 21 Oct 2018 13:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pwkhE9yh1lc640hBWKAW3eqSENRoU7AnVw6zzAMTjtg=;
        b=j3MDfV5lc6jAiu2inCIw5SjuJQvKFqzesYt4pKXohHCeQanBT97oPlTDT14YhrVFs5
         MEpejW3qZshNnxIHI/fWrQM9Mn2vjQFPcxCE6Hy7ww9gBRxSKFUzWhcMyuIB6EnKuuzw
         ptJYxUh26e6TMv73744Cl66ZkgNaQnAI7Qz3jpVmAgJ+TV2jEL97314desm8p9aYboIy
         rPQ0R5PA6bSCCgVtGeLgCEwGrPZT2N4opIiOSi5A/ihJ/P9umTv5NURqgjyH35zuj8+D
         vSljqS2l3PouQ6D8eIIRqb64zj7NoG3i8NcTx4g9fRSz0GQ/A330ybXX2PWEAKlXqXw5
         aHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pwkhE9yh1lc640hBWKAW3eqSENRoU7AnVw6zzAMTjtg=;
        b=qZ/1BYBwzblRRG2HShtOC8t/BsNJp7Z7nJp3v3bu+UA3uj/edUV0TOt3tyGh8BroDQ
         Pz2fPsFNpN4ZXTPz3bIh7qI9CYXveE5IzrRpdWUHmok21TZT5fc98Yu+q/Y0DzsrR1rc
         H4/elV6XCcvN4FfvK7SY0sJMVyO718rk7Jm/6pmlahWxFmM4kZpLOECrXX+v7TR87ZE5
         aiuinTubUu8Gu8PVN2uCMTWETQkrXlt+oJX74Km2Ouom1P/tm3P42BDOmH8sXojq7hX9
         s+wC/0YWy4vtMdw+6Z52Mk8lp3eSOi2yNLANFK0xowHOjkvvRY5OJ03qgrtoRgWJViCg
         RDYA==
X-Gm-Message-State: ABuFfojRS4Tm7c2kXpKBcaKysk4DRhfNYlrTJF0dWchEYSj5/EtAdNkh
        /a2PGUuAWNFnrNgfMuu7eBo=
X-Google-Smtp-Source: AJdET5c0QzY+bgWoZz1MclfGhaWHxPfOxeN7dPV8UFVRWbKiP7MuzhQZMnpBI5eTwtr6IhSACZ5BKg==
X-Received: by 2002:a2e:240b:: with SMTP id k11-v6mr5954900ljk.139.1540155492504;
        Sun, 21 Oct 2018 13:58:12 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:11 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/17] ARM: dts: tegra20: colibri: Setup voltage regulators for DVFS
Date:   Sun, 21 Oct 2018 23:54:52 +0300
Message-Id: <20181021205501.23943-9-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra20-colibri.dtsi | 31 ++++++++++++++++++--------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 6162d193e12c..5b3155dbf47a 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -495,17 +495,19 @@
 					regulator-always-on;
 				};
 
-				sm0 {
+				core_vdd_reg: sm0 {
 					regulator-name = "VDD_CORE_1.2V";
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
 					regulator-name = "VDD_CPU_1.0V";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
+					regulator-min-microvolt = <750000>;
+					regulator-max-microvolt = <1125000>;
 					regulator-always-on;
 				};
 
@@ -530,10 +532,13 @@
 					regulator-always-on;
 				};
 
-				ldo2 {
+				rtc_vdd_reg: ldo2 {
 					regulator-name = "VDD_RTC_1.2V";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
+					regulator-min-microvolt = <950000>;
+					regulator-max-microvolt = <1300000>;
+					regulator-coupled-with = <&core_vdd_reg>;
+					regulator-coupled-max-spread = <150000>;
+					regulator-always-on;
 				};
 
 				/* LDO3 is not connected to anything */
@@ -740,6 +745,14 @@
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
 
 &gpio {
-- 
2.19.0

