Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50034C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BBE208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xVnImYHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BBE208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeGaRFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:05:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41316 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeGaRFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:05:02 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6VFNtHV132962
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 15:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=hrH3bcmpFNBtn4AT8LVUsEuQ/ThxwmJNel9zjHJJB7k=;
 b=xVnImYHGzA4fGV5EQ+kPIkR8NO51pmYtzdOkM/lY9PrdNxg8bLaNz9GnRKikkGu850lC
 N4ElL+kpW4mLUMfPZ1euusNrbTaaExxmsUjPi5/dB+j/v2uRGtevVBfA7EaskNXOh0he
 IZplj1YJTv9sVIedlrsnULL8sCrr0Wnk96NQj4JUlmn093plzPZqo9XJgwww2IP1zijJ
 3kNcV/qKsq9j3G/Ol9f6K4lOuE4QBclsxrwRZQ5ASl/srL8QwjclQIZ8rr94pUFDUt/h
 ETmZ31DJlLdg9GLKzKWJt0eYUlXhrDEXLeaULVHnVZzbXpFYQlqrehS1qDGOy02cpmZP tA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2kge0d1pvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 15:24:11 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6VFOA6I025541
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 15:24:10 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6VFOAr2024869
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 15:24:10 GMT
Received: from mail-oi0-f53.google.com (/209.85.218.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Jul 2018 08:24:09 -0700
Received: by mail-oi0-f53.google.com with SMTP id d189-v6so28639705oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 08:24:09 -0700 (PDT)
X-Gm-Message-State: AOUpUlEaZZNGyMnOXHEvEm1aizto9uZtLzijG8IrlVg6wIVW54BhdqyP
        S9HgZxd3TFL4t0RM/exyc6CAv9KsfAqxnnkN7Tg=
X-Google-Smtp-Source: AAOMgpegzfAHDDUDC+i9xF/EEfWFnrUOisTneZohOMryyuCC1FaxqTL4rf9nmfmf6MACXpTQEFLa2fi2RbELJ6Fvt78=
X-Received: by 2002:aca:da88:: with SMTP id r130-v6mr23561159oig.163.1533050649552;
 Tue, 31 Jul 2018 08:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180731124504.27582-1-osalvador@techadventures.net>
 <CAGM2rebds=A5m1ZB1LtD7oxMzM9gjVQvm-QibHjEENmXViw5eA@mail.gmail.com>
 <20180731144157.GA1499@techadventures.net> <20180731144545.fh5syvwcecgvqul6@xakep.localdomain>
 <20180731145125.GB1499@techadventures.net> <CAGM2reZSZHdWECr8-7pj6j=CtjWVF2oKC9SwHhMuOsDkigdzgA@mail.gmail.com>
 <20180731150115.GC1499@techadventures.net> <CAGM2reZ+KhsuFhOVvJzRkQO=66TosvxDW0BYAXNf8Gw8zoRQXQ@mail.gmail.com>
In-Reply-To: <CAGM2reZ+KhsuFhOVvJzRkQO=66TosvxDW0BYAXNf8Gw8zoRQXQ@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 31 Jul 2018 11:23:33 -0400
X-Gmail-Original-Message-ID: <CAGM2reaniWqEJ1hArMoreyGn5M+eSYge+wYYMxTrRHth-hxzOQ@mail.gmail.com>
Message-ID: <CAGM2reaniWqEJ1hArMoreyGn5M+eSYge+wYYMxTrRHth-hxzOQ@mail.gmail.com>
Subject: Re: [PATCH] mm: make __paginginit based on CONFIG_MEMORY_HOTPLUG
To:     osalvador@techadventures.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kirill.shutemov@linux.intel.com, iamjoonsoo.kim@lge.com,
        Mel Gorman <mgorman@suse.de>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=840
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes we free meminit when no CONFIG_MEMORY_HOTPLUG
See here:
http://src.illumos.org/source/xref/linux-master/include/asm-generic/vmlinux.lds.h#107

Pavel
On Tue, Jul 31, 2018 at 11:06 AM Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>
> On Tue, Jul 31, 2018 at 11:01 AM Oscar Salvador
> <osalvador@techadventures.net> wrote:
> >
> > On Tue, Jul 31, 2018 at 10:53:52AM -0400, Pavel Tatashin wrote:
> > > Thats correct on arches where no sparsemem setup_usemap() will not be
> > > freed up. It is a tiny function, just a few instructions. Not a big
> > > deal.
> > >
> > > Pavel
> > > On Tue, Jul 31, 2018 at 10:51 AM Oscar Salvador
> > > <osalvador@techadventures.net> wrote:
> > > >
> > > > On Tue, Jul 31, 2018 at 10:45:45AM -0400, Pavel Tatashin wrote:
> > > > > Here the patch would look like this:
> > > > >
> > > > > From e640b32dbd329bba5a785cc60050d5d7e1ca18ce Mon Sep 17 00:00:00 2001
> > > > > From: Pavel Tatashin <pasha.tatashin@oracle.com>
> > > > > Date: Tue, 31 Jul 2018 10:37:44 -0400
> > > > > Subject: [PATCH] mm: remove __paginginit
> > > > >
> > > > > __paginginit is the same thing as __meminit except for platforms without
> > > > > sparsemem, there it is defined as __init.
> > > > >
> > > > > Remove __paginginit and use __meminit. Use __ref in one single function
> > > > > that merges __meminit and __init sections: setup_usemap().
> > > > >
> > > > > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> > > >
> > > > Uhm, I am probably missing something, but with this change, the functions will not be freed up
> > > > while freeing init memory, right?
> > > Thats correct on arches where no sparsemem setup_usemap() will not be
> > > freed up. It is a tiny function, just a few instructions. Not a big
> > > deal.
> >
> > I must be missing something.
> >
> > What about:
> >
> > calc_memmap_size
> > free_area_init_node
> > free_area_init_core
> >
> > These functions are marked with __meminit now.
> > If we have CONFIG_PARSEMEM but not CONFIG_MEMORY_HOTPLUG, these functions will
> > be left there.
>
> I hope we free meminit section if no hotplug configured. If not, than
> sure we should have something like what you suggest not only for these
> functions, but for all other meminit functions in kernel.
>
> >
> > I mean, it is not that it is a big amount, but still.
> >
> > Do not we need something like:
> >
> > diff --git a/include/linux/init.h b/include/linux/init.h
> > index 2538d176dd1f..3b3a88ba80ed 100644
> > --- a/include/linux/init.h
> > +++ b/include/linux/init.h
> > @@ -83,8 +83,12 @@
> >  #define __exit          __section(.exit.text) __exitused __cold notrace
> >
> >  /* Used for MEMORY_HOTPLUG */
> > +#ifdef CONFIG_MEMORY_HOTPLUG
> >  #define __meminit        __section(.meminit.text) __cold notrace \
> >                                                   __latent_entropy
> > +#else
> > +#define __meminit       __init
> > +#endif
> >  #define __meminitdata    __section(.meminit.data)
> >  #define __meminitconst   __section(.meminit.rodata)
> >  #define __memexit        __section(.memexit.text) __exitused __cold notrace
> >
> > on top?
> >
> > Thanks
> > --
> > Oscar Salvador
> > SUSE L3
> >
