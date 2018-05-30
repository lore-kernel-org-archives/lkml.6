Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932551AbeE3WCD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:02:03 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51293 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeE3WCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:02:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: export mtk-afe symbols as needed
Date: Thu, 31 May 2018 00:00:35 +0200
Message-Id: <20180530220057.1419933-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:UNmyZSfskeazLH3wIYQvWi5pNfMMZTyFpAQMPNq0APHZwPjY+l7
 xtuRk+dQ7JbKprX8tJjYZxQpcCtEe3wcY7gPVfY0cAbJElwkBsJZGrKTCzZBD+74365aiIW
 B771666WJjv45u9H1vHacvRdVAHVd6Kuu+3RROU9wTlhDW86uqfmfyB2TmD8FEM408VNM+6
 M3lNrJl5LJFUFnwyDomEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yqf7zVcvSUU=:Eke/1CPzRXiURDafNAKwJh
 Kfu1rMY66d5aUbuwbfbD5LyZJjFYPHL2HisySbK1jz4oozpZK74gI2cLwdVLE0bD2wjsyqR9b
 WJ8uDdtFQGdiVKF+v69P7vZD+eiNPqWOhXJRSijrpgjpp6zyf6bD+14wdzUYrLeRbOFUgHiAO
 TUm41uPDXjHB6UPU8zwBOZAqMM0Pl3DETV7jm84JicgSe/cpoVWgBYKeA9lwMPg9zEtbgV9hu
 ddhKpUFn66H86VZSf6doQEiGPN2LSrNk69yMghaKU5Xhe81zhDlz5oOvr56I3gJFkojDZxH8a
 WCshlBNHae1WwFJy6IWMq3YPYJGYvNcOfP3F/29HUke/lUoo15jrcBfjZvUq/YUJ5DjioFpkS
 vLTKk5CBFeBQJqCVk+f8Np1zslNDzap/a06AxQMtOQgoZNG5coZO+GHclHbdLSf3HY/DRE291
 mVd8XH88CaLuVQ72+vokBt2VKWhq1CfrA9Z97QOncSnzGYcnYYhHSGbBrOUxGlR0RPGpiHrut
 TyxyHWj8KIl5sklPil6RpHUBGKiN3crNkQr48a4IrVyV9y3SkMcvy52nALopQgTsLR9YiQzdT
 ctmMhooNg1UIzKlLHFkiZkVSJmbC0mWeX5D8apJ775AsuuY/C2/aV0qoJUDYzykismySq4ziY
 Y9Nc3fBFx1iRTKSghSELSgAqo5HXYFDUcxOcAYqyw8wA8iBtAtveCGNVQA5ieZ38r2ZA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new mt6797-afe driver uses some functions in a common file, which
works for a built-in driver but fails for a loadable module:

ERROR: "mtk_afe_pcm_free" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_add_sub_dai_control" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_pcm_new" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_combine_sub_dai" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_pcm_ops" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!

This exports the five symbols above for modules.

Fixes: b3c702f56bf5 ("ASoC: mt6797: combine DAI to register component")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/mediatek/common/mtk-afe-platform-driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 00618587ef1e..51ec4ff6ed95 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -57,6 +57,7 @@ int mtk_afe_combine_sub_dai(struct mtk_base_afe *afe)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_afe_combine_sub_dai);
 
 int mtk_afe_add_sub_dai_control(struct snd_soc_component *component)
 {
@@ -90,6 +91,7 @@ int mtk_afe_add_sub_dai_control(struct snd_soc_component *component)
 	return 0;
 
 }
+EXPORT_SYMBOL_GPL(mtk_afe_add_sub_dai_control);
 
 static snd_pcm_uframes_t mtk_afe_pcm_pointer
 			 (struct snd_pcm_substream *substream)
@@ -130,6 +132,7 @@ const struct snd_pcm_ops mtk_afe_pcm_ops = {
 	.ioctl = snd_pcm_lib_ioctl,
 	.pointer = mtk_afe_pcm_pointer,
 };
+EXPORT_SYMBOL_GPL(mtk_afe_pcm_ops);
 
 int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
@@ -143,11 +146,13 @@ int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 						     afe->dev,
 						     size, size);
 }
+EXPORT_SYMBOL_GPL(mtk_afe_pcm_new);
 
 void mtk_afe_pcm_free(struct snd_pcm *pcm)
 {
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
+EXPORT_SYMBOL_GPL(mtk_afe_pcm_free);
 
 const struct snd_soc_component_driver mtk_afe_pcm_platform = {
 	.name = AFE_PCM_NAME,
-- 
2.9.0
