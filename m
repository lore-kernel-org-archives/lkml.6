Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F609C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139DD2152D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="su7lvC43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139DD2152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeHBSMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:12:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39632 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeHBSMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JKxI9tPVgNcoxiXwSNb0vfR5s1OXRbbrqYCYjsbzz74=; b=su7lvC433TB0
        fONEGWyaplVdoYThrguA/ytMrIFz65IOsvSRGaAKTJXt49fGpLM2e3/u1ZF4BBWU/d8bwug8ofiQ/
        viD6VrVZippht4bxKNhnRCHs8jXPzWaIUDA1gnT+ghPxAYb/1dOHgoauYEeVtR/U6Uep0vYGZLLjn
        YrPg0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flGLJ-0002Ar-Fs; Thu, 02 Aug 2018 16:20:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 00EB01121BE5; Thu,  2 Aug 2018 17:20:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        stefan.wahren@i2se.com, bgoswami@codeaurora.org,
        guillaume.tucker@collabora.com, linux-kernel@vger.kernel.org,
        tiwai@suse.com, vkoul@kernel.org, rohitkr@codeaurora.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: core: remove support for card rebind using component framework" to the asoc tree
In-Reply-To:  <20180802150338.24538-4-srinivas.kandagatla@linaro.org>
Message-Id: <20180802162049.00EB01121BE5@debutante.sirena.org.uk>
Date:   Thu,  2 Aug 2018 17:20:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: core: remove support for card rebind using component framework

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 611cbc8799b672f41b6ba7afed758ad9efb959a7 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 2 Aug 2018 16:03:38 +0100
Subject: [PATCH] ASoC: core: remove support for card rebind using component
 framework

DRM based audio components get registered inside the component framework
bind callback. However component framework has a big mutex lock taken for
every call to component_add, component_del and bind, unbind callbacks.

This can lead to deadlock situation if we are trying to add new/remove
component within a bind/unbind callbacks. Which is what was happening
with bcm2837 rpi 3.

Revert this change till we sort out the mutex issue.

Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  7 -----
 sound/soc/soc-core.c | 62 --------------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ace474e8649e..41cec42fb456 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -17,7 +17,6 @@
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/component.h>
 #include <linux/regmap.h>
 #include <linux/log2.h>
 #include <sound/core.h>
@@ -1091,12 +1090,6 @@ struct snd_soc_card {
 
 	struct work_struct deferred_resume_work;
 
-	/* component framework related */
-	bool components_added;
-	/* set in machine driver to enable/disable auto re-binding */
-	bool auto_bind;
-	struct component_match *match;
-
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 81b27923303d..82eb3868be67 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -279,28 +279,11 @@ static inline void snd_soc_debugfs_exit(void)
 
 #endif
 
-static int snd_soc_card_comp_compare(struct device *dev, void *data)
-{
-	struct snd_soc_component *component;
-
-	lockdep_assert_held(&client_mutex);
-	list_for_each_entry(component, &component_list, list) {
-		if (dev == component->dev) {
-			if (!strcmp(component->name, data))
-				return 1;
-			break;
-		}
-	}
-
-	return 0;
-}
-
 static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 			      struct snd_soc_component *component)
 {
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_rtdcom_list *new_rtdcom;
-	char *cname;
 
 	for_each_rtdcom(rtd, rtdcom) {
 		/* already connected */
@@ -317,13 +300,6 @@ static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 
 	list_add_tail(&new_rtdcom->list, &rtd->component_list);
 
-	if (rtd->card->auto_bind && !rtd->card->components_added) {
-		cname = devm_kasprintf(rtd->card->dev, GFP_KERNEL,
-				       "%s", component->name);
-		component_match_add(rtd->card->dev, &rtd->card->match,
-				    snd_soc_card_comp_compare, cname);
-	}
-
 	return 0;
 }
 
@@ -859,25 +835,6 @@ static bool soc_is_dai_link_bound(struct snd_soc_card *card,
 	return false;
 }
 
-static int snd_soc_card_comp_bind(struct device *dev)
-{
-	struct snd_soc_card *card = dev_get_drvdata(dev);
-
-	if (card->instantiated)
-		return 0;
-
-	return snd_soc_register_card(card);
-}
-
-static void snd_soc_card_comp_unbind(struct device *dev)
-{
-}
-
-static const struct component_master_ops snd_soc_card_comp_ops = {
-	.bind = snd_soc_card_comp_bind,
-	.unbind = snd_soc_card_comp_unbind,
-};
-
 static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_dai_link *dai_link)
 {
@@ -2169,12 +2126,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	card->instantiated = 1;
 	snd_soc_dapm_sync(&card->dapm);
-	if (card->auto_bind && !card->components_added) {
-		component_master_add_with_match(card->dev,
-						&snd_soc_card_comp_ops,
-						card->match);
-		card->components_added = true;
-	}
 	mutex_unlock(&card->mutex);
 	mutex_unlock(&client_mutex);
 
@@ -2820,9 +2771,6 @@ int snd_soc_unregister_card(struct snd_soc_card *card)
 		dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
 	}
 
-	if (!card->auto_bind && card->components_added)
-		component_master_del(card->dev, &snd_soc_card_comp_ops);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_card);
@@ -3235,17 +3183,8 @@ int snd_soc_add_component(struct device *dev,
 
 	snd_soc_component_add(component);
 
-	ret = component_add(dev, NULL);
-	if (ret < 0) {
-		dev_err(dev, "ASoC: Failed to add Component: %d\n", ret);
-		goto err_comp;
-	}
-
 	return 0;
 
-err_comp:
-	soc_remove_component(component);
-	snd_soc_unregister_dais(component);
 err_cleanup:
 	snd_soc_component_cleanup(component);
 err_free:
@@ -3293,7 +3232,6 @@ static int __snd_soc_unregister_component(struct device *dev)
 	mutex_unlock(&client_mutex);
 
 	if (found) {
-		component_del(dev, NULL);
 		snd_soc_component_cleanup(component);
 	}
 
-- 
2.18.0

