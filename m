Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B78BC070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 03:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1916F2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 03:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0BIArQ4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1916F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeJOL0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 07:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbeJOL0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 07:26:52 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476B320895
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 03:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539575011;
        bh=eXlhtT/0yW/EpHseOYQMo5PoWvMH6BDErrGmYMeqKKA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0BIArQ4ccTwJRjHQCGOWdIKWxT2gX3B330dbRrVyIBvNEsKK5gVmp4hKt/ppwGwe8
         MDpqrSM/u04FkOP5Wpfx2jpEsKoI9UpKlTp93zJ8NSb5C9aMXi0km+/kmUWvTjAj5o
         7E43YbF0+a1MBbexbsS2grNu9yg9DoHV82mmcvnc=
Received: by mail-wm1-f51.google.com with SMTP id 193-v6so18005457wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 20:43:31 -0700 (PDT)
X-Gm-Message-State: ABuFfohe0KFVyyAWD0ZQplwbiwHsyB7B/9J6AWUVf+udyo9Fs26z1Zzh
        oOHVgom3k7B6QvRggpD5v71XFQT+Klp5Q85pv24Vvg==
X-Google-Smtp-Source: ACcGV62hlwQGoI87QIbKTMs47KI1pZUyzT5iCb1ffhg8L8URKoFvkTcsOxnTCEEO4EDBHhuvYiutgrh5s7uTvmNv2qI=
X-Received: by 2002:a1c:f312:: with SMTP id q18-v6mr11544011wmq.14.1539575009617;
 Sun, 14 Oct 2018 20:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181015003726.29103-1-nick.desaulniers@gmail.com>
In-Reply-To: <20181015003726.29103-1-nick.desaulniers@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 14 Oct 2018 20:43:18 -0700
X-Gmail-Original-Message-ID: <CALCETrUZoBtxoR9u=72CSmNa-793EZySMd7TjH_BmHcrNSvLZg@mail.gmail.com>
Message-ID: <CALCETrUZoBtxoR9u=72CSmNa-793EZySMd7TjH_BmHcrNSvLZg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: annotate no_context with UNWIND_HINTS
To:     nick.desaulniers@gmail.com, Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, natechancellor@gmail.com,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 5:37 PM Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
>
> Fixes the objtool warning:
> arch/x86/mm/fault.o: warning: objtool: no_context()+0x220: unreachable
> instruction
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/204
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
>  arch/x86/mm/fault.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 47bebfe6efa7..057d2178fa19 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -760,9 +760,11 @@ no_context(struct pt_regs *regs, unsigned long error_code,
>                  * and then double-fault, though, because we're likely to
>                  * break the console driver and lose most of the stack dump.
>                  */
> -               asm volatile ("movq %[stack], %%rsp\n\t"
> +               asm volatile (UNWIND_HINT_SAVE
> +                             "movq %[stack], %%rsp\n\t"
>                               "call handle_stack_overflow\n\t"
> -                             "1: jmp 1b"
> +                             "1: jmp 1b\n\t"
> +                             UNWIND_HINT_RESTORE
>                               : ASM_CALL_CONSTRAINT
>                               : "D" ("kernel stack overflow (page fault)"),
>                                 "S" (regs), "d" (address),

NAK.  Just below this snippet is unreachable();

Can you reply with objtool -dr output on a problematic fault.o?  Josh,
it *looks* like annotate_unreachable() should be doing the right
thing, but something is clearly busted.

Also, shouldn't compiler-clang.h contain a reasonable definition of
unreachable()?

--Andy
