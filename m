Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266C8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE3320672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTeZtCWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE3320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeLMIwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:52:49 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46234 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeLMIwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:52:49 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so946491ios.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 00:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XHGJSjEk7zmVCf478WOfKCGMYVWOK4idxf90rWA+6mw=;
        b=PTeZtCWV4okgM3V0fsmLlFhOce3tSJIG/qh8OZZfaKrkuBLI16cU/dt/dp1tW4xL4Q
         P2kwmI0LDTpRPNdbrNM9TxAmes8XCa7OIJxLHXwJXLb95iglnNh5PgFYlyUz9Iy1JOmF
         xiWhF5yxMr24Swq/WIXkr/Ek99s5RC4V2bXHQC5SKI6M6Oxh5SB4hRS1eCXLoiYNAg8j
         I7MGArdTy3aDVZskJ9cGgko6++2QjfAXss1EH9QrkfuHUEq/uvcENMeTYcRBD5CUYtZE
         Ke+vNmLgP65ZQ7brqnEnFg7kbIGS50YR7xrFjjI0ySi+5yuT5tazcz62wFWw5WEL38lz
         3ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHGJSjEk7zmVCf478WOfKCGMYVWOK4idxf90rWA+6mw=;
        b=qYFX+SibHcpoYH/026NdbIpkvJjVtcr63oDpPHhW4IxV4z9QZgEuoX9GkPapQygUbz
         suPB72Of8uCkb4D/QCwvVLJ5IHmVX+Go00GwJb4EqxS6WsFAyOBAMitDQ5tkjDIFbz1Q
         D0QXzBTQQu4AzmfEXg2kE+qqBoWF0hlfYZ0L02Vx+AJCwHn7Ykg5KxCwwNMGfA9BqTCZ
         YlsjdWxNfc0osL2y6wMP+VKh51HqWeQuXruasfiw9MxF0/FpgR55oesre3fQOm981xpO
         pvk3tyD7qYhE+HiyjTyGDuBNJhoWzhjLpx0t+n366RNXgdJo3Vka0t1ZS9wtxwOkPpmH
         e5vA==
X-Gm-Message-State: AA+aEWayXw40mqlbdvje+4HKA5Ivimio5k2oIf1TPBuELjP6tooTEKgp
        c+moxKhEQiKHBEKyvYa/Nrt/tQvf4K5yEEO+wsDJlQ==
X-Google-Smtp-Source: AFSGD/Wa2Wi0iXlLRNvewjIGPAe96xrn1QBXv3aseFlL+eLU9OCDfZEgoh4+dZ33dnDuldXie1NSILFDoAM+8HKAMXU=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr19384766iom.11.1544691168004;
 Thu, 13 Dec 2018 00:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20181212183447.15890-1-anders.roxell@linaro.org>
In-Reply-To: <20181212183447.15890-1-anders.roxell@linaro.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Dec 2018 09:52:36 +0100
Message-ID: <CACT4Y+YwuHK3VyYTCE=txWKRr_XWdJrUrw+ehBV=-caOQ9mjKg@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: mark file common so ftrace doesn't trace it
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

On Wed, Dec 12, 2018 at 7:36 PM Anders Roxell <anders.roxell@linaro.org> wrote:
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
> Rework so that the kasan implementation isn't traced.

Acked-by: Dmitry Vyukov <dvyukov@google.com>

Thanks!

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  mm/kasan/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index 0a14fcff70ed..e2bb06c1b45e 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -5,6 +5,7 @@ UBSAN_SANITIZE_generic.o := n
>  UBSAN_SANITIZE_tags.o := n
>  KCOV_INSTRUMENT := n
>
> +CFLAGS_REMOVE_common.o = -pg
>  CFLAGS_REMOVE_generic.o = -pg
>  # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
>  # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
> --
> 2.19.2
>
