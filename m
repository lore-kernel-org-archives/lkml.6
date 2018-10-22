Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352A3C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F8820663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGIWPAMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F8820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbeJWGoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:44:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45283 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbeJWGoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:44:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id t10-v6so6734115eds.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 15:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7FQiy3sQG0LtXMgoaOdjUeATeJRuS+E1psgYa/NO8/4=;
        b=tGIWPAMoI7whVes8hJIAy3H1GShJ1IikQSc34+Ltg1rRwg8hqAAuUTBEOWfGvH8yiZ
         q2tHQfvbcPXsS4PRQrkyD7ItmljdzeTMPmSKft5G0HVSEDFCv6qTMGujeAK8L8/Nkd0q
         G1mmPM1I0kOHyUWN42qpDQsI0NEHac9oatemVYAP4xdcmvtXVRCr2KSwrk6tI0UErmoO
         k5M1gDjd4aPXDUTgRC+3foQFpnvsdtGY5fBOeVyjIZP5QGZAO8aUGoRlpJnTuZfvigQD
         BdEK30nOEnMtDZpMbEqmMPnDPgdlJkQ1oeRSIaPTHiEMRM0emukMf7Hdr7v1Fl3+JWIl
         +TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7FQiy3sQG0LtXMgoaOdjUeATeJRuS+E1psgYa/NO8/4=;
        b=ByEbMRhmo8iE+3+a33nW0rg5ZXazBB/bbawZ6FA/0Ckm64Ar5hOj083YMlBxQVqMpV
         N3uy4OgDK/cUfL+8HxX/6WE/bs08AtEYLZkrmfH3ZMePYaq43Otf9+9WyA/7+RO1BsPu
         Wzayw9BeVGfC/eck0K12Y1/MEW7muqZDKskqrhQl9/VdRRB2UJ92mDe+8rXa4wNVecQB
         vFBqX+HTqB0GC6MOzFI0/ywGbSpuTl+Xt6MpofeyAMJhlHjQwcMSHhKOOtZ5699T7/5v
         /zO/YDsOOwW8sbDvfNcRNqICqMxpTpq9oS4gJDyQ4q8Qzdo0Axu8tRwkxilmGXGPOU4m
         xm9Q==
X-Gm-Message-State: ABuFfogoCAg0M9dc1TI5q+2LD+H8Db7VTaX0m6kjYoee9oFAJ0bkUamX
        ihBArWb3aAwS5hwzvxRRVBZybPBYeD8=
X-Google-Smtp-Source: ACcGV63guffzDIBtXxefCoPCzLR5ylxp7w2H/8WlXWrZq8QJMZM8do6WuCqUkfYYG9LEsJeQ+S/AQg==
X-Received: by 2002:a17:906:d55a:: with SMTP id gk26-v6mr37240953ejb.209.1540247013524;
        Mon, 22 Oct 2018 15:23:33 -0700 (PDT)
Received: from [192.168.1.3] (x4d0f6cdc.dyn.telefonica.de. [77.15.108.220])
        by smtp.gmail.com with ESMTPSA id w14-v6sm627177eds.16.2018.10.22.15.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 15:23:32 -0700 (PDT)
Subject: Re: [PATCH v2] staging: bcm2835-audio: interpolate audio delay
To:     Mike Brady <mikebrady@eircom.net>
Cc:     eric@anholt.net, stefan.wahren@i2se.com,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com, tiwai@suse.de,
        nishka.dasgupta_ug18@ashoka.edu.in, julia.lawall@lip6.fr,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20181022191708.GA4659@ubuntu>
From:   Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
Date:   Tue, 23 Oct 2018 00:25:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20181022191708.GA4659@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

AFAIU, this patch is wrong. Please correct me, maybe I misunderstand something.

> The problem that this patch seeks to resolve is that when userland asks for
> the delay

The userspace asks not for delay, but for the pointer.
You modify the function, which is called `snd_bcm2835_pcm_pointer`. Here you are
supposed to increase `alsa_stream->pos` with the proper offset. Instead, you
imitate a delay, but in fact the delay is not increased.

So, the proper solution should be to fix the reported pointer. As a result,
userspace will recieve the correct delay, instead of these crazy 10 ms.

> FYI, there is
> a discussion of the effects of a downstream equivalent of this suggested patch
> at:
> https://github.com/raspberrypi/firmware/issues/1026#issuecomment-415746016.

Thank you for the link, it clarified for me what you try to achieve.

On 10/22/18 21:17, Mike Brady wrote:
> When the BCM2835 audio output is used, userspace sees a jitter up to 10ms
> in the audio position, aka "delay" -- the number of frames that must
> be output before a new frame would be played.
> Make this a bit nicer for userspace by interpolating the position
> using the CPU clock.
> The overhead is small -- an extra ktime_get() every time a GPU message
> is sent -- and another call and a few calculations whenever the delay
> is sought from userland.
> At 48,000 frames per second, i.e. approximately 20 microseconds per
> frame, it would take a clock inaccuracy of
> 20 microseconds in 10 milliseconds -- 2,000 parts per million --
> to result in an inaccurate estimate, whereas
> crystal- or resonator-based clocks typically have an
> inaccuracy of 10s to 100s of parts per million.
> 
> Signed-off-by: Mike Brady <mikebrady@eircom.net>
> ---
> Changes in v2 -- remove inappropriate addition of SNDRV_PCM_INFO_BATCH flag
> 
>  .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 20 +++++++++++++++++++
>  .../vc04_services/bcm2835-audio/bcm2835.h     |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> index e66da11af5cf..9053b996cada 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
> @@ -74,6 +74,7 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream,
>  	atomic_set(&alsa_stream->pos, pos);
>  
>  	alsa_stream->period_offset += bytes;
> +	alsa_stream->interpolate_start = ktime_get();
>  	if (alsa_stream->period_offset >= alsa_stream->period_size) {
>  		alsa_stream->period_offset %= alsa_stream->period_size;
>  		snd_pcm_period_elapsed(substream);
> @@ -243,6 +244,7 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
>  	atomic_set(&alsa_stream->pos, 0);
>  	alsa_stream->period_offset = 0;
>  	alsa_stream->draining = false;
> +	alsa_stream->interpolate_start = ktime_get();
>  
>  	return 0;
>  }
> @@ -292,6 +294,24 @@ snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
>  {
>  	struct snd_pcm_runtime *runtime = substream->runtime;
>  	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
> +	ktime_t now = ktime_get();
> +
> +	/* Give userspace better delay reporting by interpolating between GPU
> +	 * notifications, assuming audio speed is close enough to the clock
> +	 * used for ktime
> +	 */
> +
> +	if ((ktime_to_ns(alsa_stream->interpolate_start)) &&
> +	    (ktime_compare(alsa_stream->interpolate_start, now) < 0)) {
> +		u64 interval =
> +			(ktime_to_ns(ktime_sub(now,
> +				alsa_stream->interpolate_start)));
> +		u64 frames_output_in_interval =
> +			div_u64((interval * runtime->rate), 1000000000);
> +		snd_pcm_sframes_t frames_output_in_interval_sized =
> +			-frames_output_in_interval;
> +		runtime->delay = frames_output_in_interval_sized;
> +	}
>  
>  	return snd_pcm_indirect_playback_pointer(substream,
>  		&alsa_stream->pcm_indirect,
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
> index e13435d1c205..595ad584243f 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
> @@ -78,6 +78,7 @@ struct bcm2835_alsa_stream {
>  	unsigned int period_offset;
>  	unsigned int buffer_size;
>  	unsigned int period_size;
> +	ktime_t interpolate_start;
>  
>  	struct bcm2835_audio_instance *instance;
>  	int idx;
> 
