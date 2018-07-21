Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADE3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F30A20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F30A20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lineageos.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeGUNpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:45:38 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43181 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbeGUNpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:45:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id o7-v6so6326147plk.10;
        Sat, 21 Jul 2018 05:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mTRMG3e8cpur4/bVkde+umdpGfZDcp0Xb3shjDFnD00=;
        b=LQkWGvrA//Bgypg5jv/d+qW+DTDZmqcalFlurLGhCdPzoWl/TLDVBrYTBYNCKfGVyo
         F1MYFalyWcd01395liuZQ/HCxFWArliZdeNFk2aIcelk0aMbjOa43cfdEgnWpzgu5SMd
         2Umwy5nDWR1ZeDltnvoLqels002pzMIfQPaDifVG/j3Ljc0vG9eNakhGSO9NmxqBdm49
         TAlVBIS8LygpmTXq/54xUdxMPfD1Y+5QyXAVa/BzJF9MjEicDLbd5fCoxXtp+/7wJgna
         mxetLgbv1OrwGwWfIf/KLGScNbH1rEpda0kyeYyKe8mNgUUFcV2j1KzYqdDwsPAQGpGO
         Lcng==
X-Gm-Message-State: AOUpUlFMd+yfFJVD14nYTIoIZxq8T2eyz7B4Xah95M4msHfw00EscBxE
        3H+ks+R7O/Yofz/CC7HeT6QGUGE1lKs=
X-Google-Smtp-Source: AAOMgpeE2Ngj3aENHG6sr87G5wrSYGriveVMVaJpP328bvVPItVwkpQ3NLWqb4WkE3ROIzbQGECYnA==
X-Received: by 2002:a17:902:8215:: with SMTP id x21-v6mr5727580pln.175.1532177578938;
        Sat, 21 Jul 2018 05:52:58 -0700 (PDT)
Received: from forlindon.lan (27-32-42-49.static.tpgi.com.au. [27.32.42.49])
        by smtp.gmail.com with ESMTPSA id o72-v6sm6625945pfk.76.2018.07.21.05.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:52:57 -0700 (PDT)
From:   Simon Shields <simon@lineageos.org>
To:     linux-samsung-soc@vger.kernel.org
Cc:     Simon Shields <simon@lineageos.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ARM: dts: exynos: configure midas SD card CD pin
Date:   Sat, 21 Jul 2018 22:50:53 +1000
Message-Id: <20180721125128.31498-6-simon@lineageos.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721125128.31498-1-simon@lineageos.org>
References: <20180721125128.31498-1-simon@lineageos.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pin is externally pulled up, so we need to disable the SoC's
internal pull down resistor to allow it to function properly.

Signed-off-by: Simon Shields <simon@lineageos.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index d69bc3c2d0ff..3d3e6b74c12e 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -1152,6 +1152,11 @@
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
+	sdhci2_cd: sdhci2-cd-irq {
+		samsung,pins = "gpx3-4";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	hdmi_hpd: hdmi-hpd {
 		samsung,pins = "gpx3-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
@@ -1383,7 +1388,7 @@
 	bus-width = <4>;
 	cd-gpios = <&gpx3 4 GPIO_ACTIVE_HIGH>;
 	cd-inverted;
-	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sdhci2_cd>;
 	pinctrl-names = "default";
 	vmmc-supply = <&ldo21_reg>;
 	status = "okay";
-- 
2.18.0

