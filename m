Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1D5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE2E21B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R0dfrliM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbfBKTMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:12:36 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45927 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbfBKTMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:12:35 -0500
Received: by mail-vk1-f193.google.com with SMTP id n126so2712936vke.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7ERLDaFHd17nh4q2HCbhRYhGQWopVg3UWTU0kS4Tdc=;
        b=R0dfrliMesEnVr3K8Fkbmns6lrFlkLIKUFytn/9Atywxh87rRD351RD7fFHhQ6wulM
         CuijnLbp/f1f9ciXU0A+fWLadS0UVLAuHNvmIA9fBcKfvHSnLxaNQtVy0wT4fRmFSz7t
         9vR/VBJKLF7AO5lyrAII+CrGYsiKJXpjFADDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7ERLDaFHd17nh4q2HCbhRYhGQWopVg3UWTU0kS4Tdc=;
        b=Ih5pq2DxL2cWqLKFiPXse5qEf//4+V2Ykt6taNVRM2TtxvZgdxQi9IYJWSIUXxhJYD
         gwNyVf9BEAMlIJSHDRXr8rZqeEPq3mw4gYZMpEtAs/Sw7EF8HyAI/p45fNwXl17P9TkV
         kJ0wg/292NtEK0sxSW3wqkkw6aW8YiKY+qZBhz1ZPKS0z8vxES4CLBQtuxrvD2QnCb5j
         lR1Ij0LkAvMaytXe6JyT+Ul7WE11JFiJ2QQOC5aOh7IO2kzk6cMNF1bmMTXrLJj8BhGp
         Ik2TsXKEK6NAme/qjnfkm6jVvapvO345CveNnexs1bTRuqgG4QJEMnHZmi437CjJAgId
         2RCA==
X-Gm-Message-State: AHQUAuY0myxRab+DSZRDKDDiEdIqNVwmY8hKLnY1zcaHIJWvtCpN8S7+
        HDKSbsWBn9cCaafwjnFdI6PlKUIDcuc=
X-Google-Smtp-Source: AHgI3IYZLPPVE7NqRFXys4lkIo5yBS6hdu1aNJLXzQlqMVpPmho1tYJcU8XfaIdn/utX+uPnSOMJGw==
X-Received: by 2002:a1f:3202:: with SMTP id y2mr15617775vky.3.1549912354189;
        Mon, 11 Feb 2019 11:12:34 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 7sm2407449vkw.51.2019.02.11.11.12.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:12:33 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id e7so22410vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:12:32 -0800 (PST)
X-Received: by 2002:a67:d007:: with SMTP id r7mr6647186vsi.110.1549912352364;
 Mon, 11 Feb 2019 11:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20190211175935.4602-1-will.deacon@arm.com>
In-Reply-To: <20190211175935.4602-1-will.deacon@arm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 11 Feb 2019 11:12:19 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJk7zpKzx0DrBRmJvAoPDEMUni5bgE-O1xR8_1-p6HAxQ@mail.gmail.com>
Message-ID: <CAGXu5jJk7zpKzx0DrBRmJvAoPDEMUni5bgE-O1xR8_1-p6HAxQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Allow tasks to have their user stack pointer
 sanity checked
To:     Will Deacon <will.deacon@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 9:59 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi all,
>
> I attended an interesting talk at LCA last month that described some of the
> security features deployed in OpenBSD [1]. One hardening feature that piqued
> my interest was, on syscall entry and page faults from userspace, checking
> that the user stack pointer for a task points at pages that were either
> allocated by the kernel for the initial process stack of mapped with mmap()
> using the MAP_STACK flag. This acts as a basic defense against stack
> pivoting attacks.

I think this is nice to have, yes! Thanks for working on it. It seems
like this blocks pivots to heap -- relocating to a groomed stack area
would still be allowed. Regardless, this does narrow the scope of such
attacks quite nicely.

> The problem with this checking is that it is a retrospective tightening
> of the ABI, but that hasn't stopped me hacking it together behind a couple
> of prctl() options.

MAP_STACK has been around for a long time, so I think anything using
threads via glibc should be "covered". I would assume this would mean
that glibc could set the prctl() for such users. I suspect there are a
lot of open-coded threading implementations, though. It'd be
interesting to see how many need modification.

Given that this is behind a prctl(), it seems the CONFIG isn't needed?

> Anyway, it was fun to implement so I figured I'd post it as an RFC.

Thanks! I'd love to see an x86 counterpart to the sycall check too.

Did you trying bringing up a full userspace and windowing environment
with this enabled by default (i.e. forcing init to set the prctls)?
I'd be curious to see how much (if anything) goes boom. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
> Will
>
> [1] https://2019.linux.conf.au/schedule/presentation/164/
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
>
> --->8
>
> Will Deacon (4):
>   mm: Check user stack pointer is mapped with MAP_STACK
>   mm: Expose user stack pointer checking via prctl()
>   mm: Add kconfig entries for user stack pointer checking
>   arm64: Check user stack pointer on syscall entry
>
>  arch/arm64/Kconfig          |  1 +
>  arch/arm64/kernel/syscall.c |  4 +++
>  include/linux/mm.h          | 15 +++++++++-
>  include/linux/mman.h        |  3 +-
>  include/linux/sched.h       |  4 +++
>  include/uapi/linux/prctl.h  |  5 ++++
>  kernel/sys.c                |  5 ++++
>  mm/Kconfig                  | 17 ++++++++++++
>  mm/memory.c                 | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 119 insertions(+), 2 deletions(-)
>
> --
> 2.11.0
>


-- 
Kees Cook
