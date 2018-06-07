Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IA0qMRc3GVstYwAAmS7hNA
	; Thu, 07 Jun 2018 13:46:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 34426608B8; Thu,  7 Jun 2018 13:46:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4BEEC602FC;
	Thu,  7 Jun 2018 13:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BEEC602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932706AbeFGNqR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:46:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35495 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932347AbeFGNqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:46:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id j15-v6so19468888wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 06:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mZuv6I5bKA92dw4Axi1eughSUVmgICz/5WT/gG8/ltY=;
        b=D7zjVqn5N/COKRsusNlii/TQmqVbPKPOuWRJvEnqDRpdqbsEs7z4JcBOznsTDuLL8c
         AoTp+LC96JRLg4X+uopbp/Mg43NXkMuH91ePfD9ElgUdB6cbnjPWUWdr7llHBQ5BSSP6
         Ep7h2rHOFMGRPC0npETUx+cVHXJm/V6NzkwSl/T8pBz5sb+V7TOdR2RnlcB900v3Ww4s
         +00A++MRCuuvrfQ1KcRnkDzXy0E9mVQJ9HOeQW20kwC9fbBKqAH7pDGvUjkIS6uecIKI
         2fOt6F7WO7GScCHoSSW8C/HgFcUIG593lfjL8VPjEbtXSjDdyrVytBc1kpLx8sPX5XZD
         k8aQ==
X-Gm-Message-State: APt69E2rqQ5FdCciY5HHyrQ4wATuvfBRtU3hao5l7S6siox/+xBxl/1L
        P7eFbyYgs2rEYaVgNkf/MJf7F0hSmsg=
X-Google-Smtp-Source: ADUXVKIfyle5EcQ9Dpez4PXDA0lT5zt+xMu9z8W4Gcf94Cg2blt4uaPxMp/AnHS3l+UZv0Sf1Nmanw==
X-Received: by 2002:a1c:1c8f:: with SMTP id c137-v6mr1681426wmc.142.1528379173818;
        Thu, 07 Jun 2018 06:46:13 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id l67-v6sm2384867wmb.22.2018.06.07.06.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 06:46:12 -0700 (PDT)
Subject: Re: [PATCH v6 2/5] efi: Add embedded peripheral firmware support
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Martijn Coenen <maco@android.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        dmitry.torokhov@gmail.com, mfuzzey@parkeon.com,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        nbroeking@me.com, Torsten Duwe <duwe@suse.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180601125330.25054-1-hdegoede@redhat.com>
 <20180601125330.25054-3-hdegoede@redhat.com>
 <20180605210753.GC4511@wotan.suse.de>
 <30260c62-eb8b-7d88-4ce1-83e969546790@redhat.com>
 <20180606214205.GI4511@wotan.suse.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <4cb520a0-d3c8-477d-5d05-7b05637f5faf@redhat.com>
Date: Thu, 7 Jun 2018 15:46:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606214205.GI4511@wotan.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-06-18 23:42, Luis R. Rodriguez wrote:
> On Wed, Jun 06, 2018 at 08:39:15PM +0200, Hans de Goede wrote:
>> On 05-06-18 23:07, Luis R. Rodriguez wrote:
>>>> +To make request_firmware() fallback to trying EFI embedded firmwares after this,
>>>> +the driver must set a boolean "efi-embedded-firmware" device-property on the
>>>> +device before passing it to request_firmware().
>>>
>>> No, as I have requested before I don't want this, it is silly to have such
>>> functionality always be considered as a fallback if we only have 2 drivers
>>> which need this. > Please add a call which only if used would then *evaluate*
>>> such fallback prospect.
>>
>> Ok, so I've a few questions about this:
>>
>> 1) You want me to add a:
>>
>> int firmware_request_with_system_firmware_fallback(struct device *device, const char *name);
>>
>> function?
> 
> The idea is correct, the name however is obviously terrible.
> 
> This is functionality that is very specialized and only *two* device drivers
> need it that we are aware of which would be upstream. Experience has shown
> fallback mechanisms *can* be a pain, and if we add this we will be supporting
> this for *life*, as such I'd very much prefer to:
> 
> a) *Clearly* reduce the scope of functionality clearly *beyond* what you
>     have done.
> 
> b) Have access to one simple call which folks can use to *clearly* and
>     quickly grep for those oddball drivers using this new interface.
> 
> We can do this by using a separate function for it.
> 
> Before you claim something seems unreasonable from the above logic, please read
> the latest state of affairs with respect to data driven Vs functional API
> evolution discussion over the firmware API [0] as well as my latests
> recommendation for what to do for the async firmware API [1].
> 
> The skinny of it is that long ago I actually proposed having only *two*
> firmware API calls, an async and a sync call and having all functionality
> fleshed out through a structure of parameters. The issue with that strategy was
> it was *too* data driven, and as per Greg's request we'll instead be exposing
> new symbols per functionality for the firmware API with his justification
> that this is just what is traditionally done on Linux. Hence we have
> firmware_request_nowarn() now for just a slight variation for a sync call.
> 
> Despite Greg's recommendation -- for the respective async functionality I
> suggested this is not going to scale well -- it is also just dumb to follow the
> same approach there for a few reasons.
> 
> 1) We have only *one* async call and had decided to *not* provide a structure
>     for that call since its inception
> 
> 2) Over time have evolved this single async call each time we have a new feature,
>     causing a slew of collateral evolutions.
> 
> So, while we like it or not, it turns out the async call to the firmware API
> is already completely data driven. Extending it with just another argument
> would just be silly now.
> 
> So refer to my recommendations to Andres for how to evolve the async API if
> you need it, however from a quick review you don't need async calls, so you
> won't have to address any of that.
> 
> [0] https://lkml.kernel.org/r/20180421173650.GW14440@wotan.suse.de
> [1] https://lkml.kernel.org/r/20180422202609.GX14440@wotan.suse.de
> 
>> Note I've deliberately named it with_system_firmware_fallback
>> and not with_efi_fallback to have the name be platform agnostic in
>> case we want something similar on other platforms in the future.
> 
> firmware_request_platform() ?
> 
>> And then have this pass a new FW_OPT_SYS_FW_FALLBACK flag to
>> _request_firmware(), right ?
> 
> Yeap.
> 
>> 2) Should this flag then be checked inside _request_firmware() before it
>> calls fw_get_efi_embedded_fw() (which may be an empty stub),
> 
> You are the architect behind this call, so its up to you.
> 
> To answer this you have to review the other flags and see if other users of the
> other flags may want your functionality. For instance the Android folks for
> instance rely on the FW_OPT_NOFALLBACK - the sysfs fallback mechanism to
> account for odd partition layouts. Could they ever want to use your fallback
> mechanism? Granted your mechanism is for x86, but they could eventually add
> support for it on ARM.
> 
> Checking if the firmware is on the EFI platform firmware list is much faster
> than the fallback mechanism, that would be one gain for them, as such it may
> make sense to check for firmware_request_platform() before using the sysfs
> fallback mechanism.  However if Android folks want to always override the
> platform firmware with the sysfs fallback interface we'd need another flag
> added and call to then change the order later if we checked for for the
> platform firmware first.

I believe we agreed a while back that the platform fallback would
replace the sysfs one when requested. I believe that still makes
sense. If a driver wants both it can simply call request_firmware_foo
itself twice and determine the order itself.

> If you however are 100% sure they won't need it, than checking
> firmware_request_platform() first would make sense now if you are
> certain these same devices won't need the sysfs fallback interface
> and don't want to use it to override the platform firmware.
> 
>> or
>> inside fw_get_efi_embedded_fw()?
> 
> You'll definitely want to check it there for sure to no-op if you
> don't have it set and error out with the same error passed before
> so it is not lost, as is done now for the sysfs fallback mechanism.
> 
>> 3) Also should I then still check device_property_read_bool(dev,
>> "efi-embedded-firmware") inside fw_get_efi_embedded_fw(), or do you
>> want to simply always try the fallback if the driver indicates this ?
>>
>> The reason I'm asking this is because the presence or not of the
>> firmware inside the system-firmware is a per board thing, not
>> a per driver thing. But since the firmware is unique per board
>> anyways it would be fine to skip the "efi-embedded-firmware"
>> device-prop check. If we're going to have a separate
>> firmware_request_with_system_firmware_fallback() function for
>> this then I'm leaning towards dropping the whole check myself.
>>
>> So are you ok with dropping the device-prop check then ?
> 
> Yes I was actually not sure why you added it, but given you say that its per
> board, it makes sense. Drivers still would still need to enable the new
> fallback via the new call, say firmware_request_platform().  I suppose it would
> depend on how many boards out there *don't* have the firmware. Since we are
> aware of only two drivers enabling this I'm going to suspect we have only a few
> boards out there with this firmware...
> 
> The value of the device-prop check then would be to *avoid* running this code
> even further for boards where it does not make sense. This is indeed valuable,
> so unless others have issue with it I'd say leave it and document this exact
> thing.
> 
> The documentation should then reflect firmware_request_platform() enables the
> fallback for the driver, however boards must use the efi-embedded-firmware
> property to further activate the fallback for a specific board.
> 
>> 4) Since I'm naming the new function
>> int firmware_request_with_system_firmware_fallback()
>> I'm thinking that fw_get_efi_embedded_fw() should be renamed
>> to firmware_fallback_system_firmware()
>> and the EFI based code
>> will just be the first (and for now only) provider of this
>> fallback with an empty stub (inline in the .h file) for when
>> there is no provider defined. Do you agree with renaming
>> fw_get_efi_embedded_fw() to
>> firmware_request_with_system_firmware_fallback() ?
> 
> That's obviously too long, so perhaps firmware_fallback_platform()?
> 
> Note that Andres recently renamed fw_sysfs_fallback() to
> firmware_fallback_sysfs() so yes, I was expectign this.
> 
> Also notice all that new shiny kdoc on firmware_fallback_sysfs()?  Please be
> sure to add your own and refer to it on the kernel documentation as well -- it
> seems we forgot to reference firmware_fallback_sysfs() on Documentation/ I'll
> go and correct that.
> 
> While at it, I just noticed your most of your changes should actually
> go into Documentation/driver-api/firmware/fallback-mechanisms.rst and only
> this new call firmware_request_platform() on
> Documentation/driver-api/firmware/request_firmware.rst
> 
>> (note this is the wrapper which calls efi_get_embedded_fw()
>> which itself will not be renamed of course).
> 
> Yeap :)

Thank you for your answers. I will prepare a v7 of this series with the
changes as discussed. I've several higher priority things to fix first
though, so it may be a while before I post v7.

Regards,

Hans
