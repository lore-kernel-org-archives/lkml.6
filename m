Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782D9C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF9820880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qJn2AdAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF9820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeLMPoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:44:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35646 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMPoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:44:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so2869669wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 07:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bDJIH6gC/LNEwkSD74Pi8XnlAWHkZTuEbFylymG13pc=;
        b=qJn2AdAoxREYaQcjOjhR0DorWHhTmDoJwyrJh7qxs77uuI68vkmSDOp4z0ns/JDqfP
         lHNNsFGdoGW8MaZ2R8AVvHunq/zvcZ3q7RkEZH9Qj4es3g07JfXfesyAh0GNvmtO/u4L
         Fw7V7+wQWroZP0JdrwQn+hOXP5n+ahtmo4XNztElalfp1ytXV6Jq8jTwvb781FcsivWk
         /QcdK3g15KHA7DCYrPA9e0Jyz4neLkVKsN611yl57kJdSZdyzZmOVVFqGpx3+fDPDej/
         uUHyx1ZaFxsKyW8ZYr1+CPkIrkaoWpapBJErTimxBO556QgzXn8ovvgJtBvPyMIESo4F
         Aa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bDJIH6gC/LNEwkSD74Pi8XnlAWHkZTuEbFylymG13pc=;
        b=Fp0x4xjiWykySgaLshsYaBtE7AxPAkBltMieiPS/TE17lTOS7Aj2zpk9yvlJlX8wS5
         3XrZ4Tj4y4xK8etuwA0UsLb98IgOhnA0gpTD3NuMVmyUD0Z8KJaMl/CViIsTJ9Z3kg24
         8hQfopzYcrigRQjdK8UDwCXeq9ZODMwixqxx7o2L3QRUx6fg5GU9IyqZzzQjqG8Y1O9I
         3dUibSy8FuUvYo6L77jybbMkvzukv2tfBZGDY/kBM6N7j/759qNYreaRg5+p3G2fXORY
         aQcwX1Cy2qHgZ+ZSU9LHzVkkEIrr5ruaIJC1TP1cLzcgVACAEiZG4llWVlSB5UUhves6
         9edA==
X-Gm-Message-State: AA+aEWaIWUuZjIhk0SS70ccUWKGjfDRs6YSR28vNbd7DIBmxIEDLoYaJ
        7fENOCzzc3kfDhvVflRBRNI9Mg==
X-Google-Smtp-Source: AFSGD/XYCmymPdAeC9TKrmdi1jaA4dlFVsYV7KIEFvLN4C6tUH0Vy7ajHx1wHgIP2DuHQHuW4oRiog==
X-Received: by 2002:a1c:8acd:: with SMTP id m196mr10910274wmd.120.1544715877324;
        Thu, 13 Dec 2018 07:44:37 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id p74sm3118235wmd.29.2018.12.13.07.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 07:44:36 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] ASoC: meson: fix do_div warning in spdifin
Date:   Thu, 13 Dec 2018 16:44:28 +0100
Message-Id: <20181213154428.6070-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if this spdif input driver is only supposed to be used on 64bits
platform, there is possible problem with 32bits and do_div, as reported
by the kbuild robot. Just fix it.

Fixes: 5ce5658375e6 ("ASoC: meson: add axg spdif input")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Hi Mark,

 This fixes the problem reported by kbuild robot [0].
 Sorry for not catching this earlier.

 Regards
 Jerome

 [0]: https://lkml.kernel.org/r/201812132245.lBYydcs3%fengguang.wu@intel.com

 sound/soc/meson/axg-spdifin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-spdifin.c b/sound/soc/meson/axg-spdifin.c
index 09f385a2bbba..01b2035fa841 100644
--- a/sound/soc/meson/axg-spdifin.c
+++ b/sound/soc/meson/axg-spdifin.c
@@ -146,8 +146,8 @@ static void axg_spdifin_write_mode_param(struct regmap *map, int mode,
 					 unsigned int base_reg,
 					 unsigned int width)
 {
-	unsigned int offset = mode, rem;
-	unsigned int reg, shift;
+	uint64_t offset = mode;
+	unsigned int reg, shift, rem;
 
 	rem = do_div(offset, num_per_reg);
 
-- 
2.19.2

