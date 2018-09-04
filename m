Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501A4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C0620645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C0620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeIDU0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:26:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:51018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbeIDUYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3DDECB0A8;
        Tue,  4 Sep 2018 15:59:02 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/29] staging: bcm2835-audio: Drop useless NULL check
Date:   Tue,  4 Sep 2018 17:58:42 +0200
Message-Id: <20180904155858.8001-14-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alsa_stream->chip can be never NULL.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index c935c6e99633..13c61af4e723 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -188,8 +188,7 @@ static int snd_bcm2835_playback_close(struct snd_pcm_substream *substream)
 	alsa_stream->buffer_size = 0;
 
 	bcm2835_audio_close(alsa_stream);
-	if (alsa_stream->chip)
-		alsa_stream->chip->alsa_stream[alsa_stream->idx] = NULL;
+	alsa_stream->chip->alsa_stream[alsa_stream->idx] = NULL;
 	/*
 	 * Do not free up alsa_stream here, it will be freed up by
 	 * runtime->private_free callback we registered in *_open above
-- 
2.18.0

