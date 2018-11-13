Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B1DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2315822507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zsABFDU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2315822507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbeKMLEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:04:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeKMLEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:04:24 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FA1D22419;
        Tue, 13 Nov 2018 01:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542071322;
        bh=RUmrhzkPUD+5BpJE4LSEpqT9TB+S4r45UM4CYfdibmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zsABFDU5ZuV44Rbc5uZylKyAGTAcgJhGaItWuvulmE1ixHE/3Sd/Yp2b2W67JCzAh
         XxV/aZDAZqgfXHoU7NHzUk4WWfBywpG21m60Rzm+Jy194SpEqMkvNwh1nqtiY7vlJj
         fWaLfaj5aukOOlhZLa6yyrUpvAAzkThd8iCVI1VQ=
Date:   Mon, 12 Nov 2018 17:08:42 -0800
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Arnold Chand <arnold.chand@gmail.com>
Cc:     "eric@anholt.net" <eric@anholt.net>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: bcm2835-audio: Fixed warnings,
 checks
Message-ID: <20181113010842.GA20883@kroah.com>
References: <7fb7b1418c55eb09d26e5a48ffe471612183b9f5.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fb7b1418c55eb09d26e5a48ffe471612183b9f5.camel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 07:29:09PM -0500, Arnold Chand wrote:
> Corrected warnings and checks issued by scripts/checkpatch.pl which includes:
> alignment of
> parenthesis, lines over 80 characters and mutex definition without comment.
> Signed-off-by: Arnold Chand <arnold.chand@gmail.com>---
> .../vc04_services/bcm2835-audio/bcm2835-ctl.c | 18 +++---
> .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 25 ++++---- .../bcm2835-
> audio/bcm2835-vchiq.c             | 59 ++++++++++---------
> .../vc04_services/bcm2835-audio/bcm2835.h     |  4 +- 4 files changed, 56
> insertions(+), 50 deletions(-)
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.cindex
> a6ec72a5f0be..04df4e7a1d24 100644--- a/drivers/staging/vc04_services/bcm2835-
> audio/bcm2835-ctl.c+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-
> ctl.c@@ -68,7 +68,7 @@ static int snd_bcm2835_ctl_get(struct snd_kcontrol
> *kcontrol, }  static int snd_bcm2835_ctl_put(struct snd_kcontrol *kcontrol,-	
> 			struct snd_ctl_elem_value *ucontrol)+			
>        struct snd_ctl_elem_value *ucontrol) { 	struct bcm2835_chip *chip =
> snd_kcontrol_chip(kcontrol); 	int val, *valp;@@ -101,7 +101,8 @@ static const
> struct snd_kcontrol_new snd_bcm2835_ctl[] = { 	{ 		.iface =
> SNDRV_CTL_ELEM_IFACE_MIXER, 		.name = "PCM Playback Volume",-		
> .access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,+	
> 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |+			  SNDRV
> _CTL_ELEM_ACCESS_TLV_READ, 		.private_value = PCM_PLAYBACK_VOLUME, 	
> 	.info = snd_bcm2835_ctl_info, 		.get = snd_bcm2835_ctl_get,@@
> -129,7 +130,7 @@ static const struct snd_kcontrol_new snd_bcm2835_ctl[] = {
> };  static int snd_bcm2835_spdif_default_info(struct snd_kcontrol *kcontrol,-	
> struct snd_ctl_elem_info *uinfo)+					  struc
> t snd_ctl_elem_info *uinfo) { 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958; 	
> uinfo->count = 1;@@ -137,7 +138,7 @@ static int
> snd_bcm2835_spdif_default_info(struct snd_kcontrol *kcontrol, }  static int
> snd_bcm2835_spdif_default_get(struct snd_kcontrol *kcontrol,-	struct
> snd_ctl_elem_value *ucontrol)+					 struct
> snd_ctl_elem_value *ucontrol) { 	struct bcm2835_chip *chip =
> snd_kcontrol_chip(kcontrol); 	int i;@@ -153,7 +154,7 @@ static int
> snd_bcm2835_spdif_default_get(struct snd_kcontrol *kcontrol, }  static int
> snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol,-	struct
> snd_ctl_elem_value *ucontrol)+					 struct
> snd_ctl_elem_value *ucontrol) { 	struct bcm2835_chip *chip =
> snd_kcontrol_chip(kcontrol); 	unsigned int val = 0;@@ -162,7 +163,8 @@ static
> int snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol, 	mutex_l
> ock(&chip->audio_mutex);  	for (i = 0; i < 4; i++)-		val |=
> (unsigned int)ucontrol->value.iec958.status[i] << (i * 8);+		val |=
> (unsigned int)ucontrol->value.iec958.status[i] <<+		       (i *
> 8);  	change = val != chip->spdif_status; 	chip->spdif_status = val;@@
> -172,7 +174,7 @@ static int snd_bcm2835_spdif_default_put(struct snd_kcontrol
> *kcontrol, }  static int snd_bcm2835_spdif_mask_info(struct snd_kcontrol
> *kcontrol,-	struct snd_ctl_elem_info *uinfo)+				
>        struct snd_ctl_elem_info *uinfo) { 	uinfo->type =
> SNDRV_CTL_ELEM_TYPE_IEC958; 	uinfo->count = 1;@@ -180,7 +182,7 @@ static int
> snd_bcm2835_spdif_mask_info(struct snd_kcontrol *kcontrol, }  static int
> snd_bcm2835_spdif_mask_get(struct snd_kcontrol *kcontrol,-	struct
> snd_ctl_elem_value *ucontrol)+				      struct
> snd_ctl_elem_value *ucontrol) { 	/* 	 * bcm2835 supports only
> consumer mode and sets all other format flagsdiff --git
> a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.cindex
> e66da11af5cf..68766e57f6e2 100644--- a/drivers/staging/vc04_services/bcm2835-
> audio/bcm2835-pcm.c+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-
> pcm.c@@ -81,17 +81,17 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream
> *alsa_stream, }  /* open callback */-static int

<snip>

Something went really wrong with your email client here :(
