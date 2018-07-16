Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9D8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E779C20850
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="kH04CNgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E779C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeGPU7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:59:54 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43832 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPU7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:59:54 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so77270960oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1iStmW92fVHQLvJAyoAU/3KGGuTjkcqxzK9XvvE5oRA=;
        b=kH04CNgPWSBQt4dukuhigqA0kkUgQEHa7DgvJNkJIHVmv5PJf0mPhta/CYPF23sdBm
         vpXiYLnRZdFdBRW7B+z5Jzm2L/VghlJx99zyzeb2BcyYXvK7WiTGamXm7eeZdNkiPm1U
         1MmbZxWH2g3mg4A8qGjZg87X9jg09/UELTFzTMsvFKfjEXsQKsPix4y1aWB/Ap6qDdGe
         SGrZBCtlPOzUEBpVXa62UtEfOlSerPEdqgolX6hvPA7suFY1hLs4p9OrsWsfP41kZ/s8
         q9orZadB9C4NzZ/jqZU7E+qC+Xf84SZ0KCQ+8pOEtNDAguyFznP7qtkbBl8H060g8NMG
         gW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1iStmW92fVHQLvJAyoAU/3KGGuTjkcqxzK9XvvE5oRA=;
        b=CAf2XDwXhtj/KBD306EKyTxOogHWjKeMe1gr+rzdVik2RbibMemkAXPVC3HH8Ff+rW
         lcLJD2alOpPE7qaVxqwiY9Q3lhxdRpLTC/VvmrRyP1v9pmI77dvL5Q9TpUtCi4KtdTr7
         29PBQ0s4FchAdZhsy6lSGin5rX2vz/Gk05eoYpsTagtTF9DEmBg3kampMOZ57lntmuj4
         SzRIa8xReGg9U3StuqS6+wU+UgpPvlViv0jrHHEyJaFcNsTW1IFkqzQCXdsrd4Y7Jjc7
         8OAsPdYu4CrBGX/Nsyvmj5VizMrjtxjTn/2av8MprwM5Mxy1WWPpeXruQ4monAB9mrh2
         F5Ug==
X-Gm-Message-State: AOUpUlGdj/qTH2ZagW+PpBpog50RcpKFEeuUVgxD5ayB2UdWnEnbpycP
        e2RzWqzPE+kcn62fMNIhpAWQ3epDS5mcoTpfju0BIg==
X-Google-Smtp-Source: AAOMgpe4wUE0BHJ0H6BpPtnYC9GYme/8dAEIusiGqnNBB6FFC6ddwMJt1zC1MairBuX4oVqKNWcgMSXqdO32EmZwS1w=
X-Received: by 2002:aca:a993:: with SMTP id s141-v6mr936934oie.72.1531773050906;
 Mon, 16 Jul 2018 13:30:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 13:30:50
 -0700 (PDT)
In-Reply-To: <CAGM2rea9AwQGaf1JiV_SDDKTKyP_n+dG9Z20gtTZEkuZPFnXFQ@mail.gmail.com>
References: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAGM2rea9AwQGaf1JiV_SDDKTKyP_n+dG9Z20gtTZEkuZPFnXFQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 16 Jul 2018 13:30:50 -0700
Message-ID: <CAPcyv4jo91jKjwn-M7cOhG=6vJ3c-QCyp0W+T+CtmiKGyZP1ng@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] mm: Asynchronous + multithreaded memmap init for ZONE_DEVICE
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@suse.com>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        X86 ML <x86@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        jmoyer <jmoyer@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:12 PM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
> On Mon, Jul 16, 2018 at 1:10 PM Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> Changes since v1 [1]:
>> * Teach memmap_sync() to take over a sub-set of memmap initialization in
>>   the foreground. This foreground work still needs to await the
>>   completion of vmemmap_populate_hugepages(), but it will otherwise
>>   steal 1/1024th of the 'struct page' init work for the given range.
>>   (Jan)
>> * Add kernel-doc for all the new 'async' structures.
>> * Split foreach_order_pgoff() to its own patch.
>> * Add Pavel and Daniel to the cc as they have been active in the memory
>>   hotplug code.
>> * Fix a typo that prevented CONFIG_DAX_DRIVER_DEBUG=y from performing
>>   early pfn retrieval at dax-filesystem mount time.
>> * Improve some of the changelogs
>>
>> [1]: https://lwn.net/Articles/759117/
>>
>> ---
>>
>> In order to keep pfn_to_page() a simple offset calculation the 'struct
>> page' memmap needs to be mapped and initialized in advance of any usage
>> of a page. This poses a problem for large memory systems as it delays
>> full availability of memory resources for 10s to 100s of seconds.
>>
>> For typical 'System RAM' the problem is mitigated by the fact that large
>> memory allocations tend to happen after the kernel has fully initialized
>> and userspace services / applications are launched. A small amount, 2GB
>> of memory, is initialized up front. The remainder is initialized in the
>> background and freed to the page allocator over time.
>>
>> Unfortunately, that scheme is not directly reusable for persistent
>> memory and dax because userspace has visibility to the entire resource
>> pool and can choose to access any offset directly at its choosing. In
>> other words there is no allocator indirection where the kernel can
>> satisfy requests with arbitrary pages as they become initialized.
>>
>> That said, we can approximate the optimization by performing the
>> initialization in the background, allow the kernel to fully boot the
>> platform, start up pmem block devices, mount filesystems in dax mode,
>> and only incur delay at the first userspace dax fault. When that initial
>> fault occurs that process is delegated a portion of the memmap to
>> initialize in the foreground so that it need not wait for initialization
>> of resources that it does not immediately need.
>>
>> With this change an 8 socket system was observed to initialize pmem
>> namespaces in ~4 seconds whereas it was previously taking ~4 minutes.
>
> Hi Dan,
>
> I am worried that this work adds another way to multi-thread struct
> page initialization without re-use of already existing method. The
> code is already a mess, and leads to bugs [1] because of the number of
> different memory layouts, architecture specific quirks, and different
> struct page initialization methods.

Yes, the lamentations about the complexity of the memory hotplug code
are known. I didn't think this set made it irretrievably worse, but
I'm biased and otherwise certainly want to build consensus with other
mem-hotplug folks.

>
> So, when DEFERRED_STRUCT_PAGE_INIT is used we initialize struct pages
> on demand until page_alloc_init_late() is called, and at that time we
> initialize all the rest of struct pages by calling:
>
> page_alloc_init_late()
>   deferred_init_memmap() (a thread per node)
>     deferred_init_pages()
>        __init_single_page()
>
> This is because memmap_init_zone() is not multi-threaded. However,
> this work makes memmap_init_zone() multi-threaded. So, I think we
> should really be either be using deferred_init_memmap() here, or teach
> DEFERRED_STRUCT_PAGE_INIT to use new multi-threaded memmap_init_zone()
> but not both.

I agree it would be good to look at unifying the 2 async
initialization approaches, however they have distinct constraints. All
of the ZONE_DEVICE memmap initialization work happens as a hotplug
event where the deferred_init_memmap() threads have already been torn
down. For the memory capacities where it takes minutes to initialize
the memmap it is painful to incur a global flush of all initialization
work. So, I think that a move to rework deferred_init_memmap() in
terms of memmap_init_async() is warranted because memmap_init_async()
avoids a global sync and supports the hotplug case.

Unfortunately, the work to unite these 2 mechanisms is going to be
4.20 material, at least for me, since I'm taking an extended leave,
and there is little time for me to get this in shape for 4.19. I
wouldn't be opposed to someone judiciously stealing from this set and
taking a shot at the integration, I likely will not get back to this
until September.
