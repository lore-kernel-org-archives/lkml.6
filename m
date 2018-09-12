Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1860C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A810020880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A810020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeILORQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:17:16 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:54017 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbeILORP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:17:15 -0400
Received: by mail-wm0-f54.google.com with SMTP id b19-v6so1525322wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bhKQo4X70prIt+UwUKyzKvZK31h5vf1Jdj+alb5cndc=;
        b=F7iVkCLq8YCqMuQREZ80wz/FbKsH69zBK0abNpNRLPXp1l0CVUSxOB6CVPj6iLog6f
         ybRArRdPbOLht8gcdK5UsUol/2xDD8vUbxwNjE17A8/mleGqCSO9Bffz+Ol+WC3PfDx2
         FSzed9YRsVOmd3v/+oqCrieYotH9v3pMdF1FlpdJbCql8FARD5yi77/+CFwP8MOm0Kus
         EnKs5j09a5OFNocNhQ7y29lhSWN7GhwnQNR8prB3veSUoYHBzOnfOwUGiiSnd9uHYsei
         8GddMLTOWdkmtzbrjsn4ytoml/Ua8uujOc4OZ3VxJVvL2FHrNY8hJPBcaxD9e7IjwK2w
         JW3A==
X-Gm-Message-State: APzg51Bb+36VToOz1Voa8T8bvjz38napHL0ghoV8WLr8APf0ZyfGn9uG
        K/ezlF2Dgt9rc5AqLutbX42f2Q==
X-Google-Smtp-Source: ANB0VdbnElk0Lzs3bnclkR02VyaFFcGiFio88t6g5oPBB4LDHeL9lT5bI2VU5SjzzbbGXnNO2LveAA==
X-Received: by 2002:a1c:f913:: with SMTP id x19-v6mr985849wmh.63.1536743616568;
        Wed, 12 Sep 2018 02:13:36 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 34-v6sm872316wra.20.2018.09.12.02.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 02:13:35 -0700 (PDT)
Subject: Re: [REGRESSION] boot-screen override by "34db50e55656 efifb: Copy
 the ACPI BGRT"
To:     David Herrmann <dh.herrmann@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-efi@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <CGME20180903132353epcas4p373e876f1b52dbed6df7bd3acc73fcdf4@epcas4p3.samsung.com>
 <CANq1E4QwNg0VuAZZtatOTXspv7Y-z_HSa-9CHzK2Y28CGK8W4Q@mail.gmail.com>
 <1982440.Fn0LzJ7a3l@amdc3058>
 <dc7f08d7-77fc-92ca-b6ec-f9d5a8f24cf3@redhat.com>
 <CANq1E4TiMSY=udGJWZoDzMhdsRjC==QCRFPO+Oja7KoyBX-6fg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9e9e269d-6ac7-7826-ecd5-acc164025429@redhat.com>
Date:   Wed, 12 Sep 2018 11:13:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CANq1E4TiMSY=udGJWZoDzMhdsRjC==QCRFPO+Oja7KoyBX-6fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-09-18 17:11, David Herrmann wrote:
> Hey
> 
> On Mon, Sep 3, 2018 at 4:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 03-09-18 16:16, Bartlomiej Zolnierkiewicz wrote:
>>>
>>> Hi,
>>>
>>> On Monday, September 03, 2018 03:23:38 PM David Herrmann wrote:
>>>> Hey
>>>>
>>>> Since this commit:
>>>>
>>>>       34db50e55656 efifb: Copy the ACPI BGRT
>>>>
>>>> the kernel will override boot-splashs unasked. This breaks the
>>>> graphical boot-process on our setups. In particular, we have a setup
>>>> where an efi-boot-entry draws the early boot-splash on-screen, then
>>>> hands-over to the linux-kernel + initrd. The boot-splash daemon in the
>>>> initrd then takes over control of possible animations.
>>>>
>>>> With the mentioned commit compiled in, the kernel will redraw the
>>>> firmware logo on screen at a random time without any way to intervene.
>>>
>>> You have CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y (the deferred
>>> console takeover support introduced in v4,19-rc1). I assume that this
>>> is intended?
>>>
>>>> What is the intention of this commit? Why is the kernel re-drawing the
>>>> firmware logo unasked? If someone during the boot-process draws
>>>> content on the screen, I would prefer if the kernel does not clear
>>>> that on driver load.
>>>
>>> +/*
>>> + * If fbcon deffered console takeover is configured, the intent is for the
>>> + * framebuffer to show the boot graphics (e.g. vendor logo) until there is some
>>> + * (error) message to display. But the boot graphics may have been destroyed by
>>> + * e.g. option ROM output, detect this and restore the boot graphics.
>>> + */
>>> +#if defined CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER && \
>>> +    defined CONFIG_ACPI_BGRT
>>> ...
>>> +static void efifb_show_boot_graphics(struct fb_info *info)
>>> ...
>>> +#else
>>> +static inline void efifb_show_boot_graphics(struct fb_info *info) {}
>>> +#endif
>>>
>>>> Can we either provide an option to disable this feature, or revert the commit?
>>>
>>> Hans?
>>
>> We use the ACPI bgrt extension to get the logo to draw and then
>> draw it since some devices rely on the OS to draw it and otherwise we
>> just end up with a blackscreen when doing silent / flickerfree boot.
>>
>> Ideally you would be able to get your vendor to put the logo in firmware
>> in the ACPI bgrt extension, then you also do not need to play any tricks
>> with an EFI binary drawing your own logo. But I can understand if you don't
>> have control over this, so you need to do this with the EFI binary trick.
>>
>> I can also understand that you want to use deferred console takeover
>> in a setup like yours to avoid fbcon messing up what is on the display
>> during boot, that is exactly what it is for. So I think a reasonable
>> approach here is to add a kernel commandline option, say:
>>
>> video=efifb:nobgrt
>>
>> David, would that work for you?
> 
> That would be perfect!

Ok, I just send out a patch for this with you in the Cc.

Sorry for taking a bit long to write the patch.

Regards,

Hans

