Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF091C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FC620834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="IIUVGeF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FC620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeH3TJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:09:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37192 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeH3TJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:09:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so7562804ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d+hduf7GdEs60i9JT8GVwOLw8yq7Cp1WN3KIRa/3IX0=;
        b=IIUVGeF8/7y4GtO0KV6vZiAULnZldYXpvzfIIoBFnpuDXzLEWsbwaDBFWn7mOaSFhY
         b1xCtmzuXssxuYJngRv7BO/9e8xIPRvMeY03OYu0PkwVBhMSHuuhS+uCoNSs06nqiRdT
         KxIWQgnAXZHP9LtfdtCLDcwjdjvHvxT6fD11sacwm2DQiUp4DWwO98K35XII4OHFoUno
         qh1B3uYZl1qU2vnuo2lRLILDHvvbnyNtJpm8AzTkp6sC6lr/WOIsY7dMxMaYN+Q9Kpwm
         2mI21ZefZbCV0tO6nCvOKOnc1p1lx0QSP5tq0HcSLUbPVflR4T3i1zRouWyg/HXbScRl
         9PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d+hduf7GdEs60i9JT8GVwOLw8yq7Cp1WN3KIRa/3IX0=;
        b=jXZtAf4fVzVFhVochjCZCgkE87SmYoLzUjf/iQUOwdHcplBQQmITm89DhXUtqJO2jk
         kpVPqTBgFdMJh/IeyMXB/oEMT8bVCBWm+XfTWeiMTiy5C4y5zSUuNzzspy7M456XDWsi
         z+Y982lWlDUdsGe24zaCDHMb1+8Zcnpg4XAbhWbNVePh+1YhVrxprgEJMpnkMoPNii+7
         WYVDHpRr6+u62W+1/XqwB2XTYTNKYA/B61bC1S0h2ydFI84qWYB6v6ZH1Y4DUdO2+8jI
         vi6O3X6NRatY/cVN8FdWOfuIm6Q7sWE+jAUp7Ikm5T8d4Shxt8wYELp5vjp1/XqwHx8Q
         A+fQ==
X-Gm-Message-State: APzg51BjYxs3I+/UfXBMhLj6kUVBGwoNvUpuqq9Q0uMeKEwI/NoQRCBU
        EWE+bGpoQwQ4Pbvs1WHTsOZ19o+RzdGP40/JuAy2Ng==
X-Google-Smtp-Source: ANB0VdapKBKf85Gk5Fj+4b6OW4IqZ9luTdKBeX5qNnwgw0p6UCb0qtkNk3+VRdQhwHWysIYe5YrXAfWf2R5F2RZ3iaY=
X-Received: by 2002:a2e:87cf:: with SMTP id v15-v6mr7387373ljj.13.1535641598466;
 Thu, 30 Aug 2018 08:06:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:dd41:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 08:06:36
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::5:2af8]
In-Reply-To: <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
 <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com> <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 30 Aug 2018 08:06:36 -0700
Message-ID: <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
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

On Wed, Aug 29, 2018 at 10:54 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 29 August 2018 at 20:59, Scott Branden <scott.branden@broadcom.com> wrote:
>> Hi Olof,
>>
>>
>> On 18-08-29 11:44 AM, Olof Johansson wrote:
>>>
>>> Hi,
>>>
>>> On Wed, Aug 29, 2018 at 10:21 AM, Scott Branden
>>> <scott.branden@broadcom.com> wrote:
>>>>
>>>> Enable EFI_ARMSTUB_DTB_LOADER to add support for the dtb= command line
>>>> parameter to function with efi loader.
>>>>
>>>> Required to boot on existing bootloaders that do not support devicetree
>>>> provided by the platform or by the bootloader.
>>>>
>>>> Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option for the
>>>> DTB loader")
>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>
>>> Why did Ard create an option for this if it's just going be turned on
>>> in default configs? Doesn't make sense to me.
>>>
>>> It would help to know what firmware still is crippled and how common
>>> it is, since it's been a few years that this has been a requirement by
>>> now.
>>
>> Broadcom NS2 and Stingray in current development and production need this
>> option in the kernel enabled in order to boot.
>
> And these production systems run mainline kernels in a defconfig configuration?
>
> The simply reality is that the DTB loader has been deprecated for a
> good reason: it was only ever intended as a development hack anyway,
> and if we need to treat the EFI stub provided DTB as a first class
> citizen, there are things we need to fix to make things works as
> expected. For instance, GRUB will put a property in the /chosen node
> for the initramfs which will get dropped if you boot with dtb=.
>
> Don't be surprised if some future enhancements of the EFI stub code
> depend on !EFI_ARMSTUB_DTB_LOADER. On UEFI systems, DTBs [or ACPI
> tables] are used by the firmware to describe itself and the underlying
> platform to the OS, and the practice of booting with DTB file images
> (taken from the kernel build as well) conflicts with that view. Note
> that GRUB still permits you to load DTBs from files (and supports more
> sources than just the file system the kernel Image was loaded from).

Ard,

Maybe a WARN() splat would be more useful as a phasing-out method than
removing functionality for them that needs to be reinstated through
changing the config?

Once the stub and the boot method is there, it's hard to undo as we
can see here. Being loud and warn might be more useful, and set a
timeline for hard removal (12 months?).

Scott; an alternative for you is to do a boot wrapper that bundles a
DT and kernel, and boot that instead of the kernel image (outside of
the kernel tree). Some 32-bit platforms from Marvell use that. That
way the kernel will just see it as a normally passed in DT.


-Olof
