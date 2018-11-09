Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E8EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DE920883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb4fTrCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DE920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeKJBzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:55:03 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38620 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbeKJBzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:55:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id a2-v6so2179509edi.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 08:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDnRpM4qUMnSqIChGLFHEHIQ2tozfkBOGnOeFt7D4vs=;
        b=Bb4fTrCVhmP62QXdGfS0C/iIXffqmIKcN7LzILXFXF2q+jUmFZe0/CfyRtK1gObXKj
         ZsdtftCgWY1t/+x0lyoDAU1yRrqKqSfBANqvNyzsSsjiMG2GWKyrJj36WHexBoZbStcE
         sjEpJgw5u6ZafgnBP+FM5zNqJx1S+LMehEjzj/TtkCX4yUOxqVhuBtowBsHaWpcaVbpi
         58KnR2KRo6t0z9RGG0rKD98AgaFYeZewe8UD4jT6rSVfq5m4osFeYY7U+n7gTGl4KUoV
         cVFIxSGrd7iKm7eb8jYjdu0U3UbtsCAM19Sm2KuLLHzhU6X6KMuao9qVviCIzvtnHMXH
         pbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDnRpM4qUMnSqIChGLFHEHIQ2tozfkBOGnOeFt7D4vs=;
        b=uPX85mco2NCHgmG3DoMY866uoIgPJ+uTjwxTEXo88m4+Z7JrPDnxKtSiMTgRqdeTuG
         XKrsBeCzbS+zp9JYBEMGONQXEXJ8qch0DmAgLj8oNWwteckvc5hLBPdw58PQ1zwkvYsI
         UOcrjHaD9w3qZisxphad6QnQlAduBwvIO35O9g/ABH8+NpKaoALnP9Crg3tZ9cx2EUfu
         gdE1Hcq2ufTrWP74WgubMn7TfA+quoOANgDcH2GonDqaFRLXYNv6nQ9LX3r/HzgOLUyL
         fnsagNy9avwQUQJIVOe+5aoiVCDHKTpueukWmybzlcardZZLUpMW2QMeU0U4LxUflV/p
         nnng==
X-Gm-Message-State: AGRZ1gLSmas3ws3AhHYMw9fAIue7Nu1sNPOJLnCl7KG8yqkEILE1LcSr
        gqi8WE5BmZZbuu+H1TXqPOA7+uyYzGr12vtqYkY=
X-Google-Smtp-Source: AJdET5dop/pI+yNO2ejLmSp5RRyNizLTrH/vz4SmuvvupbFmSnoBblwv/yzlLT0CxHMEJDSSqThixGx01hqRY0O33fs=
X-Received: by 2002:a17:906:753:: with SMTP id z19-v6mr2304222ejb.175.1541780027440;
 Fri, 09 Nov 2018 08:13:47 -0800 (PST)
MIME-Version: 1.0
References: <CANmpu8XY10CgYsnGn9hVDzGJQyWdwNihpYu3So62KtNwrkwGXw@mail.gmail.com>
 <8736sbkq2w.fsf@xmission.com>
In-Reply-To: <8736sbkq2w.fsf@xmission.com>
From:   Rian Quinn <rianquinn@gmail.com>
Date:   Fri, 9 Nov 2018 09:13:36 -0700
Message-ID: <CANmpu8Wj+Kq7nnWA48QPcn9ZyJT+=-LcRnbzxkHJL1wq4U_d2Q@mail.gmail.com>
Subject: Re: x86_64 INIT/SIPI Bug
To:     ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I apologize upfront if this is the wrong place to post this, pretty new to this.
>>
>> We are working on the Bareflank Hypervisor (www.bareflank.org), and we
>> are passing through the INIT/SIPI process (similar to how a VMX
>> rootkit from EFI might boot the OS) and we noticed that on Arch Linux,
>> the INIT/SIPI process stalls, something we are not seeing on Ubuntu.
>>
>> Turns out, to fix the issue, we had to turn on cpu_init_udelay=10000.
>> The problem is, once a hypervisor is turned on, even one that is doing
>> nothing but passing through the instructions, the "quick" that is
>> detailed below fails as the kernel is not giving the CPU enough time
>> to perform a VMExit/VMEntry (even through the VMExit is not doing
>> anything).
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/smpboot.c?h=v4.20-rc1#n650
>>
>> You can see our INIT/SIPI code here if you are interested:
>> https://github.com/rianquinn/extended_apis/blob/hyperkernel_1/bfvmm/src/hve/arch/intel_x64/vmexit/init_signal.cpp
>>
>> The reason I suggest this is a bug is the manual clearly states that a
>> wait is required and the "quirk" that turns off this delay prevents
>> code like this from working. Would it be possible to either:
>> - Turn this off by default, but still allow someone to turn it on if
>> they are confident the delay is not needed?
>> - Provide a generic way to turn this off (maybe if a hypervisor is
>> detected, it defaults to off)?
>>
>> I'd be more than happy to provide a patch and test, but I'm not sure
>> if there is any interest in changing this code.
>
> I would suggest testing either for your hypervisor or simply for being
> inside some hypervisor.  As I read the code it is only turning off the
> 10ms delay on processors where it is know that it is safe to do so.
> This is a case where it is not safe to disable the 10ms delay,
> so it makes sense not not turn off the delay.

I think the best solution would be to simply check CPUID leaf 0x40000000
as every hypervisor (at least the legit ones) set this leaf to a unique
ID that can be used to see if a hypervisor is running. Specifically, I
would patch the smp_quirk_init_udelay() function to check to see if
CPUID 0x40000000 returns 0. If it does, no hypervisor is running in which case
the quirk can set the delay to 0. If the leaf is not 0, the quirk is ignored
and the delay is set to UDELAY_10MS_DEFAULT as it does already.

Thoughts? I think the patch would look something like:

    static void __init smp_quirk_init_udelay(void)
    {
+       unsigned int eax, ebx, ecx, edx;
+
+    eax = 0x40000000;
+    ecx = 0;
+    native_cpuid(&eax, &ebx, &ecx, &edx);
+
        /* if cmdline changed it from default, leave it alone */
        if (init_udelay != UINT_MAX)
            return;

+       /* ensure a hypervisor is not running */
+       if (ebx == 0) {
+           /* if modern processor, use no delay */
+           if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
(boot_cpu_data.x86 == 6)) ||
+               ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
(boot_cpu_data.x86 >= 0xF))) {
+               init_udelay = 0;
+               return;
+           }
+       }
+
-       /* if modern processor, use no delay */
-       if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
(boot_cpu_data.x86 == 6)) ||
-           ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
(boot_cpu_data.x86 >= 0xF))) {
-           init_udelay = 0;
-           return;
-       }
        /* else, use legacy delay */
        init_udelay = UDELAY_10MS_DEFAULT;
    }

On Thu, Nov 8, 2018 at 6:16 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Rian Quinn <rianquinn@gmail.com> writes:
>
> > I apologize upfront if this is the wrong place to post this, pretty new to this.
> >
> > We are working on the Bareflank Hypervisor (www.bareflank.org), and we
> > are passing through the INIT/SIPI process (similar to how a VMX
> > rootkit from EFI might boot the OS) and we noticed that on Arch Linux,
> > the INIT/SIPI process stalls, something we are not seeing on Ubuntu.
> >
> > Turns out, to fix the issue, we had to turn on cpu_init_udelay=10000.
> > The problem is, once a hypervisor is turned on, even one that is doing
> > nothing but passing through the instructions, the "quick" that is
> > detailed below fails as the kernel is not giving the CPU enough time
> > to perform a VMExit/VMEntry (even through the VMExit is not doing
> > anything).
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/smpboot.c?h=v4.20-rc1#n650
> >
> > You can see our INIT/SIPI code here if you are interested:
> > https://github.com/rianquinn/extended_apis/blob/hyperkernel_1/bfvmm/src/hve/arch/intel_x64/vmexit/init_signal.cpp
> >
> > The reason I suggest this is a bug is the manual clearly states that a
> > wait is required and the "quirk" that turns off this delay prevents
> > code like this from working. Would it be possible to either:
> > - Turn this off by default, but still allow someone to turn it on if
> > they are confident the delay is not needed?
> > - Provide a generic way to turn this off (maybe if a hypervisor is
> > detected, it defaults to off)?
> >
> > I'd be more than happy to provide a patch and test, but I'm not sure
> > if there is any interest in changing this code.
>
> I would suggest testing either for your hypervisor or simply for being
> inside some hypervisor.  As I read the code it is only turning off the
> 10ms delay on processors where it is know that it is safe to do so.
> This is a case where it is not safe to disable the 10ms delay,
> so it makes sense not not turn off the delay.
>
> Eric
>
