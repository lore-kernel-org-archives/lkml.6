Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E05C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39A227185
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TKsY0bqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39A227185
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965010AbeF1JvL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:51:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38186 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964936AbeF1JvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:51:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so8288291wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=egzWyK3T8Ov6ucobORvjv7jBxNQJz5gq2zeDfJ0v8ug=;
        b=TKsY0bqKkQsWo75r/BJGJV3ZE/IfDC6MsXcc1S9jBDCfHIpkWwi02HN3xzdx3vk3tZ
         lUfgZIYoK1uyXsu8RHHQsQl9BWT/CeBZxWqXknKrGbAUMwFHDyiTwD+hNirK9SUwla4V
         sLxnnhSNuqkU9bR83hEgVpNVw0uBQC8d3Nm1WDFDWGjHBHin6xJpM18UckwSAko9dt+Y
         4kQftEaVHT+hv3EICLWH6moLYMkBBTOkB8Nf29ejpv0arMa6kn+nrlcoZNOlY+jxzH8Q
         Na7hjuFgrqAuBGFDsPC3ovm5vhbmQtvPfDtApAlCOp7eiTUG0FWK8RrHGoiX4Q/9tcWg
         IXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=egzWyK3T8Ov6ucobORvjv7jBxNQJz5gq2zeDfJ0v8ug=;
        b=s+PRm9Nkx6IccIQ3ia7FyPNqxPPO2BStVZqZWpi6YO+b5O4pW6FS5ISabGHfmSunz1
         GPSGkt11BlWsilppYAu/Oh0AkNv+NfgmFrLFKbiVXr0obQmxB7vEwrlteX5EBBdEGKYW
         iGFP1PRRkiaeC0KJHGV4fQ6ji5DnuTXMiVuveUSsrB33xXuRugoVUH0qTJ/H4tY5V21l
         ceUKKcNMy5Yr0dZyf8L2mBdvlk6/vSftKKS42FfwPdhbw/QptTJoERStQm5ycG7N9Xr0
         EcDzithl8WpKQIJ0DGLwpIuXoiDX71B7r1Wh21GuGQh8nIqKfaz0STArYDfhbz8xk3Dd
         Z/rA==
X-Gm-Message-State: APt69E1kl5K2/j+bT8Tc8FwQkfiD05fr6xV3ZzQwjRYGbWNq2MXkyvDS
        elx64hjeq2/IBpiGne5Vk8ttVA==
X-Google-Smtp-Source: AAOMgpcMNXU7ZqIfITxK8LUjKFVLO5lM6XJMKYedNH5GTrrisdQfUU0zyd16lKVg5YzniJ5fm4enhw==
X-Received: by 2002:a1c:c289:: with SMTP id s131-v6mr551165wmf.65.1530179463623;
        Thu, 28 Jun 2018 02:51:03 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w67-v6sm6413476wmw.0.2018.06.28.02.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 02:51:02 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM64: dts: meson-axg: add s400 speaker amplifier
Date:   Thu, 28 Jun 2018 11:50:54 +0200
Message-Id: <20180628095054.13433-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628095054.13433-1-jbrunet@baylibre.com>
References: <20180628095054.13433-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the first of the two tas5707 power amplifier present on the
speaker daughter board.

According to the schematics of the S400 v3, only I2SB_DIN3 and
I2SC_DOUT2 will be available to the speaker board.

9R83, 9R84 and 9R18 are not connected so no audio signal will be
provided to the second amplifier. There is no point in enabling it
even if it is visible on the i2c bus.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 0b655570b7c2..1927282e8530 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -147,6 +147,19 @@
 	status = "okay";
 	pinctrl-0 = <&i2c1_z_pins>;
 	pinctrl-names = "default";
+
+	speaker_amp1: audio-codec@1b {
+		compatible = "ti,tas5707";
+		reg = <0x1b>;
+		reset-gpios = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		AVDD-supply = <&vcc_3v3>;
+		DVDD-supply = <&vcc_3v3>;
+		PVDD_A-supply = <&main_12v>;
+		PVDD_B-supply = <&main_12v>;
+		PVDD_C-supply = <&main_12v>;
+		PVDD_D-supply = <&main_12v>;
+	};
 };
 
 &i2c_AO {
-- 
2.14.4

