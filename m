Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D691C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 23:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F042420989
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 23:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ccuv5ZVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F042420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeHWCci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 22:32:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42963 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeHWCci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 22:32:38 -0400
Received: by mail-pl0-f67.google.com with SMTP id g23-v6so1499391plq.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 16:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Fo+ssxlsffRwJ11v43NSCYWcaoPoti5hb3PoLOrwt4=;
        b=Ccuv5ZVvxvrywNFyQfCD0xAuZo72P6J1xZ4dWTCVg+N/TTzhLaBWBEhqdhqexse1oz
         7nPxJ9fRApedP59xgSvI28/9QvXPtaCPSAPE7rNrXdaEjkMgfsx/ny7ulJ5naC8TgmHm
         sMMXjKLkAh0edEtTQIchn1jyMaO8GweAeEZwCNwVWalSFlL4ZGfx9JCF8Rln5zxn2poN
         uKv6pC1IbDBafwPDbT5NLkbK1ue1JKFBTr+OGgCvj2TQl6aUmgA5yiwCYLUn26e9LIXf
         m/GFxVdZXW4R4LbMvszjou7QxuqD8R+/vUqq+PcCMhVW69eBFuZnn94Am+U9oLSJ9oVw
         4kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Fo+ssxlsffRwJ11v43NSCYWcaoPoti5hb3PoLOrwt4=;
        b=mSwxqC0jw33Hq1vELE8zfswiRq51gh9IIhRHKNHvY1LolTSwUWarATjMcUsSRaJfrd
         85W9V5g/+HA20blIDL01sBb/Wns5nLlSlcGET6dRqcihr6Y+LSujH83XnraoMQME4GYP
         xZ0JE95CCumAZ5wIJAYsXPhhh7AudrDmZB668SPq6Ug9DJ4oEv5i+3zMfuTkVAl3MALC
         iEhoLTwhKubLSLuEkABjNLbmFIdK1XySCoVJt4905GZzCnBJ4Z3BqyRbZ7l/HfH6n77R
         zEpTu4MN3ThkBSHxdn3dVObylXcQy4DjiNxe5VKdOPGk4CaRdA8z8WkVo3MK4kfULA4l
         z7bA==
X-Gm-Message-State: AOUpUlHoXZjglX237cV8rZXpkZqR8xJS20kNV0OEl5LxII3a0vIatqXb
        pQMlXSs4Jz2A64XWEdZC3ClHLC0svcADounwJfBCbg==
X-Google-Smtp-Source: AA+uWPwGzXn30Dl0L3YhXGQNuj3qUPPu0eimnr3cee98bVid69PEh3qowDdIFttQTdFcApIxLfX+A7yp5tmmF4i5DGo=
X-Received: by 2002:a17:902:b7c3:: with SMTP id v3-v6mr20082710plz.238.1534979147637;
 Wed, 22 Aug 2018 16:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
 <20180821123832.GA19034@nautica> <CAKwvOdmLQen+TWF_F3e5-66vtF3FEnoxjEgZbjmOZ9cv6YrEpA@mail.gmail.com>
 <acb93bae0086447c7cbe0eec05907335ebae7788.camel@perches.com>
 <CAKwvOdkLGhdQxx3oV=R2kv290NOv_w8qQ_yHWCVpvmofp7+ivQ@mail.gmail.com>
 <20180822041646.GA21716@nautica> <78396ba82562326f4b3a395a63e3e8dc38d608b2.camel@perches.com>
 <20180822043230.GA26654@nautica> <CAKwvOdm+BwvDxAw-A_1v5xO2EjDff1axAttHVz5QnBSxSbKo=g@mail.gmail.com>
 <39b6242771fd80fe19104c8a057bcc6afc0e41e5.camel@perches.com>
In-Reply-To: <39b6242771fd80fe19104c8a057bcc6afc0e41e5.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 22 Aug 2018 16:05:36 -0700
Message-ID: <CAKwvOdmZuzhyaOzh_ruNQUp96zed8+BAz3DCw1hrZrseVNg9tA@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
To:     joe@perches.com
Cc:     asmadeus@codewreck.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        daniel@iogearbox.net, hpa@zytor.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 1:50 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2018-08-22 at 11:31 -0700, Nick Desaulniers wrote:
> > On Tue, Aug 21, 2018 at 9:32 PM Dominique Martinet
> > <asmadeus@codewreck.org> wrote:
> > >
> > > Joe Perches wrote on Tue, Aug 21, 2018:
> > > > On Wed, 2018-08-22 at 06:16 +0200, Dominique Martinet wrote:
> > > > > I think that could work, but at the point making a separate
> > > > > compiler-common.h and not including compiler-gcc.h for clang sounds
> > > > > better to me... More importantly here, either solution sound complex
> > > > > enough to require more than a few days and proper testing for all archs
> > > > > etc when compared to the partial revert we have here.
> > > >
> > > > The immediate need for a partial revert seems unnecessary as
> > > > clang hasn't really worked for a couple releases now.
> > >
> > > Sorry for repeating myself, clang is used by bcc for compiling BPF
> > > programs (e.g. bpf_module_create_c_from_string() or any similar function
> > > will use the clang libs to compile the bpf program with linux headers),
> > > and this has always been working because it's not using our makefiles.
> > >
> > > This broke today in master and I only joined this thread after looking
> > > at why the build started failing today and noticing this patch, it
> > > definitely hasn't been broken for two releases, or I wouldn't be here
> > > with this timing :)
> > >
> > >
> > > > The separate compiler file changes are much more sensible,
> > > > even if it takes a few days.
> > >
> > > A few days are fine, but I think some form of fix in 4.19-rc1 would be
> > > good.
> > >
> > > I'll stop taking your time now, but I think you are/were underestimating
> > > how many people use clang with the linux kernel headers indirectly.
> > > BPF is a well-used tool :)
> >
> > Hi Dominique,
> > I'm currently testing a fix in
> > https://github.com/ClangBuiltLinux/linux/commit/1f89ae7622c26b8131f42f3a362d6ef41b88a595,
> > can you please share with me your steps to test/verify that the patch
> > fixes the issue for eBPF?  I'll go talk to a co-worker who know more
> > about eBPF, but I've not yet done anything with it.
>
> A mild suggestion about the patch would be to break it up into
> 2 patches to improve how people read and review them.
>
> 1 include/linux/compiler-*
> 2 everything else
>
> Yes, some kernel configs might not build properly between 1 and 2
> but that likely doesn't matter as those configs probably don't
> build before 1 either.

If we ordered the patches so that the "everything else" went in first,
it would not be a problem.  The first patch would just be the checks
that GCC_VERSION is defined.

In general, I'm happy to split patches, but in this suggested case, it
only shaves off 26 lines from the main body of work.  I don't think 26
lines is enough to justify splitting for readability.  But let me know
if you feel strongly about that point and I'll be happy to split. (or
possibly by "everything else" you meant something else?)

> Perhaps the test in arch/arm/kernel/asm-offsets.c for incompatible
> gcc compiler versions from 4.8.0 to 4.8.2 should be moved to
> compiler-gcc.h.

This a good suggestion, and one I've thought about, although in the
context of builtins.  *Detour ahead*.  Builtins are not portable by
default, and their use really should be feature detected (impossible
currently on gcc due to
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66970) or version checks
and protected by macros like the symbols in my current patch.  I think
I might soon hoist them to a shared header that safely detects their
support or provides a fallback when possible.  One issue is that some
builtins are arch specific, so do you want to feature detect arch
specific ones for builds of a different arch?  And that's the problem
I have with hoisting arch specific compiler checks into a shared
header; builds of other archs should pay no build penalty for
unrelated archs.  All that to say that I think it's best to keep arch
specific checks in arch/ specific subdirs, but I welcome more thoughts
on this.

Ok, I've boot tested this patch for x86_64 and arm64 in qemu, with
CC=gcc-7.2, CC=clang-8, and CC=clang-8 HOSTCC=clang-8 and am feeling
quite confident to send it for review.

>> Also, does anyone know who I should talk to about ICC testing?
> No clue

+ Daniel and HPA (the last commits to include/linux/compiler*
mentioning `icc` in 2015 and 2013 respectively)
--
Thanks,
~Nick Desaulniers
