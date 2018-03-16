Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1615926-1521161148-2-4967346662597200450
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521161147; b=oUKW6nw1AOX5HTfrQP8AdY0R6vD+EWL3qK2xRCKSLK503yW
    /OPBxukviqJ5hckXOZLnjjkDtGU181zId7FkQrucTdj/P017gfRE0pwpc3iLkN4/
    1jcvOSbm9EE95Ud+hk/rAcERnReLP59NPMTPfXvh2IGeXnsMsCQBaS0pBNDV5lTJ
    lGYJehe1/5lf0wvlPl0QOASOVQ4gBDmWo69fS+0rcUG2yx84mch4WIQVWRKF2KkR
    600suxEK6mki7C7e3AOxeybwH3mOaEZw+bIvBBzbvorn/KdZgz9gNHbGG+XAFpWj
    M8S2rtMFEzac500o0LSk0RqtlGEF4Cvzp/gNwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521161147; bh=+mFFyw5uwpjoa7C5lstRC3riFAWDB8WSCYbkzkPT6Vc=; b=V
    XHrf6kW7Bp+mVwKrd2fr4T7xVD9oluL2Y+/DY/pfsuM7LoNM4DDArwGW8upIS/v6
    DebXPoGc4yYrPEO57es3xjN0Dv3TlJedTnHAbej1XbU/k4DpWxxwd8Gntghmry0Y
    A/ec6F4uNA4aRl3fTemQPHAnGg9t2Ftk22EaDM2oCwqSYkiPGVdwCwUy082vRSpU
    Bn2U5uKa3QFhLImS3UE9Zip/gO4P249U316l2mMLgxrN4+nsXwLp/CTM94ZDXIr6
    rgp59HmsYXLmxirHH7Ev00oog52YNQz3Z+0gQk9mIer3KJCi8o1tjJMqCBmfJIAP
    8nuYxpEMsvp97c1j9YeaA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qOj4wUZ+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=glLSOKhj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qOj4wUZ+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=glLSOKhj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932689AbeCPApq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 20:45:46 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36563 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932094AbeCPApo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Mar 2018 20:45:44 -0400
X-Google-Smtp-Source: AG47ELvmYt94HF8I/1tVLaL1rkHOGtQgh8QIuPZe2stNu5jA/E94+Z/9FmTDEthfPTLs4IB94vL8Lg==
Subject: Re: [PATCH] mm/page_alloc: fix boot hang in memmap_init_zone
To: Daniel Vacek <neelx@redhat.com>
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
References: <20180313224240.25295-1-neelx@redhat.com>
 <049a38e2-c446-85f4-656c-91d4e5bb1c0d@gmail.com>
 <CACjP9X_01nuv86WeETjOFgNYQkvUFaE8089yX9fgq9uB8zpPTQ@mail.gmail.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <b391f698-5619-4946-bac7-5ba39628335e@gmail.com>
Date: Fri, 16 Mar 2018 08:45:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACjP9X_01nuv86WeETjOFgNYQkvUFaE8089yX9fgq9uB8zpPTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/15/2018 11:39 PM, Daniel Vacek Wrote:
> On Thu, Mar 15, 2018 at 3:08 PM, Jia He <hejianet@gmail.com> wrote:
>> Hi Daniel
>>
>>
>>
>> On 3/14/2018 6:42 AM, Daniel Vacek Wrote:
>>> On some architectures (reported on arm64) commit 864b75f9d6b01
>>> ("mm/page_alloc: fix memmap_init_zone pageblock alignment")
>>> causes a boot hang. This patch fixes the hang making sure the alignment
>>> never steps back.
>>>
>>> Link:
>>> http://lkml.kernel.org/r/0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com
>>> Fixes: 864b75f9d6b01 ("mm/page_alloc: fix memmap_init_zone pageblock
>>> alignment")
>>> Signed-off-by: Daniel Vacek <neelx@redhat.com>
>>> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
>>> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Mel Gorman <mgorman@techsingularity.net>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Paul Burton <paul.burton@imgtec.com>
>>> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>    mm/page_alloc.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 3d974cb2a1a1..e033a6895c6f 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -5364,9 +5364,14 @@ void __meminit memmap_init_zone(unsigned long size,
>>> int nid, unsigned long zone,
>>>                           * is not. move_freepages_block() can shift ahead
>>> of
>>>                           * the valid region but still depends on correct
>>> page
>>>                           * metadata.
>>> +                        * Also make sure we never step back.
>>>                           */
>>> -                       pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
>>> +                       unsigned long next_pfn;
>>> +
>>> +                       next_pfn = (memblock_next_valid_pfn(pfn, end_pfn)
>>> &
>>>                                          ~(pageblock_nr_pages-1)) - 1;
>>> +                       if (next_pfn > pfn)
>>> +                               pfn = next_pfn;
>> It didn't resolve the booting hang issue in my arm64 server.
>> what if memblock_next_valid_pfn(pfn, end_pfn) is 32 and pageblock_nr_pages
>> is 8196?
>> Thus, next_pfn will be (unsigned long)-1 and be larger than pfn.
>> So still there is an infinite loop here.
> Hi Jia,
>
> Yeah, looks like another uncovered case. Noone reported this so far.
> Anyways upstream reverted all this for now and we're discussing the
> right approach here.
>
> In any case thanks for this report. Can you share something like below
> from your machine?
sure.
[    0.000000] NUMA: Faking a node at [mem 
0x0000000000000000-0x00000017ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x17ffffcb80-0x17ffffffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000200000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000017ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000200000-0x000000000021ffff]
[    0.000000]   node   0: [mem 0x0000000000820000-0x000000000307ffff]
[    0.000000]   node   0: [mem 0x0000000003080000-0x000000000308ffff]
[    0.000000]   node   0: [mem 0x0000000003090000-0x00000000031fffff]
[    0.000000]   node   0: [mem 0x0000000003200000-0x00000000033fffff]
[    0.000000]   node   0: [mem 0x0000000003410000-0x000000000563ffff]
[    0.000000]   node   0: [mem 0x0000000005640000-0x000000000567ffff]
[    0.000000]   node   0: [mem 0x0000000005680000-0x00000000056dffff]
[    0.000000]   node   0: [mem 0x00000000056e0000-0x00000000086fffff]
[    0.000000]   node   0: [mem 0x0000000008700000-0x000000000871ffff]
[    0.000000]   node   0: [mem 0x0000000008720000-0x000000000894ffff]
[    0.000000]   node   0: [mem 0x0000000008950000-0x0000000008baffff]
[    0.000000]   node   0: [mem 0x0000000008bb0000-0x0000000008bcffff]
[    0.000000]   node   0: [mem 0x0000000008bd0000-0x0000000008c4ffff]
[    0.000000]   node   0: [mem 0x0000000008c50000-0x0000000008e2ffff]
[    0.000000]   node   0: [mem 0x0000000008e30000-0x0000000008e4ffff]
[    0.000000]   node   0: [mem 0x0000000008e50000-0x0000000008fcffff]
[    0.000000]   node   0: [mem 0x0000000008fd0000-0x000000000910ffff]
[    0.000000]   node   0: [mem 0x0000000009110000-0x00000000092effff]
[    0.000000]   node   0: [mem 0x00000000092f0000-0x000000000930ffff]
[    0.000000]   node   0: [mem 0x0000000009310000-0x000000000963ffff]
[    0.000000]   node   0: [mem 0x0000000009640000-0x000000000e61ffff]
[    0.000000]   node   0: [mem 0x000000000e620000-0x000000000e64ffff]
[    0.000000]   node   0: [mem 0x000000000e650000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000010800000-0x0000000017feffff]
[    0.000000]   node   0: [mem 0x000000001c000000-0x000000001c00ffff]
[    0.000000]   node   0: [mem 0x000000001c010000-0x000000001c7fffff]
[    0.000000]   node   0: [mem 0x000000001c810000-0x000000007efbffff]
[    0.000000]   node   0: [mem 0x000000007efc0000-0x000000007efdffff]
[    0.000000]   node   0: [mem 0x000000007efe0000-0x000000007efeffff]
[    0.000000]   node   0: [mem 0x000000007eff0000-0x000000007effffff]
[    0.000000]   node   0: [mem 0x000000007f000000-0x00000017ffffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000200000-0x00000017ffffffff]

-- 
Cheers,
Jia
