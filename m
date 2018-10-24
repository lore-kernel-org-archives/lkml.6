Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BE6ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892F92075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWpFJerf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892F92075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeJYCdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:33:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40789 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbeJYCdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:33:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id r1-v6so5924629edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WY6TIVv81WhoZlHK4x/iJKFTYGnYqE4UtLZj0KUe0oQ=;
        b=kWpFJerfFmu9EqP1l2JnmdpXpRW3RGPBNv4pEmAqfv7FyLdXkJ36sKDfC29qVHZ3z3
         eLYKnqyl70aRoNlXTX0L3jPThzbZVRv1SEAW0b9wpTJZNYxo44TZ8aahlOwplUfEBUX4
         2FhGd8EabbmAmbJjPeFDS8C3E4p8bkJIEM+p/6OiQUXM71/OMr+6WgyoXg1DUGyMz6Ax
         9TSO9F/ECFJgPMKJ/+ZglQUgK04enJr0IWGk8AjYE50sZ8H/eyvIvgVPXuDivDMO1fw3
         zBoVNNvWJeTDoKY2vzy4rD/R/FqX6aUmIPdLKYjPVHd9K+LlZU4Bf+kZM66wNc/psmIy
         2VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WY6TIVv81WhoZlHK4x/iJKFTYGnYqE4UtLZj0KUe0oQ=;
        b=bee9Mh4mioxlrDLM/AugAYbaCT3acAequMHTFAZttle0M4JzgjDBa20jSMv5a2FhqX
         wLnBYO7FoefspLaHFe8uyFlUNWJi50Z8YBNKWsIo7Sh48ebQIrHun+IQnMC7RkilcqkS
         diXAoQ9PRYrWtlCUlyeIDVA3X6a9udm5LpmkhlaYwV4P/IKVhphJfk1JifWFrD5ECw5E
         xKpsvbTIA5bEFUBITBbOTgbplN5FOIOZMBHV734OKOsiuQ3TZPWlQd0vUZPp4qGyRSwA
         kRAszrsbaeaounryQ1B0kGvZfc5cvtahq39aecvMcHkxqwZ7aYde8EaOrK4lUD1WmcI9
         FHhw==
X-Gm-Message-State: ABuFfojXoWrthVt7nTYhynfFFYB+s5w2Mr5k3XrJWjKQEe6JWPHbcHQa
        5UTPZlMhMrYbApvKzHtSgxc=
X-Google-Smtp-Source: ACcGV63m0GPm/Mq+HG0ZDfOliOQYm4k895kUmm6yWJIAeZg/sCnglohYBGFWJKqR9F4lTZsB66GucQ==
X-Received: by 2002:a05:6402:6d8:: with SMTP id n24mr18619925edy.99.1540404277030;
        Wed, 24 Oct 2018 11:04:37 -0700 (PDT)
Received: from [192.168.1.3] (x4dbb3c80.dyn.telefonica.de. [77.187.60.128])
        by smtp.gmail.com with ESMTPSA id c24-v6sm1954362ede.73.2018.10.24.11.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 11:04:36 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
To:     Mike Brady <mikebrady@eircom.net>
Cc:     stefan.wahren@i2se.com, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, f.fainelli@gmail.com,
        julia.lawall@lip6.fr, tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, eric@anholt.net,
        linux-rpi-kernel@lists.infradead.org,
        nishka.dasgupta_ug18@ashoka.edu.in,
        linux-arm-kernel@lists.infradead.org
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
From:   Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
Date:   Wed, 24 Oct 2018 20:06:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

On 10/24/18 10:20, Mike Brady wrote:
> Hi Kirill. Thanks for your comments.
> 
>> On 22 Oct 2018, at 23:25, Kirill Marinushkin <k.marinushkin@gmail.com> wrote:
>>
>> AFAIU, this patch is wrong. Please correct me, maybe I misunderstand something.
>>
>>> The problem that this patch seeks to resolve is that when userland asks for
>>> the delay
>>
>> The userspace asks not for delay, but for the pointer.
> 
> The call in question is snd_pcm_delay. I presume this delay is calculated from knowledge of the stream position “pos", the period (buffer?) number (and period/buffer size) and the snd_pcm_runtime structure’s “delay" field (“runtime->delay”).
> 


In kernel, this delay is calculated in `snd_pcm_calc_delay()`, defined at
`sound/core/pcm_native.c:889`. If you analyze how this calculation is done, you
will see that the returned value is a summary of the following fields:

* runtime->status->hw_ptr
* runtime->buffer_size
* runtime->control->appl_ptr
* runtime->boundary
* runtime->delay


>> You modify the function, which is called `snd_bcm2835_pcm_pointer`. Here you are
>> supposed to increase `alsa_stream->pos` with the proper offset. Instead, you
>> imitate a delay, but in fact the delay is not increased.
>>
>> So, the proper solution should be to fix the reported pointer.
> 
> I think there is a difficulty with this. The “pos” pointer looks to have to be modulo the buffer size. This causes a problem, as I see it, in that if the calculated (pos + interpolated delay in bytes) is longer than the buffer size


There is no "interpolated delay". The concept of "interpolated delay" is
incorrect. When you play sound - the pointer increments. But in this commit you
increment the delay, as if sound doesn't play.


>> As a result,
>> userspace will recieve the correct delay, instead of these crazy 10 ms.
> 
> Just to point out that with the proposed patch, it appears that the correct delay is being reported, (apart, possibly, from any delay originally set in the snd_pcm_delay field, as mentioned above).


Then I would like to point out the alsa-lib function `snd_pcm_avail()` - it will
return the wrong value.


> 
> All the best,
> Mike
> 
>> FYI, there is
>>> a discussion of the effects of a downstream equivalent of this suggested patch
>>> at:
>>> https://github.com/raspberrypi/firmware/issues/1026#issuecomment-415746016.
>>
>> Thank you for the link, it clarified for me what you try to achieve.
>>
>> On 10/22/18 21:17, Mike Brady wrote:
>>> When the BCM2835 audio output is used, userspace sees a jitter up to 10ms
>>> in the audio position, aka "delay" -- the number of frames that must
>>> be output before a new frame would be played.
>>> Make this a bit nicer for userspace by interpolating the position
>>> using the CPU clock.
>>> The overhead is small -- an extra ktime_get() every time a GPU message
>>> is sent -- and another call and a few calculations whenever the delay
>>> is sought from userland.
>>> At 48,000 frames per second, i.e. approximately 20 microseconds per
>>> frame, it would take a clock inaccuracy of
>>> 20 microseconds in 10 milliseconds -- 2,000 parts per million --
>>> to result in an inaccurate estimate, whereas
>>> crystal- or resonator-based clocks typically have an
>>> inaccuracy of 10s to 100s of parts per million.
>>>
>>> Signed-off-by: Mike Brady <mikebrady@eircom.net>
>>> ---
>>> Changes in v2 -- remove inappropriate addition of SNDRV_PCM_INFO_BATCH flag
>>>
>>> .../vc04_services/bcm2835-audio/bcm2835-pcm.c | 20 +++++++++++++++++++
>>> .../vc04_services/bcm2835-audio/bcm2835.h     |  1 +
>>> 2 files changed, 21 insertions(+)
>>>
>>> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>> index e66da11af5cf..9053b996cada 100644
>>> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>> @@ -74,6 +74,7 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream,
>>> 	atomic_set(&alsa_stream->pos, pos);
>>>
>>> 	alsa_stream->period_offset += bytes;
>>> +	alsa_stream->interpolate_start = ktime_get();
>>> 	if (alsa_stream->period_offset >= alsa_stream->period_size) {
>>> 		alsa_stream->period_offset %= alsa_stream->period_size;
>>> 		snd_pcm_period_elapsed(substream);
>>> @@ -243,6 +244,7 @@ static int snd_bcm2835_pcm_prepare(struct snd_pcm_substream *substream)
>>> 	atomic_set(&alsa_stream->pos, 0);
>>> 	alsa_stream->period_offset = 0;
>>> 	alsa_stream->draining = false;
>>> +	alsa_stream->interpolate_start = ktime_get();
>>>
>>> 	return 0;
>>> }
>>> @@ -292,6 +294,24 @@ snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
>>> {
>>> 	struct snd_pcm_runtime *runtime = substream->runtime;
>>> 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
>>> +	ktime_t now = ktime_get();
>>> +
>>> +	/* Give userspace better delay reporting by interpolating between GPU
>>> +	 * notifications, assuming audio speed is close enough to the clock
>>> +	 * used for ktime
>>> +	 */
>>> +
>>> +	if ((ktime_to_ns(alsa_stream->interpolate_start)) &&
>>> +	    (ktime_compare(alsa_stream->interpolate_start, now) < 0)) {
>>> +		u64 interval =
>>> +			(ktime_to_ns(ktime_sub(now,
>>> +				alsa_stream->interpolate_start)));
>>> +		u64 frames_output_in_interval =
>>> +			div_u64((interval * runtime->rate), 1000000000);
>>> +		snd_pcm_sframes_t frames_output_in_interval_sized =
>>> +			-frames_output_in_interval;
>>> +		runtime->delay = frames_output_in_interval_sized;
>>> +	}
>>>
>>> 	return snd_pcm_indirect_playback_pointer(substream,
>>> 		&alsa_stream->pcm_indirect,
>>> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
>>> index e13435d1c205..595ad584243f 100644
>>> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
>>> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
>>> @@ -78,6 +78,7 @@ struct bcm2835_alsa_stream {
>>> 	unsigned int period_offset;
>>> 	unsigned int buffer_size;
>>> 	unsigned int period_size;
>>> +	ktime_t interpolate_start;
>>>
>>> 	struct bcm2835_audio_instance *instance;
>>> 	int idx;
>>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
