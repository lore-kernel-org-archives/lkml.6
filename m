Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D5720841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEddYV67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D5720841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbeGaVn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:43:26 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33564 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732498AbeGaVnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:43:25 -0400
Received: by mail-it0-f65.google.com with SMTP id d16-v6so13383334itj.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1xTMFlxyM/rzgBRYUKXUbkRBxujoYMpzm2IIxrfdjz4=;
        b=DEddYV67Gh62AGZz+PNs9g2Y16cVdNyy888pUgV607rRiH4RMjU6VaaPLPSlVX9X0G
         CUfg2xPjNyOwX0rrku8odOZyMEJxg9cCJ37yxvVdqIG+/mOmPhiiexsWewFW/2WtVHXQ
         FqNu4zId3uJwQ8SjXHaYbqA+PNG7aEXqmUSKAYfPxuwzf1jNS656hXEUp5Ihz6fza9/Y
         9L6CpsAMphzH28Rykbnr2sjkCVKVv8utp47BOZG9pIMmSjs4A8fWOMlfw7JB1Ch3J5cO
         SxM5WYpnGJiSu/B3pr02FqpucsxG8pQz1p0D8uPN96z0Pb7d5BUtlUzIYkS+TJ03zvdz
         HfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1xTMFlxyM/rzgBRYUKXUbkRBxujoYMpzm2IIxrfdjz4=;
        b=OD04f7gvQCTpC0ax87cXUs/7az6mPTo93RiDLS9kpp2aLo3JU0jldckuhAe49a54qx
         dnYCd8WB+L7T0U55M7u92uObww4TGrQdp+/aZuIgY3NZTbtopghbFTuII88CE3hX3Qo4
         PvbAmRGpSZ52I2M7R0FK7nHzGcgWz4ZTSxbAVH7h0C18h+1xmRiZCOsVfkFXph4FqeiK
         NtJpuz8TIhYRFh5HXfy5oFsqq5JlDn2USVw2MQp51SBBNcyxA80hX8B/wjsW4u9F3mmz
         QTLCkmyQ2gJmfP5nzFi1HllSwFjdhi0DNyGwKORsokJ4/FTjmIl+R1U6cNVX8dDg+ZiV
         v5vQ==
X-Gm-Message-State: AOUpUlFonuoK1KoGz/1KMHUHKKTFIyb8kvX/47IapXugYmK4d9AiTB2S
        AvybStfP597hOmAsdB7SzWA=
X-Google-Smtp-Source: AAOMgpfrJ6tR9VfyIEvCZobY+z3DVjTsdKBzTIlGTDMQpbY2HhnDlTfcQn8AycFV1kUHo7O1VnoDjw==
X-Received: by 2002:a24:7c4a:: with SMTP id a71-v6mr1043931itd.69.1533067289233;
        Tue, 31 Jul 2018 13:01:29 -0700 (PDT)
Received: from [10.0.2.15] ([72.138.96.106])
        by smtp.gmail.com with ESMTPSA id c141-v6sm2266504itc.42.2018.07.31.13.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:01:28 -0700 (PDT)
Subject: Re: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, John Paul Walters <jwalters@isi.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Colin <acolin@isi.edu>,
        linux-arm-kernel@lists.infradead.org
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu> <20180731084143.GA4680@arm.com>
 <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
 <20180731155228.GN17271@n2100.armlinux.org.uk>
 <044af717-3883-a7a6-c346-18fa8cebce76@gmail.com>
 <20180731181834.GA30658@n2100.armlinux.org.uk>
From:   Alex Bounine <alex.bou9@gmail.com>
Message-ID: <570ad147-3c58-8911-0111-29e21087ca7a@gmail.com>
Date:   Tue, 31 Jul 2018 16:01:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731181834.GA30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-31 02:18 PM, Russell King - ARM Linux wrote:
> On Tue, Jul 31, 2018 at 01:59:27PM -0400, Alex Bounine wrote:
>> On 2018-07-31 11:52 AM, Russell King - ARM Linux wrote:
>>> On Tue, Jul 31, 2018 at 08:54:14AM -0400, Alex Bounine wrote:
>>>> On 2018-07-31 04:41 AM, Will Deacon wrote:
>>>>> On Mon, Jul 30, 2018 at 06:50:34PM -0400, Alexei Colin wrote:
>>>>>> Platforms with a PCI bus will be offered the RapidIO menu since they may
>>>>>> be want support for a RapidIO PCI device. Platforms without a PCI bus
>>>>>> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
>>>>>> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
>>>>>>
>>>>>> Tested that kernel builds for arm64 with RapidIO subsystem and
>>>>>> switch drivers enabled, also that the modules load successfully
>>>>>> on a custom Aarch64 Qemu model.
>>>>>>
>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>>>> Cc: John Paul Walters <jwalters@isi.edu>
>>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>>> Cc: linux-kernel@vger.kernel.org,
>>>>>> Signed-off-by: Alexei Colin <acolin@isi.edu>
>>>>>> ---
>>>>>>   arch/arm64/Kconfig | 2 ++
>>>>>>   1 file changed, 2 insertions(+)
>>>>>
>>>>> Thanks, this looks much cleaner than before:
>>>>>
>>>>> Acked-by: Will Deacon <will.deacon@arm.com>
>>>>>
>>>>> The only thing I'm not sure about is why we don't just select HAS_RAPIDIO
>>>>> unconditionally in the arm64 Kconfig. Does selecting only that option
>>>>> actually pull in new code to the build?
>>>>>
>>>> HAS_RAPIDIO option is intended for SOCs that have built in SRIO controllers,
>>>> like TI KeyStoneII or FPGAs. Because RapidIO subsystem core is required
>>>> during RapidIO port driver initialization, having separate option allows us
>>>> to control available build options for RapidIO core and port driver (bool
>>>> vs. tristate) and disable module option if port driver is configured as
>>>> built-in.
>>>
>>> Your explanation doesn't make much sense to me.
>>>
>>> RAPIDIO is the bus-level support, right?  So drivers that depend on
>>> the bus-level support should depend on RAPIDIO, and so, if RAPIDIO
>>> is configured as a module, they will also be allowed to be disabled
>>> or a module, but not built-in if tristate.  If it is boolean, and
>>> causes the driver to be built-in to the kernel, then you need to use
>>> "RAPIDIO=y" so that it's dependency is only satisfied when the core
>>> is built-in.
>>>
>>
>> RapidIO host controllers (on local bus like SoC internal or PCIe) are
>> serviced by MPORT device drivers that are subsystem specific and communicate
>> with RapidIO core using set of callbacks. Depending on HW architecture these
>> drivers may be defined as built-in or module.
> 
> Why does hardware architecture define whether something has to be built
> in or can be modular?
> 
> It is the case today that (eg) on-SoC hardware _can_ be built as a module
> if desired - just because it's on the SoC does not mean it has to be
> built in to the kernel.  Why is RapidIO any different?
>

Not HW architecture - legacy can be blamed as well. Freescale's FSL_RIO 
driver still exist as built-in so far. Intent of this patch set is to 
allow RapidIO support in more architectures without reworking old stuff.
I do not think that anyone will be updating FSL_RIO driver soon.

Also we cannot dictate to developers of future drivers which method to 
use - they may have built-in option only for the first release.

Unfortunately we have on hands dependency between mport driver build 
mode and  RapidIO core which we need to respect.


>> Built-in driver will require presence of the RapidIO core during its
>> initialization time and therefore we have to set CONFIG_RAPIDIO=y.
>> Also we have PCIe based host controllers and their drivers are OK to be
>> built as module like for any other PCI device.
>>
>> Based on requirements and available resources/HW_configuration the platform
>> can have on-chip host controller enabled or disabled (or simply not
>> implemented in case of FPGA). This leads us to combination of on-chip and
>> PCIe host controllers. For example, if PCIe bus is required for other
>> devices, we may have to use PCIe-to_SRIO bridge because all available
>> on-chip SerDes lines are assigned to PCIe.
>>
>> If we use CONFIG_RAPIDIO as a single indicator of possible configuration, we
>> can make visible config menu entry for on-chip controller that is not
>> available on given platform due to HW setup. For example on KeystoneII or
>> MPC85xx/86xx. The option HAS_RAPIDIO tells us that given platform really
>> uses on-chip RapidIO host controller. This is why FSL_RIO depends on
>> HAS_RAPIDIO.
>>
>> Also having PCIe enabled in any form is not a good option to control support
>> for on-chip controller.
> 
> I'm not saying that - can you please read my suggestion below and
> respond to that.  I'm giving you technical feedback, but it seems
> all I'm getting back is "this is how we're doing it" rather than a
> constructive discussion.

I am trying to explain why we are doing it this way, not how.

> 
> For example, can you point out why my idea I present below would not
> work?

See below.

> 
>> For peripheral devices attached to the RapidIO fabric such dependency on
>> local mport implementation does not exist and therefore they all can be
>> treated as tristate.
>>
>>> HAS_RAPIDIO gives the impression that it defines whether or not
>>> the rapidio core code is allowable or not - it doesn't suggest that
>>> it has anything to do with drivers. However, reading the PowerPC
>>> Kconfig files, it seems to be used that way.  That's confusing, and
>>> ought to be fixed.  From what I can tell, it's only used for FSL_RIO,
>>> so I suggest that gets converted to:
>>>
>>> config HAS_RAPIDIO
>>> 	bool PCI

PCI and RAPIDIO can be mutually exclusive.

>>>
>>> config RAPIDIO
>>> 	tristate "RapidIO support"
>>> 	depends on HAS_RAPIDIO
>>>
>>> config HAS_FSL_RIO
>>> 	bool
>>> 	select HAS_RAPIDIO

Introducing new variable HAS_FSL_RIO here. Do you suggest having one for 
each ARM-based board that has on-chip RIO?

>>>
>>> config FSL_RIO
>>> 	bool "Freescale Embedded SRIO Controller support"
>>> 	depends on RAPIDIO = y && HAS_FSL_RIO
>>>
>>> This frees up HAS_RAPIDIO to operate as one would expect - to define
>>> whether or not RAPIDIO should be offered.  This also allows:
>>>
>>> config ARM
>>> 	select HAS_RAPIDIO if PCI

Some SOCs can be configured without PCI. We have confusing action here - 
we have to enable PCI on platform that does not have it.

Above, you had to introduce HAS_FSL_RIO. The same will be needed for 
each ARM-based platform that supports RapidIO. E.g. HAS_KS2_RIO or 
HAS_XZINQ_RIO.

How this improves things? Right now HAS_RAPIDIO is single option that 
has to be selected for given board (plus enabling specific mport option).

Why we cannot use "select HAS_RAPIDIO" HW-specific Kconfig file 
(mach-*/Kconfig)? And have on-chip port selection in the same 
board-specific place.

This is the right place because chips like Keystone have an internal 
RapidIO controller specific to them. If you got with any type of global

The same for Xilinx. Other platforms unlock RAPIDIO selection if they 
have PCI.

Having HAS_RAPIDIO directly in the board-specific Kconfig looks to me 
more descriptive for end user as well.

>>>
>>> to be added to arch/arm/Kconfig if appropriate.  However, I'm not yet
>>> convinced that _just because_ we have PCI does not mean that RAPIDIO
>>> should be offered.  I stated a series of questions about that last
>>> Tuesday in response to an individual patch adding rapidio to arch/arm,
>>> and that email seems to have been ignored - at least as far as the
>>> questions go.
>>>
>>> Please ensure that you respond to your reviewers questions, otherwise
>>> you will start receiving plain NAKs to your patches instead (since
>>> it becomes a waste of time for reviewers to put any further effort
>>> in to explain why they don't like the patch.)
>>>
>>> Thanks.
>>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
