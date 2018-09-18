Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B789DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691F621471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPn43Tqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691F621471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeIRRt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:49:29 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43277 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeIRRt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:49:29 -0400
Received: by mail-yb1-f195.google.com with SMTP id w80-v6so683111ybe.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 05:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=glLkviCEkPwWgV6dyixYXh9CNOcWoYdEA0RZl0Gzy6Y=;
        b=HPn43TqpD29D6o2PRdahqpj+nKMMoVtBGXQ9DzJxoYHh6BIzLFH4z//qhHIfu4XlEM
         OFliY3OApp8SrhNM5IdZpgKzJ1oOxvHulnzMZRNBtlvdfZ3dQ4hMM3+Q54zWe2IMIpej
         Rhz8AZOf0v/xQDQ7+V9eUGd6NmRmRV3LsIXvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=glLkviCEkPwWgV6dyixYXh9CNOcWoYdEA0RZl0Gzy6Y=;
        b=bii92ZCuHcePnOfbV5Hbx5GrXIumELUw05qiMjOtzPsKF0MbPMETMGE3pvX17auUGp
         ZEb5NShDK9M7h694nbABJLEi6wLRZvM8xL2UY8FKXioNsoSfdNIpyP5tqrNTUphOKY6B
         x27QvJKPcjWTP5CRpoIwQwnwoM+n7Pn5mmm3RWFKDOoHHtWlGSkxMjo3K4KO81YptW6K
         kiPMBLijy6mK3eAEJ7rsWhUc4u+FBlUxG+0WdI738E0OoRhUCC7wI64nsWbFm9IbGvS2
         i75EM3NYTKrLQftMbTJ9i+Ef4SNRohkltSbvIJOH7rNPkqrnMWrCnVZOdRHQVG42gggm
         utew==
X-Gm-Message-State: APzg51DLqCj4wv2TfE7n48APQiTOro9UzCTLDjBKnuPIT6PSG4UUKyHe
        SgV6VB9mJxRUd1OOxi1N6B6JJ626o6ko4l2hqnyKww==
X-Google-Smtp-Source: ANB0VdYB6D4lDIn6qQgOX7iW/LFoFB6/YJ+mfHCfcKe2wodQ2G+AfIKyd/mJA2jzTXTOPUP+iBWbIu5RBAmlbTTmdyA=
X-Received: by 2002:a25:e548:: with SMTP id c69-v6mr12251928ybh.393.1537273028897;
 Tue, 18 Sep 2018 05:17:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 05:17:08
 -0700 (PDT)
In-Reply-To: <CAMuHMdUcg-73DNNGuG3Kn9oQ9R+LpYxpWYV_1tmzN-EzBFUXVQ@mail.gmail.com>
References: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
 <1533791723-3882-3-git-send-email-firoz.khan@linaro.org> <CAMuHMdVR+GKwT8WwjZy+=8j=ndWJ0s0sVnCGFGtsyvPAY9jnHQ@mail.gmail.com>
 <CALxhOnheD75br1X_A7h5cNYWdjrDn4ciPc++mYd-_oZJApJyZg@mail.gmail.com> <CAMuHMdUcg-73DNNGuG3Kn9oQ9R+LpYxpWYV_1tmzN-EzBFUXVQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 17:47:08 +0530
Message-ID: <CALxhOnj3HHf8dSSrWSFMQ-7vikkRVP+v=kV+8MJOnA00oDfmig@mail.gmail.com>
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

Thanks for the reply. I'll post v2 patches ASAP with this changes.

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
