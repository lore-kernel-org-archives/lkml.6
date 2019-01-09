Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC55FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A18B20656
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dwPSzrsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfAIRoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:44:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39800 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfAIRoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:44:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so8553501wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 09:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXBwFKbWk+E0hwU6u+rNOKAkE7EQuLgmRIWcKrKhQq0=;
        b=dwPSzrsZQhEN6KOqMDQ8SNwRtwCETnI6prk3MBvvU3u/XwoHAaZ3KCVva+Ui+tkf7T
         O20nLpzqdCpXmiRs3LZNHj/PvkOS9EC4zpdaCw0clIEuta2SBcvmRH3wws8AWEhsfZDx
         gVj+z/+CLzz4tz5z4OD75WdqGHU2vuFIqBk+2SP7eJUWYZf90VVtWgE0l/0PmaxD/wXD
         rouy4WD7KcnwZMMAcjjyAiCWfAgL3Vlfb0p23kuqIOQEaEemsF6c8xso/ZtKYvNKf6V2
         1hq7oO4IKTO9vDZsu48RavMFyBt8V4FTSDUD+YPokzBfTeX+OqIbDu0cLAgkj7j/Prda
         Uf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXBwFKbWk+E0hwU6u+rNOKAkE7EQuLgmRIWcKrKhQq0=;
        b=CreMBOp65JVdbHclt9e0VjYbgmF1cHvAol9L7yIHsV8NhetcufVjODlJOv6dRNhS64
         c5KYyujazJyO4anDEFfcUm2mN9Z9BC+IntP/JBI9U9NnQZua6gBqbwuhzoiQq/Pm38Ea
         Smrf3pO3OsIVPiXs+Ve0B7D/LRwwuVC1vFnB8DcZlO5npbLXwLPPUTGubDVnL1tLZix7
         nEFIHfSjzhEX+hVptK6f+cLZK35bZpu+se2WNj83DkbLPNMHCkv2RA40BTtGF1m7szUT
         Cxjd7vMklQ5f1MUp6rh6Juvde56heVOxRMcK/ReXEGGR+T4ynpsZDixCuVCRc+0bz9p/
         fWaA==
X-Gm-Message-State: AJcUukfPYRnRmY+QptJLUkziMMbDLhfH9TEAdfMTHEOXJoCev4xAwCwd
        e6ryKj+EC31rH+OSUp//wdOJjuW5vag=
X-Google-Smtp-Source: ALg8bN6+ElVUolbJy68UtraT9PBX9yysWTVmqaQK5krMK/dMbGqoUsqGZRn0WM3zj1lVdpa01AzVwQ==
X-Received: by 2002:a05:6000:10d1:: with SMTP id b17mr5876187wrx.306.1547055843011;
        Wed, 09 Jan 2019 09:44:03 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b129sm12980842wmd.24.2019.01.09.09.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 09:44:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] regulator: provide rdev_get_regmap()
Date:   Wed,  9 Jan 2019 18:44:00 +0100
Message-Id: <20190109174400.3544-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Provide a helper allowing to access regulator's regmap.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
Hi Mark,

please consider adding this helper to regulator core. I used it in
my max77650 driver and it nicely simplified the code, since there's
no more need for a driver-wide data structure as callbacks only
need to access the regulator description and register offsets (stored
in global constant regulator description structures).

 drivers/regulator/core.c         | 6 ++++++
 include/linux/regulator/driver.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b9d7b45c7295..17d496f267b6 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5251,6 +5251,12 @@ struct device *rdev_get_dev(struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(rdev_get_dev);
 
+struct regmap *rdev_get_regmap(struct regulator_dev *rdev)
+{
+	return rdev->regmap;
+}
+EXPORT_SYMBOL_GPL(rdev_get_regmap);
+
 void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data)
 {
 	return reg_init_data->driver_data;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 389bcaf7900f..795b38a06b6c 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -503,6 +503,7 @@ int regulator_notifier_call_chain(struct regulator_dev *rdev,
 
 void *rdev_get_drvdata(struct regulator_dev *rdev);
 struct device *rdev_get_dev(struct regulator_dev *rdev);
+struct regmap *rdev_get_regmap(struct regulator_dev *rdev);
 int rdev_get_id(struct regulator_dev *rdev);
 
 int regulator_mode_to_status(unsigned int);
-- 
2.19.1

