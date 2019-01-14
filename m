Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10519C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BBE20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cG3zM3rO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfANJfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:35:06 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43234 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfANJfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:35:05 -0500
Received: by mail-io1-f67.google.com with SMTP id b23so17068196ios.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 01:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pn0/rZ2B5GkSLOkvstRq19Y+ZB+KVKjQ5D4UTrTEcFQ=;
        b=cG3zM3rOJqP9xq8n8LMwEKTXJUQ4xh2O+zaaNyos6gkTdiT0UhD5YRj4zebrVQCK79
         lTszCU7lJZs+wRyNh/NZEjWDrwgO2XiRVx6xv0Ra/FQU9iclaLSOhmErIuO/HUVBzWr2
         nP3swD1jtKwthtzn03IXwPV9QFMWMIlVuHp1iQ0d6KMQztjWe8TBkSZdAUMrRjMh6WUN
         nStPiAZ/dUsrozxjVmfHco6C7wBa+7K1swBrAUHWvFubg/nw/9+fY4NJgHI7e9+NBb5/
         WSU1YAmgtOKm2strY0meX98AhNuQy8M3JmpV81bLo/b6PGT3C4i+VArU5y5WdeeW+yk+
         q0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pn0/rZ2B5GkSLOkvstRq19Y+ZB+KVKjQ5D4UTrTEcFQ=;
        b=Y3EwStg87R9NLL9B0EU3oNwpUUbYBIoiUijH3RkRFYeug9MiQjlsCPq2sJKcDe3eKv
         rbfbkIMpo1dNM0VMdXt4xNlc6oBJUPZbz+kQWa7nEPYnkxS3BtMTPWhC16LhJpkeOVZN
         22p4RGHj/sshDuKY/AiGjLDZYQJ4jbsrO4XTdndGS2Of2dH38Taj3DQcEos0uUzv8OV6
         bIlOto5zXLm3KuM5oTzoc1A/gIWqyBDII+7JUYzDY6+3pNpPQm3J+YQOJ9Ex9XeuEa61
         ZzJpisAHRHtRsAP3Iyhhq6028jyLWiUNQlc5ACuejraFb26gbqQ9STU4Q/Si1LaZTO5V
         XgDg==
X-Gm-Message-State: AJcUukfFupyeFef6Pi/0T5dBH/IzgZzN8FEGHM6skgv4U8LIWiYHWr3J
        1ygqwqgMKFgkB/oe4WiYtGY98Nv6KiwUrYjIRhVXjg==
X-Google-Smtp-Source: ALg8bN4Izjtfz8Gtik6EdgfSYlWSdQko5wrdsb98M1TQUO3p0k+tlZJCo9+xkTjkJb9IBNvEfs6/1WGPTInaXLkvDLg=
X-Received: by 2002:a6b:fa01:: with SMTP id p1mr9451772ioh.271.1547458504276;
 Mon, 14 Jan 2019 01:35:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547289808.git.christophe.leroy@c-s.fr> <0c854dd6b110ac2b81ef1681f6e097f59f84af8b.1547289808.git.christophe.leroy@c-s.fr>
In-Reply-To: <0c854dd6b110ac2b81ef1681f6e097f59f84af8b.1547289808.git.christophe.leroy@c-s.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Jan 2019 10:34:52 +0100
Message-ID: <CACT4Y+aEsLWqhJmXETNsGtKdbfHDFL1NF8ofv3KwvQPraXdFyw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] powerpc/mm: prepare kernel for KAsan on PPC32
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 12:16 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
&gt;
&gt; In kernel/cputable.c, explicitly use memcpy() in order
&gt; to allow GCC to replace it with __memcpy() when KASAN is
&gt; selected.
&gt;
&gt; Since commit 400c47d81ca38 ("powerpc32: memset: only use dcbz once cache is
&gt; enabled"), memset() can be used before activation of the cache,
&gt; so no need to use memset_io() for zeroing the BSS.
&gt;
&gt; Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
&gt; ---
&gt;  arch/powerpc/kernel/cputable.c | 4 ++--
&gt;  arch/powerpc/kernel/setup_32.c | 6 ++----
&gt;  2 files changed, 4 insertions(+), 6 deletions(-)
&gt;
&gt; diff --git a/arch/powerpc/kernel/cputable.c
b/arch/powerpc/kernel/cputable.c
&gt; index 1eab54bc6ee9..84814c8d1bcb 100644
&gt; --- a/arch/powerpc/kernel/cputable.c
&gt; +++ b/arch/powerpc/kernel/cputable.c
&gt; @@ -2147,7 +2147,7 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
&gt;         struct cpu_spec *t = &amp;the_cpu_spec;
&gt;
&gt;         t = PTRRELOC(t);
&gt; -       *t = *s;
&gt; +       memcpy(t, s, sizeof(*t));

Hi Christophe,

I understand why you are doing this, but this looks a bit fragile and
non-scalable. This may not work with the next version of compiler,
just different than yours version of compiler, clang, etc.

Does using -ffreestanding and/or -fno-builtin-memcpy (-memset) help?
If it helps, perhaps it makes sense to add these flags to
KASAN_SANITIZE := n files.


>         *PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
>  }
> @@ -2162,7 +2162,7 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
>         old = *t;
>
>         /* Copy everything, then do fixups */
> -       *t = *s;
> +       memcpy(t, s, sizeof(*t));
>
>         /*
>          * If we are overriding a previous value derived from the real
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index 947f904688b0..5e761eb16a6d 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -73,10 +73,8 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
>  {
>         unsigned long offset = reloc_offset();
>
> -       /* First zero the BSS -- use memset_io, some platforms don't have
> -        * caches on yet */
> -       memset_io((void __iomem *)PTRRELOC(&__bss_start), 0,
> -                       __bss_stop - __bss_start);
> +       /* First zero the BSS */
> +       memset(PTRRELOC(&__bss_start), 0, __bss_stop - __bss_start);
>
>         /*
>          * Identify the CPU type and fix up code sections
> --
> 2.13.3
>
