Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3278546-1521213232-2-9944626695538528131
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521213231; b=PU3sgfb8lqswnn6k1iff3sl7xGEEBuYq27yEfVfcbnk2sh+
    ZFY/YzeEbBwZG/I7x+u4oce4niwGzD0q3shOgRu7RR3vP3o3vt4gemGiwoS6/Lbq
    zG44lJB3Iq/kkotw9b7l/TyMgrRg2P3ASseiPqt0oR50NLCMfg570PqgQJcmGPUu
    CuV2D7CrLq4t4AIn2wR7BFWGW6cai26Ngx5RQsebtMipFohtz9lGoytSQa3j27ig
    MQCTR+lg8uEn65Qkf5hbu2iJj5iZUCjrjhQ1Nvp2Pb9/b5RBTBAMT1RYDhgzLXhD
    zyv9MRHt3sOEhzvFSqV2+DXQv4xfeOQFSrxkGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521213231; bh=WR+ppwuYFT14J53Z14jL92SOjd9FAg5uzDgt6Z
    LjXV4=; b=PKSv2HmrXXMtN/cSQSaKFu7xR2Wt8jMUkxHZIHrUxVLj83dgGMsF+x
    Y2jPEyTnzas150NeR6mxXYQZ8Ysc4SwjtH1H0fQZZZ0FqnTKR/Js7naNnJgtrdag
    5VisT7KTsznqPn3khqYaUTwNaZxFCoXQ0UOaax8pwjl67/HxpUBn30Mb3bNE7VnV
    KeFcoS16cZBVyjpqT9H1jCir73wBWLjTVQGQmsaf32kZwKRFynIWDiCn3xkZ+E/2
    sjp1v8eD8g8c7N9n3g39Mcf6ad3YM0b1PJLn1XpYltEv7nqfaanxmnfzcqpGwABN
    SlI4f8ZWmyUaaSyK9WmGHc/U8nX5D4RQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZGXbyxOv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZGXbyxOv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbeCPPNt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:13:49 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35761 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeCPPNs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:13:48 -0400
X-Google-Smtp-Source: AG47ELu0CIBfybsQy3rvcZiKojrsuW1BUVDWgmsqgPNckQJqe+NkCPTGPSUkjp1CCqDbxen+ayQweQwkqKs2Uj2v4pY=
MIME-Version: 1.0
In-Reply-To: <20180316143855.29838-1-neelx@redhat.com>
References: <20180316143855.29838-1-neelx@redhat.com>
From: Daniel Vacek <neelx@redhat.com>
Date: Fri, 16 Mar 2018 16:13:47 +0100
Message-ID: <CACjP9X_RLrb93JDoToW2MzNmmQYjbutnaF0Qcu8wEY7gn60TUw@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm: page_alloc: skip over regions of invalid pfns
 where possible"
To: open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Vacek <neelx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sorry I forgot to Cc: Paul Burton <paul.burton@imgtec.com>

--nX

On Fri, Mar 16, 2018 at 3:38 PM, Daniel Vacek <neelx@redhat.com> wrote:
> This reverts commit b92df1de5d289c0b5d653e72414bf0850b8511e0. The commit
> is meant to be a boot init speed up skipping the loop in memmap_init_zone()
> for invalid pfns. But given some specific memory mapping on x86_64 (or more
> generally theoretically anywhere but on arm with CONFIG_HAVE_ARCH_PFN_VALID)
> the implementation also skips valid pfns which is plain wrong and causes
> 'kernel BUG at mm/page_alloc.c:1389!'
>
> crash> log | grep -e BUG -e RIP -e Call.Trace -e move_freepages_block -e rmqueue -e freelist -A1
> kernel BUG at mm/page_alloc.c:1389!
> invalid opcode: 0000 [#1] SMP
> --
> RIP: 0010:[<ffffffff8118833e>]  [<ffffffff8118833e>] move_freepages+0x15e/0x160
> RSP: 0018:ffff88054d727688  EFLAGS: 00010087
> --
> Call Trace:
>  [<ffffffff811883b3>] move_freepages_block+0x73/0x80
>  [<ffffffff81189e63>] __rmqueue+0x263/0x460
>  [<ffffffff8118c781>] get_page_from_freelist+0x7e1/0x9e0
>  [<ffffffff8118caf6>] __alloc_pages_nodemask+0x176/0x420
> --
> RIP  [<ffffffff8118833e>] move_freepages+0x15e/0x160
>  RSP <ffff88054d727688>
>
> crash> page_init_bug -v | grep RAM
> <struct resource 0xffff88067fffd2f8>          1000 -        9bfff       System RAM (620.00 KiB)
> <struct resource 0xffff88067fffd3a0>        100000 -     430bffff       System RAM (  1.05 GiB = 1071.75 MiB = 1097472.00 KiB)
> <struct resource 0xffff88067fffd410>      4b0c8000 -     4bf9cfff       System RAM ( 14.83 MiB = 15188.00 KiB)
> <struct resource 0xffff88067fffd480>      4bfac000 -     646b1fff       System RAM (391.02 MiB = 400408.00 KiB)
> <struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff       System RAM (480.00 KiB)
> <struct resource 0xffff88067fffd640>     100000000 -    67fffffff       System RAM ( 22.00 GiB)
>
> crash> page_init_bug | head -6
> <struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff       System RAM (480.00 KiB)
> <struct page 0xffffea0001ede200>   1fffff00000000  0 <struct pglist_data 0xffff88047ffd9000> 1 <struct zone 0xffff88047ffd9800> DMA32          4096    1048575
> <struct page 0xffffea0001ede200> 505736 505344 <struct page 0xffffea0001ed8000> 505855 <struct page 0xffffea0001edffc0>
> <struct page 0xffffea0001ed8000>                0  0 <struct pglist_data 0xffff88047ffd9000> 0 <struct zone 0xffff88047ffd9000> DMA               1       4095
> <struct page 0xffffea0001edffc0>   1fffff00000400  0 <struct pglist_data 0xffff88047ffd9000> 1 <struct zone 0xffff88047ffd9800> DMA32          4096    1048575
> BUG, zones differ!
>
> crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b787000 7b788000
>       PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
> ffffea0001e00000  78000000                0        0  0 0
> ffffea0001ed7fc0  7b5ff000                0        0  0 0
> ffffea0001ed8000  7b600000                0        0  0 0       <<<<
> ffffea0001ede1c0  7b787000                0        0  0 0
> ffffea0001ede200  7b788000                0        0  1 1fffff00000000
>
> Fixes: b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns where possible")
> Signed-off-by: Daniel Vacek <neelx@redhat.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: stable@vger.kernel.org
> ---
>  include/linux/memblock.h |  1 -
>  mm/memblock.c            | 28 ----------------------------
>  mm/page_alloc.c          | 11 +----------
>  3 files changed, 1 insertion(+), 39 deletions(-)
>
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 8be5077efb5f..f92ea7783652 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -187,7 +187,6 @@ int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
>                             unsigned long  *end_pfn);
>  void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
>                           unsigned long *out_end_pfn, int *out_nid);
> -unsigned long memblock_next_valid_pfn(unsigned long pfn, unsigned long max_pfn);
>
>  /**
>   * for_each_mem_pfn_range - early memory pfn range iterator
> diff --git a/mm/memblock.c b/mm/memblock.c
> index b6ba6b7adadc..48376bd33274 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1101,34 +1101,6 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
>                 *out_nid = r->nid;
>  }
>
> -unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
> -                                                     unsigned long max_pfn)
> -{
> -       struct memblock_type *type = &memblock.memory;
> -       unsigned int right = type->cnt;
> -       unsigned int mid, left = 0;
> -       phys_addr_t addr = PFN_PHYS(++pfn);
> -
> -       do {
> -               mid = (right + left) / 2;
> -
> -               if (addr < type->regions[mid].base)
> -                       right = mid;
> -               else if (addr >= (type->regions[mid].base +
> -                                 type->regions[mid].size))
> -                       left = mid + 1;
> -               else {
> -                       /* addr is within the region, so pfn is valid */
> -                       return pfn;
> -               }
> -       } while (left < right);
> -
> -       if (right == type->cnt)
> -               return -1UL;
> -       else
> -               return PHYS_PFN(type->regions[right].base);
> -}
> -
>  /**
>   * memblock_set_node - set node ID on memblock regions
>   * @base: base of area to set node ID for
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 635d7dd29d7f..e4566a3f8083 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5356,17 +5356,8 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>                 if (context != MEMMAP_EARLY)
>                         goto not_early;
>
> -               if (!early_pfn_valid(pfn)) {
> -#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
> -                       /*
> -                        * Skip to the pfn preceding the next valid one (or
> -                        * end_pfn), such that we hit a valid pfn (or end_pfn)
> -                        * on our next iteration of the loop.
> -                        */
> -                       pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
> -#endif
> +               if (!early_pfn_valid(pfn))
>                         continue;
> -               }
>                 if (!early_pfn_in_nid(pfn, nid))
>                         continue;
>                 if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
> --
> 2.16.2
>
