Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85089C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A332170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Vw2qj55D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A332170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ieee.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbeI1RzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:55:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34227 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbeI1RzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:55:15 -0400
Received: by mail-io1-f67.google.com with SMTP id h16-v6so3992697ioj.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 04:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFBDtUPBV1V5HLZsktWP88rJk+6AC328fc0bVHuNypk=;
        b=Vw2qj55DkddwiiiDUcVBw7IZJyfwpfV8ApjFH/xI4tt5xE+bdZgkpyMyGmrY6epuhZ
         jsYVGnvJCXGs11p/9BNXMZABLv1SYcM/853H5jL2Q8qY2gvFDh4wKPqTGbZZ6f3B9/KU
         I7zdBWJ7f4WdNHlYR85Ez/+nJqr5hM6GtwchY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFBDtUPBV1V5HLZsktWP88rJk+6AC328fc0bVHuNypk=;
        b=pFyor/k1sM1kj69F643YO6w7SypYH+HLiT42wk/vyDrsGlUcHesCn9TIt5NFpgvn3w
         iG2plz7SxAgHwNwSXV/vnhzIaPxnDbg9HkSlp4/SmIKsYYW0ZKduJx65PE+vUYcfE/kv
         tAqfBvabMUl4iIT0PG52QOhks3p0rbRECo6Bv7XdQg3izQKfIvENJ+K3fhxmJMj7leuQ
         KOIPPgogBfY1e9DfPcL+Bl270kmeKL4NiFNYFzAPpcOj4SDqCem2wNj3n7J77ERLz14W
         i41NYJsJbmEYsXrMeCNBSPD0VU4XexJr6EkNVjj0X27HCl8t6+hutR/YNSR56UPEADmy
         O43A==
X-Gm-Message-State: ABuFfoiEczNHKq+8EqWOmql8nBIcm7QiP+ByBz5rfiiiw//YbvX8DFQJ
        aLYv/LjDfu3l1okJIzv+yq9jjRsg2zsrSd4wBlA=
X-Google-Smtp-Source: ACcGV627uodCNvP2ta9d81k1Y7r/rkbSebTMqRW4rapPpO0r46XWDC9fGDjuhSw5nbslQqVY+5yGVm2RMk1PP1yYnkM=
X-Received: by 2002:a6b:671c:: with SMTP id b28-v6mr11071674ioc.22.1538134315156;
 Fri, 28 Sep 2018 04:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <1538079759.qxp8zh3nwh.astroid@alex-archsus.none>
 <CALZtONA9r6=gnK-5a++tjaReqEnRzrBb3hzYMTFNXZ13z+UOWQ@mail.gmail.com>
 <153808275043.724.15980761008814866300@pink.alxu.ca> <1538082779.246sm0vb2p.astroid@alex-archsus.none>
In-Reply-To: <1538082779.246sm0vb2p.astroid@alex-archsus.none>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Fri, 28 Sep 2018 07:31:18 -0400
Message-ID: <CALZtONBUR2X8hLG59=JitZqAr0aOO+TWkf6Reke9DHkVu-9_wQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: fix z3fold warnings on CONFIG_SMP=n
To:     alex_y_xu@yahoo.ca, Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 5:15 PM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>
> Spinlocks are always lockable on UP systems, even if they were just
> locked.
>
> Cc: Dan Streetman <ddstreet@ieee.org>

I cc'ed Vitaly also, as this code is from him, but the change
certainly looks correct to me.

Acked-by: Dan Streetman <ddstreet@ieee.org>

> Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> ---
>  mm/z3fold.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 4b366d181..2e8d268ac 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -277,7 +277,7 @@ static void release_z3fold_page_locked(struct kref *ref)
>  {
>         struct z3fold_header *zhdr = container_of(ref, struct z3fold_header,
>                                                 refcount);
> -       WARN_ON(z3fold_page_trylock(zhdr));
> +       WARN_ON_SMP(z3fold_page_trylock(zhdr));
>         __release_z3fold_page(zhdr, true);
>  }
>
> @@ -289,7 +289,7 @@ static void release_z3fold_page_locked_list(struct kref *ref)
>         list_del_init(&zhdr->buddy);
>         spin_unlock(&zhdr->pool->lock);
>
> -       WARN_ON(z3fold_page_trylock(zhdr));
> +       WARN_ON_SMP(z3fold_page_trylock(zhdr));
>         __release_z3fold_page(zhdr, true);
>  }
>
> @@ -403,7 +403,7 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
>
>         page = virt_to_page(zhdr);
>         if (locked)
> -               WARN_ON(z3fold_page_trylock(zhdr));
> +               WARN_ON_SMP(z3fold_page_trylock(zhdr));
>         else
>                 z3fold_page_lock(zhdr);
>         if (WARN_ON(!test_and_clear_bit(NEEDS_COMPACTING, &page->private))) {
> --
> 2.19.0
>
