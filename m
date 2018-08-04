Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1C6C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 20:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D608217D1
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 20:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D608217D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbeHDWN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 18:13:59 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.210]:28945 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728484AbeHDWN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 18:13:58 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 5019F2CB0A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Aug 2018 15:12:10 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id m2uIfgy4iBcCXm2uIfHoC3; Sat, 04 Aug 2018 15:12:10 -0500
X-Authority-Reason: nr=8
Received: from [189.250.50.82] (port=60170 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fm2uH-002BdX-Qd; Sat, 04 Aug 2018 15:12:09 -0500
Date:   Sat, 4 Aug 2018 15:12:09 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: emu10k1: Mark expected switch fall-throughs
Message-ID: <20180804201209.GA26701@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.50.82
X-Source-L: No
X-Exim-ID: 1fm2uH-002BdX-Qd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.50.82]:60170
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case, I replaced the code comment with
a proper "fall through" annotation, which is what GCC is expecting
to find.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/pci/emu10k1/emupcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 26f6eda..9f2b609 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -778,7 +778,7 @@ static int snd_emu10k1_playback_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_START:
 		snd_emu10k1_playback_invalidate_cache(emu, 1, epcm->extra);	/* do we need this? */
 		snd_emu10k1_playback_invalidate_cache(emu, 0, epcm->voices[0]);
-		/* follow thru */
+		/* fall through */
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		if (cmd == SNDRV_PCM_TRIGGER_PAUSE_RELEASE)
@@ -928,7 +928,7 @@ static int snd_emu10k1_efx_playback_trigger(struct snd_pcm_substream *substream,
 		}
 		snd_emu10k1_playback_invalidate_cache(emu, 1, epcm->extra);
 
-		/* follow thru */
+		/* fall through */
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		snd_emu10k1_playback_prepare_voice(emu, epcm->extra, 1, 1, NULL);
-- 
2.7.4

