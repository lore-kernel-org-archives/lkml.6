Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B493ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127B02082C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4gKYmYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127B02082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeJVFN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:13:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41538 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeJVFN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id u21-v6so35084253lja.8;
        Sun, 21 Oct 2018 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CudL+sqy6LcsG39kWf5I1sBXk5eo3KjjAKTeKlnP6Sc=;
        b=X4gKYmYSYAxTORwqZ5El88V8xslhxEKeGFTGQ+rZBeg/+7R4+kB21IWGzAhxGZgNHl
         aI9kp/jGNL+3w4UkK462JcBwOaL8pdXCr7n3BHHhOXFIu9x8SvM2HnDVLUOKs62sYGN2
         j11OO4sf5t2pjBCrvA4OfQaxsrFMqR/CGlUhWrpb1Vvz2IAnDfy4wuyJZVqT4p1U1D/D
         l4Go0Y2ZBavpSVZr+fbrbRR7v/TWa5kq6uMc/xgGjHc6drusn7n7rnv2XybUxowLpWIW
         rE0Oppnj5eqI4ahmIqZUp8knzw5fIQEea6CSUS9oj1QHL5smRl25D9xmfrJghrGAgwuS
         MhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CudL+sqy6LcsG39kWf5I1sBXk5eo3KjjAKTeKlnP6Sc=;
        b=EsXO6CNydWZFlxCljsHnX2/5jmoq0VWfTb8jrDimfnmnE8D41785t2tXvIjsQ7m0zv
         2tmcWKTztNc6Xl919lWzomu6pHD3QK3piLQCHBA4PEPm3yFpDMdHtn7UtDAchC8sL9dD
         9akeh5JIR1CnYRBcXfsHpThTEprfzY9e6VJJ22I34+Pr2E/O6vzj2k6Ybs8RWn52gLAy
         6ApvKbWJafL27rypZMH1kRNvwPdiLu5n8Zt8kTx0ZC6eK6PTwvBlTHHCWpV84JhtHXKi
         9fe7l9jB0BjDgf5HejU8V40PXDybuoZrjKopiBWPXlShtFHXmz4zuJvm0YFpHk1M19UA
         z/zQ==
X-Gm-Message-State: ABuFfoiCGU9cklM1fdOKqfQTsJ99lCf4mk+mLPBO2drRVfUPfXHBA5jA
        p/GWy0C0920+1T2/0V8axTc=
X-Google-Smtp-Source: ACcGV63tanBERBQyhVICl2eVygFKIOtkfovUzOqqiHlYUrty3Lzib1wDT3m6jYUy0amSTm0Z0Gbpyw==
X-Received: by 2002:a2e:7017:: with SMTP id l23-v6mr22937686ljc.160.1540155496742;
        Sun, 21 Oct 2018 13:58:16 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:16 -0700 (PDT)
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
Subject: [RFC PATCH v2 12/17] ARM: dts: tegra20: tamonten: Setup voltage regulators for DVFS
Date:   Sun, 21 Oct 2018 23:54:56 +0300
Message-Id: <20181021205501.23943-13-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra20-tamonten.dtsi | 31 ++++++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 20137fc578b1..e9db60f4c317 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -357,17 +357,19 @@
 					regulator-always-on;
 				};
 
-				sm0 {
+				core_vdd_reg: sm0 {
 					regulator-name = "vdd_sys_sm0,vdd_core";
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
 					regulator-name = "vdd_sys_sm1,vdd_cpu";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
+					regulator-min-microvolt = <750000>;
+					regulator-max-microvolt = <1125000>;
 					regulator-always-on;
 				};
 
@@ -391,10 +393,13 @@
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
@@ -531,4 +536,12 @@
 			enable-active-high;
 		};
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

