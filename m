Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F12EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFF121B1C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I40GBqS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395194AbfBNWHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:07:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46133 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391475AbfBNWHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:07:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id i5so4548818qkd.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 14:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1XjmhD4JJ711uyiYzlTQVA7ishF/zTrKsad1nu+Riag=;
        b=I40GBqS6cfHVcJdcd+V5IlPWnqAGbyvorOnLeHnTbTXT1s0IaB21I7YnR2hKxdC1bE
         EXXUeU4XhNev33OdiDLxcRKwMTHKAhYGZOrhB3KFtUF6soINB8pre9v4RyEjgd0cc4Qr
         i0kxLQwrLdcbWTLz+Gs5Sa4TZBlmCdcNaYEKUmwpiz7ufgj0LmFxGrBFdgKMo53dQDu5
         FLC0gQ2lCJjuXuPPxVGg0gBAeErTN9oVFDDMGCJv8NcgccURHJ3cGn0R9cw/BCICU+wJ
         yDzUDrvJ4x/laZC4zRpAe8T1Lw50nnbkQyrMrRSZNcgVL1iAVtO9I1Ua+/GzeT/0XlCk
         fh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1XjmhD4JJ711uyiYzlTQVA7ishF/zTrKsad1nu+Riag=;
        b=qDPqBqMa6dC30m83rKx9TTBvBqTfvMpnnnQkfL/dW2wKVxVkwHjPtEIao7G/ZOOnb6
         M98gJPCsmjay91TnP5A/9pMh5F5cboir9XMLiidN2bjTMyF8jtLccDjSZVIQK0lhl3oL
         O37/U6ocjpHIN5TJAE+artN6sLCkYG4W3iR2dZM3YFqrbMWm/VHvMCxBisZc0gS1sf9y
         dIfPfF2HK+wwdLt+SYV473XOu87IcV3LgNOBz7kRFOuQZ9tM7TTE0+/LmvMpPYfACZxs
         qraxP2lGHuRTNdITp6cwiKL2ebdJGUAF2PTt7CUrNDGPBMj8T01PaanXutrMcry7k3DQ
         AQvA==
X-Gm-Message-State: AHQUAuZnw2yghugdQI5irBLQ0WidkK5jSWVqAzOVFYw+zSq9f2seWy0N
        cXgJYIYVQysXtpB18s4c/3QC5w==
X-Google-Smtp-Source: AHgI3IbWp1LYlHamb3ioyh4/rDxy8+xaiiiw0PUp73uSUi0K2zKkP84fMeL3ERV9k1/2GorxIuOQRA==
X-Received: by 2002:a37:5ac4:: with SMTP id o187mr4554911qkb.282.1550182068122;
        Thu, 14 Feb 2019 14:07:48 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id w1sm1314918qtc.75.2019.02.14.14.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 14:07:47 -0800 (PST)
Date:   Thu, 14 Feb 2019 17:07:47 -0500
From:   Joel Fernandes <joelaf@google.com>
To:     Todd Kjos <tkjos@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v3 1/7] binder: create userspace-to-binder-buffer copy
 function
Message-ID: <20190214220747.GC185075@google.com>
References: <20190208183520.30886-1-tkjos@google.com>
 <20190208183520.30886-2-tkjos@google.com>
 <20190214194540.GA185075@google.com>
 <CAHRSSEw22kuwLqjXHocBQTv4d5hS1tXi4uirjBhgQ=yGbw9J4g@mail.gmail.com>
 <CAJWu+oqq0s3x7j+gPzSRREj2gjZxzAPS_=XVM4uhC9GjSM9zfw@mail.gmail.com>
 <20190214212549.GB185075@google.com>
 <CAHRSSExEc0uF38wwgtF6JeVgcLiDKiPznK+SmX8fFEL8k-gpVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHRSSExEc0uF38wwgtF6JeVgcLiDKiPznK+SmX8fFEL8k-gpVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 01:55:19PM -0800, 'Todd Kjos' via kernel-team wrote:
> On Thu, Feb 14, 2019 at 1:25 PM Joel Fernandes <joelaf@google.com> wrote:
> >
> > On Thu, Feb 14, 2019 at 03:53:54PM -0500, Joel Fernandes wrote:
> > > On Thu, Feb 14, 2019 at 3:42 PM Todd Kjos <tkjos@google.com> wrote:
> > > >
> > > > On Thu, Feb 14, 2019 at 11:45 AM Joel Fernandes <joelaf@google.com> wrote:
> > > [snip]
> > > > > > + * check_buffer() - verify that buffer/offset is safe to access
> > > > > > + * @alloc: binder_alloc for this proc
> > > > > > + * @buffer: binder buffer to be accessed
> > > > > > + * @offset: offset into @buffer data
> > > > > > + * @bytes: bytes to access from offset
> > > > > > + *
> > > > > > + * Check that the @offset/@bytes are within the size of the given
> > > > > > + * @buffer and that the buffer is currently active and not freeable.
> > > > > > + * Offsets must also be multiples of sizeof(u32). The kernel is
> > > > >
> > > > > In all callers of binder_alloc_copy_user_to_buffer, the alignment of offsets
> > > > > is set to sizeof(void *). Then shouldn't this function check for sizeof(void *)
> > > > > alignment instead of u32?
> > > >
> > > > But there are other callers of check_buffer() later in the series that
> > > > don't require pointer-size alignment. u32 alignment is consistent with
> > > > the alignment requirements of the binder driver before this change.
> > > > The copy functions don't actually need to insist on alignment, but
> > > > these binder buffer objects have always used u32 alignment which has
> > > > been checked in the driver. If user code misaligned it, then errors
> > > > are returned. The alignment checks are really to be consistent with
> > > > previous binder driver behavior.
> > >
> > > Got it, thanks.
> >
> > One more thing I wanted to ask is, kmap() will now cause global lock
> > contention because of using spin_lock due to kmap_high().
> >
> > Previously the binder driver was made to not use global lock (as you had
> > done). Now these paths will start global locking on 32-bit architectures.
> > Would that degrade performance?
> 
> There was a lot of concern about 32-bit performance both for
> lock-contention and the cost of map/unmap operations. Of course,
> 32-bit systems are also where the primary win is -- namely avoiding
> vmalloc space depletion. So there was a several months-long evaluation
> period on 32-bit devices by a silicon vendor who did a lot of testing
> across a broad set of benchmarks / workloads to verify the performance
> costs are acceptable. We also ran tests to try to exhaust the kmap
> space with multiple large buffers.
> 
> The testing did find that there is some performance degradation for
> large buffer transfers, but there are no cases where this
> significantly impacted a meaningful user workload.
> 
> >
> > Are we not using kmap_atomic() in this patch because of any concern that the
> > kmap fixmap space is limited and may run out?
> 
> We're not using the atomic version here since we can't guarantee that
> the loop will be atomic since we are calling copy_from_user(). Later
> in the series, other cases do use kmap_atomic().

Got it, thanks for all the clarifications,

- Joel

