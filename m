Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UYkgO69kHlsLCQAAmS7hNA
	; Mon, 11 Jun 2018 12:01:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D5F5D607E4; Mon, 11 Jun 2018 12:01:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9/0iA7T"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3013460351;
	Mon, 11 Jun 2018 12:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3013460351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933351AbeFKL7M (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:59:12 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34581 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932973AbeFKL7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:59:05 -0400
Received: by mail-wr0-f193.google.com with SMTP id a12-v6so20113875wro.1;
        Mon, 11 Jun 2018 04:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jKsU8mhDIbqOj2eLtMunui12Enev5cjeG3fMe/w6HZY=;
        b=i9/0iA7Tcg+EzN5qPcYZpVcVume6J3o0R/NNiaA0rpr2CMXOYAv9qN9qt7ZAmbA6ny
         pEuggp/nRhWztyJf2SLyZYU5MZkOcBpjM3rRCYKcZumsor/yT5gTQozvQajzvfszESOG
         eaeUKjuXDQh6X21mrhQ2yGstwMuWaz0PkQhokS97lCvhOdE6Q3hmMppUCErhdWvZMgYM
         J3WUWsvS2lwxcZILY3nsNY5SKAx/K3XXBH0Vm/xGvOJz5tvwJ4w+z1p5QVCynNUTQMrY
         TvEI0spX+9jGUBFp5s+nRZrNN5W32mqZAwN43VxM9C8k4qAydrgEQavZNXw9ETgm+xrq
         1iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jKsU8mhDIbqOj2eLtMunui12Enev5cjeG3fMe/w6HZY=;
        b=pSw/htwNf5N3chXO67y6Xf6TNElg4F8q6BBvxT5kC/L+KWpOCejxa9pAb/sorK0aVn
         HzEfLiyZ4eEXAy4OxuamaZwRf/43xi642VZHQfsAHDHmzGRJTNvu6ReaRWVp+x7zGmzO
         L4sHgvI8tQ9qHSzPWhMJqI34F/jnV2kblJ3UUDtj8xJEvzdIv1ru9AEtjBvWWddblIKv
         SAG0E+ygmhs7W6pKkUHg7/dowZBoZevVx/D6cl1PbdKP1Fb5A/ROnug+HmnHNP3SBufN
         zp7W5Ghi0di3uTTrMAZqb75SJbxQLP1uP2/TiXcGkzDdZnTLJnRXi1bzn95MH5YOjEYI
         OVIw==
X-Gm-Message-State: APt69E1l6atXypz9H+aXUeMlNb/pRGT/eb/y2c2DhfEu3Yf+CFNXxdLm
        x91K8ugG4o1MSFcn2FZo4jl/7GDy
X-Google-Smtp-Source: ADUXVKKFh9kCnRH/75DCeG5Chs9BvIu6oYEWORMh+39qUcsijt2NbFkj5CyMfNFlKKsPwFpviBvNkw==
X-Received: by 2002:adf:8462:: with SMTP id 89-v6mr13947904wrf.138.1528718343516;
        Mon, 11 Jun 2018 04:59:03 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t124-v6sm7974796wmt.29.2018.06.11.04.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:59:02 -0700 (PDT)
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 01/14] mfd: da9063: Replace regmap_add_irq_chip with devm counterpart
Date: Mon, 11 Jun 2018 13:58:38 +0200
Message-Id: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_regmap_add_irq_chip() instead of plain regmap_add_irq_chip(),
which removes the need for da9063_irq_exit() altogether and also
fixes a bug in da9063_device_init() where the da9063_irq_exit() was
not called in a failpath.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V5: New patch
V6: No change
---
 drivers/mfd/da9063-core.c       | 1 -
 drivers/mfd/da9063-irq.c        | 8 ++------
 include/linux/mfd/da9063/core.h | 1 -
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index 6c2870d4e754..2647bb371d86 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -238,7 +238,6 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 void da9063_device_exit(struct da9063 *da9063)
 {
 	mfd_remove_devices(da9063->dev);
-	da9063_irq_exit(da9063);
 }
 
 MODULE_DESCRIPTION("PMIC driver for Dialog DA9063");
diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
index 207bbfe55449..da6ceb41f0d1 100644
--- a/drivers/mfd/da9063-irq.c
+++ b/drivers/mfd/da9063-irq.c
@@ -170,7 +170,8 @@ int da9063_irq_init(struct da9063 *da9063)
 		return -EINVAL;
 	}
 
-	ret = regmap_add_irq_chip(da9063->regmap, da9063->chip_irq,
+	ret = devm_regmap_add_irq_chip(da9063->dev, da9063->regmap,
+			da9063->chip_irq,
 			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
 			da9063->irq_base, &da9063_irq_chip,
 			&da9063->regmap_irq);
@@ -182,8 +183,3 @@ int da9063_irq_init(struct da9063 *da9063)
 
 	return 0;
 }
-
-void da9063_irq_exit(struct da9063 *da9063)
-{
-	regmap_del_irq_chip(da9063->chip_irq, da9063->regmap_irq);
-}
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index f3ae65db4c86..9ab7049977aa 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -95,6 +95,5 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq);
 int da9063_irq_init(struct da9063 *da9063);
 
 void da9063_device_exit(struct da9063 *da9063);
-void da9063_irq_exit(struct da9063 *da9063);
 
 #endif /* __MFD_DA9063_CORE_H__ */
-- 
2.16.2
