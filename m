Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAD8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D312080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/KCPfWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D312080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbeKTIlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:41:37 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50986 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbeKTIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:41:36 -0500
Received: by mail-it1-f194.google.com with SMTP id a185so525710itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZA60v9JGvM3vbTrUvJ9DGgMp+pl+AqBEHCxNcp7Kzc=;
        b=K/KCPfWLSGlzqjklTm9LirDJErmK8mGBS1JVlogDi/P8L1URE6CljFcHPqlZxsmQRx
         M18MoFqCBzmAEBZ89bjOZjikEALfNL3PyPKES82XrghybHaa5uv4QEqO7aJK9pdorD6P
         6Gflj1LX/NNTRGLOA++rG1wg0viJKIp1By1tlAYru2khNb7OM46Cs7YCvkov9h6RV77A
         m3oDz1LCRzRm9dByjojIg7WY4xy8K2+uLeu1nNL01VDWxLhSkst7cNOXCZU+pd44Csxb
         YyvPwyyw8RvtKoVrGvVziUXbiUulaIl1XUI37RSz9ahbp40Q0cmeK6Ku+SISQcZhfjr3
         ywWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZA60v9JGvM3vbTrUvJ9DGgMp+pl+AqBEHCxNcp7Kzc=;
        b=uVnZQ9v7urVbWTfsTk3TyxhzRgHBj8Nfxa2/YEXP8R58UPCv2aNt7K3/3Q+XpFCMwF
         pQ+zOPo5IqcI03Yo0uuhclnLHNG0vix3z0WtGMn2z7MH9/AvvOlvvz4nHumbhs8FFex+
         WwBlwVKdChpJ5i3hl3Z7Z/05qmlCAgaHRgnXGaX55SyNkZXvtMNRketxjm1w7d8xGdoU
         vSGKms+mAxUqguB5Y6nXHO680AvwqMECqVIlPA2nTQYT6uFiIHc6sWttrrLtCXlcoYuo
         zyT+ZkQpU8wLCOH/rKTQlqo7eaRK5JL4q8i8mdWzQBoqwEeeJR3+jY02gTuCIJGYbIfI
         C/Cw==
X-Gm-Message-State: AGRZ1gIr6Ijoukqu+9iWTV0AT7+Z0gUWnRJC0JLEMaYsJgk90OjnbEH1
        Z/OAIYncaYnBl3LcyjrEim2acR4ziYnTfku3pw4=
X-Google-Smtp-Source: AFSGD/WbLg0kv9iWFdpW3EmLrYwlqFODd7xwbzeCRtDraD89VfClniOMlyD8NLswvT15JaN+jfHM3z1fg5LwmjEVqs4=
X-Received: by 2002:a24:5284:: with SMTP id d126mr9957434itb.91.1542665750709;
 Mon, 19 Nov 2018 14:15:50 -0800 (PST)
MIME-Version: 1.0
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
 <72215e75-6c7e-0aef-c06e-e3aba47cf806@suse.cz> <efb65160af41d0e18cb2dcb30c2fb86a@codeaurora.org>
 <97d8db4c-f117-8216-5f48-d5991692c867@suse.cz>
In-Reply-To: <97d8db4c-f117-8216-5f48-d5991692c867@suse.cz>
From:   Wei Yang <richard.weiyang@gmail.com>
Date:   Tue, 20 Nov 2018 06:15:39 +0800
Message-ID: <CADZGycYeB_sZmsFJ-RV5LQavHZNJTv1_pTrnpRjs7owhYSNKSA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] memory_hotplug: Free pages as higher order
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     arunks@codeaurora.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, jgross@suse.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>, iamjoonsoo.kim@lge.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Mathieu Malaterre <malat@debian.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jrdr.linux@gmail.com, Yasuaki Ishimatsu <yasu.isimatu@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>, aaron.lu@intel.com,
        devel@linuxdriverproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, xen-devel@lists.xenproject.org,
        vatsa@codeaurora.org, Vinayak Menon <vinmenon@codeaurora.org>,
        getarunks@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 6:05 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/10/18 6:56 PM, Arun KS wrote:
> > On 2018-10-10 21:00, Vlastimil Babka wrote:
> >> On 10/5/18 10:10 AM, Arun KS wrote:
> >>> When free pages are done with higher order, time spend on
> >>> coalescing pages by buddy allocator can be reduced. With
> >>> section size of 256MB, hot add latency of a single section
> >>> shows improvement from 50-60 ms to less than 1 ms, hence
> >>> improving the hot add latency by 60%. Modify external
> >>> providers of online callback to align with the change.
> >>>
> >>> Signed-off-by: Arun KS <arunks@codeaurora.org>
> >>
> >> [...]
> >>
> >>> @@ -655,26 +655,44 @@ void __online_page_free(struct page *page)
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(__online_page_free);
> >>>
> >>> -static void generic_online_page(struct page *page)
> >>> +static int generic_online_page(struct page *page, unsigned int order)
> >>>  {
> >>> -   __online_page_set_limits(page);
> >>
> >> This is now not called anymore, although the xen/hv variants still do
> >> it. The function seems empty these days, maybe remove it as a followup
> >> cleanup?
> >>
> >>> -   __online_page_increment_counters(page);
> >>> -   __online_page_free(page);
> >>> +   __free_pages_core(page, order);
> >>> +   totalram_pages += (1UL << order);
> >>> +#ifdef CONFIG_HIGHMEM
> >>> +   if (PageHighMem(page))
> >>> +           totalhigh_pages += (1UL << order);
> >>> +#endif
> >>
> >> __online_page_increment_counters() would have used
> >> adjust_managed_page_count() which would do the changes under
> >> managed_page_count_lock. Are we safe without the lock? If yes, there
> >> should perhaps be a comment explaining why.
> >
> > Looks unsafe without managed_page_count_lock. I think better have a
> > similar implementation of free_boot_core() in memory_hotplug.c like we
> > had in version 1 of patch. And use adjust_managed_page_count() instead
> > of page_zone(page)->managed_pages += nr_pages;
> >
> > https://lore.kernel.org/patchwork/patch/989445/
>
> Looks like deferred_free_range() has the same problem calling
> __free_pages_core() to adjust zone->managed_pages. I expect
> __free_pages_bootmem() is OK because at that point the system is still
> single-threaded?
> Could be solved by moving that out of __free_pages_core().
>

Seems deferred_free_range() is protected by
pgdat_resize_lock()/pgdat_resize_unlock().

Which protects pgdat's zones, if I am right.

> But do we care about readers potentially seeing a store tear? If yes
> then maybe these counters should be converted to atomics...
>
> > -static void generic_online_page(struct page *page)
> > +static int generic_online_page(struct page *page, unsigned int order)
> >   {
> > -     __online_page_set_limits(page);
> > -     __online_page_increment_counters(page);
> > -     __online_page_free(page);
> > +     unsigned long nr_pages = 1 << order;
> > +     struct page *p = page;
> > +
> > +     for (loop = 0 ; loop < nr_pages ; loop++, p++) {
> > +             __ClearPageReserved(p);
> > +             set_page_count(p, 0);
> > +     }
> > +
> > +     adjust_managed_page_count(page, nr_pages);
> > +     set_page_refcounted(page);
> > +     __free_pages(page, order);
> > +
> > +     return 0;
> > +}
> >
> >
> > Regards,
> > Arun
> >
>
