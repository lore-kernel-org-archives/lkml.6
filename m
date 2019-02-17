Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF27C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538F52195D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i7D867TW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfBQRZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 12:25:53 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33160 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBQRZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 12:25:53 -0500
Received: by mail-ua1-f67.google.com with SMTP id q17so5115528uam.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 09:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxx/t1reVYqnMbFXMu0abZkfOzYBHareNpoI4El4ajQ=;
        b=i7D867TWvCbAmvXSMIPDlr21ezxFEKdydIUzqNZ7tguICleTYOg8gTshKYTyBRIQ0D
         m+scGjwDgRg6vQrZcvH7JI4ZuNcVYtzHW3HmGmmyPIsFs5qlKxnCSnKy9yIhsBvG9UU4
         JCzwj6IqxRPdXzC0k6p8o4VXA2fvyndxKD5Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxx/t1reVYqnMbFXMu0abZkfOzYBHareNpoI4El4ajQ=;
        b=de7W0ye20gM/NDLIV4xO9Q1i480Zqp4hEj0j6zJ6ECz6rFQ8Rs9CNdFcl1qikwyTKX
         9obzZZehjPWd7D9hLGaApHgeoOsHunhQbFyIUxYoKefPj+kmKOfb1rCsbecA96Od79zl
         kCZY1GtLOxTCqNsN0A6woS7YpJDA4Sma1iiluQbPQvMcuMY1D3j6auKn3wMLWxFEWXcu
         Y6enGWetSbeCf/5xHaIM3DpJcSqbhPYKfDJfQVpKA0d2nVaUtm6HEIfqGB9ixHVQnDmg
         l1/ZhnlT6A2CDSvCe+bC+mWTRe9IU7hqwQ6Rph8qWxElCIpbe1JvnKxTflx1wUKD1WX1
         7Kkg==
X-Gm-Message-State: AHQUAuaK7eKy0c1fn3aRumchZrJU4SCT9gTsysZua/Ec4rC8lF3HYzWe
        Jx97aKAHtBi3/63fJrfUI6P+oLysJvA=
X-Google-Smtp-Source: AHgI3IbdeovrGhhU3oWYOifkV2TH5PzYBwhOOHZgp1AT9BFpp8lhYKycLnyEcO85Sy7TjWsiRy/NdA==
X-Received: by 2002:ab0:2650:: with SMTP id q16mr9283484uao.120.1550424351182;
        Sun, 17 Feb 2019 09:25:51 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id i6sm3418508vkd.7.2019.02.17.09.25.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 09:25:50 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id t7so8338582vsq.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 09:25:49 -0800 (PST)
X-Received: by 2002:a67:c00a:: with SMTP id v10mr10689532vsi.66.1550424349393;
 Sun, 17 Feb 2019 09:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20190216140008.28671-1-bhe@redhat.com> <20190216140008.28671-6-bhe@redhat.com>
In-Reply-To: <20190216140008.28671-6-bhe@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 17 Feb 2019 09:25:38 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJjed2yS1OZ2+rKuMiPr7HTXLx5qMSV+xWHJs-DJGT4-A@mail.gmail.com>
Message-ID: <CAGXu5jJjed2yS1OZ2+rKuMiPr7HTXLx5qMSV+xWHJs-DJGT4-A@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] x86/mm/KASLR: Calculate the actual size of vmemmap region
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

On Sat, Feb 16, 2019 at 6:04 AM Baoquan He <bhe@redhat.com> wrote:
>
> Vmemmap region has different maximum size depending on paging mode.
> Now its size is hardcoded as 1TB in memory KASLR, this is not
> right for 5-level paging mode. It will cause overflow if vmemmap
> region is randomized to be adjacent to cpu_entry_area region and
> its actual size is bigger than 1TB.
>
> So here calculate how many TB by the actual size of vmemmap region
> and align up to 1TB boundary.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/kaslr.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 97768df923e3..ca12ed4e5239 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -101,7 +101,7 @@ static __initdata struct kaslr_memory_region {
>  } kaslr_regions[] = {
>         { &page_offset_base, 0 },
>         { &vmalloc_base, 0 },
> -       { &vmemmap_base, 1 },
> +       { &vmemmap_base, 0 },
>  };
>
>  /*
> @@ -121,6 +121,7 @@ void __init kernel_randomize_memory(void)
>         unsigned long rand, memory_tb;
>         struct rnd_state rand_state;
>         unsigned long remain_entropy;
> +       unsigned long vmemmap_size;
>
>         vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
>         vaddr = vaddr_start;
> @@ -152,6 +153,14 @@ void __init kernel_randomize_memory(void)
>         if (memory_tb < kaslr_regions[0].size_tb)
>                 kaslr_regions[0].size_tb = memory_tb;
>
> +       /*
> +        * Calculate how many TB vmemmap region needs, and align to
> +        * 1TB boundary.

Can you describe why this is the right calculation? (This will help
explain why 4-level is different from 5-level here.)

> +        */
> +       vmemmap_size = (kaslr_regions[0].size_tb << (TB_SHIFT - PAGE_SHIFT)) *
> +               sizeof(struct page);
> +       kaslr_regions[2].size_tb = DIV_ROUND_UP(vmemmap_size, 1UL << TB_SHIFT);
> +
>         /* Calculate entropy available between regions */
>         remain_entropy = vaddr_end - vaddr_start;
>         for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
> --
> 2.17.2
>

Otherwise, yeah, looks great!

-- 
Kees Cook
