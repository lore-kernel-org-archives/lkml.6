Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F240223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmzVA1YB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F240223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbeKNDH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:07:56 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55685 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeKNDH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:07:56 -0500
Received: by mail-it1-f194.google.com with SMTP id o19so10178065itg.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 09:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=rkRU1drvR1a2TlJZVMfx6wXvS/lJWOZcIH1FRRvC0OM=;
        b=XmzVA1YBcA2rLLfor4Tv7Auf1X2DEL4U4Jvkl2OghePFYBXUYVKduu5o1KTDVTD8Yw
         U6C/pDD87M7fsyrEaX29iDcTT8gUSLZutJQJUWV6OZOwKzP0GgkJBD7bApfs2euLBZ1U
         yiMV56WQWV/L72bubKqGckxDq8040DwhE8hAZjdTtg2h9B3FiODmuCG6CgrAJAP189Lj
         3MkJeM5GjVL+HOdOqtdnCNPUakMOAjelvQax1R2gM9u/7BP6IDUzybWI+6tezWfkYBYr
         DQ6v6naEkmUdQDUvMmSEENK3LETNwulyEDnZW7PNM0cPxNiUjhjfih3EOu/3yU06rjuq
         5n1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=rkRU1drvR1a2TlJZVMfx6wXvS/lJWOZcIH1FRRvC0OM=;
        b=rmjkGZ6Ad7H/EaMKUSgmAUcucnrvNUGydcTtWbf53tMQIBD/rLwGQMdmjv8ux4tDsD
         atS5wletOBPgY1kKQiuf04Qmyw8/Gw2jBkzbEWg6Y5vSjmkMtNduOyp0gc8Uk/1YIuXw
         8rGUzvJNOSsGorw8dAAJ+nolsqrq/yXoeI1s+A9wKPEJv1Is1xm7te6Ddc4CqS7SYOCi
         efaHQvz3nd7eDXFvCCbPFnJGws61j5MSOAbCkQNE26UGbt/HKwrOBDrjkTFNSDtD7x8S
         LZkf6JpOYG/lDPJJOP9zmCoS9O629dZHOVgylxMDYXSzfEJxWq/ZzUnkcZODcJegdBH4
         vREg==
X-Gm-Message-State: AGRZ1gJ9SS2Ye0voMs0YUImFnBqPrR0eeFT/qiZEKioJzo9EWcuGbclM
        yQwxMARQPN1+8Oaf/cVGL4I=
X-Google-Smtp-Source: AJdET5c0BvqysIZ7ebGnn48MmzuJZJ4G9ousAp4+pTTQrwt9J1u9Dj3wtrjqS5NqFhqkKD0yM3MegA==
X-Received: by 2002:a24:4a10:: with SMTP id k16-v6mr4370959itb.170.1542128937440;
        Tue, 13 Nov 2018 09:08:57 -0800 (PST)
Received: from wireless176-180.wireless.wmich.edu ([35.46.39.157])
        by smtp.gmail.com with ESMTPSA id r9sm1524303iop.8.2018.11.13.09.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 09:08:56 -0800 (PST)
Message-ID: <9e35c529cc004dca71227d34baed976e1eaa3b88.camel@gmail.com>
Subject: [PATCH] staging: vc04_services: bcm2835-audio: bcm2835-ctl.c fixed
 warnings
From:   Arnold Chand <arnold.chand@gmail.com>
To:     "eric@anholt.net" <eric@anholt.net>
Cc:     "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 13 Nov 2018 12:08:55 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed lines over 80 characters by adding braces where control flow
statements are more than one line, aligned parenthesis of function
arguments.

Signed-off-by: Arnold Chand <arnold.chand@gmail.com>
---
 .../vc04_services/bcm2835-audio/bcm2835-ctl.c | 27 +++++++++++--------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
index a6ec72a5f0be..47347ec82572 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
@@ -68,7 +68,7 @@ static int snd_bcm2835_ctl_get(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_bcm2835_ctl_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
 	int val, *valp;
@@ -88,8 +88,10 @@ static int snd_bcm2835_ctl_put(struct snd_kcontrol *kcontrol,
 	if (val != *valp) {
 		*valp = val;
 		changed = 1;
-		if (bcm2835_audio_set_chip_ctls(chip))
-			dev_err(chip->card->dev, "Failed to set ALSA controls..\n");
+		if (bcm2835_audio_set_chip_ctls(chip)) {
+			dev_err(chip->card->dev,
+				"Failed to set ALSA controls..\n");
+		}
 	}
 	mutex_unlock(&chip->audio_mutex);
 	return changed;
@@ -101,7 +103,8 @@ static const struct snd_kcontrol_new snd_bcm2835_ctl[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "PCM Playback Volume",
-		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
 		.private_value = PCM_PLAYBACK_VOLUME,
 		.info = snd_bcm2835_ctl_info,
 		.get = snd_bcm2835_ctl_get,
@@ -129,7 +132,7 @@ static const struct snd_kcontrol_new snd_bcm2835_ctl[] = {
 };
 
 static int snd_bcm2835_spdif_default_info(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
+					  struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
 	uinfo->count = 1;
@@ -137,7 +140,7 @@ static int snd_bcm2835_spdif_default_info(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_bcm2835_spdif_default_get(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					 struct snd_ctl_elem_value *ucontrol)
 {
 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
 	int i;
@@ -153,7 +156,7 @@ static int snd_bcm2835_spdif_default_get(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					 struct snd_ctl_elem_value *ucontrol)
 {
 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
 	unsigned int val = 0;
@@ -161,8 +164,10 @@ static int snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&chip->audio_mutex);
 
-	for (i = 0; i < 4; i++)
-		val |= (unsigned int)ucontrol->value.iec958.status[i] << (i * 8);
+	for (i = 0; i < 4; i++) {
+		val |= (unsigned int)ucontrol->value.iec958.status[i] <<
+		       (i * 8);
+	}
 
 	change = val != chip->spdif_status;
 	chip->spdif_status = val;
@@ -172,7 +177,7 @@ static int snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_bcm2835_spdif_mask_info(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
+				       struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
 	uinfo->count = 1;
@@ -180,7 +185,7 @@ static int snd_bcm2835_spdif_mask_info(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_bcm2835_spdif_mask_get(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+				      struct snd_ctl_elem_value *ucontrol)
 {
 	/*
 	 * bcm2835 supports only consumer mode and sets all other format flags
-- 
2.19.1


