Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 93FF6C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC20208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland-com.20150623.gappssmtp.com header.i=@herbertland-com.20150623.gappssmtp.com header.b="CGD2Pm7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC20208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=herbertland.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755018AbeFNRlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 13:41:09 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39537 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754757AbeFNRlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 13:41:07 -0400
Received: by mail-qt0-f196.google.com with SMTP id p23-v6so6573807qtn.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nS1Ok2RvxHxXDLWPua+igdIh/Js7SSaV+D07BTTMCTg=;
        b=CGD2Pm7VqzWETUeOpMrdqHV/72n0+R5vakmVGUHLdFhRgpLYrUynK9q58PUofQ+AMV
         qEsSMRmo966twVIOsJRQDngojPH4c34HIQP0qg44HyzOv95xyq+H2uKELgJollcr02AI
         qcqdMzDQ0w31nzHDPyJ+6GOYUAp4sfECIWl8aiTj/XxTLPnmDUa++L4HJ0DYTCUb/Yf+
         6QfloHQ3Xo1BXI9UtHoYktaUNwRC2p9FjtaxY+GuVPH2mEx77aJKLziBh0JPEWDrYuA6
         Fb0GiGlyT1bXesXode9KjGYfZQyU5laOdRbhs+EAdjDHrsclW9voA7ZuHfy3oAeHGwJa
         kDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nS1Ok2RvxHxXDLWPua+igdIh/Js7SSaV+D07BTTMCTg=;
        b=dam3d3HJGnyp1zkVph3w9lRIkUQHEvtPN/Lr/2iOizxmPEkYlCTQvgGbrHUharuLvy
         3UL7SYwPshkoa5Yh+KS8X87akqlBY82Dm8xxOZ/GFBYrxveQtl/j1yJ7D7aUBWAEj96/
         DzVtnsAgdLQHOsGwvlPzvtlikT9JuR+sTRRUNlQr4sgwv4R/GUe8CPWqjKHblNIrSQuZ
         /Ajq0n4XiqhZ2W9N8s8eaS5xPCIHOMOjum3MczfbnFXxJk+0DuyQe0UQ+ILOr2Af/SGW
         RdZQinLWpAqxufAJEqDzllUDgy8H3sT+GHs+aij05Q6EkcrIQQD2iKp5CPHStURSziv5
         IaQw==
X-Gm-Message-State: APt69E0Bj75Xzw0eEQYq6OUdBmUV93SfuChZoKtS/zlc4JDFgRSWc/hg
        d4WJHJyUPoZQ3YL9QyLEM3/L6uO9lz2sGpOXwzeQzw==
X-Google-Smtp-Source: ADUXVKLRHbJCoPKzFU3sq3g+OZk58cRoSUQxPrx4TQBoTByKvKdHtgBiZDFzNLy83iDU3cbtOTUc8QPqPx9vVA2anRA=
X-Received: by 2002:a0c:e4d3:: with SMTP id g19-v6mr3304673qvm.242.1528998066575;
 Thu, 14 Jun 2018 10:41:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:33a2:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 10:41:05
 -0700 (PDT)
In-Reply-To: <871sdck9ds.fsf@notabene.neil.brown.name>
References: <152782754287.30340.4395718227884933670.stgit@noble>
 <152782824964.30340.6329146982899668633.stgit@noble> <20180602154851.pfy4wryezuhxp76v@gondor.apana.org.au>
 <87y3fvpf40.fsf@notabene.neil.brown.name> <CALx6S37AYrFoJNrdToRc84J=B4f57jaHS077UsxdEoQ-xwyCeg@mail.gmail.com>
 <87sh63pakb.fsf@notabene.neil.brown.name> <CALx6S35sf4oj=x73SfhUxi1e9-u4Stxgr9BAj5E7KKmbufntwg@mail.gmail.com>
 <87r2lmnj2c.fsf@notabene.neil.brown.name> <CALx6S36Ce-rXQMzmFYZVPGD10Bo6udvRAHiZ5gWwnzVwoTVv0w@mail.gmail.com>
 <87in6wo636.fsf@notabene.neil.brown.name> <871sdjnwkr.fsf@notabene.neil.brown.name>
 <87y3frmhyx.fsf@notabene.neil.brown.name> <CALx6S35GgUOd0dPgv7P96wNNTv5pN7fij0pcAoccqcSWZhvY7Q@mail.gmail.com>
 <871sdck9ds.fsf@notabene.neil.brown.name>
From:   Tom Herbert <tom@herbertland.com>
Date:   Thu, 14 Jun 2018 10:41:05 -0700
Message-ID: <CALx6S35Yr8th_LFoCLjEqfzti0cp7+7nKZC7KO3dzeQkU7c0nw@mail.gmail.com>
Subject: Re: [PATCH RFC v2] rhashtable: implement rhashtable_walk_peek() using rhashtable_walk_last_seen()
To:     NeilBrown <neilb@suse.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Herbert <tom@quantonium.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 7:48 PM, NeilBrown <neilb@suse.com> wrote:
>
> rhashtable_walk_last_seen() does most of the work that
> rhashtable_walk_peek() needs done, so use it and put
> it in a "static inline".
> Also update the documentation for rhashtable_walk_peek() to clarify
> the expected use case.
>
> Signed-off-by: NeilBrown <neilb@suse.com>

Acked-by: Tom Herbert <tom@quantonium.net>

> ---
>
> v2 as static-inline - suggested by Tom.
>
> Thanks,
> NeilBrown
>
>  include/linux/rhashtable.h | 29 ++++++++++++++++++++++++++++-
>  lib/rhashtable.c           | 34 ----------------------------------
>  2 files changed, 28 insertions(+), 35 deletions(-)
>
> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index d63b472e9d50..96ebc2690027 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h
> @@ -247,10 +247,37 @@ static inline void rhashtable_walk_start(struct rhashtable_iter *iter)
>  }
>
>  void *rhashtable_walk_next(struct rhashtable_iter *iter);
> -void *rhashtable_walk_peek(struct rhashtable_iter *iter);
>  void *rhashtable_walk_last_seen(struct rhashtable_iter *iter);
>  void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases(RCU);
>
> +/**
> + * rhashtable_walk_peek - Return the next object to use in an interrupted walk
> + * @iter:      Hash table iterator
> + *
> + * Returns the "current" object or NULL when the end of the table is reached.
> + * When an rhashtable_walk is interrupted with rhashtable_walk_stop(),
> + * it is often because an object was found that could not be processed
> + * immediately, possible because there is no more space to encode details
> + * of the object (e.g. when producing a seq_file from the table).
> + * When the walk is restarted, the same object needs to be processed again,
> + * if possible.  The object might have been removed from the table while
> + * the walk was paused, so it might not be available.  In that case, the
> + * normal "next" object should be treated as "current".
> + *
> + * To support this common case, rhashtable_walk_peek() returns the
> + * appropriate object to process after an interrupted walk, either the
> + * one that was most recently returned, or if that doesn't exist - the
> + * next one.
> + *
> + * Returns -EAGAIN if resize event occurred.  In that case the iterator
> + * will rewind back to the beginning and you may continue to use it.
> + */
> +static inline void *rhashtable_walk_peek(struct rhashtable_iter *iter)
> +{
> +       return rhashtable_walk_last_seen(iter) ?:
> +               rhashtable_walk_next(iter);
> +}
> +
>  void rhashtable_free_and_destroy(struct rhashtable *ht,
>                                  void (*free_fn)(void *ptr, void *arg),
>                                  void *arg);
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 45f2554399a5..354275037df3 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -915,40 +915,6 @@ void *rhashtable_walk_next(struct rhashtable_iter *iter)
>  }
>  EXPORT_SYMBOL_GPL(rhashtable_walk_next);
>
> -/**
> - * rhashtable_walk_peek - Return the next object but don't advance the iterator
> - * @iter:      Hash table iterator
> - *
> - * Returns the next object or NULL when the end of the table is reached.
> - *
> - * Returns -EAGAIN if resize event occurred.  Note that the iterator
> - * will rewind back to the beginning and you may continue to use it.
> - */
> -void *rhashtable_walk_peek(struct rhashtable_iter *iter)
> -{
> -       struct rhlist_head *list = iter->list;
> -       struct rhashtable *ht = iter->ht;
> -       struct rhash_head *p = iter->p;
> -
> -       if (p)
> -               return rht_obj(ht, ht->rhlist ? &list->rhead : p);
> -
> -       /* No object found in current iter, find next one in the table. */
> -
> -       if (iter->skip) {
> -               /* A nonzero skip value points to the next entry in the table
> -                * beyond that last one that was found. Decrement skip so
> -                * we find the current value. __rhashtable_walk_find_next
> -                * will restore the original value of skip assuming that
> -                * the table hasn't changed.
> -                */
> -               iter->skip--;
> -       }
> -
> -       return __rhashtable_walk_find_next(iter);
> -}
> -EXPORT_SYMBOL_GPL(rhashtable_walk_peek);
> -
>  /**
>   * rhashtable_walk_last_seen - Return the previously returned object, if available
>   * @iter:      Hash table iterator
> --
> 2.14.0.rc0.dirty
>
