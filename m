Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDB1C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED312242C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED312242C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeHJVBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:01:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32783 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeHJVBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:01:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id s12-v6so7898609ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 11:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QGhq0w+xFdQXuR+iuKGkis+Pwz1VoJ9tczVJ0IByQDI=;
        b=oqkq9pSRMoRKOdvCbqTZRGA/+t/V3WqM/7z4nyFouVjihQ1pjygLNaRdXQLlhuDk8Q
         V8uIxUazkfKe4ATrEQX0zVb2uC7pDraXcs3l/rA+bIhGqM8sQBvUU0t364d/TLZ+Wp4D
         C9RpqJn43vLvByxtUAwvmh8jzkHkT5sEuJHPANn1aByC80dWVLru9gNklk0RomUMSJ4d
         KNE/992PAR3alvNDHemtQmp+0FHtkrkMreN6zyLeRoIxzost2JTqZ47LWsc4+RMHXhMA
         DyffmK2j7f5FudDvYOB8e+8JWpXb5EJT6ZVslNUZgWlgp2YzDYd5x5aQ2t3omahsiU0z
         Trqg==
X-Gm-Message-State: AOUpUlGZ7QKK+fXGTGR1ph4YqCSuhe8kwRRj8dwU3k9EFWoDtvp/Rk0R
        Vk291Jszwi/o4GH82RWUlKdF2u0BNw12EzrveRpJ/A==
X-Google-Smtp-Source: AA+uWPys/AdDO4e6p+klh2lnbczGPxJk6A3s8/eMzu5aAjxwZbykGE6FFUUdwD9oiVIH4RNPmVt/zqCw8biWJu1baUE=
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr5357518ljj.139.1533925841654;
 Fri, 10 Aug 2018 11:30:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:81a:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 11:30:41 -0700 (PDT)
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F47CDA91A@ORSMSX114.amr.corp.intel.com>
References: <1533789077-16156-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1533789077-16156-7-git-send-email-sai.praneeth.prakhya@intel.com>
 <CACi5LpPcaiHEHV9cFm=C4UB23jmfie16VR4m3ZAkZ9bVis5Dqg@mail.gmail.com> <FFF73D592F13FD46B8700F0A279B802F47CDA91A@ORSMSX114.amr.corp.intel.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Sat, 11 Aug 2018 00:00:41 +0530
Message-ID: <CACi5LpNESNVWFrfQLGi4-GehjO9GxV50sg7HUvxCHYS_z-yBGQ@mail.gmail.com>
Subject: Re: [PATCH V1 6/6] x86/efi: Introduce EFI_WARN_ON_ILLEGAL_ACCESSES
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ricardo.ner@intel.com" <ricardo.ner@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Lee Chun-Yi <jlee@suse.com>, Al Stone <astone@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:04 PM, Prakhya, Sai Praneeth
<sai.praneeth.prakhya@intel.com> wrote:
>> > +config EFI_WARN_ON_ILLEGAL_ACCESSES
>>
>> How about shortening the name to just 'EFI_WARN_ON_ILLEGAL_ACCESS'?
>>
>
> Makes sense.. I will shorten it.
>
>> > +       bool "Warn about illegal memory accesses by firmware"
>> > +       depends on EFI
>>
>> From a distribution p-o-v, I would suggest that we set this CONFIG option only if
>> we are in the EXPERT mode, as this need more thrashing with the behaviour we
>> see on old, buggy EFI firmwares available on very old x86 machines. So
>> something like:
>>            bool "Warn about illegal memory accesses by firmware" if EXPERT
>>
>
> Agreed. Although the feature is intended to warn about all these buggy firmware's
> instead of silently working around (as we are doing presently), it needs more testing.
> Hence, as you said, I think it's safe to have it as an EXPERT config option.
>
>> > +       help
>> > +         Enable this debug feature so that the kernel can detect illegal
>> > +         memory accesses by firmware and issue a warning. Also,
>> > +         1. If the illegally accessed region is EFI_BOOT_SERVICES_<CODE/DATA>,
>> > +            the kernel fixes it up by mapping the requested region.
>
> [....]
>
>> > diff --git a/init/main.c b/init/main.c index
>> > 3b4ada11ed52..dce0520861a1 100644
>> > --- a/init/main.c
>> > +++ b/init/main.c
>> > @@ -730,7 +730,8 @@ asmlinkage __visible void __init start_kernel(void)
>> >         arch_post_acpi_subsys_init();
>> >         sfi_init_late();
>> >
>> > -       if (efi_enabled(EFI_RUNTIME_SERVICES)) {
>> > +       if (efi_enabled(EFI_RUNTIME_SERVICES) &&
>> > +           !IS_ENABLED(CONFIG_EFI_WARN_ON_ILLEGAL_ACCESSES)) {
>>
>> Since this is an arch agnostic code leg, do we really want to introduce a generic
>> check for CONFIG_EFI_WARN_ON_ILLEGAL_ACCESSES
>> here, without checking for whether we are actually running this on a
>> x86 hardware, or alternatively we can consider moving
>> CONFIG_EFI_WARN_ON_ILLEGAL_ACCESSES out of 'arch/x86/Kconfig' to
>> 'arch/Kconfig' so that later it can be used on other archs like ARM64 as well.
>>
>> I think the later would be more useful..
>
> Thanks for bringing this up. I see your point. I will refrain from polluting architecture
> agnostic code. As we don't need efi_free_boot_services() at all, if EFI_WARN_ON_ILLEGAL_ACCESSES
> is enabled, probably making changes to include/linux/efi.h would be better, I guess..
>
> Moving this to arch/Kconfig could be too futuristic.. I guess.. because I am not sure
> if this problem exists on ARM machines, if so, probably Ard could suggest something here.

I think Ard can comment better but let me chime in with my limited
experience with Fedora arm64 implementations - we are already seeing
EFI firmware implementations which are broken/are orphaned (not well
supported anymore) on arm64 even though the hardware is still in-use.
With arm64 EFI firmware implementations still catching up with ARM
server SBBR specifications, we expect more x86 like broken EFI
implementations on arm64 as well. So, I don't see that as a distant
problem, in-fact this is something which has been on my Fedora to-do
list for arm64 for some time.

If there is a framework on x86 available, I can take a stab and
extrapolate it for arm64 as well.

Thanks,
Bhupesh
