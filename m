Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524734771; cv=none;
        d=google.com; s=arc-20160816;
        b=M9Q/3nbquwAWat27Wi85hRn8nEBcBJSazdizae3/POgJmPfsTq+EDcZ/fBbESfXEvP
         tkao3izaS+6pOFntb1+7C3WgCEFFp4U74DsrwqWwWV563GPxi+WqX9nEJVMu6/Bwy3uR
         oAxe6sk1Aa/4QgQPKslSLVDZrW5CGrPP57HzWyapXgaVwOYnS8CGDIeWwFDgdAnZlYx2
         UdjSdcL2cy3JbH/zWeMZRoe5M3EmPrAivIsfJopXCqmeWez+2RtF0Ipfgwzjs040iSLZ
         x7C1FSRTEG+bTwCNXeiFgojVwwe+ROflKF3/6k98+Ag75XkDOvhkqMuEiUZy7JHWIY9A
         hOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ClZt5Zn/d+kMfuWdOlwPS5jYcdRb6ywL01OywEYIoOQ=;
        b=bKn0f0NeAwZlwX5e0PZY6tLulJgJwI6AsojZRDVdImVQLKuKVdQDbDfoTAEdM39nKB
         AGj2zL7cbf9BO9g/oQiWw7/t9gX0nKQGtJotNpstkFbLJr12iAi59miJUPdj3Uvak/tm
         zBMIuNfXGou4/9udjldLz1QBVZzma49MXqvxZS+Fiol1fTyHmNMADpKqwm6BUIacgfX2
         a3fmV/FXJpuIsbRg9NFhOXIv55VILoqMwJ0NiVPqJ83SeDDe20/KjIcBNL5tvZmwGn5L
         7j5EwLzpULUoy2yO4YZZcN6zEcdWawmsaBm5b4zOKIiMrKzCXgUYKdZ4l4+U2DH8YRAx
         /AUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GRg0IOrw;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GRg0IOrw;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49+u3Uhqoqq7uealuOKmNzuXYXqoGY7D2dHitZ4Ks5fl1gqp8ROL6ffVYeaV2ePICrM1FTA+p7zDBgrluZp0pc=
MIME-Version: 1.0
In-Reply-To: <s5hy3hcwkhy.wl-tiwai@suse.de>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180424172445.31928-1-jorge.sanjuan@codethink.co.uk> <s5hy3hcwkhy.wl-tiwai@suse.de>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Thu, 26 Apr 2018 12:26:10 +0300
Message-ID: <CAB=otbSyFftwzq9YXvyFWOcKZQch+Hd0XVWugPzJ3O2nb3hYZQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 0/4] ALSA: usb: UAC3 new features.
To: Takashi Iwai <tiwai@suse.de>, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285487756615401?=
X-GMAIL-MSGID: =?utf-8?q?1598800287836629825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 9:02 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 24 Apr 2018 19:24:41 +0200,
> Jorge Sanjuan wrote:
>>
>> v2 fixes:
>>  - If/else statements braces style fixes.
>>  - Add wrapping function to mixer unit code.
>>  - Make connectors control kctl struct const.
>>  - Little endian to cpu conversion in several places.
>>  - Sing off and add Fixes tag to fixup commit.
>>  - Remove flex-array for a struct that is used statically.
>>
>> Now that the UAC3 patch [1] has made it to linux-next I have some extra
>> features to make a UAC3 device fully work in Linux. Including Jack
>> insertion control that I have put on top of this other patch [2] for
>> UAC2. Also adding support for the UAC3 Mixer Unit which is most likely
>> to appear in most headset type devices.

Thanks for adding these improvements!

>
> These patches look reasonable, I'm OK to merge.  But I'll wait for
> Ruslan's comments (or at best with test results).

I reviewed first 3 patches and will review jack detection patch later,
and I'm going to test this patchset in a next few days.

>
>> UAC3 devices also require to have a Basic Audio Device (BADD) in a separate
>> config for which both Ruslan Bilovol and myself have submited different
>> approaches[3][4] but I don't know what the final merge will be. Once there
>> is official support for BADD, we'll need to test it with an actual UAC3
>> device to confirm it all wokrs.
>
> Could you guys try to get agreement which approach should we take?
>
> I have no big preference.  Currently Ruslan's patch series look
> easier, just because its addition is a bit smaller, though.

The BADD devices are quite simple, so direct initialization internal ALSA
structures looks easy and straightforward, comparing to generation of
missing descriptors.
I'm currently improving the patch series so it will look even more
smaller and easier, let's see how it goes

Thanks,
Ruslan

>
>
> Thanks!
>
> Takashi
>
>> All this features are tested with an actual UAC3 device that is still in
>> development. For this patch series, only the legacy config (#1. UAC1/UAC2)
>> and the UAC3 config have been tested. The BADD config is only tested using
>> and updated verison of [4].
>>
>> [1]: https://patchwork.kernel.org/patch/10298179/
>> [2]: https://patchwork.kernel.org/patch/10305847/
>> [3]: https://patchwork.kernel.org/patch/10340851/
>> [4]: https://www.spinics.net/lists/alsa-devel/msg71617.html
>>
>> Based on linux-next tag: next-20180420
>>
>> Jorge Sanjuan (3):
>>   ALSA: usb-audio: UAC3. Add support for mixer unit.
>>   ALSA: usb-audio: Use Class Specific EP for UAC3 devices.
>>   ALSA: usb-audio: UAC3 Add support for connector insertion.
>>
>> Michael Drake (1):
>>   ALSA: usb-audio: ADC3: Fix channel mapping conversion for ADC3.
>>
>>  include/linux/usb/audio-v2.h   |   7 ++
>>  include/linux/usb/audio-v3.h   |  14 +++
>>  include/uapi/linux/usb/audio.h |  13 ++-
>>  sound/usb/mixer.c              | 195 +++++++++++++++++++++++++++++++++++++----
>>  sound/usb/stream.c             |  11 ++-
>>  5 files changed, 217 insertions(+), 23 deletions(-)
>>
>> --
>> 2.11.0
>>
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
