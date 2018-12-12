Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FD3C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C4720839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KiXjvh4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C4720839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeLLSgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:36:02 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33095 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbeLLSgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:36:01 -0500
Received: by mail-yw1-f68.google.com with SMTP id q11so7389779ywa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLFkzZ47/NSlvBRoi2hymf7yNACYMKV1jQLM//dnV+8=;
        b=KiXjvh4+R8WJNSxrnzLpaIVgFqVoaoV0N4E0b98yGfj2rr8CSMALR6a2RoUS3j6NQy
         29ndrmcb/QUb2uuy/LbXMxHvkf9CkG7m1xIgJwF0y7u9RrTieX2V53LoeiMuN4snQdqZ
         SqttWjASOOT63AJT6B7syOSSEwOuiHNkcoRSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLFkzZ47/NSlvBRoi2hymf7yNACYMKV1jQLM//dnV+8=;
        b=qz4PTC5kgr/a5dS8Kd7m68uEu7PwVyXYAJhkJjTgBbeJq+2Kht/Xzidaxpt5WM76VW
         DPYtR7IGVo7zhxdk5Vgis5nA7pKmjDrIDpWrJ+LCwWWWp0YEG5ZcU+aYp7rqUkI1b6sJ
         K3zHX540ociHXgbayCJy8VI3AqOb+vwVFOvhAPpv9LgSaJZpcqUibNz9TmJNZlulzux7
         QcilVkt+lLYdDWHL3VEOb8+OcMlPx4ToBFnHYgYYORTmrFPPxDlostzwjYx0pacfw0KH
         HraQQ2khzChtBnQffiI1UAisclwPm7qRtGGatUpzuDhk0zIho+8Q2x0606r0RFczFc1O
         h/nw==
X-Gm-Message-State: AA+aEWbY+VZRFkEY2MPwU7DgvNx+mYu/LLjH7V3vhJs95TmpUdnfI6To
        G+k6Lg8QfYoI6gYrwvcAO6QDJBpK2I/ifXRRHzRgpjxg23Q=
X-Google-Smtp-Source: AFSGD/VpSrY0gn6SiwLAkgvehhnUrssMbWiwMjVhAfJ7xf4DVHczDtzpQCu8hd0cKhr7EayEsfns5Lft91U9MFkyKzQ=
X-Received: by 2002:a81:e40b:: with SMTP id r11mr21546436ywl.56.1544639760220;
 Wed, 12 Dec 2018 10:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20181211103733.22284-1-anders.roxell@linaro.org> <CACT4Y+Yz36BDR6WJ0WrPLHd+Z2WpJFhqm=Hv8_VoC7CJ8GEh=Q@mail.gmail.com>
In-Reply-To: <CACT4Y+Yz36BDR6WJ0WrPLHd+Z2WpJFhqm=Hv8_VoC7CJ8GEh=Q@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 12 Dec 2018 19:35:48 +0100
Message-ID: <CADYN=9JOBgbZYpm4zVvNCj-LVfwCTCuwZTWOi8gXDUrOjbHf_A@mail.gmail.com>
Subject: Re: [PATCH] kasan: mark kasan_check_(read|write) as 'notrace'
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     aryabinin@virtuozzo.com, kasan-dev@googlegroups.com,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 at 11:55, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Dec 11, 2018 at 11:37 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > When option CONFIG_KASAN is enabled toghether with ftrace, function
> > ftrace_graph_caller() gets in to a recursion, via functions
> > kasan_check_read() and kasan_check_write().
> >
> >  Breakpoint 2, ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:179
> >  179             mcount_get_pc             x0    //     function's pc
> >  (gdb) bt
> >  #0  ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:179
> >  #1  0xffffff90101406c8 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:151
> >  #2  0xffffff90106fd084 in kasan_check_write (p=0xffffffc06c170878, size=4) at ../mm/kasan/common.c:105
> >  #3  0xffffff90104a2464 in atomic_add_return (v=<optimized out>, i=<optimized out>) at ./include/generated/atomic-instrumented.h:71
> >  #4  atomic_inc_return (v=<optimized out>) at ./include/generated/atomic-fallback.h:284
> >  #5  trace_graph_entry (trace=0xffffffc03f5ff380) at ../kernel/trace/trace_functions_graph.c:441
> >  #6  0xffffff9010481774 in trace_graph_entry_watchdog (trace=<optimized out>) at ../kernel/trace/trace_selftest.c:741
> >  #7  0xffffff90104a185c in function_graph_enter (ret=<optimized out>, func=<optimized out>, frame_pointer=18446743799894897728, retp=<optimized out>) at ../kernel/trace/trace_functions_graph.c:196
> >  #8  0xffffff9010140628 in prepare_ftrace_return (self_addr=18446743592948977792, parent=0xffffffc03f5ff418, frame_pointer=18446743799894897728) at ../arch/arm64/kernel/ftrace.c:231
> >  #9  0xffffff90101406f4 in ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:182
> >  Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> >  (gdb)
> >
> > Rework so that kasan_check_read() and kasan_check_write() is marked with
> > 'notrace'.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  mm/kasan/common.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 03d5d1374ca7..71507d15712b 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -95,13 +95,13 @@ void kasan_disable_current(void)
> >         current->kasan_depth--;
> >  }
> >
> > -void kasan_check_read(const volatile void *p, unsigned int size)
> > +void notrace kasan_check_read(const volatile void *p, unsigned int size)
> >  {
> >         check_memory_region((unsigned long)p, size, false, _RET_IP_);
> >  }
> >  EXPORT_SYMBOL(kasan_check_read);
> >
> > -void kasan_check_write(const volatile void *p, unsigned int size)
> > +void notrace kasan_check_write(const volatile void *p, unsigned int size)
> >  {
> >         check_memory_region((unsigned long)p, size, true, _RET_IP_);
> >  }
>
> Hi Anders,
>
> Thanks for fixing this!
>
> I wonder if there is some compiler/make flag to turn this off for the
> whole file?
>
> We turn as much instrumentation as possible already for this file in Makefile:
>
> KASAN_SANITIZE := n
> UBSAN_SANITIZE_kasan.o := n
> KCOV_INSTRUMENT := n
> CFLAGS_REMOVE_kasan.o = -pg
> CFLAGS_kasan.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
>
> These functions call check_memory_region, which is presumably inlined.
> But if it's not inlined later in some configuration, or we just
> shuffle code a bit, we can get the same problem again.

Thank you for the review.

I'll send out a v2 shortly where I turned off the hole file.

Cheers,
Anders
