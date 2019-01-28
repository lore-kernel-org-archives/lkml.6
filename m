Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45248C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096462177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWzqcoJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfA1UGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:06:38 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42716 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1UGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:06:38 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so19744017qtq.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 12:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOevpI4M7TBAYwZIdw3A2sHMSBaHAS6nG5olNgvrJrU=;
        b=JWzqcoJ7dNiiTOA+E70etwOz35fnrFBgRnmhM4iwB2jqvkRACtLKkVYmsGO7K0zCoY
         yqYK21FFkkkgzpJifry0Pi21PJYh8227IsBQ7wbxPRv3EzJRRZRZC76KrllI68zpKhBL
         I5yXT/mtx9YzguCxXsXY7XHOVACmCN8f9Ti4m4Hn/DqebWRU5evoSKZZxfeIyWENltv4
         Sx+m54nAEDAwyl3cNpXr3M7D/g3kOuSD836ic7geyV6vpemzJDVfpkjzawmgDktbxXcg
         YfkT4X1IxGBbukaZFGDHi1vi57S7LzkbN/TQY4RzSeMLxYvOmUQZXORRpJ5Hfztu4KRn
         vQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOevpI4M7TBAYwZIdw3A2sHMSBaHAS6nG5olNgvrJrU=;
        b=lCCp+4BkdjT0Ic4ZHUn7TmXq0J/Kd0aecOIvQwUKn4x3AL2AEbYPeJ7dpFWiFDanGx
         ul84vSyRtlZTCX778hsLQQxiZoZOgn9Zzz8/J1eNQf8YCMPfobcUdxzlRDimDv+9kdrm
         L+/kfCCMpP4xVXDo594KyOK6WznMFbkmhSjV0FVOXcKQ3ORp6uzuZ2mJggtfuRf1+maI
         7ww1hfXLSxP7w7ZyNuULvZP5zjixz9slAJKdEQqkTKMcr3Q9TQWRz8yEyaDlrHx+GlS8
         ZMkbYqXk2HlbylEdTysY3AFOy0AQkIYL5ds3VUbELFBFbQlx+zQk+Ojm7t5+cdaj0BHV
         ODiA==
X-Gm-Message-State: AJcUukcj+rClRxY6t8w3Q6Iy+3NchI/Up5/SRgo8kVghdcYSuMCB4/lM
        XAjxXc9y2y7hSZWNQWA8FHWH9uVoNzh5YSint8Q=
X-Google-Smtp-Source: ALg8bN7fU5qtnrXSFdOLmXgE+D7issUC2/0LNN2b/ZereP292vUTnMQQlHmx8OowjZIvngQ76guEPlSTPFdrg0se/2A=
X-Received: by 2002:ac8:c7:: with SMTP id d7mr22249791qtg.326.1548705997075;
 Mon, 28 Jan 2019 12:06:37 -0800 (PST)
MIME-Version: 1.0
References: <1548287573-15084-1-git-send-email-yang.shi@linux.alibaba.com> <aecc642c-d485-ed95-7935-19cda48800bc@nvidia.com>
In-Reply-To: <aecc642c-d485-ed95-7935-19cda48800bc@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 28 Jan 2019 12:06:25 -0800
Message-ID: <CAHbLzkqTZK05g0191dKyTXGDcAuqMi9AGWPHbAEysQdgT7ayBQ@mail.gmail.com>
Subject: Re: [v2 PATCH] mm: ksm: do not block on page lock when searching
 stable tree
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, hughd@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Sorry for the late reply. It seems your email didn't reach my company
mailbox. So, I replied you with my personal email.

Thanks for your suggestion. This does make the code looks neater.
However, I'm not sure how Andrew thought about this patch. Once he is
ok to this patch in overall, I will update v3 by following your
suggestion.

Regards,
Yang


On Wed, Jan 23, 2019 at 4:24 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 1/23/19 3:52 PM, Yang Shi wrote:
> > ksmd need search stable tree to look for the suitable KSM page, but the
> > KSM page might be locked for a while due to i.e. KSM page rmap walk.
> > Basically it is not a big deal since commit 2c653d0ee2ae
> > ("ksm: introduce ksm_max_page_sharing per page deduplication limit"),
> > since max_page_sharing limits the number of shared KSM pages.
> >
> > But it still sounds not worth waiting for the lock, the page can be skip,
> > then try to merge it in the next scan to avoid potential stall if its
> > content is still intact.
> >
> > Introduce async mode to get_ksm_page() to not block on page lock, like
> > what try_to_merge_one_page() does.
> >
> > Return -EBUSY if trylock fails, since NULL means not find suitable KSM
> > page, which is a valid case.
> >
> > With the default max_page_sharing setting (256), there is almost no
> > observed change comparing lock vs trylock.
> >
> > However, with ksm02 of LTP, the reduced ksmd full scan time can be
> > observed, which has set max_page_sharing to 786432.  With lock version,
> > ksmd may tak 10s - 11s to run two full scans, with trylock version ksmd
> > may take 8s - 11s to run two full scans.  And, the number of
> > pages_sharing and pages_to_scan keep same.  Basically, this change has
> > no harm.
> >
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > ---
> > Hi folks,
> >
> > This patch was with "mm: vmscan: skip KSM page in direct reclaim if priority
> > is low" in the initial submission.  Then Hugh and Andrea pointed out commit
> > 2c653d0ee2ae ("ksm: introduce ksm_max_page_sharing per page deduplication
> > limit") is good enough for limiting the number of shared KSM page to prevent
> > from softlock when walking ksm page rmap.  This commit does solve the problem.
> > So, the series was dropped by Andrew from -mm tree.
> >
> > However, I thought the second patch (this one) still sounds useful.  So, I did
> > some test and resubmit it.  The first version was reviewed by Krill Tkhai, so
> > I keep his Reviewed-by tag since there is no change to the patch except the
> > commit log.
> >
> > So, would you please reconsider this patch?
> >
> > v2: Updated the commit log to reflect some test result and latest discussion
> >
> >  mm/ksm.c | 29 +++++++++++++++++++++++++----
> >  1 file changed, 25 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 6c48ad1..f66405c 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -668,7 +668,7 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
> >  }
> >
> >  /*
> > - * get_ksm_page: checks if the page indicated by the stable node
> > + * __get_ksm_page: checks if the page indicated by the stable node
> >   * is still its ksm page, despite having held no reference to it.
> >   * In which case we can trust the content of the page, and it
> >   * returns the gotten page; but if the page has now been zapped,
> > @@ -686,7 +686,8 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
> >   * a page to put something that might look like our key in page->mapping.
> >   * is on its way to being freed; but it is an anomaly to bear in mind.
> >   */
> > -static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
> > +static struct page *__get_ksm_page(struct stable_node *stable_node,
> > +                                bool lock_it, bool async)
> >  {
> >       struct page *page;
> >       void *expected_mapping;
> > @@ -729,7 +730,14 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
> >       }
> >
> >       if (lock_it) {
> > -             lock_page(page);
> > +             if (async) {
> > +                     if (!trylock_page(page)) {
> > +                             put_page(page);
> > +                             return ERR_PTR(-EBUSY);
> > +                     }
> > +             } else
> > +                     lock_page(page);
> > +
> >               if (READ_ONCE(page->mapping) != expected_mapping) {
> >                       unlock_page(page);
> >                       put_page(page);
> > @@ -752,6 +760,11 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
> >       return NULL;
> >  }
> >
> > +static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
> > +{
> > +     return __get_ksm_page(stable_node, lock_it, false);
> > +}
> > +
> >  /*
> >   * Removing rmap_item from stable or unstable tree.
> >   * This function will clean the information from the stable/unstable tree.
> > @@ -1673,7 +1686,11 @@ static struct page *stable_tree_search(struct page *page)
> >                        * It would be more elegant to return stable_node
> >                        * than kpage, but that involves more changes.
> >                        */
> > -                     tree_page = get_ksm_page(stable_node_dup, true);
> > +                     tree_page = __get_ksm_page(stable_node_dup, true, true);
>
> Hi Yang,
>
> The bools are stacking up: now you've got two, and the above invocation is no longer
> understandable on its own. At this point, we normally shift to flags and/or an
> enum.
>
> Also, I see little value in adding a stub function here, so how about something more
> like the following approximation (untested, and changes to callers are not shown):
>
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 6c48ad13b4c9..8390b7905b44 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -667,6 +667,12 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
>         free_stable_node(stable_node);
>  }
>
> +typedef enum {
> +       GET_KSM_PAGE_NORMAL,
> +       GET_KSM_PAGE_LOCK_PAGE,
> +       GET_KSM_PAGE_TRYLOCK_PAGE
> +} get_ksm_page_t;
> +
>  /*
>   * get_ksm_page: checks if the page indicated by the stable node
>   * is still its ksm page, despite having held no reference to it.
> @@ -686,7 +692,8 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
>   * a page to put something that might look like our key in page->mapping.
>   * is on its way to being freed; but it is an anomaly to bear in mind.
>   */
> -static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
> +static struct page *get_ksm_page(struct stable_node *stable_node,
> +                                get_ksm_page_t flags)
>  {
>         struct page *page;
>         void *expected_mapping;
> @@ -728,8 +735,17 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
>                 goto stale;
>         }
>
> -       if (lock_it) {
> +       if (flags == GET_KSM_PAGE_TRYLOCK_PAGE) {
> +               if (!trylock_page(page)) {
> +                       put_page(page);
> +                       return ERR_PTR(-EBUSY);
> +               }
> +       } else if (flags == GET_KSM_PAGE_LOCK_PAGE) {
>                 lock_page(page);
> +       }
> +
> +       if (flags == GET_KSM_PAGE_LOCK_PAGE ||
> +           flags == GET_KSM_PAGE_TRYLOCK_PAGE) {
>                 if (READ_ONCE(page->mapping) != expected_mapping) {
>                         unlock_page(page);
>                         put_page(page);
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> > +
> > +                     if (PTR_ERR(tree_page) == -EBUSY)
> > +                             return ERR_PTR(-EBUSY);
> > +
> >                       if (unlikely(!tree_page))
> >                               /*
> >                                * The tree may have been rebalanced,
> > @@ -2060,6 +2077,10 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
> >
> >       /* We first start with searching the page inside the stable tree */
> >       kpage = stable_tree_search(page);
> > +
> > +     if (PTR_ERR(kpage) == -EBUSY)
> > +             return;
> > +
> >       if (kpage == page && rmap_item->head == stable_node) {
> >               put_page(kpage);
> >               return;
> >
>
