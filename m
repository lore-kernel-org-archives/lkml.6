Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4284CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0892D21774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0892D21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeHUJkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:40:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54624 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeHUJkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:40:45 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4B2D29D7;
        Tue, 21 Aug 2018 06:21:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.18 10/35] ALSA: dice: fix wrong copy to rx parameters for Alesis iO26
Date:   Tue, 21 Aug 2018 08:20:36 +0200
Message-Id: <20180821055020.434892298@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055019.954904905@linuxfoundation.org>
References: <20180821055019.954904905@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 627661ced8246c8e833f3bc3817070e934cd79ba upstream.

A commit 28b208f600a3 ('ALSA: dice: add parameters of stream formats for
models produced by Alesis') adds wrong copy to rx parameters instead of
tx parameters for Alesis iO26.

This commit fixes the bug for v4.18-rc8.

Fixes: 28b208f600a3 ('ALSA: dice: add parameters of stream formats for models produced by Alesis')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: <stable@vger.kernel.org> # v4.18
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/dice/dice-alesis.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/firewire/dice/dice-alesis.c
+++ b/sound/firewire/dice/dice-alesis.c
@@ -37,7 +37,7 @@ int snd_dice_detect_alesis_formats(struc
 				MAX_STREAMS * SND_DICE_RATE_MODE_COUNT *
 				sizeof(unsigned int));
 	} else {
-		memcpy(dice->rx_pcm_chs, alesis_io26_tx_pcm_chs,
+		memcpy(dice->tx_pcm_chs, alesis_io26_tx_pcm_chs,
 				MAX_STREAMS * SND_DICE_RATE_MODE_COUNT *
 				sizeof(unsigned int));
 	}


