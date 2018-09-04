Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D89C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3E720869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RBtLuyre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3E720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeIDKrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 06:47:37 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36013 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeIDKrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 06:47:37 -0400
Received: by mail-io0-f194.google.com with SMTP id q5-v6so2041116iop.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 23:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/RF9SAHZXuuxw1ADKLw19tzRWszhpRHseZy7CJLlQfg=;
        b=RBtLuyreXkAVZmszF00O4fdXp+WtuhrtOLLChxGuucWHN3DV8oHq5xNq0CUCr3frHb
         u2Qt/ySLxZLzW1G+xor82T7o8R+LU21kbCioErtV4qYtA1jEoNCuKbzQAhtpzkZuiDkp
         rvgJyExo9ZGjdu+v7cUtyiHAFYNa3kl6UWUA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/RF9SAHZXuuxw1ADKLw19tzRWszhpRHseZy7CJLlQfg=;
        b=pAEWkP18WK5RpRU4K7mffGVyOpOnHi8JQQDrwbCnsQIRN5Publai0N7Q6pO0B//+4W
         sM3NZ4b9walBHwbfPK+urHsrbwmpuFjzrUZNzlxhEFWvmZRzSX1DbYvYtPcyarjGBaRL
         U57aQelbiG9RH4q6cl3MTLjpq3IgasYpVkR82DcISDSXrWPxnUrNkUR5QhZbG5k9H620
         wPbl8LWDAQG1UaeadsLFOv1ygDmcQs3q5btqk7yYV4WbZskJqtxxFPqGBnhJGHV15e7e
         dTCGsmjOmoA0eynPdFQ8oLRlBmAjBW8MFTruxw5MGv6bXC7Dw72tWJy/DNCzI4LkRoxl
         RzrA==
X-Gm-Message-State: APzg51C2eMdkbkNYKilpkRbCINku0p3DY/HgNaoFtRFk5prST9FyNoBX
        nzo29Hz/Q2ipIsTdTs1zOqPyBaKXwXrV0+Exj4q+4A==
X-Google-Smtp-Source: ANB0VdZ9LIPro5hXcW37rJCy9miSvh6CLGZPQKQq62mSG3M1pfJZpHX5e12FF5LmvVSBgJgRImg5/KWPFSbnxcit+eU=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr21118732iof.173.1536042237132;
 Mon, 03 Sep 2018 23:23:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:8f46:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 23:23:56 -0700 (PDT)
In-Reply-To: <CAOesGMgLHx3+j1bWEsMWsN-yjGNZyLOpAjLg0Jut8gG=ADE25g@mail.gmail.com>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
 <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com> <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
 <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
 <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com> <CAOesGMgLHx3+j1bWEsMWsN-yjGNZyLOpAjLg0Jut8gG=ADE25g@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 4 Sep 2018 08:23:56 +0200
Message-ID: <CAKv+Gu_x=bS4xJcD_LuEnnN=Lx4Jc87uK8J_ACdA9EeUqtM3Yg@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
To:     Olof Johansson <olof@lixom.net>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 September 2018 at 04:54, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Aug 30, 2018 at 9:23 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 30 August 2018 at 17:06, Olof Johansson <olof@lixom.net> wrote:
>>> On Wed, Aug 29, 2018 at 10:54 PM, Ard Biesheuvel
>>> <ard.biesheuvel@linaro.org> wrote:
>>>> On 29 August 2018 at 20:59, Scott Branden <scott.branden@broadcom.com> wrote:
>>>>> Hi Olof,
>>>>>
>>>>>
>>>>> On 18-08-29 11:44 AM, Olof Johansson wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On Wed, Aug 29, 2018 at 10:21 AM, Scott Branden
>>>>>> <scott.branden@broadcom.com> wrote:
>>>>>>>
>>>>>>> Enable EFI_ARMSTUB_DTB_LOADER to add support for the dtb= command line
>>>>>>> parameter to function with efi loader.
>>>>>>>
>>>>>>> Required to boot on existing bootloaders that do not support devicetree
>>>>>>> provided by the platform or by the bootloader.
>>>>>>>
>>>>>>> Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option for the
>>>>>>> DTB loader")
>>>>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>>>>
>>>>>> Why did Ard create an option for this if it's just going be turned on
>>>>>> in default configs? Doesn't make sense to me.
>>>>>>
>>>>>> It would help to know what firmware still is crippled and how common
>>>>>> it is, since it's been a few years that this has been a requirement by
>>>>>> now.
>>>>>
>>>>> Broadcom NS2 and Stingray in current development and production need this
>>>>> option in the kernel enabled in order to boot.
>>>>
>>>> And these production systems run mainline kernels in a defconfig configuration?
>>>>
>>>> The simply reality is that the DTB loader has been deprecated for a
>>>> good reason: it was only ever intended as a development hack anyway,
>>>> and if we need to treat the EFI stub provided DTB as a first class
>>>> citizen, there are things we need to fix to make things works as
>>>> expected. For instance, GRUB will put a property in the /chosen node
>>>> for the initramfs which will get dropped if you boot with dtb=.
>>>>
>>>> Don't be surprised if some future enhancements of the EFI stub code
>>>> depend on !EFI_ARMSTUB_DTB_LOADER. On UEFI systems, DTBs [or ACPI
>>>> tables] are used by the firmware to describe itself and the underlying
>>>> platform to the OS, and the practice of booting with DTB file images
>>>> (taken from the kernel build as well) conflicts with that view. Note
>>>> that GRUB still permits you to load DTBs from files (and supports more
>>>> sources than just the file system the kernel Image was loaded from).
>>>
>>> Ard,
>>>
>>> Maybe a WARN() splat would be more useful as a phasing-out method than
>>> removing functionality for them that needs to be reinstated through
>>> changing the config?
>>>
>>
>> We don't have any of that in the stub, and inventing new ways to pass
>> such information between the stub and the kernel proper seems like a
>> cart-before-horse kind of thing to me. The EFI stub diagnostic
>> messages you get on the serial console are not recorded in the kernel
>> log buffer, so they only appear if you actually look at the serial
>> output.
>
> Ah yeah. I suppose you could do it in the kernel later if you detect
> you've booted through EFI with dtb= on the command line though.
>
>>
>>> Once the stub and the boot method is there, it's hard to undo as we
>>> can see here. Being loud and warn might be more useful, and set a
>>> timeline for hard removal (12 months?).
>>>
>>
>> The dtb= handling is still there, it is just not enabled by default.
>> We can keep it around if people are still using it. But as I pointed
>> out, we may decide to make new functionality available only if it is
>> disabled, and at that point, we'll have to choose between one or the
>> other in defconfig, which is annoying.
>>
>>> Scott; an alternative for you is to do a boot wrapper that bundles a
>>> DT and kernel, and boot that instead of the kernel image (outside of
>>> the kernel tree). Some 32-bit platforms from Marvell use that. That
>>> way the kernel will just see it as a normally passed in DT.
>>>
>>
>> Or use GRUB. It comes wired up in all the distros, and let's you load
>> a DT binary from anywhere you can imagine, as opposed to the EFI stub
>> which can only load it if it happens to reside in the same file system
>> (or even directory - I can't remember) as the kernel image. Note that
>> the same reservations apply to doing that - the firmware is no longer
>> able to describe itself to the OS via the DT, which is really the only
>> conduit it has available on an arm64 system..
>
> So, I've looked at the history here a bit, and dtb= support was
> introduced in 2014. Nowhere does it say that it isn't a recommended
> way of booting.
>
> There are some firmware stacks today that modify and provide a
> runtime-updated devicetree to the kernel, but there are also a bunch
> who don't. Most "real" products will want a firmware that knows how to
> pass in things such as firmware environment variables, or MAC
> addresses, etc, to the kernel, but not all of them need it.
>
> In particular, in a world where you want EFI to be used on embedded
> platforms, requiring another bootloader step such as GRUB to be able
> to reasonably boot said platforms seems like a significant and
> unfortunate new limitation. Documentation/efi-stub.txt has absolutely
> no indication that it is a second-class option that isn't expected to
> be available everywhere. It doesn't really matter what _your_
> intention was around it, if those who use it never found out and now
> rely on it.
>
> Unfortunately the way forward here is to revert 3d7ee348aa4127a.
>

I agree with your analysis but not with your conclusion.

Whether or not the option is def_bool y and/or enabled in defconfig is
a matter of policy. ACPI-only distros such as RHEL are definitely
going to disable this option. But in general, supporting DTBs loaded
from files is a huge pain for the distros, so I expect most of them to
disable it as well.

As for EFI on embedded systems: this will be mostly on U-boot's
bootefi implementation, which definitely does the right thing when it
comes to passing the DTB via a UEFI configuration table (regardless of
whether it makes any modifications to it)

In any case, I won't object to a patch that reenables the EFI stub DTB
loader in defconfig. Whether or not it should be def_bool y is
something we can discuss as well. I have added Leif and Alex to cc,
perhaps they have anything to add.
