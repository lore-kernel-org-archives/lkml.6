Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A569AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BC020878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BC020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeJBQj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:39:28 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.252]:19369 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbeJBQj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:39:28 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 62B272D1F5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 04:57:01 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7HPzgIKcXaSey7HQCgftgr; Tue, 02 Oct 2018 04:57:00 -0500
X-Authority-Reason: nr=8
Received: from 174.206.93.92.rev.sfr.net ([92.93.206.174]:47740 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g7HPz-000WhA-2i; Tue, 02 Oct 2018 04:56:39 -0500
Date:   Tue, 2 Oct 2018 11:56:36 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: sb8: Fix fall-through annotations
Message-ID: <20181002095636.GA29253@embeddedor.com>
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
X-Source-IP: 92.93.206.174
X-Source-L: No
X-Exim-ID: 1g7HPz-000WhA-2i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 174.206.93.92.rev.sfr.net (embeddedor) [92.93.206.174]:47740
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "fallthru" with a proper "fall through" annotation.

This fix is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/isa/sb/sb8_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index 4817977..8288fae 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -130,13 +130,13 @@ static int snd_sb8_playback_prepare(struct snd_pcm_substream *substream)
 			chip->playback_format = SB_DSP_HI_OUTPUT_AUTO;
 			break;
 		}
-		/* fallthru */
+		/* fall through */
 	case SB_HW_201:
 		if (rate > 23000) {
 			chip->playback_format = SB_DSP_HI_OUTPUT_AUTO;
 			break;
 		}
-		/* fallthru */
+		/* fall through */
 	case SB_HW_20:
 		chip->playback_format = SB_DSP_LO_OUTPUT_AUTO;
 		break;
@@ -287,7 +287,7 @@ static int snd_sb8_capture_prepare(struct snd_pcm_substream *substream)
 			chip->capture_format = SB_DSP_HI_INPUT_AUTO;
 			break;
 		}
-		/* fallthru */
+		/* fall through */
 	case SB_HW_20:
 		chip->capture_format = SB_DSP_LO_INPUT_AUTO;
 		break;
@@ -387,7 +387,7 @@ irqreturn_t snd_sb8dsp_interrupt(struct snd_sb *chip)
 	case SB_MODE_PLAYBACK_16:	/* ok.. playback is active */
 		if (chip->hardware != SB_HW_JAZZ16)
 			break;
-		/* fallthru */
+		/* fall through */
 	case SB_MODE_PLAYBACK_8:
 		substream = chip->playback_substream;
 		if (chip->playback_format == SB_DSP_OUTPUT)
@@ -397,7 +397,7 @@ irqreturn_t snd_sb8dsp_interrupt(struct snd_sb *chip)
 	case SB_MODE_CAPTURE_16:
 		if (chip->hardware != SB_HW_JAZZ16)
 			break;
-		/* fallthru */
+		/* fall through */
 	case SB_MODE_CAPTURE_8:
 		substream = chip->capture_substream;
 		if (chip->capture_format == SB_DSP_INPUT)
-- 
2.7.4

