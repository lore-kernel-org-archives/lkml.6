Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB57C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14CB223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUGbCZil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14CB223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeKLTch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:32:37 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40987 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeKLTcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:32:36 -0500
Received: by mail-io1-f67.google.com with SMTP id r6-v6so2976634ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+FJEbbbgzXsx0prDG1KnMJk+leq5MmCaB9pPB7rmsM=;
        b=HUGbCZilD2pqGaCXcIR4zf+V/ZR/65Tx7zRjlvR22XzGxQ9SBZ+p2bozao2/IUcYZE
         qWr613kUfBWtEw53t3uss2n4IsOlgX3r5oROe5jn/nZE1kWQoXVeI84+9T8JGb99xh1T
         Z+5zJWS6LKDo1CG656POVSW6bNHGF9hgz3esQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+FJEbbbgzXsx0prDG1KnMJk+leq5MmCaB9pPB7rmsM=;
        b=uD64MjhU8dr541Ic8DwfZVDasTEvuAxOw7LxChaWLwj5rGoVJNQH0I50VSp98/5Ie3
         KYm5zhQwhRbklcKfo1rvE/aMC0Cz/4nJ2NWaevBxm79NDA7Cn4bgHMr/renqj2v1CkNz
         F7qDyLuY/S+QvOf0Db3rxgrjuO4IwjIfbyxN/Ot7175KF16FFIf0S168bxaPPVF+s9yg
         H4GSudtxIOdh7TpxUCW/gkT0miFaHs6efafLRjDHcPQAo09N9oVwMZgafJ5LrcRIRYMd
         BPHW3gKSDP5mJf2Z0h9PZEHC2xhNRQsBOfQjgZZDigb+DY3OvEYVcfEwJfevSTdep42C
         driQ==
X-Gm-Message-State: AGRZ1gKpxLGMzGZGPlC77tJ3O7z9tkFZiFeNGm2DK3FWD2+pO26Stgci
        lbWPlQPeZzg38z/CJAJT59l9zVd92XA4igPem4LbYA==
X-Google-Smtp-Source: AJdET5cGwTM/awqi1mqt8oDCQCPi5t8AeL5r0JwJKfbhIPLl2MdrVRCvXriwqSyrwecwXOV6IJu/xo+i2xcaMRytH9k=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr146724iob.170.1542015612539;
 Mon, 12 Nov 2018 01:40:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541711457.git.jpoimboe@redhat.com> <20181109072811.GB86700@gmail.com>
 <20181109144501.aqhcv3vdjuqlp7pz@treble> <20181112050241.GB28219@gmail.com> <20181112053055.hdcv5x7md47ehunv@treble>
In-Reply-To: <20181112053055.hdcv5x7md47ehunv@treble>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 12 Nov 2018 10:39:52 +0100
Message-ID: <CAKv+Gu8etgVmqPq+fNRBkb55ePrtY=5kxFu5+O4Wsqk=CWzG8w@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Static calls
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 at 06:31, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Nov 12, 2018 at 06:02:41AM +0100, Ingo Molnar wrote:
> >
> > * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > > On Fri, Nov 09, 2018 at 08:28:11AM +0100, Ingo Molnar wrote:
> > > > > - I'm not sure about the objtool approach.  Objtool is (currently)
> > > > >   x86-64 only, which means we have to use the "unoptimized" version
> > > > >   everywhere else.  I may experiment with a GCC plugin instead.
> > > >
> > > > I'd prefer the objtool approach. It's a pretty reliable first-principles
> > > > approach while GCC plugin would have to be replicated for Clang and any
> > > > other compilers, etc.
> > >
> > > The benefit of a plugin is that we'd only need two of them: GCC and
> > > Clang.  And presumably, they'd share a lot of code.
> > >

Having looked into this, I don't think they will share any code at
all, to be honest. Perhaps some macros and string templates, that's
all.

> > > The prospect of porting objtool to all architectures is going to be much
> > > more of a daunting task (though we are at least already considering it
> > > for some arches).
> >
> > Which architectures would benefit from ORC support the most?
>
> According to my (limited and potentially flawed) knowledge, I think
> arm64 would benefit the most performance-wise, whereas powerpc and s390
> gains would be quite a bit less.
>

What would arm64 gain from ORC and/or objtool?

> We may have to port objtool to arm64 anyway, for live patching.

Is this about the reliable stack traces, i.e., the ability to detect
non-leaf functions that don't create stack frames? I think we should
be able to manage this without objtool on arm64 tbh.

>  But
> that will be a lot more work than it took for Ard to write a GCC plugin.
>
> > I really think that hard reliance on GCC plugins is foolish
>
> Funny, I feel the same way about hard reliance on objtool :-)
>

I tend to agree here. I think objtool is a necessary evil (as are
compiler plugins, for that matter) which I hope does not spread to
other architectures.

But the main difference is that the GCC plugin is only ~50 lines (for
this particular use case, and minus another 50 lines of boilerplate),
whereas objtool (AIUI) duplicates lots and lots of functionality of
the compiler, assembler and/or linker, to mangle relocations, create
new sections etc etc. Porting this to other architectures is going to
be a major maintenance effort, especially when I think of, e.g.,
32-bit ARM with its Thumb2 quirks and other idiosyncrasies that are
currently hidden in the toolchain. Other architectures should be first
class citizens if objtool gains support for them, which means that the
x86 people that own it currently are on the hook for testing their
changes against architectures they are not familiar with.

This obviously applies equally to compiler plugins, but those have a
lot more focus.


> > - but maybe Clang's plugin infrastructure is a guarantee that it
> > remains a sane and usable interface.
>
> Hopefully so.  If it breaks, we could always write another tool, as the
> work is straightforward.  Or we could make it an objtool subcommand
> which works on all arches.
>
> > > > All other usecases are bonus, but it would certainly be interesting to
> > > > investigate the impact of using these APIs for tracing: that too is a
> > > > feature enabled everywhere but utilized only by a small fraction of Linux
> > > > users - so literally every single cycle or instruction saved or hot-path
> > > > shortened is a major win.
> > >
> > > With retpolines, and with tracepoints enabled, it's definitely a major
> > > win.  Steve measured an 8.9% general slowdown on hackbench caused by
> > > retpolines.
> >
> > How much of that slowdown is reversed?
>
> In theory, it should reverse all of the slowdown, and actually may even
> speed it up a little.  Steve is working on measuring that now.
>
> --
> Josh
