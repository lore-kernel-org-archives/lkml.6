Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB844ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05A82083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvukRxzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05A82083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeJVFOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:14:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35682 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbeJVFN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id o14-v6so35129879ljj.2;
        Sun, 21 Oct 2018 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bfPxAABb1jDJ2Qsfc7iJcf6o4lAj7GKSnk+3Z0pbBag=;
        b=hvukRxzSmBceCx29ruL0uS8bUhVtVE88aU/eK0GdgRuVcsnqbm/Xt/Rw444+RvX1zw
         +xZ8rZUOxFZ6z6baEoEb+t53r1w2qk5HM5y12heW48zmlkW0TzP3UcJ3W7obMqFwcGRs
         /21v/4kGv7weSfwWSzi/kJREmhMP58wnlrbnLV0Z+WVR3AqpJbFccR6gYK6IEA/HiDd4
         kv0Os9Lz1h8aXEboS+4JWKvKx384pPUFdd6wGscIV9zuouA+jcombYRURwW72ZTPADKw
         PbX5VzFZYiqBOTjbxskBhtl3md2hqyUACKLC3Ycs0St5XSfGBaM+xGWtIGYvPyO/Y3oz
         m1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bfPxAABb1jDJ2Qsfc7iJcf6o4lAj7GKSnk+3Z0pbBag=;
        b=l3SoDDcyMWvvLTBxI30SgVxeqT9eofuQ45RDKyU8KhyLdLrhdsgM/d1/7r3guMtOrO
         qooTBfe5cviauEF1/Eg48AzT7LLVVF1XhLSlniZugzp84JOb3lw6cu3PziWbtSpqkbxb
         nMbBMah5SOmlBZw1c7XLOHpvuGV0wOQZum3cTUe26XVM3jtipOvPiwh5UztwdGQW4mc/
         eHrkiY++NiJgg8oq9P2j4hejsBiGuG/HEcIa1eEg5+zAsYmR/ny5BCpucYxbjVZHvJdC
         EfmTaFNU5+ByTePolgmlLi8Zsn1ZX22i2o4xvAMPcXuxlKfCc5JZxYjdz6z441JWcd3/
         phSw==
X-Gm-Message-State: ABuFfoi+GjgIB5wJL5fAb6j0IkmyAifz30JQ2dKPUU8jymQg18+g4KzP
        bd+Z7FwnH1gp0YkuOSOUc9U=
X-Google-Smtp-Source: ACcGV617gDeztmpy07CUUkfYimgYscBKieRM1rLip1b18NhqVlZ0eHMHL4KEaGiTHcDFQRx3vKo1cw==
X-Received: by 2002:a2e:50e:: with SMTP id 14-v6mr13217260ljf.152.1540155499872;
        Sun, 21 Oct 2018 13:58:19 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:19 -0700 (PDT)
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
Subject: [RFC PATCH v2 15/17] ARM: dts: tegra30: beaver: Setup voltage regulators for DVFS
Date:   Sun, 21 Oct 2018 23:54:59 +0300
Message-Id: <20181021205501.23943-16-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra30-beaver.dts | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index b0d40ac8ac6e..39941489d005 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -1806,8 +1806,11 @@
 
 				vddctrl_reg: vddctrl {
 					regulator-name = "vdd_cpu,vdd_sys";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
+					regulator-min-microvolt = <800000>;
+					regulator-max-microvolt = <1250000>;
+					regulator-coupled-with = <&core_vdd_reg>;
+					regulator-coupled-max-spread = <300000>;
+					regulator-max-step-microvolt = <100000>;
 					regulator-always-on;
 				};
 
@@ -1868,13 +1871,16 @@
 			};
 		};
 
-		tps62361@60 {
+		core_vdd_reg: tps62361@60 {
 			compatible = "ti,tps62361";
 			reg = <0x60>;
 
 			regulator-name = "tps62361-vout";
 			regulator-min-microvolt = <500000>;
 			regulator-max-microvolt = <1500000>;
+			regulator-coupled-with = <&vddctrl_reg>;
+			regulator-coupled-max-spread = <300000>;
+			regulator-max-step-microvolt = <100000>;
 			regulator-boot-on;
 			regulator-always-on;
 			ti,vsel0-state-high;
@@ -2114,4 +2120,11 @@
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

