Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EDBC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EE521A37
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="b/Z+hRu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EE521A37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeHHTCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:02:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58514 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHTCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gyeWXQDonVYARYkY+Y+TlHg4ugCB6AxiCfKYp/+CXSo=; b=b/Z+hRu0sU7g
        xdMG3qS7Qsto005WTpHJNNmWEU5bA6Q2S9ZHrLwKjpPjtRU5eEhpplWVfniv8q1u3RkoCyNqip6+6
        YMjhcmdUc7PgUsnYdInjTmBsXAtjnMgLF4t+x2its3DhuAd0dzUBj7oD+7Hnc+a0Z/fmuwVnLI07m
        mS/iE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fnRWr-00024j-CX; Wed, 08 Aug 2018 16:41:45 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BF4151124340; Wed,  8 Aug 2018 17:41:44 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: wm_adsp: Make DSP name configurable by codec driver" to the asoc tree
In-Reply-To:  <20180808161339.17402-2-rf@opensource.cirrus.com>
Message-Id: <20180808164144.BF4151124340@debutante.sirena.org.uk>
Date:   Wed,  8 Aug 2018 17:41:44 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm_adsp: Make DSP name configurable by codec driver

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

From 605391d0f4bfdff2f2c6c5477ce0ccf776d8d5c0 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Wed, 8 Aug 2018 17:13:39 +0100
Subject: [PATCH] ASoC: wm_adsp: Make DSP name configurable by codec driver

Instead of harcoding that a core must always be called "DSPn"
add a name member to struct wm_adsp so that the owning codec
driver can provide a custom name. This allows for re-use of
the wm_adsp driver with parts where the processing cores are
named differently.

If no name is provided the default DSPn name is used.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 69 ++++++++++++++++++++++++++------------
 sound/soc/codecs/wm_adsp.h |  2 ++
 2 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 1c12c78dbcce..f61656070225 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -35,15 +36,15 @@
 #include "wm_adsp.h"
 
 #define adsp_crit(_dsp, fmt, ...) \
-	dev_crit(_dsp->dev, "DSP%d: " fmt, _dsp->num, ##__VA_ARGS__)
+	dev_crit(_dsp->dev, "%s: " fmt, _dsp->name, ##__VA_ARGS__)
 #define adsp_err(_dsp, fmt, ...) \
-	dev_err(_dsp->dev, "DSP%d: " fmt, _dsp->num, ##__VA_ARGS__)
+	dev_err(_dsp->dev, "%s: " fmt, _dsp->name, ##__VA_ARGS__)
 #define adsp_warn(_dsp, fmt, ...) \
-	dev_warn(_dsp->dev, "DSP%d: " fmt, _dsp->num, ##__VA_ARGS__)
+	dev_warn(_dsp->dev, "%s: " fmt, _dsp->name, ##__VA_ARGS__)
 #define adsp_info(_dsp, fmt, ...) \
-	dev_info(_dsp->dev, "DSP%d: " fmt, _dsp->num, ##__VA_ARGS__)
+	dev_info(_dsp->dev, "%s: " fmt, _dsp->name, ##__VA_ARGS__)
 #define adsp_dbg(_dsp, fmt, ...) \
-	dev_dbg(_dsp->dev, "DSP%d: " fmt, _dsp->num, ##__VA_ARGS__)
+	dev_dbg(_dsp->dev, "%s: " fmt, _dsp->name, ##__VA_ARGS__)
 
 #define ADSP1_CONTROL_1                   0x00
 #define ADSP1_CONTROL_2                   0x02
@@ -608,7 +609,6 @@ static void wm_adsp2_init_debugfs(struct wm_adsp *dsp,
 				  struct snd_soc_component *component)
 {
 	struct dentry *root = NULL;
-	char *root_name;
 	int i;
 
 	if (!component->debugfs_root) {
@@ -616,13 +616,7 @@ static void wm_adsp2_init_debugfs(struct wm_adsp *dsp,
 		goto err;
 	}
 
-	root_name = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!root_name)
-		goto err;
-
-	snprintf(root_name, PAGE_SIZE, "dsp%d", dsp->num);
-	root = debugfs_create_dir(root_name, component->debugfs_root);
-	kfree(root_name);
+	root = debugfs_create_dir(dsp->name, component->debugfs_root);
 
 	if (!root)
 		goto err;
@@ -1315,12 +1309,12 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	switch (dsp->fw_ver) {
 	case 0:
 	case 1:
-		snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "DSP%d %s %x",
-			 dsp->num, region_name, alg_region->alg);
+		snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s %s %x",
+			 dsp->name, region_name, alg_region->alg);
 		break;
 	default:
 		ret = snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
-				"DSP%d%c %.12s %x", dsp->num, *region_name,
+				"%s%c %.12s %x", dsp->name, *region_name,
 				wm_adsp_fw_text[dsp->fw], alg_region->alg);
 
 		/* Truncate the subname from the start if it is too long */
@@ -1648,7 +1642,7 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 	if (file == NULL)
 		return -ENOMEM;
 
-	snprintf(file, PAGE_SIZE, "%s-dsp%d-%s.wmfw", dsp->part, dsp->num,
+	snprintf(file, PAGE_SIZE, "%s-%s-%s.wmfw", dsp->part, dsp->fwf_name,
 		 wm_adsp_fw[dsp->fw].file);
 	file[PAGE_SIZE - 1] = '\0';
 
@@ -2226,7 +2220,7 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 	if (file == NULL)
 		return -ENOMEM;
 
-	snprintf(file, PAGE_SIZE, "%s-dsp%d-%s.bin", dsp->part, dsp->num,
+	snprintf(file, PAGE_SIZE, "%s-%s-%s.bin", dsp->part, dsp->fwf_name,
 		 wm_adsp_fw[dsp->fw].file);
 	file[PAGE_SIZE - 1] = '\0';
 
@@ -2398,8 +2392,38 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 	return ret;
 }
 
+static int wm_adsp_create_name(struct wm_adsp *dsp)
+{
+	char *p;
+
+	if (!dsp->name) {
+		dsp->name = devm_kasprintf(dsp->dev, GFP_KERNEL, "DSP%d",
+					   dsp->num);
+		if (!dsp->name)
+			return -ENOMEM;
+	}
+
+	if (!dsp->fwf_name) {
+		p = devm_kstrdup(dsp->dev, dsp->name, GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+
+		dsp->fwf_name = p;
+		for (; *p != 0; ++p)
+			*p = tolower(*p);
+	}
+
+	return 0;
+}
+
 int wm_adsp1_init(struct wm_adsp *dsp)
 {
+	int ret;
+
+	ret = wm_adsp_create_name(dsp);
+	if (ret)
+		return ret;
+
 	INIT_LIST_HEAD(&dsp->alg_regions);
 
 	mutex_init(&dsp->pwr_lock);
@@ -2672,7 +2696,7 @@ int wm_adsp2_preloader_put(struct snd_kcontrol *kcontrol,
 	struct wm_adsp *dsp = &dsps[mc->shift - 1];
 	char preload[32];
 
-	snprintf(preload, ARRAY_SIZE(preload), "DSP%u Preload", mc->shift);
+	snprintf(preload, ARRAY_SIZE(preload), "%s Preload", dsp->name);
 
 	dsp->preloaded = ucontrol->value.integer.value[0];
 
@@ -2867,8 +2891,7 @@ int wm_adsp2_component_probe(struct wm_adsp *dsp, struct snd_soc_component *comp
 {
 	char preload[32];
 
-	snprintf(preload, ARRAY_SIZE(preload), "DSP%d Preload", dsp->num);
-
+	snprintf(preload, ARRAY_SIZE(preload), "%s Preload", dsp->name);
 	snd_soc_component_disable_pin(component, preload);
 
 	wm_adsp2_init_debugfs(dsp, component);
@@ -2891,6 +2914,10 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 {
 	int ret;
 
+	ret = wm_adsp_create_name(dsp);
+	if (ret)
+		return ret;
+
 	switch (dsp->rev) {
 	case 0:
 		/*
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 8d58cb9d9bb9..4b8778b0b06c 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -57,6 +57,8 @@ struct wm_adsp_compr_buf;
 
 struct wm_adsp {
 	const char *part;
+	const char *name;
+	const char *fwf_name;
 	int rev;
 	int num;
 	int type;
-- 
2.18.0

