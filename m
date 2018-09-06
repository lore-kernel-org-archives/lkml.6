Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFCCC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E634E206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ZEPLijWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E634E206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeIFPTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:19:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56814 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeIFPTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=V5982hUaztJwQr3P+zQusvupYIhXro85ite54Jn+TmE=; b=ZEPLijWoDUY7
        43I/zP6PICVsuqQhRsHOOQRQ9x0+GxcG2ZcXm3yy2Csi/qXarF7OgC6HMOCSMs1IW7RaU8wrAwL0s
        TKNA+9EdlPELvfmAII/lSKnL4YnH82kR7K7CP3dIlgLDX50mI3zWhzMyITxt/1fOFKk8h98CUmvpD
        wo0wg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxrmS-00048J-4b; Thu, 06 Sep 2018 10:44:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E04351122A1F; Thu,  6 Sep 2018 11:44:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: hdac_hdmi: remove redundant check for !port condition" to the asoc tree
In-Reply-To:  <20180906093901.16682-1-colin.king@canonical.com>
Message-Id: <20180906104455.E04351122A1F@debutante.sirena.org.uk>
Date:   Thu,  6 Sep 2018 11:44:55 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: hdac_hdmi: remove redundant check for !port condition

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

From c24fb71fa4f764f02c17cbf88a969f109794e602 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 6 Sep 2018 10:39:01 +0100
Subject: [PATCH] ASoC: hdac_hdmi: remove redundant check for !port condition

The !port check is redundant as it being performed in the following
check. Remove it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 7b8533abf637..dc6a0dfea050 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1961,9 +1961,6 @@ static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdev, int pcm_idx)
 
 	port = list_first_entry(&pcm->port_list, struct hdac_hdmi_port, head);
 
-	if (!port)
-		return 0;
-
 	if (!port || !port->eld.eld_valid)
 		return 0;
 
-- 
2.19.0.rc1

