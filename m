Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3218355-1519916994-2-12743884120655978101
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
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
    t=1519916994; b=OqGIMxWlnWX2Lo2E2eoPVa7pwmqE0V56FesxVENdLHFiQ+x
    YzC5/YJbLU5DjlfaKTfsfuz8eGJJBR7y9NYQsAFAeDgQaP5x+TLZS0LSo0wZSm7M
    pN8ofFq0SqC5TagurQRqs1u1Dnufc1OoMpbbI6JNY852hSEDsnKK6+5tziO20Xj3
    Aen7KJO00zhtQ40JKEkCHgSZrKPqnR809TQhuY5giJxF+ZiyW7EJCqlpFkxP/xkx
    FKT0BmLjYKWiRmwIj8ztd6zIQH1RoRLj9lKSHwTUPJUNULzrPfS1amDR+Orh3BzI
    66jE5LD9zqa9WIZK04FiYZyQC+9U81EEMNRGzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519916994; bh=Z0YEfD17EMWqgyXmqTSoq1ldZE32+xyXQSuIES
    R9N0Q=; b=Q/yB+uY5MZqOH5ez2bljlxS180TdaGdjiYw+CRFGSuxayPnbqmiiFh
    MYaZY8ygHGUVcAvDgG0fAqVyGXmHbrCl6hjgFPuYYqWKQGQ9VQWM1un0MMQduzg4
    uqAGHmdE/BOUer5VRGoeP2hsCrvnN/kDFzUKekwfmC+/Mf1qvFHhfFpinQTTkbJy
    68aoFYrWhzO30LPSR8BQXHf9g5/k7TXzufMasfxZJFhgN/PYvgNGQMpOBJfb6uug
    BQub+IqxxKwKITnHSaY2MnQmiz4xq8fx1yU0qudFwlxLnZ9cXaUmMASxn4P6uXdB
    nz9ocylMx7VQRLzvxsAo0Rnb8aemj55A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Sb0oguKI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Sb0oguKI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031784AbeCAPJi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 10:09:38 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:47027 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031707AbeCAPJh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 10:09:37 -0500
X-Google-Smtp-Source: AG47ELv89/phd+jptLsHYQDPlyB4uhd+Stdx4QMHAh+EfRGFvXF21Nz5B/lK2Q+UWWhsYOAhd74UW+wVjg/6QTU6Fhw=
MIME-Version: 1.0
In-Reply-To: <20180301131033.GH15057@dhcp22.suse.cz>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com> <20180301131033.GH15057@dhcp22.suse.cz>
From: Daniel Vacek <neelx@redhat.com>
Date: Thu, 1 Mar 2018 16:09:35 +0100
Message-ID: <CACjP9X-S=OgmUw-WyyH971_GREn1WzrG3aeGkKLyR1bO4_pWPA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: fix memmap_init_zone pageblock alignment
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ffffe31d01ed8000  7b600000                0        0  0 0
On Thu, Mar 1, 2018 at 2:10 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Thu 01-03-18 13:47:45, Daniel Vacek wrote:
>> In move_freepages() a BUG_ON() can be triggered on uninitialized page structures
>> due to pageblock alignment. Aligning the skipped pfns in memmap_init_zone() the
>> same way as in move_freepages_block() simply fixes those crashes.
>
> This changelog doesn't describe how the fix works. Why doesn't
> memblock_next_valid_pfn return the first valid pfn as one would expect?

Actually it does. The point is it is not guaranteed to be pageblock
aligned. And we
actually want to initialize even those page structures which are
outside of the range.
Hence the alignment here.

For example from reproducer machine, memory map from e820/BIOS:

$ grep 7b7ff000 /proc/iomem
7b7ff000-7b7fffff : System RAM

Page structures before commit b92df1de5d28:

crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b7fe000 7b7ff000
7b800000 7ffff000 80000000
      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
fffff73941e00000  78000000                0        0  1 1fffff00000000
fffff73941ed7fc0  7b5ff000                0        0  1 1fffff00000000
fffff73941ed8000  7b600000                0        0  1 1fffff00000000
fffff73941edff80  7b7fe000                0        0  1 1fffff00000000
fffff73941edffc0  7b7ff000 ffff8e67e04d3ae0     ad84  1 1fffff00020068
uptodate,lru,active,mappedtodisk    <<<< start of the range here
fffff73941ee0000  7b800000                0        0  1 1fffff00000000
fffff73941ffffc0  7ffff000                0        0  1 1fffff00000000

So far so good.

After commit b92df1de5d28 machine eventually crashes with:

BUG at mm/page_alloc.c:1913

>         VM_BUG_ON(page_zone(start_page) != page_zone(end_page));

>From registers and stack I digged start_page points to
ffffe31d01ed8000 (note that this is
page ffffe31d01edffc0 aligned to pageblock) and I can see this in memory dump:

crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b7fe000 7b7ff000
7b800000 7ffff000 80000000
      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
ffffe31d01e00000  78000000                0        0  0 0
ffffe31d01ed7fc0  7b5ff000                0        0  0 0
ffffe31d01ed8000  7b600000                0        0  0 0    <<<< note
that nodeid and zonenr are encoded in top bits of page flags which are
not initialized here, hence the crash :-(
ffffe31d01edff80  7b7fe000                0        0  0 0
ffffe31d01edffc0  7b7ff000                0        0  1 1fffff00000000
ffffe31d01ee0000  7b800000                0        0  1 1fffff00000000
ffffe31d01ffffc0  7ffff000                0        0  1 1fffff00000000

With my fix applied:

crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b7fe000 7b7ff000
7b800000 7ffff000 80000000
      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
ffffea0001e00000  78000000                0        0  0 0
ffffea0001e00000  7b5ff000                0        0  0 0
ffffea0001ed8000  7b600000                0        0  1 1fffff00000000
   <<<< vital data filled in here this time \o/
ffffea0001edff80  7b7fe000                0        0  1 1fffff00000000
ffffea0001edffc0  7b7ff000 ffff88017fb13720        8  2 1fffff00020068
uptodate,lru,active,mappedtodisk
ffffea0001ee0000  7b800000                0        0  1 1fffff00000000
ffffea0001ffffc0  7ffff000                0        0  1 1fffff00000000

We are not interested in the beginning of whole section. Just the
pages in the first
populated block where the range begins are important (actually just
the first one really, but...).


> It would be also good put the panic info in the changelog.

Of course I forgot to link the related bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=196443

Though it is not very well explained there as well. I hope my notes
above make it clear.


>> Fixes: b92df1de5d28 ("[mm] page_alloc: skip over regions of invalid pfns where possible")
>> Signed-off-by: Daniel Vacek <neelx@redhat.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  mm/page_alloc.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index cb416723538f..9edee36e6a74 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5359,9 +5359,14 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>>                       /*
>>                        * Skip to the pfn preceding the next valid one (or
>>                        * end_pfn), such that we hit a valid pfn (or end_pfn)
>> -                      * on our next iteration of the loop.
>> +                      * on our next iteration of the loop. Note that it needs
>> +                      * to be pageblock aligned even when the region itself
>> +                      * is not as move_freepages_block() can shift ahead of
>> +                      * the valid region but still depends on correct page
>> +                      * metadata.
>>                        */
>> -                     pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
>> +                     pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
>> +                                             ~(pageblock_nr_pages-1)) - 1;
>>  #endif
>>                       continue;
>>               }
>> --
>> 2.16.2
>>
>
> --
> Michal Hocko
> SUSE Labs
