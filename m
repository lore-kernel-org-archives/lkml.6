Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED19AECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61FD2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anVXieLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61FD2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbeGQQio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:38:44 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33503 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbeGQQin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:38:43 -0400
Received: by mail-lf0-f65.google.com with SMTP id u14-v6so1251785lfu.0;
        Tue, 17 Jul 2018 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmGc4y2imt1ExYPAjKYiMse/xhDh77VC3NOODiIkSdg=;
        b=anVXieLyNjPWQaX1zLjCbK2+V6qn+x65PNz8rU41HpVlZsj9xsJiR/OteewcCiVDZH
         AldKjDUSx5ZaKdQ0bJ4XrZj2erfhlIBKdeMjo+7bk0YgKDpWwSAo6bTIvlGC8SPvrBni
         iqe2zGUhE5smrYG0p+++vv+WTFrFkQrrDtqBdxR/kmW2PZx9p65EVAEAlbnYyO45itqU
         LgdUZFAaqAqsAo/mcEoXYTYUFjTfuWHQwq5fTVOo6Boo2fxpbVkgFyBpLpPhDtl/pyM8
         sdUULnFSkmuAFqE7fRvZiCwy4z3e9aJzcdx9cXu/ZTQ4nv3hZ+mnUcaxstqgMZWHLIyL
         nUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmGc4y2imt1ExYPAjKYiMse/xhDh77VC3NOODiIkSdg=;
        b=f6aYwrO6yLJ2ejjy588ZU9KCvlAIp3hvvrBPzyIfTHKWORTF+DxYo6VC0Gu82q7SLi
         D3JGK8nPBjHaFmTWnaMmT6/qxiDv8Jl4Vwft3+49PblYEiQqmHb+tr9V0+ceG5yJGzul
         hDiKHjd3YUtZcOLHzlmQvsSqqtnhNAhOv9fvro+Bh1F4U/QCPjNiNmkWDgAOmwVyUVWR
         QvJYYvadXBTNfcZ6dRGPHSuWnMCT9C9ZGlRjfialTQtAoeqSOog0pqToa+QSCxIIH0bX
         nLjfWGwObn1cBBLOGtsKtNtO9xLtVevhGo9wBUlhBS5hqjIYOmKdHollaSDvK2y9hzV8
         DnVw==
X-Gm-Message-State: AOUpUlF8PMgwo02oCqnDFx1g73otvaXpdBlZcYHqsdibiu+cD88ijwBO
        tIB7NK5rgZ2PmELv1At4Ilg=
X-Google-Smtp-Source: AAOMgpd3X5CnupnsMshy/iKwCO1aUlWPBpjOunui63FYJ8+D+4iBzepv1VYq9QWzK/Cs7tyxC6kiOw==
X-Received: by 2002:a19:910a:: with SMTP id t10-v6mr1632983lfd.24.1531843520268;
        Tue, 17 Jul 2018 09:05:20 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.googlemail.com with ESMTPSA id d23-v6sm229861ljg.17.2018.07.17.09.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 09:05:19 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v3 1/3] power: supply: max8998-charger: Fix platform data retrieval
Date:   Tue, 17 Jul 2018 18:05:07 +0200
Message-Id: <1531843509-3533-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

Since the max8998 MFD driver supports instantiation by DT, platform data
retrieval is handled in MFD probe and cell drivers should get use
the pdata field of max8998_dev struct to obtain them.

Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/power/supply/max8998_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max8998_charger.c b/drivers/power/supply/max8998_charger.c
index b64cf0f14142..66438029bdd0 100644
--- a/drivers/power/supply/max8998_charger.c
+++ b/drivers/power/supply/max8998_charger.c
@@ -85,7 +85,7 @@ static const struct power_supply_desc max8998_battery_desc = {
 static int max8998_battery_probe(struct platform_device *pdev)
 {
 	struct max8998_dev *iodev = dev_get_drvdata(pdev->dev.parent);
-	struct max8998_platform_data *pdata = dev_get_platdata(iodev->dev);
+	struct max8998_platform_data *pdata = iodev->pdata;
 	struct power_supply_config psy_cfg = {};
 	struct max8998_battery_data *max8998;
 	struct i2c_client *i2c;
-- 
2.7.4

