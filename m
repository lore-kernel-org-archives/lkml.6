Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61645C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 02:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE03208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 02:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JgZvWElV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE03208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756675AbeFPCOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 22:14:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44014 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbeFPCOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 22:14:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5G2EDp4180202
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 02:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=Lu29uZ+k6W+5jSJKPRewoWmEckyNmUdBGloVm+wPFSQ=;
 b=JgZvWElVsyOxJg5p0TEw7MHfLFiN175s5J2K0pi5qAtqu2cebz/hEVISLDF15dK8dj8A
 22+DTDRZbbc3kLWJFdq+oMVZLszD0ZXPD+7ngOVedKRcGGGW1ylaNgofnYyU9hpKR3EU
 xCE8vyvHZVt7OX5u0s4RC2JFEybpIzCusEajQtMxsDG43pXt6uvCvCRfFXY0OL5A6baD
 PBBhXNw/9+OsbUjAdzKO+nH48QrlSGoBaYAtbkYTeaMvelGm38kmcyABgxT9uHhJvgDT
 UmfiQPhC2D9BopmX6kVY4qDHzIeEgw0hnAcKR6HsW2f5GW9IS80MPZtKQ2oQvVWm+00W hw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jk0xrts3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 02:14:13 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5G2E9uU014084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 02:14:09 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5G2E8rE003064
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 02:14:08 GMT
Received: from mail-oi0-f43.google.com (/209.85.218.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jun 2018 19:14:08 -0700
Received: by mail-oi0-f43.google.com with SMTP id e8-v6so10454414oii.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 19:14:08 -0700 (PDT)
X-Gm-Message-State: APt69E2EC1j8l+5Je00ho1N1yLNGQAeXEG+9OwZibI78wDFvcNir3jVe
        vSUCwHJiBHb/sHRo34bu4nvZwrC0PRew/gDAOvk=
X-Google-Smtp-Source: ADUXVKLsOmUoYNkn7wW0UE7V1OftvtQFkRISWQfAFs82MigBiXycf5FTxHMO1zKAeXL/u1/fCxE5S87iRgxlHlYwP1k=
X-Received: by 2002:aca:56c8:: with SMTP id k191-v6mr2158066oib.221.1529115248353;
 Fri, 15 Jun 2018 19:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180615155733.1175-1-pasha.tatashin@oracle.com> <20180615144756.89479279f1506697f87bc61e@linux-foundation.org>
In-Reply-To: <20180615144756.89479279f1506697f87bc61e@linux-foundation.org>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 15 Jun 2018 22:13:32 -0400
X-Gmail-Original-Message-ID: <CAGM2reaZYvoNFcaaYBLm6sCvOP_KTQ-WrLw6=9mMhmu=brEYcQ@mail.gmail.com>
Message-ID: <CAGM2reaZYvoNFcaaYBLm6sCvOP_KTQ-WrLw6=9mMhmu=brEYcQ@mail.gmail.com>
Subject: Re: [PATCH] mm: skip invalid pages block at a time in zero_resv_unresv
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, n-horiguchi@ah.jp.nec.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        osalvador@suse.de, willy@infradead.org, mingo@kernel.org,
        dan.j.williams@intel.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8925 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=7 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806160026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 5:48 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 15 Jun 2018 11:57:33 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
>
> > The role of zero_resv_unavail() is to make sure that every struct page that
> > is allocated but is not backed by memory that is accessible by kernel is
> > zeroed and not in some uninitialized state.
> >
> > Since struct pages are allocated in blocks (2M pages in x86 case), we can
> > skip pageblock_nr_pages at a time, when the first one is found to be
> > invalid.
> >
> > This optimization may help since now on x86 every hole in e820 maps
> > is marked as reserved in memblock, and thus will go through this function.
> >
> > This function is called before sched_clock() is initialized, so I used my
> > x86 early boot clock patches to measure the performance improvement.
> >
> > With 1T hole on i7-8700 currently we would take 0.606918s of boot time, but
> > with this optimization 0.001103s.
>
> This conflicts with mm-zero-remaining-unavailable-struct-pages.patch, below.

Hi Andrew,

mm-zero-remaining-unavailable-struct-pages.patch should be replaced by newer
version:

http://lkml.kernel.org/r/20180615072947.GB23273@hori1.linux.bs1.fc.nec.co.jp

The v3
"[PATCH] x86/e820: put !E820_TYPE_RAM regions into memblock.reserved"
was acked by michal and also I reviewed it.

My patch does not conflict with this newer version, and intends to
help the newer version as there is now potentially more work for
zero_resv_unavail().

Thank you,
Pavel

>
> mm-zero-remaining-unavailable-struct-pages.patch (which you have yet to
> review, please) fixes an oops and is rather higher priority.
>
>
>
> From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Subject: mm: zero remaining unavailable struct pages
>
> There is a kernel panic that is triggered when reading /proc/kpageflags on
> the kernel booted with kernel parameter 'memmap=nn[KMG]!ss[KMG]':
>
>   BUG: unable to handle kernel paging request at fffffffffffffffe
>   PGD 9b20e067 P4D 9b20e067 PUD 9b210067 PMD 0
>   Oops: 0000 [#1] SMP PTI
>   CPU: 2 PID: 1728 Comm: page-types Not tainted 4.17.0-rc6-mm1-v4.17-rc6-180605-0816-00236-g2dfb086ef02c+ #160
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.fc28 04/01/2014
>   RIP: 0010:stable_page_flags+0x27/0x3c0
>   Code: 00 00 00 0f 1f 44 00 00 48 85 ff 0f 84 a0 03 00 00 41 54 55 49 89 fc 53 48 8b 57 08 48 8b 2f 48 8d 42 ff 83 e2 01 48 0f 44 c7 <48> 8b 00 f6 c4 01 0f 84 10 03 00 00 31 db 49 8b 54 24 08 4c 89 e7
>   RSP: 0018:ffffbbd44111fde0 EFLAGS: 00010202
>   RAX: fffffffffffffffe RBX: 00007fffffffeff9 RCX: 0000000000000000
>   RDX: 0000000000000001 RSI: 0000000000000202 RDI: ffffed1182fff5c0
>   RBP: ffffffffffffffff R08: 0000000000000001 R09: 0000000000000001
>   R10: ffffbbd44111fed8 R11: 0000000000000000 R12: ffffed1182fff5c0
>   R13: 00000000000bffd7 R14: 0000000002fff5c0 R15: ffffbbd44111ff10
>   FS:  00007efc4335a500(0000) GS:ffff93a5bfc00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: fffffffffffffffe CR3: 00000000b2a58000 CR4: 00000000001406e0
>   Call Trace:
>    kpageflags_read+0xc7/0x120
>    proc_reg_read+0x3c/0x60
>    __vfs_read+0x36/0x170
>    vfs_read+0x89/0x130
>    ksys_pread64+0x71/0x90
>    do_syscall_64+0x5b/0x160
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   RIP: 0033:0x7efc42e75e23
>   Code: 09 00 ba 9f 01 00 00 e8 ab 81 f4 ff 66 2e 0f 1f 84 00 00 00 00 00 90 83 3d 29 0a 2d 00 00 75 13 49 89 ca b8 11 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 34 c3 48 83 ec 08 e8 db d3 01 00 48 89 04 24
>
> According to kernel bisection, this problem became visible due to commit
> f7f99100d8d9 which changes how struct pages are initialized.
>
> Memblock layout affects the pfn ranges covered by node/zone. Consider
> that we have a VM with 2 NUMA nodes and each node has 4GB memory, and
> the default (no memmap= given) memblock layout is like below:
>
>   MEMBLOCK configuration:
>    memory size = 0x00000001fff75c00 reserved size = 0x000000000300c000
>    memory.cnt  = 0x4
>    memory[0x0]     [0x0000000000001000-0x000000000009efff], 0x000000000009e000 bytes on node 0 flags: 0x0
>    memory[0x1]     [0x0000000000100000-0x00000000bffd6fff], 0x00000000bfed7000 bytes on node 0 flags: 0x0
>    memory[0x2]     [0x0000000100000000-0x000000013fffffff], 0x0000000040000000 bytes on node 0 flags: 0x0
>    memory[0x3]     [0x0000000140000000-0x000000023fffffff], 0x0000000100000000 bytes on node 1 flags: 0x0
>    ...
>
> If you give memmap=1G!4G (so it just covers memory[0x2]),
> the range [0x100000000-0x13fffffff] is gone:
>
>   MEMBLOCK configuration:
>    memory size = 0x00000001bff75c00 reserved size = 0x000000000300c000
>    memory.cnt  = 0x3
>    memory[0x0]     [0x0000000000001000-0x000000000009efff], 0x000000000009e000 bytes on node 0 flags: 0x0
>    memory[0x1]     [0x0000000000100000-0x00000000bffd6fff], 0x00000000bfed7000 bytes on node 0 flags: 0x0
>    memory[0x2]     [0x0000000140000000-0x000000023fffffff], 0x0000000100000000 bytes on node 1 flags: 0x0
>    ...
>
> This causes shrinking node 0's pfn range because it is calculated by
> the address range of memblock.memory. So some of struct pages in the
> gap range are left uninitialized.
>
> We have a function zero_resv_unavail() which does zeroing the struct
> pages outside memblock.memory, but currently it covers only the reserved
> unavailable range (i.e. memblock.memory && !memblock.reserved).
> This patch extends it to cover all unavailable range, which fixes
> the reported issue.
>
> Link: http://lkml.kernel.org/r/20180613054107.GA5329@hori1.linux.bs1.fc.nec.co.jp
> Fixes: f7f99100d8d9 ("mm: stop zeroing memory during allocation in vmemmap")
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Tested-by: Oscar Salvador <osalvador@suse.de>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Steven Sistare <steven.sistare@oracle.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  include/linux/memblock.h |   16 ----------------
>  mm/page_alloc.c          |   33 ++++++++++++++++++++++++---------
>  2 files changed, 24 insertions(+), 25 deletions(-)
>
> diff -puN include/linux/memblock.h~mm-zero-remaining-unavailable-struct-pages include/linux/memblock.h
> --- a/include/linux/memblock.h~mm-zero-remaining-unavailable-struct-pages
> +++ a/include/linux/memblock.h
> @@ -236,22 +236,6 @@ void __next_mem_pfn_range(int *idx, int
>         for_each_mem_range_rev(i, &memblock.memory, &memblock.reserved, \
>                                nid, flags, p_start, p_end, p_nid)
>
> -/**
> - * for_each_resv_unavail_range - iterate through reserved and unavailable memory
> - * @i: u64 used as loop variable
> - * @flags: pick from blocks based on memory attributes
> - * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
> - * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
> - *
> - * Walks over unavailable but reserved (reserved && !memory) areas of memblock.
> - * Available as soon as memblock is initialized.
> - * Note: because this memory does not belong to any physical node, flags and
> - * nid arguments do not make sense and thus not exported as arguments.
> - */
> -#define for_each_resv_unavail_range(i, p_start, p_end)                 \
> -       for_each_mem_range(i, &memblock.reserved, &memblock.memory,     \
> -                          NUMA_NO_NODE, MEMBLOCK_NONE, p_start, p_end, NULL)
> -
>  static inline void memblock_set_region_flags(struct memblock_region *r,
>                                              unsigned long flags)
>  {
> diff -puN mm/page_alloc.c~mm-zero-remaining-unavailable-struct-pages mm/page_alloc.c
> --- a/mm/page_alloc.c~mm-zero-remaining-unavailable-struct-pages
> +++ a/mm/page_alloc.c
> @@ -6390,25 +6390,40 @@ void __paginginit free_area_init_node(in
>   * struct pages which are reserved in memblock allocator and their fields
>   * may be accessed (for example page_to_pfn() on some configuration accesses
>   * flags). We must explicitly zero those struct pages.
> + *
> + * This function also addresses a similar issue where struct pages are left
> + * uninitialized because the physical address range is not covered by
> + * memblock.memory or memblock.reserved. That could happen when memblock
> + * layout is manually configured via memmap=.
>   */
>  void __paginginit zero_resv_unavail(void)
>  {
>         phys_addr_t start, end;
>         unsigned long pfn;
>         u64 i, pgcnt;
> +       phys_addr_t next = 0;
>
>         /*
> -        * Loop through ranges that are reserved, but do not have reported
> -        * physical memory backing.
> +        * Loop through unavailable ranges not covered by memblock.memory.
>          */
>         pgcnt = 0;
> -       for_each_resv_unavail_range(i, &start, &end) {
> -               for (pfn = PFN_DOWN(start); pfn < PFN_UP(end); pfn++) {
> -                       if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
> -                               continue;
> -                       mm_zero_struct_page(pfn_to_page(pfn));
> -                       pgcnt++;
> +       for_each_mem_range(i, &memblock.memory, NULL,
> +                       NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL) {
> +               if (next < start) {
> +                       for (pfn = PFN_DOWN(next); pfn < PFN_UP(start); pfn++) {
> +                               if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
> +                                       continue;
> +                               mm_zero_struct_page(pfn_to_page(pfn));
> +                               pgcnt++;
> +                       }
>                 }
> +               next = end;
> +       }
> +       for (pfn = PFN_DOWN(next); pfn < max_pfn; pfn++) {
> +               if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
> +                       continue;
> +               mm_zero_struct_page(pfn_to_page(pfn));
> +               pgcnt++;
>         }
>
>         /*
> @@ -6419,7 +6434,7 @@ void __paginginit zero_resv_unavail(void
>          * this code can be removed.
>          */
>         if (pgcnt)
> -               pr_info("Reserved but unavailable: %lld pages", pgcnt);
> +               pr_info("Zeroed struct page in unavailable ranges: %lld pages", pgcnt);
>  }
>  #endif /* CONFIG_HAVE_MEMBLOCK */
>
> _
>
