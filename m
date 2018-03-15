Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-512551-1521128350-2-16265147667582482028
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
    t=1521128349; b=OK+tXE4+agJu4t5p0o5N9YzUwZkcCtAJJED2D5K6nGJ7CVP
    NGSEq9gGilbVuUk1c4VfVYzUBo+ClSoDKQY9FOloqMdXpvmhBSRzk/zDSCAkImQH
    uxJla4phR0iFrVzjos3mbqEdGD2axWSXfzo1D4ti6hCG0GqrcAjlt95GUGj8a14F
    VJCgC/AJ4kzswB5yD1JyjXeh5/LcLF25j6zUiAXIyRhx4b9ghffeBulaxd4CqgD/
    ilkM89vK/6GJ0KtG7hQ+60ugCz58TSknDdF63GAQujMbj8zcJzcmLoG5/l6EG0FI
    SD+UExuLbP2ylPB8wK1IdimTRI/wM3/4IEncWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521128349; bh=GJd8pivFQhI61eFC9kG01wLxGh9JXTMy24OOow
    ZH4DU=; b=ItGnBzSfrTmq9JoED8Qmi3/KGH8KGCMhx/DbqvPEbN6uTUPfVDdgfk
    UTAwO64dWotAiVPMvKFw0r5a5xo0zc6WaiHlipScey6J+RGbyODrGr4CMfA3H63j
    A7U3wDmVt0RaeFZoIlb92aammSnx0GqrHCvu4FOzHP+QYCmVi3HEvhEdVNIljau0
    vzNahpvasiMYKZvUTZmOVSbEgOxNx8lIznquY+HWZSBGTySwnukIX2+lAG1ceptQ
    vDyu0G+BKww44bQov6BvDT0V+QrO+foULb4nqzg8fcRX3umMzQK/DWWTM2qGSln9
    8MH8g3EQBAUnyaA3xiqd1Fvjj+6AFV+g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZrRmDk6j;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZrRmDk6j;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeCOPjI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 11:39:08 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34831 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbeCOPjG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Mar 2018 11:39:06 -0400
X-Google-Smtp-Source: AG47ELsDEguYzRO4/ssX4tI85jItSbQuC4WBO2thpyB+fnyyTej+uUL4ZeZlcAj2xISpuFQjdIGEl3U2tWKmgmUYTRY=
MIME-Version: 1.0
In-Reply-To: <049a38e2-c446-85f4-656c-91d4e5bb1c0d@gmail.com>
References: <20180313224240.25295-1-neelx@redhat.com> <049a38e2-c446-85f4-656c-91d4e5bb1c0d@gmail.com>
From: Daniel Vacek <neelx@redhat.com>
Date: Thu, 15 Mar 2018 16:39:04 +0100
Message-ID: <CACjP9X_01nuv86WeETjOFgNYQkvUFaE8089yX9fgq9uB8zpPTQ@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: fix boot hang in memmap_init_zone
To: Jia He <hejianet@gmail.com>
Cc: open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        stable <stable@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 3:08 PM, Jia He <hejianet@gmail.com> wrote:
> Hi Daniel
>
>
>
> On 3/14/2018 6:42 AM, Daniel Vacek Wrote:
>>
>> On some architectures (reported on arm64) commit 864b75f9d6b01
>> ("mm/page_alloc: fix memmap_init_zone pageblock alignment")
>> causes a boot hang. This patch fixes the hang making sure the alignment
>> never steps back.
>>
>> Link:
>> http://lkml.kernel.org/r/0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com
>> Fixes: 864b75f9d6b01 ("mm/page_alloc: fix memmap_init_zone pageblock
>> alignment")
>> Signed-off-by: Daniel Vacek <neelx@redhat.com>
>> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
>> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Paul Burton <paul.burton@imgtec.com>
>> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: <stable@vger.kernel.org>
>> ---
>>   mm/page_alloc.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 3d974cb2a1a1..e033a6895c6f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5364,9 +5364,14 @@ void __meminit memmap_init_zone(unsigned long size,
>> int nid, unsigned long zone,
>>                          * is not. move_freepages_block() can shift ahead
>> of
>>                          * the valid region but still depends on correct
>> page
>>                          * metadata.
>> +                        * Also make sure we never step back.
>>                          */
>> -                       pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
>> +                       unsigned long next_pfn;
>> +
>> +                       next_pfn = (memblock_next_valid_pfn(pfn, end_pfn)
>> &
>>                                         ~(pageblock_nr_pages-1)) - 1;
>> +                       if (next_pfn > pfn)
>> +                               pfn = next_pfn;
>
> It didn't resolve the booting hang issue in my arm64 server.
> what if memblock_next_valid_pfn(pfn, end_pfn) is 32 and pageblock_nr_pages
> is 8196?
> Thus, next_pfn will be (unsigned long)-1 and be larger than pfn.
> So still there is an infinite loop here.

Hi Jia,

Yeah, looks like another uncovered case. Noone reported this so far.
Anyways upstream reverted all this for now and we're discussing the
right approach here.

In any case thanks for this report. Can you share something like below
from your machine?

   Booting Linux on physical CPU 0x0000000000 [0x410fd034]
   Linux version 4.16.0-rc5-00004-gfc6eabbbf8ef-dirty (ard@dogfood) ...
   Machine model: Socionext Developer Box
   earlycon: pl11 at MMIO 0x000000002a400000 (options '')
   bootconsole [pl11] enabled
   efi: Getting EFI parameters from FDT:
   efi: EFI v2.70 by Linaro
   efi:  SMBIOS 3.0=0xff580000  ESRT=0xf9948198  MEMATTR=0xf83b1a98
RNG=0xff7ac898
   random: fast init done
   efi: seeding entropy pool
   esrt: Reserving ESRT space from 0x00000000f9948198 to 0x00000000f99481d0.
   cma: Reserved 16 MiB at 0x00000000fd800000
   NUMA: No NUMA configuration found
   NUMA: Faking a node at [mem 0x0000000000000000-0x0000000fffffffff]
   NUMA: NODE_DATA [mem 0xffffd8d80-0xffffda87f]
   Zone ranges:
     DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
     Normal   [mem 0x0000000100000000-0x0000000fffffffff]
   Movable zone start for each node
   Early memory node ranges
     node   0: [mem 0x0000000080000000-0x00000000febeffff]
     node   0: [mem 0x00000000febf0000-0x00000000fefcffff]
     node   0: [mem 0x00000000fefd0000-0x00000000ff43ffff]
     node   0: [mem 0x00000000ff440000-0x00000000ff7affff]
     node   0: [mem 0x00000000ff7b0000-0x00000000ffffffff]
     node   0: [mem 0x0000000880000000-0x0000000fffffffff]
   Initmem setup node 0 [mem 0x0000000080000000-0x0000000fffffffff]


Thank you.

--nX

> Cheers,
> Jia He
>>
>>   #endif
>>                         continue;
>>                 }
>
>
> --
> Cheers,
> Jia
>
