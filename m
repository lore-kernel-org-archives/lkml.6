Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61027C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF66218FC
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJ1SbOCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfABQBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:01:35 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46384 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbfABQBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:01:34 -0500
Received: by mail-io1-f68.google.com with SMTP id v10so24824848ios.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 08:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsVRfe43oyzUo0Yy9DI1Z23iK9Sm0kuPZkg3XZE1K0s=;
        b=lJ1SbOCQmCiSje2wR9gDYU1HImajNSDmeWnXTZO5rCoBsAlIhL4aDeULEZHby+kCZt
         Dy7MEnhOAlOmcrdzKNRaCiaQFjh+90KMFzwgkHcPcgP0vVE6+k/Ekmadn3AxXZsfpo74
         W1jpRUgSVXtIdhdK+XjvwIGgBqxCVbFQMV3tUFTXzqTjEpWLQukp6dkO1vI0IhiUwy0K
         j2AkiHfDOSen9OICBmdzi2Nrj2KO03eQ+XJcRQUzxCVa87quMvaBrEOvlAn0xUXqZziV
         EUDoESsy1dyF/Xy2ETa3z9veco5gNMNIbOmJnmCg9052AChJeJ1NnNEbIrqgD+cSZqyi
         /6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsVRfe43oyzUo0Yy9DI1Z23iK9Sm0kuPZkg3XZE1K0s=;
        b=rww7bdf8yOoyiXY5LuFNU+qkiJs/gWu9ovuLQdiwNHmtS+C2F7ONyXHlz0x8AsFTQK
         cBfjqb3dgqm4REwIZ/tXRzCyddjFJ/4AC5ZbdkQg2OWs7QNsoyqGjJo2FR/PT5P3Dvty
         r3XSG6ChO4DyUE821kdqSTk/MbrUMqKDhtW0u9mHGd/TluBCmoFx0tVH71yM9JO4Cbax
         UIic4+e1PHD80PXi7jE/UfwDrDbhOwZ/B9lCRlUYGT8ryROjwpkFKp5Z6fl5WEYqX+AG
         qXUvW4mDo1DBKYbI4F+rCrzHxgdeVFjztOV1gTV7slLjlx8NLHbyDhUfgvLHJ6gImiHp
         dFJA==
X-Gm-Message-State: AJcUukfJkEI3nxd1ZsGaIWBfVh8j8CZ9dR1GI1TsP2X4eABqVtUIqPZs
        Uvq0v2B4xYpz5CvEu09P9sLQLpFvOdYtf3urIVtgHY9xFMCXHQ==
X-Google-Smtp-Source: ALg8bN5HLgXn+wb+8Pq1yMVD3WdxS30aST5R0S/BK5ebSCAS1pFN7ptXkkqcqVeJcWYGFT/TRkHUdHcnYC68YJmJM1U=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr30920702iom.11.1546444891786;
 Wed, 02 Jan 2019 08:01:31 -0800 (PST)
MIME-Version: 1.0
References: <0000000000000f35c6057e780d36@google.com> <CACT4Y+ZECp8Ymq=0QUNfwmfpQvWkBpoMgyUCuz0M=peehEeCHw@mail.gmail.com>
 <010001680f42f192-82b4e12e-1565-4ee0-ae1f-1e98974906aa-000000@email.amazonses.com>
In-Reply-To: <010001680f42f192-82b4e12e-1565-4ee0-ae1f-1e98974906aa-000000@email.amazonses.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 2 Jan 2019 17:01:20 +0100
Message-ID: <CACT4Y+Z8M+ODKobZYzWBbPv_y_Y2xNBfuUuX7iVceeLap2Yq3g@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in setup_kmem_cache_node
To:     Christopher Lameter <cl@linux.com>
Cc:     syzbot <syzbot+d6ed4ec679652b4fd4e4@syzkaller.appspotmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Miller <davem@davemloft.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net,
        Linux-MM <linux-mm@kvack.org>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 4:51 PM Christopher Lameter <cl@linux.com> wrote:
>
> On Wed, 2 Jan 2019, Dmitry Vyukov wrote:
>
> > Am I missing something or __alloc_alien_cache misses check for
> > kmalloc_node result?
> >
> > static struct alien_cache *__alloc_alien_cache(int node, int entries,
> >                                                 int batch, gfp_t gfp)
> > {
> >         size_t memsize = sizeof(void *) * entries + sizeof(struct alien_cache);
> >         struct alien_cache *alc = NULL;
> >
> >         alc = kmalloc_node(memsize, gfp, node);
> >         init_arraycache(&alc->ac, entries, batch);
> >         spin_lock_init(&alc->lock);
> >         return alc;
> > }
> >
>
>
> True _alloc_alien_cache() needs to check for NULL
>
>
> From: Christoph Lameter <cl@linux.com>
> Subject: slab: Alien caches must not be initialized if the allocation of the alien cache failed
>
> Callers of __alloc_alien() check for NULL.
> We must do the same check in __alloc_alien_cache to avoid NULL pointer dereferences
> on allocation failures.
>
> Signed-off-by: Christoph Lameter <cl@linux.com>

Please add:
Reported-by: syzbot+d6ed4ec679652b4fd4e4@syzkaller.appspotmail.com

> Index: linux/mm/slab.c
> ===================================================================
> --- linux.orig/mm/slab.c
> +++ linux/mm/slab.c
> @@ -666,8 +666,10 @@ static struct alien_cache *__alloc_alien
>         struct alien_cache *alc = NULL;
>
>         alc = kmalloc_node(memsize, gfp, node);
> -       init_arraycache(&alc->ac, entries, batch);
> -       spin_lock_init(&alc->lock);
> +       if (alc) {
> +               init_arraycache(&alc->ac, entries, batch);
> +               spin_lock_init(&alc->lock);
> +       }
>         return alc;
>  }
>
