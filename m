Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCFFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F06920936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="aZbRJxfk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A6rIabyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F06920936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbeGJS1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:27:06 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:42645 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732958AbeGJS1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:27:04 -0400
Received: by mail-yw0-f194.google.com with SMTP id y203-v6so8196558ywd.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=k/2WrfJlFXl+GUONhoZXlRF6G32vrxpccWnhEaOJRbA=;
        b=aZbRJxfkwB9Xei6FDEZbmuAXq8mhHIKtwJqzOqj7xY5OPH6iWDn0bpwYbVWkRMaxvq
         rdy7hi90VptOESZJbrKO4w7qdmZ7suH1nA+VCeDTF0hn5qJpfItXlFidn74uRIr7Dl3c
         JQyhEYodzwpp7jDfD+4PNChbxVrdenPMVADD3wBsYlqGFFcsHF3/jS+UfCwU/GG2x/2k
         xH/0qm8XcX8fcpMr9IEUgk7TCpEuh5M2NWkncadG+HRmLUDo2O+IHcMTYbn6P32uby5u
         LKnKql1JI+saeGDfmVHs7rDAmMB8lucwsKBxUA0qtEruxz0bVMYvP3q8Z06AJzHqeBQh
         ox8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=k/2WrfJlFXl+GUONhoZXlRF6G32vrxpccWnhEaOJRbA=;
        b=A6rIabySl4xc50ojT4C+gnr9BMk1+HZAumJ2LvO45YSlgKiluD7LAqY8qOOWxf+IM8
         kzhMy4pENv5Qz8maVAxX8XmiSfUeP4H9i7DZ6saZ7Pj/ycGmEuhKDcxF9n75wH7QIg4e
         ShAY8RMYc1oKdGQovs8NWtObyCSIuccJSNJb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=k/2WrfJlFXl+GUONhoZXlRF6G32vrxpccWnhEaOJRbA=;
        b=NMetbci0Q5fBn0oXFVnd+9nH6pOi9U3Ug7f25hxx6wsAtGGN2ARU97+A2YrdaHUew0
         jzIqiYp26AN3cg5rT81g3n7aAly9C/S/B2iIB2lza1wq1NC8Pn+WMTItuZlkv6E2sxrb
         Mtj1lxTNE74fdkTPsX4N5hm4zZ+V41gBFkiAOu3CnoyrdZRSDnX70lWDQdAut0rtRIyS
         tnzdadWixygblUK8yQitj1NSYIemHVBnR+V5WPMe6Qi2nk+x5pxYl0qIpVCDV9iKkJcz
         hVZ/JaF4bPt4AAI4aBNo8kroYurXElMHXq3EACtywCCB9kTkMkVxpbC5bqafpiiv7byX
         oouw==
X-Gm-Message-State: AOUpUlGFg9OxS1N8VN+xJ6e0bd7PlzKdbalKNY6a0fxkj9T6Fqjhq9zV
        jp6uy/7HFrWgrIa5u7lfFlFrPvgmrH4zav3XmUQrPg==
X-Google-Smtp-Source: AAOMgpfsdCENTWZvsbaIChq1+Oh78aBP+Y3egizHl68oFTSxssbEdcuFku5DPMU6xOrkHD2KJS6SbAh1c0bIRdd3GPE=
X-Received: by 2002:a0d:f002:: with SMTP id z2-v6mr1856668ywe.116.1531247213219;
 Tue, 10 Jul 2018 11:26:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 11:26:52
 -0700 (PDT)
In-Reply-To: <20180710042609.zie5fgrvoyusmeod@treble>
References: <1531186516-15764-1-git-send-email-yamada.masahiro@socionext.com>
 <20180710022904.e3oql2ts4qz43bzo@treble> <CAK7LNASM+81JkGu5-z8GRZ9+sRyd55gO0G0M5c54zRhE5JhE3g@mail.gmail.com>
 <20180710042609.zie5fgrvoyusmeod@treble>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 10 Jul 2018 11:26:52 -0700
X-Google-Sender-Auth: i6uOLtl_f6xZaR9-Yce_2hYfxEE
Message-ID: <CAGXu5jKiPFdP-wMeH5RpRuT9RAK9v-Ce=2=tmsZVYm0Bn3A-Lw@mail.gmail.com>
Subject: Re: [PATCH v2] objtool: move libelf detection to Kconfig from Makefile
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 9:26 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> I wasn't a part of the -fstack-protector conversation, but I doubt it's
> the same pattern.  We're trying to phase out frame pointers, for several
> reasons.  One big reason is that they cause a general slowdown across
> the entire kernel.

My primary concern with stack-protector was that I wanted to avoid a
disconnect between what was visible in CONFIG_* and how the kernel
actually got built. i.e. a kernel config had
CONFIG_STACKPROTECTOR_STRONG, it was actually built with
-fstack-protector-strong. Having it silently downgrade to
-fstack-protector while keeping CONFIG_STACKPROTECTOR_STRONG would
lead to serious confusion.

The second issue was that I wanted the best stack protector a compiler
supported, and at the time it wasn't possible to do this from kconfig.

Masahiro fixed both of these now. :) (Thank you!)

> Since we switched the x86_64 default to the ORC unwinder, a lot of
> people have switched over.  But this patch will reverse (or at least
> slow down) that trend, because almost nobody has the libelf devel
> packaged installed by default.  So over time, it will effectively make
> frame pointers the default again in many cases.  That's exactly what we
> *don't* want to do.  It will also cause people to accidentally re-enable
> frame pointers when they thought they had ORC.

This is more like the gcc-plugins: kconfig will just not make the
plugin CONFIG_*s visible if the gcc plugin dev package is missing on
the build host. However, having or not having these isn't something
we're trying to phase in or out, so the ORC case is more like how
stack-protector was originally: fail the build if your CONFIG requires
some additional build host package.

What might be interesting is having "make *config" report certain
CONFIG_* failures with helpful text. "WARNING: missing libelf for
CONFIG_ORC..." or "Warning: missing gcc-plugin-dev for
CONFIG_GCC_PLUGINS" etc?

-Kees

-- 
Kees Cook
Pixel Security
