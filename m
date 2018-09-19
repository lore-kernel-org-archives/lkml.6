Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA2AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4A8214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2+YqoEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4A8214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbeITD1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:27:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41751 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732479AbeITD1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:27:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so6442997ljy.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 14:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0pnysa9LYWXiv/lmq/UpOIIIkfxL8NfCriv/Ioaklc0=;
        b=c2+YqoEv2NoW0MgpTxXS5N3bFIZCFhN8ys3y/wx0vGGOJywa9+hfi2ZNQPwpQCFqQV
         4SumWkL505nlnZGsD7K+LpsvaXqrPrpGDtAUW1kXmd3aidCusws6iYHdyFLvU9sL4fPB
         pPftct4RyJjgnwjVNSM2sehvFB/r5hpnKnnXljA8Pm02nKD8MI4ZX3DmulGLLnDKcNLL
         go7edukPDOfH7CGbkiQZ4y3+hU2+KoFDiwxTR/SA8o9iqBaTgdtts9KzLvFLZmxyieod
         0ksU/s1ROajZrIJjHqo1L0FNixA9n4xlBiryqWZL++TFe8y92yRHkVITL1e7WZNsHME0
         vBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0pnysa9LYWXiv/lmq/UpOIIIkfxL8NfCriv/Ioaklc0=;
        b=jnDCDdwHKQHqsgkoFXkRJVfWM+2arkD4J3KPrOlnVAFHzvihGSrZGQM78tN2Op9i/d
         OisP41VN6KWvJ6q4QbYiG+KmjkX7Vkc3k9UYml4MCv8s9tubFti/pFJ5Pv8ITDa+Cz2t
         ItfbOfBoU83o4sUo5/5PnUCpeRci2OTJ7woTg5UbNi6f+vLiv2SVt9qD5FG1BF5ohKpd
         Yzi2dgeBFUh3gOGLYtbcbscqDJIjmJCH76BsYqd4bPWA9qmEdbFMyNx29if6JPEjjXnw
         QrR+SnwgXhM4DobIm3FNsdQNm2V/T2ETnHENtH53T0hpCCIOA2RamnVw0/uDNb8eow9t
         8JAQ==
X-Gm-Message-State: APzg51BD3iAyJJdTxkQr5yYH5eKVGb6h92BOBot+Cg+CDbnuO+Oojf77
        UChM/khBvjSAyept2+ppMBE=
X-Google-Smtp-Source: ANB0VdZxhwN9IT4vL+78jMm07s9Tg5URZtSWydG2lvzRDgOXweyeTeuHYlBzVmPMPfkuz6eDxWzeGQ==
X-Received: by 2002:a2e:144c:: with SMTP id 12-v6mr24528775lju.122.1537393649159;
        Wed, 19 Sep 2018 14:47:29 -0700 (PDT)
Received: from nick (retailing-exile.volia.net. [93.72.35.76])
        by smtp.gmail.com with ESMTPSA id f66-v6sm4234390lji.23.2018.09.19.14.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 14:47:28 -0700 (PDT)
Date:   Thu, 20 Sep 2018 00:47:10 +0300
From:   Nick Simonov <nicksimonovv@gmail.com>
To:     oleksandr_andrushchenko@epam.com
Cc:     tiwai@suse.com, xen-devel@lists.xenproject.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        nicksimonovv@gmail.com
Subject: [PATCH] ALSA: xen-front: Refine indentations and constify snd_pcm_ops
Message-ID: <20180919214710.GA6907@nick>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_pcm_ops are not supposed to change. So mark the
non-const structs as const. Also, refine indentation
to ncrease readability.

Signed-off-by: Nick Simonov <nicksimonovv@gmail.com>
---
 sound/xen/xen_snd_front_alsa.c | 46 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
index 129180e..2cbd967 100644
--- a/sound/xen/xen_snd_front_alsa.c
+++ b/sound/xen/xen_snd_front_alsa.c
@@ -637,31 +637,31 @@ static int alsa_pb_fill_silence(struct snd_pcm_substream *substream,
  * to know when the buffer can be transferred to the backend.
  */
 
-static struct snd_pcm_ops snd_drv_alsa_playback_ops = {
-	.open = alsa_open,
-	.close = alsa_close,
-	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = alsa_hw_params,
-	.hw_free = alsa_hw_free,
-	.prepare = alsa_prepare,
-	.trigger = alsa_trigger,
-	.pointer = alsa_pointer,
-	.copy_user = alsa_pb_copy_user,
-	.copy_kernel = alsa_pb_copy_kernel,
-	.fill_silence = alsa_pb_fill_silence,
+static const struct snd_pcm_ops snd_drv_alsa_playback_ops = {
+	.open		= alsa_open,
+	.close		= alsa_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= alsa_hw_params,
+	.hw_free	= alsa_hw_free,
+	.prepare	= alsa_prepare,
+	.trigger	= alsa_trigger,
+	.pointer	= alsa_pointer,
+	.copy_user	= alsa_pb_copy_user,
+	.copy_kernel	= alsa_pb_copy_kernel,
+	.fill_silence	= alsa_pb_fill_silence,
 };
 
-static struct snd_pcm_ops snd_drv_alsa_capture_ops = {
-	.open = alsa_open,
-	.close = alsa_close,
-	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = alsa_hw_params,
-	.hw_free = alsa_hw_free,
-	.prepare = alsa_prepare,
-	.trigger = alsa_trigger,
-	.pointer = alsa_pointer,
-	.copy_user = alsa_cap_copy_user,
-	.copy_kernel = alsa_cap_copy_kernel,
+static const struct snd_pcm_ops snd_drv_alsa_capture_ops = {
+	.open		= alsa_open,
+	.close		= alsa_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= alsa_hw_params,
+	.hw_free	= alsa_hw_free,
+	.prepare	= alsa_prepare,
+	.trigger	= alsa_trigger,
+	.pointer	= alsa_pointer,
+	.copy_user	= alsa_cap_copy_user,
+	.copy_kernel	= alsa_cap_copy_kernel,
 };
 
 static int new_pcm_instance(struct xen_snd_front_card_info *card_info,
-- 
2.7.4

