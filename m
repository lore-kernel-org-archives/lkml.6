Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8DFC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A412D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OYFcyYbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A412D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbeLKKzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:55:32 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35624 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeLKKzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:55:31 -0500
Received: by mail-io1-f67.google.com with SMTP id i1so9423572ioo.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+oce3y3MlGvg/ig4q///rHNhAA6VEygCtwfBqOJrH80=;
        b=OYFcyYbujpbmJLMoorf8g2CGc3dRHhpaC4oHn7aX8C+pilj0+BUmD1PuOBBAcJutRU
         NlZxIVAjYLgNAGCZ28aD4VsUXDxT5NB0OzAMZY1RJUoKXWN4LTwUojH2yeqSpysB5iNL
         A42x7SB9zOM5MurTZecCvWFWksN43Ae6DSRD8cPq7p9XyoDRBiU0YKrpB9ETgqXOKVeQ
         cbOuhpyilH0yoa/VjlOgZvQPlJRuTlM4QoPtcCz1ksDdON6xeeGsa3f6SKzw/tarO6XZ
         0Ng9h66+0z54ZXXZQLT5o6Lc2ak7m45gnjsY8igPlrcjS8c8vqVruog4uC+JbP7eaGYH
         JmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oce3y3MlGvg/ig4q///rHNhAA6VEygCtwfBqOJrH80=;
        b=XoVYbSgc7x1pSMrHS1ttQMHgEbAcYFk62zh97cPdFmsOfxJaicHBuGEP0e14B3qW6M
         Cdpe9JQ1P8hgC6VTcnilcz9WN0vf10+wTNJXepiYQSFz5hrqr+mxSohRHdjHXth+hnBK
         iUaB+5WkNHN1T93OlCMhMl6sccJaOCEkM7+Wgc9C+MsyKYXthAyfmsk6w5C4LQxaVeYE
         xWiyDFVUglvUlf78s/VkiR5HXROL/Gm0sNuJ35aRnCcRwXOjkXaMF0b/RHb40rBd0RFk
         2BYvBP9hK77A9PscbFCH29nL4zwbCaiS8mzxA73AGFSZLwDZdYNenjOBRKbRzYSL/nIv
         iB/Q==
X-Gm-Message-State: AA+aEWZPiE1WuN+NoDUmODUTsXhgYVlMdA9ysLfsElXF/nxSPoR3rv9d
        m/Kge0guuV3+dfvyzH85qMQlltOrBLyH2oonmw31bg==
X-Google-Smtp-Source: AFSGD/VJFiK20b68epGrMvagn+leJifm3tacp6heSJXRe88DiHfYg/Uaou99w5gEQcF4RvuRM5U0d3jn75ernwtRDCU=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr12603247iom.11.1544525729885;
 Tue, 11 Dec 2018 02:55:29 -0800 (PST)
MIME-Version: 1.0
References: <20181211103733.22284-1-anders.roxell@linaro.org>
In-Reply-To: <20181211103733.22284-1-anders.roxell@linaro.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Dec 2018 11:55:18 +0100
Message-ID: <CACT4Y+Yz36BDR6WJ0WrPLHd+Z2WpJFhqm=Hv8_VoC7CJ8GEh=Q@mail.gmail.com>
Subject: Re: [PATCH] kasan: mark kasan_check_(read|write) as 'notrace'
To:     anders.roxell@linaro.org
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:37 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When option CONFIG_KASAN is enabled toghether with ftrace, function
> ftrace_graph_caller() gets in to a recursion, via functions
> kasan_check_read() and kasan_check_write().
>
>  Breakpoint 2, ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:179
>  179             mcount_get_pc             x0    //     function's pc
>  (gdb) bt
>  #0  ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:179
>  #1  0xffffff90101406c8 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:151
>  #2  0xffffff90106fd084 in kasan_check_write (p=0xffffffc06c170878, size=4) at ../mm/kasan/common.c:105
>  #3  0xffffff90104a2464 in atomic_add_return (v=<optimized out>, i=<optimized out>) at ./include/generated/atomic-instrumented.h:71
>  #4  atomic_inc_return (v=<optimized out>) at ./include/generated/atomic-fallback.h:284
>  #5  trace_graph_entry (trace=0xffffffc03f5ff380) at ../kernel/trace/trace_functions_graph.c:441
>  #6  0xffffff9010481774 in trace_graph_entry_watchdog (trace=<optimized out>) at ../kernel/trace/trace_selftest.c:741
>  #7  0xffffff90104a185c in function_graph_enter (ret=<optimized out>, func=<optimized out>, frame_pointer=18446743799894897728, retp=<optimized out>) at ../kernel/trace/trace_functions_graph.c:196
>  #8  0xffffff9010140628 in prepare_ftrace_return (self_addr=18446743592948977792, parent=0xffffffc03f5ff418, frame_pointer=18446743799894897728) at ../arch/arm64/kernel/ftrace.c:231
>  #9  0xffffff90101406f4 in ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:182
>  Backtrace stopped: previous frame identical to this frame (corrupt stack?)
>  (gdb)
>
> Rework so that kasan_check_read() and kasan_check_write() is marked with
> 'notrace'.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  mm/kasan/common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 03d5d1374ca7..71507d15712b 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -95,13 +95,13 @@ void kasan_disable_current(void)
>         current->kasan_depth--;
>  }
>
> -void kasan_check_read(const volatile void *p, unsigned int size)
> +void notrace kasan_check_read(const volatile void *p, unsigned int size)
>  {
>         check_memory_region((unsigned long)p, size, false, _RET_IP_);
>  }
>  EXPORT_SYMBOL(kasan_check_read);
>
> -void kasan_check_write(const volatile void *p, unsigned int size)
> +void notrace kasan_check_write(const volatile void *p, unsigned int size)
>  {
>         check_memory_region((unsigned long)p, size, true, _RET_IP_);
>  }

Hi Anders,

Thanks for fixing this!

I wonder if there is some compiler/make flag to turn this off for the
whole file?

We turn as much instrumentation as possible already for this file in Makefile:

KASAN_SANITIZE := n
UBSAN_SANITIZE_kasan.o := n
KCOV_INSTRUMENT := n
CFLAGS_REMOVE_kasan.o = -pg
CFLAGS_kasan.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)

These functions call check_memory_region, which is presumably inlined.
But if it's not inlined later in some configuration, or we just
shuffle code a bit, we can get the same problem again.
