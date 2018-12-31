Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59946C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D0E20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeLaVCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:02:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36379 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbeLaVCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:02:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so24950963wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 13:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0s8s9F4vy5ULIuFl4QnWdvemyDg6gdlClY6VTgelsUQ=;
        b=E0EDjfWsfOhNjzc70IA8f7Ve+zSB4+EgUxVsFkMOLxiv2OhwPgNBtQGF72TQwVrmiY
         57V60U674RA6KzugeF8nwxNgMqXgWt7Zq6lmMNP2e+yzjANtwFKsxPUNJ1eUSWzZwBJG
         oLAmoIspHOamzYNiM5D9jM48wEgDtyzoEtyqbj8aRUMYFP4FBfZPRS21IKnMw8m+mVS/
         fGpgsAnD4uKVCfU3Cqczt5AhZuZ3L05VHQ//AhELVq2zZQoUJENlW4uxsFj+QgT/Tk1r
         c3e2aNxdAbL922xHa2hdbhECUAHvVkKQsLdn/O6baB7iAUL07f6l4g+zS9BqnbC+og64
         UyRA==
X-Gm-Message-State: AJcUukc5GJJiSmAlBnpOlscySfeeDxmUbVLd0vDSEqs3kD3I5TAWV8Fg
        duOc+knDbJeouebNLc+4VD5Hbg==
X-Google-Smtp-Source: ALg8bN42RgBOl1VHnh9D+LM3uk9Q0YRhuxYTYBO+JLC8gf1IQszHX3tsUoiPD8d6o5ZZmwT9+3gltw==
X-Received: by 2002:a1c:3905:: with SMTP id g5mr31036081wma.30.1546290152903;
        Mon, 31 Dec 2018 13:02:32 -0800 (PST)
Received: from localhost.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id l20sm85550195wrb.93.2018.12.31.13.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 13:02:32 -0800 (PST)
Subject: Re: [GIT PULL] sound updates for 4.21
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Azat Khuzhin <dohardgopro@gmail.com>
References: <s5hk1k48ayx.wl-tiwai@suse.de>
 <CAHk-=wg+hjDa8UGRVnCFytjwYLPk2yDgJoKOESVSE7_6KfaeTg@mail.gmail.com>
 <20181228124303.GA16558@gmail.com> <s5hmuoplgw2.wl-tiwai@suse.de>
 <CAHk-=wjXVPpDWHzvNL=9gGVGNnYg1jOH8hQx=dq4caEzip-n0g@mail.gmail.com>
 <s5hef9zl69r.wl-tiwai@suse.de>
 <82bb7f60-c3c2-4715-a0a0-f1f2a8b14c74@linux.intel.com>
 <s5h1s5ykteg.wl-tiwai@suse.de>
 <acbc8f2d-c112-550d-1028-b4c234df4c1b@linux.intel.com>
 <s5ho991k1g9.wl-tiwai@suse.de>
 <f1474b8c-6215-e842-1649-64d9ef17ef7a@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <887fbee7-3969-c009-9751-1b82b632eb80@redhat.com>
Date:   Mon, 31 Dec 2018 22:02:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f1474b8c-6215-e842-1649-64d9ef17ef7a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/31/18 9:10 PM, Pierre-Louis Bossart wrote:
> 
> On 12/31/18 12:15 PM, Takashi Iwai wrote:
>> On Mon, 31 Dec 2018 11:24:41 +0100,
>> Pierre-Louis Bossart wrote:
>>>
>>> On 12/31/18 2:11 AM, Takashi Iwai wrote:
>>>> On Mon, 31 Dec 2018 00:17:58 +0100,
>>>> Pierre-Louis Bossart wrote:
>>>>>> BTW, one thing I'd really like to avoid is to rearrange the probe
>>>>>> procedure of the legacy HDA driver (so that we can get codec_mask
>>>>>> during pci probe() call).  The async probe is the result of the many
>>>>>> struggles with the various and complex configurations.   Moving the
>>>>>> codec probe to the beginning isn't trivial and quite risky to break
>>>>>> something else.
>>>>> Agree, mucking with the probe isn't something we should look into,
>>>>> especially with this Skylake driver being eventually deprecated once
>>>>> SOF is at feature parity. This set of autodetection patches for 4.21
>>>>> was really targeting CFL/WHL+ devices, where the DSP usage is
>>>>> mandatory when directly-attached digital microphones are used. For
>>>>> Skylake and kabylake using the legacy by default is just fine.
>>>> OK, then how about applying the PCI class check only for such ones
>>>> like the patch below?  The macro isn't sexy and can be replaced with
>>>> another way, but you have an idea.
>>> The two patches which added the PCI class checks were supposed to be a
>>> simple bullet-proof way of detecting the DSP presence and solving a
>>> problem of coexistence between two drivers. At this point if we start
>>> adding quirks and still have unclear issues with HDMI support which
>>> isn't different for CFL+, it may be wiser to revert them to let the
>>> 4.21 merge window progress? It's frustrating but I'd rather solve this
>>> problem the right way than with multiple iterations rushed because of
>>> the merge window timing.
>> Fair enough, let's revert them for now.  I'm going to submit the
>> revert patch.
> 
> Thanks Takashi. If everyone who has been impacted by this issue can send me privately the result of the following two commands it'd help us figure out which machines expose the DSP - we may ask for additional information, e.g. NHLT tables. We clearly need to widen the validation scope since there is obviously a disconnect between what 3rd party BIOS expose and the technical consensus within Intel audio teams. Thanks in advance for your time.
> 
> -Pierre

On my Apollo Lake laptop which is also affected by this:

> lspci -s 0:1f.3 -vn

00:0e.0 0403: 8086:5a98 (rev 0b) (prog-if 80)
         Subsystem: 10ec:111a
         Flags: bus master, fast devsel, latency 0, IRQ 128
         Memory at 91218000 (64-bit, non-prefetchable) [size=16K]
         Memory at 91000000 (64-bit, non-prefetchable) [size=1M]
         Capabilities: <access denied>
         Kernel driver in use: snd_hda_intel
         Kernel modules: snd_hda_intel, snd_soc_skl

> more /sys/bus/pci/devices/0000\:00\:1f.3/class (should return 0x040100 or 0x040380, if the value is 0x040300 then the DSP is not exposed)

0x040380

Regards,

Hans

