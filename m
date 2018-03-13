Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-14183-1520981242-2-17306519181379352837
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
    t=1520981242; b=wX6N7mOK8lMPP8b57GQoj5WwOakyfXfBuCRgAnktJ64NGo1
    aL3y3+1fQftieEEyPHj+7+qYBq9k0I+8AG1spxvobt2U+W6Ka+rsJh5wQT+oaMkk
    j4AXHS4sHGRbce1szcsCXiqdyfR5L1QdgsIGUHLQKiX2pX6yUkldJFR1VbY/CMB3
    qiEbRjslBx4NkFw2FHmYi5Cv1ozc2QQ9geTGTzrLJqzDa0FKC9NosJVWQluniEQF
    H8wx8/fGCDs7LijZQYC6VWR4yDfwSXu3aHmJvXo1IaM+WhuTSgearCBAXIWBh4h9
    Pw6H5qkX3OJfe2xlozg2Mz4E+OkhF3tQZEKsxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520981242; bh=aCyIBKyyRNUSe9ab8oldzZFrWpqOcChtTWoxVq
    mNf7k=; b=FHOfJxgtjva29xjycIHv2SzX94LPw7cIxJOW/sQEOnK20Q/ndqe4Ac
    8zHG7iNRkVLN4ZJ8hBTdKX0/Ay4rfTsjnfNlgHy4FF8weJkymBsPK1zgIFIUsyjp
    TfNkkJfr0FJDJ47Nlm+TFPmMSZZZRBWf3fFkFOpkgotIG2naa50XdVfevdmQulYn
    BmIPwDshIq3sl9yqVH0B7gmJyCRCH75WgJVVKqyQpa14Pd8xFPq16+7WMyNMpy8Z
    qg0O4XiWgu2H9U7xwP2re0Zt74h3gzJgDVUPZB523APErHuXSdKcw6ZWDj7g/Q68
    c8bx2DG7Pd6u13FIP6S8El0rvXp13IKw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZocULesI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZocULesI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932569AbeCMWrU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 18:47:20 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36343 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932481AbeCMWrT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 18:47:19 -0400
X-Google-Smtp-Source: AG47ELsEMa8WOJQhZ/BTIvgvwnCChamr2Q3cQwH/fyYleYhJ6qL9FoJJiBpbh8YVMHBHUNpWv6ICRRwKXy3Zz5LA3nM=
MIME-Version: 1.0
In-Reply-To: <CA+G9fYth0DVemSK3Sp8aRc9mzDAq0==WW08Gq1L5JjxWg-a+Gw@mail.gmail.com>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
 <cover.1520011944.git.neelx@redhat.com> <0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com>
 <20180302164052.5eea1b896e3a7125d1e1f23a@linux-foundation.org>
 <CACjP9X_tpVVDPUvyc-B2QU=2J5MXbuFsDcG90d7L0KuwEEuR-g@mail.gmail.com>
 <CAPKp9ubzXBMeV6Oi=KW1HaPOrv_P78HOXcdQeZ5e1=bqY97tkA@mail.gmail.com>
 <CA+G9fYvWm5NYX64POULrdGB1c3Ar3WfZAsBTEKw4+NYQ_mmddA@mail.gmail.com>
 <CACjP9X96_Wtj3WOXgkjfijN-ZXB9pS=K547-JerRq4QKkrYkfQ@mail.gmail.com> <CA+G9fYth0DVemSK3Sp8aRc9mzDAq0==WW08Gq1L5JjxWg-a+Gw@mail.gmail.com>
From: Daniel Vacek <neelx@redhat.com>
Date: Tue, 13 Mar 2018 23:47:18 +0100
Message-ID: <CACjP9X_DjH4hVrUOOLok+ht5NO52TuV0mS4yZs5RCGjF0hi6LQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm/page_alloc: fix memmap_init_zone pageblock alignment
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 7:34 AM, Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
> On 12 March 2018 at 22:21, Daniel Vacek <neelx@redhat.com> wrote:
>> On Mon, Mar 12, 2018 at 3:49 PM, Naresh Kamboju
>> <naresh.kamboju@linaro.org> wrote:
>>> On 12 March 2018 at 17:56, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>> Hi,
>>>>
>>>> I couldn't find the exact mail corresponding to the patch merged in v4.16-rc5
>>>> but commit 864b75f9d6b01 "mm/page_alloc: fix memmap_init_zone
>>>> pageblock alignment"
>>>> cause boot hang on my ARM64 platform.
>>>
>>> I have also noticed this problem on hi6220 Hikey - arm64.
>>>
>>> LKFT: linux-next: Hikey boot failed linux-next-20180308
>>> https://bugs.linaro.org/show_bug.cgi?id=3676
>>>
>>> - Naresh
>>>
>>>>
>>>> Log:
>>>> [    0.000000] NUMA: No NUMA configuration found
>>>> [    0.000000] NUMA: Faking a node at [mem
>>>> 0x0000000000000000-0x00000009ffffffff]
>>>> [    0.000000] NUMA: NODE_DATA [mem 0x9fffcb480-0x9fffccf7f]
>>>> [    0.000000] Zone ranges:
>>>> [    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
>>>> [    0.000000]   Normal   [mem 0x0000000100000000-0x00000009ffffffff]
>>>> [    0.000000] Movable zone start for each node
>>>> [    0.000000] Early memory node ranges
>>>> [    0.000000]   node   0: [mem 0x0000000080000000-0x00000000f8f9afff]
>>>> [    0.000000]   node   0: [mem 0x00000000f8f9b000-0x00000000f908ffff]
>>>> [    0.000000]   node   0: [mem 0x00000000f9090000-0x00000000f914ffff]
>>>> [    0.000000]   node   0: [mem 0x00000000f9150000-0x00000000f920ffff]
>>>> [    0.000000]   node   0: [mem 0x00000000f9210000-0x00000000f922ffff]
>>>> [    0.000000]   node   0: [mem 0x00000000f9230000-0x00000000f95bffff]
>>>> [    0.000000]   node   0: [mem 0x00000000f95c0000-0x00000000fe58ffff]
>>>> [    0.000000]   node   0: [mem 0x00000000fe590000-0x00000000fe5cffff]
>>>> [    0.000000]   node   0: [mem 0x00000000fe5d0000-0x00000000fe5dffff]
>>>> [    0.000000]   node   0: [mem 0x00000000fe5e0000-0x00000000fe62ffff]
>>>> [    0.000000]   node   0: [mem 0x00000000fe630000-0x00000000feffffff]
>>>> [    0.000000]   node   0: [mem 0x0000000880000000-0x00000009ffffffff]
>>>> [    0.000000]  Initmem setup node 0 [mem 0x0000000080000000-0x00000009ffffffff]
>>>>
>>>> On Sat, Mar 3, 2018 at 1:08 AM, Daniel Vacek <neelx@redhat.com> wrote:
>>>>> On Sat, Mar 3, 2018 at 1:40 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
>>>>>>
>>>>>> This makes me wonder whether a -stable backport is really needed...
>>>>>
>>>>> For some machines it definitely is. Won't hurt either, IMHO.
>>>>>
>>>>> --nX
>>
>> Hmm, does it step back perhaps?
>>
>> Can you check if below cures the boot hang?
>>
>> --nX
>>
>> ~~~~
>> neelx@metal:~/nX/src/linux$ git diff
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 3d974cb2a1a1..415571120bbd 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5365,8 +5365,10 @@ void __meminit memmap_init_zone(unsigned long
>> size, int nid, unsigned long zone,
>>                          * the valid region but still depends on correct page
>>                          * metadata.
>>                          */
>> -                       pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
>> +                       unsigned long next_pfn;
>> +                       next_pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
>>                                         ~(pageblock_nr_pages-1)) - 1;
>> +                       pfn = max(next_pfn, pfn);
>>  #endif
>>                         continue;
>>                 }
>
> After applying this patch on linux-next the boot hang problem resolved.
> Now the hi6220-hikey is booting successfully.
> Thank you.

Thank you and Sudeep for testing. I've just sent Andrew a formal patch.

>
> - Naresh
>
>> ~~~~
