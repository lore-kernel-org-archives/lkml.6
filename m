Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4475ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B05208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ob/Gz964"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B05208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbeGMMJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:09:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33375 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeGMMJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:09:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so4346882wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=jsAPxDrKmDni+9ip5t209bPE6nwgW1vjStnIwuNytC4=;
        b=ob/Gz964DMVBW1liD+vFCAwDL+w+x/wbcvF5gL9tfb+gF9m4QREMuxsM0FSITD/ekX
         /LOP0wmU+LhxsYMl/eRjW+kpJHH6BiNMOBHlGXiGWjihWdBiUSgRgjHjBtiqaiZ8sRzq
         jZY7lRckJ8xqeUEsjW8TaGiNOU4AbWvOHUv50RKtUDpakyWrzoT63ieORchcWqXWSUXg
         5/rZGOgnTbPGIBk8cHeJbyihZE55cYHZCRfPcJWbA6Ju7hJoPU70XRun6ukquVlekiP2
         Evc8IyXjMY02e2ccQVRnBNOdFu7BjtWVbadOIA+nxrcUWUSlOcyExdgFuL+nbZ/Pgt/g
         jraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jsAPxDrKmDni+9ip5t209bPE6nwgW1vjStnIwuNytC4=;
        b=oYLjpzz6oaSQ2IaXra846fkrkejHFDTy0N9EL0aS1SYiBbouVcPua17rUrFHpDjhQn
         jiGy3E8cd+ghkNMiGJEUVdqnai3+jck6GTKDcxj6DSUcsl3EgmIhx6Sze0rPlB/R2UyL
         HKBIx2neb+rZgeAoBE939B2ttruMvovQus13I+vcfiKQP4KoC6C3h3qY9uT4IUQoNM7V
         R9bkSP0NkS1KLvw0bNRw4yZSml+RKF8hog9HlRmBYnkHkCbw3V7Ewy4zJktuaF33vuZV
         IoaIZZt/VwYbKv6033d1C2A2jzDGpllkn8cEOR0EFHhy1nwo9bygefVgjQa2qZ+HaMoE
         Vv6A==
X-Gm-Message-State: AOUpUlFwazvDVdR2GDjRQFEAH7rbtbdm5fSnkzGbPAkAYh3hmUWI62vi
        yo0JyQCTT7R4gKHhVVevJ1aVSw==
X-Google-Smtp-Source: AAOMgpc1S3v3Rr1W05BsB5gGUMqNwRT6chmlM6mIYOmMXGx4ts//pIXKr4s0NeVb+dp/IyMHYw7GYg==
X-Received: by 2002:a1c:d6cf:: with SMTP id n198-v6mr3948632wmg.61.1531482891180;
        Fri, 13 Jul 2018 04:54:51 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id u185-v6sm904756wmg.25.2018.07.13.04.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 04:54:50 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-axg: add adc buttons the S400
Date:   Fri, 13 Jul 2018 13:54:47 +0200
Message-Id: <20180713115447.2868-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 6 adc buttons of the amlogic S400

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index f389f84be2e2..fd90fa4a282c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -6,11 +6,55 @@
 /dts-v1/;
 
 #include "meson-axg.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	compatible = "amlogic,s400", "amlogic,a113d", "amlogic,meson-axg";
 	model = "Amlogic Meson AXG S400 Development Board";
 
+	adc_keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+
+		button-next {
+			label = "Next";
+			linux,code = <KEY_NEXT>;
+			press-threshold-microvolt = <1116000>; /* 62% */
+		};
+
+		button-prev {
+			label = "Previous";
+			linux,code = <KEY_PREVIOUS>;
+			press-threshold-microvolt = <900000>; /* 50% */
+		};
+
+		button-wifi {
+			label = "Wifi";
+			linux,code = <KEY_WLAN>;
+			press-threshold-microvolt = <684000>; /* 38% */
+		};
+
+		button-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			press-threshold-microvolt = <468000>; /* 26% */
+		};
+
+		button-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			press-threshold-microvolt = <252000>; /* 14% */
+		};
+
+		button-voice {
+			label = "Voice";
+			linux,code = <KEY_VOICECOMMAND>;
+			press-threshold-microvolt = <0>; /* 0% */
+		};
+	};
+
 	aliases {
 		serial0 = &uart_AO;
 		serial1 = &uart_A;
-- 
2.14.4

