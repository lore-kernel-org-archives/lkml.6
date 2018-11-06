Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D27C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFDC2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxMHkqmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFDC2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbeKFJdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:33:37 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54983 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbeKFJdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:33:37 -0500
Received: by mail-it1-f194.google.com with SMTP id d6so15511010itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 16:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wj8+MP0Q+X4/kErEU87GH8+TuYm6uQfnz8mN/PS1sCA=;
        b=PxMHkqmvOyilx5T7xSJMKsvcmKY5aK9V1OWt2jkknnycevkyIaLh1dNhGT6QNEApe4
         aU0WSOooN7ctM6E0iBorMiMhgP2OzQxEdZTu4Mk6apG3E38CPK+epXgfyr7jmqpzTRO6
         dr32Y3AyauJuXYQslRR2BUZHbgwKToT5pWTMghj94PV7Ka3EfrjHlwTYl4q2NDW0h21g
         0myyvt34mugKL2ZLeESPUxyvjXwdtBgBvC1viTOzxEkX4StWufF/tHxVJ+NQegmXqcei
         4gocNj3ROGpsFxacny+jPBYdf+QMpq2p3ovsqjD6u8I9m41BfNP30VAQRYyd3lN/K3Cu
         zGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wj8+MP0Q+X4/kErEU87GH8+TuYm6uQfnz8mN/PS1sCA=;
        b=SEqcwjQa04Y0Pj7dsN7AQ1y94DhQXOPr0xi/L8zLbt1yhK0HxFlWJbFTKAaAeQKc+1
         LsfQFKynv279Tep8teo/c5UUZRmUacHoc11ZbHZk6uQh+SdS5XqV1r3Mxeq6Q6tZOQNA
         cQCkaMFKtmiA1E76h8PZXDbUbsx6D3q0fczUJG3FmdPq/3nPBMMGBZNaUmL5UtchVPcF
         pnAwAPJhXkut8KGHQ3GhN0Iq0iiMNB0Z1F3HSVCSbRCuq0Fvi+H7FfK4qGmf3FZTWuPA
         bfZFhgYcU0ZpaNRVJJnGfVnrLBdybBKjmDE3Jz/TzEnY+SS8ItXx1q+aGXUxcl+C2BaU
         JzTA==
X-Gm-Message-State: AGRZ1gICr94tOf0tgV7aADPb39y+5Wvq578XgP6UZ0pGwcWNQ3bd81wD
        AodRMoo8IPXAEzT6uf8uQbi8O9xf+YUZFDpAzN4=
X-Google-Smtp-Source: AJdET5cydHOpUT4j6TMsClWSi5jU/tECrCdTx7u6DlxLGmbfkZzZ1bYs0LBrQKY99WmdZxgiRI9AlC0zHL9sTIqb4jw=
X-Received: by 2002:a24:e385:: with SMTP id d127-v6mr282274ith.6.1541463076269;
 Mon, 05 Nov 2018 16:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20181105204000.129023-1-bvanassche@acm.org> <20181105131305.574d85469f08a4b76592feb6@linux-foundation.org>
 <1541454489.196084.157.camel@acm.org> <ce6faf63-1661-abe5-16a6-8c19cc9f6689@rasmusvillemoes.dk>
 <1541457654.196084.159.camel@acm.org> <CAKgT0Udci4Ai4OD20NSRuDckE_G4RHma3Bg6H1Um6N9Se_zPew@mail.gmail.com>
 <1541462466.196084.163.camel@acm.org>
In-Reply-To: <1541462466.196084.163.camel@acm.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 5 Nov 2018 16:11:04 -0800
Message-ID: <CAKgT0Ue59US_f-cZtoA=yVbFJ03ca5OMce2opUdQcsvgd8LWMw@mail.gmail.com>
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

On Mon, Nov 5, 2018 at 4:01 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Mon, 2018-11-05 at 14:48 -0800, Alexander Duyck wrote:
> > On Mon, Nov 5, 2018 at 2:41 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > > How about this version, still untested? My compiler is able to evaluate
> > > the switch expression if the argument is constant.
> > >
> > >  static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
> > >  {
> > > -       int is_dma = 0;
> > > -       int type_dma = 0;
> > > -       int is_reclaimable;
> > > +       unsigned int dr = !!(flags & __GFP_RECLAIMABLE);
> > >
> > >  #ifdef CONFIG_ZONE_DMA
> > > -       is_dma = !!(flags & __GFP_DMA);
> > > -       type_dma = is_dma * KMALLOC_DMA;
> > > +       dr |= !!(flags & __GFP_DMA) << 1;
> > >  #endif
> > >
> > > -       is_reclaimable = !!(flags & __GFP_RECLAIMABLE);
> > > -
> > >         /*
> > >          * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
> > >          * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
> > >          */
> > > -       return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
> > > +       switch (dr) {
> > > +       default:
> > > +       case 0:
> > > +               return 0;
> > > +       case 1:
> > > +               return KMALLOC_RECLAIM;
> > > +       case 2:
> > > +       case 3:
> > > +               return KMALLOC_DMA;
> > > +       }
> > >  }
> >
> > Doesn't this defeat the whole point of the code which I thought was to
> > avoid conditional jumps and branches? Also why would you bother with
> > the "dr" value when you could just mask the flags value and switch on
> > that directly?
>
> Storing the relevant bits of 'flags' in the 'dr' variable avoids that the
> bit selection expressions have to be repeated and allows to use a switch
> statement instead of multiple if / else statements.

Really they shouldn't have to be repeated. You essentially have just 3
cases. 0, __GFP_RECLAIMABLE, and the default case.

> Most kmalloc() calls pass a constant to the gfp argument. That allows the
> compiler to evaluate kmalloc_type() at compile time. So the conditional jumps
> and branches only appear when the gfp argument is not a constant. What makes
> you think it is important to optimize for that case?
>
> Bart.

I didn't really think it was all that important to optimize, but I
thought that was what you were trying to maintain with the earlier
patch since it was converting things to a table lookup.

If we really don't care then why even bother with the switch statement
anyway? It seems like you could just do one ternary operator and be
done with it. Basically all you need is:
return (defined(CONFIG_ZONE_DMA) && (flags & __GFP_DMA)) ? KMALLOC_DMA :
        (flags & __GFP_RECLAIMABLE) ? KMALLOC_RECLAIM : 0;

Why bother with all the extra complexity of the switch statement?

Thanks.

- Alex
