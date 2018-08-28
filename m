Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA19C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A50220897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SQMsaVu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A50220897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeH1QTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:19:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40186 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeH1QTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:19:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id 207-v6so1792167wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=1bWk57vJ2/NRaLDaBlmuyzPfFua+8fuTr7SjvElztx4=;
        b=SQMsaVu9GglAt+KayjZhBlmha+uowDRqqymDUslJw/UdhJ8qgLmksNANQYp9l7oZUx
         0mTq6wcAkVmYMpJoL/Zmpye7v8l3fUxxoMWK6tYVt8DnycaiFIvgkX7gDP9moNYS/T84
         9EzkHhXyeCoqKES3QHNuvqnZNJI6L4w9qHMBm66Xve6W2WZEp0Xr9Gb+wEJLmfbnPbQh
         AFyows6wuhIIHQqx+UFQa+/iyS5ewSir7bMZVmyl5Wkf8bXTk1XgHrQ4G6g4czfUBibM
         ais26saeeCvwYGkvhDdPLzrUvWzIRm/bNtLzSqVgu668kI7H5Ma5EsbEokcNbck4KZgh
         B7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1bWk57vJ2/NRaLDaBlmuyzPfFua+8fuTr7SjvElztx4=;
        b=IJnNUWCx3Iln1ZJbxtI5MGhBEZe6sdpcSu/LdsHD/wDo88iGI43VHCjaBuOBdDdeMw
         ZIaNI/TpbkTr0XOvxLdadlXFsNe+QnuEK7m/z/s9kCmmYmfCXRhF7Tbayb6aB2sXoaSA
         sNFQfkoaCup8kkDClr/V6p2sdt5fo/KUpy2beR3D+epSfqxJhge/EFrUIM8qtURrhY76
         lUOCParyVn8f8pmJaTnJj/tlZmgaceNEnJfNClVd09f0h1eXtO5ZbKjf4KdrNsOKved5
         ys1lliJZV10LUAEQaiDFqUXv7Y4yW3TY2OS6Bx8yJbGA/99U8RjgnvY01q0ljRzPb+Hl
         H/Aw==
X-Gm-Message-State: APzg51DkOS5DPF5Cr+k8205YVJSDzoNIh9A8BsWJNeT3DVrGV65OV5bD
        G1I3mphMKvhzoq60CCQGeGICBw==
X-Google-Smtp-Source: ANB0VdaafbyJaCCcd8f8L31pizhFSOEbj7+HhomwIrBn5Heoit4UTPs/J4XyeSBZgPCaKXgRh0ErDg==
X-Received: by 2002:a1c:7e92:: with SMTP id z140-v6mr1192585wmc.48.1535459260209;
        Tue, 28 Aug 2018 05:27:40 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 184-v6sm2105685wmv.6.2018.08.28.05.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 05:27:39 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] arm64: defconfig: enable modules for amlogic s400 sound card
Date:   Tue, 28 Aug 2018 14:27:35 +0200
Message-Id: <20180828122735.28919-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile the necessary drivers as modules, including codecs, for the
s400 sound card.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f67e8d5e93ad..6b1daea53bd3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -464,6 +464,7 @@ CONFIG_SND_SOC_ROCKCHIP_I2S=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
 CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
+CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_AK4613=m
@@ -475,6 +476,9 @@ CONFIG_SND_SOC_RT5514_SPI=m
 CONFIG_SND_SOC_RT5645=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
+CONFIG_SND_SOC_ES7134=m
+CONFIG_SND_SOC_ES7241=m
+CONFIG_SND_SOC_TAS571X=m
 CONFIG_I2C_HID=m
 CONFIG_USB=y
 CONFIG_USB_OTG=y
-- 
2.17.1

