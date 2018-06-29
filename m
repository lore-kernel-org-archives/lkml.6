Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F482C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC4423CE7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC4423CE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936223AbeF2Lxl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:53:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933005AbeF2Lxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:53:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F37640201C7;
        Fri, 29 Jun 2018 11:53:39 +0000 (UTC)
Received: from [10.36.117.11] (ovpn-117-11.ams2.redhat.com [10.36.117.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE4572156880;
        Fri, 29 Jun 2018 11:53:35 +0000 (UTC)
Subject: Re: [PATCH v34 0/4] Virtio-balloon: support free page reporting
To:     Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org,
        akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
 <c4dd0a13-91fb-c0f5-b41f-54421fdacca9@redhat.com>
 <5B35ACD5.4090800@intel.com>
 <4840cbb7-dd3f-7540-6a7c-13427de2f0d1@redhat.com>
 <5B36189E.5050204@intel.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <34bb25eb-97f3-8a9f-8a13-401dfcf39a2c@redhat.com>
Date:   Fri, 29 Jun 2018 13:53:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5B36189E.5050204@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 29 Jun 2018 11:53:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 29 Jun 2018 11:53:39 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.06.2018 13:31, Wei Wang wrote:
> On 06/29/2018 03:46 PM, David Hildenbrand wrote:
>>>
>>> I'm afraid it can't. For example, when we have a guest booted, without
>>> too many memory activities. Assume the guest has 8GB free memory. The
>>> arch_free_page there won't be able to capture the 8GB free pages since
>>> there is no free() called. This results in no free pages reported to host.
>>
>> So, it takes some time from when the guest boots up until the balloon
>> device was initialized and therefore page hinting can start. For that
>> period, you won't get any arch_free_page()/page hinting callbacks, correct.
>>
>> However in the hypervisor, you can theoretically track which pages the
>> guest actually touched ("dirty"), so you already know "which pages were
>> never touched while booting up until virtio-balloon was brought to
>> life". These, you can directly exclude from migration. No interface
>> required.
>>
>> The remaining problem is pages that were touched ("allocated") by the
>> guest during bootup but freed again, before virtio-balloon came up. One
>> would have to measure how many pages these usually are, I would say it
>> would not be that many (because recently freed pages are likely to be
>> used again next for allocation). However, there are some pages not being
>> reported.
>>
>> During the lifetime of the guest, this should not be a problem,
>> eventually one of these pages would get allocated/freed again, so the
>> problem "solves itself over time". You are looking into the special case
>> of migrating the VM just after it has been started. But we have the
>> exact same problem also for ordinary free page hinting, so we should
>> rather solve that problem. It is not migration specific.
>>
>> If we are looking for an alternative to "problem solves itself",
>> something like "if virtio-balloon comes up, it will report all free
>> pages step by step using free page hinting, just like we would have from
>> "arch_free_pages()"". This would be the same interface we are using for
>> free page hinting - and it could even be made configurable in the guest.
>>
>> The current approach we are discussing internally for details about
>> Nitesh's work ("how the magic inside arch_fee_pages() will work
>> efficiently) would allow this as far as I can see just fine.
>>
>> There would be a tiny little window between virtio-balloon comes up and
>> it has reported all free pages step by step, but that can be considered
>> a very special corner case that I would argue is not worth it to be
>> optimized.
>>
>> If I am missing something important here, sorry in advance :)
>>
> 
> Probably I didn't explain that well. Please see my re-try:
> 
> That work is to monitor page allocation and free activities via 
> arch_alloc_pages and arch_free_pages. It has per-CPU lists to record the 
> pages that are freed to the mm free list, and the per-CPU lists dump the 
> recorded pages to a global list when any of them is full.
> So its own per-CPU list will only be able to get free pages when there 
> is an mm free() function gets called. If we have 8GB free memory on the 
> mm free list, but no application uses them and thus no mm free() calls 
> are made. In that case, the arch_free_pages isn't called, and no free 
> pages added to the per-CPU list, but we have 8G free memory right on the 
> mm free list.
> How would you guarantee the per-CPU lists have got all the free pages 
> that the mm free lists have?

As I said, if we have some mechanism that will scan the free pages (not
arch_free_page() once and report hints using the same mechanism step by
step (not your bulk interface)), this problem is solved. And as I said,
this is not a migration specific problem, we have the same problem in
the current page hinting RFC. These pages have to be reported.

> 
> - I'm also worried about the overhead of maintaining so many per-CPU 
> lists and the global list. For example, if we have applications 
> frequently allocate and free 4KB pages, and each per-CPU list needs to 
> implement the buddy algorithm to sort and merge neighbor pages. Today a 
> server can have more than 100 CPUs, then there will be more than 100 
> per-CPU lists which need to sync to a global list under a lock, I'm not 
> sure if this would scale well.

The overhead in the current RFC is definitely too high. But I consider
this a problem to be solved before page hinting would go upstream. And
we are discussing right now "if we have a reasonable page hinting
implementation, why would we need your interface in addition".

> 
> - This seems to be a burden imposed on the core mm memory 
> allocation/free path. The whole overhead needs to be carried during the 
> whole system life cycle. What we actually expected is to just make one 
> call to get the free page hints only when live migration happens.

You're focusing too much on the actual implementation of the page
hinting RFC right now. Assume for now that we would have
- efficient page hinting without degrading other CPUs and little
  overhead
- a mechanism that solves reporting free pages once after we started up
  virtio-balloon and actual free page hinting starts

Why would your suggestion still be applicable?

Your point for now is "I might not want to have page hinting enabled due
to the overhead, but still a live migration speedup". If that overhead
actually exists (we'll have to see) or there might be another reason to
disable page hinting, then we have to decide if that specific setup is
worth it merging your changes.

I am not (and don't want to be) in the position to make any decisions
here :) I just want to understand if two interfaces for free pages
actually make sense.

Maybe the argument "I don't want free page hinting" is good enough.

> 
> Best,
> Wei


-- 

Thanks,

David / dhildenb
