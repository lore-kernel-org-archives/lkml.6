Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E21C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5407C206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="X9mfjQGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbfAIN4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:56:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37472 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731016AbfAIN4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:56:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so7779945wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 05:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Awf98hG54rdI8pmMtli9QyfIsBrAW657JsBg39iVlpQ=;
        b=X9mfjQGCpSnWsLgevmhg8WeBo4mHoaeMOdfBLve8+GI4McnbVb/+0rPCv+rjsilFdZ
         89MhFbqdaFwhICQ0x82U1YsMS3RWiGg6J7mxMvP1DaEip4/mrEbgW5xFpuY2od1QwyGk
         Kh5uj7LHHUkgWb+Y+EyROZoqqkTsbtQYE6DfG/e3Ovdwyq0vLAnFIyc4pJTlFcItQBl5
         qOpkGAHoaObsJDAR4IJeWu0OLlOm8EENPPAzd7tm5m9kLjEMlSosHPcUJdCfpYubK2OC
         PGMm/dhKKlv9642KVCfU4KC/fS4T53CEBavOK5xt2kJD5AhoWRuIoSpPt03XXvjM1e8K
         Z+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Awf98hG54rdI8pmMtli9QyfIsBrAW657JsBg39iVlpQ=;
        b=Ij6gkxpq0QZuYZa1kKK+NGKMApenwgy/fNIJ7ISLlZTOPpQzGOwxJOSs1KGgDDarSd
         Jlhv0FRVcKCNXo0SaI1V01QShFagefPw43PJCSrWVrXb6p+yCt50F8GbkJ3uHpUzPZk4
         LE4Bj1EDek7Uibb+186NQ7BsYkYHDbhLhPNEMWxpWvaX9xt/EOo951bqHdcS+tWlvvdu
         p7mqEGqJtDpLtWmv45Fe16v8QJT5yTpheiaq+sqY2OrOvYz8oTP0gDe0pddlkBXhJq9l
         JfrgGi1F9htOz4buhEjyIEIBqBf5beP5q3PezvoUZM5/V/KrAHz/vqRabztXyxNn7UV4
         qcsw==
X-Gm-Message-State: AJcUukfFScUtQNN71bpJo7ZjPfwNspsR6hVigXOsKW5Clahy29ci/Pbr
        9mfy4qVVTnfsqZl5DgU2h484gA==
X-Google-Smtp-Source: ALg8bN57LaRohlkCyOeHcsDmmkTRBoqT8EG8lyBnzHAxA7e/FcA46+A0VxZ6T0wx6nhoYvFoV791Mg==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr4994557wru.33.1547042202742;
        Wed, 09 Jan 2019 05:56:42 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c13sm59601671wrb.38.2019.01.09.05.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Jan 2019 05:56:41 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2] arm64: dts: meson: Fix mmc cd-gpio polarity
Date:   Wed,  9 Jan 2019 14:56:38 +0100
Message-Id: <1547042198-17601-1-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
changed the behavior of "cd-inverted" to follow the device tree bindings
specification.
Lines specifying "cd-inverted" are now "acitve high".

Fix the SD card for meson by setting the cd-gpio as "active low" according
to the boards specifications.

Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v2: fix more occurences, also in other meson boards.

 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi            | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts           | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts         | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts            | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi               | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi           | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi              | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts   | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi          | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts          | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts            | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts             | 3 +--
 14 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index e14e0ce7e89f..016641a41694 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -187,8 +187,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 8cd50b75171d..ade2ee09ae96 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -305,8 +305,7 @@
 	max-frequency = <200000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddio_ao3v3>;
 	vqmmc-supply = <&vddio_tf>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 4cf7f6e80c6a..25105ac96d55 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -238,8 +238,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 2e1cd5e3a246..1cc9dc68ef00 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -258,8 +258,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&tflash_vdd>;
 	vqmmc-supply = <&tf_io>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index ce862266b9aa..0be0f2a5d2fe 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -196,8 +196,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 93a4acf2c46c..ad4d50bd9d77 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -154,8 +154,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vcc_3v3>;
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index ec09bb5792b7..2d2db783c44c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -211,8 +211,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vcc_3v3>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
index f1c410e2da2b..796baea7a0bf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
@@ -131,8 +131,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index db293440e4ca..255cede7b447 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -238,8 +238,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vcc_3v3>;
 	vqmmc-supply = <&vcc_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index 6739697be1de..9cbdb85fb591 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -183,8 +183,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_card>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index a1b31013ab6e..bc811a2faf42 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -137,8 +137,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 3c3a667a8df8..3f086ed7de05 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -356,8 +356,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index f7a1cffab4a8..8acfd40090d2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -147,8 +147,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index 7212dc4531e4..7fa20a8ede17 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -170,8 +170,7 @@
 	max-frequency = <100000000>;
 	disable-wp;
 
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
-- 
2.7.4

