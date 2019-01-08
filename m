Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07EBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80A82070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqgBTcWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfAHRol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:44:41 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33154 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfAHRok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:44:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so2246992plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpwsRQZv8cZDXezM+/IdJvZruPLZk55CpGsFMCsUilU=;
        b=SqgBTcWVm29Iw+KrjCqe7n2RW/81E879y88xZUt60txZAXWmVrF/f1mCCEeJ9xwg5W
         Bno4DmX8P/wUpX3IHjYqSH5OjQibQrNjKRTXDwvyMtzDE6WHlId7MNjkNx/rmgGsI4MG
         mNUP1V8jyZTKNn2hYKNbSh+V4jbt2r1F+F81kBKZxozyCH8xhg52+cmJE5BWAGtpT7J5
         PNxZKzmnz/hoE3QX3k9me/V5PDulXHUMnEjygJR+k2kppBq4SgG8KPtj2dQ5YZ/LaPz0
         JnUxuxGBIgF13zdK82QJ7VvmI8BZAHe0CWpKl3ZTVYU2P2vhB/tBzS0dknEjURkd5kkr
         8HAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpwsRQZv8cZDXezM+/IdJvZruPLZk55CpGsFMCsUilU=;
        b=ccbOGQEWgTWqnAwClnBarst+HY3/R0iQ/4g6WIQ9Fs/IZChGUmC3XY2vP1LTT7Jioo
         lztEiy/Gj19SUi3dFZGVZgwgwk0HEh/IPVVZ2BaRfjCqk9nTL2+tKCJMI6QQJeJhgsfL
         9ovErmA8kj7028clGpsdUgaPOGFC89oSMwexjbXQTKTNUretAu0mvEP/DpXCBohyE4UQ
         GsslO0poWhUDbrI6SPxrKBrgXbqbiSKuiMPWXqM/Yl1u31RSIgHmsa3xvTj0aF3ZdZ5i
         30lEetjn7SP4H0VGHsRXCJW5rGYBggwRY5CJUPdZFokicmwSjTVKPXegsdkEyFbVSqCC
         oA9Q==
X-Gm-Message-State: AJcUukeSyMqetjb+DQZqMfFG1HWBhXLtkKp4hqJbySPFyWl6LTkN2yRU
        FvFDtg1JaE6I9OdXvhjGBEJTL+0NhQEMCGZzV6Vp78e83YbVdQ==
X-Google-Smtp-Source: ALg8bN4+yjgv2TGbFKmAFCrQXJ+agtIXiOf2nUt66cJWYINDo10H7Geo695+YE/W5QbVzdhAFRrLFFG6wcqpWHZpkkc=
X-Received: by 2002:a17:902:7b88:: with SMTP id w8mr2663380pll.320.1546969479337;
 Tue, 08 Jan 2019 09:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20190102205715.14054-1-mst@redhat.com> <20190102205715.14054-2-mst@redhat.com>
In-Reply-To: <20190102205715.14054-2-mst@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Jan 2019 09:44:28 -0800
Message-ID: <CAKwvOdk3b6mnpTEEyY-JFrej8K12w9oTMLqi7q5aNiRMyJo6Ow@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Eli Friedman <efriedma@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org,
        Eric Christopher <echristo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch and sorry for the delay; was totally unplugged
for the holidays.

On Wed, Jan 2, 2019 at 12:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Since commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
> mutually exclusive") clang no longer reuses the OPTIMIZER_HIDE_VAR macro
> from compiler-gcc - instead it gets the version in
> include/linux/compiler.h.  Unfortunately that version doesn't actually
> prevent compiler from optimizing out the variable.

Good catch. Did you find this via eyeballing the code, a test, or some
other way?

>
> Fix up by moving the macro out from compiler-gcc.h to compiler.h.
> Compilers without incline asm support will keep working
> since it's protected by an ifdef.
>
> Also fix up comments to match reality since we are no longer overriding
> any macros.
>
> Build-tested with gcc and clang.
>
> Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> Cc: Eli Friedman <efriedma@codeaurora.org>
> Cc: Joe Perches <joe@perches.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Also for more context, see:
commit 7829fb09a2b4 ("lib: make memzero_explicit more robust against
dead store elimination")

> ---
>  include/linux/compiler-clang.h | 5 ++---
>  include/linux/compiler-gcc.h   | 4 ----
>  include/linux/compiler-intel.h | 4 +---
>  include/linux/compiler.h       | 4 +++-
>  4 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 3e7dafb3ea80..7ddaeb5182e3 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -3,9 +3,8 @@
>  #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
>  #endif
>
> -/* Some compiler specific definitions are overwritten here
> - * for Clang compiler
> - */
> +/* Compiler specific definitions for Clang compiler */
> +
>  #define uninitialized_var(x) x = *(&(x))
>
>  /* same as gcc, this was present in clang-2.6 so we can assume it works
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 2010493e1040..72054d9f0eaa 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -58,10 +58,6 @@
>         (typeof(ptr)) (__ptr + (off));                                  \
>  })
>
> -/* Make the optimizer believe the variable can be manipulated arbitrarily. */
> -#define OPTIMIZER_HIDE_VAR(var)                                                \
> -       __asm__ ("" : "=r" (var) : "0" (var))
> -
>  /*
>   * A trick to suppress uninitialized variable warning without generating any
>   * code
> diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
> index 517bd14e1222..b17f3cd18334 100644
> --- a/include/linux/compiler-intel.h
> +++ b/include/linux/compiler-intel.h
> @@ -5,9 +5,7 @@
>
>  #ifdef __ECC
>
> -/* Some compiler specific definitions are overwritten here
> - * for Intel ECC compiler
> - */
> +/* Compiler specific definitions for Intel ECC compiler */
>
>  #include <asm/intrinsics.h>
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 06396c1cf127..1ad367b4cd8d 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -152,7 +152,9 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  #endif
>
>  #ifndef OPTIMIZER_HIDE_VAR
> -#define OPTIMIZER_HIDE_VAR(var) barrier()
> +/* Make the optimizer believe the variable can be manipulated arbitrarily. */
> +#define OPTIMIZER_HIDE_VAR(var)                                                \
> +       __asm__ ("" : "=r" (var) : "0" (var))
>  #endif

This should be fine, thanks for the cleanup!  For now, we're not yet
confident to turn on Clang's integrated assembler for the kernel, but
I'll make sure to revisit this should we, in case Clang is then able
to optimize this out.
+ Eric, who might know of a better trick for what we're trying to
accomplish with this macro.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

+ Miguel
Miguel, would you mind taking this into your compiler-attributes tree?
-- 
Thanks,
~Nick Desaulniers
