Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BCFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923B220659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="o4qZf6OO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923B220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeIEQPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:15:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57478 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeIEQPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NcZdCnfeepk/5o+H4+Fen5etYaqC3d6ZhiNiool0VmE=; b=o4qZf6OOTdOl
        cgFFaJ8ab0GiHKaP7Ff3LuWNWzC2Gt21vWd3Q6wk1TIL+dLNXNjc2kXkPpSEsKrTSgn+xnMuFZiur
        rsn2sOmZ9dwaScHKXWHZm80WQkWiQ4KFZbHDlVgKNB3x4aqAHEnlfhquzdoNxwwr/34nQhV5yNinq
        MpqoY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxWFq-0002Cn-O6; Wed, 05 Sep 2018 11:45:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7DF3411229D0; Wed,  5 Sep 2018 12:45:50 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: change status to orphan" to the asoc tree
In-Reply-To:  <20180905083137.23153-1-suzuki.katsuhiro@socionext.com>
Message-Id: <20180905114550.7DF3411229D0@debutante.sirena.org.uk>
Date:   Wed,  5 Sep 2018 12:45:50 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: change status to orphan

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

From ae45893f74c72e632cbad882509f12558db2e4f3 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Wed, 5 Sep 2018 17:31:37 +0900
Subject: [PATCH] ASoC: uniphier: change status to orphan

Since I'm leaving from Socionext, I'll unable to access specification
documents of this hardware (these are not public). So change the
state to orphan until someone will maintain this driver.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc711d23dc83..5ee6b45248e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13159,9 +13159,8 @@ F:	drivers/i2c/busses/i2c-synquacer.c
 F:	Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
 
 SOCIONEXT UNIPHIER SOUND DRIVER
-M:	Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-S:	Maintained
+S:	Orphan
 F:	sound/soc/uniphier/
 
 SOEKRIS NET48XX LED SUPPORT
-- 
2.19.0.rc1

