Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61118C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E222086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E222086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeIHS0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 14:26:53 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35990 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeIHS0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 14:26:52 -0400
Received: from null ([172.19.249.150]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N5lvf-1fmdGq0KqJ-017GEG; Sat, 08
 Sep 2018 15:40:43 +0200
Date:   Sat, 8 Sep 2018 15:40:41 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Message-ID: <1706035173.39231.1536414041437@email.1und1.de>
In-Reply-To: <20180904155858.8001-17-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
 <20180904155858.8001-17-tiwai@suse.de>
Subject: Re: [PATCH 16/29] staging: bcm2835-audio: Drop superfluous mutex
 lock during prepare
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:K+pzkF6JpWbsQeHFK/cTp6AT4muAOvNRqq52MxY0IR7eoelBS6C
 mCQAg69hXsPfHUDphBRmYIQ6KNScBIfmyru95OXkQ1NBzK0vjZKL1IEz/4qsMYt7BZRHBBT
 K5/olqxqsouEQ0O0y/9kU7sN9VQPNIAwcNwAdMclIG7DpmxWpi7R41Zn4AsQ/d9owfY6d9R
 VqMuS8aqJn4QsWDHfwp+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7S4ft3bFxbQ=:PFzBsbxSrzO4VtyG+CQ+UR
 RJK8NiX+HqR5ObWbghD1Khe7qCiaXSH0dB7Nu55tBbwIW+8UKvKtRFjOnZWSZ/uUp5Xgu6seO
 6n6Pm3ubTbG4DX/fn4qPuMI68FnwIrrpH/SUEXc2TB/YK5YwCeoxftFYwba/6b4I3ew0jcJFa
 YOXmBVmFzVmQB6OCJRvQdr6+AUUJUS0mW/kKFRlRR19w7arLKAE01x2kNZcQY5OTkx3987t0F
 Z0vNS6wiRamJVeX/PbPOFvEy8PZxFjxWThNbn8nWhPv/Avmb2c+0DfKkoGtDBp8WuVKWjuRJr
 HbgtX19aAWzeIN7ypfi9mKPWFoC/dUI6g/6TBOK47L0ODX54a+2Z+jyhUOEOVx2gXE+nIlvmL
 IeSZX2AAHGhD1eJlutoqFIQwmI2qBR9V2DtWFh2riCHtR2IANsg+IcQbuXgB6uCuS/jyCUk0h
 Vt2Y2J7rHS7NruOLvIJJYQEtMNM/g2A6YZOAyDHGjNsU16zXkptIOe/7w+xHl09Q2jdE/AfZU
 PO8vATDfj7FVUFKisti0oGxMx8VMR/BpXRrUArliupL6SiMkTBD49B2u72qU8KlM9qP62PrkQ
 ghpJzzn7FRu41NdXNtYf8HqXpyLjR5LSBoDne2Gv3x9aQGfRbxapMMzaY6vP92m8q6mvaEvqE
 ZHLG7cDAW2tozyinT7MpExokIC1Gl0UlJu/nA/fRssRB8BwOjJvBH+R7pX2D/mttYTjYe91wz
 fNTAYYuG6WeSyOoN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Takashi Iwai <tiwai@suse.de> hat am 4. September 2018 um 17:58 geschrieben:
> 
> 
> The chip->audio_mutex is used basically for protecting the opened
> stream assignment, and the prepare callback is irrelevant with it.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> index 1f9c940f1cc3..9659c25b9f9d 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> @@ -218,8 +218,6 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
>  	int channels;
>  	int err;
>  
> -	mutex_lock(&chip->audio_mutex);
> -
>  	/* notify the vchiq that it should enter spdif passthrough mode by
>  	 * setting channels=0 (see
>  	 * https://github.com/raspberrypi/linux/issues/528)
> @@ -233,7 +231,7 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
>  				       runtime->rate,
>  				       snd_pcm_format_width(runtime->format));
>  	if (err < 0)
> -		goto out;
> +		return err;
>  
>  	memset(&alsa_stream->pcm_indirect, 0, sizeof(alsa_stream->pcm_indirect));
>  
> @@ -246,9 +244,7 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
>  	alsa_stream->pos = 0;
>  	alsa_stream->draining = false;
>  
> - out:
> -	mutex_unlock(&chip->audio_mutex);
> -	return err;
> +	return 0;

looks like your are removing code which has been added in patch #14 ?

>  }
>  
>  static void snd_bcm2835_pcm_transfer(struct snd_pcm_substream *substream,
> -- 
> 2.18.0
>
