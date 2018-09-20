Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4824FECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE00D21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJLkByaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE00D21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbeITNyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:54:52 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39077 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeITNyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:54:52 -0400
Received: by mail-yw1-f67.google.com with SMTP id k130-v6so903795ywe.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 01:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8oJy7BqSZNnTAN520tyfdX6YbtuMitnMJzwVgZH+hV4=;
        b=RJLkByajtf0DrgeClLVN3foGgGLUj6/WQJL9pWNAamx2eyE+8wS7zzubgUb1paAt5h
         RE5fmkrHF1qWcY94XJalt+wevPNvIokB8Axb4j9IO6jHzVM277fXJxBwlMy2KjID2+wc
         TbO/pcgT/y2uBVYUOHYKXTPDMOjg0lvwA59pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8oJy7BqSZNnTAN520tyfdX6YbtuMitnMJzwVgZH+hV4=;
        b=GEF4LE1tOPL0f4CxBljqx6JorZO0f5MR7C5LDt640BAyozWgiXC/erRAfZ+ox9KqV/
         tD/f5N6KwV8qjCzqoXDtMEGxt08t/40aOt8cPq4gJwCHr7exueM49MXS7fJVKHelFF//
         +PsjlHqMi56liohBTtbm+nOOqvfrggQbwptRx8f9qAvP9bwB46CxdrzoSiCLorI+53DU
         Bcpfb4p3SeV6SPqA77wJE022HxMxlBV64zmfSwi4qa8m7ly7xyTho82mVZ+EXQME8Fyc
         c8/l1372Fc/sY/DsncUhGwExtCOoafFjkR2aDjUaREftesQ+/agYr4qbo2ZfsTwfDOjK
         Kpcw==
X-Gm-Message-State: APzg51DVRNXmteVbPVMz+rpGUir5WglJ+exqtBAUKQWAlql07Fs1TshX
        u/VUwcXR1z0EHupxQDx6Ytrer1ZLjGKpwHsQ6R8O5A==
X-Google-Smtp-Source: ANB0VdbuRp6mD0JVJ32GO8AlHn+1l7HDRWIckn+BGR5EPy6QeowWwFhItS8npLMxxvwyLApRmTNZ/Y+YIAweCxWu/SY=
X-Received: by 2002:a81:5fd4:: with SMTP id t203-v6mr12568140ywb.84.1537431157642;
 Thu, 20 Sep 2018 01:12:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 01:12:37
 -0700 (PDT)
In-Reply-To: <CAMuHMdUcg-73DNNGuG3Kn9oQ9R+LpYxpWYV_1tmzN-EzBFUXVQ@mail.gmail.com>
References: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
 <1533791723-3882-3-git-send-email-firoz.khan@linaro.org> <CAMuHMdVR+GKwT8WwjZy+=8j=ndWJ0s0sVnCGFGtsyvPAY9jnHQ@mail.gmail.com>
 <CALxhOnheD75br1X_A7h5cNYWdjrDn4ciPc++mYd-_oZJApJyZg@mail.gmail.com> <CAMuHMdUcg-73DNNGuG3Kn9oQ9R+LpYxpWYV_1tmzN-EzBFUXVQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 20 Sep 2018 13:42:37 +0530
Message-ID: <CALxhOnjLKU8BCHFoc35P_tTh=6+NRbCrO6oB3Gar=uBMqYU4iw@mail.gmail.com>
Subject: Re: [PATCH 2/4] m68k: Replace NR_syscalls macro from asm/unistd.h
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 18 September 2018 at 15:34, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Firoz,
>
> On Tue, Sep 18, 2018 at 9:16 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>> On 9 August 2018 at 13:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > One first comment below...
>> >
>> > On Thu, Aug 9, 2018 at 7:16 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>> >> NR_syscalls macro holds the number of system call exist in m68k
>> >> architecture. This macro is currently the part of asm/unistd.h file.
>> >> We have to change the value of NR_syscalls, if we add or delete a
>> >> system call.
>> >>
>> >> One of patch in this patch series has a script which will generate
>> >> a uapi header based on syscall.tbl file. The syscall.tbl file
>> >> contains the number of system call information. So we have two
>> >> option to update NR_syscalls value.
>> >>
>> >> 1. Update NR_syscalls in asm/unistd.h manually by counting the
>> >>    no.of system calls. No need to update NR_syscalls untill
>> >>    we either add a new system call or delete an existing system
>> >>    call.
>> >>
>> >> 2. We can keep this feature it above mentioned script, that'll
>> >>    count the number of syscalls and keep it in a generated file.
>> >>    In this case we don't need to explicitly update NR_syscalls
>> >>    in asm/unistd.h file.
>> >>
>> >> The 2nd option will be the recommended one. For that, I moved the
>> >> NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
>> >> name also changed form NR_syscalls to __NR_syscalls for making the
>> >> name convention same across all architecture. While __NR_syscalls
>> >> isn't strictly part of the uapi, having it as part of the generated
>> >> header to simplifies the implementation.
>> >
>> > It can indeed not be part of the UAPI, as UAPI definitions can never change,
>> > while new syscalls will be added in the future, increasing the number ;-)
>>
>> Thanks for your reply :)
>> Sorry for the delayed response :(
>>
>> I would like to keep __NR_syscalls macro to uapi header in order to simplify
>> the system call table generation script. Otherwise the __NR_syscalls
>> macro need to update manually. That become a problem.
>>
>> Please check the below implementation in uapi file make sense?
>> It is an easy workaround to leave __NR_syscalls macro in uapi/asm/unistd.h
>> and enclose it in #ifdef __KERNEL__
>>
>> ...
>> ...
>> #define __NR_pwritev2  378
>> #define __NR_statx      379
>>
>> #ifdef __KERNEL__
>> #define __NR_syscalls   380
>> #endif
>> ...
>> ...
>
> #ifdef __KERNEL__ sounds fine to me.

I posted similar script for 10 different architectures. I got few good review
from the maintainers and it will be applicable for all the
architectures including
m68k. There are few area which I identified need to improve. This will take
couple of days.

But it will be very helpful if you can perform the boot test on the
actual platform
and share the result.

FYI, Keeping a single script is always our plan for long run. But I
have to keep a
separate versions for the start so each architecture can be handled  in one
series. Which would make easier to merge in the initial version. we
could probably
add it to scripts/*.sh first, but that requires more coordination between the
architectures.

- Firoz

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
