Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58CF21B18
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MO6eQ5LK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392863AbfBNVzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:55:32 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42585 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387641AbfBNVzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:55:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id y140so4551654qkb.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfUBORap72Jt0I4QDdDnFCDsVaIdSdBAC4zZgLMxXAM=;
        b=MO6eQ5LK43KewPrWhYfrBHF6xt5C7OhUvyjBDQzHRxAjfp959MrCPRCP262EBWR9mM
         wbo7+RjFwsUQZnKmAEwEXv3rI89xJuTUikIEhgD1XU+xXYFKpP3Q+CQDK3YvS3W4v1M8
         DsQcajHxS7X4O4U214+vGbXlaUGaicIQhwhvtJl6s+Jfqnwku5mHo8R96Gn7gMkbd0lW
         UruxBUqDg/i9jKt31kPrEvHgniKUm9cM7T14vXFimgsZ9ptn/M8PBZL1q8Mt+CENSMA7
         SJYdkJ7Jkzc4hyHLpiqsvaUv5Gp8A5RhRjnafLEeJYF6OVWLSvanii+CoGimR4mfFhhc
         SglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfUBORap72Jt0I4QDdDnFCDsVaIdSdBAC4zZgLMxXAM=;
        b=rtZ4m/mAzizpgLlY48ExaUXk20YKdd6RamDtIH001bfw18HcAJxk8sBpDg4bVx6lpO
         BpYu0VjzrXJD8KL3+ulfdhrxlB5FthU+GKsVKQl3iy3ighOiPO4waewJUj1Q5UrGduhq
         ArpEl0La5JAt8/Du+Hctx+ibGy/r5L3ZLp7fbP3JGy9MGT45psl0l26A5VJfYQhxOvzy
         vSD3EjhOdDZrLCG6kBLkCpucK8e8w18jbqov4wMUImSa1gFs6DOpNumxuZn9hb4emR+j
         VKnUhjgk5uzK1IVaWMT5LckbAxjdkXkFs9AZa4Ssgwc1ecmI1A5au9wRXeyL7Om3kO0p
         mdQg==
X-Gm-Message-State: AHQUAub03Jqw3zbDfjQRmnaZhVb2/+tfv4sEjjTQPceo7yP838rwipUF
        Qgy4gLYEXI+QW/uCYp7disf3LkLZU6ISYTsq60DohA==
X-Google-Smtp-Source: AHgI3IYvEgusFeAWFhvLwISke0qcrqOqnDiibZyWx4c8fN9tMwPwXkYrGeOcIwesoJ6ORys8nAYDKOH/rv/pqKqhj9I=
X-Received: by 2002:a37:cf56:: with SMTP id e83mr4755350qkj.101.1550181331053;
 Thu, 14 Feb 2019 13:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20190208183520.30886-1-tkjos@google.com> <20190208183520.30886-2-tkjos@google.com>
 <20190214194540.GA185075@google.com> <CAHRSSEw22kuwLqjXHocBQTv4d5hS1tXi4uirjBhgQ=yGbw9J4g@mail.gmail.com>
 <CAJWu+oqq0s3x7j+gPzSRREj2gjZxzAPS_=XVM4uhC9GjSM9zfw@mail.gmail.com> <20190214212549.GB185075@google.com>
In-Reply-To: <20190214212549.GB185075@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 14 Feb 2019 13:55:19 -0800
Message-ID: <CAHRSSExEc0uF38wwgtF6JeVgcLiDKiPznK+SmX8fFEL8k-gpVA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] binder: create userspace-to-binder-buffer copy function
To:     Joel Fernandes <joelaf@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 1:25 PM Joel Fernandes <joelaf@google.com> wrote:
>
> On Thu, Feb 14, 2019 at 03:53:54PM -0500, Joel Fernandes wrote:
> > On Thu, Feb 14, 2019 at 3:42 PM Todd Kjos <tkjos@google.com> wrote:
> > >
> > > On Thu, Feb 14, 2019 at 11:45 AM Joel Fernandes <joelaf@google.com> wrote:
> > [snip]
> > > > > + * check_buffer() - verify that buffer/offset is safe to access
> > > > > + * @alloc: binder_alloc for this proc
> > > > > + * @buffer: binder buffer to be accessed
> > > > > + * @offset: offset into @buffer data
> > > > > + * @bytes: bytes to access from offset
> > > > > + *
> > > > > + * Check that the @offset/@bytes are within the size of the given
> > > > > + * @buffer and that the buffer is currently active and not freeable.
> > > > > + * Offsets must also be multiples of sizeof(u32). The kernel is
> > > >
> > > > In all callers of binder_alloc_copy_user_to_buffer, the alignment of offsets
> > > > is set to sizeof(void *). Then shouldn't this function check for sizeof(void *)
> > > > alignment instead of u32?
> > >
> > > But there are other callers of check_buffer() later in the series that
> > > don't require pointer-size alignment. u32 alignment is consistent with
> > > the alignment requirements of the binder driver before this change.
> > > The copy functions don't actually need to insist on alignment, but
> > > these binder buffer objects have always used u32 alignment which has
> > > been checked in the driver. If user code misaligned it, then errors
> > > are returned. The alignment checks are really to be consistent with
> > > previous binder driver behavior.
> >
> > Got it, thanks.
>
> One more thing I wanted to ask is, kmap() will now cause global lock
> contention because of using spin_lock due to kmap_high().
>
> Previously the binder driver was made to not use global lock (as you had
> done). Now these paths will start global locking on 32-bit architectures.
> Would that degrade performance?

There was a lot of concern about 32-bit performance both for
lock-contention and the cost of map/unmap operations. Of course,
32-bit systems are also where the primary win is -- namely avoiding
vmalloc space depletion. So there was a several months-long evaluation
period on 32-bit devices by a silicon vendor who did a lot of testing
across a broad set of benchmarks / workloads to verify the performance
costs are acceptable. We also ran tests to try to exhaust the kmap
space with multiple large buffers.

The testing did find that there is some performance degradation for
large buffer transfers, but there are no cases where this
significantly impacted a meaningful user workload.

>
> Are we not using kmap_atomic() in this patch because of any concern that the
> kmap fixmap space is limited and may run out?

We're not using the atomic version here since we can't guarantee that
the loop will be atomic since we are calling copy_from_user(). Later
in the series, other cases do use kmap_atomic().

>
> thanks,
>
>  - Joel
>
>
