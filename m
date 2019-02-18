Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD39EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AA5217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSHv3Azy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbfBRPZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:25:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34038 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfBRPZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:25:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so1479021pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 07:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZM7ZiHVQG9OziFvs2AnUsvoK7AiW4q5xi1NxMlkl6g=;
        b=vSHv3AzyCbWSr589HtaNNKpur1UiY5+jPg8/vQQzllunLl/aDvzZK+Q5lq5iMCD3lk
         uYnjhCYIE3f3+guOw52YyDhPRUF5s+e1TEdMgmcFKjxaKfdv/EJpIg/WCBqtyFBlPIr0
         6g763Pd7QhyHS0zcTtyuVM89WL1po1l34Hxs+0w36MAp9B4TqSY8bACzWmXuRkNFd+5/
         GX/rC6AStlOkJJh/0HjqcslGd+B5Tr6t/9LR283Bg/qPh7lVc6kYEzGRk+1qFDaP3qJm
         r5uRlDmsTu2vxzN0xBHeDaW5SCd/9iYfCzSKdHFoFYEkKnM/yHrehoJF5/lEt2r2u7Lc
         pm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZM7ZiHVQG9OziFvs2AnUsvoK7AiW4q5xi1NxMlkl6g=;
        b=WKxrg14QCtuWzZpDQ6Xoy4ip7uxLMFjbNhv/e5BleeVvfxpD8w8t6A7YGqrx/nuqfQ
         gZ5fp02sZDZZ0WxgzljelUZqwXBXur7KtzfUDg987qtjCTxQz9LNU4+wHtGdoQwD6uqA
         inVFsLZilBQ+b1ump00VoruHtwL8aVZFM8h8PBVGMDb2erQJppxDt+QnTlQ3btyUk1lv
         gEwq8+miOxzFoPu9RsomAPaCkx0EhBsKPQDA45Sh+gQ7tP9YiA6tC9WMlZhmSt/TRJfW
         vfXEplj+YEBvG9k6C8BdcdcO0P3Jh0CQyz5GFP9jiZfZ8Eg7OVXjZlJ9CHYt+Bdaxc8N
         9hZQ==
X-Gm-Message-State: AHQUAuY233iFW+AVDQI+AUzKeaiHurWizKbVkZtVz6SHSucJCsXhyXCX
        2s7fyH4l0pDDxAdZuxZCUg5z98AuWGCz6RMeO7GD6Q==
X-Google-Smtp-Source: AHgI3IY3Y4pVRqsvmzgvBt01A6JRyNzrR6X8Dzlf1raJJfRx7vp4mMtvw/pULtIX4bcVD4+Xsnjy4WX7LSOWwwKdF/k=
X-Received: by 2002:a63:7f46:: with SMTP id p6mr23252259pgn.54.1550503556849;
 Mon, 18 Feb 2019 07:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20190217043434.46233-1-cai@lca.pw>
In-Reply-To: <20190217043434.46233-1-cai@lca.pw>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 18 Feb 2019 16:25:45 +0100
Message-ID: <CAAeHK+y8Xd1J2DppUMQLVhoc69wrqgNA=9hV45Jsd7V97CN6yw@mail.gmail.com>
Subject: Re: [PATCH] trace: skip hwasan
To:     Qian Cai <cai@lca.pw>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 5:34 AM Qian Cai <cai@lca.pw> wrote:
>
> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
> because there is a burst of too much pointer access, and then KASAN will
> dereference each byte of the shadow address for the tag checking which
> will kill all the CPUs.

Hi Qian,

Could you check if adding "CFLAGS_REMOVE_tags.o = -pg" into
mm/kasan/Makefile helps with that?

Thanks!

>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/trace/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index c2b2148bb1d2..fdd547a68385 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -28,6 +28,11 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
>  GCOV_PROFILE := y
>  endif
>
> +# Too much pointer access will kill hwasan.
> +ifdef CONFIG_KASAN_SW_TAGS
> +KASAN_SANITIZE := n
> +endif
> +
>  CFLAGS_trace_benchmark.o := -I$(src)
>  CFLAGS_trace_events_filter.o := -I$(src)
>
> --
> 2.17.2 (Apple Git-113)
>
