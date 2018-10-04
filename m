Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D732C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF63221473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr+/QzKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF63221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeJDOuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:50:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36082 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJDOt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:49:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so8803030wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 00:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X0ASNwBxHKF6ktzMVYXK27WDzQC+31Y2Q38KQhGgTbo=;
        b=Wr+/QzKzLWJH/FUBd2G3buE/JqcF/PgT5zKK7eI7IXRMr28AiKxNOk7UQWf9YF1eSJ
         VGrRWlBrN/MvruShu0NzHIydYPzHZUK3qlwmNxtvqOCqPB4qfTMzbuSbyR1z0E1g5NzS
         /gx0oHZkIkxviHopKR1qKMGUyqA05sQKYhquOU8uebXpK40Dcn6bqqOgNoFytb9vvMtL
         MmOghckNADhXyBDV2/Anmc/P/o1CgEp6g9aJWkqVyUMK7MrdfPavPpsf1Yfr3ZW18XkI
         5uF9ODFK6GMA9hJvEApDQ5fvQx0p3m3jF8ilafkRAvjuBLr+h2LXaWCmhW9PrGWWvs1/
         YAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X0ASNwBxHKF6ktzMVYXK27WDzQC+31Y2Q38KQhGgTbo=;
        b=iOCvtkNNg9NUq7fA6FaDvO0gBPle0CuAeRShjjOdTgX/pEN7PJDnxvDuVsP0nCpxPw
         bQrhJouqmbqW6xBQzQ16f83dzoHMKogwuFG1xqYD+jkyHAjIeXVEkaqQrg6kX+cG4kAR
         u/zPuq0BGQOGSdI/dRdFKwEsvxW8kllkTrmJ9tDPWd/4qMnUeMaqu1Pt5IzLaNPIxBRr
         l1GoTnEVqLX2K9s12vq+6yMwsgF9eQf1RTEGYIxnKbUXvozPVnVI2NP7wU8N+X0xGeOT
         QDMVDP59cx6rVfPJi7vT2BgcDEH8tLa/KetiTmRL32GDdGszA5M/A0Hy0yQl3lnhwhMC
         pnkg==
X-Gm-Message-State: ABuFfogA9LDBSSmUAtDRpyMmOvzI8XXW8eneCw2AIwAqnrmBF1WcG6x5
        bqz2u+fiu1vyTNms75IwHHKcyV0z
X-Google-Smtp-Source: ACcGV631gkl6i86iCvEvGp1yqzpRrxCuBPDvis1e/b2TmuxgEIns69oJSrkqwDI043wlqew1RFZvxw==
X-Received: by 2002:adf:da43:: with SMTP id r3-v6mr3881430wrl.221.1538639878777;
        Thu, 04 Oct 2018 00:57:58 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a12-v6sm2320002wrr.71.2018.10.04.00.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 00:57:58 -0700 (PDT)
Date:   Thu, 4 Oct 2018 09:57:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Message-ID: <20181004075755.GA3353@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003213100.189959-5-namit@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> GCC considers the number of statements in inlined assembly blocks,
> according to new-lines and semicolons, as an indication to the cost of
> the block in time and space. This data is distorted by the kernel code,
> which puts information in alternative sections. As a result, the
> compiler may perform incorrect inlining and branch optimizations.
> 
> The solution is to set an assembly macro and call it from the inlined
> assembly block. As a result GCC considers the inline assembly block as
> a single instruction.
> 
> This patch allows to inline functions such as __get_seccomp_filter().
> Interestingly, this allows more aggressive inlining while reducing the
> kernel size.
> 
>    text	   data	    bss	    dec	    hex	filename
> 18140970 10225412 2957312 31323694 1ddf62e ./vmlinux before
> 18140140 10225284 2957312 31322736 1ddf270 ./vmlinux after (-958)
> 
> Static text symbols:
> Before:	40302
> After:	40286	(-16)
> 
> Functions such as kref_get(), free_user(), fuse_file_get() now get
> inlined.

Yeah, so I kind of had your series on the back-burner (I'm sure you noticed!),
mostly because what I complained about in a previous round of review a couple
of months ago: that the description of the series and the changelog of every
single patch in it is tiptoeing around the *real* problem and never truly
describes it:

   ** This is a GCC bug, plain and simple, and we are uglifying **
   ** and complicating kernel assembly code to work it around.  **

We'd never ever consider such uglification for Clang, not even _close_.

Sure this would have warranted a passing mention? Instead the changelogs are
lovingly calling it a "distortion" as if this was no-one's fault really, and
the patch a "solution".

How about calling it a "GCC inlining bug" and a "workaround with costs" 
which it is in reality, and stop whitewashing the problem?

At the same time I realize that we still need this series because GCC won't
get fixed, so as a consolation I wrote the changelog below that explains
how it really is, no holds barred.

Since the tone of the changelog is a bit ... frosty, I added this disclaimer:

  [ mingo: Wrote new changelog. ]

Let me know if you want me to make it more prominent that you had absolutely
no role in writing that changelog.

I'm also somewhat annoyed at the fact that this series carries a boatload
of reviewed-by's and acked-by's, yet none of those reviewers found it
important to point out the large chasm that is gaping between description
and reality.

Thanks,

    Ingo


=============>
Subject: x86/refcount: Prevent inlining related GCC distortions
From: Nadav Amit <namit@vmware.com>
Date: Wed, 3 Oct 2018 14:30:54 -0700

The inlining pass of GCC doesn't include an assembler, so it's not aware
of basic properties of the generated code, such as its size in bytes,
or that there are such things as discontiuous blocks of code and data
due to the newfangled linker feature called 'sections' ...

Instead GCC uses a lazy and fragile heuristic: it does a linear count of
certain syntactic and whitespace elements in inlined assembly block source
code, such as a count of new-lines and semicolons (!), as a poor substitute
for "code size and complexity".

Unsurprisingly this heuristic falls over and breaks its neck whith certain
common types of kernel code that use inline assembly, such as the frequent
practice of putting useful information into alternative sections.

As a result of this fresh, 20+ years old GCC bug, GCC's inlining decisions
are effectively disabled for inlined functions that make use of such asm()
blocks, because GCC thinks those sections of code are "large" - when in
reality they are often result in just a very low number of machine
instructions generated.

This absolute lack of inlining provess when GCC comes across such asm()
blocks both increases generated kernel code size and causes performance
overhead, which is particularly noticeable on paravirt kernels, which make
frequent use of these inlining facilities in attemt to stay out of the
way when running on baremetal hardware.

Instead of fixing the compiler we use a workaround: we set an assembly macro
and call it from the inlined assembly block. As a result GCC considers the
inline assembly block as a single instruction. (Which it often isn't but I digress.)

This uglifies and bloats the source code:

  2 files changed, 46 insertions(+), 29 deletions(-)

Yay readability and maintainability, it's not like assembly code is hard to read
and maintain ...

This patch allows GCC to inline simple functions such as __get_seccomp_filter().

To no-one's surprise the result is GCC performs more aggressive (read: correct)
inlining decisions in these senarios, which reduces the kernel size and presumably
also speeds it up:

      text     data     bss      dec     hex  filename
  18140970 10225412 2957312 31323694 1ddf62e  ./vmlinux before
  18140140 10225284 2957312 31322736 1ddf270  ./vmlinux after (-958)

Change in size of static text symbols:

   Before: 40302
    After: 40286 (-16)

Functions such as kref_get(), free_user(), fuse_file_get() now get inlined. Hurray!

We also hope that GCC will eventually get fixed, but we are not holding
our breath for that. Yet we are optimistic, it might still happen, any decade now.

[ mingo: Wrote new changelog. ]

Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181003213100.189959-5-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
