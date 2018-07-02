Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FF1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4FC21A56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F3scf1Wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4FC21A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbeGBRzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:55:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53364 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeGBRzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:55:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w62Hrelx009106
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 17:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=zMpBZqIob5wP3bvZyyHOiqfojBEoxGq3SbF724kndgs=;
 b=F3scf1WtUylzCqAQ+it+PEVFtAfvqaH8rmn+SI9rgEKLdQIIVzxTAHAOFN1loaRLKQOQ
 hiYXTutpQIuA14cLnwFyFYp3LTgz5VVMprk3CRgA0v1E3ypYA6e7dGqB9nboB7JopOjN
 LALNSRGyRl0W15Q/mMeNiAIrI8tW259SImhB3Xqf/j56iEs1/PJrDd2ywuhrRBa7a9Z+
 AfEo7E+LEy+DLknCdQPWxduvOSzuhgddcwUPsOVJL0Q6eoxKJVfhWAec8mcgiltJ6J7Q
 OOWMSaAwXMqdYp+P8eBXA5/DcbM33xs74+hJk32yq3+X+H3D4EMbFLi8zDOUjhHOsWMz eQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2jx1tnwg9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 17:55:07 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w62Ht6RA025723
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 17:55:06 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w62Ht6dg027448
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 17:55:06 GMT
Received: from mail-oi0-f45.google.com (/209.85.218.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Jul 2018 10:55:06 -0700
Received: by mail-oi0-f45.google.com with SMTP id w126-v6so10698025oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:55:06 -0700 (PDT)
X-Gm-Message-State: APt69E3tx9bdJl4GAm8Z3jUcI5xTxBq+NMCmpNvJlBMvHufPwpKWtZYM
        r234wfW9VUrEEBpc0EU3dIJR44U/HNZGtJwizk4=
X-Google-Smtp-Source: AAOMgpeAYf6ppxEKyCdniKVFyr/7Fzu5ncH8Qu8fkM+iTKzFh1IiYV2SXZNxFIuYN+HF2Fu6OLo97RIdPUZfzFdMVHM=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr2921742oiy.191.1530554105791;
 Mon, 02 Jul 2018 10:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180702152745.27596-1-pasha.tatashin@oracle.com> <20180702155858.GE19043@dhcp22.suse.cz>
In-Reply-To: <20180702155858.GE19043@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 2 Jul 2018 13:54:29 -0400
X-Gmail-Original-Message-ID: <CAGM2reYeHhQAqujJwcec_t40pM+9=DO=Ht8HR=yX6rHSUQQXvg@mail.gmail.com>
Message-ID: <CAGM2reYeHhQAqujJwcec_t40pM+9=DO=Ht8HR=yX6rHSUQQXvg@mail.gmail.com>
Subject: Re: [PATCH] mm: teach dump_page() to correctly output poisoned struct pages
To:     mhocko@kernel.org
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        mgorman@techsingularity.net, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 11:59 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 02-07-18 11:27:45, Pavel Tatashin wrote:
> > If struct page is poisoned, and uninitialized access is detected via
> > PF_POISONED_CHECK(page) dump_page() is called to output the page. But,
> > the dump_page() itself accesses struct page to determine how to print
> > it, and therefore gets into a recursive loop.
> >
> > For example:
> > dump_page()
> >  __dump_page()
> >   PageSlab(page)
> >    PF_POISONED_CHECK(page)
> >     VM_BUG_ON_PGFLAGS(PagePoisoned(page), page)
> >      dump_page() recursion loop.
>
> This deserves a big fat comment in __dump_page. Basically no Page$FOO
> can be used on an HWPoison page.
>
> > Fixes: f165b378bbdf ("mm: uninitialized struct page poisoning sanity checking")
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you, I will send out an updated version with a comment.

Pavel

>
> > ---
> >  mm/debug.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/debug.c b/mm/debug.c
> > index 56e2d9125ea5..469b526e6abc 100644
> > --- a/mm/debug.c
> > +++ b/mm/debug.c
> > @@ -43,12 +43,20 @@ const struct trace_print_flags vmaflag_names[] = {
> >
> >  void __dump_page(struct page *page, const char *reason)
> >  {
> > +     bool page_poisoned = PagePoisoned(page);
> > +     int mapcount;
> > +
> > +     if (page_poisoned) {
> > +             pr_emerg("page:%px is uninitialized and poisoned", page);
> > +             goto hex_only;
> > +     }
> > +
> >       /*
> >        * Avoid VM_BUG_ON() in page_mapcount().
> >        * page->_mapcount space in struct page is used by sl[aou]b pages to
> >        * encode own info.
> >        */
> > -     int mapcount = PageSlab(page) ? 0 : page_mapcount(page);
> > +     mapcount = PageSlab(page) ? 0 : page_mapcount(page);
> >
> >       pr_emerg("page:%px count:%d mapcount:%d mapping:%px index:%#lx",
> >                 page, page_ref_count(page), mapcount,
> > @@ -60,6 +68,7 @@ void __dump_page(struct page *page, const char *reason)
> >
> >       pr_emerg("flags: %#lx(%pGp)\n", page->flags, &page->flags);
> >
> > +hex_only:
> >       print_hex_dump(KERN_ALERT, "raw: ", DUMP_PREFIX_NONE, 32,
> >                       sizeof(unsigned long), page,
> >                       sizeof(struct page), false);
> > @@ -68,7 +77,7 @@ void __dump_page(struct page *page, const char *reason)
> >               pr_alert("page dumped because: %s\n", reason);
> >
> >  #ifdef CONFIG_MEMCG
> > -     if (page->mem_cgroup)
> > +     if (!page_poisoned && page->mem_cgroup)
> >               pr_alert("page->mem_cgroup:%px\n", page->mem_cgroup);
> >  #endif
> >  }
> > --
> > 2.18.0
> >
>
> --
> Michal Hocko
> SUSE Labs
>
