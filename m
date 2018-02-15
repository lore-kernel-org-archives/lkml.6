Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165407AbeBOR1V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:27:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35758 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165077AbeBOPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:34:21 -0500
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>,
        Steven Eckhoff <steven.eckhoff.opensource@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: TSCS42xx: make const array norm_addrs static, reduces object code size" to the asoc tree
In-Reply-To: <20180214172153.5749-1-colin.king@canonical.com>
Message-Id: <E1emLY3-0007JV-Nz@debutante>
Date: Thu, 15 Feb 2018 15:34:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: TSCS42xx: make const array norm_addrs static, reduces object code size

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

>From 390f7bbdd7c8f812e22100248b0ed7ae1f68b8c9 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 14 Feb 2018 17:21:53 +0000
Subject: [PATCH] ASoC: TSCS42xx: make const array norm_addrs static, reduces
 object code size

Don't populate the const array norm_addrs on the stack, instead make it
static.  Makes the object code smaller by over 230 bytes.  Also re-format
array data as the insertion of the static keywork made the first line
overly long.

Before:
   text	   data	    bss	    dec	    hex	filename
  53780	  34752	    256	  88788	  15ad4	linux/sound/soc/codecs/tscs42xx.o

After:
   text	   data	    bss	    dec	    hex	filename
  53461	  34840	    256	  88557	  159ed	linux/sound/soc/codecs/tscs42xx.o

(gcc version 7.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tscs42xx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index f4f8c613386a..e915261fa1cb 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -1319,11 +1319,13 @@ static struct snd_soc_component_driver soc_codec_dev_tscs42xx = {
 
 static inline void init_coeff_ram_cache(struct tscs42xx *tscs42xx)
 {
-	const u8 norm_addrs[] = { 0x00, 0x05, 0x0a, 0x0f, 0x14, 0x19, 0x1f,
-		0x20, 0x25, 0x2a, 0x2f, 0x34, 0x39, 0x3f, 0x40, 0x45, 0x4a,
-		0x4f, 0x54, 0x59, 0x5f, 0x60, 0x65, 0x6a, 0x6f, 0x74, 0x79,
-		0x7f, 0x80, 0x85, 0x8c, 0x91, 0x96, 0x97, 0x9c, 0xa3, 0xa8,
-		0xad, 0xaf, 0xb0, 0xb5, 0xba, 0xbf, 0xc4, 0xc9, };
+	static const u8 norm_addrs[] = {
+		0x00, 0x05, 0x0a, 0x0f, 0x14, 0x19, 0x1f, 0x20, 0x25, 0x2a,
+		0x2f, 0x34, 0x39, 0x3f, 0x40, 0x45, 0x4a, 0x4f, 0x54, 0x59,
+		0x5f, 0x60, 0x65, 0x6a, 0x6f, 0x74, 0x79, 0x7f, 0x80, 0x85,
+		0x8c, 0x91, 0x96, 0x97, 0x9c, 0xa3, 0xa8, 0xad, 0xaf, 0xb0,
+		0xb5, 0xba, 0xbf, 0xc4, 0xc9,
+	};
 	u8 *coeff_ram = tscs42xx->coeff_ram;
 	int i;
 
-- 
2.16.1
