Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE07ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2F02082C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAM5zKnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2F02082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeJVFN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:13:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44990 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbeJVFN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id m18-v6so28807909lfl.11;
        Sun, 21 Oct 2018 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCr7GO7Iq5Y7bRaR7BM38wZmN8Gdtnzq1YAYU5cFX8w=;
        b=sAM5zKnEloKH4E7B1p0tOi0MR1Z0KVDoHZooz+DptlYqoEA4nJhalQ+G2t8q4q0UUS
         bsJJkIPq0i8gX85xC8cn6wokAi1u6u3CEtpUz4BIoD2JV6q0tC3afip+AC09sbNSamie
         hvRQTSlTzXbAU8RlkzhuuCoiqqT9He5mxM3+1IDHYLkwvWHCjov4y7K+IsCF5/aa8UHs
         pUTPK8bQMp5KYuEWgsn8RJk3fP1lZ1K39RV7Z3NN4JPXEH824gu5wV0hkQ/9i7OCO8hy
         Y4qKT1kcjcv+O/rM05ecQVNaKQG0xQqPxIzNjNRHYSxB9TVUMd1iBQjkZJ4quaxaLOlF
         Hycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCr7GO7Iq5Y7bRaR7BM38wZmN8Gdtnzq1YAYU5cFX8w=;
        b=m975hGKeabKcYMO/LmBRw2bJf8xcZn7F1qcqP3beIAah+C46/2+Gtbtl/n/gk0TX+7
         EeHZfPz8M52MhbvxlRA/EX2wsCLs6fSHQQXGaLzjtHrd987z0TecwSciP7qxlNLurs/u
         5F1K2eXuo2CtJvBMITqV1OGcT/z0RB/209HliMF+JmtOQx2rNp4IPOLQtHINd6deetAF
         BzfDxATKpR/gpZAWjgBD5wLSXv1kFrTVm8Me8luF+2A01WaBHOA9p5n7mzE4Sdo8TDV0
         OXPWNg3jm2vNH4Sl0tKTYQUdy4QIGkosJINkuRisAycuawF9GrmpxF4Vw0jVamnjV15e
         XIpA==
X-Gm-Message-State: ABuFfogvVxNiNRkqTk6MHhT8ha65x9dSjzyi38juYtR7RPO8a5KQbdgD
        LZCSkWpThGEOO8SfVeNOv0tbn2qA
X-Google-Smtp-Source: ACcGV63ykze29jsaL4SPe6FdBA/hyZ4qiqg66/Jr+b4ZAJ/irigoIwRJ9oI9KNi0lArXNqmb949a+w==
X-Received: by 2002:a19:2b54:: with SMTP id r81mr1515429lfr.34.1540155498798;
        Sun, 21 Oct 2018 13:58:18 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:18 -0700 (PDT)
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
Subject: [RFC PATCH v2 14/17] ARM: dts: tegra30: apalis: Setup voltage regulators for DVFS
Date:   Sun, 21 Oct 2018 23:54:58 +0300
Message-Id: <20181021205501.23943-15-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra30-apalis.dtsi | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 7f112f192fe9..1ca9bec8380f 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -890,8 +890,11 @@
 
 				vddctrl_reg: vddctrl {
 					regulator-name = "+V1.0_VDD_CPU";
-					regulator-min-microvolt = <1150000>;
-					regulator-max-microvolt = <1150000>;
+					regulator-min-microvolt = <800000>;
+					regulator-max-microvolt = <1250000>;
+					regulator-coupled-with = <&core_vdd_reg>;
+					regulator-coupled-max-spread = <300000>;
+					regulator-max-step-microvolt = <100000>;
 					regulator-always-on;
 				};
 
@@ -1013,13 +1016,16 @@
 		};
 
 		/* SW: +V1.2_VDD_CORE */
-		regulator@60 {
+		core_vdd_reg: regulator@60 {
 			compatible = "ti,tps62362";
 			reg = <0x60>;
 
 			regulator-name = "tps62362-vout";
 			regulator-min-microvolt = <900000>;
 			regulator-max-microvolt = <1400000>;
+			regulator-coupled-with = <&vddctrl_reg>;
+			regulator-coupled-max-spread = <300000>;
+			regulator-max-step-microvolt = <100000>;
 			regulator-boot-on;
 			regulator-always-on;
 			ti,vsel0-state-low;
@@ -1168,4 +1174,11 @@
 			 <&tegra_car TEGRA30_CLK_EXTERN1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	cpus {
+		cpu0: cpu@0 {
+			cpu-supply = <&vddctrl_reg>;
+			core-supply = <&core_vdd_reg>;
+		};
+	};
 };
-- 
2.19.0

