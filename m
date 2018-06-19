Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4666FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F273C205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RgsfLXKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F273C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966878AbeFSPsF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:48:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33041 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966650AbeFSPr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:47:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so19389388wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=jswF46JTCFQSzTI90C09z/gakpKpYDa0XxcKekREGYc=;
        b=RgsfLXKUpWw+end/iC8pQIcTnBLKg3XVAuSLT9LqT7/jHgyosbIoGsl6bH7yLyticj
         xPzSKtyND0eBPGOJ+L9nK9dkbYxBVyP/i2o/lTSF2ymDbuLoyaaz6lhiU65Wa5D5ZYcO
         lV2WiE0RCILw8GNjeuTZte72NlYRksVBIN5Zp0Am1cGq/d8QQgCAVBMbAXvdkR1KnhY1
         G/B0OIVkfYyYrYE6gNWI5Ed45TpebNEGH1ltWSoka0WgzJRZvR/4OiycMFw5XmiTd+M7
         TVc1nOLpCe4prIwYA7G0si6PKqX25gMJx+VDZiaARLDkjr8Dkb1R1f1vcJQ/I+7v3R+Z
         lB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jswF46JTCFQSzTI90C09z/gakpKpYDa0XxcKekREGYc=;
        b=Ie7d/RCEucz1CteSw4rroWHojo9ry5Xp7r/Gx+qbKhOVV3WdiL+6kEny0xlMQ28l3V
         NN0jf9PTBnpIG11LQRMlAEu/YeEcFa/LHdtf6CZQ9tbLfn6hN4l0pWy3XTjvtSla7LpH
         E3P15m5Lb5AVKXt/EfTzr7Umc8hDDcps0Jcz7sAOlDuEi2ZftsPiBDwi0fs81QzRLym1
         l0/FJqzH6FQSIGIqOY8SZnGA5cG4meFMlOJQmwcWK5/3eMvJxs8PmrSAQLepib2ODUvj
         z9VNVxLcoXBaujEsb2X2bzRh0lZmw2kNL4VRCt3x5rqph6m+zKLCVUfkLXZjlGBWAM22
         NZfA==
X-Gm-Message-State: APt69E3BSK5OQTZHzEPI7txeIBAWkn6vbbCHGrYF1BqPZ6WLAULZ1U77
        tdg3FtotOXPY9IqwSud2ey0dgg==
X-Google-Smtp-Source: ADUXVKJ5OuwN8mG2xT29diEgTZnxfTr2lhRj4YXAuCS9i8QOjdpsNc2Z/2s5ftrSpJj7ajaJz/QcJQ==
X-Received: by 2002:a1c:1286:: with SMTP id 128-v6mr13042754wms.9.1529423278200;
        Tue, 19 Jun 2018 08:47:58 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id u70-v6sm608234wmd.3.2018.06.19.08.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 08:47:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: meson: audio-divider is one based
Date:   Tue, 19 Jun 2018 17:47:53 +0200
Message-Id: <20180619154753.12788-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio divider is one based. This offset was mistakenly dropped from
recalc_rate() when migrating to clk_regmap.

Fixes: 88a4e1283681 ("clk: meson: migrate the audio divider clock to clk_regmap")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/clk-audio-divider.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-audio-divider.c b/drivers/clk/meson/clk-audio-divider.c
index 58f546e04807..e4cf96ba704e 100644
--- a/drivers/clk/meson/clk-audio-divider.c
+++ b/drivers/clk/meson/clk-audio-divider.c
@@ -51,7 +51,7 @@ static unsigned long audio_divider_recalc_rate(struct clk_hw *hw,
 	struct meson_clk_audio_div_data *adiv = meson_clk_audio_div_data(clk);
 	unsigned long divider;
 
-	divider = meson_parm_read(clk->map, &adiv->div);
+	divider = meson_parm_read(clk->map, &adiv->div) + 1;
 
 	return DIV_ROUND_UP_ULL((u64)parent_rate, divider);
 }
-- 
2.14.3

