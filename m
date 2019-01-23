Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF800C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954C121855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XoLHPkMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfAWWiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:38:01 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:44189 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfAWWiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:38:01 -0500
Received: by mail-ua1-f49.google.com with SMTP id d19so1307749uaq.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4B8lCha9ZTaw69yBTneXvxWuhyv5HaHtF9PM+NeshY=;
        b=XoLHPkMG0sjoqXANSoKCIxZjaGp5ZrPI3pNVduYbjj/qH0LRZRRtWb3fXkJjwaqcFO
         65sIYsoQBmWv+AIWJWMR5UMTb3vwnHFwgi8qhA7m+QiWeWxnBp4OzemSJv1t7pLKz3QJ
         efHx+GNbBhX1157wGglCRIFIg6YmQNmbp379ICdiqcwxrooQw083uu4rsYT1vpFaCNx+
         QqPJaM6EpnEdXsBchxF6cykk4rKRQIK9w+qSDEazsGVyp0DDV3QZWi4iuX2vn+n2T8cd
         JnspAPMM8encGI7z7lHMbx9okZema1B3oOgPebuLq8ppvmogV70mccNEB5p8hjvSuw1s
         lkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4B8lCha9ZTaw69yBTneXvxWuhyv5HaHtF9PM+NeshY=;
        b=nIM18KZ6/CD/YWIYlhVqErYlfvY8cRkUMoq3Xo2llD5QoHjXC43TaONYF3iiuEiEbp
         Wi1jllk4nfm2aV7m+JrtxRLRPJavZfBW2TCpWF67J9q182JXTFZL5us6ZgYv9EB2RQ0K
         KyHwBLMW3LdzQ+4nTXYMr5/LTjEWIn+XGJM+IUhP8AhoicoJjDR+dWn5TSbN8eUi8+Lj
         9YLikOTt7w88gYE1U/WeW1CoRCdfXLujJM4FzLokTINiy6bIqMGv7sR344ixvqWJcHnl
         VRk1FN0KI8gIBS42Bu4/IjQqe5K38OTLZV2aGVCEjx4msCjYcVfnQjkhMCGWOGSKw9En
         uVLw==
X-Gm-Message-State: AJcUukfqc72Br3yb0O5c3+coN1S8sUNR7pvH/R5SEeLmeu6aOx0PQPbc
        alsdNf9Uxp0DF9G4JakjfwODq/Vd2Aow1KvkEEz4Bg==
X-Google-Smtp-Source: ALg8bN43ZqaePHNCwQ+Lf7w8/rQGYZmv+kzmliGFwnBMT+rJ88XiWLtsDnvk64R4joIO9g4wTrsG+z6DJ//u9fUfSik=
X-Received: by 2002:ab0:63d7:: with SMTP id i23mr1704478uap.11.1548283079017;
 Wed, 23 Jan 2019 14:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119102800.GB17723@infradead.org> <20190119103606.GA17400@kroah.com>
 <8BD4CB7A-944C-4EC5-A198-1D85C9EE28D6@zytor.com> <20190120161003.GB23827@google.com>
 <A40C22DF-B43F-44BA-8148-FC0881087315@zytor.com> <20190121014553.GD23827@google.com>
 <BC774ED4-C0FC-4AA6-9BAF-36930A661D9B@zytor.com> <20190122133901.GA189736@google.com>
 <117d2f96-b0e9-2376-69b7-836fa0c52539@opersys.com>
In-Reply-To: <117d2f96-b0e9-2376-69b7-836fa0c52539@opersys.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 23 Jan 2019 14:37:47 -0800
Message-ID: <CAKOZuesWgo3CZj49aUChX_-dpijCrVLxgVZChyLLmOWXCLQf-Q@mail.gmail.com>
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the kernel
To:     Karim Yaghmour <karim.yaghmour@opersys.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atish patra <atishp04@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 1:29 PM Karim Yaghmour
<karim.yaghmour@opersys.com> wrote:
> > By the way, we can easily write a script to just extract the .ko directly -
> > if the whole "load it as a module" thing bothers you. The kheaders.ko can
> > just be thought of as a tarball. There's already a script to extract
> > /proc/config.gz in the same/similar way: scripts/extract-ikconfig
>
> If I may add a few more thoughts here ... in no specific order:
>
>  From that point of view, if something comes from or is rooted in
> mainline, instead of being mandated, it's usually easier to find it
> across the board. A perfect example of this is ftrace. The fact that
> it's in mainline has enabled google to: a) instrument their entire stack
> to log events to it (see
> http://www.opersys.com/downloads/cc-slides/android-debug/slides-main-181012.html#/82
> and
> http://www.opersys.com/downloads/cc-slides/android-debug/slides-main-181012.html#/83),
> and b) provide app-developer-facing tools (see
> https://developer.android.com/studio/command-line/systrace). Since this
> tracing functionality is now integrated into Android Studio (look for
> "System Trace" here:
> https://developer.android.com/studio/profile/cpu-profiler), it's very
> much "standard android" and additional proof, if any was needed, that
> tracing is useful to everyone.
>
> A few years back I was asked by a customer to put together some class
> material for internal Android debugging and performance analysis
> (commercial disclaimer applies, but slides/exercises are under
> "courseware":
> http://www.opersys.com/training/android-debug-and-performance). ftrace
> was very much in those early versions and it was great to show people
> that they could use it "out of the box". Recently I wanted to update
> this class material to cover eBPF and its applicability in Android. Holy
> cow. That turned out to be less obvious than necessary and somewhat
> peculiar to pull off. In this specific case, Joel tried a few things
> (see
> http://www.opersys.com/downloads/cc-slides/android-debug/slides-main-181012.html#/111)
> before eventually settling on loading a Debian chroot jail into a live
> Android (https://github.com/joelagnel/adeb) ... all of which require a
> proper set of kernel headers to properly function. Don't get me wrong,
> Joel's Androdeb makes this easy, but it's still outside the standard
> Android MO.
>
> In short, let's just say that, contrary to ftrace, I don't see the path
> for eBPF to being part of the standard toolset used by app developers
> any time soon. The recently-released bpftrace might help in that regard,
> but the kernel headers aren't too far in that regard either.

While I think there's definitely a place for eBPF as part of the
Android performance toolkit, I think most users will end up using it
through rich front-end performance collection and analysis tools (of
the sort I'm working on) rather than directly as a first-line window
into the operation of the system. Below this level is probably
something like bpftrace, and below that, raw eBPF and ftrace
manipulation. It's also worth noting that much of the time, system
analysis is retrospection, not inspection (e.g., investigating the
causes of rare and hard-to-reproduce bad behavior), and so iteration
via interactive specification of eBPF programs isn't a practical path
forward. It's still useful, even in this scenario, to be able (as part
of higher-level tools) attach "canned" eBPF programs to the kernel to
extract certain generally-useful bits of information, and in this
capacity, Joel's header module would be useful.

> Personally I advocated a more aggressive approach with Joel in private:
> just put the darn headers straight into the kernel image, it's the
> *only* artifact we're sure will follow the Android device whatever
> happens to it (like built-in ftrace).

I was thinking along similar lines. Ordinarily, we make loadable
kernel modules. What we kind of want here is a non-loadable kernel
module --- or a non-loadable section in the kernel image proper. I'm
not familiar with early-stage kernel loader operation: I know it's
possible to crease discardable sections in the kernel image, but can
we create sections that are never slurped into memory in the first
place? If not, maybe loading and immediately discarding the header
section is good enough.

> To that end, I even had some crazy
> ideas on how to compress the headers even further than with std
> compression algorithms -- here's a snippet from an email I sent Joel
> some time back detailing such a hack:
> > Since C headers have fairly constrained semantics and since the types of semantics generally used to name structs, etc. in the Linux kernel are well established, we can likely devise a very customized compression algorithm for the purpose.

Would such a thing really do better than LZMA? LZMA already has very
clever techniques for eliminating long-range redundancies in
compressible text, including redundancies at the sub-byte level. I can
certainly understand the benefit of stripping comments, since removing
comments really does decrease the total amount of information the
compressor has to preserve, but I'm not sure how much the encoding
scheme you propose below would help, since it reminds me of the
encoding scheme that LZMA would discover automatically.

> Whether such craziness makes sense or is adopted or not isn't mine to
> chart, but I certainly can't see eBPF reaching the same mass deployment
> ftrace has within the Android ecosystem until there's a way to use it
> without having to chase kernel headers independently of kernel images.
> There are "too many clicks" involved and someone somewhere will drop the
> ball if it's not glued to the kernel in some way shape or form. Any
> solution that solves this is one I'd love to hear about.

I agree. There definitely needs to be a "just collect a damn trace"
button that works on any device, and for this button to work and
incorporate eBPF, the system needs to be able to describe itself.
