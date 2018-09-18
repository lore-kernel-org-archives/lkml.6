Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75FDC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58992146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpILf7qM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58992146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeIRMsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:48:12 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34378 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbeIRMsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:48:12 -0400
Received: by mail-yb1-f194.google.com with SMTP id 184-v6so402215ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 00:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c0noeHIX0ldlcFPDgUobaOdsnZbk9b8UyXSiH2PgIxE=;
        b=HpILf7qMKTbrpxv0l/5vDzxoKPioPmi0QPX26d4UqRNP70KF4PwrNWjAmVASA18H/E
         NiQDN8tO1JwnDL+ehxI0IdzkL2XMYL3oaKVtrVX6zQdswXgsI0FwflZ0FmK8bRGP041N
         yavyLpvQlPEZlTuKYgvtK+yIihE5/RPF3WMsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c0noeHIX0ldlcFPDgUobaOdsnZbk9b8UyXSiH2PgIxE=;
        b=Mbc8eGWic9jIfIuC4MgqolKeP57YONOGGh32aKCSWP8unuL2KtFLYWmlZDPzWmC9ct
         NHkER5CDPpoVUdaPMfyRw9h5f8c+EC3jkwFzi20Z85ar4OkXTZCMpyWlIV3FVqjGhxV6
         5ac1P32vk/UbJTtIorFxBSNgIYyy4Kt2H6EMJMzQfWmJ1q210iCs6N6j+YBagSCNIWVr
         942nJIviK6T9MjyJAoQA73C1Yn9XMHC5LBn3kWMjl/Zx546JJVn1/qH05yKfSreH36Gj
         +jowtOTFmw3/RrZ7GMAAdWt21XyNk9tvaZANGKTlo6lLwGUgZgP3ZBOpiLC5rLkxnJBs
         fX1w==
X-Gm-Message-State: APzg51AAAdW+MKaiHSKtAgdFiYvbm6qD0i+gvIGmkbC+wrZlgXY5Vcfp
        3Vy66wJDdNvDXutxAUPBgFYRPAUE/B/mPryxNvVdog==
X-Google-Smtp-Source: ANB0Vdaay9H95RWsKpBPr0pAsKpQc1NPYSWCwwXLqAz8IQbe7C+OPkygetZQKuPcje0xpma05vU3CTdD9SOl2pdg37k=
X-Received: by 2002:a25:e548:: with SMTP id c69-v6mr11778281ybh.393.1537255014875;
 Tue, 18 Sep 2018 00:16:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 00:16:54
 -0700 (PDT)
In-Reply-To: <CAMuHMdVR+GKwT8WwjZy+=8j=ndWJ0s0sVnCGFGtsyvPAY9jnHQ@mail.gmail.com>
References: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
 <1533791723-3882-3-git-send-email-firoz.khan@linaro.org> <CAMuHMdVR+GKwT8WwjZy+=8j=ndWJ0s0sVnCGFGtsyvPAY9jnHQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 12:46:54 +0530
Message-ID: <CALxhOnheD75br1X_A7h5cNYWdjrDn4ciPc++mYd-_oZJApJyZg@mail.gmail.com>
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

On 9 August 2018 at 13:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Firoz,
>
> One first comment below...
>
> On Thu, Aug 9, 2018 at 7:16 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>> NR_syscalls macro holds the number of system call exist in m68k
>> architecture. This macro is currently the part of asm/unistd.h file.
>> We have to change the value of NR_syscalls, if we add or delete a
>> system call.
>>
>> One of patch in this patch series has a script which will generate
>> a uapi header based on syscall.tbl file. The syscall.tbl file
>> contains the number of system call information. So we have two
>> option to update NR_syscalls value.
>>
>> 1. Update NR_syscalls in asm/unistd.h manually by counting the
>>    no.of system calls. No need to update NR_syscalls untill
>>    we either add a new system call or delete an existing system
>>    call.
>>
>> 2. We can keep this feature it above mentioned script, that'll
>>    count the number of syscalls and keep it in a generated file.
>>    In this case we don't need to explicitly update NR_syscalls
>>    in asm/unistd.h file.
>>
>> The 2nd option will be the recommended one. For that, I moved the
>> NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
>> name also changed form NR_syscalls to __NR_syscalls for making the
>> name convention same across all architecture. While __NR_syscalls
>> isn't strictly part of the uapi, having it as part of the generated
>> header to simplifies the implementation.
>
> It can indeed not be part of the UAPI, as UAPI definitions can never change,
> while new syscalls will be added in the future, increasing the number ;-)

Thanks for your reply :)
Sorry for the delayed response :(

I would like to keep __NR_syscalls macro to uapi header in order to simplify
the system call table generation script. Otherwise the __NR_syscalls
macro need to update manually. That become a problem.

Please check the below implementation in uapi file make sense?
It is an easy workaround to leave __NR_syscalls macro in uapi/asm/unistd.h
and enclose it in #ifdef __KERNEL__

...
...
#define __NR_pwritev2  378
#define __NR_statx      379

#ifdef __KERNEL__
#define __NR_syscalls   380
#endif
...
...

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
