Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C1EC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BBD20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544724679;
	bh=irQx8cWqQ+wsAM9wi9zjQvk5WED1/PzZmEj18yqFQ8U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ngVO1xjohIEsl5YvleyVIRRN9Fwghq2Id/d5uQcrhuXcW3cSsaEuNou6lM+OsxmYX
	 wgnUwpXbN1JNeGkDLrD8uE8feJjE+meuPy0z/Ygf50zEya1racA8eSb0LFLhl+Tp5m
	 s36kSlNDHi0DDz3xIKXEuk1OVc4SxZBSQOgQFH2w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BBD20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeLMSLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:11:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36796 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeLMSLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=d5nEPPG99hGb9NnBzfz1aDvxs86ohilkb71VFmHkFtc=; b=gRJ6T3mS2Ugs
        2QrsVhC5GraQjbi2z3riV7v5YL77UA/YrbeufmzVz/74Oj4gG615hIfWBFklEPTeEaqBPUtnpjm4E
        93dMcBHem9Qot1n8ClHLNFu/2NemQd2hYGjeUuKsoUjvDP9CQgZBCjoMPTBQm+vNbMs3CvHjHGxRM
        1gSLI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXVRt-0002Ow-GE; Thu, 13 Dec 2018 18:11:01 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3188611254D1; Thu, 13 Dec 2018 18:11:01 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: fix do_div warning in spdifin" to the asoc tree
In-Reply-To:  <20181213154428.6070-1-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20181213181101.3188611254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 18:11:01 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: fix do_div warning in spdifin

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

From 165be3c260f88a5f8c55d89458ad1f1d9efd701f Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 13 Dec 2018 16:44:28 +0100
Subject: [PATCH] ASoC: meson: fix do_div warning in spdifin

Even if this spdif input driver is only supposed to be used on 64bits
platform, there is possible problem with 32bits and do_div, as reported
by the kbuild robot. Just fix it.

Fixes: 5ce5658375e6 ("ASoC: meson: add axg spdif input")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-spdifin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-spdifin.c b/sound/soc/meson/axg-spdifin.c
index 09f385a2bbba..01b2035fa841 100644
--- a/sound/soc/meson/axg-spdifin.c
+++ b/sound/soc/meson/axg-spdifin.c
@@ -146,8 +146,8 @@ static void axg_spdifin_write_mode_param(struct regmap *map, int mode,
 					 unsigned int base_reg,
 					 unsigned int width)
 {
-	unsigned int offset = mode, rem;
-	unsigned int reg, shift;
+	uint64_t offset = mode;
+	unsigned int reg, shift, rem;
 
 	rem = do_div(offset, num_per_reg);
 
-- 
2.19.0.rc2

