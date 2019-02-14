Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDEB21900
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+z3NP45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438013AbfBNVZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:25:51 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46291 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388263AbfBNVZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:25:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id y20so8556755qtm.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uvdk4l69SVq1YCepBd0SNErCFPeMSilcO259odTUTos=;
        b=l+z3NP45VQ7XjqmgiGSFeyDx69gQDt8EGKaKIWsQEH7XQdV3EtFSlPAyH8ieWnAtN4
         hTalZqklXKd0pkRVVIOEbyy2xBsqOFUPT5tASXhKSIBj36KpP3dY0vGEjKJcG3pqrxpE
         vjJLZUT6gYRtssNYOrih/32Mx+hAECs2nNXgG5wJhvFApQHKiaMC21MbI64RiNq5Va8m
         Q8V80F+9nUsTmY7u2D4Er/ESohNGhAtQ+vy2BSb/x28lbkpjS2Cl0ow7w5BG5HXwBqF8
         wjU5YFJ36CvR0NwZGucMYkGOmAm1Yq3HUF+gsEgFQfP3Jx/t7BM0b+1qkY+ScSyVALij
         v32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uvdk4l69SVq1YCepBd0SNErCFPeMSilcO259odTUTos=;
        b=Hw8Z39sXkvnFHCG4K56CruuhaoUM25thE9O3hynL49HhSaPN6IzdxKiRCj1oDSLQBR
         Lm0aRtnkU+uG3a/zBg8TbzIDzV+Q/cYJkvj/OU1xTt1WkOPpHcZXCM6SHuFCKUVW+FTt
         kDxbIr7zDm396MUm7wVn/THSzkdg2h2yqgU9x7/k/RV5XZyUndxkIIFJhPsy2mkM+MWc
         akv0ZkkSw8E+WKSlCuv2V4nu0IbMq6pyNtc24h3Tdpie2oS+NJKPtJJRnvCpzTGDvFDU
         EkvTZoPZanE7VdObwC2Dg3nDPcHBXle+qP67waK+JFgFVS0lz5Dnl+gRk7w/LN1z85CW
         U+HQ==
X-Gm-Message-State: AHQUAuZOlhZ5IclMYBj6sogDEp7GiS7REQnLrJ3/wXcrAzZ2BrR/KkEJ
        +XGexxWGl2CLlEsm/Xf/8eMiVA==
X-Google-Smtp-Source: AHgI3Ia+iJnekvlkjNnCl1bw/RcAzTNdWayOpTyWdfUsJLRuOu+vzVZLin+EplRFNc/LJudNKlGUKQ==
X-Received: by 2002:ac8:1ae9:: with SMTP id h38mr4899963qtk.229.1550179550058;
        Thu, 14 Feb 2019 13:25:50 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id s48sm2145501qts.47.2019.02.14.13.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 13:25:49 -0800 (PST)
Date:   Thu, 14 Feb 2019 16:25:49 -0500
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
Message-ID: <20190214212549.GB185075@google.com>
References: <20190208183520.30886-1-tkjos@google.com>
 <20190208183520.30886-2-tkjos@google.com>
 <20190214194540.GA185075@google.com>
 <CAHRSSEw22kuwLqjXHocBQTv4d5hS1tXi4uirjBhgQ=yGbw9J4g@mail.gmail.com>
 <CAJWu+oqq0s3x7j+gPzSRREj2gjZxzAPS_=XVM4uhC9GjSM9zfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqq0s3x7j+gPzSRREj2gjZxzAPS_=XVM4uhC9GjSM9zfw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 03:53:54PM -0500, Joel Fernandes wrote:
> On Thu, Feb 14, 2019 at 3:42 PM Todd Kjos <tkjos@google.com> wrote:
> >
> > On Thu, Feb 14, 2019 at 11:45 AM Joel Fernandes <joelaf@google.com> wrote:
> [snip]
> > > > + * check_buffer() - verify that buffer/offset is safe to access
> > > > + * @alloc: binder_alloc for this proc
> > > > + * @buffer: binder buffer to be accessed
> > > > + * @offset: offset into @buffer data
> > > > + * @bytes: bytes to access from offset
> > > > + *
> > > > + * Check that the @offset/@bytes are within the size of the given
> > > > + * @buffer and that the buffer is currently active and not freeable.
> > > > + * Offsets must also be multiples of sizeof(u32). The kernel is
> > >
> > > In all callers of binder_alloc_copy_user_to_buffer, the alignment of offsets
> > > is set to sizeof(void *). Then shouldn't this function check for sizeof(void *)
> > > alignment instead of u32?
> >
> > But there are other callers of check_buffer() later in the series that
> > don't require pointer-size alignment. u32 alignment is consistent with
> > the alignment requirements of the binder driver before this change.
> > The copy functions don't actually need to insist on alignment, but
> > these binder buffer objects have always used u32 alignment which has
> > been checked in the driver. If user code misaligned it, then errors
> > are returned. The alignment checks are really to be consistent with
> > previous binder driver behavior.
> 
> Got it, thanks.

One more thing I wanted to ask is, kmap() will now cause global lock
contention because of using spin_lock due to kmap_high().

Previously the binder driver was made to not use global lock (as you had
done). Now these paths will start global locking on 32-bit architectures.
Would that degrade performance?

Are we not using kmap_atomic() in this patch because of any concern that the
kmap fixmap space is limited and may run out?

thanks,

 - Joel


