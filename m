Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB171C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E272082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="w2s+pfIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E272082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeIDVyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:54:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41439 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeIDVyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:54:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so3843514ljy.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gt+deXbHZEB0bnH+Y+zxKibrQwTxu82a4o4aLU9k0WM=;
        b=w2s+pfIySSU/Kwz/u1tlFMmlqLF8O+RUTqFh0spy0lwq7UEC1Zm+tUCVus3QGnhPSx
         T/P+XBPw62Sae4QKQbLJ/GHlCNHsNzmF0jTnLmiajYPmrNgoy3eI6iQGCQl5mwF+TSlJ
         2T6AJ9xv3fQWcisMy1k+7/NwdU2e9ygJ4xKbQQAvvqdkA6PgzbYli6kpMgoa/C1l/iWW
         tHjoVBTwDMsGzQaAiSnikMNqixsPbTbnhcgXhpmw/S8F417WUtqtjeGxK0fC2Gi6NTA0
         B+2o+QLiyJVby6kd01d6sIv7ABZbxYN0HAkvGpPawGqyU/K36qG1KKn2hROqgkZRbxkX
         SY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gt+deXbHZEB0bnH+Y+zxKibrQwTxu82a4o4aLU9k0WM=;
        b=b6O2M7895SMNtcmNLZTJud0/5B0aWyEK5dPaRyQnQf2bXhNExMXfKIu4bnjUspLW4b
         5Lfg5/6PrrGgizvFDPtKJ35J1XnHSkloAezM4Tj5p2e8CKkxGnUDURa5hjBDzqNcCXZf
         MskfrCeHnbUje9fg5nesfdBcWoePHlyMw4zGhMzkS1sY4N+TlAePZ3olh6gX3xUBa+Ko
         Efrcbk3qyQRtzSdBfaRnE6BNDoQIKgf+sAiLWTFePlhkiDoSwevh3zmuctyJVONxvJ3N
         oDipq+nehUSXhFCh05qQSuC9mut1KIvLb4sNkyASil2pQGozP3ntFbVCRzT2Wv370Xq0
         hz3A==
X-Gm-Message-State: APzg51Cn4mqLD9JP13wAxOUJccQatYqu/ZSSEY8cMwCTKAJNZmlGCIPX
        QaLwlgypZekFY4jAcmtsl27VvVEdkWqaL5sKEnj6bg==
X-Google-Smtp-Source: ANB0Vdb8Lh7w5bZi8TuNjtVuN8Qg5f6m7iEJb9SfA/Qx1l+rKmASKnp5vY5xSvRLZIB5suXB4DCtVo815BpwtndDjqk=
X-Received: by 2002:a2e:8e89:: with SMTP id z9-v6mr3550019ljk.155.1536082126681;
 Tue, 04 Sep 2018 10:28:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:175b:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 10:28:45 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::4:a2ee]
In-Reply-To: <CACxGe6uK+N5XUqZhH7gAQXoq+QXMvFPHF_i4WqivrufTU=0cog@mail.gmail.com>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
 <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com> <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
 <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
 <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
 <CAOesGMgLHx3+j1bWEsMWsN-yjGNZyLOpAjLg0Jut8gG=ADE25g@mail.gmail.com>
 <CAKv+Gu_x=bS4xJcD_LuEnnN=Lx4Jc87uK8J_ACdA9EeUqtM3Yg@mail.gmail.com> <CACxGe6uK+N5XUqZhH7gAQXoq+QXMvFPHF_i4WqivrufTU=0cog@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 4 Sep 2018 10:28:45 -0700
Message-ID: <CAOesGMjU4dKGj8tjexbweNUZWmxiLHwODkHbGaAqabwOGKb=bw@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
To:     Grant Likely <grant.likely@secretlab.ca>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 3:13 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> Hey folks. More comments below, but the short answer is I really don't
> see what the problem is. Distros cannot easily support platforms that
> require a dtb= parameter, and so they probably won't. They may or may
> not disable 'dtb=', depending on whether they see it as valuable for
> debug.

Sure, I'm all for enterprise distros not wanting to support this, but
there are boatloads of kernel parameters that they're unlikely to
already be supporting, including "initrd=" and others. "dtb="
shouldn't be any different.

Needing to disable it with a config option sounds like an odd approach to this.

> Vertically integrated platforms are a different beast. We may strongly
> recommend firmware provides the dtb for all the mentioned good
> reasons, but they still get to decide their deployment methodology,
> and it is not burdensome for the kernel to keep the dtb= feature that
> they are using.

+1


> On Tue, Sep 4, 2018 at 7:24 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>
>> On 2 September 2018 at 04:54, Olof Johansson <olof@lixom.net> wrote:
>> > On Thu, Aug 30, 2018 at 9:23 AM, Ard Biesheuvel
>> > <ard.biesheuvel@linaro.org> wrote:
>> >> On 30 August 2018 at 17:06, Olof Johansson <olof@lixom.net> wrote:
>> >>> On Wed, Aug 29, 2018 at 10:54 PM, Ard Biesheuvel
>> >>> <ard.biesheuvel@linaro.org> wrote:
>> >>>> On 29 August 2018 at 20:59, Scott Branden <scott.branden@broadcom.com> wrote:
>> >>>>> Hi Olof,
>> >>>>>
>> >>>>>
>> >>>>> On 18-08-29 11:44 AM, Olof Johansson wrote:
>> >>>>>>
>> >>>>>> Hi,
>> >>>>>>
>> >>>>>> On Wed, Aug 29, 2018 at 10:21 AM, Scott Branden
>> >>>>>> <scott.branden@broadcom.com> wrote:
>> >>>>>>>
>> >>>>>>> Enable EFI_ARMSTUB_DTB_LOADER to add support for the dtb= command line
>> >>>>>>> parameter to function with efi loader.
>> >>>>>>>
>> >>>>>>> Required to boot on existing bootloaders that do not support devicetree
>> >>>>>>> provided by the platform or by the bootloader.
>> >>>>>>>
>> >>>>>>> Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option for the
>> >>>>>>> DTB loader")
>> >>>>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> >>>>>>
>> >>>>>> Why did Ard create an option for this if it's just going be turned on
>> >>>>>> in default configs? Doesn't make sense to me.
>> >>>>>>
>> >>>>>> It would help to know what firmware still is crippled and how common
>> >>>>>> it is, since it's been a few years that this has been a requirement by
>> >>>>>> now.
>> >>>>>
>> >>>>> Broadcom NS2 and Stingray in current development and production need this
>> >>>>> option in the kernel enabled in order to boot.
>> >>>>
>> >>>> And these production systems run mainline kernels in a defconfig configuration?
>> >>>>
>> >>>> The simply reality is that the DTB loader has been deprecated for a
>> >>>> good reason: it was only ever intended as a development hack anyway,
>> >>>> and if we need to treat the EFI stub provided DTB as a first class
>> >>>> citizen, there are things we need to fix to make things works as
>> >>>> expected. For instance, GRUB will put a property in the /chosen node
>> >>>> for the initramfs which will get dropped if you boot with dtb=.
>> >>>>
>> >>>> Don't be surprised if some future enhancements of the EFI stub code
>> >>>> depend on !EFI_ARMSTUB_DTB_LOADER.
>
> That's an odd statement to make. The DTB loader code is well contained
> and with defined semantics... True, the semantics are "I DON'T BELIEVE
> FIRMWARE", but it is still well defined. What scenario are you
> envisioning where EFI_ARMSTUB_DTB_LOADER would be explicitly excluded?
>
> Conversely, the dtb= argument is an invaluable debug tool during
> development. As Olof has already said, there are a lot of embedded
> deployments where there is no desire for grub or any other
> intermediary loader.
>
>> >>>> On UEFI systems, DTBs [or ACPI
>> >>>> tables] are used by the firmware to describe itself and the underlying
>> >>>> platform to the OS, and the practice of booting with DTB file images
>> >>>> (taken from the kernel build as well) conflicts with that view. Note
>> >>>> that GRUB still permits you to load DTBs from files (and supports more
>> >>>> sources than just the file system the kernel Image was loaded from).
>> >>>
>> >>> Ard,
>> >>>
>> >>> Maybe a WARN() splat would be more useful as a phasing-out method than
>> >>> removing functionality for them that needs to be reinstated through
>> >>> changing the config?
>> >>>
>> >>
>> >> We don't have any of that in the stub, and inventing new ways to pass
>> >> such information between the stub and the kernel proper seems like a
>> >> cart-before-horse kind of thing to me. The EFI stub diagnostic
>> >> messages you get on the serial console are not recorded in the kernel
>> >> log buffer, so they only appear if you actually look at the serial
>> >> output.
>
> As an aside, they probably should be recorded. That is probably a
> question for the UEFI USWG. Grub and the ARMSTUB could probably bodge
> something together, but that would be non-standard.

Having a way to pass firmware console messages onto the kernel is a
generic problem; different firmware stacks seem to solve this in
different ways. Having a unified way of passing, say, a text buffer to
the kernel filled with the firmware console log would indeed be useful
for everyone, not just EFI.


>> > Ah yeah. I suppose you could do it in the kernel later if you detect
>> > you've booted through EFI with dtb= on the command line though.
>> >
>> >>
>> >>> Once the stub and the boot method is there, it's hard to undo as we
>> >>> can see here. Being loud and warn might be more useful, and set a
>> >>> timeline for hard removal (12 months?).
>> >>>
>> >>
>> >> The dtb= handling is still there, it is just not enabled by default.
>> >> We can keep it around if people are still using it. But as I pointed
>> >> out, we may decide to make new functionality available only if it is
>> >> disabled, and at that point, we'll have to choose between one or the
>> >> other in defconfig, which is annoying.
>> >>
>> >>> Scott; an alternative for you is to do a boot wrapper that bundles a
>> >>> DT and kernel, and boot that instead of the kernel image (outside of
>> >>> the kernel tree). Some 32-bit platforms from Marvell use that. That
>> >>> way the kernel will just see it as a normally passed in DT.
>> >>>
>> >>
>> >> Or use GRUB. It comes wired up in all the distros, and let's you load
>> >> a DT binary from anywhere you can imagine, as opposed to the EFI stub
>> >> which can only load it if it happens to reside in the same file system
>> >> (or even directory - I can't remember) as the kernel image. Note that
>> >> the same reservations apply to doing that - the firmware is no longer
>> >> able to describe itself to the OS via the DT, which is really the only
>> >> conduit it has available on an arm64 system..
>> >
>> > So, I've looked at the history here a bit, and dtb= support was
>> > introduced in 2014. Nowhere does it say that it isn't a recommended
>> > way of booting.
>> >
>> > There are some firmware stacks today that modify and provide a
>> > runtime-updated devicetree to the kernel, but there are also a bunch
>> > who don't. Most "real" products will want a firmware that knows how to
>> > pass in things such as firmware environment variables, or MAC
>> > addresses, etc, to the kernel, but not all of them need it.
>> >
>> > In particular, in a world where you want EFI to be used on embedded
>> > platforms, requiring another bootloader step such as GRUB to be able
>> > to reasonably boot said platforms seems like a significant and
>> > unfortunate new limitation. Documentation/efi-stub.txt has absolutely
>> > no indication that it is a second-class option that isn't expected to
>> > be available everywhere. It doesn't really matter what _your_
>> > intention was around it, if those who use it never found out and now
>> > rely on it.
>> >
>> > Unfortunately the way forward here is to revert 3d7ee348aa4127a.
>> >
>>
>> I agree with your analysis but not with your conclusion.
>>
>> Whether or not the option is def_bool y and/or enabled in defconfig is
>> a matter of policy. ACPI-only distros such as RHEL are definitely
>> going to disable this option. But in general, supporting DTBs loaded
>> from files is a huge pain for the distros, so I expect most of them to
>> disable it as well.
>
> I support leaving 3d7ee348 in, and making it def_bool y

Again, with the argument above -- I question its presence at all. We
usually don't pick up kernel changes just because a distro wants to
make a policy statement.

In this case, there is no genuine technical motivation for this
change, especially when the parallel "initrd=" option is still there.


-Olof
