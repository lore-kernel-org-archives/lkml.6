Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDE7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA8D214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sC/UuYdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfAJPkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:40:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38450 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbfAJPka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:40:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so11894615wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 07:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=V9rCXdwFQ912EEViaZFliq7MrgmbybjfHv7F+8qyBT8=;
        b=sC/UuYdZFJJDxNYpYHZqKnaJ1OhTmrlu5RUodLU9wXttl96CuBI3zHhPqPs+81sTn+
         5TxD139hdOGc/ZTmvTweF6yUhBHX2rsWDGRmPVsehxkt5O9IqWfB5HKSmmv0ppKb+/1R
         qW/yU/dEuxEKspPf4PXd/3x99ZFp4c9y/SNvffTKmBfPZGFvMW4Xqwqu/FOrDrUSVpTy
         4698sP8nU5iaZ27OkO216ltszQqVA19NlexLLAnoWbv29krZv3nCwGgxhsnD42mnnIzX
         Flq+aPtI1k9ai81QqhRlensAaNM62kbEVyxzaf9CuCX+Lf1ImBeoT+S0QlDvC0l1T0mj
         9gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V9rCXdwFQ912EEViaZFliq7MrgmbybjfHv7F+8qyBT8=;
        b=sul+ujUbkYh7/fOH0fBbxGfkRUMvykVCBYTKlEP9KVmTnhnUxFZyWJlWJWEO9k/5v0
         +xnipt1WWMq/M2062YS+yrUJAHq6umojsXy6QMA1n9qlyvjFGv7eBo6W6rU08KaKMgcm
         n5MiH7qMm/VNnZ4rYyUbBS3sOH5Il0FoQ0oyDdWxXC0ziSsU95mRg255IuxglvcnLGii
         NjpxfsEaOXETCjP2A2eGE5vQ5L5lv3QQyPQCU5K5R/zuOnGe4wboftClQS/Y5h7Jqzzi
         4QkPS579c3ycoxfFGNIcKKasS3TaVkKrpLprVIvknnaWrffLM+ThtPaSKp0P0lXT+NMq
         9NPQ==
X-Gm-Message-State: AJcUukfZfqXjUmEBPvLVngWWrboe6+JJJvvVaL10nZjsS9cY2eM8CroY
        raDW0Y0lASChLjnluk3jKp6RfA==
X-Google-Smtp-Source: ALg8bN5gwy6guv6OLbftNleV1OlHsgTK9ZVUvYMAIsf6u3WqifYpeSYuir6Ufn0+IbXX5ctDS4UJxQ==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr10183906wrw.304.1547134828319;
        Thu, 10 Jan 2019 07:40:28 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com ([2620:10d:c092:180::1:f5ef])
        by smtp.googlemail.com with ESMTPSA id h131sm22694198wmd.17.2019.01.10.07.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 07:40:27 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3] arm64: dts: meson: Fix mmc cd-gpios polarity
Date:   Thu, 10 Jan 2019 16:40:22 +0100
Message-Id: <1547134822-18498-1-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
changed the behavior of "cd-inverted" to follow the device tree bindings
specification.
Lines specifying "cd-inverted" are now "active high".

Fix the SD card for meson by setting the cd-gpios as "active low" according
to the boards specifications.

Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v3: fix typos in the commit message

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

