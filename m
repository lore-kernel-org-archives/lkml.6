Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC44EECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B6920856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B6920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lineageos.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeGUNpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:45:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46502 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUNpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:45:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so228740pfn.13;
        Sat, 21 Jul 2018 05:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HOzds67PDgvO9bGnb5MaUNqXAmLVKCFqq0imjBCUCvM=;
        b=KqcsWRoqoIakZnrWblEwSjw7317GL4hGC3McRw/Oi5eRI+K8pi6RtANj1SyniXmgS4
         9rqd9OkGzNG8Z5Kr+dUbtHdJD5dvYcQ9w4UVHzv5Hh8V/AYX+Kh96WShIZS5ehxZHRdU
         VfAWG3+ubzRVcASkHWeKFfOi2vu0YgZRFOCtHJFKgdRltqUNV1TGeeDdSEMCh57MvD8U
         lJ+gyA/EUFbEbwZBPZsZKJnLsGXwmPTG1HuYM8aPs+CJ5hoJeQWzDztW5H39Lirn/eWW
         8gU8tmr1X3DZ3zb1+355t4/+CqV9+1XHwEkO/GjRYPDVqwDedeu9EJrNkZ1Q2fNUrseS
         BD2A==
X-Gm-Message-State: AOUpUlHLgWfrNmT9i3cGZHqtJf8vm3Z1monaA+wioELhQtEFdF27qT81
        qnoYzWg2tPhd3SG8woeF/A3folqUSlg=
X-Google-Smtp-Source: AAOMgpdaYVZ2tc+QtzAY1ZbEneiDoE39SHFfYrY+kJh65zo6pTWf8vCI9avfv5wqNabcs2lT1dEdFw==
X-Received: by 2002:a62:1b07:: with SMTP id b7-v6mr6018328pfb.70.1532177560603;
        Sat, 21 Jul 2018 05:52:40 -0700 (PDT)
Received: from forlindon.lan (27-32-42-49.static.tpgi.com.au. [27.32.42.49])
        by smtp.gmail.com with ESMTPSA id o72-v6sm6625945pfk.76.2018.07.21.05.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:52:39 -0700 (PDT)
From:   Simon Shields <simon@lineageos.org>
To:     linux-samsung-soc@vger.kernel.org
Cc:     Simon Shields <simon@lineageos.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ARM: dts: exynos: add pinctrl for midas fuelgauge irq pin
Date:   Sat, 21 Jul 2018 22:50:51 +1000
Message-Id: <20180721125128.31498-4-simon@lineageos.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721125128.31498-1-simon@lineageos.org>
References: <20180721125128.31498-1-simon@lineageos.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pin is externally pulled up, so we should disable the SoC's
pull down resistor in order for the interrupt to function properly.

Signed-off-by: Simon Shields <simon@lineageos.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 6f7b564905ab..6a6364a9debd 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -206,6 +206,8 @@
 			compatible = "maxim,max17047";
 			interrupt-parent = <&gpx2>;
 			interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&max77693_fuel_irq>;
 			reg = <0x36>;
 
 			maxim,over-heat-temp = <700>;
@@ -1138,6 +1140,11 @@
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
+	max77693_fuel_irq: max77693-fuel-irq {
+		samsung,pins = "gpx2-3";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	hdmi_hpd: hdmi-hpd {
 		samsung,pins = "gpx3-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
-- 
2.18.0

