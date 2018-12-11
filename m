Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07246C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65CD20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544490990;
	bh=fwpCgsIapvnuWnYwl4M9t9LxQgdvGFsbCwCIc9kDs34=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=mZaG+fKrP63Wv4aX/B0vG9qKuukwY7k3Y5G/yik7WueT6ivNAyUAN3WFmpJ5c9EQW
	 5o5sgq7rEcjnWnr1Q0dSjM9L3Arp0z+Q6ZERPZUZEc1Fssn98/p04i8OHUQbgXm5tf
	 r3m/VwbF3dBwEuUg4Kdzd/UCtkaTfuZEb/VPybnk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65CD20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeLKBQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:16:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51516 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbeLKBQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JoNcaT6inkT0WusSS+PMjJmr4t51Nqd0OapqwfUWwZs=; b=lV/VV07AuJlb
        1DQ/JFErg6B0Xz/ZtcdSmai5OFtvSUj1UXtSw5+Sn/hPSm19j/nAgdotKlW2FehKWe/bEZEMakZSz
        F1YhC+CRTSswjcq3g7bIxnTrCbe7SVGRMjevSlcfI9eLp1dTUtLoayfTZpHW4GlCiUoPmwSrTnNPE
        3PwUk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWet-0000Mf-3V; Tue, 11 Dec 2018 01:16:23 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BD76411254C7; Tue, 11 Dec 2018 01:16:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Track dangling GPIO descriptors" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181211011622.BD76411254C7@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 01:16:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Track dangling GPIO descriptors

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 0edb040d416ab350c02ac710233349aeaf8c2a26 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Dec 2018 13:43:37 +0100
Subject: [PATCH] regulator: core: Track dangling GPIO descriptors

If a GPIO descriptor is passed to the regulator_register()
function inside the config->ena_gpiod callers must be
sure that once they call this API the regulator core
owns that descriptor and will make sure to issue
gpiod_put() on it, no matter whether the call is
successful or not.

For device tree regulators, the regulator core will
automatically set up regulator init data from the device
tree when registering a regulator by calling
regulator_of_get_init_data() which in turn calls down to
the regulator driver's .of_parse_cb() callback.
This callback (in drivers such as for max77686) may also
choose to fill in the config->ena_gpiod field with a GPIO
descriptor.

Harden the errorpath of regulator_register() to
properly gpiod_put() any passed in cfg->ena_gpiod
or any gpiod coming from the device tree on any type
of error.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 55 ++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 757619878068..79cb090ff22f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4868,21 +4868,33 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	struct regulator_config *config = NULL;
 	static atomic_t regulator_no = ATOMIC_INIT(-1);
 	struct regulator_dev *rdev;
+	bool dangling_cfg_gpiod = false;
+	bool dangling_of_gpiod = false;
 	struct device *dev;
 	int ret, i;
 
-	if (regulator_desc == NULL || cfg == NULL)
+	if (cfg == NULL)
 		return ERR_PTR(-EINVAL);
+	if (cfg->ena_gpiod)
+		dangling_cfg_gpiod = true;
+	if (regulator_desc == NULL) {
+		ret = -EINVAL;
+		goto rinse;
+	}
 
 	dev = cfg->dev;
 	WARN_ON(!dev);
 
-	if (regulator_desc->name == NULL || regulator_desc->ops == NULL)
-		return ERR_PTR(-EINVAL);
+	if (regulator_desc->name == NULL || regulator_desc->ops == NULL) {
+		ret = -EINVAL;
+		goto rinse;
+	}
 
 	if (regulator_desc->type != REGULATOR_VOLTAGE &&
-	    regulator_desc->type != REGULATOR_CURRENT)
-		return ERR_PTR(-EINVAL);
+	    regulator_desc->type != REGULATOR_CURRENT) {
+		ret = -EINVAL;
+		goto rinse;
+	}
 
 	/* Only one of each should be implemented */
 	WARN_ON(regulator_desc->ops->get_voltage &&
@@ -4893,16 +4905,20 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	/* If we're using selectors we must implement list_voltage. */
 	if (regulator_desc->ops->get_voltage_sel &&
 	    !regulator_desc->ops->list_voltage) {
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto rinse;
 	}
 	if (regulator_desc->ops->set_voltage_sel &&
 	    !regulator_desc->ops->list_voltage) {
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto rinse;
 	}
 
 	rdev = kzalloc(sizeof(struct regulator_dev), GFP_KERNEL);
-	if (rdev == NULL)
-		return ERR_PTR(-ENOMEM);
+	if (rdev == NULL) {
+		ret = -ENOMEM;
+		goto rinse;
+	}
 
 	/*
 	 * Duplicate the config so the driver could override it after
@@ -4911,11 +4927,22 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	config = kmemdup(cfg, sizeof(*cfg), GFP_KERNEL);
 	if (config == NULL) {
 		kfree(rdev);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto rinse;
 	}
 
 	init_data = regulator_of_get_init_data(dev, regulator_desc, config,
 					       &rdev->dev.of_node);
+	/*
+	 * We need to keep track of any GPIO descriptor coming from the
+	 * device tree until we have handled it over to the core. If the
+	 * config that was passed in to this function DOES NOT contain
+	 * a descriptor, and the config after this call DOES contain
+	 * a descriptor, we definately got one from parsing the device
+	 * tree.
+	 */
+	if (!cfg->ena_gpiod && config->ena_gpiod)
+		dangling_of_gpiod = true;
 	if (!init_data) {
 		init_data = config->init_data;
 		rdev->dev.of_node = of_node_get(config->of_node);
@@ -4954,6 +4981,9 @@ regulator_register(const struct regulator_desc *regulator_desc,
 				 config->ena_gpio, ret);
 			goto clean;
 		}
+		/* The regulator core took over the GPIO descriptor */
+		dangling_cfg_gpiod = false;
+		dangling_of_gpiod = false;
 	}
 
 	/* register with sysfs */
@@ -5039,8 +5069,13 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	regulator_ena_gpio_free(rdev);
 	mutex_unlock(&regulator_list_mutex);
 clean:
+	if (dangling_of_gpiod)
+		gpiod_put(config->ena_gpiod);
 	kfree(rdev);
 	kfree(config);
+rinse:
+	if (dangling_cfg_gpiod)
+		gpiod_put(cfg->ena_gpiod);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(regulator_register);
-- 
2.19.0.rc2

