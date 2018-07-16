Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A10ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02637208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="l/nqQ5zS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02637208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbeGPKik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:38:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46246 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731479AbeGPKij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:38:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id s11-v6so31259662wra.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jsAPxDrKmDni+9ip5t209bPE6nwgW1vjStnIwuNytC4=;
        b=l/nqQ5zSR95a4wF5kc4HB3HM9h5LVTCQpz12iVgWIGNLqQeNtyjJu0+rQI7sOOxtVa
         KyJMzooYjs+nxv1K+JVBNr6ANFhyrPdz8ej0wZo7YK5XsMGZ/kYo/z+ZzHsWXMvh5pBj
         rR7gePXwJjIH1xsgaW54efZ7H10WnAvshSYwjWsYQplriD2Cfd8HYLe9yx12S1eqHJ4J
         an3b3r9vSzCMPBHWdAKX0QydhilYwanZFgcTMjf2J5Oe2bCC588po/wgR2MziHIowtMb
         bNeIKSDxuL37CLWEPwdyxD58tR+qo7Wvm9NqwKd11sR4VspuTvydfFFXF1CMPGtxPnrt
         GK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jsAPxDrKmDni+9ip5t209bPE6nwgW1vjStnIwuNytC4=;
        b=WxtxAKiDMpWc6+t1i+GmwU0OyGaLijdd8EOdSZmyCh3cs1wXMphekp2a0j0DltNXSS
         XNp7rN7VQCq9ikGHMZKRjdYmhrE3I02G8r5VVqOsm/rMA5mti/o3UctTnOpprgj9fcsZ
         ZXZWdjUM2egKtOE99r0lSFCgGjwiLYg+VKuKDU9BBAyVR1091YLo1BzsBF1Hy8ORxop4
         0JJRXVqJVjOtfuEWbEgBU5EjKx/HiL9ybopVYBsRa/YcMhTGOp5CzvZ48yM9kYwCFDA6
         f8vr7SPSzmzohfcalIYqDjDfEml2htv7j2wKa0I30/q9QQ1KqsBs2Q+6ToLMHa6mk8oM
         V5JA==
X-Gm-Message-State: AOUpUlGbymYZwU65KV1Dyyz4K0005Fp2n2VkF+YuW+iOagsrX3AZR+dU
        7JVVdk11Ip64Q/+ig30dgvhHZnY2
X-Google-Smtp-Source: AAOMgpfHckAkHyWL79jz03q9gnV7Q/zNWBzUCb4j8+KTo/E4ZMoky9/QWM4U1bWZUJIFsGvMoQWdkQ==
X-Received: by 2002:adf:dfcd:: with SMTP id q13-v6mr11210848wrn.113.1531735917105;
        Mon, 16 Jul 2018 03:11:57 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id h14-v6sm10219094wro.15.2018.07.16.03.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 03:11:56 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/6] ARM64: dts: meson-axg: add adc buttons the S400
Date:   Mon, 16 Jul 2018 12:11:47 +0200
Message-Id: <20180716101151.31109-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180716101151.31109-1-jbrunet@baylibre.com>
References: <20180716101151.31109-1-jbrunet@baylibre.com>
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

