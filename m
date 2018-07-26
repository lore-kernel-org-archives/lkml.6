Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D89C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03CF20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0aoMRj9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03CF20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbeGZQ5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:57:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47840 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730298AbeGZQ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:57:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QFXuoH141008
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 15:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=pezoiC3bd4O/h/75aqFJKkzwyd2Qs6/b9qlYox1d2Ek=;
 b=0aoMRj9cnM6xwnbR8VC4QI557vR/N8jB/B1bHTApffLAg7E5tS7ticXsNbNGCBp+lE/B
 bsVs060MkRNX/pC15RKe1qB3WehAt+2kBTG5pA+JwsfHW1E94SZFqXb4PF6r43t/06jg
 ZEuVfo1Pej6HS7uy6DN76aa63lVAFlMIaEHIouUBFE/9RyY/DYaXk9wVB8Hu8AA5MEmR
 Cw8Q3lxrxCbptDYupy6tmQQj9P2foS2hHZpL+z4/oz/POBYzyk3/s9Qf+Nqf3eIbVa/S
 rOReVVRoZ9am/r4lf3RmZRN2mkU1IupBbweXXA3WA96zXI4zT+xiRMv7uJMtqgt1n0nu Eg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2kbwfq3n7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 15:39:49 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6QFdl2V004777
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 15:39:48 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6QFdlBn001718
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 15:39:47 GMT
Received: from mail-oi0-f44.google.com (/209.85.218.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 08:39:47 -0700
Received: by mail-oi0-f44.google.com with SMTP id n21-v6so3733777oig.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 08:39:47 -0700 (PDT)
X-Gm-Message-State: AOUpUlF4anGVhx6t6ZTSmAbiC4zcvleDhMjj8pvj7zyUp4AVL6/w2Pa+
        t+WEYqnZoHuI5KhZL5D8Bh+swR5z2nGCLiOb6ao=
X-Google-Smtp-Source: AAOMgpepMjl9ubnYRVdKySqs+IcxoYVXb8MDzYXy829OjZbAcYrWgloIZ+crEYZjFsX3JC2wjDYCSCNvDR5VJXqzp/4=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr2668243oia.156.1532619580246;
 Thu, 26 Jul 2018 08:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180724235520.10200-1-pasha.tatashin@oracle.com>
 <20180724235520.10200-3-pasha.tatashin@oracle.com> <20180724183142.d20798b43fd1215f6165649c@linux-foundation.org>
 <CAGM2reb4vT59uUkMkJVBx9-GEYQs287oTG08aRwKtjfJ1BVrjA@mail.gmail.com> <20180725143007.25d5bff352872aba90ca731b@linux-foundation.org>
In-Reply-To: <20180725143007.25d5bff352872aba90ca731b@linux-foundation.org>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 26 Jul 2018 11:39:04 -0400
X-Gmail-Original-Message-ID: <CAGM2reZ-DLcSw_DnBFfR8yvZBxpT4W1pUPo5+R6HDNvumx-nsA@mail.gmail.com>
Message-ID: <CAGM2reZ-DLcSw_DnBFfR8yvZBxpT4W1pUPo5+R6HDNvumx-nsA@mail.gmail.com>
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
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 5:30 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 24 Jul 2018 21:46:25 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
>
> > > > +static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
> > > >  {
> > > > +     static unsigned long prev_end_pfn, nr_initialised;
> > >
> > > So answer me quick, what happens with a static variable in an inlined
> > > function?  Is there one copy kernel-wide?  One copy per invocation
> > > site?  One copy per compilation unit?
> > >
> > > Well I didn't know so I wrote a little test.  One copy per compilation
> > > unit (.o file), it appears.
> > >
> > > It's OK in this case because the function is in .c (and has only one
> > > call site).  But if someone moves it into a header and uses it from a
> > > different .c file, they have problems.
> > >
> > > So it's dangerous, and poor practice.  I'll make this non-static
> > > __meminit.
> >
> > I agree, it should not be moved to header it is dangerous.
> >
> > But, on the other hand this is a hot-path. memmap_init_zone() might
> > need to go through billions of struct pages early in boot, and I did
> > not want us to waste time on function calls. With defer_init() this is
> > not a problem, because if CONFIG_DEFERRED_STRUCT_PAGE_INIT is set
> > memmap_init_zone() won't have much work to do, but for
> > overlap_memmap_init() this is a problem, especially because I expect
> > compiler to optimize the pfn dereference usage in inline function.
>
> Well.  The compiler will just go and inline defer_init() anwyay - it
> has a single callsite and is in the same __meminint section as its
> calling function.  My gcc-7.2.0 does this.  Marking it noninline
> __meminit is basically syntactic fluff designed to encourage people to
> think twice.

Makes sense. I will do the change in the next version of the patches.

>
> > >
> > > --- a/mm/page_alloc.c~mm-calculate-deferred-pages-after-skipping-mirrored-memory-fix
> > > +++ a/mm/page_alloc.c
> > > @@ -309,7 +309,8 @@ static inline bool __meminit early_page_
> > >   * Returns true when the remaining initialisation should be deferred until
> > >   * later in the boot cycle when it can be parallelised.
> > >   */
> > > -static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
> > > +static bool __meminit
> > > +defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
> > >  {
> > >         static unsigned long prev_end_pfn, nr_initialised;
> > >
> > >
> > > Also, what locking protects these statics?  Our knowledge that this
> > > code is single-threaded, presumably?
> >
> > Correct, this is called only from "context == MEMMAP_EARLY", way
> > before smp_init().
>
> Might be worth a little comment to put readers minds at ease.

Will add it.

Thank you,
Pavel
