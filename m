Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1558C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAD3206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL0hJyZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfBWDtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:49:42 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44859 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWDtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 22:49:41 -0500
Received: by mail-ed1-f67.google.com with SMTP id b20so3424774edw.11;
        Fri, 22 Feb 2019 19:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DqWt3UfZ4NBrp8He4mByAYHG1G+RK7SiDr2oLi31obE=;
        b=WL0hJyZBeTlHc3tUg3byrfJGQLHYAIPzMqRWj4jnlzi1lnBy0YF/USR8w9fsCplA2m
         ibb+/Eb2f8yECQMHFYMBLudNpyYAPahQfxBsl5DNIuApMQYu/KXmV+9tXqCgZGa7ukIm
         0uWo+mNvyhLOHu/1Xuy/5JLYlPn+k9L+31uq9By72jJauZ9tX+vUB3r4ZqRyYAUcwqOB
         VSZn6k+rpRLTKeR33Cb/UyoB4qP8HPAXTKfbME76hgLVLy/IuSX3micyiuBA5cH1vo8m
         Bl9/bXEh862XwIEOjXRLMvzWOKm0bH9PbdJkp8MosVOnsrkra++ZbpfnRod5bA2ECcOe
         v+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DqWt3UfZ4NBrp8He4mByAYHG1G+RK7SiDr2oLi31obE=;
        b=HjY6jNvrhHQEOHoUTLzYXQWFUG9FHWfUt78NJbH2qLFY8LonOJ8vIJ7zzQMRZ4kWNa
         0K5KufxeAxXB36m2XpPiGdB2xIAXusjt7F223tyzTFViQDrteLWPrdvYPHkB9iYvsIYa
         eCVSEuPl/Yz7LpjEwdwIoGplDuVrCcngL7/gLeAn2foe/mJwB95pZPCbCWrRKFg1hJ2d
         UdPzO/YRxKjLvslJfo5BDq9TpQhybYaGeTI2VAIB6asiC3HPOuUMatHQJgjcVbyRA0g1
         lNylNKvCsakm9EaIawdxWTo9oWXkSW553LlQ9/1LATmtxQMviTUfvET0awaHwSTAzKv3
         gYkg==
X-Gm-Message-State: AHQUAuaP+xUXxYUbm7NXBZhHAHNFm/g4ogaQX/eqXM0m8Z5K+BcHfg2D
        tHwHnMQ2w4c/h4BrnO+hovo=
X-Google-Smtp-Source: AHgI3IZXs+GTCQMwy2RUYMJyEOKQa0+2BTGNV9qKVF6CED3xcCY62IDb4V5gEqkDE8+NRT0uJBk3qw==
X-Received: by 2002:aa7:d396:: with SMTP id x22mr5643285edq.182.1550893778606;
        Fri, 22 Feb 2019 19:49:38 -0800 (PST)
Received: from [192.168.0.171] (179.187.203.120.dynamic.adsl.gvt.net.br. [179.187.203.120])
        by smtp.gmail.com with ESMTPSA id d17sm560308ejm.35.2019.02.22.19.49.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 19:49:37 -0800 (PST)
Subject: Re: X450LCP lost abillity to turn the screen off
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
References: <20190210192408.GA81989@bebop>
 <CAHp75Vc_0tLLSeVjiBLFXZXJSw7Evf=vmBrgbtsj11_SWS_rOg@mail.gmail.com>
 <691cc9a7-e126-a7cf-b3b2-ce5a77eadbeb@gmail.com>
 <CAOcMMieCjobcM_d-ojuL88cOWFCFZbo=z5X=QWyqi_q7LZ5xHw@mail.gmail.com>
 <e1be4724-38df-ac86-551c-7cfaf8e50b19@gmail.com>
 <CAOcMMifw3SZ7hp-ZPAVZeRPOpgYmqi3nkNSwZizWnNgVDBUyEw@mail.gmail.com>
 <725242e1-625a-f6bc-ffaa-a22052ae89f0@gmail.com>
Message-ID: <90a2d017-3e37-4a62-a55a-caf15416e188@gmail.com>
Date:   Sat, 23 Feb 2019 00:49:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <725242e1-625a-f6bc-ffaa-a22052ae89f0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi João,

On 2/13/19 7:46 PM, Marcos Paulo de Souza wrote:
> Hello João,
> 
> On 2/12/19 2:30 PM, João Paulo Rechi Vita wrote:
>> On Mon, Feb 11, 2019 at 6:31 PM Marcos Paulo de Souza
>> <marcos.souza.org@gmail.com> wrote:
>>>
>>> Hello João,
>>>
>>> On 2/11/19 5:14 PM, João Paulo Rechi Vita wrote:
>>>> Hello Marcos,
>>>>
>>>> On Sun, Feb 10, 2019 at 5:05 PM Marcos Paulo de Souza
>>>> <marcos.souza.org@gmail.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2/10/19 9:45 PM, Andy Shevchenko wrote:
>>>>>> On Sun, Feb 10, 2019 at 9:24 PM Marcos Paulo de Souza
>>>>>> <marcos.souza.org@gmail.com> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Since 5.0.0-rc4 I vefiried that my ASUS laptop
>>>>>>
>>>>>> Can you be more specific, what model, BIOS version, etc (also would be
>>>>>> nice to have dmi strings from it, I guess dmidecode tool would help).
>>>>>
>>>>> dmidecode attached.
>>>>>
>>>>>>> cannot turn the screen of
>>>>>>> anymore. There were several commits in 5.0 merge window touching this
>>>>>>> functionality like:
>>>>>>>
>>>>>>>    71b12beaf12f platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes
>>>>>>>    b3f2f3799a97 platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
>>>>>>>    78f3ac76d9e5 platform/x86: asus-wmi: Tell the EC the OS will handle the display off hotkey
>>>>>>>
>>>>>>
>>>>>> Can you bisect or just try to revert one-by-one from above and see
>>>>>> which one is a culprit?
>>>>>
>>>>> I already did some primary analysis, and it seems the commit 3f2f3799a97
>>>>> maps the x035 (which is Alt+f7 in my laptop) to SCREENLOCK, which is
>>>>> wrong because alt+f7 should be Screen Toggle. I will try to revert this
>>>>> commit, or remap to KEY_DISPLAYTOGGLE or KEY_DISPLAY_OFF, and test if it
>>>>> works.
>>>>>
>>>>
>>>> User-space does not act on KEY_DISPLAYTOGGLE / KEY_DISPLAY_OFF, these
>>>> values should be used when the hardware is turning the screen
>>>> back-light ON and OFF. According to Asus BIOS engineers, the
>>>> back-light used to be driven by the hardware, but they have changed to
>>>> the this new approach of telling the OS to drive the back-light for a
>>>> while now (no specific dates or BIOS / windows driver versions were
>>>> shared). They we actually surprised when we told the that some
>>>> machines still have a working implementation (and selected by default
>>>> unless told otherwise) of the old behavior, which sounds like it is
>>>> the case for the machine you have at hand.
>>>>
>>>> The new behavior, as defined in their spec is to only notify the OS of
>>>> the keypress with 0x35, and have the OS "close" the screen, with the
>>>> screen being "opened" on mouse or keyboard activity. This closely
>>>> matches the screen lock behavior on Linux platforms, so we are mapping
>>>> it to KEY_SCREENLOCK in the kernel, and it then gets mapped to
>>>> XF86ScreenSaver by xkeyboard-config, and finally gnome-settings-daemon
>>>> uses it as a lock screen shortcut (look for "screensaver" in
>>>> plugins/media-keys/shortcuts-list.h on the gnome-settings-daemon
>>>> repository).
>>>
>>> Interesting.
>>>
>>>>
>>>>> But yes, I'll do my best to track the problem ASAP at my side. Please
>>>>> let me know if I can provide any additional information.
>>>>>
>>>>
>>>> You can check what is being sent by the kernel with evtest, and what
>>>> is being sent by X with "xinput test <device id>" (and you can find
>>>> the device id with "xinput list"). And you can re-map it without
>>>> having to rebuild the kernel using udev's hwdb. But simply re-mapping
>>>> should not change anything, since userspace does not act on
>>>> KEY_DISPLAYTOGGLE / KEY_DISPLAY_OFF. If you want to switch back to the
>>>> old behavior you need to revert "78f3ac76d9e5 platform/x86: asus-wmi:
>>>> Tell the EC the OS will handle the display off hotkey".
>>>
>>> I tried reverting the patch and only recompiling/reinstalling the
>>> platform/x86 modules, but the problem still happens. My next step will
>>> be testing agains't 4.20, since my machine was working with 4.12, so I
>>> might try the major releases first.
>>>
>>
>> So maybe your desktop environment (KDE) acts on KEY_DISPLAYTOGGLE /
>> KEY_DISPLAY_OFF and this is the only reason why this was working in
>> the first place? It would be sad to find out different DEs behave
>> differently in this situation, but IMO
>> include/uapi/linux/input-event-codes.h is not super clear about
>> whether userspace should act on these values or they are just intended
>> to notify userspace of a change so desktop notifications (like an OSD)
>> can be shown. If that is the case you will need to revert all 3
>> commits you listed earlier. Also, make sure to check with evtest which
>> values are being sent by the kernel to make sure the correct code is
>> being executed.
> 
> I think you found the issue. Tried GNOME in the same machine, with the
> same kernel, and it works. I can revert those 3 commits and try again
> with a different DE, if you think it would help.

Let me elaborate it better:
* When using KDE, pressing Alt+F7, KDE only locks the screen
* When using GNOME, pressing Alt+F7, GNOME locks the screen and turns 
the screen off.

I hope it explains better what happened.

Thanks.

> 
> Thanks.
> 
>>
>>>>
>>>> That being said, I believe it would be more productive to figure out
>>>> why your userspace stack is not reacting to 0x35 / XF86ScreenSaver and
>>>> fix that. Which window manager / graphical desktop environment are you
>>>> using?
>>>
>>> Well, I'm using KDE Plasma 5 Desktop Environment (20170319-lp150.7.1) of
>>> openSUSE Leap 15.0.
>>>
>>>>
>>>> As a final note, from your dmidecode output I see you are on BIOS
>>>> version X450LCP.207, and there is version 208 available for download
>>>> on Asus website. I'm curious to know if it changes the old behavior
>>>> (with the patches you listed reverted), but I'm not responsible if a
>>>> BIOS update breaks your machine in any way, so just do it if you this
>>>> is something you are comfortable with and understand and assume all
>>>> the risks yourself. We have been reporting machines with the old
>>>> behavior back to Asus, but I don't know what they are doing with that
>>>> information, if anything. I'm adding your machine with the old BIOS
>>>> version to the list, so if you test the new BIOS let me know so I can
>>>> add that as well. But please don't feel any pressure to update the
>>>> BIOS if this is something you would not do otherwise.
>>>
>>> For now I would like to skip this upgrade, since it is nothing that I
>>> can play with now (I use this machine at work). I really hope that Asus
>>> could join fwupd, making such upgrades easier to apply on Linux machines.
>>>
>>
>> Absolutely, don't worry about the BIOS update.
>>
>>> Let me know if I can provide more info. I may have news in the next day
>>> about testing other kernels...
>>>
>>
>> Thanks for your feedback.
>>
>> --
>> João Paulo Rechi Vita
>>
