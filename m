Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56341C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D65020693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bScAigkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D65020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754113AbeFTBYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:24:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40059 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753995AbeFTBYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:24:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id n5-v6so3657548wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 18:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SBNOy/WkQTQB5iEfr6BkcMUw1BWpxRZj8da7nWaCGyU=;
        b=bScAigkGH2QLWE0CcTsg6Ht8QhLXJ8OdlmQg1kTNZurqk6rkLWTn8tnuoTjT+TAwJZ
         IGKb6yVUt5h/QhWko8GBzibdIlyamWJOFamSjFoZajxANfc7C9d/ErrIDJTUCMFbdioz
         dobCFWx9DpXok36S8GO6rs14bgsOnRHonSHBpsnIM6pKAh+WqcD82MK98pkGDsnaa/wm
         W3IMxRRDfHPSjEb1EvV/2eloqbInrmeZNJJBH7syQGIMG/QC2ZzjQ4mp4HZOwzkC/mRC
         Dj5gd8ZybKtqo3fLK83mMrkF/KsZvEYOSyon70hSaLYiG5L0w0jVvsnAtapMNZUzWUvs
         AMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBNOy/WkQTQB5iEfr6BkcMUw1BWpxRZj8da7nWaCGyU=;
        b=pSwLeoopwdClPlOS9x9wKPS4QuEzdNMDwCVtssbc6TiUXy9DicMaXy33e1TzAHzoNk
         EI83QVBr12E9JwqZZ+d1heIceAsTGIG0oPxeEarQ+95wsNSY9E/2Gm9kco09TWgEXYW6
         ATAs9u8YPOuZi6Bi3fSl3WtXPep2KmGaRNASoqPPdBWI6uJhjq76qaI/ThlfO4OQHGkC
         jm7yMZXXprfN8ZpwIsMUvKEUgKoeW6+NbsQtqXMIzeaRG5SFERpocGi6L7pnK62U8Kgx
         ETdSmpAUkKPJolSVzTqK3RsLG4QmCeS4yIRwniKbYzMTp5qvYnKCB2QTd0daWtrq+kqA
         8Fhg==
X-Gm-Message-State: APt69E3BPO081I48BOf7MLkwhM5Q9vrNdCL5avp1QTf7RrlmBgsjhk+r
        UdsXtcnarxer3Ci0XWE9bp5XB2uJU6GJB9XV/mFYQA==
X-Google-Smtp-Source: ADUXVKLDbRLyHOloufNU4e/t9fm+J6v13fnkHUW5jujMstjDjPInAeODIv7lpBRGFZg671nRhVbtLOmHwW1StiEeVJw=
X-Received: by 2002:a1c:1c8f:: with SMTP id c137-v6mr20765wmc.142.1529457884924;
 Tue, 19 Jun 2018 18:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180619213352.71740-1-shakeelb@google.com> <alpine.DEB.2.21.1806191748040.25812@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1806191748040.25812@chino.kir.corp.google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 19 Jun 2018 18:24:32 -0700
Message-ID: <CALvZod7A+QC5OqYNx-kQcJYOQmeSm8ie9JGnh3_-CUfYn7jpOA@mail.gmail.com>
Subject: Re: [PATCH] slub: fix __kmem_cache_empty for !CONFIG_SLUB_DEBUG
To:     David Rientjes <rientjes@google.com>
Cc:     Jason@zx2c4.com, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 5:49 PM David Rientjes <rientjes@google.com> wrote:
>
> On Tue, 19 Jun 2018, Shakeel Butt wrote:
>
> > diff --git a/mm/slub.c b/mm/slub.c
> > index a3b8467c14af..731c02b371ae 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3673,9 +3673,23 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
> >
> >  bool __kmem_cache_empty(struct kmem_cache *s)
> >  {
> > -     int node;
> > +     int cpu, node;
>
> Nit: wouldn't cpu be unused if CONFIG_SLUB_DEBUG is disabled?
>

I think I didn't get the warning as I didn't use #ifdef.

> >       struct kmem_cache_node *n;
> >
> > +     /*
> > +      * slabs_node will always be 0 for !CONFIG_SLUB_DEBUG. So, manually
> > +      * check slabs for all cpus.
> > +      */
> > +     if (!IS_ENABLED(CONFIG_SLUB_DEBUG)) {
> > +             for_each_online_cpu(cpu) {
> > +                     struct kmem_cache_cpu *c;
> > +
> > +                     c = per_cpu_ptr(s->cpu_slab, cpu);
> > +                     if (c->page || slub_percpu_partial(c))
> > +                             return false;
> > +             }
> > +     }
> > +
> >       for_each_kmem_cache_node(s, node, n)
> >               if (n->nr_partial || slabs_node(s, node))
> >                       return false;
>
> Wouldn't it just be better to allow {inc,dec}_slabs_node() to adjust the
> nr_slabs counter instead of doing the per-cpu iteration on every shutdown?

Yes that is doable as the functions {inc,dec}_slabs_node() are called
in slow path. I can move them out of CONFIG_SLUB_DEBUG. I think the
reason 0f389ec63077 ("slub: No need for per node slab counters if
!SLUB_DEBUG") put them under CONFIG_SLUB_DEBUG is because these
counters were only read through sysfs API which were disabled on
!CONFIG_SLUB_DEBUG. However we have a usecase other than sysfs API.

Please let me know if there is any objection to this conversion. For
large machines I think this is preferable approach.

thanks,
Shakeel
