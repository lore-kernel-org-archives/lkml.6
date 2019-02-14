Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFFEC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D33A2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNK1c8yT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436633AbfBNIRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:17:50 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38517 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403869AbfBNIRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:17:50 -0500
Received: by mail-it1-f193.google.com with SMTP id l66so2307251itg.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vjC5NjxwgilwtZCnDsY6OAd0Xq/XwAgXTYGo31ekm8=;
        b=aNK1c8yTuLO4n3j1d0QYocvzyrdgUf2vlTgREXu9f8Pp7aHd+561eGZq7biuBgPwnl
         ygku9cP6LmXbeDCzJO+lM8/MQJqILhCqiZrJz3z5XrKI/1bV+hng6VZCrDkRYoqJY35w
         2tuoD1M+ZiZlwTlrhEezTf+8Pug5NNZT5PnZWY1tDtIgrhQM1ygT5xlHxLjrMcDXe98S
         RQQY9759UBbO9LYT0ruTyZWG5zxy8fYZ2UjDy1J4/d4B80fVcwJrKwZ2+kpHA96ieivs
         pz20h2lHsIeCFCzNhxk4thUvlz1IjYq/Fd6H9NYEARdEO++iKFkD4jpTcZhnPgBxqP4x
         o0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vjC5NjxwgilwtZCnDsY6OAd0Xq/XwAgXTYGo31ekm8=;
        b=K+btUe4527veZWNdeDuoXXnnJTE3/A73r7DExamdukNSIECDBeCu1Nn37zSF98Y853
         hVxYRAdfokukU7rgwkl7imBZx6fOh575Tafe2Xdl/F2ZgCy5ghCU0r1zvB5cAq7mMSN3
         qrVJD0kLTJY3TKUeVIpuuXLIA5RVQBnq6w/7MU5C1UFT7xduREXM2aZcXJ0BZyNEeg2R
         jl5Z2MT+jZM9GN5HqJ7IfRmau6Uv3yvyh6HHiBH3yXaPW8UCh27Bsmmd7OTBuRz34lwG
         Hm7k5IOttCtR+alJ5BHNBcb1OTz6/0Mk6lToynhdSBMNuR4N1yCNnelu4aLYwRgFhdXY
         zh8A==
X-Gm-Message-State: AHQUAua6R8dk5HW1ahZ4ZPX8I13+E30XjfGSguBKcmy8M11nB+nqjSay
        dVMPW2GptfBscGuYjDDsLR97rJMCMAgBBfCH1kdcBg==
X-Google-Smtp-Source: AHgI3IYNlDSU3mi0qYgRsQJMWMT1IhzHWzq9DBcIPGdiUW6PeQgzOhuVuSviZQ0hxz+h8Qo0gqlifJZ/RSA7IPsp7T0=
X-Received: by 2002:a24:c3c4:: with SMTP id s187mr1485818itg.158.1550132268814;
 Thu, 14 Feb 2019 00:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20190213193413.25560-1-hedi.berriche@hpe.com>
In-Reply-To: <20190213193413.25560-1-hedi.berriche@hpe.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 14 Feb 2019 09:17:37 +0100
Message-ID: <CAKv+Gu9MkLBv_unbhjikwOTit4xC0-WmS_HMLr1RQ+FZAoW_9g@mail.gmail.com>
Subject: Re: [Patch v3 0/4] Protect against concurrent calls into UV BIOS
To:     Hedi Berriche <hedi.berriche@hpe.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 at 20:34, Hedi Berriche <hedi.berriche@hpe.com> wrote:
>
> - Changes since v2
>   Addressed comments from Ard Biesheuvel:
>  * expose efi_runtime_lock to UV platform only instead of globally
>  * remove unnecessary #ifdef CONFIG_EFI from bios_uv.c
>
> - Changes since v1:
>   Addressed comments from Bhupesh Sharma, Thomas Gleixner, and Ard Biesheuvel:
>  * made __uv_bios_call() static
>  * moved the efi_enabled() cleanup to its own patchlet
>  * explained the reason for renaming the efi_runtime_lock semaphore
>  * dropped the reviewed-bys as they should be given on the mailing list
>  * Cc'ng stable@vger.kernel.org given the nature of the problem addressed by the patches
>

Hi Hedi,

The patches look good to me now.

For the series,

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

However, I don't think all the patches should go to -stable. Only 4/4
fixes an actual bug, and the remaining patches don't look like they
are prerequisites for that change.

Also, if your colleagues reviewed your patches, now would be the time
to ask them to give their Reviewed-by as well.

-- 
Ard.



> ---
>
> Calls into UV BIOS were not being serialised which is wrong as it violates EFI
> runtime rules, and bad as it does result in all sorts of potentially hard to
> track down hangs and panics when efi_scratch.prev_mm gets clobbered whenever
> efi_switch_mm() gets called concurrently from two different CPUs.
>
> Patch #1 removes an unnecessary #ifdef CONFIG_EFI guard from bios_uv.c.
>
> Patch #2 removes uv_bios_call_reentrant() because it's dead code.
>
> Patch #3 is a cleanup that drops test_bit() in favour of the ad hoc efi_enabled().
>
> Patch #4 makes uv_bios_call() variants use the efi_runtime_lock semaphore to
> protect against concurrency.
>
> Cc: Russ Anderson <rja@hpe.com>
> Cc: Mike Travis <mike.travis@hpe.com>
> Cc: Dimitri Sivanich <sivanich@hpe.com>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: stable@vger.kernel.org # v4.9+
>
> Hedi Berriche (4):
>   x86/platform/UV: remove unnecessary #ifdef CONFIG_EFI
>   x86/platform/UV: kill uv_bios_call_reentrant() as it has no callers
>   x86/platform/UV: use efi_enabled() instead of test_bit()
>   x86/platform/UV: use efi_runtime_lock to serialise BIOS calls
>
>  arch/x86/include/asm/uv/bios.h          | 13 ++++-----
>  arch/x86/platform/uv/bios_uv.c          | 35 ++++++++++++++-----------
>  drivers/firmware/efi/runtime-wrappers.c |  7 +++++
>  3 files changed, 34 insertions(+), 21 deletions(-)
>
> --
> 2.20.1
>
