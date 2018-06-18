Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75A7C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6425620693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utofY43n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6425620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755471AbeFRWB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:01:59 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34187 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754256AbeFRWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:01:57 -0400
Received: by mail-lf0-f66.google.com with SMTP id v84-v6so3838610lfa.1;
        Mon, 18 Jun 2018 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/wQt4x5Mq6ZG/doggWKxS7cNxk9mtcKJx80Jx3+tyA=;
        b=utofY43nC4dbg16Fm0kS9NEb5KjkJmATLTGuGlEeQ15mlEP5b/7o5rH7xundW0/WZa
         d3uT4s30RmoQ2lP6dLcBCAMGrun+hO+afOQ31378KyD8UrJ01h8RqVLIl7A0sI3giLqS
         rRJFOCEyW7rjvZcgXeOA78lq56331JE8zD+gcaJHOPXQZ4e50fYYcG5vh8Kmx2irwNDC
         bdOjZxFZ6f+yHO4Np6kAuOqVNXdDMClQSkAOOHHf8/0XqhCHhJo6F2c1mzku9NGLy5TG
         aF82CMcVOhNC6wl2jM9NCiTHCp5Fc/14KseC0RPegYewoGvG6GemiOGZHDTbc/zVnKAx
         HRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/wQt4x5Mq6ZG/doggWKxS7cNxk9mtcKJx80Jx3+tyA=;
        b=bOgJltUPDxBy+rq/6R+TM750zfTAwhkYv0JrJvF6r+pygzdfpNV0NnC5LVlK5WssIe
         N9E+Dhnacszxln3nFoRCNcOY/M8IqdE9KGmgFtQlPXpzfL3binsUgS8OSqXj1rfqR6Dx
         B+6Cfwf8MeNj8m+F99sWdpzjjaZjow9Vi6hmCmY2s6n/c+nAUyc3az1xEF4sOTYxsbn9
         zlU8bc8DPQy8AhTiUcfuEQfXwnVUk5aXmgMtPRZPcDJb6RaNfPUhNjpvW+bPM70euF7+
         FTy0ji93GrJwwFq7sJz+MOIJ2pGpd+ZxaEev/nd9RImN4gWFTFYfJu4Gr/akN5iLCfzy
         Z5zA==
X-Gm-Message-State: APt69E05NmwJ5ClSdz0undpYe8nuJyYYRzdLfmXRdHzuPoUR4xLMRPZV
        8tuIKqtMnspoiezYMEUD+9nG4eiJpwcEcoDLGm4=
X-Google-Smtp-Source: ADUXVKKH3o2lQMlaYxq9dhpT4OZiJ13K7HDDKtbQiw74mKqFGnn6TX8Kn1kRvIBii8kS05PI4XvE/0CdIcxD/8iLbaE=
X-Received: by 2002:a19:5a14:: with SMTP id o20-v6mr4622019lfb.105.1529359315304;
 Mon, 18 Jun 2018 15:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
 <20180618131003.88110-4-andriy.shevchenko@linux.intel.com> <20180618141404.68124daab97bd0f3a3051544@linux-foundation.org>
In-Reply-To: <20180618141404.68124daab97bd0f3a3051544@linux-foundation.org>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon, 18 Jun 2018 15:01:43 -0700
Message-ID: <CAKdAkRTHOORds7aEauv4rp3_=PnGi=Nv-VS3-nAb9MztJPKG=Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        agk@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        shli@kernel.org, linux-raid@vger.kernel.org,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        ynorov@caviumnetworks.com, lkml <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 2:14 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 18 Jun 2018 16:10:01 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > A lot of code become ugly because of open coding allocations for bitmaps.
> >
> > Introduce three helpers to allow users be more clear of intention
> > and keep their code neat.
> >
> > ...
> >
> > +unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
> > +{
> > +     return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), flags);
> > +}
> > +EXPORT_SYMBOL(bitmap_alloc);
> > +
> > +unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags)
> > +{
> > +     return bitmap_alloc(nbits, flags | __GFP_ZERO);
> > +}
> > +EXPORT_SYMBOL(bitmap_zalloc);
> > +
> > +void bitmap_free(const unsigned long *bitmap)
> > +{
> > +     kfree(bitmap);
> > +}
> > +EXPORT_SYMBOL(bitmap_free);
> > +
>
> I suggest these functions are small and simple enough to justify
> inlining them.
>

We can't as we end up including bitmap.h (by the way of cpumask.h)
form slab.h, so we gen circular dependency. Maybe if we removed memcg
stuff from slab.h so we do not need to include workqueue.h...

-- 
Dmitry
