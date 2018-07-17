Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19335ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEAE2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WHcy+Pt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEAE2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbeGQPUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:20:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45364 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbeGQPUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:20:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6HEiKe2094326
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=LVlUeDYJUcqbSEDZzTsYNjx4zU/4OM5tIjC0oYAoGW8=;
 b=WHcy+Pt7G6XERwdU/52Jgy0De4YDjyDAoJQLOHOI0C4KODspEFCdaxz0+2izlw3/MqzX
 12bUsWbrsOqIIwxlXJQHrO+/vbeLunk6OsYSjGIji49PPZe+IVcldXlsboZlUvl/Xe5h
 kuZP3j2PBJt/LRQP4S0kaf2xG8TX5wT/y4XCJ7iOeZLuY9N0Dr01FwNmVyDPpY5ISR/X
 UtR+EJVGqqDBjybyR/HMWuwfP387kSQiWcTglnqANe+7/VgsvLaU1DUa07ES6o9vXv2K
 9FXjFiMAJIPA2CHTc0OqCmiayNPJbX/njjBsjU42jF+iqspALhvI3KVoWjrucVA7Fi/E mw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2k7a3t12ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:47:18 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6HElH6P020016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:47:18 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6HElHwR005503
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:47:17 GMT
Received: from mail-oi0-f54.google.com (/209.85.218.54)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 07:47:17 -0700
Received: by mail-oi0-f54.google.com with SMTP id q11-v6so2477406oic.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:47:17 -0700 (PDT)
X-Gm-Message-State: AOUpUlHcc5m5DC35gQeM4gS5HqJzGv+5PRmv8oYH/LuSNKflNEdbT6fk
        nqemIF4GXj/9PmH37If4ZaxbpaXUs4Z+WQ6c+yM=
X-Google-Smtp-Source: AAOMgperwgU858DVry7WtvX4mq1pYkxWlR6vGJuoujwK8wkCsIxpXGXj5JYElgoxOdadzd2dI0g2biJXDesW7uulGwk=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr2130311oia.156.1531838835402;
 Tue, 17 Jul 2018 07:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAGM2rea9AwQGaf1JiV_SDDKTKyP_n+dG9Z20gtTZEkuZPFnXFQ@mail.gmail.com> <CAPcyv4jo91jKjwn-M7cOhG=6vJ3c-QCyp0W+T+CtmiKGyZP1ng@mail.gmail.com>
In-Reply-To: <CAPcyv4jo91jKjwn-M7cOhG=6vJ3c-QCyp0W+T+CtmiKGyZP1ng@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 17 Jul 2018 10:46:39 -0400
X-Gmail-Original-Message-ID: <CAGM2reacO1HF91yH8OR5w5AdZwPgwfSFfjDNBsHbP66v1rEg=g@mail.gmail.com>
Message-ID: <CAGM2reacO1HF91yH8OR5w5AdZwPgwfSFfjDNBsHbP66v1rEg=g@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] mm: Asynchronous + multithreaded memmap init for ZONE_DEVICE
To:     dan.j.williams@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, tony.luck@intel.com,
        yehs1@lenovo.com, vishal.l.verma@intel.com, jack@suse.cz,
        willy@infradead.org, dave.jiang@intel.com, hpa@zytor.com,
        tglx@linutronix.de, dalias@libc.org, fenghua.yu@intel.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        benh@kernel.crashing.org, Michal Hocko <mhocko@suse.com>,
        paulus@samba.org, hch@lst.de, jglisse@redhat.com, mingo@redhat.com,
        mpe@ellerman.id.au, Heiko Carstens <heiko.carstens@de.ibm.com>,
        x86@kernel.org, logang@deltatee.com, ross.zwisler@linux.intel.com,
        jmoyer@redhat.com, jthumshirn@suse.de, schwidefsky@de.ibm.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nvdimm@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807170155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Dan,
> >
> > I am worried that this work adds another way to multi-thread struct
> > page initialization without re-use of already existing method. The
> > code is already a mess, and leads to bugs [1] because of the number of
> > different memory layouts, architecture specific quirks, and different
> > struct page initialization methods.
>
> Yes, the lamentations about the complexity of the memory hotplug code
> are known. I didn't think this set made it irretrievably worse, but
> I'm biased and otherwise certainly want to build consensus with other
> mem-hotplug folks.
>
> >
> > So, when DEFERRED_STRUCT_PAGE_INIT is used we initialize struct pages
> > on demand until page_alloc_init_late() is called, and at that time we
> > initialize all the rest of struct pages by calling:
> >
> > page_alloc_init_late()
> >   deferred_init_memmap() (a thread per node)
> >     deferred_init_pages()
> >        __init_single_page()
> >
> > This is because memmap_init_zone() is not multi-threaded. However,
> > this work makes memmap_init_zone() multi-threaded. So, I think we
> > should really be either be using deferred_init_memmap() here, or teach
> > DEFERRED_STRUCT_PAGE_INIT to use new multi-threaded memmap_init_zone()
> > but not both.
>
> I agree it would be good to look at unifying the 2 async
> initialization approaches, however they have distinct constraints. All
> of the ZONE_DEVICE memmap initialization work happens as a hotplug
> event where the deferred_init_memmap() threads have already been torn
> down. For the memory capacities where it takes minutes to initialize
> the memmap it is painful to incur a global flush of all initialization
> work. So, I think that a move to rework deferred_init_memmap() in
> terms of memmap_init_async() is warranted because memmap_init_async()
> avoids a global sync and supports the hotplug case.
>
> Unfortunately, the work to unite these 2 mechanisms is going to be
> 4.20 material, at least for me, since I'm taking an extended leave,
> and there is little time for me to get this in shape for 4.19. I
> wouldn't be opposed to someone judiciously stealing from this set and
> taking a shot at the integration, I likely will not get back to this
> until September.

Hi Dan,

I do not want to hold your work, so if Michal or Andrew are OK with
the general approach of teaching    memmap_init_zone() to be async
without re-using deferred_init_memmap() or without changing
deferred_init_memmap() to use the new memmap_init_async() I will
review your patches.

Thank you,
Pavel

>
