Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D21C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358E520C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="fnuF8gc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfBYPxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:53:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39277 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfBYPxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:53:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so10496881wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 07:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X7sKwbYrLSIJUJ9jPqZmquG/sga/Seag9q08cTdOghg=;
        b=fnuF8gc0c+N/1YCleHIqdfa6gA6JQjxj2O27uCoE6WOdS/sRJN0Ht2huTAgH2HB5Jk
         Jf0hIhy/SS24/DknywIbC9zl87n6GysbCHcTJGL5823X6G5M0NjI1/lTRZGeOTKtEMdx
         2OvRZjShLmwytyghdSTL+IUDOzsoWiqkMuLa44T0wEBa38183NTmUclMMfOhrijqwaip
         RjdvlBbSb2oCaMXgo1Z/s25bbiUmkdaR912FLm+DwOqDTAXkyAFhAY6Xrzj4ru2YhPZX
         N8oiJOHFsz5Y55+6rPvwb+oysj8BNTqXinXDMgVA2sOTZdZeUFc8Db+LeKT7tQOX0pEG
         NHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X7sKwbYrLSIJUJ9jPqZmquG/sga/Seag9q08cTdOghg=;
        b=AYzBMZxEhLBRb7E+cv04aKeILKrWFz5wgDmq9/8a74X8oolta3xsx8i8OqMEHUKyg8
         Wy5LFEmedf8IGnGGXixWTxeTzs87NcKSZJzXaDCxTfmExRgBz2jCjZPnDv7nvX/BrUnY
         y7+04lm0I1Cl/Kl+Ifai0qOTx43DODvwgyHmbvOuqZNYci8O5yRdjcz6b14bWejpKlme
         3b5uGuymj/XJ6vfbiujLDBoBY58l1WHgyJ1jEvU24+XvEcfNT6mU6qYtX05XVNbE3dYW
         P97RRXFK417QFYf1JogWWS4QnfS0D71FCS5ou7nTV4YJevIsjgO2vErzKJpi/7dPOOQz
         putQ==
X-Gm-Message-State: AHQUAubJmKBB/a7Mlq/nlCsUi88h2Qk5VEnHT6j2heSmHW8iQ8FWHGB3
        Fa14zHb5Sga2WI9YPFElXjtrVH9hD63gTV3bwbaUKg==
X-Google-Smtp-Source: AHgI3Ia7HgMw7oAlTgseU1kVZOd42p1aGQF0xXIEIyIDV+BMy0uKc3txTzpgstPfzts8w3lNBf2SKSW99BPx3QtA9Uk=
X-Received: by 2002:adf:e58f:: with SMTP id l15mr11960362wrm.309.1551109993843;
 Mon, 25 Feb 2019 07:53:13 -0800 (PST)
MIME-Version: 1.0
References: <20190225124330.613028745@infradead.org> <20190225125232.191698923@infradead.org>
In-Reply-To: <20190225125232.191698923@infradead.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 25 Feb 2019 07:53:01 -0800
Message-ID: <CALCETrW1_r=Qgbpiq8PsYYD11W7CwAS-UCAxzvvubJnMAHH2Dg@mail.gmail.com>
Subject: Re: [PATCH 5/6] objtool: Add UACCESS validation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 4:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> It is important that UACCESS regions are as small as possible;
> furthermore the UACCESS state is not scheduled, so doing anything that
> might directly call into the scheduler will cause random code to be
> ran with UACCESS enabled.
>
> Teach objtool too track UACCESS state and warn about any CALL made
> while UACCESS is enabled. This very much includes the __fentry__()
> tracing calls and __preempt_schedule() calls.
>
> Note that exceptions _do_ save/restore the UACCESS state, and therefore
> they can drive preemption. This also means that all exception handlers
> must have an otherwise dedundant UACCESS disable instruction;
> therefore ignore this warning for !STT_FUNC code (exception handlers
> are not normal functions).
>
> It also provides a UACCESS_SAFE() annotation which allows explicit
> annotation. This is meant to be used for future things like:
> unsafe_copy_{to,from}_user().
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/frame.h           |   30 +++++++++++-
>  tools/objtool/arch.h            |    4 +
>  tools/objtool/arch/x86/decode.c |   14 +++++
>  tools/objtool/check.c           |  100 ++++++++++++++++++++++++++++++++++++----
>  tools/objtool/check.h           |    2
>  tools/objtool/elf.h             |    1
>  6 files changed, 138 insertions(+), 13 deletions(-)
>
> --- a/include/linux/frame.h
> +++ b/include/linux/frame.h
> @@ -28,10 +28,38 @@ asm (".pushsection .discard.nonstd_frame
>       ".byte 0\n\t"
>       ".popsection\n\t");
>
> +/*
> + * This macro marks functions as UACCESS-safe, that is, it is safe to call from an
> + * UACCESS enabled region (typically user_access_begin() /
> + * user_access_end()).
> + *
> + * These functions in turn will only call UACCESS-safe functions themselves (which
> + * precludes tracing, including __fentry__ and scheduling, including
> + * preempt_enable).
> + *
> + * UACCESS-safe functions will obviously also not change UACCESS themselves.
> + */
> +#define UACCESS_SAFE(func)                                             \
> +       asm (".pushsection .discard.uaccess_safe_strtab, \"S\", @3\n\t" \
> +            "999: .ascii \"" #func "\"\n\t"                            \
> +            "     .byte 0\n\t"                                         \
> +            ".popsection\n\t"                                          \
> +            ".pushsection .discard.uaccess_safe\n\t"                   \
> +            ".long 999b - .\n\t"                                       \
> +            ".popsection")

Minor nit: using big numbers like 999: like this always bugs me.  It
relies on there not being a macro nested inside or outside this that
uses the same number.  My general preference is to do something like
.Ldescription_\@ instead.

Otherwise this looks conceptually good :)
