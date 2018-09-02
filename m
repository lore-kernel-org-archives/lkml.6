Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFBEC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390C220843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="eQMA1/JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390C220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeIBHIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 03:08:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41501 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeIBHIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 03:08:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so12859259ljy.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 19:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LWTj3fHDCWp/M2DWb+PtB0AQG7HxvOmHQhWxez9knJY=;
        b=eQMA1/JXvcGm9HXWjUxrzXiM73tpN/llU4Sx/xP7T8rBBHpBplsYROrq63xI6w9IZ+
         8CCN9+kyhcEcE71n5v6MhtxRBYMHHvJdTxOjia7HhR4oP7ikrph2U+giomkWuBjA/mV6
         sOKiR4WWfLR17fsdaSySqoDpvoxjAG6uqUJXox8yQ8R0WwjzxUZjf/sft9mrDfQtynWe
         3reug1NXYMWNumVVyIi+LvI51VW9WN4pGxWubXZDuiKXwcvenTBTEbdUrFTniVsNGB8j
         9uTQcWqj+HbJVarZNrQ+WNnnm9qkk9/EoApUGinZGsKyHTQnIJj5fA4iBXaerNwHZ77/
         OZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LWTj3fHDCWp/M2DWb+PtB0AQG7HxvOmHQhWxez9knJY=;
        b=seMEcrgXSDn17C4dy64mmbUpqOI7RZNiUqiP/Ph0Thn/4vWYM+AtiHkaTtasoq2j8M
         jO1QJSWNbFakEm9cB9B6s1ttpEybJHGh/uwb1k/FTpaJuIOg81/nTqeeDASh7L7/HmY0
         t1LRxB7V9UonWCRM8EwcMyFTgWRrHk5uHWf3xbKiGIuWW5XOJkxlMk13BziSYer1sDQa
         X+KkwF63/I69Q9yyFCcxYWGACl75bc28QOr8ULu6fYBPMF9HnTfyf3a9HF3wKJIDsMvI
         tbq2D6h498xpP8H5MGWVs5/aLx4FtaKG0lnkRumlNXP30caKarbJEMNRVdk6foG+3JMW
         nUnQ==
X-Gm-Message-State: APzg51Cx1LY3w/QBWrm1BHG6b47eaSN3l5fO9Mw6Zx5EpdLIQ/q5ThaN
        vS706W1xIkgyVcGtKXhF6U5LuP2jr6UgLWoR8jv0TQ==
X-Google-Smtp-Source: ANB0VdYkuQMAc1A/DAdub4Inwq/N+tj5sRr4pA2pcQ0ebUr4/N5+tKL5Z4Haq9MyzRaiTWF6CEXp66QFzqYFF6Z6OIo=
X-Received: by 2002:a2e:40c:: with SMTP id 12-v6mr14823158lje.146.1535856876564;
 Sat, 01 Sep 2018 19:54:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:cc08:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 19:54:34 -0700 (PDT)
X-Originating-IP: [99.152.116.91]
In-Reply-To: <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
 <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com> <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
 <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com> <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 1 Sep 2018 19:54:34 -0700
Message-ID: <CAOesGMgLHx3+j1bWEsMWsN-yjGNZyLOpAjLg0Jut8gG=ADE25g@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 9:23 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 30 August 2018 at 17:06, Olof Johansson <olof@lixom.net> wrote:
>> On Wed, Aug 29, 2018 at 10:54 PM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 29 August 2018 at 20:59, Scott Branden <scott.branden@broadcom.com> wrote:
>>>> Hi Olof,
>>>>
>>>>
>>>> On 18-08-29 11:44 AM, Olof Johansson wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Wed, Aug 29, 2018 at 10:21 AM, Scott Branden
>>>>> <scott.branden@broadcom.com> wrote:
>>>>>>
>>>>>> Enable EFI_ARMSTUB_DTB_LOADER to add support for the dtb= command line
>>>>>> parameter to function with efi loader.
>>>>>>
>>>>>> Required to boot on existing bootloaders that do not support devicetree
>>>>>> provided by the platform or by the bootloader.
>>>>>>
>>>>>> Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option for the
>>>>>> DTB loader")
>>>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>>>
>>>>> Why did Ard create an option for this if it's just going be turned on
>>>>> in default configs? Doesn't make sense to me.
>>>>>
>>>>> It would help to know what firmware still is crippled and how common
>>>>> it is, since it's been a few years that this has been a requirement by
>>>>> now.
>>>>
>>>> Broadcom NS2 and Stingray in current development and production need this
>>>> option in the kernel enabled in order to boot.
>>>
>>> And these production systems run mainline kernels in a defconfig configuration?
>>>
>>> The simply reality is that the DTB loader has been deprecated for a
>>> good reason: it was only ever intended as a development hack anyway,
>>> and if we need to treat the EFI stub provided DTB as a first class
>>> citizen, there are things we need to fix to make things works as
>>> expected. For instance, GRUB will put a property in the /chosen node
>>> for the initramfs which will get dropped if you boot with dtb=.
>>>
>>> Don't be surprised if some future enhancements of the EFI stub code
>>> depend on !EFI_ARMSTUB_DTB_LOADER. On UEFI systems, DTBs [or ACPI
>>> tables] are used by the firmware to describe itself and the underlying
>>> platform to the OS, and the practice of booting with DTB file images
>>> (taken from the kernel build as well) conflicts with that view. Note
>>> that GRUB still permits you to load DTBs from files (and supports more
>>> sources than just the file system the kernel Image was loaded from).
>>
>> Ard,
>>
>> Maybe a WARN() splat would be more useful as a phasing-out method than
>> removing functionality for them that needs to be reinstated through
>> changing the config?
>>
>
> We don't have any of that in the stub, and inventing new ways to pass
> such information between the stub and the kernel proper seems like a
> cart-before-horse kind of thing to me. The EFI stub diagnostic
> messages you get on the serial console are not recorded in the kernel
> log buffer, so they only appear if you actually look at the serial
> output.

Ah yeah. I suppose you could do it in the kernel later if you detect
you've booted through EFI with dtb= on the command line though.

>
>> Once the stub and the boot method is there, it's hard to undo as we
>> can see here. Being loud and warn might be more useful, and set a
>> timeline for hard removal (12 months?).
>>
>
> The dtb= handling is still there, it is just not enabled by default.
> We can keep it around if people are still using it. But as I pointed
> out, we may decide to make new functionality available only if it is
> disabled, and at that point, we'll have to choose between one or the
> other in defconfig, which is annoying.
>
>> Scott; an alternative for you is to do a boot wrapper that bundles a
>> DT and kernel, and boot that instead of the kernel image (outside of
>> the kernel tree). Some 32-bit platforms from Marvell use that. That
>> way the kernel will just see it as a normally passed in DT.
>>
>
> Or use GRUB. It comes wired up in all the distros, and let's you load
> a DT binary from anywhere you can imagine, as opposed to the EFI stub
> which can only load it if it happens to reside in the same file system
> (or even directory - I can't remember) as the kernel image. Note that
> the same reservations apply to doing that - the firmware is no longer
> able to describe itself to the OS via the DT, which is really the only
> conduit it has available on an arm64 system..

So, I've looked at the history here a bit, and dtb= support was
introduced in 2014. Nowhere does it say that it isn't a recommended
way of booting.

There are some firmware stacks today that modify and provide a
runtime-updated devicetree to the kernel, but there are also a bunch
who don't. Most "real" products will want a firmware that knows how to
pass in things such as firmware environment variables, or MAC
addresses, etc, to the kernel, but not all of them need it.

In particular, in a world where you want EFI to be used on embedded
platforms, requiring another bootloader step such as GRUB to be able
to reasonably boot said platforms seems like a significant and
unfortunate new limitation. Documentation/efi-stub.txt has absolutely
no indication that it is a second-class option that isn't expected to
be available everywhere. It doesn't really matter what _your_
intention was around it, if those who use it never found out and now
rely on it.

Unfortunately the way forward here is to revert 3d7ee348aa4127a.


-Olof
