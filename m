Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ImlqGHwwHltHYgAAmS7hNA
	; Mon, 11 Jun 2018 08:19:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 48972607A4; Mon, 11 Jun 2018 08:19:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh0M6K6a"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CFEDE606FA;
	Mon, 11 Jun 2018 08:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFEDE606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbeFKITG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 04:19:06 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41396 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754044AbeFKITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:19:04 -0400
Received: by mail-pg0-f65.google.com with SMTP id l65-v6so9379172pgl.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zkFyDAD6fZUSG9efrOTfMOXd85JKhz97pALuyqQpjU8=;
        b=mh0M6K6aKTOwojxBoPHJ/x+stBhfGHn9KwErgRPoAaHnhwmudO3636DT08/qsDsaHp
         JORfxs8kVnMIb0ZsNCN+l6jKv3t6uMfODAXxji8FFLIqQfPTYJvHKYpfGbyXQ5gFeNsS
         6YosiTUlcprQeQphgG2CbbqutHYDpeaC1rRl00Al4XlX/XXDgDJw3UNoBEG2+ho0cdKM
         6c268K+/X85/m2KWHvbGVNZtdCL6W3PZsRg0t8bqMoiHyGoMkSK3XESpF3OTljCXjCgY
         vEzQI6pusedlqVSd7NtpmB9cJP77N5BhxMtwbjKekUKD9wLe0a+4tnBU/4hdEpyUyEyy
         16Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zkFyDAD6fZUSG9efrOTfMOXd85JKhz97pALuyqQpjU8=;
        b=j8VI5S4ou/KfPqIOuybaYO8dnDDQ7hHpHomAO+5Iyoo5Tjq3F7quYfEzJKPy6IBtIl
         h7WhpQqgQ6BHRJdczr9fMB4kpyvONQ+rhMASmvfoLID03OWoSPgOMNb5sCmdVXi8p+Mg
         vaTO6ESywio4O14ektyplXwXRq+ne/gQZRt+PUkBv8noptcCvwBbWX0i0MlrWLPdi8MB
         AEl9nq+o857nq51a6yAwuJNFlzQZTgI2qG9v6wOx5jms5r9sSRqwi1n2IvqjiulLRTqz
         Tsj1Dl+V3VvALcHmAz1Cf1V6v7AGmz9jzrL9Y1XjIMTKq+3N0U8ibPoor6+B15KVLno1
         AW1A==
X-Gm-Message-State: APt69E07jXijAdsV/Fpbfr65IM1OM8a4BQ8mmP+roveDCnOyo4RJSxIr
        UganwX51c10HlAZiMXQD5so=
X-Google-Smtp-Source: ADUXVKLV2h9+aAh9fSluCJYQhMDBtz0MCMAHHt/99T/7xaZhUVz81o9sg4lwx1RHF983CieoWmHiYQ==
X-Received: by 2002:a62:4255:: with SMTP id p82-v6mr16556873pfa.227.1528705144299;
        Mon, 11 Jun 2018 01:19:04 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id d9-v6sm70374443pfg.183.2018.06.11.01.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 01:19:03 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: emu10k1: add error handling for snd_ctl_add
Date: Mon, 11 Jun 2018 16:18:40 +0800
Message-Id: <1528705122-34409-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When snd_ctl_add fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling snd_ctl_add.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 sound/pci/emu10k1/emupcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index d39458a..69f9b10 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -1858,7 +1858,9 @@ int snd_emu10k1_pcm_efx(struct snd_emu10k1 *emu, int device)
 	if (!kctl)
 		return -ENOMEM;
 	kctl->id.device = device;
-	snd_ctl_add(emu->card, kctl);
+	err = snd_ctl_add(emu->card, kctl);
+	if (err < 0)
+		return err;
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(emu->pci), 64*1024, 64*1024);
 
-- 
2.7.4
