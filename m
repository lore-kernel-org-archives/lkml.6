Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35BAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FFB2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDMMb9nA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfAIWHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:07:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43293 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfAIWHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:07:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so3883407pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 14:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5MCYmnwLXSItUOfFJQ3wA7TVBclPLgN1Gi/0GfWgwWU=;
        b=EDMMb9nA839GmwMsIY1JpdzRmdyj5qvYn8My1+W5/LE4z0CRE6kTXWF1SIw/rBEuyN
         Eq9wvYvKfzk8j5bnweLaON1Rie1rbZTMsvK03MF1fsg2bhSnNqYm0ibf/O+9Qx5MDHFR
         s2gi78cOUXHmnEaF8Saok5fhrxbHZbJj7uUQuuCh4ndiyAKRnC5/GRZuDe3o0jNoYDye
         p+JOAlfoCYPfuXgAWdTBmHK3vQeUtX3nyOIfyQY8Ca9nj6COklvDLpKqFnFtqIPbAFfq
         WR1sbNKTFQBA0flufeRvZti5SKFu2YFsrouozKxF2Ly+nTdel2esBkI07+3KoE78bTE9
         IGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5MCYmnwLXSItUOfFJQ3wA7TVBclPLgN1Gi/0GfWgwWU=;
        b=EtaLb0aTkKG/8WNY58M002ptziWBoCGYLofEZurrfKBfO+DpelOX6wYFSGqABsnRl3
         o+p7LHAmTIywyK0BwsrgR9eqBphu+fgGtnBoUv1GqaWKQKBQgc7aQ5qvMWhhRv3w3co1
         iudGpu6raD8MIlHcE+TZuyn//sj6V5GoHFvIpY0lqz/bDPYbozd/WMflvEGARGCtUI+Q
         zDFPhWb9t+2GBeXLcSe62oBUfMCAIoDBS003d+ahjItwuBIKE+HTbdl41/nnLpQcH3I8
         zcaU7NbYwzIwfahcQNdeiOUATPbRfACO8Y0O1jJingKTdKtqlUmit8usRTKUDecmnE0I
         Kbbg==
X-Gm-Message-State: AJcUukeXJIzukOA31ImZItrsTv44g3pf4AG9ec4Wd3vB1gXpeX++XVfP
        W+WlQNiYcKoTjQ3K4Iut3ZejWjbOUzq2p9A3VuiknJVOkVTpjQ==
X-Google-Smtp-Source: ALg8bN6Y+ZLKbh+6yS5Yz2cCj7DAj+wPreVOv3r92FomYNRAM7dp6bmYscgrsiXqe7XhZ3Q/fsRSfd1KtFQExzWufjE=
X-Received: by 2002:a63:bf0b:: with SMTP id v11mr7162300pgf.302.1547071642725;
 Wed, 09 Jan 2019 14:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20190109203119.GR6310@bombadil.infradead.org>
In-Reply-To: <20190109203119.GR6310@bombadil.infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Jan 2019 14:07:11 -0800
Message-ID: <CAKwvOdns4358_UgKgBPGzMfXoFLDijv13wFnv5UP=G_zjZbcwA@mail.gmail.com>
Subject: Re: [RFC] Use plan9 C extensions
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Collingbourne <pcc@google.com>, rsmith@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Peter, Richard

On Wed, Jan 9, 2019 at 12:31 PM Matthew Wilcox <willy@infradead.org> wrote:
>
>
> While replacing idr_alloc_cyclic(), I've come across a situation in
> which being able to depend on -fplan9-extensions is going to lead to
> nicer code in the users.

Thanks for reaching out and for the heads up!  For more context for
folks following along, here's GCC's documentation on
`-fplan9-extensions`.
https://gcc.gnu.org/onlinedocs/gcc/Unnamed-Fields.html
(See bottom half of the page).

Additionally, here's an SO post where the code owner for Clang
(Richard, separate from LLVM) talks about some of the
`-fplan9-extensions`.
https://stackoverflow.com/questions/7060949/equivalent-to-fplan9-extensions-in-clang

Further, here's a patch that started implementing this in Clang to
support compiling Go with Clang back when Go was not implemented in Go
(self hosting):
https://reviews.llvm.org/D3853

I would say in general, additions of `-f` flags to a codebase should
be carefully reviewed.  The first thing that comes to mind for most
compiler vendors when developers ask about using them is "what are you
doing?"  Some are useful, but there are many that are dangerous and/or
problematic.

>
> For cyclic allocations, we need to keep a 'next' value somewhere.
> The IDR had a moderately large root, so they didn't mind the cost to
> all users of embedding the next value in the root.

This sounds like some kind of "intrusive data structure?"  Doesn't the
kernel have macro's for generic intrusive containers?  Would you be
adding similar macros for xarray (or is that irrelevant to your
question)?

> For the XArray,
> I care about increasing it from the current 16 bytes on 64-bit or
> 12 bytes on 32-bit.  If most users used it, I wouldn't care, but
> only about 10% of the IDR users use the cyclic functionality.
>
> What I currently have is this (random example):
>
> -       struct idr      s2s_cp_stateids;
> -       spinlock_t      s2s_cp_lock;
> +       struct xarray   s2s_cp_stateids;
> +       u32             s2s_cp_stateid_next;
>
> ...
>
> +       if (xa_alloc_cyclic(&nn->s2s_cp_stateids,
> +                               &copy->cp_stateid.si_opaque.so_id, copy,
> +                               xa_u32_limit, &nn->s2s_cp_stateid_next,
> +                               GFP_KERNEL))
>                 return 0;
>
> What I'd really like to do is have a special data structure for the
> cyclic users that embeds that "next" field, but I can pass to all the
> regular xa_foo() functions.  Something like this:
>
> struct cyclic_xarray {
>         struct xarray;
>         u32 next;
> };
>
> Then this user would do:
>
>         struct cyclic_xarray s2s_cp_stateids;
>
>         if (xa_alloc_cyclic(&nn->s2s_cp_stateids,
>                                 &copy->cp_stateid.si_opaque.so_id, copy,
>                                 xa_u32_limit, GFP_KERNEL))

Sorry, this doesn't look quite syntactically valid, so I'm having a
hard time following along.  Would you be able to show me a simple
reproducer in godbolt (https://godbolt.org/) with GCC what you're
trying to do (maybe with comments showing before/after)?  (Godbolt is
a godsend for developers to clearly communicate codegen issues with
compiler vendors, and its short links can easily be embedded in bug
reports and commit messages).

>
> (ie one fewer argument, as well as one fewer thing to track in their struct).

The difference in the second case from the first looks like the "one
fewer argument" is the address of another member of `nn`.  In general
cases of trying to minimize the number of parameters passed, rather
than pass 2 pointers to 2 members, I would curious if you could just
pass 1 pointer to parent struct (ie. `nn`) to `xa_foo()` and friends
and pull out the members there?

>
> That's what -fplan9-extensions would allow us to do.  Without it,
> we'd need to name that struct xarray and need extra syntactic sugar;
> eg later when it calls xa_erase(), it'd look like this:
>
>         xa_erase(&nn->s2s_cp_stateids, copy->cp_stateid.si_opaque.so_id);
>
> instead of:
>
>         xa_erase(&nn->s2s_cp_stateids.xa, copy->cp_stateid.si_opaque.so_id);

Also hard to spot the intended difference as there's no `xa` member in
any of your examples (I assume you meant `xarray`, but a godbolt link
would be appreciated to make sure I'm understanding the problem
correctly).

>
> -fplan9-extensions is supported in gcc since 4.6 which is now our minimum
> version.  This might annoy the people who want to get the kernel compiling
> with LLVM though (and any other compilers?  is icc still a thing?).  Added
> those people to the cc.

Thanks for including us (LLVM folks)!  It would be good that new
additions be made optional if possible if unsupported in Clang; but
that's not doable in this case.  From the documentation, it seems that
`-fplan9-extensions` enables a couple of things, and I think with a
clearer example of what you're trying to do, I would be better
equipped to comment on which part of the compiler flag you'd like to
make use of.

-- 
Thanks,
~Nick Desaulniers
