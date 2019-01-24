Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903B9C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D38F21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360483;
	bh=F/wh98cllsI3EaO7tVRIuDLXP6OU6e2Q4obAZH1DXXc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vkKWoF3GWeYrTqzSUHwDIEMEMj8TEi4tZYe2uvgWjEYTL3tICrnyOfhS0J4RaDa0Z
	 mlgI0M2QEyrY6fJ/7HOAs42ObjSRZOmZCgTOi4zQ5z132T3WvUJp+gEHBEBJAGCydG
	 3Bu4Q8Ep3y/LsbhfZfKugFVZNDzCDl+W+iH1r5vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfAXT32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:29:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47708 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbfAXT3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=OBKdKA7iUfAjFttIUVkneqnmt+wmzaOQCBRcRhvNnpE=; b=c4NVBC2O8EYR
        Cz6W05zDCNowa8wN+zXtf9UiKE76ZnJCFmJK0jvKHsNvOQimYGO6v0bhyizyZU5Wy+cooWjvJqSsh
        Rqv7Pg8Cz4Df9FsPtOmlGVVjFlriwB97TEjsP5GukQM8LZR6TJfKusYSjrjPb0ZdptysmBj0pyK44
        PoUYk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmkgY-0006lP-22; Thu, 24 Jan 2019 19:29:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A68721121B6F; Thu, 24 Jan 2019 19:29:09 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: Intel: make const arrays static, reduces object code size" to the asoc tree
In-Reply-To:  <20190124173735.13669-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190124192909.A68721121B6F@debutante.sirena.org.uk>
Date:   Thu, 24 Jan 2019 19:29:09 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: make const arrays static, reduces object code size

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

From 4ffdca62e2deee7a27613571c9bd18c95b8eac84 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 24 Jan 2019 17:37:35 +0000
Subject: [PATCH] ASoC: Intel: make const arrays static, reduces object code
 size

Don't populate the const arrays on the stack but instead make
it static. Makes the object code smaller, for example:

Before:
   text    data     bss     dec     hex filename
  14107    8832     224   23163    5a7b bytcht_es8316.o

After:
   text    data     bss     dec     hex filename
  14015    8896     224   23135    5a5f bytcht_es8316.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 2 +-
 sound/soc/intel/boards/bytcr_rt5640.c  | 2 +-
 sound/soc/intel/boards/bytcr_rt5651.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index fa9c4cf97686..1364e4e601d8 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -437,7 +437,7 @@ static const struct acpi_gpio_mapping byt_cht_es8316_gpios[] = {
 
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
-	const char * const mic_name[] = { "in1", "in2" };
+	static const char * const mic_name[] = { "in1", "in2" };
 	struct byt_cht_es8316_private *priv;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_acpi_mach *mach;
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index ca8b4d5ff70f..a79466c8fb29 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1149,7 +1149,7 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 
 static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
-	const char * const map_name[] = { "dmic1", "dmic2", "in1", "in3" };
+	static const char * const map_name[] = { "dmic1", "dmic2", "in1", "in3" };
 	const struct dmi_system_id *dmi_id;
 	struct byt_rt5640_private *priv;
 	struct snd_soc_acpi_mach *mach;
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index b618d984e2d5..e6945d11c8ab 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -919,7 +919,7 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 
 static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 {
-	const char * const mic_name[] = { "dmic", "in1", "in2", "in12" };
+	static const char * const mic_name[] = { "dmic", "in1", "in2", "in12" };
 	struct byt_rt5651_private *priv;
 	struct snd_soc_acpi_mach *mach;
 	struct device *codec_dev;
-- 
2.20.1

