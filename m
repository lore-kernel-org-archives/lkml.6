Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1EFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496752086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDGaOSVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496752086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeJKHDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:03:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41322 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKHDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:03:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id m77-v6so3394933pfi.8;
        Wed, 10 Oct 2018 16:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4cGv9KSq9spv+wQx2gf6A+VcNeYBZE+cG0/uYugPfAg=;
        b=pDGaOSVE1g6O14Po+fhe82fIm1YYF39pg1YMdEMO5xKfdTwiIbOa9pvQGkXyUpTLSd
         KY9ktfxrn9XPn2rEUC4jyJKzc6OTsGekB13iHpFYxFAkQgqMtkYCz6G372Tkgp7dEmrH
         sVkGzv+QkUcIJWr5Ta0JC1dYZn6wAKjrzzEiAQyIHh/cjtIPxBCumRL+1zKsTTjxoc9n
         ddRpRvapJHhH7tFWP7lnKjqRvVMqwxUxoOyVb3K2i8oDhcFaLzraJd98zl8wC6bPHP8B
         EwJP2J1r3PaCpx93CiZzW2wWbWh822L3xaJFU8AyCVd93/UOdXnDSFEal60I2CpQV+eq
         pHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4cGv9KSq9spv+wQx2gf6A+VcNeYBZE+cG0/uYugPfAg=;
        b=iynfY6ul0O1hDsVYo18XcM/Ko+iNZnFvlXErPnWj4uHmAIeiRgIChGedsfaKn/rxss
         3TfDiSZkAWcUSVDhRVcQpmSS0MhDhoL/2On+qo0IWjmCfkwsBdqffFs2OcjKG+Kgj9R9
         Qu7waepT55bOQ9spZ2kyn5ZZlovYnWJzLzDkJYEs7BOpkw4ccd1DojkRI0iQ7DpYwAnA
         1JZHecvg5CcuBZeEytbFgokqZDv7YlHGw4OTiHy+o99JKyCS1XoPvuuh0lnCS9ppgxp5
         SsfiSG+JPA4BZJdUyv/EuI4YGpRGN/8xBvQSzsQ3icMA0WOark67QDT4nDfPFDqn6s0g
         UbPw==
X-Gm-Message-State: ABuFfoiKrSVhAgX6H/prP9RC2zT49eLDc5dVUpgn+1OfrJVB2zsGa5NA
        NigNRY8VsIv+PQMwdHgYYVNKy5/7
X-Google-Smtp-Source: ACcGV62onWSUbGyBo+v3NA/TgNAgt2tTNnVCZgfjVcdvfYAjJXNxQs2mpdwxWIdjHu51ur1kBRggzw==
X-Received: by 2002:a62:8891:: with SMTP id l139-v6mr36587056pfd.198.1539214712637;
        Wed, 10 Oct 2018 16:38:32 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:bde3:602:d806:663b? ([2001:df0:0:200c:bde3:602:d806:663b])
        by smtp.gmail.com with ESMTPSA id t15-v6sm60741709pfj.7.2018.10.10.16.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 16:38:31 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock
 behaviour
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20181008152523.70705-1-sashal@kernel.org>
 <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
 <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
 <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
 <1cbc87c6-7920-1f53-879b-79de87d685fc@gmail.com>
 <CAMuHMdUiAVamY--BMBFprEwdXn1Dyv9sERwMXB7x7F9omiEXkA@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <628c2f56-5381-b526-bad7-fd902acf14d5@gmail.com>
Date:   Thu, 11 Oct 2018 12:38:26 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUiAVamY--BMBFprEwdXn1Dyv9sERwMXB7x7F9omiEXkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,


On 10/10/18 19:59, Geert Uytterhoeven wrote:
> Hi Michael,
>
> On Wed, Oct 10, 2018 at 12:07 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> I agree the bug is neither subtle nor recent, not security relevant and
>> will affect only a handful of users at best.
>>
>> If you're worried about weakening the rules around stable releases, by
>> all means go ahead and veto the inclusion of these patches in the next
>> stable release.
> I believe the distro the issue was reported against (Debian ports) will not
> get the fix until the issue is fixed in the upstream stable release?

That's correct. but there are ways around that. I could petition Ben to 
add it as a separate patch for now.

Boils down to the same question really - what's the impact of this bug? 
Will it prevent installation from distribution media f.e.?

Given that it's taken ten years for someone to even notice one aspect 
(missing key mappings), and then I just happened to see the discussion 
on the ML (which wasn't even about mapping so much as about keys stuck 
in autorepeat, which I haven't been able to reproduce), I think it's 
clear that this has minimal impact. m68k users tend to be reasonably 
computer savvy, and can install a custom built kernel until Debian 
catches up with current kernel versions.

Having reread Documentation/process/stable-kernel-rules.rst, it's hard 
for me to argue these patches belong in stable.

Cheers,

     Michael


>
>> On 09/10/18 08:20, Dmitry Torokhov wrote:
>>> On Mon, Oct 8, 2018 at 12:09 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>>>> someone on debian-68k reported the bug, which (to me) indicates that the
>>>> code is not just used by me.
>>>>
>>>> Whether or not a functioning Capslock is essential to have? You be the
>>>> judge of that. If you are OK with applying the keymap patch, why not
>>>> this one?
>>> I have exactly the same concerns about the keymap patch. This all has
>>> not been working correctly for many many years (and it was not broken
>>> in a subtly way as far as I understand, but rather quite obvious).
>>> Thus I do not understand why this belongs to stable release. It is not
>>> a [recent] regression, nor secutiry bug, nor even enabling of new
>>> hardware, that is why I myself did not mark it as stable.
>>>
>>> I still maintain that we pick up for stable too many patches for no
>>> clear benefit. This is similar to the patch for Atmel controllers that
>>> was picked to stable and I asked why, as it is not clear how many
>>> users might be affected (or if the problem the patch was solving was
>>> purely theoretical, or only affecting hardware that is not in
>>> circulation yet).
>>>
>>>> Debian will carry stable patches without explicit action on behalf of
>>>> the maintainer. Unstable patches are a little harder to get accepted.
>>>>
>>>> On 09/10/18 06:11, Dmitry Torokhov wrote:
>>>>> On Mon, Oct 8, 2018 at 8:25 AM Sasha Levin <sashal@kernel.org> wrote:
>>>>>> From: Michael Schmitz <schmitzmic@gmail.com>
>>>>>>
>>>>>> [ Upstream commit 52d2c7bf7c90217fbe875d2d76f310979c48eb83 ]
>>>>>>
>>>>>> The CapsLock key on Atari keyboards is not a toggle, it does send the
>>>>>> normal make and break scancodes.
>>>>>>
>>>>>> Drop the CapsLock toggle handling code, which did cause the CapsLock
>>>>>> key to merely act as a Shift key.
>>>>> This has been broken for 10+ years. Does it really make sense to
>>>>> promote it to stable?
>>>>>
>>>>>> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
>>>>>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>>>>> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
>>>>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>>>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>>>>>> ---
>>>>>>     drivers/input/keyboard/atakbd.c | 10 ++--------
>>>>>>     1 file changed, 2 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
>>>>>> index 524a72bee55a..fdeda0b0fbd6 100644
>>>>>> --- a/drivers/input/keyboard/atakbd.c
>>>>>> +++ b/drivers/input/keyboard/atakbd.c
>>>>>> @@ -189,14 +189,8 @@ static void atakbd_interrupt(unsigned char scancode, char down)
>>>>>>
>>>>>>                    scancode = atakbd_keycode[scancode];
>>>>>>
>>>>>> -               if (scancode == KEY_CAPSLOCK) { /* CapsLock is a toggle switch key on Amiga */
>>>>>> -                       input_report_key(atakbd_dev, scancode, 1);
>>>>>> -                       input_report_key(atakbd_dev, scancode, 0);
>>>>>> -                       input_sync(atakbd_dev);
>>>>>> -               } else {
>>>>>> -                       input_report_key(atakbd_dev, scancode, down);
>>>>>> -                       input_sync(atakbd_dev);
>>>>>> -               }
>>>>>> +               input_report_key(atakbd_dev, scancode, down);
>>>>>> +               input_sync(atakbd_dev);
>>>>>>            } else                          /* scancodes >= 0xf3 are mouse data, most likely */
>>>>>>                    printk(KERN_INFO "atakbd: unhandled scancode %x\n", scancode);
>>>>>>
> Gr{oetje,eeting}s,
>
>                          Geert
>

