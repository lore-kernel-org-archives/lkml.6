Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B22CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FBA20897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UDYNK2Z+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FBA20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeH1QIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:08:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46440 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeH1QIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:08:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id a108-v6so1356029wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 05:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=JQ+58KIOL9krLpYYyKtJqpjQE7I1y4kXR72mwSo4Z7k=;
        b=UDYNK2Z+VcSC1jr65ZktLDjEJCmI9/p1TC5EBcvAf9OLUcIvEJ5f6zWIcnGeba2XbQ
         zGdCkLmnCG99x4EzxLxPKglODj5+aAu9Nx+/OHkwIwz1dMbG+hsz0KrEOfgzNmukPplm
         vz0S8POR8ZqD1+dN0VGJIUhO1ScVA7cCmNRDYW9gkmXpmqTh+4t1UxfZJwv94bt3uhkT
         7bydCKn7ZX1RIlaMyHi0BGl5TKqJuoxgx1+4sCDX7x7B+5SKzSQ1DREVNJM3EtY+GKBK
         KOXLj3/QdTo09GBkUlLwIR4lVxDjywGoAcxOMxNg0xrRwkQXN4UJV9IWxQ6xRPVUZCHZ
         Cvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JQ+58KIOL9krLpYYyKtJqpjQE7I1y4kXR72mwSo4Z7k=;
        b=H9Y5nU3+FozbBKXU1Ee/wKP/kn7l1bnYkf11lNzCuxi6rdXWEoRHqCBZachgnG40rI
         zmDrojFHXsCNTZQVDaY3j7QZ1uEIzCFmsP2NhgME9VahKnglHpmNwEYZZeenB7lcc1E4
         KUM7T/X6HixxfRPhzMvoP9ki53453a/6w6qZNLHpZbUV6cYmxyLUQmWSRUL+lhIKhhDY
         UfHFOAdAGghCE7oCFa4KvKcse5vqK5kIpVaXWaMJi57DW+v9aQfGgCE48SjwaTHPiToX
         pzOC6VFCCk9hRUgqimdtUeXGKB4WweON3kyVK+qmZTxLsmH0G+IJWem0ON3cd25HdbZu
         +fBA==
X-Gm-Message-State: APzg51Bc8UunDORyl+Kjq3z412PPI1Zy1mDh46kYyAUK8TW9mW1m853r
        K1cw+t8KGRvZirxOx2rSmxpK4A==
X-Google-Smtp-Source: ANB0VdYNfzNdTl6THhxArKSkakek/PoYZI0HC5u7D7X21VXWL7D5KH/VNq3K0m7yZjuz+Wbuq1e2zg==
X-Received: by 2002:adf:ae01:: with SMTP id x1-v6mr974255wrc.45.1535458648969;
        Tue, 28 Aug 2018 05:17:28 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id k35-v6sm1773992wrc.14.2018.08.28.05.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 05:17:28 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: meson: imply clock and reset controllers
Date:   Tue, 28 Aug 2018 14:17:21 +0200
Message-Id: <20180828121721.26488-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio clock controller and ARB reset controller module
implication for the device using them

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 8af8bc358a90..2ccbadc387de 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -4,6 +4,8 @@ menu "ASoC support for Amlogic platforms"
 config SND_MESON_AXG_FIFO
 	tristate
 	select REGMAP_MMIO
+	imply COMMON_CLK_AXG_AUDIO
+	imply RESET_MESON_AUDIO_ARB
 
 config SND_MESON_AXG_FRDDR
 	tristate "Amlogic AXG Playback FIFO support"
@@ -22,6 +24,7 @@ config SND_MESON_AXG_TODDR
 config SND_MESON_AXG_TDM_FORMATTER
 	tristate
 	select REGMAP_MMIO
+	imply COMMON_CLK_AXG_AUDIO
 
 config SND_MESON_AXG_TDM_INTERFACE
 	tristate
@@ -58,6 +61,7 @@ config SND_MESON_AXG_SPDIFOUT
 	tristate "Amlogic AXG SPDIF Output Support"
 	select SND_PCM_IEC958
 	imply SND_SOC_SPDIF
+	imply COMMON_CLK_AXG_AUDIO
 	help
 	  Select Y or M to add support for SPDIF output serializer embedded
 	  in the Amlogic AXG SoC family
-- 
2.17.1

