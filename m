Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B14C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23CE20C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="km7uASjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23CE20C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbeGKNsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:48:30 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54526 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387988AbeGKNsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:48:30 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so3635766itb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 06:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6+AJkM+2dKI1NIkL0/LdAyj5YpfM+xdfHwcUzJL1y2s=;
        b=km7uASjLxhMpUAgZMB4yrWZ5vnEy7IqqDHpDfp2+lr6YF3KfbMo113NvK+1EU9yi/a
         0B4VOfUpgIs1XKtukYj1HJLPU/VWBTJwK9cBdJGkfUq9rhCcGqgNv1mWwD+9zpmhwPZY
         ZGEMNDB6DQagjL0BsE0k7U8GJ8arUvaGvvzDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6+AJkM+2dKI1NIkL0/LdAyj5YpfM+xdfHwcUzJL1y2s=;
        b=E024Eu26VJQKij3WCN+5anyxIA/1ILXcicsWsY1J6CAhbNjE9VbSZlczceR4LmHKai
         gFEObPGw1aPeYYFdh6R7PQP38opjs3vxv0JBngc1pJmEehXSio78OmnoOB8ikjZiavnY
         2y5NhyKVuOqHIObtkpFrh8iY4v477bRYMttjUCMuEPMxu4bJFZnnM01Nu8M6WCA9aWmG
         32vzeBeRcShR4Cp7ee3aaPRgvKuYWEZURHRvOKccnQ4PbUIsRmGseCw9Rg01C95Ru+nz
         yFyDEXyYG6YEtOg1+UvsOmO6ozBJMt4wLV2in4+WSUEuw0k2qE0szDig1HOiD9Xs9FDT
         e3/w==
X-Gm-Message-State: APt69E0sG1c2fIF1vRGJFEEMI9DdCT71QXt7rLavSoyxZOYFFIrJruTC
        k56rgeRdOnd30mSJAuJgrweIpp7OCpbkjet4trTvzl/2kC8=
X-Google-Smtp-Source: AAOMgpfjoJmZa5XqtaxLt0OHkQinnXEXqwlYYvNSnU0IQLaOUjZehSft8m1hjVZt9HNa5sXHXPWAqD+14DkyIupHbtg=
X-Received: by 2002:a02:a1d9:: with SMTP id o25-v6mr5026011jah.86.1531316644253;
 Wed, 11 Jul 2018 06:44:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 06:44:03
 -0700 (PDT)
In-Reply-To: <20180711111427.GA27216@gmail.com>
References: <20180711090235.9327-1-ard.biesheuvel@linaro.org>
 <20180711101303.GA8574@gmail.com> <CAKv+Gu8m4UgL0GyYDuu5z+dzEF=N--H4PkqoO_xqwyW2_A+RMA@mail.gmail.com>
 <20180711111427.GA27216@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 11 Jul 2018 15:44:03 +0200
Message-ID: <CAKv+Gu_LJEu11NV5CVTPV9ieZ=XKkgW2qdkFJ+1iWk+F2jNPww@mail.gmail.com>
Subject: Re: [GIT PULL 0/1] EFI mixed mode fix for v4.18
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 July 2018 at 13:14, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> On 11 July 2018 at 12:13, Ingo Molnar <mingo@kernel.org> wrote:
>> >
>> > * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> >
>> >> The following changes since commit 1e4b044d22517cae7047c99038abb444423243ca:
>> >>
>> >>   Linux 4.18-rc4 (2018-07-08 16:34:02 -0700)
>> >>
>> >> are available in the Git repository at:
>> >>
>> >>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent
>> >>
>> >> for you to fetch changes up to d7f2e972e702d329fe11d6956df99dfc31211c25:
>> >>
>> >>   efi/x86: remove pointless call to PciIo->Attributes() (2018-07-11 10:52:46 +0200)
>> >>
>> >> ----------------------------------------------------------------
>> >> A single fix for the x86 PCI I/O protocol handling code that got
>> >> broken for mixed mode (64-bit Linux/x86 on 32-bit UEFI) after a
>> >> fix was applied in -rc2 to fix it for ordinary 64-bit Linux/x86.
>> >
>> > Just curious, because it's unclear from the changelog, what was the symptom, a
>> > boot hang, instant reboot, or some other misbehavior?
>>
>> Hans reported that his mixed mode tablet would not boot at all any
>> more, but enter a reboot loop without any logs printed by the kernel.
>>
>> > Also, what's the scope of
>> > the fix: were all 64-bit on 32-bit UEFI mixed-mode bootups affected, or only a
>> > certain subset?
>> >
>>
>> Any mixed mode system with PCI is likely to be affected. I have added
>> a QEMU mixed mode config to my boot test environment to catch errors
>> like this one.
>
> Ok, I've added this information to the commit - will be useful to backporters,
> to judge the severity of the bug fixed.
>

Perhaps it wasn't clear from the commit log that only v4.18-rc2 and
later is affected by the mixed mode issue, since that is when a fix
for ordinary 64-bit x86 was applied that affected v4.18-rc1.

>> The unfortunate thing here is that this uncovered a fundamental issue with mixed
>> mode, i.e., that any UEFI protocol prototype involving 64-bit by-value
>> parameters needs to be special cased in the stub code, which is rather tedious.
>> There is one other call that is potentially affected, a file open call in the
>> initrd handling code, but that specific occurrence happens to work unmodified.
>> This patch removes the other one. Going forward, we will have to carefully
>> review UEFI protocol invocations for mixed mode compatibility.
>
> Yeah. Is there any, more systematic way to detect such problems perhaps at an
> earlier stage, other than careful review which will often fail to find such bugs?
> Also, testing is good, but could we perhaps do something on a deeper level -
> automate the casting, generate a warning on suspicious patterns, etc. etc?
>

The main problem is the assumption is that we can convert any call
using the SysV/x86_64 calling convention to the IA32 calling
convention by pushing a 32-bit word for each argument passed in a
register. This assumption holds most of the time, but not all of the
time, and any argument passed by register that takes up more than a
single 32-bit slot is problematic. Note that EFI_PHYSICAL_ADDRESS is
always defined as 64 bits wide, and is widely used in UEFI.
Fortunately, it is mostly passed by reference, and pointers are 32-bit
in mixed mode, so there we dodge the issue.

To me, it is a bit surprising that GCC cannot do this for us, i.e., we
set some __attribute__(()) on a function declaration to inform the
compiler that it should use the 32-bit calling convention. But I guess
there are issues that complicate this in ways that my limited
understanding of low level x86 does not cover.

In any case, the only way to automate this would be to find *some* way
to instantiate the thunking code specifically for each prototype that
we invoke at runtime. The most naive approach would be to classify
functions as

(u32, u32, u32, u32, u32, ...)
(u64, u32, u32, u32, u32, ...)
(u32, u64, u32, u32, u32, ...)
(u64, u64, u32, u32, u32, ...)

etc etc

and have a static library containing the thunking routine for each
one, and wire them up as appropriate. Of course, there is no point in
exhaustively generating each one if we know that only the file open()
call deviates from the first entry.

However, the EFI stub code is not expected to expand that much, and so
for the time being, I'm fine with a combination of review and rigorous
testing
