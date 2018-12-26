Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7433BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9A721720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Hw8NnDZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbeLZBqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:46:04 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:53412 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLZBqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 20:46:03 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 82FCBACA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 01:46:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kr94WIu9xrlv for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 19:46:02 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4B80DABF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:46:02 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id r7so2062484iom.22
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 17:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zH4wbm0A0HpmKIDW63FpRxBngcFc0Vh0IGDM4zQOJOk=;
        b=Hw8NnDZ9LxB9SgVVOPJj5+bu+425Pp8QsAbKPY4jBAkzLMT+0EnujnNcRSgFuWfMw4
         8zE8K9IqFjvhgyzJAakWti8W+qXz5te5bYvRs86VBBuUinbKRystgkXnGZVPykOwETdg
         XF4vNikXKp1HHPLSqqCnKgb+B7bEFPWJhiu1aFcnZbBl4smJg2cOJOtDXdXIUWAacw9j
         h5dEU5B8H5MKNKyW/Z/0xa6QH2J58GUw6BfF2jN7TBvE5T5b0oBIReeJD+sk3vhjsQZu
         cKelcxvqZBE5ZENwBv597hR/m5O8KdMoDFT09u9APRmhefjuMd71oNyXa3CeC1HFZDvZ
         gUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zH4wbm0A0HpmKIDW63FpRxBngcFc0Vh0IGDM4zQOJOk=;
        b=ilWDn/dhOheaiDTQrCPAkk8o0rdpOG1mvd6E4MIyLqsCZT7rTEWL2HZjg9Df+STqAb
         rni/IXljM9txQgofbEIgWArH7xLmxRtzQneCPM1zwjGB0yM3I2w0P40xVRC/3NI/aSN1
         ppbABruASKX18B8U6AMsO63/B7svWGujap26c8Nd+hHmcUEta8VaTwA3DB+MrVVEC25f
         EIwzhkjw4Etf0zklX8mvAXL5yxFBTIV8EVWK+Soz1RwZL0q/qTfSr7YLk9kFAoel24WY
         0f2o4MX3Vz/0H8Kn+qjNzH+SeYm5v2bO2VDzG4tswH/A+masmvH8wYfN1glzWo3edhos
         kP2w==
X-Gm-Message-State: AJcUukd2KQfuEW9uOPkvurm/c7eLGRTTw0kciKdnErYEfu7tgvCWL09D
        mdHRb33lW0ReGVe5oWLHPgEo1trXWFryY9TcFHB4NeSFzcO5/tF5C+5jHSxycn73qu2rPoFSGz3
        pTJ2iiyObRm8mTC9jmvDJ0+9tQTOy
X-Received: by 2002:a6b:b90a:: with SMTP id j10mr11861955iof.172.1545788761937;
        Tue, 25 Dec 2018 17:46:01 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6LzlBSws3nT+Wr3xloQiqKpm0xx9RMoxukkK5ov7+m220P+kmR+ThWxznfsAH307RfjbqLFg==
X-Received: by 2002:a6b:b90a:: with SMTP id j10mr11861949iof.172.1545788761732;
        Tue, 25 Dec 2018 17:46:01 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id f10sm11266998itf.41.2018.12.25.17.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 17:46:01 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sound: sb: fix a missing check of snd_ctl_add
Date:   Tue, 25 Dec 2018 19:45:32 -0600
Message-Id: <20181226014534.71083-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_ctl_add() could fail, so let's check its return value and return its
error code upstream upon failure.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/isa/sb/sb16_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 37e6ce7b0b13..c9b25dc1f78e 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -879,8 +879,14 @@ int snd_sb16dsp_pcm(struct snd_sb *chip, int device)
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_sb16_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_sb16_capture_ops);
 
-	if (chip->dma16 >= 0 && chip->dma8 != chip->dma16)
-		snd_ctl_add(card, snd_ctl_new1(&snd_sb16_dma_control, chip));
+	if (chip->dma16 >= 0 && chip->dma8 != chip->dma16) {
+		err =
+			snd_ctl_add(card,
+					snd_ctl_new1(&snd_sb16_dma_control,
+						chip));
+		if (err < 0)
+			return err;
+	}
 	else
 		pcm->info_flags = SNDRV_PCM_INFO_HALF_DUPLEX;
 
-- 
2.17.2 (Apple Git-113)

