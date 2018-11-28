Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BC4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080C8205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nuts55cB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080C8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeK1VpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:45:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39030 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeK1VpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:45:15 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so22959183ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UgH5BLrY5mQhMxyJsxrsvTNe6D7bSCIeA0AxXEad3l0=;
        b=Nuts55cBGeXdFX4HEqvC1KvJMqk7W5K8vwEiLU0fGIJNWDw9v/dgCDviPkAk2wIicc
         iCTsByewZqMhowQxtYflzjzfRrpPyH766Cxp1v+AuKSfNPUXU7wta8OdmaZX/vwoFlxd
         ZY56lNyyKX1ex+aqlLWMgjcOHfLtNB4BwadhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UgH5BLrY5mQhMxyJsxrsvTNe6D7bSCIeA0AxXEad3l0=;
        b=Fcz6qVy6HrVbTl055lLxVZj1QroSel2/86PKEDyuOOVXuYqa6WdAskgq2xKN/ZWx7D
         YjX3kpuy7mUlcR2IlTVS3+OFms5I8J9UIJVUC/eJ8yrxZ9+3/z6F1Gj/7WWELHjr7Ykn
         zHE4PHgFqOiIys3EdyLQgF4e6Vpix4547HBekZhgCTa/FWpxmrITeg+MO8rfkyurJx4L
         KXAQOIhnwuvc8O+ZWO2mSJADiBpJHtUDZqHXJOaKaOAz/TT0UuRrP/wGHfmREknVhf9G
         zH1Qs5mY+RUisn2Q5jbL3FMl2ouOeOGrXTHiMPicl7kFDnpgxw5ighGZkLkF1XLGfZ49
         HfiQ==
X-Gm-Message-State: AA+aEWYP5zqLQuKjSmJCsvBe4TpyFVMbYm5Jxbp+on/EHBY34/4D8UdH
        iAB3OtojrCTh3w8XPI5e4f9fnLh+J6XG3A==
X-Google-Smtp-Source: AFSGD/WeKBWMoKuGaTSSb4O2qClgiXJ5jW+EESB275DBC+jqNgZ1hBfio94s7TSexrZj1hj6Yz4lSw==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr3876765ljb.52.1543401840510;
        Wed, 28 Nov 2018 02:44:00 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c20sm1095101lfj.67.2018.11.28.02.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:43:59 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 02/10] regulator: lm363x: Let core handle GPIO descriptor
Date:   Wed, 28 Nov 2018 11:43:42 +0100
Message-Id: <20181128104350.31902-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128104350.31902-1-linus.walleij@linaro.org>
References: <20181128104350.31902-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod_get() rather than the devm_* version so that the
regulator core can handle the lifecycle of these descriptors.

Fixes: b2d751b7f69b ("regulator: lm363x: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/lm363x-regulator.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index bbedb08d257b..06cfba441c46 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -227,10 +227,10 @@ static struct gpio_desc *lm363x_regulator_of_get_enable_gpio(struct device *dev,
 	 */
 	switch (id) {
 	case LM3632_LDO_POS:
-		return devm_gpiod_get_index_optional(dev, "enable", 0,
+		return gpiod_get_index_optional(dev, "enable", 0,
 				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	case LM3632_LDO_NEG:
-		return devm_gpiod_get_index_optional(dev, "enable", 1,
+		return gpiod_get_index_optional(dev, "enable", 1,
 				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	default:
 		return NULL;
@@ -263,6 +263,8 @@ static int lm363x_regulator_probe(struct platform_device *pdev)
 					 LM3632_EXT_EN_MASK,
 					 LM3632_EXT_EN_MASK);
 		if (ret) {
+			if (gpiod)
+				gpiod_put(gpiod);
 			dev_err(dev, "External pin err: %d\n", ret);
 			return ret;
 		}
@@ -270,6 +272,8 @@ static int lm363x_regulator_probe(struct platform_device *pdev)
 
 	rdev = devm_regulator_register(dev, &lm363x_regulator_desc[id], &cfg);
 	if (IS_ERR(rdev)) {
+		if (gpiod)
+			gpiod_put(gpiod);
 		ret = PTR_ERR(rdev);
 		dev_err(dev, "[%d] regulator register err: %d\n", id, ret);
 		return ret;
-- 
2.19.1

