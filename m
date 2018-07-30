Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3452FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6051D20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="U3ONieF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6051D20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeG3Mho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:37:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50592 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeG3Mho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=D2j9mNekJbEJHmWt2LlNdGVKLeEm2SFKqQZabsz20hk=; b=U3ONieF++JPw
        XVu0ENB8A+dqWiAgD+QF9NpzjhyCLoFYgABnjt3rpAhfI2vGn5tdE4RDMEQngx8HsNM15Wm6pUYoU
        In18NubkWlvUGWWEhU6Cs9TwVX/dWLbMq+tX01g5TlozRomLFkwVgdHSdmP/Jtm2Px7+XimkA6Bzi
        JYum8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fk5xI-00053i-73; Mon, 30 Jul 2018 11:03:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F065C1124216; Mon, 30 Jul 2018 12:03:11 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: add support for multichannel output" to the asoc tree
In-Reply-To:  <20180727023728.7810-1-suzuki.katsuhiro@socionext.com>
Message-Id: <20180730110311.F065C1124216@debutante.sirena.org.uk>
Date:   Mon, 30 Jul 2018 12:03:11 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: add support for multichannel output

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

From 8fc9983db199bb397d48e32a6400765b70f1995a Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Fri, 27 Jul 2018 11:37:28 +0900
Subject: [PATCH] ASoC: uniphier: add support for multichannel output

This patch adds multichannel PCM output support for LD11/LD20.
Currently driver tested and supported only 2ch, 6ch, and 8ch.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-core.c | 78 ++++++++++++++++++++++++++++++++---
 sound/soc/uniphier/aio-ld11.c |  2 +-
 sound/soc/uniphier/aio-reg.h  |  1 +
 sound/soc/uniphier/aio.h      |  3 ++
 4 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 638cb3fc5f7b..8b09bbb0f8d0 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -264,6 +264,57 @@ void aio_port_reset(struct uniphier_aio_sub *sub)
 	}
 }
 
+/**
+ * aio_port_set_ch - set channels of LPCM
+ * @sub: the AIO substream pointer, PCM substream only
+ * @ch : count of channels
+ *
+ * Set suitable slot selecting to input/output port block of AIO.
+ *
+ * This function may return error if non-PCM substream.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+static int aio_port_set_ch(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 slotsel_2ch[] = {
+		0, 0, 0, 0, 0,
+	};
+	u32 slotsel_multi[] = {
+		OPORTMXTYSLOTCTR_SLOTSEL_SLOT0,
+		OPORTMXTYSLOTCTR_SLOTSEL_SLOT1,
+		OPORTMXTYSLOTCTR_SLOTSEL_SLOT2,
+		OPORTMXTYSLOTCTR_SLOTSEL_SLOT3,
+		OPORTMXTYSLOTCTR_SLOTSEL_SLOT4,
+	};
+	u32 mode, *slotsel;
+	int i;
+
+	switch (params_channels(&sub->params)) {
+	case 8:
+	case 6:
+		mode = OPORTMXTYSLOTCTR_MODE;
+		slotsel = slotsel_multi;
+		break;
+	case 2:
+		mode = 0;
+		slotsel = slotsel_2ch;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < AUD_MAX_SLOTSEL; i++) {
+		regmap_update_bits(r, OPORTMXTYSLOTCTR(sub->swm->oport.map, i),
+				   OPORTMXTYSLOTCTR_MODE, mode);
+		regmap_update_bits(r, OPORTMXTYSLOTCTR(sub->swm->oport.map, i),
+				   OPORTMXTYSLOTCTR_SLOTSEL_MASK, slotsel[i]);
+	}
+
+	return 0;
+}
+
 /**
  * aio_port_set_rate - set sampling rate of LPCM
  * @sub: the AIO substream pointer, PCM substream only
@@ -575,6 +626,10 @@ int aio_port_set_param(struct uniphier_aio_sub *sub, int pass_through,
 			rate = params_rate(params);
 		}
 
+		ret = aio_port_set_ch(sub);
+		if (ret)
+			return ret;
+
 		ret = aio_port_set_rate(sub, rate);
 		if (ret)
 			return ret;
@@ -731,15 +786,28 @@ void aio_port_set_volume(struct uniphier_aio_sub *sub, int vol)
 int aio_if_set_param(struct uniphier_aio_sub *sub, int pass_through)
 {
 	struct regmap *r = sub->aio->chip->regmap;
-	u32 v;
+	u32 memfmt, v;
 
 	if (sub->swm->dir == PORT_DIR_OUTPUT) {
-		if (pass_through)
+		if (pass_through) {
 			v = PBOUTMXCTR0_ENDIAN_0123 |
 				PBOUTMXCTR0_MEMFMT_STREAM;
-		else
-			v = PBOUTMXCTR0_ENDIAN_3210 |
-				PBOUTMXCTR0_MEMFMT_2CH;
+		} else {
+			switch (params_channels(&sub->params)) {
+			case 2:
+				memfmt = PBOUTMXCTR0_MEMFMT_2CH;
+				break;
+			case 6:
+				memfmt = PBOUTMXCTR0_MEMFMT_6CH;
+				break;
+			case 8:
+				memfmt = PBOUTMXCTR0_MEMFMT_8CH;
+				break;
+			default:
+				return -EINVAL;
+			}
+			v = PBOUTMXCTR0_ENDIAN_3210 | memfmt;
+		}
 
 		regmap_write(r, PBOUTMXCTR0(sub->swm->oif.map), v);
 		regmap_write(r, PBOUTMXCTR1(sub->swm->oif.map), 0);
diff --git a/sound/soc/uniphier/aio-ld11.c b/sound/soc/uniphier/aio-ld11.c
index ab04d3331be9..de962df245ba 100644
--- a/sound/soc/uniphier/aio-ld11.c
+++ b/sound/soc/uniphier/aio-ld11.c
@@ -286,7 +286,7 @@ static struct snd_soc_dai_driver uniphier_aio_dai_ld11[] = {
 			.formats     = SNDRV_PCM_FMTBIT_S32_LE,
 			.rates       = SNDRV_PCM_RATE_48000,
 			.channels_min = 2,
-			.channels_max = 2,
+			.channels_max = 8,
 		},
 		.ops = &uniphier_aio_i2s_ops,
 	},
diff --git a/sound/soc/uniphier/aio-reg.h b/sound/soc/uniphier/aio-reg.h
index 45fdc6ae358a..734395dbcffb 100644
--- a/sound/soc/uniphier/aio-reg.h
+++ b/sound/soc/uniphier/aio-reg.h
@@ -374,6 +374,7 @@
 #define OPORTMXTYVOLGAINSTATUS(n, m)     (0x42108 + 0x400 * (n) + 0x20 * (m))
 #define   OPORTMXTYVOLGAINSTATUS_CUR_MASK  GENMASK(15, 0)
 #define OPORTMXTYSLOTCTR(n, m)           (0x42114 + 0x400 * (n) + 0x20 * (m))
+#define   OPORTMXTYSLOTCTR_MODE            BIT(15)
 #define   OPORTMXTYSLOTCTR_SLOTSEL_MASK    GENMASK(11, 8)
 #define   OPORTMXTYSLOTCTR_SLOTSEL_SLOT0   (0x8 << 8)
 #define   OPORTMXTYSLOTCTR_SLOTSEL_SLOT1   (0x9 << 8)
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index aa89c2f6fa24..23a5c3c68658 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -141,6 +141,9 @@ enum IEC61937_PC {
 #define AUD_MIN_FRAGMENT_SIZE    (4 * 1024)
 #define AUD_MAX_FRAGMENT_SIZE    (16 * 1024)
 
+/* max 5 slots, 10 channels, 2 channel in 1 slot */
+#define AUD_MAX_SLOTSEL    5
+
 /*
  * This is a selector for virtual register map of AIO.
  *
-- 
2.18.0

