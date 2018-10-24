Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83557ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D2E2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6ksAwMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D2E2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeJYGao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:30:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39817 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeJYGao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:30:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id e5-v6so6527985eds.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 15:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hwYT6buyQwbWqL09LI9qGDdkLHJaJowvzPM7+wVvEYk=;
        b=L6ksAwMAmkRv2RiIOg6nHF0UfpyI7u960uSyswi1F1WpTsVe7qpPK62CDKhs88wR5F
         rOoMpMPY+c8lzU7Lvq6UWN+1C1/NrOVHx1Lzpw4iIFl73F9YIxBoImh+/GYkXFj8qkfs
         NFvoS9kgwJmt4hc+QF8s7DUhSv3DCZlCFSmEN1BJv3bVgcTsvT+IM3MTteyBuyUTwoRS
         rU8/DFBwQA5HW4oY/oOWT3+Pxg79n1rTGj7DAvnA/+OWMlEWup+RlO1Xn7qu8mOqGYi5
         ZeqWWHh6+OHO6YPaX8k5+4mb8inI/wt7AAY+cX7pKOzEy3vbdLnq+imNkb2s5HCT+2e/
         Qy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hwYT6buyQwbWqL09LI9qGDdkLHJaJowvzPM7+wVvEYk=;
        b=A1JRksqEZTT2ht5PVLPIMzzTZ/yyoxC0SptP8eGlHMDbsmmhBDF347ayB5Q5365G9l
         TgI5MCJ0mR+esqr2CMGPY/uEML5S69gh+aPmqEJrID2VdbuuW7IiUnLC3uqDxt9ZlVvk
         znHYorhop2W/5nB5rfmW66W67PZ5cnU6fbe2iy+s+Hg3VSz5C3zMc/zDIKUAzEfgdeaT
         Tg2aN9PGcr/m7XXGYlR39gnx5tiVCDErk/LR1JOI2pUb1lfzBzM9PYtv1KGa9zLhV3WY
         EnzePzt+P8yyvqgV26orIpO+3iMevJO7d14p9pehyRoR+06Q9pDlA1Csdt7ejyI4TRaI
         y1jA==
X-Gm-Message-State: ABuFfojydVQ4j2uOUXF1fabMMwr5kTnADZh44bwtmz2euyrUbYzx+Qt/
        OhRJdjZ2lf5Xna89zsGW5ZA=
X-Google-Smtp-Source: ACcGV60gRLUM4S7I6WWOwB4QYfzjkOjngBsAqT5984SrTPjPqFU/d96Y0iIL+II7WpG1Fafvo8F/Gg==
X-Received: by 2002:a50:9554:: with SMTP id v20-v6mr20784180eda.4.1540418453020;
        Wed, 24 Oct 2018 15:00:53 -0700 (PDT)
Received: from [192.168.1.3] (x4dbb3c80.dyn.telefonica.de. [77.187.60.128])
        by smtp.gmail.com with ESMTPSA id y14-v6sm1240755ejq.11.2018.10.24.15.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 15:00:52 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2] staging: bcm2835-audio: interpolate audio
 delay
To:     Mike Brady <mikebrady@eircom.net>
Cc:     stefan.wahren@i2se.com, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, f.fainelli@gmail.com, eric@anholt.net,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        linux-rpi-kernel@lists.infradead.org,
        nishka.dasgupta_ug18@ashoka.edu.in,
        linux-arm-kernel@lists.infradead.org
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
 <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
From:   Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <9884c4f5-2343-e3a4-8d8b-dd2db404ef27@gmail.com>
Date:   Thu, 25 Oct 2018 00:02:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

We are not on the same page. What you hear is not what I tell you.
Either you don't understand what happens in your commit, or I don't understand
what happens in the driver.

Hopefully somebody in the community can comment here.

On 10/24/18 21:54, Mike Brady wrote:
>>>> You modify the function, which is called `snd_bcm2835_pcm_pointer`. Here you are
>>>> supposed to increase `alsa_stream->pos` with the proper offset. Instead, you
>>>> imitate a delay, but in fact the delay is not increased.
>>>>
>>>> So, the proper solution should be to fix the reported pointer.
>>>
>>> I think there is a difficulty with this. The “pos” pointer looks to have to be modulo the buffer size. This causes a problem, as I see it, in that if the calculated (pos + interpolated delay in bytes) is longer than the buffer size
>>
>>
>> There is no "interpolated delay". The concept of "interpolated delay" is
>> incorrect.
> 
> Yes, my language here is wrong. What I mean is the estimated number of frames output since the pointer was last updated — let’s call it the `interpolated frame count`.
> 

That's not what I mean. From my perspective, the problem is not in language, but
in the concept which you introduce here.

>> When you play sound - the pointer increments.
> 
> Unfortunately, when you play sound, the pointer does not actually increment, for up to about 10 milliseconds. I know of no way to actually access the true “live” position of the frame that is being played at any instant; hence the desire to estimate it.
> 

Your vision of situation in the opposite from my vision. What you see as a
symptom - I see as a root cause. As I see, you should fix the
pointer-not-incrementing. Why do you think that it's okay that the pointer is
not updating during sound play? Why do you insist that there is a delay? I don't
understand why we are so stuck here.

> What actually seems to be happening is that when `bcm2835_playback_fifo` is called, the pointer is updated, but as frames are individually output to the DAC, this pointer does not increment. It is not updated until the next time `bcm2835_playback_fifo` is called.
> 
>> But in this commit you increment the delay, as if sound doesn't play.
> 
> It is true that the patch does make use of the  snd_pcm_runtime structure’s “delay" field (aka "runtime->delay” here). That field is defined for: “/* extra delay; typically FIFO size */”. Clearly it is not being used for that here — it is being used simply because it is part of the calculation done in snd_pcm_calc_delay(), as you point out. At present, it looks like that field isn’t being used –– it’s set to zero –– and not modified anywhere else in the driver, AFAICS. If it was necessary, it would be a simple matter to preserve whatever value it was given.
> 

That's not what I am talking about. Somehow we don't understand each other.

>>>> As a result,
>>>> userspace will recieve the correct delay, instead of these crazy 10 ms.
>>>
>>> Just to point out that with the proposed patch, it appears that the correct delay is being reported, (apart, possibly, from any delay originally set in the snd_pcm_delay field, as mentioned above).
>>
>>
>> Then I would like to point out the alsa-lib function `snd_pcm_avail()` - it will return the wrong value.
> 
> It is already the case that snd_pcm_avail() does not return the true delay. The ALSA documentation states: "The value returned by that call [i.e. the snd_pcm_avail*() functions] is not directly related to the delay…” 
> 

Do you mean, that you are submitting the patch into the upstream kernel without
reading the code?

snd_pcm_avail() is calculated based on:

* hw_ptr
* buffer_size
* appl_ptr
* boundary

If you fix hw_ptr - it will fix both snd_pcm_delay() and snd_pcm_avail().
Instead, you invent the "interpolated delay", which in fact only compensates the
wrong hw_ptr instead of fixing it.

Best Regards,
Kirill


