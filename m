Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D930C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED67D20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED67D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eircom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeJKUVA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:21:00 -0400
Received: from vie01a-dmta-pe04-1.mx.upcmail.net ([62.179.121.163]:17743 "EHLO
        vie01a-dmta-pe04-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbeJKUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:21:00 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <mikebrady@eircom.net>)
        id 1gAaTQ-0003jx-Ms
        for linux-kernel@vger.kernel.org; Thu, 11 Oct 2018 14:53:52 +0200
Received: from helix.aillwee.com ([37.228.204.209])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id mCto1y00W4XbgXZ01CtqQy; Thu, 11 Oct 2018 14:53:51 +0200
X-SourceIP: 37.228.204.209
Received: from [192.168.50.181] (apu.aillwee.com [192.168.50.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by helix.aillwee.com (Postfix) with ESMTPSA id DDBEA4E607;
        Thu, 11 Oct 2018 13:53:47 +0100 (IST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH 17/29] staging: bcm2835-audio: Add 10ms period constraint
 [Resend in plain text...]
From:   Mike Brady <mikebrady@eircom.net>
In-Reply-To: <425F6E5F-782E-4288-ABF0-180504FD7B01@eircom.net>
Date:   Thu, 11 Oct 2018 13:53:47 +0100
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F63F1767-B8DA-42EE-9E74-A9A3D28C7D1F@eircom.net>
References: <20180904155858.8001-1-tiwai@suse.de>
 <20180904155858.8001-18-tiwai@suse.de>
 <4c5f9aed-8fbe-fe22-0c8d-097d8915805c@i2se.com>
 <s5h4lelu84e.wl-tiwai@suse.de>
 <8866e22a-6cd7-d32d-92e5-9a4e60206d2f@i2se.com>
 <s5hworhs559.wl-tiwai@suse.de>
 <828AF61F-4F6F-44C3-B463-7FE4EB8974F1@eircom.net>
 <s5hy3b7z138.wl-tiwai@suse.de>
 <425F6E5F-782E-4288-ABF0-180504FD7B01@eircom.net>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi. Just testing out the updated bcm2835 audio driver — it seems that it will underflow at somewhere above about 4410 and below 5120 frames, whereas the present driver is happy down to at least 2000 frames — I haven’t tried lower than about 1700.

Is this change meant to happen?

Regards
Mike


> On 9 Oct 2018, at 16:28, Mike Brady <mikebrady@eircom.net> wrote:
> 
> Hi Takashi.
> 
>> On 9 Oct 2018, at 14:44, Takashi Iwai <tiwai@suse.de> wrote:
>> 
>> On Tue, 09 Oct 2018 15:18:15 +0200,
>> Mike Brady wrote:
>>> 
>>>>> @Mike: Do you want to write a patch series which upstream "interpolate
>>>>> audio delay" and addresses Takashi's comments?
>>>>> 
>>>>> I would help you, in case you have questions about setup a Raspberry Pi
>>>>> with Mainline kernel or patch submission.
>>>> 
>>>> Well, the question is who really wants this.  The value given by that
>>>> patch is nothing but some estimation and might be even incorrect.
>>>> 
>>>> PulseAudio won't need it any longer when you set the BATCH flag.
>>>> Then it'll switch from tsched mode to the old mode, and the delay
>>>> value would be almost irrelevant.
>>> 
>>> Well, two answers. First, Shairport Sync
>>> (https://github.com/mikebrady/shairport-sync) needs it — whenever a
>>> packet of audio frames is about to be added to the output queue (at
>>> approximately 7.9 millisecond intervals), the delay is checked to
>>> try to maintain sync to within a few milliseconds. The BCM2835 audio
>>> device is the only one I have yet come across with so much
>>> jitter. Whatever other drivers do, the delay they report doesn’t
>>> suffer from anything like this level of jitter.
>> 
>> OK, if there is another application using that delay value, it's worth
>> to consider providing a fine-grained value.
>> 
>>> The second answer is that the veracity of the ALSA documentation
>>> depends on it — any application using the ALSA system for
>>> synchronisation will rely on this being an accurate reflection of
>>> the situation. AFAIK there is really no workaround it if the
>>> application is confined to “safe” ALSA
>>> (http://0pointer.de/blog/projects/guide-to-sound-apis).
>> 
>>> On LMKL.org, Takashi wrote:
>>> 
>>>> Date	Wed, 19 Sep 2018 11:52:33 +0200
>>>> From	Takashi Iwai <>
>>>> Subject	Re: [PATCH 17/29] staging: bcm2835-audio: Add 10ms period constraint
>>> 
>>>> [snip]
>>> 
>>>> That's OK, as long as the computation is accurate enough (at least not
>>>> exceed the actual position) and is light-weight.
>>> 
>>>> [snip]
>>> 
>>> The overhead is small -- an extra ktime_get() every time a GPU message
>>> is sent -- and another call and a few calculations whenever the delay
>>> is sought from userland.
>>> 
>>> At 48,000 frames per second, i.e. approximately 20 microseconds per
>>> frame, it would take a clock inaccuracy of roughly
>>> 20 microseconds in 10 milliseconds -- 2,000 parts per million — to
>>> result in an inaccurate estimate. 
>>> Crystal or resonator-based clocks typically have an inaccuracy of
>>> 10s to 100s of parts per million.
>>> 
>>> Finally, to see the effect of the absence and presence of this
>>> interpolation, please have a look at this:
>>> https://github.com/raspberrypi/firmware/issues/1026#issuecomment-415746016,
>>> where a downstream version of this fix was being discussed.
>> 
>> I'm not opposing to the usage of delay value.  The attribute is
>> provided exactly for such a purpose.  It's a good thing (tm).
>> 
>> The potential problem is, however, rather the implementation: it's
>> using a system timer for interpolation, which is known to drift from
>> the actual clocks.  Though, one may say that in such a use case, we
>> may ignore the drift since the interpolation is so narrow.
> 
> Yes, that was my thought. I guess another thing in its favour is that this audio device will always
> be in partnership with a processor as part of an SoC, so it will always be likely to have a reasonably
> accurate clock.
> 
>> But another question is whether it should be implemented in each
>> driver level.  The time-stamping is basically a PCM core
>> functionality, and nothing specific to the hardware, especially when
>> it's referring to the system timer.
> 
> That’s a fair point. I don’t know what is done in other drivers, but can only report that with one possible exception,
> the DACs used with Shairport Sync by many end users report well-behaved delay figures, certainly to within two microseconds. I’m afraid I don’t know how they do it.
> 
>> e.g. you can think in a different way, too: we may put a timestamp at
>> each hwptr update, and pass it as-is, instead of updating the
>> timestamp at each position query.  This will effectively gives the
>> accurate position-timestamp pair, and user-space may interpolate as it
>> likes, too.
> 
> That’s not a bad idea, and I might take it up on the alsa-devel mailing list, as you suggest.
> 
>> In anyway, if *this* kind of feature needs to be merged, it's
>> definitely to be discussed with the upstream.  So, if you're going to
>> merge that sort of path, please keep Cc to alsa-devel ML.
> 
> In the meantime, would you think that the balance of convenience lies with this interpolation scheme? (Finally, I have a patch ready….)
> Regards
> Mike
> 
>> 
>> thanks,
>> 
>> Takashi
> 

