Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E49C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691CA223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDevkoGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691CA223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbeKNDGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:06:54 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35714 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbeKNDGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:06:54 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so19561930itj.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 09:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LkXr7dP5VkUFjRS+tlXvL7uauQv+fosphLZXZLLaguI=;
        b=nDevkoGyAxFtTjiZVOjTFvGcvcbCA3HurnjNKK4EE1xv4nNzuOg1ljSgoAkq5YPNO/
         kotJdVjb5s0Z9QDsYty801zs6D9UJ3Mb7QKMzHQk0Yjo0bP4eNFzQmRV+ytHIkcI8dbR
         13eBRfOR78I+o4HuvYXgRg6A7Z/S4dTcuwUnaqnc8jm5XlI2lw9I/z8eydE/nqmuK1sA
         dgY2UOGb3ypTBmrJkxVghr1ZLi2jy/X+d9NrxxR8qs5piBnxTEcp+DNZQvyW8AgPAinD
         URi4U2Dvfg188cy2GvKK5ldHZPZn1eiwbZiY5lDq6ckwb3D2ZSI4tdGUms7+T9ih9mK8
         FKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LkXr7dP5VkUFjRS+tlXvL7uauQv+fosphLZXZLLaguI=;
        b=qK8/QewlWgYECGRi8rLsklhYgCwXLN3an54UhfWKLHxIADoiVk5F1a6m46dC/BeJI+
         ZA+3vU+8spwaCvBt6wR/ekXfkszRWsOSW9HrcOMggpyqpQGp01Sm0RV7PKkf3ctkXMBB
         3GWAM6wwaQJ8VFCxx2rFvwKJzdOjU+1GaqZtVJoWZ1EZ7LmVNmPMF8//dF1314j/eVng
         ta+6FYQiQT3hSX7+/9MK5sV4DLM2N/o7gV6vwMGTrTCtxTEjm8gs/rrDbVj8GZD2p8gb
         JVxmsOJYaTaz+Md0wZEEbyjRDrfkve4mlt/wstNPdd9cVLJxLKPyxy3JqgMPcNjjuYBt
         c6zQ==
X-Gm-Message-State: AGRZ1gLCCSA0W9xlwZUACAnTbOuU52MKhBO02mXTi5Vkwm5W/uT797Qw
        cNvtoYTMDqHuko9Bm5YzXzY=
X-Google-Smtp-Source: AJdET5cg1pp4yAvXoJSaIF3ESSScewDdBD7xPvdfB75VVcftiwUt/NEYXzwDlRtUwIOBbBJUzt/vKw==
X-Received: by 2002:a02:a15e:: with SMTP id m30mr2257147jah.143.1542128875415;
        Tue, 13 Nov 2018 09:07:55 -0800 (PST)
Received: from wireless176-180.wireless.wmich.edu ([35.46.39.157])
        by smtp.gmail.com with ESMTPSA id i201sm624916ioa.1.2018.11.13.09.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 09:07:54 -0800 (PST)
Message-ID: <cd0a084aebba806d5edbeb2b3b42d59f28c44ada.camel@gmail.com>
Subject: Re: [PATCH] staging: vc04_services: bcm2835-audio: Fixed warnings,
 checks
From:   Arnold Chand <arnold.chand@gmail.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "eric@anholt.net" <eric@anholt.net>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Tue, 13 Nov 2018 12:07:53 -0500
In-Reply-To: <20181113010842.GA20883@kroah.com>
References: <7fb7b1418c55eb09d26e5a48ffe471612183b9f5.camel@gmail.com>
         <20181113010842.GA20883@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-12 at 17:08 -0800, gregkh@linuxfoundation.org wrote:
> On Mon, Nov 12, 2018 at 07:29:09PM -0500, Arnold Chand wrote:
> > Corrected warnings and checks issued by scripts/checkpatch.pl which includes:
> > alignment of
> > parenthesis, lines over 80 characters and mutex definition without comment.
> > Signed-off-by: Arnold Chand <arnold.chand@gmail.com>---
> > .../vc04_services/bcm2835-audio/bcm2835-ctl.c | 18 +++---
> > .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 25 ++++---- .../bcm2835-
> > audio/bcm2835-vchiq.c             | 59 ++++++++++---------
> > .../vc04_services/bcm2835-audio/bcm2835.h     |  4 +- 4 files changed, 56
> > insertions(+), 50 deletions(-)
> > diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> > b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.cindex
> > a6ec72a5f0be..04df4e7a1d24 100644--- a/drivers/staging/vc04_services/bcm2835-
> > audio/bcm2835-ctl.c+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-
> > ctl.c@@ -68,7 +68,7 @@ static int snd_bcm2835_ctl_get(struct snd_kcontrol
> > *kcontrol, }  static int snd_bcm2835_ctl_put(struct snd_kcontrol *kcontrol,-	
> > 			struct snd_ctl_elem_value *ucontrol)+			
> >        struct snd_ctl_elem_value *ucontrol) { 	struct bcm2835_chip *chip =
> > snd_kcontrol_chip(kcontrol); 	int val, *valp;@@ -101,7 +101,8 @@ static const
> > struct snd_kcontrol_new snd_bcm2835_ctl[] = { 	{ 		.iface =
> > SNDRV_CTL_ELEM_IFACE_MIXER, 		.name = "PCM Playback Volume",-		
> > .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,+	
> > 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |+			  SNDRV
> > _CTL_ELEM_ACCESS_TLV_READ, 		.private_value = PCM_PLAYBACK_VOLUME, 	
> > 	.info = snd_bcm2835_ctl_info, 		.get = snd_bcm2835_ctl_get,@@
> > -129,7 +130,7 @@ static const struct snd_kcontrol_new snd_bcm2835_ctl[] = {
> > };  static int snd_bcm2835_spdif_default_info(struct snd_kcontrol *kcontrol,-	
> > struct snd_ctl_elem_info *uinfo)+					  struc
> > t snd_ctl_elem_info *uinfo) { 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958; 	
> > uinfo->count = 1;@@ -137,7 +138,7 @@ static int
> > snd_bcm2835_spdif_default_info(struct snd_kcontrol *kcontrol, }  static int
> > snd_bcm2835_spdif_default_get(struct snd_kcontrol *kcontrol,-	struct
> > snd_ctl_elem_value *ucontrol)+					 struct
> > snd_ctl_elem_value *ucontrol) { 	struct bcm2835_chip *chip =
> > snd_kcontrol_chip(kcontrol); 	int i;@@ -153,7 +154,7 @@ static int
> > snd_bcm2835_spdif_default_get(struct snd_kcontrol *kcontrol, }  static int
> > snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol,-	struct
> > snd_ctl_elem_value *ucontrol)+					 struct
> > snd_ctl_elem_value *ucontrol) { 	struct bcm2835_chip *chip =
> > snd_kcontrol_chip(kcontrol); 	unsigned int val = 0;@@ -162,7 +163,8 @@ static
> > int snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol, 	mutex_l
> > ock(&chip->audio_mutex);  	for (i = 0; i < 4; i++)-		val |=
> > (unsigned int)ucontrol->value.iec958.status[i] << (i * 8);+		val |=
> > (unsigned int)ucontrol->value.iec958.status[i] <<+		       (i *
> > 8);  	change = val != chip->spdif_status; 	chip->spdif_status = val;@@
> > -172,7 +174,7 @@ static int snd_bcm2835_spdif_default_put(struct snd_kcontrol
> > *kcontrol, }  static int snd_bcm2835_spdif_mask_info(struct snd_kcontrol
> > *kcontrol,-	struct snd_ctl_elem_info *uinfo)+				
> >        struct snd_ctl_elem_info *uinfo) { 	uinfo->type =
> > SNDRV_CTL_ELEM_TYPE_IEC958; 	uinfo->count = 1;@@ -180,7 +182,7 @@ static int
> > snd_bcm2835_spdif_mask_info(struct snd_kcontrol *kcontrol, }  static int
> > snd_bcm2835_spdif_mask_get(struct snd_kcontrol *kcontrol,-	struct
> > snd_ctl_elem_value *ucontrol)+				      struct
> > snd_ctl_elem_value *ucontrol) { 	/* 	 * bcm2835 supports only
> > consumer mode and sets all other format flagsdiff --git
> > a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> > b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.cindex
> > e66da11af5cf..68766e57f6e2 100644--- a/drivers/staging/vc04_services/bcm2835-
> > audio/bcm2835-pcm.c+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-
> > pcm.c@@ -81,17 +81,17 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream
> > *alsa_stream, }  /* open callback */-static int
> 
> <snip>
> 
> Something went really wrong with your email client here :(

Sorry, still trying to fix the issue with git and gmail. Resending patch separately
but only for one file.

