Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FC1ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9352083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPXlXion"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9352083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeJVFOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:14:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34603 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbeJVFOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:14:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id n26-v6so10114682lfl.1;
        Sun, 21 Oct 2018 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tOE86fX1OZR0BOmROk+U9leFQPqWVeFiGsncXg6ozE=;
        b=aPXlXionNPzTk6cCxVe2cWd6m4h+8p09fWzVARc9jDstvYvp1QNp58uvdmdMg8lhIx
         lNK9+3Df7ObXngqjPRG1pzhuEqk5iHG7fGp9IGjkyHQt28ep4FnowdIaXzyM6Nvpz62S
         k0jX6nSHzFiVF3+idJxDf0yCnh/lIZtSzYfj4A9BjLKhsgph/XJwJjIdCFEyBcTvsnmu
         ASHYhaD+NuCF4QYzXdM5EezNEAS3YfLVf9IV1K1p8uVSEsldpCIHeltV5j+0MQ9sCH2u
         SJh4eWD4s93NfGlHnrzFookzbrGgXxUlw3LPQWLiyTy+iRHrhmiZzKA5t7yST206dQmf
         rcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tOE86fX1OZR0BOmROk+U9leFQPqWVeFiGsncXg6ozE=;
        b=Ajnbgieb04ZYxNSNlpSlctZXE2TmNS1mMAROLpfDtz5tS/+eve6U4yPb1lPNSrrlqG
         qVTY250QLoYCtDUMRxVRZBAwYMpwSXY5rrKv8nQ2Qu2hob5ynsjFk0Woz7aHtWxzKK1O
         WQJXxU0In37i/RwPk72lvEBUakm8110gikDuuB7NVVBkJ22YIlbMFR9ED3XxvK4mIjPF
         PpYAKXh0KS8mQE8HIBow57oOKlRGXv2Lwr1Dpg5tLl2wdjwpk8cgOh7S7jRJZFpii5gV
         NJIvnU0RTNziAKgbzLeKvvawMbH7VmM8eKEXKJAr3ohHY9TYIJVWrvyQ1yRDL8Q4QFHW
         CO3A==
X-Gm-Message-State: ABuFfoifAHPmTqBjQdlY70293quwW87laCkMNXBueRwWxvzs52UXZ0rh
        lSDO2c1tOHfG98xgfJ5wwWD0KqsI
X-Google-Smtp-Source: ACcGV63q+YtjgaYu2LMgtbLsXqiSy7zJQ4rseMS6iMdp3vJJdAcvLxcuEkxWcF27T6KMXeo7wUJ6aw==
X-Received: by 2002:a19:8d11:: with SMTP id p17-v6mr7280174lfd.116.1540155500915;
        Sun, 21 Oct 2018 13:58:20 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:20 -0700 (PDT)
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
Subject: [RFC PATCH v2 16/17] ARM: dts: tegra30: cardhu: Setup voltage regulators for DVFS
Date:   Sun, 21 Oct 2018 23:55:00 +0300
Message-Id: <20181021205501.23943-17-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra30-cardhu.dtsi | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index fb9222b479d2..5fcf5ac09530 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -272,8 +272,11 @@
 
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
 
@@ -342,13 +345,16 @@
 			interrupts = <TEGRA_GPIO(CC, 2) IRQ_TYPE_LEVEL_LOW>;
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
@@ -649,4 +655,11 @@
 			debounce-interval = <10>;
 		};
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

