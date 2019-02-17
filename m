Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8281C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B229221924
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hFoI7Bp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfBQQxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:53:37 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40525 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfBQQxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:53:37 -0500
Received: by mail-vs1-f66.google.com with SMTP id z18so8309282vso.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 08:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKgfA//YV+A6sroKDHVk07GyLvRUDPHxxokXfsRBje4=;
        b=hFoI7Bp6l7EaGViqnGVmnznQ8x3N373hLmNz0CcJsNiE5HtBLMntYVo5fGmSfCou+q
         XP4n31pvGKARD5G1hVX6OliOHzOaAbgx000jxqFNHNr5F0gy+eNqGUl1sBlNEqr2r+za
         CyLRzP2de/gk8cOYua8mreVJ3GGuXSmaDQ/Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKgfA//YV+A6sroKDHVk07GyLvRUDPHxxokXfsRBje4=;
        b=b4Z37r7CuM9dHnF/b/rMuMMf9E59grSDXRIl9TI3g4cWuSdaWQKNUgkfFh0Mv5I0zo
         Klos5d5FT99fErRtCDeKK+5KdVJoK187vlbOIbthUPYzQTHIaS5fzrAUtQs0AvJ60zAO
         IXdTbP2Zt1c+TTRlBuVMUvKKWGbllJ7O9Qr/ZDiruSx5QHwaA/F84n3V4NLFcqJwxX/O
         2T0Qh6NLOUJscIdvcVzHDcrGWzAwzikEBBB6GzF+LXQd1sRyRoCjfRA3I/JYBULjNicQ
         hJNnn/6mOFYB33Qiz8ZdNTagCVaqnokzBAqphLuYVULXg9knWNqbYkbhKM8FrJNR+xVI
         B1SA==
X-Gm-Message-State: AHQUAubcxUTJyYC+J9f4Dp/AFCI+rSoTn1sf60D2+TC6vbiGsDW2ONtn
        Bg8HXQ/S85DWQjQNjFpimU6fPs6D9Zs=
X-Google-Smtp-Source: AHgI3IZ176JBGyRe/58sbO5nbsM6CmJUAzirmOcBIGo6vP7rCaZ1/JIG/K67SYaUjIwRucFW5yegnw==
X-Received: by 2002:a67:1b85:: with SMTP id b127mr10376994vsb.45.1550422415625;
        Sun, 17 Feb 2019 08:53:35 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id b144sm2535262vka.34.2019.02.17.08.53.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 08:53:34 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id j3so5095362uap.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 08:53:34 -0800 (PST)
X-Received: by 2002:a9f:2709:: with SMTP id a9mr9767198uaa.10.1550422414147;
 Sun, 17 Feb 2019 08:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20190216140008.28671-1-bhe@redhat.com> <20190216140008.28671-5-bhe@redhat.com>
In-Reply-To: <20190216140008.28671-5-bhe@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 17 Feb 2019 08:53:21 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKRRj9Hb5b=vnnrSuVpA+6U5mk1+16HsV=ZrPv-zgjPNA@mail.gmail.com>
Message-ID: <CAGXu5jKRRj9Hb5b=vnnrSuVpA+6U5mk1+16HsV=ZrPv-zgjPNA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] x86/mm/KASLR: Fix the wrong calculation of memory
 region initial size
To:     Baoquan He <bhe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Mike Travis <travis@sgi.com>,
        Thomas Garnier <thgarnie@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 6:03 AM Baoquan He <bhe@redhat.com> wrote:
>
> In memory region KASLR, __PHYSICAL_MASK_SHIFT is taken to calculate
> the initial size of the direct mapping region. This is correct in
> the old code where __PHYSICAL_MASK_SHIFT was equal to MAX_PHYSMEM_BITS,
> 46 bits, and only 4-level mode was supported.
>
> Later, in commit b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT
> always 52"), __PHYSICAL_MASK_SHIFT was changed to be always 52 bits, no
> matter it's 5-level or 4-level. This is wrong for 4-level paging. Then
> when we adapt physical memory region size based on available memory, it
> will overflow if the amount of system RAM and the padding is bigger
> than 64 TB.
>
> In fact, here MAX_PHYSMEM_BITS should be used instead. Fix it by
> replacing __PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.
>
> Fixes: b83ce5ee9147 ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52")
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Nice catch! I wish I had a system with >64TB RAM. ;)

Acked-by: Kees Cook <keescook@chromium.org>

> ---
>  arch/x86/mm/kaslr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index bf680929fe26..97768df923e3 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -137,7 +137,7 @@ void __init kernel_randomize_memory(void)
>         if (!kaslr_memory_enabled())
>                 return;
>
> -       kaslr_regions[0].size_tb = 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT);
> +       kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
>         kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
>
>         /*
> --
> 2.17.2
>


-- 
Kees Cook
