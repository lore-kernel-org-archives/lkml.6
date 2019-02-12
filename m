Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9F1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074822083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D253Chez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfBLUGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:06:05 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42989 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfBLUGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:06:05 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so2995762lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/n+2vOYomTB5BLs+7tL7KTaBHH30/oos+ud6/cnVnSI=;
        b=D253Chez2iaEQIcdy2TZNsUlaqMRm9VIwWrpW4fWK//FTDXCKKfklGuD0o642xmL34
         Mp7YirjzpQRotbrv0djWXVT+vJS5/MLsACCfzpkJ9An4MiWd9dVmmIgjhdo9yVZ3/bHH
         9o6+1iNpzzKTb5pLfsCFl4j2YHGc18WAFp/jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/n+2vOYomTB5BLs+7tL7KTaBHH30/oos+ud6/cnVnSI=;
        b=N9E7ZQXsC6ZNk7s96xi/lmd8i0YRrQCj9wNcLiKqtJxqNgTObJdEQYce3QBotG7gxE
         zwaLxs2fgh0CTEuui0reaclHjgXAV9CuYrmHRmh3kmlmpHwLyYvo4+lYPOm0uSg7hhCs
         FDQSIjTfOTuHvp5gazjeIoiFBr0ehaJ5rrYO0MEvTn2SQQwJLaH9SZCLl9kvwhdCKHJK
         bsWPaS4/CfFwe1m+Mzu0X5EWlduaJGsI3i/p8gjkfUKeSZryEyXCZsqb30o4nxwxzqQk
         8GbZRynBhVn2AOrHRVHc0RRbKZ9HGuQvs4GhZzydBsIgu5LLu1mxCYIOGlzMH3M6qbRU
         u94A==
X-Gm-Message-State: AHQUAuYtgzsqXKTE2xhe9YyVg+mMJPvC1guZcS9cQemqwHOKX0VIZkzC
        J+sqHF0OlatCmPzP59ztQo97qwgrBzk=
X-Google-Smtp-Source: AHgI3Ia0hnrQxhe+lVD/+jjesEkW6v+jk25Q6ZpjLsWndGHKUsmfWeQsz01jExueIgvdyFIpeXp99A==
X-Received: by 2002:ac2:5624:: with SMTP id b4mr435281lff.41.1550001962410;
        Tue, 12 Feb 2019 12:06:02 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v11-v6sm2790594ljc.57.2019.02.12.12.06.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 12:06:02 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id j13-v6so3368447ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:06:02 -0800 (PST)
X-Received: by 2002:a2e:7316:: with SMTP id o22-v6mr1693665ljc.82.1550001499483;
 Tue, 12 Feb 2019 11:58:19 -0800 (PST)
MIME-Version: 1.0
References: <1549913486-16799-1-git-send-email-longman@redhat.com> <1549913486-16799-3-git-send-email-longman@redhat.com>
In-Reply-To: <1549913486-16799-3-git-send-email-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Feb 2019 11:58:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjTmSg6zX=xKFSPZor7FWi3s4D0dy-hz_M=yeF_6478QA@mail.gmail.com>
Message-ID: <CAHk-=wjTmSg6zX=xKFSPZor7FWi3s4D0dy-hz_M=yeF_6478QA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] locking/rwsem: Optimize down_read_trylock()
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:31 AM Waiman Long <longman@redhat.com> wrote:
>
> Modify __down_read_trylock() to make it generate slightly better code
> (smaller and maybe a tiny bit faster).

This looks good, but I would ask you to try one slightly different approach.

Instead of this:

>        long tmp = atomic_long_read(&sem->count);
>
>        while (tmp >= 0) {
>                if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
>                                        tmp + RWSEM_ACTIVE_READ_BIAS)) {
>                        return 1;
>                }
>        }

try doing this instead:

        long tmp = 0;

        do {
                if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
                                        tmp + RWSEM_ACTIVE_READ_BIAS)) {
                        return 1;
        } while (tmp >= 0);
        return 0;

because especially when it comes to locking, it's usually better to
just *guess* that the lock is unlocked, than it is to actually read
from the line to see what the state is.

Often - but certainly not always - the lock is the first access to the
target cacheline, and assuming the trylock is successful (which I
think is the case we want to optimize for), we're much better off
causing that first access to be a read-for-ownership, rather than a
read-for-sharing.

Because if you first read from the line, and then do a cmpxchg, and if
the line was not in the cache, your cache coherency protocol will
generally go through two states: first shared (for the initial read)
and then exclusive-dirty (for the cmpxchg).

Now, this is obviously very micro-architecture dependent, and in fact
the microarchitecture could even see the "predict fallthrough to a
cmpxchg with the same address" and turn the first read into a
read-for-ownership, but we've done this at some point before, and the
"guess unlocked" was actually the one that performed better.

Of course, the downside is that it might be worse when the guess is
incorrect - either because of a nested read lock or due to an actual
conflict with a write, but on the whole those *should* be the rare
cases, and not the cases where we necessarily optimize for latency of
the operation.

Hmm?

                    Linus
