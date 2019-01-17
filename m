Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC66CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9A420851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YECdKmns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfAQKXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:23:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39037 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfAQKX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:23:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so10359331wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Tf+jWcbQvaP/wZHxbjP4tGEHKpoydocGjOeujE6LsY=;
        b=YECdKmnsLma30+5hkWrT0/AErkw+qY1sW+4PEBA5VOPC3jiyD4mfoO7JIHmc8iFBsC
         EtYlOtTc0y7kuXV5Yslhbp/mze3r5AzNYQYCo3oBHahOoaJHA9SuDD+KGTZprnVb7d1y
         gqOR7mOgTpyQmGXveaMybagkJaVIfxpwDvBx3+E8gyDREbSHSX5r3cfb6RJtSnwKI8z1
         D7fiXOrbVWV4H2+l6YnuwFg+mT41dt0DtBtpuFPD5GfjL4JgeWcLSFTV7mEeJiUs21GF
         K6qTTvMdfiG4gfmZsxMq4FknElK5Kt6pS5E3DoKjQYUs9tWhkLvCbfkc6DH2JoJeJ0Eo
         upoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Tf+jWcbQvaP/wZHxbjP4tGEHKpoydocGjOeujE6LsY=;
        b=YZ2cXMGf8yO1XGAZ3ubCjgKGekKb/at48GD7YqC8y5wuhPMHPl8qKSggQQwWRABGwB
         K5pyk24/7J+ecFMyibQNLQr7b3G5YnUUaGWx9rTqW0LqFegZqNRI+XyEVlIe/74rXmJx
         lAmu4ELMLE+f3Qr/iZFY9M5V1V6AE9fwBUMfTlIJEysGnA4OSE+x8pOkKRzlrAHeo4I6
         v92h1LNsHxyjGH2FGKC+uwHkaXAD5sqTibLdUAWLtqUvrgo1c2cL28lATUQudjZuSDJU
         xmSbvnNXPWxuBU0uUsLlku4ubBfg6Z5aeExbjd2XFXsdQmGWqngJH00LurJMVrTua0Ml
         eCMA==
X-Gm-Message-State: AJcUukdXSv4dOOzEsaNppmCpEkvQCn2E+5IFYVB20c2vXUFkOv1MZBnl
        MHRj9VZ5Ho6MvgLOqDxDkDDn+A==
X-Google-Smtp-Source: ALg8bN6gLhA6yd4aO0Nf1n+/DxbTHZN1epiKdGM4gxJ24u11pxa+cNjFrMswgsx6iwMKyyPVXfCrZw==
X-Received: by 2002:adf:9382:: with SMTP id 2mr11151661wrp.269.1547720607627;
        Thu, 17 Jan 2019 02:23:27 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id u10sm66400530wrr.33.2019.01.17.02.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 02:23:27 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pinctrl: meson: add optional region for drive strength
Date:   Thu, 17 Jan 2019 11:23:15 +0100
Message-Id: <20190117102315.1833-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117102315.1833-1-jbrunet@baylibre.com>
References: <20190117102315.1833-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the G12a, there is a new 'region' to handle the drive-strength.
This is optional since the older do not have this.

Fixes: 29ae0952e85f ("pinctrl: meson-g12a: add pinctrl driver support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 6 ++++++
 drivers/pinctrl/meson/pinctrl-meson.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index a4ae1ac5369e..96a4a72708e4 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -507,6 +507,12 @@ static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
 	if (IS_ERR(pc->reg_pullen))
 		pc->reg_pullen = pc->reg_pull;
 
+	pc->reg_ds = meson_map_resource(pc, gpio_np, "ds");
+	if (IS_ERR(pc->reg_ds)) {
+		dev_dbg(pc->dev, "ds registers not found - skipping\n");
+		pc->reg_ds = NULL;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index eff61ea1c67e..5eaab925f427 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -120,6 +120,7 @@ struct meson_pinctrl {
 	struct regmap *reg_pullen;
 	struct regmap *reg_pull;
 	struct regmap *reg_gpio;
+	struct regmap *reg_ds;
 	struct gpio_chip chip;
 	struct device_node *of_node;
 };
-- 
2.20.1

