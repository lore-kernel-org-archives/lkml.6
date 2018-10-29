Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A87C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26C120827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.tech header.i=@birdec.tech header.b="dhlYM5uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26C120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birdec.tech
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeJ2S5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:57:30 -0400
Received: from host.euro-space.net ([87.117.239.2]:59499 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729625AbeJ2S5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.tech
        ; s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oKfNGpMSV/UW4WwQevm9uvvKiImZyOV4bH+dfSC5qbY=; b=dhlYM5uoIlC2MD46hCQG3pNyB/
        O7Fsag3UBv1pi8A8ey+2zlpJf6ucV3xYlStzoFWizCuJqw5Zlxnpspql4vLO/CaPa9uC4VNBc4koV
        BAp4CzKjkxrGXo76bLdq697I53wQjIJrd4GrgWvkH1ATzbMEw5KuuSW0lugWl/P0se1BbhcSwHyYk
        srsIdom9fgQRqiQ1D9lnWRYRC4QZOvtPm01MemHKftO9o9JzK5t+01rUuIonA7aAm/95GHQicXqud
        EF0EFV2NFZDd2c4qwWmvBW5HSFFTU/a9CahNaCS+Kqr9+5gCPbMG/6Dx7NwKrqhPhF6fmGVaNLIDK
        relBqCqA==;
Received: from x4dbc7335.dyn.telefonica.de ([77.188.115.53]:52812 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <kmarinushkin@birdec.tech>)
        id 1gH3Mv-0007KB-0B; Mon, 29 Oct 2018 08:57:53 +0000
From:   Kirill Marinushkin <kmarinushkin@birdec.tech>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH 2/2] ASoC: pcm3060: Rename output widgets
Date:   Mon, 29 Oct 2018 09:59:13 +0100
Message-Id: <20181029085913.17298-2-kmarinushkin@birdec.tech>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181029085913.17298-1-kmarinushkin@birdec.tech>
References: <20181029085913.17298-1-kmarinushkin@birdec.tech>
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

In the initial commit [1], I added differential outputs of the codec as
separate `+` and `-` widgets:

OUTL+
OUTR+
OUTL-
OUTR-

Later, in the commit [2], I added a control to switch the outputs between
differential and single-ended modes. Having this control, the `+` and `-`
separation in widgets seems for me confusing. There are no functional
benefits in such separation, so I find reasonable to get rid of it:

OUTL
OUTR

The new naming is more friendly for sound cards, and is better aligned with
other codec drivers in kernel.

Renaming outputs now should not be a problem from the backwards-
compatibility perspective, as the driver for PCM3060 is added into the
mainline very recently, and did not yet appear in any releases.

[1] commit 6ee47d4a8dac ("ASoC: pcm3060: Add codec driver")
[2] commit c33260d09337 ("ASoC: pcm3060: Add control for differential
    output")

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 sound/soc/codecs/pcm3060.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index f792ad637ae4..078a3b1fc064 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -207,20 +207,16 @@ static const struct snd_kcontrol_new pcm3060_dapm_controls[] = {
 };
 
 static const struct snd_soc_dapm_widget pcm3060_dapm_widgets[] = {
-	SND_SOC_DAPM_OUTPUT("OUTL+"),
-	SND_SOC_DAPM_OUTPUT("OUTR+"),
-	SND_SOC_DAPM_OUTPUT("OUTL-"),
-	SND_SOC_DAPM_OUTPUT("OUTR-"),
+	SND_SOC_DAPM_OUTPUT("OUTL"),
+	SND_SOC_DAPM_OUTPUT("OUTR"),
 
 	SND_SOC_DAPM_INPUT("INL"),
 	SND_SOC_DAPM_INPUT("INR"),
 };
 
 static const struct snd_soc_dapm_route pcm3060_dapm_map[] = {
-	{ "OUTL+", NULL, "Playback" },
-	{ "OUTR+", NULL, "Playback" },
-	{ "OUTL-", NULL, "Playback" },
-	{ "OUTR-", NULL, "Playback" },
+	{ "OUTL", NULL, "Playback" },
+	{ "OUTR", NULL, "Playback" },
 
 	{ "Capture", NULL, "INL" },
 	{ "Capture", NULL, "INR" },
-- 
2.13.6

