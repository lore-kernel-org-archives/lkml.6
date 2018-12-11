Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8C8C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0AE20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544490959;
	bh=HieifSIcrlHBbcfwdN7B4Cdiama0nh1hL5npdHUHXFA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1VK4Io2rtu7bwquDfF0WSSxr88Dz3PF5esoRTb4xTdCX7D0FcqUvhR+6l30V+hIoP
	 Se43ycLfA6/cMWmARZuaQMwi23m5cCYJqLNKSdcp6dzeCTSelwoEdZreTU4PaY/FIB
	 Eu1bs1kVUJ3gC0Q2g8o5ha30+iJjJ/Al0Of0V2kM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0AE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbeLKBP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:15:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50560 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeLKBP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KDzxnoo9efXOS8nQfeIjn0Aj3VAJZ5uy8uUal97/syU=; b=YHw6aMRC7roN
        Xg8v6L4+wzytAxxvM7Wy11Kb5xsP/Q3SJgyXD/7rMVFC9D8qRNF6aII+YEDCT2t8oju88ojteWTHy
        s5vitxiY3hhuBpvAKYqed7UJBvEhC6/gvfjNs9PYncMvodmwEo85n1yfIKBpDlTNV0g8nRkcSkZUl
        97e9I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWeI-0000KQ-3p; Tue, 11 Dec 2018 01:15:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C4DD111254C7; Tue, 11 Dec 2018 01:15:45 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: simple-card-utils: fix build warning without CONFIG_OF" to the asoc tree
In-Reply-To:  <20181210204640.2407929-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Message-Id: <20181211011545.C4DD111254C7@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 01:15:45 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: simple-card-utils: fix build warning without CONFIG_OF

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

From 2b320e046495e6cf02d1f0b1abf07042ac5635ea Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Dec 2018 21:46:10 +0100
Subject: [PATCH] ASoC: simple-card-utils: fix build warning without CONFIG_OF

When CONFIG_OF is disabled, of_graph_parse_endpoint() does not
initialize 'info', and gcc can see that:

sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_card_parse_graph_dai':
sound/soc/generic/simple-card-utils.c:284:13: error: 'info.port' may be used uninitialized in this function [-Werror=maybe-uninitialized]

It's probably best to check the return code anyway, and that also
takes care of the warning.

Fixes: b6f3fc005a2c ("ASoC: simple-card-utils: fixup asoc_simple_card_get_dai_id() counting")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 6a31d07976b9..17d8aee43835 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -280,7 +280,10 @@ static int asoc_simple_card_get_dai_id(struct device_node *ep)
 	 * Non HDMI sound case, counting port/endpoint on its DT
 	 * is enough. Let's count it.
 	 */
-	of_graph_parse_endpoint(ep, &info);
+	ret = of_graph_parse_endpoint(ep, &info);
+	if (ret)
+		return -ENXIO;
+
 	return info.port;
 }
 
-- 
2.19.0.rc2

