Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AC1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A442150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A442150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbeISST0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:19:26 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49255 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeISST0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:19:26 -0400
Received: from [192.168.178.69] ([109.104.39.77]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MvbJw-1fld6t0BEs-00sfSp; Wed, 19 Sep 2018 14:41:29 +0200
Subject: Re: [PATCH 17/29] staging: bcm2835-audio: Add 10ms period constraint
To:     Takashi Iwai <tiwai@suse.de>, Mike Brady <mikebrady@eircom.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.org>
References: <20180904155858.8001-1-tiwai@suse.de>
 <20180904155858.8001-18-tiwai@suse.de>
 <4c5f9aed-8fbe-fe22-0c8d-097d8915805c@i2se.com>
 <s5h4lelu84e.wl-tiwai@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <8866e22a-6cd7-d32d-92e5-9a4e60206d2f@i2se.com>
Date:   Wed, 19 Sep 2018 14:41:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <s5h4lelu84e.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-Provags-ID: V03:K1:ffbFpjj9c9U03SAxiCzCwO39ACs7pi2RavYhNJnJvGjGD/BkMIV
 WWtlVjRwLcZmLou6k8kBPMiedneVw6CR1kZBnUN28+bYdr25sXNZGVJBJHmH1Zk9U4PFCvx
 qiIzlILm03RktaIxQwsn1dARfE8y61AX6z0Go1byuPewewEQb0AtX2XV0Jgi7IcFW3O2rIn
 YrTcciX3/qBSqMBU2tP3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QG3KKz1RuCc=:PYdyPTjg9nXB+c1eLHNVd7
 gXTIdid2rVGRUVSYOasznJKCJFNa7Bu+3wVOLYpofbxoyyz/vT+qmFKzqzkP2Gpwvv2kuP/V5
 i6YK8ixDj5OBrt4T391Yf2WyatJJgdsqjL+5KUdBlfZOrAPrEkVAyma3NZE0Y6o8EDjYVwUQR
 lDd7XPx+fCnn5TCXgGiqkAJvI78HKzC13y/uQ13hha6iY5aYBXbDozvh3dBlo+DX8T36Cc39r
 OlpxT1mc/dFQ/peiHS4qcwhRIOdTLC3nevOpNTYCCScLZyY22QlbrkIE94tZSyRXRB8lbz/Bj
 i/zz7SX1vsZ8JDdSlZRknAwZRT7St4X5tPm7gRIAMnafoalexdTXj72MPFnCf/OemLduNJ5AK
 78cLFgHcg7j8j2knR+COgMWW9d4w72T3ruekxTHgvA0cAnWxozmcce7GQKMtz/NINKdfNNNIJ
 3VYs4c11rmeD1GNwiinpWINPhkr7LMklo3v8/tWfQe6r+oK3sHBpkxt6b8fLWQzgg5CcvGOnh
 8ttXiNlpE6RRLEl7Jf/vy7G3mZa5UyOJ6UV4xD1lrrEu+oCRpzu0HTHoCjb1KM9qdyX9EI7V5
 Vkj7CYFAKlDiES3SfBKeqzyE0iNJlN0wykcqSoB3aRkLydPk7I52ARbyp/XEH5hUTKVaGPyTF
 t3vhNjvYTXKaOvwOuWEoBlHb57jsmWYH4O/VhAibR1jWhGXhc5Z0hZuXeeuqku7HCUo/hcaqw
 fVPAi/wKbM6vYkiB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[add Phil and Mike]

Am 19.09.2018 um 11:52 schrieb Takashi Iwai:
> On Wed, 19 Sep 2018 11:42:22 +0200,
> Stefan Wahren wrote:
>> Hi Takashi,
>>
>> Am 04.09.2018 um 17:58 schrieb Takashi Iwai:
>>> It seems that the resolution of vc04 callback is in 10 msec; i.e. the
>>> minimal period size is also 10 msec.
>>>
>>> This patch adds the corresponding hw constraint.
>>>
>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>> ---
>>>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>> index 9659c25b9f9d..6d89db6e14e4 100644
>>> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
>>> @@ -145,6 +145,11 @@ static int snd_bcm2835_playback_open_generic(
>>>  				   SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
>>>  				   16);
>>>  
>>> +	/* position update is in 10ms order */
>>> +	snd_pcm_hw_constraint_minmax(runtime,
>>> +				     SNDRV_PCM_HW_PARAM_PERIOD_TIME,
>>> +				     10 * 1000, UINT_MAX);
>>> +
>>>  	chip->alsa_stream[idx] = alsa_stream;
>>>  
>>>  	chip->opened |= (1 << idx);
>> in the Foundation Kernel (Downstream) there is a patch to interpolate
>> the audio delay. So my questions is, does your patch above makes the
>> following patch obsolete?
> Through a quick glance, no, my patch is orthogonal to this.
>
> My patch adds a PCM hw constraint so that the period size won't go
> below 10ms, while the downstream patch provides the additional delay
> value that is calculated from the system clock.

thanks for your explanation. So your patch must be reverted with
implementation of interpolate audio delay.

>
>> [PATCH] bcm2835: interpolate audio delay
>>
>> It appears the GPU only sends us a message all 10ms to update
>> the playback progress. Other than this, the playback position
>> (what SNDRV_PCM_IOCTL_DELAY will return) is not updated at all.
>> Userspace will see jitter up to 10ms in the audio position.
>>
>> Make this a bit nicer for userspace by interpolating the
>> position using the CPU clock.
>>
>> I'm not sure if setting snd_pcm_runtime.delay is the right
>> approach for this. Or if there is maybe an already existing
>> mechanism for position interpolation in the ALSA core.
> That's OK, as long as the computation is accurate enough (at least not
> exceed the actual position) and is light-weight.
>
>> I only set SNDRV_PCM_INFO_BATCH because this appears to remove
>> at least one situation snd_pcm_runtime.delay is used, so I have
>> to worry less in which place I have to update this field, or
>> how it interacts with the rest of ALSA.
> Actually, this SNDRV_PCM_INFO_BATCH addition should be a separate
> patch.  It has nothing to do with the runtime->delay calculation.
> (And, this "one situation" is likely called PulseAudio :)
>
>> In the future, it might be nice to use VC_AUDIO_MSG_TYPE_LATENCY.
>> One problem is that it requires sending a videocore message, and
>> waiting for a reply, which could make the implementation much
>> harder due to locking and synchronization requirements.
> This can be now easy with my patch series.  By switching to non-atomic
> operation, we can issue the vc04 command inside the pointer callback,
> too.

I think we should try to implement this later.

@Mike: Do you want to write a patch series which upstream "interpolate
audio delay" and addresses Takashi's comments?

I would help you, in case you have questions about setup a Raspberry Pi
with Mainline kernel or patch submission.

Regards
Stefan

>
>
> thanks,
>
> Takashi


