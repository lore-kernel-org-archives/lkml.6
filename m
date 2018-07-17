Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B99ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2493F20849
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tEYgpMcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2493F20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbeGQQKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:10:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34278 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbeGQQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:10:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so1726311wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fpyojqqEXxBMVGQ9gOj0nSaGphKtXorSOcTurNY/3cc=;
        b=tEYgpMcSVhKeFLn59F2/ms1O7JqnRZw7/Zb/T2X0vIcvIJdGnSHeYnLv05fqmh7f65
         1s58Kzr9hhGYc7TDSvB0P32coupLWr6FWTvZQPNNi1BIDj5CR/SAagY0YAtgSJjC88QX
         79cCUiri3zpFgnmxaNfpXxtHyocohyN5MOuyioskrjbn5lxcK2xe1hqXPIZYiy/CD0nY
         sNhBTvcuJamxtqn4LhXYYkDQgZyMlh/VboO9sSMvOTPjBiCNRZpa+EwvmAs44cLVBhyC
         NNHcmtHY0OZJhp1pfjHzcV2ne8TDTiXk09jM9LanXnTKEuUQZZXlOHtZtRwey6Ll/G8I
         R8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fpyojqqEXxBMVGQ9gOj0nSaGphKtXorSOcTurNY/3cc=;
        b=K1MeovMhbmwcZJ9+Css7PfV1LPSFlqedtFvJh9bCwR0ha56AXAe3BGMZ0fv9LIyB6z
         9heuE+h44hG4f0OXSzk2oGFB4jT2BZkkkZGGcBW6x136itOiO7a2jt+vMsqaJvZ8oQF6
         i7x4EA/5ncV6fymxFjFKtDNTLUvXhF73JbfZhz7BYw+F3eV8JH2QEQn3Dmgp23maH4z4
         RPKTbPEsAF5j4QBXxQojbTsUYxwqtUf51X07frBEQnQZYlZlqeFQ4FvF9HF5cELRzUcx
         8B0ykeGJ/tC2X5fk8IKtmpvSpi6HD6ZTT8x3fH82/m/xRxbtfqLbLdTMaXmMmEhf7Flm
         t4AA==
X-Gm-Message-State: AOUpUlHMy86liHbvI6HNChouhlrDzOEIM4q9g43FfI9a8LGsAHYPuVfe
        R1XpxyvJHa131ULiXgbIOE5cCA==
X-Google-Smtp-Source: AAOMgpf7N2H+OjqUXNKGPb1GqKhHHg3Gg4URYJtXw8ypOuDTbCnPU2LsWKb243WD2cMwkrVWGola+w==
X-Received: by 2002:adf:8276:: with SMTP id 109-v6mr1804507wrb.127.1531841808205;
        Tue, 17 Jul 2018 08:36:48 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16971464wmb.3.2018.07.17.08.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:36:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 01/15] ASoC: meson: add axg fifos DT binding documentation
Date:   Tue, 17 Jul 2018 17:36:25 +0200
Message-Id: <20180717153643.8806-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT bindings documentation for axg's FIFOs: TODDR and FRDDR.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/sound/amlogic,axg-fifo.txt | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
new file mode 100644
index 000000000000..3dfc2515e5c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
@@ -0,0 +1,23 @@
+* Amlogic Audio FIFO controllers
+
+Required properties:
+- compatible: 'amlogic,axg-toddr' or
+	      'amlogic,axg-frddr'
+- reg: physical base address of the controller and length of memory
+       mapped region.
+- interrupts: interrupt specifier for the fifo.
+- clocks: phandle to the fifo peripheral clock provided by the audio
+	  clock controller.
+- resets: phandle to memory ARB line provided by the arb reset controller.
+- #sound-dai-cells: must be 0.
+
+Example of FRDDR A on the A113 SoC:
+
+frddr_a: audio-controller@1c0 {
+	compatible = "amlogic,axg-frddr";
+	reg = <0x0 0x1c0 0x0 0x1c>;
+	#sound-dai-cells = <0>;
+	interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
+	clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
+	resets = <&arb AXG_ARB_FRDDR_A>;
+};
-- 
2.14.4

