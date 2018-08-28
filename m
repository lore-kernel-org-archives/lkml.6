Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAB1C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A942087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.tech header.i=@birdec.tech header.b="nQfktLIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A942087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birdec.tech
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeH2Bfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:35:50 -0400
Received: from host.euro-space.net ([87.117.239.2]:42720 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH2Bfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.tech
        ; s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a2yC7/xN5e6r2EKsm4v+K36IC7YFL66cp1N1jflwIj8=; b=nQfktLIu2+w3XWtBEaVP0HVtKr
        CMrFVh+CWoUXlNTxzuPP5LhX8W28T3caApWyG0mvuphRBLRxCCMt3o5aiC8F4Y6pjTWbcs8I3QwZb
        lZSzAOY72W1Kgw38tQhcw6cuXF8BZBOBM64sLtr9uhRbYFND/jMExCvsR9wA7hRE5mgUVG63U3FTi
        cVWxwpHzZGo40X6kd3M/5n04Evdetx8pwAqnw082+cIwea6JoKGmvLh3LXYMTLejOyqF8L5F7yYmT
        UkXRs7s+mBGFDl9L5qpaGbICsbtZNLPIkw5FYNSMxcY+LB3W1K0WSG8cGJ2wlBWjvX9vR+ockSZ/0
        Oux0Amfw==;
Received: from x55b35620.dyn.telefonica.de ([85.179.86.32]:36818 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <kmarinushkin@birdec.tech>)
        id 1fulkZ-00052G-Ib; Tue, 28 Aug 2018 22:42:11 +0100
From:   Kirill Marinushkin <kmarinushkin@birdec.tech>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        M R Swami Reddy <mr.swami.reddy@ti.com>,
        Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH 2/2] ASoC: pcm3060: Improve legibility of if-statements
Date:   Tue, 28 Aug 2018 23:42:31 +0200
Message-Id: <20180828214231.10164-2-kmarinushkin@birdec.tech>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180828214231.10164-1-kmarinushkin@birdec.tech>
References: <20180828194045.GQ2414@sirena.org.uk>
 <20180828214231.10164-1-kmarinushkin@birdec.tech>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.tech
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.tech
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.tech
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modified some if-statements to make them more clear

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/codecs/pcm3060.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 5b9718fa766d..494d9d662be8 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -68,7 +68,10 @@ static int pcm3060_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	reg = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG67 : PCM3060_REG72);
+	if (dai->id == PCM3060_DAI_ID_DAC)
+		reg = PCM3060_REG67;
+	else
+		reg = PCM3060_REG72;
 
 	regmap_update_bits(priv->regmap, reg, PCM3060_REG_MASK_FMT, val);
 
@@ -124,7 +127,10 @@ static int pcm3060_hw_params(struct snd_pcm_substream *substream,
 	}
 
 val_ready:
-	reg = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG67 : PCM3060_REG72);
+	if (dai->id == PCM3060_DAI_ID_DAC)
+		reg = PCM3060_REG67;
+	else
+		reg = PCM3060_REG72;
 
 	regmap_update_bits(priv->regmap, reg, PCM3060_REG_MASK_MS, val);
 
-- 
2.13.6

