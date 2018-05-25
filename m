Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2888030-1527213137-2-8580777706830769237
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527213136; b=ew6l4dOU2eATaUUCyMt78ID91rM1QIFwYjap0UIcTJ/mbFvUhR
    e4bU2KKHAOaRqoA/U6v4Ijv9hSqosDiEevPXkXjzcydrn081m+BMR0Jy51VVSgR1
    zQi0YQgk3FMuxod63aM1WwA7UV2OjD9SEF3ECbPxdz6qs+4l5X9sEoWopOv9g/eN
    m8JawFhEUOb6jYpn12qUsE89zCzvAI5ytZFQvHm3N3lt32YwlcFMNdj6+gFWbQ5N
    5bC0gqFOJU03GZnJG+0mzndpklhuIEJ0ZIVdxr1KABaMS8iAgUZ2447xqKgPzKQs
    N8s7iXQbQA7/vmOVkTEqAJVYhh12ReNOsA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527213136;
    bh=Fht/v7wbgA/gExmDD4+9IESnwjI39FJEXGYjaDi0OpE=; b=i2F08QMgUVEA
    Vj3URAlU7j6DWMY/beEV59AQNcxFT9QdaD1C5JYLuy3ko87km4VGPA6AFu7UKx0Z
    GFXvCbrHjkuydiTZ4gmFzYeEZNdmZqSeaINue/BxW8xPzEjWw7W9q2HSW7sou6II
    6M6WmvRU6oP13e2iwQkOvzWopnUKlO5DRF5kvSr+SRvWDjUZaxM0bCCoRe4HH7jn
    0siknHtu7ez4fb9WALjpwBHhE0fw7JModWsoich7gqX9209OzrF8QDdf5yUV3uxn
    N8rt//33LhtKvppZ4Dtw278kwifJ4ZuSSy52wP7i/VOC6DWVyRXUjneOEip6nLbQ
    1anq0bhayA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ascade.co.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ascade.co.jp header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ascade.co.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ascade.co.jp header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFk1eUYGptpJAG02Jn0AS4Mjev2RYBRyBEIdnp6kC92pY95XghvtwD7AzriV/Pz8H/ikFoF/sxAJoi4Sx6pgwYUIeCrbquccADsarJPPoQHar5AEaqEC
    4OIsGapWoAFKzQPBvbT/ETjIwy/0ByOZz/4Tc/8BcQ5msHxISVmuzzQI04cIAz5kF0fnpOv9kLd4DEfDkDd38bjijU7shLNoWPL0fPtvghJKHc30yVRxDs9D
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=PcMsZRGSVe7Y605zVlgA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965348AbeEYBwO (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 21:52:14 -0400
Received: from ext-host0001.ascade.co.jp ([218.224.228.194]:63519 "EHLO
        ns.ascade.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935594AbeEYBwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 May 2018 21:52:11 -0400
Subject: Re: [PATCH v2 0/7] mm: pages for hugetlb's overcommit may be able to
 charge to memcg
To: Michal Hocko <mhocko@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Marc-Andre Lureau <marcandre.lureau@redhat.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
References: <e863529b-7ce5-4fbe-8cff-581b5789a5f9@ascade.co.jp>
 <240f1b14-ed7d-4983-6c52-be4899d4caa5@oracle.com>
 <8711fed5-fc35-a11a-3a17-740a9dca1f2a@ascade.co.jp>
 <20180522185407.GC20441@dhcp22.suse.cz>
 <455b1a07-d7e3-102b-65e7-3892947b7675@ascade.co.jp>
 <20180524082044.GW20441@dhcp22.suse.cz>
 <b2afbff6-b59f-7105-3808-64d41bd4a3a8@ascade.co.jp>
 <20180524132414.GI20441@dhcp22.suse.cz>
From: TSUKADA Koutaro <tsukada@ascade.co.jp>
Message-ID: <504b1ca0-9030-29be-4657-9cc18575eacb@ascade.co.jp>
Date: Fri, 25 May 2018 10:51:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180524132414.GI20441@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018/05/24 22:24, Michal Hocko wrote
[...]> I do not see anything like that. adjust_pool_surplus is simply and
> accounting thing. At least the last time I've checked. Maybe your
> patchset handles that?

As you said, my patch did not consider handling when manipulating the
pool. And even if that handling is done well, it will not be a valid
reason to charge surplus hugepage to memcg.

[...]
>> Absolutely you are saying the right thing, but, for example, can mlock(2)ed
>> pages be swapped out by reclaim?(What is the difference between mlock(2)ed
>> pages and hugetlb page?)
> 
> No mlocked pages cannot be reclaimed and that is why we restrict them to
> a relatively small amount.

I understood the concept of memcg.

[...]
> Fatal? Not sure. It simply tries to add an alien memory to the memcg
> concept so I would pressume an unexpected behavior (e.g. not being able
> to reclaim memcg or, over reclaim, trashing etc.).

As you said, it must be an alien. Thanks to the interaction up to here,
I understood that my solution is inappropriate. I will look for another
way.

Thank you for your kind explanation.

-- 
Thanks,
Tsukada
