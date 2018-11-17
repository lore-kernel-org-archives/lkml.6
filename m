Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE661C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 07:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968FB2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 07:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1vIDkbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968FB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbeKQRWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 12:22:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34908 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeKQRWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 12:22:32 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so22242720ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 23:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIKcjyDRicTrvbuurk8pmEnO8fySvmZKHCB2aFwXKyo=;
        b=d1vIDkbeZUZUCYskR8G7+3qH2MMSz6P51FBjnG/CkqJ7iWaUY9dyicU2YmH6olA42D
         Sp5JkcRb397m5fl5zZFVJY+eNi77Lps6tbR4yk7IXiUOT+CvsbSmn0C1eNXACcYw4zR1
         fMC3t03xr4Cnqf0749ChMGV88OFtE8sqiFGN5VedJl4L5e0SEscrTTPRjJpXVABBM/Nc
         DykZpAZ/xLephvYBoA7UGbBJMX7baxyhg7y6GPb1JyIxSKN+uRsH6271lLw/3TrF/k5d
         IiSXtuQY6TZAMsMAqvGrLMiaXdTywSthefBge9GBj5WY5CGxqscf/FcMcih0KPMYwf/O
         xdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIKcjyDRicTrvbuurk8pmEnO8fySvmZKHCB2aFwXKyo=;
        b=mC4j1sglfQklPTkLfLrxTGkw10jgLtLxmTmrRb/yf1E6BOG3p/QLGIQz+OjY+1GQ4B
         ofKSmFw7uiMpmuvdXnNRHeD1cIMacGq8kDfVyXtahD8gK4ZMX5GCfVgs7x8cqffvD+yD
         vYcTLK1zEdh1xiVV4JOPUV1Vt6UDNHVfXQMDhfgyxBjwZYilGqaZYSn/rxCBsf9x2mQt
         3idTtxyGcXMzu1oAkBNZ9VGOi/uejdmBMk/uDoKJQf3K5aaZW9y22ZodVm30YqhwLJtl
         WiWNUkQn2dy5eOdZpBQopBCuIiiy2eOnshNRQKNkhkYf8JYNqHW3xY1kqdQl2ujvuHQi
         OKsg==
X-Gm-Message-State: AGRZ1gJkcM0gTHcEd1qu5nVIRZivwJFnegY+89sBjw8/shufu/pdlw37
        n91AE9RsYJalhOclGY0uqa+xneV0q4rAV7AM24Q=
X-Google-Smtp-Source: AJdET5czjaiMsHoTtcU3ldJi6TO+PftdpUiKXZ88r8b39gmA5paMZgOKfehDa96kXsV8gIx4bI6GqpsYsVHngdTtUTo=
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr7425061lji.93.1542438407249;
 Fri, 16 Nov 2018 23:06:47 -0800 (PST)
MIME-Version: 1.0
References: <5bdfb8db.1c69fb81.c8f62.9586@mx.google.com> <CAJr6mf1nOouU31WF_xb_46wDebPQ-7+NTCiSKBjLyQta2mny6w@mail.gmail.com>
 <7a3922bc5089dfe0978e07a809606360c74c940c.camel@perches.com>
In-Reply-To: <7a3922bc5089dfe0978e07a809606360c74c940c.camel@perches.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 17 Nov 2018 12:40:14 +0530
Message-ID: <CAFqt6zY2bv=G1N13E4-SA2DE6ey3kw378fFzgEHV7wdpJ5hp5g@mail.gmail.com>
Subject: Re: [PATCH] arch/powerpc: Use dma_zalloc_coherent
To:     Joe Perches <joe@perches.com>
Cc:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        darren@stevens-zone.net, christophe.leroy@c-s.fr,
        geoff@infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Fri, Nov 16, 2018 at 12:55 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2018-11-15 at 23:29 +0530, Sabyasachi Gupta wrote:
> > On Mon, Nov 5, 2018 at 8:58 AM Sabyasachi Gupta
> > <sabyasachi.linux@gmail.com> wrote:
> > > Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
> > >
> > > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> >
> > Any comment on this patch?
>
> It's obviously correct.
>
> You might realign the arguments on the next lines
> to the open parenthesis.
>
> Perhaps there should be new function calls
> added for symmetry to the other alloc functions
> for multiplication overflow protection.
>
> Perhaps:
>
> void *dma_alloc_array_coherent()
> void *dma_calloc_coherent()
>
> Something like
> ---
>  include/linux/dma-mapping.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 15bd41447025..95bebf8883b1 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -565,6 +565,25 @@ static inline void *dma_alloc_coherent(struct device *dev, size_t size,
>                         (gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
>  }
>
> +static inline void *dma_alloc_array_coherent(struct device *dev,
> +                                            size_t n, size_t size,
> +                                            dma_addr_t *dma_handle, gfp_t gfp)
> +{
> +       size_t bytes;
> +
> +       if (unlikely(check_mul_overflow(n, size, &bytes)))
> +               return NULL;
> +       return dma_alloc_coherent(dev, bytes, dma_handle, gfp);
> +}
> +
> +static inline void *dma_calloc_coherent(struct device *dev,
> +                                       size_t n, size_t size,
> +                                       dma_addr_t *dma_handle, gfp_t gfp)
> +{
> +       return dma_alloc_array_coherent(dev, n, size, dma_handle,
> +                                       gfp | __GFP_ZERO);
> +}
> +

If I understood correctly, you are talking about adding these 2 new inline
functions. We can do that.

Can you please help to understand the consumers of these 2 new inline ?

>  static inline void dma_free_coherent(struct device *dev, size_t size,
>                 void *cpu_addr, dma_addr_t dma_handle)
>  {
>
> ---
> > > diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
> []
> > > @@ -255,15 +255,13 @@ int pasemi_dma_alloc_ring(struct pasemi_dmachan *chan, int ring_size)
> > >
> > >         chan->ring_size = ring_size;
> > >
> > > -       chan->ring_virt = dma_alloc_coherent(&dma_pdev->dev,
> > > +       chan->ring_virt = dma_zalloc_coherent(&dma_pdev->dev,
> > >                                              ring_size * sizeof(u64),
> > >                                              &chan->ring_dma, GFP_KERNEL);
> > >  en
> > >         if (!chan->ring_virt)
> > >                 return -ENOMEM;
> > >
> > > -       memset(chan->ring_virt, 0, ring_size * sizeof(u64));
> > > -
> > >         return 0;
> > >  }
> > >  EXPORT_SYMBOL(pasemi_dma_alloc_ring);
>
>
