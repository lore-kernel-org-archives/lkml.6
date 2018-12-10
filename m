Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F58C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA29220672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fK01HTN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA29220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeLJPKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:10:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42755 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeLJPKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:10:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so10834953wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84cTJcohC+weltLv7Y1DgUl2/9ZRCjJVA+0ga2MRH98=;
        b=fK01HTN6Q9meRtE3l6JhYyCvrRtG6ar22Va34019dOiwqGvzQgJi7RJ2Gweh7XiQo1
         BCciNEcMOHrw4Yj6KnlmviGJjC+4EMXbOt3FE/gLGKeS8+OVYFydDrDpXYri+rXHCTAk
         LPhMAPYgzegP8tNUUbOzNNAs2xxwRebiAi6FWgqDXR6Fo9RbpcZNnCWHwQBIViiEzDCX
         Z1dI1ecUzOgRNrkQrGYg7mT33iNUYy/8dqFnSrGDVHVjTtkflkNkQxQYYGQgRvSeyTLh
         AoFrja08ZEoa7OZUcby/WZ+41VERmFx9Yc54M1idGtiRTVcGZYJxNzHddNP76dqT9Apo
         XCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84cTJcohC+weltLv7Y1DgUl2/9ZRCjJVA+0ga2MRH98=;
        b=CIWdElCPJD/O+U88c38nIRqZwzkp6hMBMsvgCOneeMTpzz3vZo78XJmMlS2jX1re4/
         ewT/rVtHH1WI411lm0B+t3DEnOczGPpqNcGUyFgzJtrvUxpg6XvEtAFm08mmbzuFAko+
         CmZvnOzkF00mZm61AIUlik35P7snkA1KRHWqvKSk0WtdhfmlR3ueNGmG3NATMvE21ZyI
         Wrg9Ledq4zEcXjRENOYxgqJStkhCrm18oHzcaVpQtIiLLx6pyXB7oQWRUo6fk1Edd/Ox
         rME9Aym6H4Y0k879pZHjZrO9QHzFpaalLwnRTe2Msbr4NpGgfokANg1zKSJEWOjq0eAn
         ptPA==
X-Gm-Message-State: AA+aEWaeXcjyn1FfehRe830PbHtqSr3ATwI8oMNMgXCwRmSqzNazS9EB
        LxLwfAyNYzQtxR0CaQRvqLrkfQ==
X-Google-Smtp-Source: AFSGD/XVj85AN1kuls0Vncgr0ic8mB6w7bbShbP5WfSHcvsaJ3Fb6mvzzOZCinFDa2OY0ke4qZpSsg==
X-Received: by 2002:a05:6000:104b:: with SMTP id c11mr10453451wrx.303.1544454640039;
        Mon, 10 Dec 2018 07:10:40 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y8sm11755720wmg.13.2018.12.10.07.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 07:10:39 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] regulator: make _regulator_is_enabled() available in internal.h
Date:   Mon, 10 Dec 2018 16:10:23 +0100
Message-Id: <20181210151024.3906-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181210151024.3906-1-brgl@bgdev.pl>
References: <20181210151024.3906-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to use _regulator_is_enabled() in helpers.c. Export it locally
in internal.h.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/regulator/core.c     | 3 +--
 drivers/regulator/internal.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2c66b528aede..3754711530b2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -96,7 +96,6 @@ struct regulator_supply_alias {
 	const char *alias_supply;
 };
 
-static int _regulator_is_enabled(struct regulator_dev *rdev);
 static int _regulator_disable(struct regulator_dev *rdev);
 static int _regulator_get_voltage(struct regulator_dev *rdev);
 static int _regulator_get_current_limit(struct regulator_dev *rdev);
@@ -2531,7 +2530,7 @@ int regulator_disable_deferred(struct regulator *regulator, int ms)
 }
 EXPORT_SYMBOL_GPL(regulator_disable_deferred);
 
-static int _regulator_is_enabled(struct regulator_dev *rdev)
+int _regulator_is_enabled(struct regulator_dev *rdev)
 {
 	/* A GPIO control always takes precedence */
 	if (rdev->ena_pin)
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index 943926a156f2..a8557ed96ae6 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -113,4 +113,5 @@ enum regulator_get_type {
 
 struct regulator *_regulator_get(struct device *dev, const char *id,
 				 enum regulator_get_type get_type);
+int _regulator_is_enabled(struct regulator_dev *rdev);
 #endif
-- 
2.19.1

