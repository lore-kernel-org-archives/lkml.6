Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A02BECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518B12154F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQGAIPay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518B12154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeIVNpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 09:45:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45143 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVNpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 09:45:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id j8-v6so6925835pll.12;
        Sat, 22 Sep 2018 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7/9fBhU1cSz/dzE9di8oht9D/bY7/abEoKUW8gmMZRY=;
        b=SQGAIPaynapX4EfIVvmiF0RJ/5vbVF8mO4YLL+TY6tHO/NPdJPzAabhCAHf/qtMDQz
         76eXV1ca2qcHQNK6Y5zsxcvZRQUYkG4Rtvmb1FQ/4QshMd/x8BmGNdlDaOERfmFERxTK
         1fBuNRbrc7RmZ4ZhnFpxU7eQpMV/+GIB32Hrznyd8/SFY1k5o9411vKV7ze53Hi5aFpX
         bxh9nK58p+SqCVM2v0DVKIXzuO5Yn/jwRVvVv0teomHHbzbckGoHatMr1zZ3Ayt/Y0gC
         n2sKrc33ZOFsAtJP9gsJS8vmddYTh/vIsrgQB2+79BQEMzt16aE1bpYiNgAYSbijPIjD
         bPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7/9fBhU1cSz/dzE9di8oht9D/bY7/abEoKUW8gmMZRY=;
        b=VJN54Z1YrLDxWiF/aCdTTYC2lKvza/QTxwIR95IzEqguyXmBoz7G22ljDmAB5ns+GJ
         yCrJ4FY4z+gVVrwkxE26f8F9m6h4fcnGQI+nRmQFKvQQUCdNabHLh3ym8TTpNj3txVt1
         nNOExAcOI6s+QfXeRWTfJ27N5yRpDz4KRb2d11+B9XaqYZgYGwPNogt7Jjzc0soANFDx
         5CoDwyq9Mm9yq87gBCZ4f0npcXLzNcyhqJaEeTP0IJcLcupabKy7pXu9SFzVFRbU1zzg
         jZZtaUt+u3XZ1Nm0XEuYhAirWz/r5at4G5l9oB3q7T0myfwPDIYM5tNfQN2hBz0jD6qd
         Uqlw==
X-Gm-Message-State: ABuFfogtF1s2CAV0kwGBkj3meLwKy4EmrwhUdOfVHKJeMVa2lBen3S/S
        XyATU+CT83C9bHB5JRuU6Gw=
X-Google-Smtp-Source: ACcGV62FWCB3ZxSVEPEQTb2ZUQyz/O4FlG89hEcgDbVT8dEw934q3rL4Dk5TB7nfnxvHzYk9tcMkrA==
X-Received: by 2002:a17:902:42e2:: with SMTP id h89-v6mr1434204pld.69.1537602794734;
        Sat, 22 Sep 2018 00:53:14 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.116])
        by smtp.gmail.com with ESMTPSA id f67-v6sm53219253pff.29.2018.09.22.00.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 00:53:14 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCHv4 4/6] ARM: dts: exynos: Add CD and WP pins to Odroid XU3/XU4 SD card
Date:   Sat, 22 Sep 2018 07:52:36 +0000
Message-Id: <20180922075238.884-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180922075238.884-1-linux.amoon@gmail.com>
References: <20180922075238.884-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the card-detect and write-protect GPIO pins for OdroidXU3/XU4
SD card by adding pinctrl setting for wp-gpio pin and set it to
active low.

This also removes debug messages:
    dwmmc_exynos 12220000.mmc: No GPIO consumer cd found
    dwmmc_exynos 12220000.mmc: No GPIO consumer wp found

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Fix the commit message and squash it with cd-gpios and wp-gpio
patches into single patch as suggested by Krzysztof.
---
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi     | 8 ++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index dda8ca2d2324..9a39a0d8ec86 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -289,6 +289,14 @@
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
+
+	sd2_wp: sd2-wp {
+		samsung,pins = "gpc4-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		/* Pin is floating so pull it up to disable write-protect */
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
+	};
 };
 
 &pinctrl_2 {
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index a80b6c045154..2aacfb669140 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -498,10 +498,12 @@
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_wp &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
 	cap-sd-highspeed;
 	max-frequency = <200000000>;
+	cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpc4 0 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&ldo19_reg>;
 	vqmmc-supply = <&ldo13_reg>;
 	sd-uhs-sdr50;
-- 
2.17.1

