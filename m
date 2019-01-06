Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D651C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605B12085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="dLqb8SqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbfAFRQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 12:16:12 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:36968 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfAFRQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 12:16:11 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id EF21FB54
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jan 2019 17:16:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q-EfIyemnSYk for <linux-kernel@vger.kernel.org>;
        Sun,  6 Jan 2019 11:16:09 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id BE0BFB90
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jan 2019 11:16:09 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id r65so45899236iod.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 09:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=G831cuWKGqn39aVq/djZERsMInuvXiNimpsVKbJIPFE=;
        b=dLqb8SqT7k11RgmK/hlemMDSIghyTMCW1+boVQ3g5a5X4g47HgyNFaMdX6TRTmhoFN
         grC9dyPdY4zcNX+h850Qi8j9XMWa1/WQizNYKt20Pf0MyL7W7FiFHORn5fbwoc3u7Jfr
         evSWxS3KC40AFAB6XooDWONckaVO3bEmm4/5j2ihRWPDCoECq/Nd/Ndz6N251koWAgQz
         IyKAEkN/tlOLCK9inyN5zHcBvXKkUnPhcJ/W+P57cmQTCBQ5RkXPZICcK7l785ZcZADo
         hed8VRkYAnq431zXF4joqv8GgW8O1Zrp3EJ+Yf0hQ49qHfR5qBaSZd5XKTO1ac1K5Zr3
         96Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G831cuWKGqn39aVq/djZERsMInuvXiNimpsVKbJIPFE=;
        b=OHjousLPqtL8q2fjyrSw0WhYxpMwA0X3zsDKWU+ElKVyjMELENp84s5HJY/uVyzMSO
         irKM8bLKzBz35s15GTlcMrsPnlMMLcVrpXqu+m6I9I2ElMCuZ5Tti0zLYwzL3mOeltCq
         9Bh+8E/Y/WQDppzthoF7u8NyuQlAwCBGl87wargsBmNq0qU6VD2oG4N7hJ3aYxvZ7aQp
         uT+D+hVGTIRSAXXt8I38GJCAY8SsQNjDInRa6jknChxjnkQ/NppO1fNjGt9UPZEUF9qo
         PvEZ5oV2pQHSf3ZT9PuUa/3BQrtA8vrYIQ++ezkE9a90Be0yg4BDT90XDYzZalnDb8+c
         b67w==
X-Gm-Message-State: AJcUukdmLxQTiFvFt5spLFxs4m0ks8IyffzLSjNr5RgWMq7BmnGMDmad
        cejg+arEIsUPoatCJzYeGHTUxV3XWc/UCnxpEsTGAjS/U4T3N/rj9Dvs1So2ddPURLsVIdZbRU4
        JRqoGe8i0BBpZ/hOCjnpRdwktV1Wb
X-Received: by 2002:a6b:2c92:: with SMTP id s140mr40142967ios.218.1546794969397;
        Sun, 06 Jan 2019 09:16:09 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7Afwi/zSJz8HRuW8FVqwhutCFbkXPPIMobyniJay9mGWlt3CD6nVGhS+stEzoisJNpEoXd/w==
X-Received: by 2002:a6b:2c92:: with SMTP id s140mr40142959ios.218.1546794969179;
        Sun, 06 Jan 2019 09:16:09 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id b140sm3251551itc.4.2019.01.06.09.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 09:16:08 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ALSA: isa: fix a missing check of snd_ctl_add
Date:   Sun,  6 Jan 2019 11:16:00 -0600
Message-Id: <20190106171601.10506-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_ctl_add() could fail, so let's check its return value and return its
error code upstream upon failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 sound/isa/sb/sb16_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 37e6ce7b0b13..981d65d122b6 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -879,10 +879,14 @@ int snd_sb16dsp_pcm(struct snd_sb *chip, int device)
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_sb16_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_sb16_capture_ops);
 
-	if (chip->dma16 >= 0 && chip->dma8 != chip->dma16)
-		snd_ctl_add(card, snd_ctl_new1(&snd_sb16_dma_control, chip));
-	else
+	if (chip->dma16 >= 0 && chip->dma8 != chip->dma16) {
+		err = snd_ctl_add(card, snd_ctl_new1(
+					&snd_sb16_dma_control, chip));
+		if (err)
+			return err;
+	} else {
 		pcm->info_flags = SNDRV_PCM_INFO_HALF_DUPLEX;
+	}
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_isa_data(),
-- 
2.17.1

