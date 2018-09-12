Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D102C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1472087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1472087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeILQ6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:58:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34488 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:58:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id f8-v6so1369823ljk.1;
        Wed, 12 Sep 2018 04:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LyoU4bQEGudsJlLrwE1nHlFKHoOx2W5+y2PvgatmyhU=;
        b=sUUy4nKo1z1yhCGqhMxoO5/1wIiq/fO8HIVwtO+kG50JYRETb+7t4gL9v27bJ+HVn/
         LfrENfb0AzGRMio5zQAuYwxU+eQOCSAdqSetRJVcvY+txB7ZgeVohZ8uz6J6d8pKc2hC
         sn/nstKzIxK4AoOCfTlc/7b4HaRxcZj680hhzi7QVMfkyJ9+4nlMTz3Y3wOacSA1Tlbg
         TTtpelg6AY5N4mWPEC55nDGUOhJpT1DhCF2ozv2bHNTbbaTV2t9Mq7SHkE4B7hpNIQp/
         /EAe+U3x31WhK+1IKkkXIayYv1BiI2cDKMNwYr0id6EB+3NsBD78QFWwyYqSvj0IRqZk
         bnNA==
X-Gm-Message-State: APzg51CK6mjL3iM5BhLoeBWXkm0ucyTye4hFPrYw40184KCxTVaJxKos
        +15N2ZfkoyjlTKLHtK2oh7E=
X-Google-Smtp-Source: ANB0VdawIazaf09nMs5Hzr7re5VAWxNvHz89QjIsSDDyQfpAfDkkwWTG893pAqUrBKc/ZSKkgCMvZA==
X-Received: by 2002:a2e:5bd5:: with SMTP id m82-v6mr1192848lje.115.1536753272331;
        Wed, 12 Sep 2018 04:54:32 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x8-v6sm143368lji.53.2018.09.12.04.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 04:54:31 -0700 (PDT)
Date:   Wed, 12 Sep 2018 14:54:20 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        matti.vaittinen@fi.rohmeurope.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        sboyd@kernel.org
Subject: [PATCH v2 7/7] regulator: bd718xx: rename bd71837 to 718xx
Message-ID: <7265df162f1d48b6aa76a47971619a1a09bdabbe.1536750863.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1536750863.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1536750863.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rename bd71837-regulator.c to bd718x7-regulator.c to reflect the
fact that also BD71847 is now supported by the driver.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/Kconfig                                      | 2 +-
 drivers/regulator/Makefile                                     | 2 +-
 drivers/regulator/{bd71837-regulator.c => bd718x7-regulator.c} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/regulator/{bd71837-regulator.c => bd718x7-regulator.c} (100%)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 329cdd33ed62..6e96ef1bd74a 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -189,7 +189,7 @@ config REGULATOR_BD718XX
 	  and LDO regulators.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called bd71837-regulator.
+	  will be called bd718x7-regulator.
 
 config REGULATOR_BD9571MWV
 	tristate "ROHM BD9571MWV Regulators"
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 801d9a34a203..eac4d794f3b8 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
 obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
 obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o
 obj-$(CONFIG_REGULATOR_BCM590XX) += bcm590xx-regulator.o
-obj-$(CONFIG_REGULATOR_BD718XX) += bd71837-regulator.o
+obj-$(CONFIG_REGULATOR_BD718XX) += bd718x7-regulator.o
 obj-$(CONFIG_REGULATOR_BD9571MWV) += bd9571mwv-regulator.o
 obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
 obj-$(CONFIG_REGULATOR_DA9052)	+= da9052-regulator.o
diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd718x7-regulator.c
similarity index 100%
rename from drivers/regulator/bd71837-regulator.c
rename to drivers/regulator/bd718x7-regulator.c
-- 
2.14.3

