Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE58ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A09620867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A09620867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeIRPgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:36:36 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33816 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbeIRPgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:36:35 -0400
Received: by mail-vs1-f65.google.com with SMTP id m10-v6so429530vsk.1;
        Tue, 18 Sep 2018 03:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSk3B4twbMDvFSuPlrXne9UgVExFWzhUGu+0rETXsn4=;
        b=l/d0HG9U5kYk0LL7ndxQAVxFcz15uuP+UiQpj8r+es/2MxV4VTU9kmEIENXXBGyHZT
         Sywt/f78uV6u5cX33cFPPIgSdBDsEX0VRQmjZERZyME/Xd4yZvuDj+hSn1dsGHbPNAo6
         MkzOlK+Pd9WVzfrQRhOzzaY4+6qR4QPXImp+3/YStKTeW4VsIQCaq2XiM287vRFk8aqS
         cKg/Wa7a3I7OqtZwNQDFAFRvEdOdhTbJv/X281nc4cBs+StbJrMJWcpiVbbNbQbdXt4l
         /P5az2HEu62A3y4IvC7MYpWgAHi+Mp5pUK88Hf814Ar98IIpwQMEqMet8NgSoioLkmQt
         rZbA==
X-Gm-Message-State: APzg51Dz/JExwhefI1PXBDAZdOqoLsaIxfeTxybDMJBveabWWPAdtfll
        L7L2RTXg59eYn0c8JHEtVCbBE3jDWDmDMcDbab0=
X-Google-Smtp-Source: ANB0VdYdG2N/ADwy2/qHq4QKYm4WcU7g3h1BpgOwFdFerNInWOelgtI0NnA8TBM8rmQvWVTYY2wd98UxZVfQSD0nSZA=
X-Received: by 2002:a67:cd07:: with SMTP id u7-v6mr8986255vsl.78.1537265083578;
 Tue, 18 Sep 2018 03:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
 <1533791723-3882-3-git-send-email-firoz.khan@linaro.org> <CAMuHMdVR+GKwT8WwjZy+=8j=ndWJ0s0sVnCGFGtsyvPAY9jnHQ@mail.gmail.com>
 <CALxhOnheD75br1X_A7h5cNYWdjrDn4ciPc++mYd-_oZJApJyZg@mail.gmail.com>
In-Reply-To: <CALxhOnheD75br1X_A7h5cNYWdjrDn4ciPc++mYd-_oZJApJyZg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Sep 2018 12:04:31 +0200
Message-ID: <CAMuHMdUcg-73DNNGuG3Kn9oQ9R+LpYxpWYV_1tmzN-EzBFUXVQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] m68k: Replace NR_syscalls macro from asm/unistd.h
To:     firoz.khan@linaro.org
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Tue, Sep 18, 2018 at 9:16 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On 9 August 2018 at 13:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > One first comment below...
> >
> > On Thu, Aug 9, 2018 at 7:16 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >> NR_syscalls macro holds the number of system call exist in m68k
> >> architecture. This macro is currently the part of asm/unistd.h file.
> >> We have to change the value of NR_syscalls, if we add or delete a
> >> system call.
> >>
> >> One of patch in this patch series has a script which will generate
> >> a uapi header based on syscall.tbl file. The syscall.tbl file
> >> contains the number of system call information. So we have two
> >> option to update NR_syscalls value.
> >>
> >> 1. Update NR_syscalls in asm/unistd.h manually by counting the
> >>    no.of system calls. No need to update NR_syscalls untill
> >>    we either add a new system call or delete an existing system
> >>    call.
> >>
> >> 2. We can keep this feature it above mentioned script, that'll
> >>    count the number of syscalls and keep it in a generated file.
> >>    In this case we don't need to explicitly update NR_syscalls
> >>    in asm/unistd.h file.
> >>
> >> The 2nd option will be the recommended one. For that, I moved the
> >> NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
> >> name also changed form NR_syscalls to __NR_syscalls for making the
> >> name convention same across all architecture. While __NR_syscalls
> >> isn't strictly part of the uapi, having it as part of the generated
> >> header to simplifies the implementation.
> >
> > It can indeed not be part of the UAPI, as UAPI definitions can never change,
> > while new syscalls will be added in the future, increasing the number ;-)
>
> Thanks for your reply :)
> Sorry for the delayed response :(
>
> I would like to keep __NR_syscalls macro to uapi header in order to simplify
> the system call table generation script. Otherwise the __NR_syscalls
> macro need to update manually. That become a problem.
>
> Please check the below implementation in uapi file make sense?
> It is an easy workaround to leave __NR_syscalls macro in uapi/asm/unistd.h
> and enclose it in #ifdef __KERNEL__
>
> ...
> ...
> #define __NR_pwritev2  378
> #define __NR_statx      379
>
> #ifdef __KERNEL__
> #define __NR_syscalls   380
> #endif
> ...
> ...

#ifdef __KERNEL__ sounds fine to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
