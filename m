Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8FFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764A021547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsH/2Hnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764A021547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeI0U0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:26:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38050 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0U0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:26:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so2014031pfh.5;
        Thu, 27 Sep 2018 07:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c1F8GZeVe3Dvm5Q3L+hg9E5AyBz63OwEgf2hcnNqH5s=;
        b=SsH/2HnfYLftA7AVG2ZTQqV3swa86Gfz7yNsvxWa+ffxdZlA7aWs0kFHHEEWq93oCD
         M+i77QDzO1gu4CWwWNaawn27fY13idQLGhcpEr5QcGrtEmdUU0aqWjS9Ru8i4d2RK8dQ
         S34Uqo9zAoswdZdOtE8/Nn93MITsPZoLTihP2zIXOMXjpvHeftxqSUtJBCtTrKI+EZYM
         fvxvMy6+gVjl3ftNuLrkWiEivxRKMHe2NIctwr4ZHSELEUh9LKsPe2lA2vfDmkOnRLKc
         bKuSZAdnNns0W84xi4Hq03ytfn9OSPXqCQrMnMjVxJRTb9dqOw1WgjcVdJO+p29Fwbyp
         HeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c1F8GZeVe3Dvm5Q3L+hg9E5AyBz63OwEgf2hcnNqH5s=;
        b=K1cxzzC9/UL0+NuJ37dXauhHM6pL5G4QYBfK60G4DMbnNofCJ119XBP41pI6zwqBYw
         kr8s+/k1bLEnkM8dECmiVqe2+SZN9KkeTy29vF6cqWQzuwPvEOwSCVtav11zqYjv0QZP
         b1cmkDNLqieMoN7tOxxcRkQZAfdTA8chCQSa9DKLfz3EfFQiSF5HDnY98M1hx6cU63GC
         Y7CPgxTA4rqqVI0rT0EpuPiY93ZnbHdNC3ikIm1kPMuY7ceV9yKKru8h0RvJUfE489Wm
         TKTyu+TL/CRPIxznLgjzoxGm/BNYxMjC79JW/whlBCN8QjTQ6EZF5VX4VZB5djZYfL1p
         sy3A==
X-Gm-Message-State: ABuFfogUD+voJKIwn7vnkrJYgTVNXHoA2owHKkFlmAKmLd0YEXlQdRoG
        /MWC8rIVShgl+jje6UzKkBY=
X-Google-Smtp-Source: ACcGV60E8v1/+E54XDmohRQueADQ5Cim1gdow0wASDs3vPzs1AcVs9QTI0Qo1CPfhOE3koQvx+bFgw==
X-Received: by 2002:a63:4860:: with SMTP id x32-v6mr10507892pgk.375.1538057292156;
        Thu, 27 Sep 2018 07:08:12 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.185])
        by smtp.gmail.com with ESMTPSA id r205-v6sm4259763pgr.11.2018.09.27.07.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:08:11 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCHv5 4/6] ARM: dts: exynos: Add pin configuration for SD write protect on Odroid XU3/XU4
Date:   Thu, 27 Sep 2018 14:07:36 +0000
Message-Id: <20180927140738.1006-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927140738.1006-1-linux.amoon@gmail.com>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SD card write-protect pin configuration to be sure that it will be
properly pulled down to indicate write access.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes since v4:
1. Remove cd-gpios and wp-gpios leaving only WP pin configuration (after
   Marek Szyprowski feedback).
2. Pull pin down.
3. change the subject and commit message.
Sorry Krzysztof if I have copied your commit message to describe the
changes.
---
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi     | 7 +++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index dda8ca2d2324..b82af7c89654 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -289,6 +289,13 @@
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
+
+	sd2_wp: sd2-wp {
+		samsung,pins = "gpc4-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
+	};
 };
 
 &pinctrl_2 {
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index a80b6c045154..54811960e322 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -498,7 +498,7 @@
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_wp &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
 	cap-sd-highspeed;
 	max-frequency = <200000000>;
-- 
2.17.1

