Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC65AECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B5C2082C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWKltCBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B5C2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeJVFOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:14:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36132 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbeJVFOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:14:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id l1-v6so9019994lfc.3;
        Sun, 21 Oct 2018 13:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kLoLfunpsOiImN7+1Ii2rXCFU/3rlLKOsyCDj2PWwm8=;
        b=dWKltCBGLkEuudqS5ANR2CITe6jmsLugzJ0x2UuWc3xbXkndi7JyZRqCU10kPw9KJv
         usnB0a0zBoSGtFq2uJjTHsWpzDOqZFgWXGycgi8Di84tXIaLlCuCIfCTilogOMsIBvNt
         Fdvry2PEUBhSECYWWk+pUFkZHtc6mYVfnOx4+M/q81RxkeYEQzY4djFqUnGNo2RiA9pH
         OkDU4VgyENEU5rK5jKXGOf9SDWLyKhjv+hE+BM5oqe5LvMB9nzQEOIg6fzKFq0UtZQ6Z
         vHJPTDiYhb/CNi7ejQHYJQK4PY4uR7iXRvpRo/AsHnGML7RV3sqgIzbnY+w2ppHWp9dm
         whWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kLoLfunpsOiImN7+1Ii2rXCFU/3rlLKOsyCDj2PWwm8=;
        b=fStFdEA3ysJSqHZeXvJAnUAJVwCgzpTGSAB4cUmCI3Tdi6Wxi9qSqXPVRBTTJLcUN+
         DTCRR8XRCb+YeNCraJqoSWf5hHA442fnSA6AFNgeL9cef/0OPn4MGFHR3Gl63yeiy0EK
         H53ItyvaSygenJvzErtT04mlQv1x4i7hX+z9mrk8kvPPjgMMq22H8KwmzKiuVbeB2td2
         s+IxeVrBhxrkrQ+paflXygDXjo2RCh0SVr5fGpxawwjdfbNiu2V+m+mFtic70WZjzA0A
         ZqGzeg8vXL1ftRnEjxo1+6PLkuEH1227+EOKjOaHrxHwEEFSQ/P4zOUwmHUT7qjUYJvt
         mxpw==
X-Gm-Message-State: ABuFfogY5laubHICgMAdPYyd9RWJxFzpKTgUVqXxOJQWaN50b/7CnNqE
        6lgSPibWKmha0TWVeAwyWsE=
X-Google-Smtp-Source: ACcGV625xOxSNSRRK1ANM3OHEY3c6Q/90Z/n1G2JL8oAg6fHMdKtE6ue7hMk6lFlmlcDrk4dY2S6HQ==
X-Received: by 2002:a19:274b:: with SMTP id n72-v6mr7433059lfn.153.1540155501931;
        Sun, 21 Oct 2018 13:58:21 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:21 -0700 (PDT)
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
Subject: [RFC PATCH v2 17/17] ARM: dts: tegra30: colibri: Setup voltage regulators for DVFS
Date:   Sun, 21 Oct 2018 23:55:01 +0300
Message-Id: <20181021205501.23943-18-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra30-colibri.dtsi | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 35af03ca9e90..c59099c1e2c3 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -763,8 +763,11 @@
 
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
 
@@ -882,13 +885,16 @@
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
@@ -1027,6 +1033,13 @@
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
 
 &gpio {
-- 
2.19.0

