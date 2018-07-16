Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B52AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0155208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ihg3bgsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0155208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbeGPTm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:42:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46914 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbeGPTm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:42:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GJ9Z6u062106
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=O2SwayotstqZ3xBXYVbgIsexsdZepRU1dDWYeEmXFzo=;
 b=Ihg3bgsjV9x66HmH/RT9J6ddIxXMZ7MhYvT/SxKBxVchirFJh6HFPKEYsPwe5hskktHo
 Og9Ggyq0ceQLTdw7rMgPDXL6GbGpC6gGk0AOhtoqChoteoItIRXQS5Q85Da91dmxmvfm
 I5G7TBQByHOMgIPcBavmieJrEM6lW9n/mSawFLUpYSwWYfdUEwg70yh15pcelDhUUUIi
 kDOww2a08y3ZdhEm59+zka8QtNjDjGMOKWpkyea2M46qoMA90OvEVeT2T346VGg1NOi4
 VyCj08itCFEPQ6gZuANo2uOptgercetMWtBH1Yi+jFMAo2oyP5ovkAqD1JHOXYCHpbij DA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2k7a3swuvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:13:37 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6GJDaTT012113
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:13:36 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6GJDZOR023286
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:13:36 GMT
Received: from mail-oi0-f46.google.com (/209.85.218.46)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 12:13:35 -0700
Received: by mail-oi0-f46.google.com with SMTP id b15-v6so76843310oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:13:35 -0700 (PDT)
X-Gm-Message-State: AOUpUlGjRI9UPhvfqPl8Uwt1YL1uSww2tNROr3cm70lmWwi8wEj9cWsk
        ikUSzg1M6XcX+IfrGhJqa8WY47IBF9spHOmLGEE=
X-Google-Smtp-Source: AAOMgpcIwsekFQRlUlH9OzYe2D46eX5Vgg6Rdr5xf4tjwzGvYwvdabPxGkBzoeYQZuBcSf4CnQLs7jLbknYNVtTL4js=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr558975oig.221.1531768414471;
 Mon, 16 Jul 2018 12:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 16 Jul 2018 15:12:58 -0400
X-Gmail-Original-Message-ID: <CAGM2rea9AwQGaf1JiV_SDDKTKyP_n+dG9Z20gtTZEkuZPFnXFQ@mail.gmail.com>
Message-ID: <CAGM2rea9AwQGaf1JiV_SDDKTKyP_n+dG9Z20gtTZEkuZPFnXFQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] mm: Asynchronous + multithreaded memmap init for ZONE_DEVICE
To:     dan.j.williams@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, tony.luck@intel.com,
        yehs1@lenovo.com, vishal.l.verma@intel.com, jack@suse.cz,
        willy@infradead.org, dave.jiang@intel.com, hpa@zytor.com,
        tglx@linutronix.de, dalias@libc.org, fenghua.yu@intel.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        ysato@users.sourceforge.jp, benh@kernel.crashing.org,
        Michal Hocko <mhocko@suse.com>, paulus@samba.org, hch@lst.de,
        jglisse@redhat.com, mingo@redhat.com, mpe@ellerman.id.au,
        Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
        logang@deltatee.com, ross.zwisler@linux.intel.com,
        jmoyer@redhat.com, jthumshirn@suse.de, schwidefsky@de.ibm.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nvdimm@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 1:10 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Changes since v1 [1]:
> * Teach memmap_sync() to take over a sub-set of memmap initialization in
>   the foreground. This foreground work still needs to await the
>   completion of vmemmap_populate_hugepages(), but it will otherwise
>   steal 1/1024th of the 'struct page' init work for the given range.
>   (Jan)
> * Add kernel-doc for all the new 'async' structures.
> * Split foreach_order_pgoff() to its own patch.
> * Add Pavel and Daniel to the cc as they have been active in the memory
>   hotplug code.
> * Fix a typo that prevented CONFIG_DAX_DRIVER_DEBUG=y from performing
>   early pfn retrieval at dax-filesystem mount time.
> * Improve some of the changelogs
>
> [1]: https://lwn.net/Articles/759117/
>
> ---
>
> In order to keep pfn_to_page() a simple offset calculation the 'struct
> page' memmap needs to be mapped and initialized in advance of any usage
> of a page. This poses a problem for large memory systems as it delays
> full availability of memory resources for 10s to 100s of seconds.
>
> For typical 'System RAM' the problem is mitigated by the fact that large
> memory allocations tend to happen after the kernel has fully initialized
> and userspace services / applications are launched. A small amount, 2GB
> of memory, is initialized up front. The remainder is initialized in the
> background and freed to the page allocator over time.
>
> Unfortunately, that scheme is not directly reusable for persistent
> memory and dax because userspace has visibility to the entire resource
> pool and can choose to access any offset directly at its choosing. In
> other words there is no allocator indirection where the kernel can
> satisfy requests with arbitrary pages as they become initialized.
>
> That said, we can approximate the optimization by performing the
> initialization in the background, allow the kernel to fully boot the
> platform, start up pmem block devices, mount filesystems in dax mode,
> and only incur delay at the first userspace dax fault. When that initial
> fault occurs that process is delegated a portion of the memmap to
> initialize in the foreground so that it need not wait for initialization
> of resources that it does not immediately need.
>
> With this change an 8 socket system was observed to initialize pmem
> namespaces in ~4 seconds whereas it was previously taking ~4 minutes.

Hi Dan,

I am worried that this work adds another way to multi-thread struct
page initialization without re-use of already existing method. The
code is already a mess, and leads to bugs [1] because of the number of
different memory layouts, architecture specific quirks, and different
struct page initialization methods.

So, when DEFERRED_STRUCT_PAGE_INIT is used we initialize struct pages
on demand until page_alloc_init_late() is called, and at that time we
initialize all the rest of struct pages by calling:

page_alloc_init_late()
  deferred_init_memmap() (a thread per node)
    deferred_init_pages()
       __init_single_page()

This is because memmap_init_zone() is not multi-threaded. However,
this work makes memmap_init_zone() multi-threaded. So, I think we
should really be either be using deferred_init_memmap() here, or teach
DEFERRED_STRUCT_PAGE_INIT to use new multi-threaded memmap_init_zone()
but not both.

I am planning to study the memmap layouts, and figure out how can we
reduce their number or merge some of the code, and also, I'd like to
simplify memmap_init_zone() by at least splitting it into two
functions: one that handles the boot case, and another that handles
the hotplug case, as those are substantially different, and make
memmap_init_zone() more complicated than needed.

Thank you,
Pavel

[1] https://www.spinics.net/lists/linux-mm/msg157271.html

>
> These patches apply on top of the HMM + devm_memremap_pages() reworks:
