Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1044611-1524675891-2-13139461393297402076
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524675891; b=Mvjq96TJ1z3O94cFHGdHqHvP+WXhtnDtIWhtNAVrvkEwK99m4p
    H0Mpq3eXPtdDU3tG+4Rlv5gY5ymFHZuj8etxKtaRP7EpdsWeKwCuau79wSWRgS5/
    3IEYSs07xfZoaHqwv4SsKxEvdicMjRWrxl/EYYY3ONpmoX2C84gcpjluDfUbBinX
    Eq0H4KbH3qIhYgQ7eMHB6ap3ca6LyPFOnT+u04bUgBVTljFr5uWr2hxIbhlWSlDN
    8u/CS+/vH+2iEJLP6iHS6NVeWfnKYb4T+N5MednwJWv1obfPT9FMvEtV6W5SMde+
    IuSk3lpjDf4d/dQbQsAzm19okVRZGGjU3GGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524675891;
    bh=acVAPGJaUYb8CuEn+7+WUYYgUKCeMCaDPuuGBduUvBo=; b=uXaoFXKqXjgj
    DJiiA2fYsNo1fY2+PvnUn4HJPkEeWNYL8GmGKBNcHeY2efiFwm9kADonX3Jwvqv5
    G9VIK8WjsAMgXI2vQWiFW66F2yEjTxcxvUj2S6kpwnvTf2eQ1FuubxM9BdJv0KaQ
    YPtanKL8yBsdSMNUagmO/jlnOqAI6VJUFE3JBijUkLbBOBPwe+ReApmEkaiEVaTr
    TL0ulQ/WiomgmdqQl4Cpm3iSpeg/2esZ/z5iUDuuudYHXdjwTheMY8nJKYxc4ljx
    9XrtvrwX4U+gDTFesi7IMRY5G0sLhxEsMtcECaEh6wCNINFiKKKokYiwMnH6R27r
    6KvfuyJi4A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNlT7HVVbf7rZRBrkiduxBoXr15ZNy9ZNtzbogYA9XOHltLghRcLO6Wna7mCkf747UXWR+IMAbJ2NAygdTdcrA/NuhkiyHTLH4eQVNFa3UU0oOQsVTii
    HSoQI86uLQgnW3KxwUQpkMsqzUL0200YyFIYT75v91OLrdZPvXdoQYCCOAhNXq6r0liRcHLH5Yn16FTI22R4KgqXN612Wa9qBJWEd7aUb0vaXVkWBNQ6KEpb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=5DDD043un-yQppQx2xwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755276AbeDYREs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 13:04:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:58406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754926AbeDYREs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Apr 2018 13:04:48 -0400
Subject: Re: [PATCH 1/3] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
To: Roman Gushchin <guro@fb.com>
Cc: Vijayanand Jitta <vjitta@codeaurora.org>,
        vinayak menon <vinayakm.list@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Linux API <linux-api@vger.kernel.org>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-2-guro@fb.com>
 <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
 <20180411135624.GA24260@castle.DHCP.thefacebook.com>
 <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz>
 <20180412145702.GB30714@castle.DHCP.thefacebook.com>
 <CAOaiJ-=JtFWNPqdtf+5uim0-LcPE9zSDZmocAa_6K3yGpW2fCQ@mail.gmail.com>
 <69b4dcd8-1925-e0e8-d9b4-776f3405b769@codeaurora.org>
 <20180425125211.GB3410@castle> <db71bf8f-0c76-e304-25c3-d22f1e0d71e5@suse.cz>
 <20180425164845.GA7223@castle>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7fc2986e-b867-eb32-9124-d10ef6c1a3a3@suse.cz>
Date: Wed, 25 Apr 2018 19:02:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425164845.GA7223@castle>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/25/2018 06:48 PM, Roman Gushchin wrote:
> On Wed, Apr 25, 2018 at 05:47:26PM +0200, Vlastimil Babka wrote:
>> On 04/25/2018 02:52 PM, Roman Gushchin wrote:
>>> On Wed, Apr 25, 2018 at 09:19:29AM +0530, Vijayanand Jitta wrote:
>>>>>>>> Idk, I don't like the idea of adding a counter outside of the vm counters
>>>>>>>> infrastructure, and I definitely wouldn't touch the exposed
>>>>>>>> nr_slab_reclaimable and nr_slab_unreclaimable fields.
>>>>>>>
>>>>>>> We would be just making the reported values more precise wrt reality.
>>>>>>
>>>>>> It depends on if we believe that only slab memory can be reclaimable
>>>>>> or not. If yes, this is true, otherwise not.
>>>>>>
>>>>>> My guess is that some drivers (e.g. networking) might have buffers,
>>>>>> which are reclaimable under mempressure, and are allocated using
>>>>>> the page allocator. But I have to look closer...
>>>>>>
>>>>>
>>>>> One such case I have encountered is that of the ION page pool. The page pool
>>>>> registers a shrinker. When not in any memory pressure page pool can go high
>>>>> and thus cause an mmap to fail when OVERCOMMIT_GUESS is set. I can send
>>>>> a patch to account ION page pool pages in NR_INDIRECTLY_RECLAIMABLE_BYTES.
>>
>> FYI, we have discussed this at LSF/MM and agreed to try the kmalloc
>> reclaimable caches idea. The existing counter could then remain for page
>> allocator users such as ION. It's a bit weird to have it in bytes and
>> not pages then, IMHO. What if we hid it from /proc/vmstat now so it
>> doesn't become ABI, and later convert it to page granularity and expose
>> it under a name such as "nr_other_reclaimable" ?
> 
> I've nothing against hiding it from /proc/vmstat, as long as we keep
> the counter in place and the main issue resolved.

Sure.

> Maybe it's better to add nr_reclaimable = nr_slab_reclaimable + nr_other_reclaimable,
> which will have a simpler meaning that nr_other_reclaimable (what is other?).

"other" can be changed, sure. nr_reclaimable is possible if we change
slab to adjust that counter as well - vmstat code doesn't support
arbitrary calculations when printing.

> Thanks!
> 

