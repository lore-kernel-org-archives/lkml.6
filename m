Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8CDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5568B208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+lsZIVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeL0PVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 10:21:13 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:42409 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbeL0PVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 10:21:12 -0500
Received: by mail-pf1-f177.google.com with SMTP id 64so9261563pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 07:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2EGYq8XTKqDNlssItDJr1D7HvVzviICZgcJkBUhouQ=;
        b=o+lsZIViOhVMBZaQmR9XX3L1dHn4EmbIWJalPCayhnKcnph0w5lZ/IAYbjQtdej+E1
         1Msmkxd9/iv3OtnGBCncNWYh/1FmvZrfnhmoETbKp1WhdfohCzcj6Tj04MDAxPmDj+Ll
         nm4steYkwKEhsT8KnAfiTssWcYV81zREG4S99JkH3bpyFNXGtHeEnV/4YpqOuyFj07N+
         aS1J+Tw6i+243o+B6sN7ixqhFJrRReVe8uIaLrK63g1hAR/dvZEzoesIV68JVtr2/YZl
         03lMrTpWc/m/O4KkXny6zjXaWjZNirxNs8i2AR5Jtc5Ju3o3moKPoFAgDkxnkqH4eNEI
         +teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2EGYq8XTKqDNlssItDJr1D7HvVzviICZgcJkBUhouQ=;
        b=IAFxERcHn9dUKyQHyZjFHMQQFzAIuxsvqOCiSoU9GE/Kc+k2ese8B6HZ8RS07pyeXn
         HlzBZCE8XW8GWkEtpij6KVJtV9Wu5rGGItPAhi3NWWPJrVQT1Y61Z0iS63lLlb9EF0ZN
         51FvdsiTTS7vx0wM8KaF8bXFjr4l9DYPA6ndjYtH60s3E+YHrU8DCmB/ElBzub6rJWJ7
         fDXEe88XDqncwC34CFlDH/KCBNb2S5fRhxPOEj4kL2o71lm6SZrOmX1ORV0/f1++Zk7y
         RgQ498Yap5frRF2YBVWG0Le9bJGH+XDGEIFLucfhOxoy2rumE3kEBiCkKy4WxQVzZXj7
         mzoA==
X-Gm-Message-State: AJcUukfgPmXV+rGTCc6SMnOYc5GKqt8oqVSrEmxWBfFXLWLBgGvWgE6Z
        fJ5dr6NRHSbx2YcsqHVY3MU11TWFdDHtXyR8ItuPfQ==
X-Google-Smtp-Source: ALg8bN6T8NvDJ2PBQQwHgBrKDWlnRFUo+0Y11//Bd7DA4F8zknOWe3sAFZQutsygcML14CuAp8P5ZBXhNq7w9Ap/5mU=
X-Received: by 2002:a63:9e58:: with SMTP id r24mr23625868pgo.264.1545924071964;
 Thu, 27 Dec 2018 07:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20181226020550.63712-1-cai@lca.pw>
In-Reply-To: <20181226020550.63712-1-cai@lca.pw>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 27 Dec 2018 16:21:00 +0100
Message-ID: <CAAeHK+zj0LcjhcQFd4H9CfRbyzz8u+HuhA4-c-pjnDobkDGRJQ@mail.gmail.com>
Subject: Re: [PATCH -mmotm] arm64: skip kmemleak for KASAN again
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 3:06 AM Qian Cai <cai@lca.pw> wrote:
>
> Due to 871ac3d540f (kasan: initialize shadow to 0xff for tag-based
> mode), kmemleak is broken again with KASAN. It needs a similar fix
> from e55058c2983 (mm/memblock.c: skip kmemleak for kasan_init()).
>
> Signed-off-by: Qian Cai <cai@lca.pw>

Hi Qian,

Sorry, didn't see your first kmemleak fix. I can merge this fix into
my series if I end up resending it.

In any case:

Acked-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!

> ---
>  arch/arm64/mm/kasan_init.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 48d8f2fa0d14..4b55b15707a3 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -47,8 +47,7 @@ static phys_addr_t __init kasan_alloc_raw_page(int node)
>  {
>         void *p = memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
>                                                 __pa(MAX_DMA_ADDRESS),
> -                                               MEMBLOCK_ALLOC_ACCESSIBLE,
> -                                               node);
> +                                               MEMBLOCK_ALLOC_KASAN, node);
>         return __pa(p);
>  }
>
> --
> 2.17.2 (Apple Git-113)
>
