Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF36ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEC720647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="CinLoHfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEC720647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbeGTRch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:32:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56698 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbeGTRcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xda0Aoz+7vpwi1z1p8C690I7f0UzHZAFfAv/TlnuTUg=; b=CinLoHfV39NS
        ElnPmoeDN2ihRv1rFqgeWxzAG7Q7AFKwX2p02h4Z6d2QtHXVVlI+76CZIaOEAFeK1fAooPAZ6JwpC
        GA+Lj6NOq2iqJeeCBeBoYbux0FvNLE9OeTKrKx/zGS9Lq11AhYyFyNI9kh87ZTSulCwgkKQ/i6Az7
        hpjXI=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYUu-000051-T4; Fri, 20 Jul 2018 16:43:16 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYUu-0000kP-EJ; Fri, 20 Jul 2018 17:43:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: export snd_soc_of_get_slot_mask" to the asoc tree
In-Reply-To:  <20180717153643.8806-17-jbrunet@baylibre.com>
Message-Id: <E1fgYUu-0000kP-EJ@debutante>
Date:   Fri, 20 Jul 2018 17:43:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: export snd_soc_of_get_slot_mask

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

From cbdfab3b675f4c34258b0ec9e4707de44e1f6989 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 17 Jul 2018 17:43:02 +0200
Subject: [PATCH] ASoC: export snd_soc_of_get_slot_mask

Amlogic's axg card driver can't use snd_soc_of_parse_tdm_slot()
directly because it needs to handle 4 mask for each direction.
Yet the parsing of each mask is the same, so export
snd_soc_of_get_slot_mask() to reuse the the existing code.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 3 +++
 sound/soc/soc-core.c | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a23ecdf3eff1..ace474e8649e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1433,6 +1433,9 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 			       const char *propname);
 int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 					  const char *propname);
+int snd_soc_of_get_slot_mask(struct device_node *np,
+			     const char *prop_name,
+			     unsigned int *mask);
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			      unsigned int *tx_mask,
 			      unsigned int *rx_mask,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 08e189485009..ad5b0ef16d82 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3428,9 +3428,9 @@ int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_simple_widgets);
 
-static int snd_soc_of_get_slot_mask(struct device_node *np,
-				    const char *prop_name,
-				    unsigned int *mask)
+int snd_soc_of_get_slot_mask(struct device_node *np,
+			     const char *prop_name,
+			     unsigned int *mask)
 {
 	u32 val;
 	const __be32 *of_slot_mask = of_get_property(np, prop_name, &val);
@@ -3445,6 +3445,7 @@ static int snd_soc_of_get_slot_mask(struct device_node *np,
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(snd_soc_of_get_slot_mask);
 
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			      unsigned int *tx_mask,
-- 
2.18.0

