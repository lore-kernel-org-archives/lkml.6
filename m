Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EF0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D6E20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCUEkHbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D6E20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbeGaTk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:40:56 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41174 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbeGaTk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:40:56 -0400
Received: by mail-io0-f194.google.com with SMTP id q9-v6so13802324ioj.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ZYMY8RLr1kYp9Uqn9rkgZCc2px4fyTM8rVF5iUuYL0=;
        b=LCUEkHbl1UTwZzampQVx75pWO1gHyZQOG81zQYGNVSd6qmYQwQGvCwLVxYcNg8en0Q
         R6cw6hfsGyueMgHtww0P/vqgadCENOsIbOgIC9g1qa+k3jJI+V54QU8sYF5NCbF8UpFC
         wYfqs92DA/YJOVYBXlN3a6hvCdzm7uabNQdIIwo7ygA7AUAzh0SiL2kdSW3GjypmA5eg
         MH1670FAKPbUd836MdEwKR4+3u8eU3X2Q4gLIne/tb/DfcrAY9v0pydKLqfxg4utGJ/l
         6MVF0mKwkF9WJUDbJxD9b72IwosoZTDUCLKKXHb675jVap/PxqWl3AVM3Vqu1m60tsrE
         dr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ZYMY8RLr1kYp9Uqn9rkgZCc2px4fyTM8rVF5iUuYL0=;
        b=IqtwonCPjMMxm3iyMKeBjkxQrrPa+Q5SkXpA/2w0GL8C3G7H4fbXMAZKQc7QEIIVJP
         4hTUhVN2Trh4K1bV3Sgq66UjxkPA9auGQIIPkw296ErHfIhTrEYrkDTbHzJ3lkGf+Wdz
         KZM/1JBiFH0U0YywyguVXol9HH7eXFZKU/AmKaqqclI/LzNi67kY7RpLX0m0KwXzC0zy
         +NDfDSX65IAoFS8vVz5seYmj/2OTiZm22oOnNETpNCK7mpdW4sD/qhXyu8H1PpsjG5iH
         QNRg8g7sQmkpSsH/cd1UbNNHAdb48F24gOER04D/TiltqOJotRs86HGCedWOWdSH9vY2
         V08w==
X-Gm-Message-State: AOUpUlGhLNhMD7xNUQ3ubkSnFnQ4zqSeYmPQdFaR5m7gqBbGzdGdVSr/
        tPEs4mLG4vwYzAFvLNJlqW8/MnK6638=
X-Google-Smtp-Source: AAOMgpeiGM6BLEbMmIOkNwZrU+vaktQc8jY1wUo8k+gCrDN5Qo5rPmx2AuQmCiQJEmqw/Jhuy8PyRg==
X-Received: by 2002:a6b:8786:: with SMTP id r6-v6mr685152ioi.106.1533059968946;
        Tue, 31 Jul 2018 10:59:28 -0700 (PDT)
Received: from [10.0.2.15] ([72.138.96.106])
        by smtp.gmail.com with ESMTPSA id r126-v6sm1939012ita.26.2018.07.31.10.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 10:59:28 -0700 (PDT)
Subject: Re: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Will Deacon <will.deacon@arm.com>, Alexei Colin <acolin@isi.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu> <20180731084143.GA4680@arm.com>
 <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
 <20180731155228.GN17271@n2100.armlinux.org.uk>
From:   Alex Bounine <alex.bou9@gmail.com>
Message-ID: <044af717-3883-a7a6-c346-18fa8cebce76@gmail.com>
Date:   Tue, 31 Jul 2018 13:59:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731155228.GN17271@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-31 11:52 AM, Russell King - ARM Linux wrote:
> On Tue, Jul 31, 2018 at 08:54:14AM -0400, Alex Bounine wrote:
>> On 2018-07-31 04:41 AM, Will Deacon wrote:
>>> On Mon, Jul 30, 2018 at 06:50:34PM -0400, Alexei Colin wrote:
>>>> Platforms with a PCI bus will be offered the RapidIO menu since they may
>>>> be want support for a RapidIO PCI device. Platforms without a PCI bus
>>>> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
>>>> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
>>>>
>>>> Tested that kernel builds for arm64 with RapidIO subsystem and
>>>> switch drivers enabled, also that the modules load successfully
>>>> on a custom Aarch64 Qemu model.
>>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>> Cc: John Paul Walters <jwalters@isi.edu>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org,
>>>> Signed-off-by: Alexei Colin <acolin@isi.edu>
>>>> ---
>>>>   arch/arm64/Kconfig | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>
>>> Thanks, this looks much cleaner than before:
>>>
>>> Acked-by: Will Deacon <will.deacon@arm.com>
>>>
>>> The only thing I'm not sure about is why we don't just select HAS_RAPIDIO
>>> unconditionally in the arm64 Kconfig. Does selecting only that option
>>> actually pull in new code to the build?
>>>
>> HAS_RAPIDIO option is intended for SOCs that have built in SRIO controllers,
>> like TI KeyStoneII or FPGAs. Because RapidIO subsystem core is required
>> during RapidIO port driver initialization, having separate option allows us
>> to control available build options for RapidIO core and port driver (bool
>> vs. tristate) and disable module option if port driver is configured as
>> built-in.
> 
> Your explanation doesn't make much sense to me.
> 
> RAPIDIO is the bus-level support, right?  So drivers that depend on
> the bus-level support should depend on RAPIDIO, and so, if RAPIDIO
> is configured as a module, they will also be allowed to be disabled
> or a module, but not built-in if tristate.  If it is boolean, and
> causes the driver to be built-in to the kernel, then you need to use
> "RAPIDIO=y" so that it's dependency is only satisfied when the core
> is built-in.
> 

RapidIO host controllers (on local bus like SoC internal or PCIe) are 
serviced by MPORT device drivers that are subsystem specific and 
communicate with RapidIO core using set of callbacks. Depending on HW 
architecture these drivers may be defined as built-in or module.
Built-in driver will require presence of the RapidIO core during its 
initialization time and therefore we have to set CONFIG_RAPIDIO=y.
Also we have PCIe based host controllers and their drivers are OK to be 
built as module like for any other PCI device.

Based on requirements and available resources/HW_configuration the 
platform can have on-chip host controller enabled or disabled (or simply 
not implemented in case of FPGA). This leads us to combination of 
on-chip and PCIe host controllers. For example, if PCIe bus is required 
for other devices, we may have to use PCIe-to_SRIO bridge because all 
available on-chip SerDes lines are assigned to PCIe.

If we use CONFIG_RAPIDIO as a single indicator of possible 
configuration, we can make visible config menu entry for on-chip 
controller that is not available on given platform due to HW setup. For 
example on KeystoneII or MPC85xx/86xx. The option HAS_RAPIDIO tells us 
that given platform really uses on-chip RapidIO host controller. This is 
why FSL_RIO depends on HAS_RAPIDIO.

Also having PCIe enabled in any form is not a good option to control 
support for on-chip controller.

For peripheral devices attached to the RapidIO fabric such dependency on 
local mport implementation does not exist and therefore they all can be 
treated as tristate.

> HAS_RAPIDIO gives the impression that it defines whether or not
> the rapidio core code is allowable or not - it doesn't suggest that
> it has anything to do with drivers. However, reading the PowerPC
> Kconfig files, it seems to be used that way.  That's confusing, and
> ought to be fixed.  From what I can tell, it's only used for FSL_RIO,
> so I suggest that gets converted to:
> 
> config HAS_RAPIDIO
> 	bool PCI
> 
> config RAPIDIO
> 	tristate "RapidIO support"
> 	depends on HAS_RAPIDIO
> 
> config HAS_FSL_RIO
> 	bool
> 	select HAS_RAPIDIO
> 
> config FSL_RIO
> 	bool "Freescale Embedded SRIO Controller support"
> 	depends on RAPIDIO = y && HAS_FSL_RIO
> 
> This frees up HAS_RAPIDIO to operate as one would expect - to define
> whether or not RAPIDIO should be offered.  This also allows:
> 
> config ARM
> 	select HAS_RAPIDIO if PCI
> 
> to be added to arch/arm/Kconfig if appropriate.  However, I'm not yet
> convinced that _just because_ we have PCI does not mean that RAPIDIO
> should be offered.  I stated a series of questions about that last
> Tuesday in response to an individual patch adding rapidio to arch/arm,
> and that email seems to have been ignored - at least as far as the
> questions go.
> 
> Please ensure that you respond to your reviewers questions, otherwise
> you will start receiving plain NAKs to your patches instead (since
> it becomes a waste of time for reviewers to put any further effort
> in to explain why they don't like the patch.)
> 
> Thanks.
> 
