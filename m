Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1922CC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D4B26CC4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="SuUU1Iv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D4B26CC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbeFZPDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:03:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37356 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeFZPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=f/V/2metfeRPCwwAB8zId3CU3ZEdLIRYYeOhngxIqco=; b=SuUU1Iv7VEq9
        sk5h38Mnl4JUuK808v+mwbXD0D0VrpoX7jGRQ9wTd45NjXk/4QD3MMisDaKyeUUZuV63kN3ZeFkDm
        2zEqAvf01nTuJWKMxWbeKBwsmautyedaZX22Xzxm1v543fh5oWHLmnNxfZsoJlU8FsZMsxoq3zKFs
        SKmtE=;
Received: from host109-146-194-33.range109-146.btcentralplus.com ([109.146.194.33] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXpVO-0001Is-IF; Tue, 26 Jun 2018 15:03:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 127D1440070; Tue, 26 Jun 2018 16:03:42 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: trace: remove snd_soc_codec" to the asoc tree
In-Reply-To:  <87vadh3pz1.wl%kuninori.morimoto.gx@renesas.com>
Message-Id: <20180626150342.127D1440070@finisterre.ee.mobilebroadband>
Date:   Tue, 26 Jun 2018 16:03:42 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: trace: remove snd_soc_codec

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

From 211b4415ecb254e167837206756dea123342689c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 28 Mar 2018 02:18:13 +0000
Subject: [PATCH] ASoC: trace: remove snd_soc_codec

snd_soc_codec is replaced to snd_soc_component,
and it is not used in this file.
Let's remove it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/trace/events/asoc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index ccd1a3bdff46..40c300fe704d 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -12,7 +12,6 @@
 #define DAPM_ARROW(dir) (((dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-")
 
 struct snd_soc_jack;
-struct snd_soc_codec;
 struct snd_soc_card;
 struct snd_soc_dapm_widget;
 struct snd_soc_dapm_path;
-- 
2.17.1

