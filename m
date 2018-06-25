Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671A4C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA6724FD3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA6724FD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934642AbeFYPAn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:00:43 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46971 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934575AbeFYPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:00:39 -0400
Received: by mail-ot0-f196.google.com with SMTP id v24-v6so15363485otk.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z6O0ISdK3m2j53R8xvBKVVz+RSUDTuxZtPNbqmUAhWE=;
        b=tsiIOeNNWCcBMdngaFr1FhQtjbsfjOVvjW1+9eRf6lfagqC0zmsmMTXKjAJQC8F405
         qOp/wDc1KdOlnHesd7jyw4RzrhPUBlzij1YgTiGxKQ+aa22mBOxOqBPGM6FtrxE3N4VF
         pOTVzCY76nV848yHRH4/ohfjnIxzgWxNyxFGQ6KpD6joSJnTuTjUOi18nfQpCdbik9e2
         4d94FczxQmbexBHhpBdy9D2xM4DKruFe1FZ94r/MVCES41Lie8uPNBE6mWWxQ08FIg2D
         ivFwAXmVIpeoEo1bBYrIrm+7VPqwl3ZgxteZLyzfHzxmllUzeJk5wqkwNQuI391q758P
         p3NQ==
X-Gm-Message-State: APt69E3Y2e/Dzu4xp++/o2PSZ+mAMKXEsFBttxyVtxd+2TF7ZNrYp0ca
        c7a7dmQyCevwnmMHMK/7SBt2vUnGvpvJ0KD8zH3U/A==
X-Google-Smtp-Source: AAOMgpdZCUnaPbEXnV726N9oy6zGtAeWrQnB5awvjFT07RAhJCYtgQoVTJuT1NDyXcbWR704LiYpyaCwGsVzFoB6G34=
X-Received: by 2002:a9d:624:: with SMTP id 33-v6mr4533543otn.327.1529938838133;
 Mon, 25 Jun 2018 08:00:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2b2c:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 08:00:37
 -0700 (PDT)
In-Reply-To: <20180621190721.bdr42xmp6f2uba7x@pburton-laptop>
References: <20180316143855.29838-1-neelx@redhat.com> <20180621190721.bdr42xmp6f2uba7x@pburton-laptop>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Mon, 25 Jun 2018 17:00:37 +0200
Message-ID: <CACjP9X9mSg0LM=JvWHPzMUsG_y9UHinC6aJnpPLE==5xR4MnHw@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm: page_alloc: skip over regions of invalid pfns
 where possible"
To:     Paul Burton <paul.burton@mips.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 9:07 PM, Paul Burton <paul.burton@mips.com> wrote:
> Hi Daniel,
>
> Hmm... I only just noticed this because you CC'd an email address that
> is no longer functional. I presume you're not using .mailmap, which
> would have given you my current email address.

Hi Paul,

  I do not remember exactly but I guess I used either get_maintainers
script or the email from your commit. I'm sorry for the inconvenience.

> On Fri, Mar 16, 2018 at 03:38:55PM +0100, Daniel Vacek wrote:
>> This reverts commit b92df1de5d289c0b5d653e72414bf0850b8511e0. The commit
>> is meant to be a boot init speed up skipping the loop in memmap_init_zone()
>> for invalid pfns. But given some specific memory mapping on x86_64 (or more
>> generally theoretically anywhere but on arm with CONFIG_HAVE_ARCH_PFN_VALID)
>
> My patch definitely wasn't ARM-specific & I have never tested it on ARM.
> It was motivated by a MIPS platform with an extremely sparse memory map.
> Could you explain why you think it depends on ARM or
> CONFIG_HAVE_ARCH_PFN_VALID?

  Hopefully explained further below.

>> the implementation also skips valid pfns which is plain wrong and causes
>> 'kernel BUG at mm/page_alloc.c:1389!'
>
> Which VM_BUG_ON is that? I don't see one on line 1389 as of commit
> b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns where
> possible") or any mainline final release since.

  The report was from RHEL kernel actually. But it still applied to
upstream tree. It was this one
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/page_alloc.c?id=274a1ff0704bc8fef76dbe2d6fb197ddbc23f380#n1913
later changed with commit 3e04040df6d4 which I believe does not really
change or improve much anything, unfortunately...

>> crash> log | grep -e BUG -e RIP -e Call.Trace -e move_freepages_block -e rmqueue -e freelist -A1
>> kernel BUG at mm/page_alloc.c:1389!
>> invalid opcode: 0000 [#1] SMP
>> --
>> RIP: 0010:[<ffffffff8118833e>]  [<ffffffff8118833e>] move_freepages+0x15e/0x160
>> RSP: 0018:ffff88054d727688  EFLAGS: 00010087
>> --
>> Call Trace:
>>  [<ffffffff811883b3>] move_freepages_block+0x73/0x80
>>  [<ffffffff81189e63>] __rmqueue+0x263/0x460
>>  [<ffffffff8118c781>] get_page_from_freelist+0x7e1/0x9e0
>>  [<ffffffff8118caf6>] __alloc_pages_nodemask+0x176/0x420
>> --
>> RIP  [<ffffffff8118833e>] move_freepages+0x15e/0x160
>>  RSP <ffff88054d727688>
>>
>> crash> page_init_bug -v | grep RAM
>> <struct resource 0xffff88067fffd2f8>          1000 -        9bfff       System RAM (620.00 KiB)
>> <struct resource 0xffff88067fffd3a0>        100000 -     430bffff       System RAM (  1.05 GiB = 1071.75 MiB = 1097472.00 KiB)
>> <struct resource 0xffff88067fffd410>      4b0c8000 -     4bf9cfff       System RAM ( 14.83 MiB = 15188.00 KiB)
>> <struct resource 0xffff88067fffd480>      4bfac000 -     646b1fff       System RAM (391.02 MiB = 400408.00 KiB)
>> <struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff       System RAM (480.00 KiB)
>> <struct resource 0xffff88067fffd640>     100000000 -    67fffffff       System RAM ( 22.00 GiB)
>>
>> crash> page_init_bug | head -6
>> <struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff       System RAM (480.00 KiB)
>> <struct page 0xffffea0001ede200>   1fffff00000000  0 <struct pglist_data 0xffff88047ffd9000> 1 <struct zone 0xffff88047ffd9800> DMA32          4096    1048575
>> <struct page 0xffffea0001ede200> 505736 505344 <struct page 0xffffea0001ed8000> 505855 <struct page 0xffffea0001edffc0>
>> <struct page 0xffffea0001ed8000>                0  0 <struct pglist_data 0xffff88047ffd9000> 0 <struct zone 0xffff88047ffd9000> DMA               1       4095
>> <struct page 0xffffea0001edffc0>   1fffff00000400  0 <struct pglist_data 0xffff88047ffd9000> 1 <struct zone 0xffff88047ffd9800> DMA32          4096    1048575
>> BUG, zones differ!
>>
>> crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b787000 7b788000
>>       PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
>> ffffea0001e00000  78000000                0        0  0 0
>> ffffea0001ed7fc0  7b5ff000                0        0  0 0
>> ffffea0001ed8000  7b600000                0        0  0 0       <<<<
>> ffffea0001ede1c0  7b787000                0        0  0 0
>> ffffea0001ede200  7b788000                0        0  1 1fffff00000000
>
> I'm not really sure what I'm looking at here. I presume you're saying
> that memmap_init_zone() didn't initialize the struct page for
> phys=0x7b788000?

  Quite the opposite. It's the first one which gets correctly
initialized as it is the start of next usable range as returned by
memblock_next_valid_pfn(). Though early_pfn_valid() returns true for
all frames in this section starting with 0x78000 (at least on x86
where it is based on the memsection implementation) so the next valid
pfn should correctly be frame 0x78000 instead of 0x7b788. The crash
was caused by accessing page 0xffffea0001ed8000 (covering phys
0x7b600000) as move_freepages_block() aligns the start_pfn to
pageblock_nr_pages before calling move_freepages().

  The arm implementation of early_pfn_valid() is actually based on
memblock and returns false for frames 0x78000 through 0x7b787 hence I
thought you based the memblock_next_valid_pfn() implementation on this
ARM semantics enabled by CONFIG_HAVE_ARCH_PFN_VALID instead of the
generic early_pfn_valid() version based on memory sections
implementation.

  When I am thinking about it now, instead of reverting it could also
have been #ifdefed on CONFIG_HAVE_ARCH_PFN_VALID. That way ARM could
still use the advantage but not MIPS I believe.

> Could you describe the memblock region list, and what ranges
> memmap_init_zone() skipped over?

  I guess that's already explained above. The memblock regions matched
the usable 'System RAM' ranges as dumped from iomem resources in my
commit message, IIRC. Let me dump the data if I can still find it.

crash> memblock.memory.cnt,memory.regions memblock
  memory.cnt = 0x7,
  memory.regions = 0xffffffff81af1140 <memblock_memory_init_regions>

crash> memblock_region.base,size,flags,nid
memblock_memory_init_regions 7 | sed 's/^  /\t/' | paste - - - - - |
column -ts'     '
base = 0x1000       size = 0x9b000      flags = 0x0  nid = 0x0
base = 0x100000     size = 0x42fc0000   flags = 0x0  nid = 0x0
base = 0x4b0c8000   size = 0xed5000     flags = 0x0  nid = 0x0
base = 0x4bfac000   size = 0x18706000   flags = 0x0  nid = 0x0
base = 0x7b788000   size = 0x78000      flags = 0x0  nid = 0x0
base = 0x100000000  size = 0x380000000  flags = 0x0  nid = 0x0
base = 0x480000000  size = 0x200000000  flags = 0x0  nid = 0x1

  Yeah, so it matches with the node break added.

> Thanks,
>     Paul

Thank you for looking into it! If you have any further questions, just
drop me an email. And have a nice day.

--nX
