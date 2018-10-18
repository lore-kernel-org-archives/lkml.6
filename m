Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A102ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30EC21470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="pmI+U0Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30EC21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeJRKgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:36:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34295 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbeJRKgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:36:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id z25-v6so812117wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 19:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7/bMHPSVbQLZNWyMUxGXJS3zoiQOs09IGRLpyhmr4s=;
        b=pmI+U0Wh/1Nja4HGlWqnUPvSxNaYCbfBtaedGQg7Phs4W3peq7iyhHIdkDMv0oCFs3
         YYfUqerBre9xFa/Oe6E6o082zGFN8bIxMchAVHFEypmYYPjefg5zFPtDAvKxU72bAvTq
         joydZa0o7g1x6362YhNgBptHvVZu9/1a29WxBazR2+7pwoM8cK/OemE2/NDkGs7SdyID
         0LzoX8HqqwP5kUG25a+jDLcUe5gAsDR5CStTgeuNLWtJJbkxQHVGVKWT8rauueYWJndW
         bzRiw02jTX8VKyVG16ySAiwwjRupw/Yhy1REJmvC8omh/Vvo/Lbg4ImoBUACR8vfRrdw
         J25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7/bMHPSVbQLZNWyMUxGXJS3zoiQOs09IGRLpyhmr4s=;
        b=ZDxw7Q2BBZTwdVYxAtBGoJLtJhUHxmFuykXdTRpqEcw1A/yHyN/2N6Msk9gwzAI3zp
         218h2t/JdIJUkyESAevGDzG1NXMLd5uE3EvHmDfJS/TKVsoYedljX4DePvZT6H2R43zz
         frrUi74H5NKv3DyJLoWdYknVZvZ8je6Is3LLaFlncuKphx4raADfGRdHm29TGac8+pRs
         6vy0MtnOxYXAnE9/ZmQ3x/3VlSAPhQ5Fi4oCZGbube0CsMa49S+L3vTfPNiBe88lcykb
         3cqxjQA2g67rVpuoxk1FdvjCFW1ltlXIw+EeuUQ3JXv0O4xH3Mg0MtRnMXpLACnJWPS6
         Dzyg==
X-Gm-Message-State: ABuFfohi72AeYwRCXLOuav3xBRFNXpZUk2L5NoguyEsHVXJ0Dvi0xZc2
        p2Twtl8W2zHu5KR2JUJXyxHSCUZlZc5WSghYs+IzXA==
X-Google-Smtp-Source: ACcGV62UuWPBDjHNB+T0m/liPx71szV/pyDoNGDaN6nvQyPMpNl2asZDTvwlCA4mzfpuuFZc/OruMmjXILe7YaIK/yc=
X-Received: by 2002:a1c:4054:: with SMTP id n81-v6mr5347619wma.82.1539830274165;
 Wed, 17 Oct 2018 19:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <1460987025-30360-1-git-send-email-dsafonov@virtuozzo.com>
 <tip-abfb9498ee1327f534df92a7ecaea81a85913bae@git.kernel.org> <87h8hkc9fd.fsf@notabene.neil.brown.name>
In-Reply-To: <87h8hkc9fd.fsf@notabene.neil.brown.name>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 17 Oct 2018 19:37:42 -0700
Message-ID: <CALCETrXB8PE4Ue0BeD0wUS9psLLjpv_pt+nj=SEaj+Nb_dZzUA@mail.gmail.com>
Subject: Re: in_compat_syscall() returns from kernel thread for X86_32.
To:     NeilBrown <neilb@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-tip-commits@vger.kernel.org, jsimmons@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 6:48 PM NeilBrown <neilb@suse.com> wrote:
>
>
> Was: Re: [tip:x86/asm] x86/entry: Rename is_{ia32,x32}_task() to in_{ia32,x32}_syscall()
> On Tue, Apr 19 2016, tip-bot for Dmitry Safonov wrote:
>
> > Commit-ID:  abfb9498ee1327f534df92a7ecaea81a85913bae
> > Gitweb:     http://git.kernel.org/tip/abfb9498ee1327f534df92a7ecaea81a85913bae
> > Author:     Dmitry Safonov <dsafonov@virtuozzo.com>
> > AuthorDate: Mon, 18 Apr 2016 16:43:43 +0300
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Tue, 19 Apr 2016 10:44:52 +0200
> >
> > x86/entry: Rename is_{ia32,x32}_task() to in_{ia32,x32}_syscall()
> >
> ...
> > @@ -318,7 +318,7 @@ static inline bool is_x32_task(void)
> >
> >  static inline bool in_compat_syscall(void)
> >  {
> > -     return is_ia32_task() || is_x32_task();
> > +     return in_ia32_syscall() || in_x32_syscall();
> >  }
>
> Hi,
>  I'm reply to this patch largely to make sure I get the right people
>  .....
>
> This test is always true when CONFIG_X86_32 is set, as that forces
> in_ia32_syscall() to true.
> However we might not be in a syscall at all - we might be running a
> kernel thread which is always in 64 mode.
> Every other implementation of in_compat_syscall() that I found is
> dependant on a thread flag or syscall register flag, and so returns
> "false" in a kernel thread.
>
> Might something like this be appropriate?
>
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 2ff2a30a264f..c265b40a78f2 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -219,7 +219,7 @@ static inline int arch_within_stack_frames(const void * const stack,
>  #ifndef __ASSEMBLY__
>
>  #ifdef CONFIG_X86_32
> -#define in_ia32_syscall() true
> +#define in_ia32_syscall() (!(current->flags & PF_KTHREAD))
>  #else
>  #define in_ia32_syscall() (IS_ENABLED(CONFIG_IA32_EMULATION) && \
>                            current_thread_info()->status & TS_COMPAT)
>
> This came up in the (no out-of-tree) lustre filesystem where some code
> needs to assume 32-bit mode in X86_32 syscalls, and 64-bit mode in kernel
> threads.
>

I could get on board with:

({WARN_ON_ONCE(current->flags & PF_KTHREAD); true})

The point of these accessors is to be used *in a syscall*.

What on Earth is Lustre doing that makes it have this problem?
