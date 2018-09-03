Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E841BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CD120658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="gv+t0Q7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CD120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeICSHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:07:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57628 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeICSHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4h5vXZ8nhUXJlWKGGOg51nmFbnDqq7I5pkzdrchMNh8=; b=gv+t0Q7+02Zo
        KfyxZ38Bjp2/YBtUDw+Ex8BivmwaNzMb3U9MQo9vqWbRXbj4FGho1neswJ+6RxGFJSDshSTgcTZI1
        +GYlqaoMiBXdAPbeUxffeWvyiTsvCJrEQ1/F8/dXF6ZNV/PcSB2DQFq3CfqqYpTNDuT0YZDF8dyRr
        TFft4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwpC8-0000Ib-MK; Mon, 03 Sep 2018 13:47:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 724C411227AE; Mon,  3 Sep 2018 14:47:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: fix soc-core.c kernel-doc warning" to the asoc tree
In-Reply-To:  <a75f4b8b-4e1c-bc73-1033-c49f4b30e4e5@infradead.org>
Message-Id: <20180903134708.724C411227AE@debutante.sirena.org.uk>
Date:   Mon,  3 Sep 2018 14:47:08 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fix soc-core.c kernel-doc warning

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

From 63a886f38dd96868e33488eccee8ed427144d397 Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 2 Sep 2018 19:38:10 -0700
Subject: [PATCH] ASoC: fix soc-core.c kernel-doc warning

Fix kernel-doc warning:

../sound/soc/soc-core.c:2918: warning: Excess function parameter 'legacy_dai_naming' description in 'snd_soc_register_dais'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2a73630d0680..e9c2304afaf1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2944,8 +2944,6 @@ static struct snd_soc_dai *soc_add_dai(struct snd_soc_component *component,
  * @component: The component the DAIs are registered for
  * @dai_drv: DAI driver to use for the DAIs
  * @count: Number of DAIs
- * @legacy_dai_naming: Use the legacy naming scheme and let the DAI inherit the
- *                     parent's name.
  */
 static int snd_soc_register_dais(struct snd_soc_component *component,
 				 struct snd_soc_dai_driver *dai_drv, size_t count)
-- 
2.19.0.rc1

