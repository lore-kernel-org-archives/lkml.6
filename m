Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B33C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAAE20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="up7C+zZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAAE20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbeKEVRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:17:55 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39248 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeKEVRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=pIDVrl3lzPUFKvm/lAKTgFVLGnbFbZNuJyouyznyvEo=; b=up7C+zZ/B2LQ
        sGGcFmHkpRl0D4naamwhMay3Cn9Ujr/cScf+/WvECrEo9Uiw7JzQhgkqQiv+SKb8D570zFax33UzV
        ITUiTukT01gZ4XHPlzUcqJYSZ+OEkFYHMGTLTZEoM8Udo1FVO5PBUnJpHspnV/zc8Xed4NkFWJ383
        YGJFY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdWS-0008IE-9n; Mon, 05 Nov 2018 11:58:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0D0071124D98; Mon,  5 Nov 2018 11:58:24 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: AMD: constify regulator_desc structure" to the asoc tree
In-Reply-To:  <1540706168-30601-1-git-send-email-Julia.Lawall@lip6.fr>
Message-Id: <20181105115824.0D0071124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 11:58:24 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: constify regulator_desc structure

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

From de3636488cff3678bafaf2d024e64c003ed2beae Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 28 Oct 2018 06:56:08 +0100
Subject: [PATCH] ASoC: AMD: constify regulator_desc structure

The regulator_desc structure can be const as it is only passed as the
second argument of devm_regulator_register and the corresponding
parameter is declared as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 3f813ea5210a..a5daad973ce5 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -403,7 +403,7 @@ static struct regulator_config acp_da7219_cfg = {
 static struct regulator_ops acp_da7219_ops = {
 };
 
-static struct regulator_desc acp_da7219_desc = {
+static const struct regulator_desc acp_da7219_desc = {
 	.name = "reg-fixed-1.8V",
 	.type = REGULATOR_VOLTAGE,
 	.owner = THIS_MODULE,
-- 
2.19.0.rc2

