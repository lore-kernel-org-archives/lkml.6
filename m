Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D3EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ED520852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fizpQW9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59ED520852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeGYC4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:56:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49876 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbeGYC4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:56:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6P1cnwp166089
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 01:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=XEDFTGpB2oa7uBKsdYbPr+VrohdEFxF0DkH14ePUEz0=;
 b=fizpQW9eD0XN0Caeh3RNJiM7a6FgJYCqouYLkq7wZ2bgDmKGi3k58zdjYf3G4HH8Q6eZ
 Tt441WE+UkJcxFtm2KUdzKJHI5+c/l5NR0jKOp4/OLisrxqLwLh6hGzsTDucHDjNEXLz
 /bnLvp7fDh8INcLlDyriRmCg1nPlJ2Ifz+G5L4afa4Fcg0N+7HjX8CkT9wOfIotHAo47
 MPKnsPnYLqIIjXITVWwijC6zVRBi4OeHwUrfqrHAd7BvTCAa5hueL5hcdTvvzNc3Wmhy
 ItzW2NaaMy8l8uvugDIW7dzCjOcw7gTvK+EjEwKL9JVpNQm6aqojR5ACcqWiHorZOhqY ug== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2kbv8t3evc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 01:47:04 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6P1l2dE011659
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 01:47:03 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6P1l207016931
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 01:47:02 GMT
Received: from mail-oi0-f54.google.com (/209.85.218.54)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Jul 2018 18:47:02 -0700
Received: by mail-oi0-f54.google.com with SMTP id b15-v6so11048770oib.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 18:47:01 -0700 (PDT)
X-Gm-Message-State: AOUpUlGqk3UpcrpLQaWyKt4xFqx07jDPa74V7trDj3rzGCIjUSYxpJwI
        ry/y1rYZIql+XfiE6j0C+TTppX2izk3Q/jb2qS4=
X-Google-Smtp-Source: AAOMgpdkvQnAJFlsB4nxXakWLioF7sTepls0zWrjY9H9/7E4sxGDSx77HDS40Zr80i9pE3wK3oafIPEPETydx/iGyTY=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr1248018oig.221.1532483221487;
 Tue, 24 Jul 2018 18:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180724235520.10200-1-pasha.tatashin@oracle.com>
 <20180724235520.10200-3-pasha.tatashin@oracle.com> <20180724183142.d20798b43fd1215f6165649c@linux-foundation.org>
In-Reply-To: <20180724183142.d20798b43fd1215f6165649c@linux-foundation.org>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 24 Jul 2018 21:46:25 -0400
X-Gmail-Original-Message-ID: <CAGM2reb4vT59uUkMkJVBx9-GEYQs287oTG08aRwKtjfJ1BVrjA@mail.gmail.com>
Message-ID: <CAGM2reb4vT59uUkMkJVBx9-GEYQs287oTG08aRwKtjfJ1BVrjA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: calculate deferred pages after skipping mirrored memory
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>, bhe@redhat.com,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 9:31 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 24 Jul 2018 19:55:19 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
>
> > update_defer_init() should be called only when struct page is about to be
> > initialized. Because it counts number of initialized struct pages, but
> > there we may skip struct pages if there is some mirrored memory.
> >
> > So move, update_defer_init() after checking for mirrored memory.
> >
> > Also, rename update_defer_init() to defer_init() and reverse the return
> > boolean to emphasize that this is a boolean function, that tells that the
> > reset of memmap initialization should be deferred.
> >
> > Make this function self-contained: do not pass number of already
> > initialized pages in this zone by using static counters.
> >
> > ...
> >
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -306,24 +306,28 @@ static inline bool __meminit early_page_uninitialised(unsigned long pfn)
> >  }
> >
> >  /*
> > - * Returns false when the remaining initialisation should be deferred until
> > + * Returns true when the remaining initialisation should be deferred until
> >   * later in the boot cycle when it can be parallelised.
> >   */
> > -static inline bool update_defer_init(pg_data_t *pgdat,
> > -                             unsigned long pfn, unsigned long zone_end,
> > -                             unsigned long *nr_initialised)
> > +static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
> >  {
> > +     static unsigned long prev_end_pfn, nr_initialised;
>
> So answer me quick, what happens with a static variable in an inlined
> function?  Is there one copy kernel-wide?  One copy per invocation
> site?  One copy per compilation unit?
>
> Well I didn't know so I wrote a little test.  One copy per compilation
> unit (.o file), it appears.
>
> It's OK in this case because the function is in .c (and has only one
> call site).  But if someone moves it into a header and uses it from a
> different .c file, they have problems.
>
> So it's dangerous, and poor practice.  I'll make this non-static
> __meminit.

I agree, it should not be moved to header it is dangerous.

But, on the other hand this is a hot-path. memmap_init_zone() might
need to go through billions of struct pages early in boot, and I did
not want us to waste time on function calls. With defer_init() this is
not a problem, because if CONFIG_DEFERRED_STRUCT_PAGE_INIT is set
memmap_init_zone() won't have much work to do, but for
overlap_memmap_init() this is a problem, especially because I expect
compiler to optimize the pfn dereference usage in inline function.

>
> --- a/mm/page_alloc.c~mm-calculate-deferred-pages-after-skipping-mirrored-memory-fix
> +++ a/mm/page_alloc.c
> @@ -309,7 +309,8 @@ static inline bool __meminit early_page_
>   * Returns true when the remaining initialisation should be deferred until
>   * later in the boot cycle when it can be parallelised.
>   */
> -static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
> +static bool __meminit
> +defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
>  {
>         static unsigned long prev_end_pfn, nr_initialised;
>
>
> Also, what locking protects these statics?  Our knowledge that this
> code is single-threaded, presumably?

Correct, this is called only from "context == MEMMAP_EARLY", way
before smp_init().
