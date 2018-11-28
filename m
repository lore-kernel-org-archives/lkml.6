Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8AFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A200420989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="G+XbJc7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A200420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeK1X7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:59:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60868 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeK1X7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2HLg8dipmPclwYlwliL5RnAWnxGaksPDkNBLAJj7vZI=; b=G+XbJc7OgZGn
        v58Y0XnTNkll4VpYtHOrTuIc7FuVv7fQ93kxn1J2POCGwn58K5G4elW0+7tA5xKBl9zmwge080XBJ
        /TsNVEgoD4wojVC5+3pynPpmA/XstL0p0T3ecBI2dZvKQWnYkw/XVCbGpPCQ8EN+2sDVpXeLWsZmF
        YXPKU=;
Received: from 92.40.248.202.threembb.co.uk ([92.40.248.202] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRzPE-0005Gn-L9; Wed, 28 Nov 2018 12:57:28 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B3238440078; Wed, 28 Nov 2018 12:57:27 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, jsarha@ti.com, robh+dt@kernel.org,
        misael.lopez@ti.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: davinci-mcasp: Document dismod optional property" to the asoc tree
In-Reply-To:  <20181116134141.17396-4-peter.ujfalusi@ti.com>
Message-Id: <20181128125727.B3238440078@finisterre.ee.mobilebroadband>
Date:   Wed, 28 Nov 2018 12:57:27 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: davinci-mcasp: Document dismod optional property

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

From a3641b30c19b93b1298028a7210b55145e70056c Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 16 Nov 2018 15:41:40 +0200
Subject: [PATCH] ASoC: davinci-mcasp: Document dismod optional property

The dismod property can be used to specify the drive on level of inactive
TX slots.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/davinci-mcasp-audio.txt        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index 46bc9829c71a..b279b6072bd5 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -30,6 +30,11 @@ Optional properties:
 - ti,hwmods : Must be "mcasp<n>", n is controller instance starting 0
 - tx-num-evt : FIFO levels.
 - rx-num-evt : FIFO levels.
+- dismod : Specify the drive on TX pin during inactive slots
+	0 : 3-state
+	2 : logic low
+	3 : logic high
+	Defaults to 'logic low' when the property is not present
 - sram-size-playback : size of sram to be allocated during playback
 - sram-size-capture  : size of sram to be allocated during capture
 - interrupts : Interrupt numbers for McASP
-- 
2.19.1

