Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ED3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319B320656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQYq2n9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfANJzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:55:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44980 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfANJzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:55:49 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so15085687lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 01:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kiHdA9QkJRvfjwHTIrMx6nrkjWZbNgwvVi/jDVnFEGU=;
        b=aQYq2n9CIgX+UUZJoi1/zKIjsIVGr6rKv7tinq2DX+ymRYSvAvjKbbFn3h+NBG/ZRh
         ZO5NPMlvMJJSQ4IJRrc9DQmOXha7I6lw7tns78lpbnD02CEAnl5dQSx7gUTkckTuw8Q5
         yBvUGeV5cYdFSUQxesN0EaQAaUE4Hd/WrRdGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kiHdA9QkJRvfjwHTIrMx6nrkjWZbNgwvVi/jDVnFEGU=;
        b=joMVUchO76Gp7kcL1qTkwvKdczs19ZGnICuNFojwhBuIrEjoAcFwmFga+NLHSRgUv1
         5b5aZ4eGvpEfndNHGpieYrnws75UW9Gr2BLPCtBoFH87F9oRPn+6ifVnsptYgWzxQVzC
         xKsLj+2Apv8ykAsltRg7fBVc3ResRrOnla48d6NGjajm3H4lO8nsQgf8GTZ/Ji1g6vB3
         3e9EjD2TJwRmtzZLQ7LDg1bsV4zyY6jUwAmLMNFZ9cihXr9+c7VV6v5BOkYvVsY2vzWQ
         W6AUaBXvfDQ/e6muDuOFg4dy27LmUmoM85hyd5a0uyfZEV8vzSO+vow1wUWHdoWCdq0J
         u3rQ==
X-Gm-Message-State: AJcUukejyMjPJ0pUJjDplL5f6VrUSCSkJyuJ9FqLJs3B+eQ/xCzliHoK
        eKcJAs/vyjLt7k5M5uBD5h6uZw==
X-Google-Smtp-Source: ALg8bN4VLCfOcM3i+FpoNVfMM/WYcR7cCUZpIHhzRYHgHr5Wiab0rIZanzF7Mi51wYEssT4PyBmySw==
X-Received: by 2002:a19:7006:: with SMTP id h6mr13504722lfc.147.1547459746705;
        Mon, 14 Jan 2019 01:55:46 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id f16-v6sm17516494lji.88.2019.01.14.01.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 01:55:46 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     perex@perex.cz, tiwai@suse.com, brian.austin@cirrus.com,
        Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 1/3] ASoC: cs4341: fix waring unused-function
Date:   Mon, 14 Jan 2019 10:55:40 +0100
Message-Id: <20190114095540.22956-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver cs4341 can be built with SPI and/or I2C, but it has to be one
of them at least. When I2C is set as a module we see the warning below:

sound/soc/codecs/cs4341.c:213:12: warning: ‘cs4341_probe’
defined but not used [-Wunused-function]
 static int cs4341_probe(struct device *dev)
            ^~~~~~~~~~~~

Rework so that we use IS_ENABLED instead of defined. Also change so
SND_SOC_CS4341 depends on SND_SOC_I2C_AND_SPI to we dont' get a link
error when SND_SOC_CS4341=y, I2C=m and REGMAP_I2C=m is set.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 sound/soc/codecs/Kconfig  | 2 +-
 sound/soc/codecs/cs4341.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 87cb9c51e6f5..87ecb38e57f4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -546,7 +546,7 @@ config SND_SOC_CS43130
 
 config SND_SOC_CS4341
 	tristate "Cirrus Logic CS4341 CODEC"
-	depends on I2C || SPI_MASTER
+	depends on SND_SOC_I2C_AND_SPI
 	select REGMAP_I2C if I2C
 	select REGMAP_SPI if SPI_MASTER
 
diff --git a/sound/soc/codecs/cs4341.c b/sound/soc/codecs/cs4341.c
index d2e616a89fd4..ade7477d04f1 100644
--- a/sound/soc/codecs/cs4341.c
+++ b/sound/soc/codecs/cs4341.c
@@ -223,7 +223,7 @@ static int cs4341_probe(struct device *dev)
 					       &cs4341_dai, 1);
 }
 
-#if defined(CONFIG_I2C)
+#if IS_ENABLED(CONFIG_I2C)
 static int cs4341_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -317,7 +317,7 @@ static int __init cs4341_init(void)
 {
 	int ret = 0;
 
-#if defined(CONFIG_I2C)
+#if IS_ENABLED(CONFIG_I2C)
 	ret = i2c_add_driver(&cs4341_i2c_driver);
 	if (ret)
 		return ret;
@@ -332,7 +332,7 @@ module_init(cs4341_init);
 
 static void __exit cs4341_exit(void)
 {
-#if defined(CONFIG_I2C)
+#if IS_ENABLED(CONFIG_I2C)
 	i2c_del_driver(&cs4341_i2c_driver);
 #endif
 #if defined(CONFIG_SPI_MASTER)
-- 
2.19.2

