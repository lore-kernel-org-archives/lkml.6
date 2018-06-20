Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13268C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44CB20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="p0MyeK9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44CB20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754238AbeFTKGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:06:46 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36298 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754104AbeFTKGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:06:21 -0400
Received: by mail-wr0-f195.google.com with SMTP id f16-v6so2659199wrm.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 03:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/25jG1/AlkO1wnTVMssBMqhJnfLOsH7SOsbHveCnpzk=;
        b=p0MyeK9BLHvvnWDQHsfTZyz8ssDNbZRfvSRbmC8HWf851HgVH5HDIfjpYD7bjA5QkH
         OIFUvJCbjFlLaAqrYTl4/ROb6P58scr5Q0CiVZlCT8ie/UEuc/d6kQoN5Gswf9C6nmSQ
         /+aBoCggPd5kbKnaOaK3miIdBSwNJNPfMxBu9iXz7tUZ8PtOLJ5cLOFIbGjeZO66UplE
         Ksq2RxUcDqWdTGtkizznOquCHYW2ACm7Si5QE0oXd1WoAVPM/yCiaeK6s+XeTavyUqXF
         DCMfchHx9l/forEzqIxigS9lmiFEBjmkK9+5xW/6vygNpSxQ/2G93p7mFtempy67Uwo3
         mvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/25jG1/AlkO1wnTVMssBMqhJnfLOsH7SOsbHveCnpzk=;
        b=h7ndnThmNSScK1oYQL5nb3djDcjhZ0HNm56m3YK8MIqLOZ49wfPPfbWsJJTEIj9DjQ
         Dd+XYFo10Wf0/W+UpOvIVrNYmzppH/1hqqsMHntf2PUj/2HFvEpD9TQ0cl0Ms+USwyC8
         wzF7kNNIbiyhQYNOqE1D2puaPPyYLOz44iLOEQfYc1M0pqYzloJ6gI3Hytl6UXrJHobn
         3U4L84J2c3+s626oQCnJl36+eFJbhO+DsX7Icb/XbVy9ig+2+ESrE40iCn5qu3cQ7cV8
         5RpbdUMW/5Qx+/dO0NAebGEHSMH9HCkeQRPHNLz0cBR/+8lPLXYMEuxnz9MWynW6j5He
         6Mvw==
X-Gm-Message-State: APt69E3DBR4qT7fIKr4xgEUtV1P46jWGzOgJlT5JVa4VAJnWbD+nSISH
        G3U5h9J+P21OsHFIkX37rJW2cQ==
X-Google-Smtp-Source: ADUXVKJDKLmXf2EFvJFOpPITr/B1GTMFfpgPFsAUeBBpVLHNNGS1MmWImkI3xQXwUMCEs4+XS3R0UQ==
X-Received: by 2002:adf:ba8f:: with SMTP id p15-v6mr18332730wrg.139.1529489180202;
        Wed, 20 Jun 2018 03:06:20 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id m10-v6sm2685852wrq.56.2018.06.20.03.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 03:06:19 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: meson: stop rate propagation for audio clocks
Date:   Wed, 20 Jun 2018 12:06:09 +0200
Message-Id: <20180620100610.29010-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180620100610.29010-1-jbrunet@baylibre.com>
References: <20180620100610.29010-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is actually a lot easier to setup the PLL with carefully chosen rates
than relying on CCF clock propagation for this audio use case.
This way, we can make sure we will always be able to provide the common
audio clock rates, while having the PLL in the optimal operating range.

For this, we stop the rate propagation at the mux picking the
PLL and let it round to the closest matching PLL.

Doing so, we can use the generic divider for the i2s clock.
clk-audio-divider is no longer required. It was a (poor) attempt
to use CCF rate propagation while making sure the PLL rate would
be high enough to work with audio use cases.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 297ebc391475..894a6adaa17a 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -970,28 +970,26 @@ static struct clk_regmap gxbb_cts_amclk_sel = {
 		.mask = 0x3,
 		.shift = 9,
 		.table = (u32[]){ 1, 2, 3 },
+		.flags = CLK_MUX_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_amclk_sel",
 		.ops = &clk_regmap_mux_ops,
 		.parent_names = (const char *[]){ "mpll0", "mpll1", "mpll2" },
 		.num_parents = 3,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
 static struct clk_regmap gxbb_cts_amclk_div = {
-	.data = &(struct meson_clk_audio_div_data){
-		.div = {
-			.reg_off = HHI_AUD_CLK_CNTL,
-			.shift   = 0,
-			.width   = 8,
-		},
+	.data = &(struct clk_regmap_div_data) {
+		.offset = HHI_AUD_CLK_CNTL,
+		.shift = 0,
+		.width = 8,
 		.flags = CLK_DIVIDER_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_amclk_div",
-		.ops = &meson_clk_audio_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "cts_amclk_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1018,13 +1016,13 @@ static struct clk_regmap gxbb_cts_mclk_i958_sel = {
 		.mask = 0x3,
 		.shift = 25,
 		.table = (u32[]){ 1, 2, 3 },
+		.flags = CLK_MUX_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "cts_mclk_i958_sel",
 		.ops = &clk_regmap_mux_ops,
 		.parent_names = (const char *[]){ "mpll0", "mpll1", "mpll2" },
 		.num_parents = 3,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.14.3

