Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08334C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A4F2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSUvqz4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A4F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388237AbeKFIKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:10:35 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36962 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387965AbeKFIKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:10:35 -0500
Received: by mail-it1-f195.google.com with SMTP id j79-v6so3176569itb.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFYJrxVhkpmtU2Wl01xsiF06VysxFo0WEBY5pC7EduE=;
        b=GSUvqz4kbFpv5GNWcCKJyHbCA8DtHfskFBy2PunorSi2SF5Tk/TzzdHrEye2IOUUZO
         cfoGL3R43hqNaxTsr95hVPvW2rUjx/uw9vbTOH4DxKHfMw59z6ZbB/GENGydqGoGjN35
         AbCoc1+BD+NzVMztUvfU5FLMEaGYmSdTsUpvdQWRVv+OEaF9O3D4DeqZHPwtosA5I74y
         Dv26+cvSqooPE4ZJ9m7apR0Y+XpPd34LHWX0wtvTRExcX0vKa5dFjSCCLi2TJcI3xYI7
         4bivGvk2gBFGI50tWl0jTIa6PeBwAreAAqgOzWu8lO0UDr8DxnNqsarn0YsR9o6iECuX
         hjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFYJrxVhkpmtU2Wl01xsiF06VysxFo0WEBY5pC7EduE=;
        b=eI5rgkq+oMycWD5oM7C3GkbZnCs6M+WuSuQK7+vGEzMH5NEmaq42LKy3XGmm+Nq1kB
         grV9yood8LBFbANsmiMuVy7yLDSc016UciuGNF/5qOa2/pm++0Bpo2AmlqSm2XpGJc7Z
         aTjpFSENXKAuP1i18F8pMi9FO1GsLlAQhVM5tcbCd8Gqw5oZCGttHqOU0bixuc9CgElw
         Ok+21F36SPHNv5oW4jvfs0wISevesjabyDxSW5dMlzj1GQS37R1jGxjsuNiHt4+Ag/9P
         vlVHBz5CTUQudDzb7NCiLUrG8ZP86LUT7CAwOKn1zW5nBb9EM23ylGiSOKUi6ntFWoZZ
         NtEw==
X-Gm-Message-State: AGRZ1gJbbyyrV2s/W/JqYaiVqIqDWD+WEQOW33DxVGrbPadyLeJTkcmo
        KRGx9m93SBL2RN8L2RGH3tCyctqStJUa0xC6cvY=
X-Google-Smtp-Source: AJdET5enDqu2WTLssRJ0XMvmJ5hpHU/ucVWt79pU/jlZuHAPoJPiGWLa9lcgFwQsqutAGoJDPbLcLNT5JR1pQGgDz5s=
X-Received: by 2002:a02:c85:: with SMTP id 5-v6mr22306025jan.87.1541458114535;
 Mon, 05 Nov 2018 14:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20181105204000.129023-1-bvanassche@acm.org> <20181105131305.574d85469f08a4b76592feb6@linux-foundation.org>
 <1541454489.196084.157.camel@acm.org> <ce6faf63-1661-abe5-16a6-8c19cc9f6689@rasmusvillemoes.dk>
 <1541457654.196084.159.camel@acm.org>
In-Reply-To: <1541457654.196084.159.camel@acm.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 5 Nov 2018 14:48:23 -0800
Message-ID: <CAKgT0Udci4Ai4OD20NSRuDckE_G4RHma3Bg6H1Um6N9Se_zPew@mail.gmail.com>
Subject: Re: [PATCH] slab.h: Avoid using & for logical and of booleans
To:     bvanassche@acm.org
Cc:     linux@rasmusvillemoes.dk,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, guro@fb.com,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 2:41 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Mon, 2018-11-05 at 23:14 +0100, Rasmus Villemoes wrote:
> > Won't that pessimize the cases where gfp is a constant to actually do
> > the table lookup, and add 16 bytes to every translation unit?
> >
> > Another option is to add a fake KMALLOC_DMA_RECLAIM so the
> > kmalloc_caches[] array has size 4, then assign the same dma
> > kmalloc_cache pointer to [2][i] and [3][i] (so that costs perhaps a
> > dozen pointers in .data), and then just compute kmalloc_type() as
> >
> > ((flags & __GFP_RECLAIMABLE) >> someshift) | ((flags & __GFP_DMA) >>
> > someothershift).
> >
> > Perhaps one could even shuffle the GFP flags so the two shifts are the same.
>
> How about this version, still untested? My compiler is able to evaluate
> the switch expression if the argument is constant.
>
>  static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>  {
> -       int is_dma = 0;
> -       int type_dma = 0;
> -       int is_reclaimable;
> +       unsigned int dr = !!(flags & __GFP_RECLAIMABLE);
>
>  #ifdef CONFIG_ZONE_DMA
> -       is_dma = !!(flags & __GFP_DMA);
> -       type_dma = is_dma * KMALLOC_DMA;
> +       dr |= !!(flags & __GFP_DMA) << 1;
>  #endif
>
> -       is_reclaimable = !!(flags & __GFP_RECLAIMABLE);
> -
>         /*
>          * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
>          * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
>          */
> -       return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
> +       switch (dr) {
> +       default:
> +       case 0:
> +               return 0;
> +       case 1:
> +               return KMALLOC_RECLAIM;
> +       case 2:
> +       case 3:
> +               return KMALLOC_DMA;
> +       }
>  }
>
> Bart.

Doesn't this defeat the whole point of the code which I thought was to
avoid conditional jumps and branches? Also why would you bother with
the "dr" value when you could just mask the flags value and switch on
that directly?
