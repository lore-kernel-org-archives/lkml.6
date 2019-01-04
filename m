Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55552C43444
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CD3218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YTo91iP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfADUSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:18:11 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40714 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfADUSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:18:11 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so41656926qtf.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 12:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bUHujUxE5hzycDL7wcIHPPjUFSgBLqxO4yvkBKHsO/s=;
        b=YTo91iP5SIrIiw+XAhsKMKxx/epBVh3oaONXvL+FEwm8fs0WPZ0kw6p+vtDyClmMrT
         g1gd7Moj/lwexKyT+MEcjRLekQgBib0YZb5+lU/J3IU3GrXFWVuK3uGFQMWgMCVBNGbA
         L40gHP8LLoOROkKHZcN6S/ziWlZ+zk813osZ6Tdl3QkZ9gK9CjfsQnC9NvmjikYHm3g9
         oZT1+u6/9+Ag531Cl+meqKtfTHRYAOEEV0bJjVgNa6fVS4uXbJJ/6haNq63lEsHvtXza
         9pEqE+LxrURCvPHeeOr+zfBQmA3AWaRL/Ke0ZxbWlrO6KHD1GdLaPSYVo2tV8x6ZJkN1
         u8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bUHujUxE5hzycDL7wcIHPPjUFSgBLqxO4yvkBKHsO/s=;
        b=PBflbkEi1UekeIdNuPiFoPWjaXQULKSkfzSH/c+cfR9KTW22TrD38B99R+4gsLKc3R
         NZD2EGJzTaI0Jzx3EjcveYgJ72dGRA/Jq81jh+UlHw7fZVNGvjuRbKGCn+WnjJ3ElDl3
         CkEMGlLEuHTrZyafb2OXewzt/7pnZOevBqmf2AlrSks5kYQYQpXoJMwDLw/SmnPjZqlU
         FaJwj/bN4eK2Pv9clNldcEvsoMDMq8b3bzAaUYYHX0mXnUNwvU98Lyc6qASNL17Dz/nJ
         d4qG++oHjIiWVGsPqU2tClE+1NAxBOfXZOmVn6dX2+n0mPeH2XvJP7zejFpDer1ULZro
         n7iA==
X-Gm-Message-State: AJcUukefVyQLwCjLxJg7p3j0XfEfMovd6c2eVdWwmLjZFjFj5JXYhdbl
        loi2PCfPu0DEChHpUcWduX2To+hvvo1VpQ==
X-Google-Smtp-Source: ALg8bN6ivkgQIgqn9ePX2J5HVluozY6es2+h6+on9EzKcMHqiyOaecoXFR57qe9IOhL/jMKY1Gp9jw==
X-Received: by 2002:a0c:b919:: with SMTP id u25mr52282340qvf.104.1546633089901;
        Fri, 04 Jan 2019 12:18:09 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b134sm24666756qkg.78.2019.01.04.12.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 12:18:09 -0800 (PST)
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190103165927.GU31793@dhcp22.suse.cz>
 <5d8f3a98-a954-c8ab-83d9-2f94c614f268@lca.pw>
 <20190103190715.GZ31793@dhcp22.suse.cz>
 <62e96e34-7ea9-491a-b5b6-4828da980d48@lca.pw>
 <20190103202235.GE31793@dhcp22.suse.cz>
 <a5666d82-b7ad-4b90-5f4e-fd22afc3e1dc@lca.pw>
 <20190104130906.GO31793@dhcp22.suse.cz>
 <e4ad9d12-387d-1cc6-f404-cae6d43ccf80@lca.pw>
 <20190104151737.GT31793@dhcp22.suse.cz>
 <c8faf7eb-d23f-4ef7-3432-0acc7165f883@lca.pw>
 <20190104153245.GV31793@dhcp22.suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <fa135cd8-32e5-86f7-14ee-30685bca91b5@lca.pw>
Date:   Fri, 4 Jan 2019 15:18:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190104153245.GV31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 10:32 AM, Michal Hocko wrote:
> On Fri 04-01-19 10:25:12, Qian Cai wrote:
>> On 1/4/19 10:17 AM, Michal Hocko wrote:
>>> On Fri 04-01-19 10:01:40, Qian Cai wrote:
>>>> On 1/4/19 8:09 AM, Michal Hocko wrote:
>>>>>> Here is the number without DEFERRED_STRUCT_PAGE_INIT.
>>>>>>
>>>>>> == page_ext_init() after page_alloc_init_late() ==
>>>>>> Node 0, zone DMA: page owner found early allocated 0 pages
>>>>>> Node 0, zone DMA32: page owner found early allocated 7009 pages
>>>>>> Node 0, zone Normal: page owner found early allocated 85827 pages
>>>>>> Node 4, zone Normal: page owner found early allocated 75063 pages
>>>>>>
>>>>>> == page_ext_init() before kmemleak_init() ==
>>>>>> Node 0, zone DMA: page owner found early allocated 0 pages
>>>>>> Node 0, zone DMA32: page owner found early allocated 6654 pages
>>>>>> Node 0, zone Normal: page owner found early allocated 41907 pages
>>>>>> Node 4, zone Normal: page owner found early allocated 41356 pages
>>>>>>
>>>>>> So, it told us that it will miss tens of thousands of early page allocation call
>>>>>> sites.
>>>>>
>>>>> This is an answer for the first part of the question (how much). The
>>>>> second is _do_we_care_?
>>>>
>>>> Well, the purpose of this simple "ugly" ifdef is to avoid a regression for the
>>>> existing page_owner users with DEFERRED_STRUCT_PAGE_INIT deselected that would
>>>> start to miss tens of thousands early page allocation call sites.
>>>
>>> I am pretty sure we will hear about that when that happens. And act
>>> accordingly.
>>>
>>>> The other option I can think of to not hurt your eyes is to rewrite the whole
>>>> page_ext_init(), init_page_owner(), init_debug_guardpage() to use all early
>>>> functions, so it can work in both with DEFERRED_STRUCT_PAGE_INIT=y and without.
>>>> However, I have a hard-time to convince myself it is a sensible thing to do.
>>>
>>> Or simply make the page_owner initialization only touch the already
>>> initialized memory. Have you explored that option as well?
>>
>> Yes, a proof-of-concept version is v1 where ends up with more ifdefs due to
>> dealing with all the low-level details,
>>
>> https://lore.kernel.org/lkml/20181220060303.38686-1-cai@lca.pw/
> 
> That is obviously not what I've had in mind. We have __init_single_page
> which initializes a single struct page. Is there any way to hook
> page_ext initialization there?

Well, the current design is,

(1) allocate page_ext physical-contiguous pages for all
    nodes.
(2) page owner gathers all early allocation pages.
(3) page owner is fully operational.

It may be possible to move (1) as early as possible just after vmalloc_init() in
start_kernel() because it depends on vmalloc(), but it still needs to call (2)
as there have had many early allocation pages already.

Node 0, zone DMA: page owner found early allocated 0 pages
Node 0, zone DMA32: page owner found early allocated 6654 pages
Node 0, zone Normal: page owner found early allocated 40972 pages
Node 4, zone Normal: page owner found early allocated 40968 pages

But, (2) still depends on DEFERRED_STRUCT_PAGE_INIT. To get ride of this
dependency, it may be possible to add some checking in __init_single_page():

- if not done (1), save those pages to an array and defer
  page_owner early_handle initialization until done (1).

Though, I can't see any really benefit of this approach apart from "beautify"
the code.
