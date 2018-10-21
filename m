Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14229ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA762086E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvfzulwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA762086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeJVFN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:13:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34600 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbeJVFNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id n26-v6so10114619lfl.1;
        Sun, 21 Oct 2018 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VV4rw/xYMg2pa62uyvB1i95nBFrBi4ce9oWUqNOKKUU=;
        b=KvfzulwXHavT5aTRXatTkyfZAO+pGdMBHMw6eDjismX26LIE1rhBdCaWGbjHJUDU5K
         ZrUH/pe1kZiK9VAyHCT13dO30El7UA5TYGEW5KF5eyRUNW2Q4/5JB/33oUYZwpfKm6X9
         MB1fpFQ4bRibnjwgWTNo9iLUUbABUVPGcxbSxvDGaXOXoTJvdThD/sWd020QhPUTOaBb
         lT5xxuMMkkXZ/fTRZv0OJM+ZrjJw336o5NC7E4VbD3p84etRensu2a/gS3fVhTPrElwQ
         On5IY1FQ/ywWZgqc4NXcHDlwWftIIBkbUBmVVKXIaNYFJgVhoNzh7S8Y5Cf//JukXRvP
         8X3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VV4rw/xYMg2pa62uyvB1i95nBFrBi4ce9oWUqNOKKUU=;
        b=Kf7+Q3uTkzhOxpB/yDsoedvgEFuiWlrw9qgyVR97c8NQyJaiM/CIvPbNppJh5QQYOw
         OYTw4ZXypNLzlOUbcsMR+BYqqPe2E55HKklYWYmnB6ibv2ZPpmtEuZJAkV8LEjvXbJ1K
         3QJZhrzeH6eH8mnwUCY0nwfG6MGVo1A6F5z0whLnljRfDg+M/1V0LxNUir7zJLPHbwfL
         IK91WjokiN055Qq2cSLNKNJLbVlF5ltv2j86iknlRL9geOygou33NRVf0ChNml2qU7KG
         mXiK5XQ+3N5Y7bujAuyY0ezmm2GnYulG3JFy8JZDhnDCj95xRbZ0np8bEH9eSG9lDUQX
         tGjg==
X-Gm-Message-State: ABuFfog8Tbb3CjIwDuFGz6dqVOW96iaBc+peTM44C7auO0zlYuXZ0Pyc
        T7hM/22/ghKdFyHQ7QVFmmY=
X-Google-Smtp-Source: ACcGV63oZKQhMq6L4ecaR+Natn6WjQNsB+L530XB48yYXu+DGQPKcG+GS70G57alH8HZjuRjAWO+IA==
X-Received: by 2002:a19:ae11:: with SMTP id f17-v6mr8340920lfc.86.1540155495716;
        Sun, 21 Oct 2018 13:58:15 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:15 -0700 (PDT)
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
Subject: [RFC PATCH v2 11/17] ARM: dts: tegra20: seaboard: Setup voltage regulators for DVFS
Date:   Sun, 21 Oct 2018 23:54:55 +0300
Message-Id: <20181021205501.23943-12-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra20-seaboard.dts | 27 +++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index f91441683aad..85bf7e89ebbe 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -444,16 +444,18 @@
 					regulator-always-on;
 				};
 
-				sm0 {
+				core_vdd_reg: sm0 {
 					regulator-name = "vdd_sm0,vdd_core";
-					regulator-min-microvolt = <1300000>;
+					regulator-min-microvolt = <1000000>;
 					regulator-max-microvolt = <1300000>;
+					regulator-coupled-with = <&rtc_vdd_reg>;
+					regulator-coupled-max-spread = <150000>;
 					regulator-always-on;
 				};
 
-				sm1 {
+				cpu_vdd_reg: sm1 {
 					regulator-name = "vdd_sm1,vdd_cpu";
-					regulator-min-microvolt = <1125000>;
+					regulator-min-microvolt = <750000>;
 					regulator-max-microvolt = <1125000>;
 					regulator-always-on;
 				};
@@ -474,10 +476,13 @@
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
@@ -938,4 +943,12 @@
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

