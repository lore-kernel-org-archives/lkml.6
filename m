Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD4EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4212082F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZ7V6+h+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395280AbfBMWmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:42:54 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36320 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392557AbfBMWmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:42:52 -0500
Received: by mail-it1-f195.google.com with SMTP id h6so8513206itl.1;
        Wed, 13 Feb 2019 14:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rE3ENum9etw8FLEOLYubxTblJFLNuBz5iBEKWe/uDo=;
        b=rZ7V6+h+utXAZGJQoZDjA54bjjYcb7ywLdWYkYK0fi3mff9Dkdg+vxoqqTJMA/HIXH
         DV2KZ6iDhfzxbeh4uFhSNKgpV9rS8l2/lQIA9Wc6SR9Qj+41beo/LKzHrmKcPZOauyyH
         Jntvx5Hg70U633XKv8KFLOM+ulJXhWCqOBRVQnTpIOD/yDRmXSe/RpRI1xLc3mE/MrKa
         V44xvB1CUpZ2qZZzr8XeT21Kwtx6B8CVs89nRNMPDosV9bKK0VWnfQN3Otdjqgfo6p7W
         aAf0R5G3QMrCDHjfAlTpvDdUdMuCqN+ofqroGSqdDWgbB0fcZVPx3m+CWSlJnFMlkSeA
         N9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rE3ENum9etw8FLEOLYubxTblJFLNuBz5iBEKWe/uDo=;
        b=lxtscgSwIKsaYFt2E0E6uNru3B/BzyaAYviyZCSS0J2py93GupaxODEx9+b1WGvlF4
         Y2uPi5i6623Af/HsX+ViHkS29Pr+UCO3TELVkLtoIdfQRGkoyhNi6VEcbMabuml7xVVh
         55sGi6zaEkXBX2ZQSlw4r5p+mCiI6FYG5hONGWLqavJ2XyxMoNLmhcrEKNrHiZlujWVD
         1e7pE0NX4aR3YYJUfDIvCNrHiJHUOFpdj52LggSUwfYX71swNKeEwLKBx6zcr3tbvajO
         lOcdPJoi0kce2Aa/2STOlSwVrT/MnkfDzKPTMNXRt9iPO2z64rXkj4UsoLD66y3kj1xV
         /VYg==
X-Gm-Message-State: AHQUAubs+NJ3iQy9MCPB9bnQE5sWniMYjqf6U24sPX2Ot1497Cmn4x03
        OWz/XCqXnbRDZXvRzgk3Anef1s9h6SALXHtboYI=
X-Google-Smtp-Source: AHgI3Ia37dWLigwy1iXWhfEBHuwjMxAIRQlHqD+nA8C5nqLiqJgOwL8GGfYyXhA7B/AkcXW13JbXtgKB2q8oxNDUA1w=
X-Received: by 2002:a24:2ed3:: with SMTP id i202mr291268ita.89.1550097770916;
 Wed, 13 Feb 2019 14:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20190213204157.12570-1-jannh@google.com>
In-Reply-To: <20190213204157.12570-1-jannh@google.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 13 Feb 2019 14:42:39 -0800
Message-ID: <CAKgT0Uc7wheUjStv5a4BSNv_=-iu1Ttdj9f_10CdR_oc2BhVig@mail.gmail.com>
Subject: Re: [PATCH] mm: page_alloc: fix ref bias in page_frag_alloc() for
 1-byte allocs
To:     Jann Horn <jannh@google.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Aaron Lu <aaron.lu@intel.com>, Netdev <netdev@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 12:42 PM Jann Horn <jannh@google.com> wrote:
>
> The basic idea behind ->pagecnt_bias is: If we pre-allocate the maximum
> number of references that we might need to create in the fastpath later,
> the bump-allocation fastpath only has to modify the non-atomic bias value
> that tracks the number of extra references we hold instead of the atomic
> refcount. The maximum number of allocations we can serve (under the
> assumption that no allocation is made with size 0) is nc->size, so that's
> the bias used.
>
> However, even when all memory in the allocation has been given away, a
> reference to the page is still held; and in the `offset < 0` slowpath, the
> page may be reused if everyone else has dropped their references.
> This means that the necessary number of references is actually
> `nc->size+1`.
>
> Luckily, from a quick grep, it looks like the only path that can call
> page_frag_alloc(fragsz=1) is TAP with the IFF_NAPI_FRAGS flag, which
> requires CAP_NET_ADMIN in the init namespace and is only intended to be
> used for kernel testing and fuzzing.

Actually that has me somewhat concerned. I wouldn't be surprised if
most drivers expect the netdev_alloc_frags call to at least output an
SKB_DATA_ALIGN sized value.

We probably should update __netdev_alloc_frag and __napi_alloc_frag so
that they will pass fragsz through SKB_DATA_ALIGN.

> To test for this issue, put a `WARN_ON(page_ref_count(page) == 0)` in the
> `offset < 0` path, below the virt_to_page() call, and then repeatedly call
> writev() on a TAP device with IFF_TAP|IFF_NO_PI|IFF_NAPI_FRAGS|IFF_NAPI,
> with a vector consisting of 15 elements containing 1 byte each.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  mm/page_alloc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 35fdde041f5c..46285d28e43b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4675,11 +4675,11 @@ void *page_frag_alloc(struct page_frag_cache *nc,
>                 /* Even if we own the page, we do not use atomic_set().
>                  * This would break get_page_unless_zero() users.
>                  */
> -               page_ref_add(page, size - 1);
> +               page_ref_add(page, size);
>
>                 /* reset page count bias and offset to start of new frag */
>                 nc->pfmemalloc = page_is_pfmemalloc(page);
> -               nc->pagecnt_bias = size;
> +               nc->pagecnt_bias = size + 1;
>                 nc->offset = size;
>         }
>
> @@ -4695,10 +4695,10 @@ void *page_frag_alloc(struct page_frag_cache *nc,
>                 size = nc->size;
>  #endif
>                 /* OK, page count is 0, we can safely set it */
> -               set_page_count(page, size);
> +               set_page_count(page, size + 1);
>
>                 /* reset page count bias and offset to start of new frag */
> -               nc->pagecnt_bias = size;
> +               nc->pagecnt_bias = size + 1;
>                 offset = size - fragsz;
>         }

If we already have to add a constant it might be better to just use
PAGE_FRAG_CACHE_MAX_SIZE + 1 in all these spots where you are having
to use "size + 1" instead of "size". That way we can avoid having to
add a constant to a register value and then program that value.
instead we can just assign the constant value right from the start.
