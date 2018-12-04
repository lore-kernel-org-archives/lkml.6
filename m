Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE471C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AFF20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="x9TFE5l8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AFF20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeLDQxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:53:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52761 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeLDQxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:53:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so10311761wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K40kWu2bFnwxaEfpkYLrLkpBZbXIIj4vA9lroIFYCFY=;
        b=x9TFE5l8GS7goMvDCBMrggwMzWFPJewP9EWehtKPz+C74GBF1wjzGEA0Esix8yZoMs
         qwXb+gjJTPhZ3uaYsm5PMrzFNvtbq+67jMLYb3rO011WaS/udaXsUlP1fXIa/3ePHamD
         aVGJ6Ikl++hZUS+lUp3Vn3hCqeXR5Fsqrckht/uh7yfwDOsD+PwxiJ8Gu3FB69Df3XqH
         TXow5eFRDl2rVgrACLyotp93fPlOBYw4OinzZecX4jZrHYkwQ7kAY/UwgYHPBnUEqzV5
         THeQqj3oAqVxcsP3sjX62SwLZ0HgHIEDMKB5df+WJ+Ls0u3c1va+iEi+MSu7K7NnOCug
         vKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K40kWu2bFnwxaEfpkYLrLkpBZbXIIj4vA9lroIFYCFY=;
        b=EuxyVDrPa4ij/KMVjLLvdQjQ7X5GyOwpFpEhD6C6o5K+rA7I0K8dZd3/RXggxJnsLO
         OgW/XgFXTUM0UQ9z3kR6LIro3kTFkilfpnr8yDfeh6lFDkTfVi8+h9iswrLWfVOURM88
         A+dIxmFyw+wpeg0D+vvwkyeF7uRd5EKz2uaamUfQMCGspgo28KcFIJuLPB3SpkF2RBvV
         Z6GbD9xmMnDWlgLiQcLH+jUVAMIPl9bSkikCpGVP9fTwxiC5XVoYezmYTvVTuCRxCJWA
         2L0QyaOCGCLqygqn+R3CDH813kB5liTLr8H1Bx9m6609q5sKdOVNjxzWzRhdRJTpGcR2
         h3RA==
X-Gm-Message-State: AA+aEWbBWVqRx05nKUQyFxWtDoukY8aNyXOCPR63ObFGQraPCck4aaEG
        kb8AQJ45DNQB6NmdDa2iYR4jXg==
X-Google-Smtp-Source: AFSGD/XPqhimKpWte2wk1Eo37C89ytBiK4mTyBVgUXcKqbOMtkraPZ6t9wA4bmsy2i3hDxh1TA8BFw==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr2811790wmb.98.1543942399163;
        Tue, 04 Dec 2018 08:53:19 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id s66sm11581633wmf.34.2018.12.04.08.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 08:53:18 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/5] clk: meson: clean-up clock registration
Date:   Tue,  4 Dec 2018 17:53:07 +0100
Message-Id: <20181204165310.20806-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204165310.20806-1-jbrunet@baylibre.com>
References: <20181204165310.20806-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Order, ids and size  between the table of regmap clocks and the onecell
data table could be different.

Set regmap pointer in all the regmap clocks before starting the
registration using the onecell data, to make sure we don't
get into an incoherent situation.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson-aoclk.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
index f965845917e3..258c8d259ea1 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -65,15 +65,20 @@ int meson_aoclkc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/*
-	 * Populate regmap and register all clks
-	 */
-	for (clkid = 0; clkid < data->num_clks; clkid++) {
+	/* Populate regmap */
+	for (clkid = 0; clkid < data->num_clks; clkid++)
 		data->clks[clkid]->map = regmap;
 
+	/* Register all clks */
+	for (clkid = 0; clkid < data->hw_data->num; clkid++) {
+		if (!data->hw_data->hws[clkid])
+			continue;
+
 		ret = devm_clk_hw_register(dev, data->hw_data->hws[clkid]);
-		if (ret)
+		if (ret) {
+			dev_err(dev, "Clock registration failed\n");
 			return ret;
+		}
 	}
 
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-- 
2.19.1

