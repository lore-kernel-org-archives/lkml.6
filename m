Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13ABECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C2C2082C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ6J03W7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C2C2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeJVFOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:14:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35677 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbeJVFNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id o14-v6so35129790ljj.2;
        Sun, 21 Oct 2018 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fmGkAu4XHZNOq56DlvZJAZH2wGLRNDClSYlgkU+I3vs=;
        b=cJ6J03W7VcdH2AT2dD3h7QavYUFpBTwp35ZL9Ech6FWutxSCh/sWNi/KyFubYGVQ7y
         YIzSxDAK/e8a08f+ECQkwyMHUpkZMV+UsJSm5Cvg0/yqrJhIzoC+tNr35WfqjvpbxAOc
         L88rSIBdqwzNun7IhUvBLLzm5h1fIY0+5/kh1qPYGw7Lh1a/KPtykQhDTk63l/huonx9
         N7ldTMyTljBWjMC5SphoaKSJH9q0It/V5RuTmokR9ItXWOApjGMJHUZFAa80c231yb/K
         6btp9w4wxxGJXcvh7v+YgHHByq6tC1drjJXgq1/DnDZmsqUCbjEqiVFBGkancQ7tVf1w
         x7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fmGkAu4XHZNOq56DlvZJAZH2wGLRNDClSYlgkU+I3vs=;
        b=EDM2xKpXoheDv3gW9ZKqs0zyZR7bBicRaidxYrrKGh6AAlGEog42axKxtQPa7p+pRb
         owvxwk1FpxheQWc7rP2XWnNl5gKSuLHjAVN2MxjQC5NSzRafn0Wv54zVm7/sQYstug2D
         IzCcZ+/ARP5m4IalDb1YHLFivQo+4X9MK2bn3dk55I/IYj6QOUWIsbI+5E9T/Akiyl+1
         YPK/Tu87CY79d4dnmJyq6+7LyxkJbXpbQVxx3Gi0CgZXTvZESM75Yxr1ZSWWb2rsnFIG
         G3adawNEwPzQnpudYR+hERXMCtvArS/rbG9RuxKYdM5Pr8HSGIQwEG7KC08L8SVIUhsW
         casw==
X-Gm-Message-State: AGRZ1gKWDkl7aTqGotGOIK5guVJC07Jmpeh39iSzMg7VRMGD0CnvwcwH
        S0VdFalnjhb91//yi7xyMC4=
X-Google-Smtp-Source: ACcGV639oMkaHMpChbwibtF+UeUvYVZGh5z5uDQsjzfp4+Sj9QWMCSI9KBi1RR/k+b3pOYyey/jsHg==
X-Received: by 2002:a2e:1642:: with SMTP id 2-v6mr9360327ljw.56.1540155494568;
        Sun, 21 Oct 2018 13:58:14 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:14 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/17] ARM: dts: tegra20: paz00: Setup voltage regulators for DVFS
Date:   Sun, 21 Oct 2018 23:54:54 +0300
Message-Id: <20181021205501.23943-11-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra20-paz00.dts | 31 ++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 8861e0976e37..51a09ae99f3a 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -337,17 +337,19 @@
 					regulator-always-on;
 				};
 
-				sm0 {
+				core_vdd_reg: sm0 {
 					regulator-name = "+1.2vs_sm0,vdd_core";
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
 					regulator-name = "+1.0vs_sm1,vdd_cpu";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
+					regulator-min-microvolt = <750000>;
+					regulator-max-microvolt = <1125000>;
 					regulator-always-on;
 				};
 
@@ -367,10 +369,13 @@
 					regulator-always-on;
 				};
 
-				ldo2 {
+				rtc_vdd_reg: ldo2 {
 					regulator-name = "+1.2vs_ldo2,vdd_rtc";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
+					regulator-min-microvolt = <950000>;
+					regulator-max-microvolt = <1300000>;
+					regulator-coupled-with = <&core_vdd_reg>;
+					regulator-coupled-max-spread = <150000>;
+					regulator-always-on;
 				};
 
 				ldo3 {
@@ -603,4 +608,12 @@
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

