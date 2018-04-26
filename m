Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AIpwx4+GzCDh3ngq1+Tpnin68si6a8YrFeN9IbgLpnpptqAnq6qUjJhDCCAJItcT/WlFaIILCmeW
ARC-Seal: i=1; a=rsa-sha256; t=1524762803; cv=none;
        d=google.com; s=arc-20160816;
        b=UpqVpjR7+GHTlfgAOTXJe7F1aF48YSwG1hrIGVBnzZCwCui47YzOoQujbegwsidKTH
         +K2wOKnDFd+GnN1v/kLN1sxTCFfD9zsd/I9T6sZe+YPDlu4LjXb70QxLGwq0ruZDUbg8
         MgvsIfiNhlbs/kenqOigz53V8lXPXVJnZiB9q7c9w45jCWkmBz0q6cCWAoP6LkoJSzhP
         OeJllSGVmyiusCgQtBcM9JQ2LTmYoI+aOz7fGjGbq1Y8tyQVzfuYAc4pgL9uSCTosSd0
         HTIrGkNGROyu2rvpjX3PFwtntxyf7LkGeANLEe5pySFgWBOP6h/WmLkPO5LRWg/2848I
         d8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=rDTwcEmJVaIoDhfD8arfg0vpQVZAObnTTaM6GWyUx4k=;
        b=syKWvQnMAzuZPTyFMyGGvokGLDdIsd+Hggtg59VvT2a3KXuTMu3W0IW76id0AVsVy/
         UpafJLo6YaDcd/jbHRYNaWMx65d3m2fKrpWkjvOSEiVOIxf8k7z3ibjpaIY8iHV283Kf
         ixmWB7BMGHAvb0wU0WfCc49oMRQHT4wDq60lEzKGrQpZGnlddzglJPeste8YJaKevt06
         r4Lb/4p1BNvxe33zaSuYHqoW269ciJ8ZxY0tfflPr0WRFNguYfL7TvvSSkVhRBpMsuAV
         cuKRPVzcL8rnQ9IYSLbXfuf+wLcX4xErtgSdPNDIG9B0GxPptfyiLK8uTXjg+qQo2aTD
         ti8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Subject: Re: [alsa-devel] [PATCH v2 0/4] ALSA: usb: UAC3 new features.
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180424172445.31928-1-jorge.sanjuan@codethink.co.uk>
 <s5hy3hcwkhy.wl-tiwai@suse.de>
 <CAB=otbSyFftwzq9YXvyFWOcKZQch+Hd0XVWugPzJ3O2nb3hYZQ@mail.gmail.com>
From: Jorge <jorge.sanjuan@codethink.co.uk>
Message-ID: <74748a72-dfba-666f-aaf7-b2976cda9b87@codethink.co.uk>
Date: Thu, 26 Apr 2018 18:13:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAB=otbSyFftwzq9YXvyFWOcKZQch+Hd0XVWugPzJ3O2nb3hYZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285487756615401?=
X-GMAIL-MSGID: =?utf-8?q?1598829681501264897?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 26/04/18 10:26, Ruslan Bilovol wrote:
> On Tue, Apr 24, 2018 at 9:02 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> On Tue, 24 Apr 2018 19:24:41 +0200,
>> Jorge Sanjuan wrote:
>>>
>>> v2 fixes:
>>>   - If/else statements braces style fixes.
>>>   - Add wrapping function to mixer unit code.
>>>   - Make connectors control kctl struct const.
>>>   - Little endian to cpu conversion in several places.
>>>   - Sing off and add Fixes tag to fixup commit.
>>>   - Remove flex-array for a struct that is used statically.
>>>
>>> Now that the UAC3 patch [1] has made it to linux-next I have some extra
>>> features to make a UAC3 device fully work in Linux. Including Jack
>>> insertion control that I have put on top of this other patch [2] for
>>> UAC2. Also adding support for the UAC3 Mixer Unit which is most likely
>>> to appear in most headset type devices.
> 
> Thanks for adding these improvements!
> 
>>
>> These patches look reasonable, I'm OK to merge.  But I'll wait for
>> Ruslan's comments (or at best with test results).
> 
> I reviewed first 3 patches and will review jack detection patch later,
> and I'm going to test this patchset in a next few days.
> 
>>
>>> UAC3 devices also require to have a Basic Audio Device (BADD) in a separate
>>> config for which both Ruslan Bilovol and myself have submited different
>>> approaches[3][4] but I don't know what the final merge will be. Once there
>>> is official support for BADD, we'll need to test it with an actual UAC3
>>> device to confirm it all wokrs.
>>
>> Could you guys try to get agreement which approach should we take?
>>
>> I have no big preference.  Currently Ruslan's patch series look
>> easier, just because its addition is a bit smaller, though.
> 
> The BADD devices are quite simple, so direct initialization internal ALSA
> structures looks easy and straightforward, comparing to generation of
> missing descriptors.
> I'm currently improving the patch series so it will look even more
> smaller and easier, let's see how it goes

Hi Ruslan,

I agree that the BADD devices may not require that much logic using all 
the descriptors. Besides, what makes your approach more interesting to 
me is the fact that there is no need to bypass the cluster descriptor 
every single time if the UAC3 device operates in BADD mode.

I have not yet tested your patch with the UAC3 device that I have. I was 
wondering whether that BADD mixer code will work with and AS interface 
with several alt settings with different endpoints wMaxPacketSize. That 
is something I am working on/testing for this device. I'd have to take a 
closer look to the patch to provide some useful input on that.

Thanks,

Jorge

> 
> Thanks,
> Ruslan
> 
>>
>>
>> Thanks!
>>
>> Takashi
>>
>>> All this features are tested with an actual UAC3 device that is still in
>>> development. For this patch series, only the legacy config (#1. UAC1/UAC2)
>>> and the UAC3 config have been tested. The BADD config is only tested using
>>> and updated verison of [4].
>>>
>>> [1]: https://patchwork.kernel.org/patch/10298179/
>>> [2]: https://patchwork.kernel.org/patch/10305847/
>>> [3]: https://patchwork.kernel.org/patch/10340851/
>>> [4]: https://www.spinics.net/lists/alsa-devel/msg71617.html
>>>
>>> Based on linux-next tag: next-20180420
>>>
>>> Jorge Sanjuan (3):
>>>    ALSA: usb-audio: UAC3. Add support for mixer unit.
>>>    ALSA: usb-audio: Use Class Specific EP for UAC3 devices.
>>>    ALSA: usb-audio: UAC3 Add support for connector insertion.
>>>
>>> Michael Drake (1):
>>>    ALSA: usb-audio: ADC3: Fix channel mapping conversion for ADC3.
>>>
>>>   include/linux/usb/audio-v2.h   |   7 ++
>>>   include/linux/usb/audio-v3.h   |  14 +++
>>>   include/uapi/linux/usb/audio.h |  13 ++-
>>>   sound/usb/mixer.c              | 195 +++++++++++++++++++++++++++++++++++++----
>>>   sound/usb/stream.c             |  11 ++-
>>>   5 files changed, 217 insertions(+), 23 deletions(-)
>>>
>>> --
>>> 2.11.0
>>>
>>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
