Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CE9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515C32089F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfBRUx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:53:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbfBRUx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:53:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B0A7980F98;
        Mon, 18 Feb 2019 20:53:56 +0000 (UTC)
Received: from [10.36.116.142] (ovpn-116-142.ams2.redhat.com [10.36.116.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC783607AA;
        Mon, 18 Feb 2019 20:53:44 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
        yang.zhang.wz@gmail.com, riel@surriel.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com,
        Alexander Duyck <alexander.duyck@gmail.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org>
 <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <20190218122636-mutt-send-email-mst@kernel.org>
 <f396836d-9bbd-e3e2-c7b0-d921bf1c9ed1@redhat.com>
 <20190218140947-mutt-send-email-mst@kernel.org>
 <4039c2e8-5db4-cddd-b997-2fdbcc6f529f@redhat.com>
 <20190218143819-mutt-send-email-mst@kernel.org>
 <58714908-f203-0b64-845b-5818e52a62fa@redhat.com>
 <20190218152021-mutt-send-email-mst@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <dba1eb78-1d24-5b39-afb0-c8a9473a0c8e@redhat.com>
Date:   Mon, 18 Feb 2019 21:53:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218152021-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 18 Feb 2019 20:53:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.02.19 21:31, Michael S. Tsirkin wrote:
> On Mon, Feb 18, 2019 at 09:04:57PM +0100, David Hildenbrand wrote:
>>>>>>> So I'm fine with a simple implementation but the interface needs to
>>>>>>> allow the hypervisor to process hints in parallel while guest is
>>>>>>> running.  We can then fix any issues on hypervisor without breaking
>>>>>>> guests.
>>>>>>
>>>>>> Yes, I am fine with defining an interface that theoretically let's us
>>>>>> change the implementation in the guest later.
>>>>>> I consider this even a
>>>>>> prerequisite. IMHO the interface shouldn't be different, it will be
>>>>>> exactly the same.
>>>>>>
>>>>>> It is just "who" calls the batch freeing and waits for it. And as I
>>>>>> outlined here, doing it without additional threads at least avoids us
>>>>>> for now having to think about dynamic data structures and that we can
>>>>>> sometimes not report "because the thread is still busy reporting or
>>>>>> wasn't scheduled yet".
>>>>>
>>>>> Sorry I wasn't clear. I think we need ability to change the
>>>>> implementation in the *host* later. IOW don't rely on
>>>>> host being synchronous.
>>>>>
>>>>>
>>>> I actually misread it :) . In any way, there has to be a mechanism to
>>>> synchronize.
>>>>
>>>> If we are going via a bare hypercall (like s390x, like what Alexander
>>>> proposes), it is going to be a synchronous interface either way. Just a
>>>> bare hypercall, there will not really be any blocking on the guest side.
>>>
>>> It bothers me that we are now tied to interface being synchronous. We
>>> won't be able to fix it if there's an issue as that would break guests.
>>
>> I assume with "fix it" you mean "fix kfree taking longer on every X call"?
>>
>> Yes, as I initially wrote, this mimics s390x. That might be good (we
>> know it has been working for years) and bad (we are inheriting the same
>> problem class, if it exists). And being synchronous is part of the
>> approach for now.
> 
> BTW on s390 are these hypercalls handled by Linux?

I assume you mean in KVM - Yes! There is a hardware assist to handle the
"queuing of 512 pfns" but once the buffer is full, the actual hypercall
intercept will be triggered.

arch/s390/kvm/priv.c:handle_essa()

The interesting part is

down_read(&gmap->mm->mmap_sem);
for (i = 0; i < entries; ++i);
	__gmap_zap(gmap, cbrlo[i]);
up_read(&gmap->mm->mmap_sem);

cbrlo is the pfn array stored in the hypervisor.

> 
>> I tend to focus on the first part (we don't know anything besides it is
>> working) while you focus on the second part (there could be a potential
>> problem). Having a real problem at hand would be great, then we would
>> know what exactly we actually have to fix. But read below.
> 
> If we end up doing a hypercall per THP, maybe we could at least
> not block with interrupts disabled? Poll in guest until
> hypervisor reports its done?  That would already be an
> improvement IMHO. E.g. perf within guest will point you
> in the right direction and towards disabling hinting.

I think we always have the option to busy loop where we consider it more
helpful. On synchronous hypercalls, no waiting is necessary. Only on
asynchronous ones (which would the most probably be virtio based).

I don't think only reporting THP will be future proof. So with whatever
we come up, it has to be able to deal with smaller granularities. Not
saying eventually page granularity, but at least some other orders. The
only solution to avoid overhead of many hypercalls is then to report
multiple ones in one shot.

>>>
>>>> Via virtio, I guess it is waiting for a response to a requests, right?
>>>
>>> For the buffer to be used, yes. And it could mean putting some pages
>>> aside until hypervisor is done with them. Then you don't need timers or
>>> tricks like this, you can get an interrupt and start using the memory.
>>
>> I am very open to such an approach as long as we can make it work and it
>> is not too complicated. (-> simple)
>>
>> This would mean for example
>>
>> 1. Collect entries to be reported per VCPU in a buffer. Say magic number
>> 256/512.
>>
>> 2. Once the buffer is full, do crazy "take pages out of the balloon
>> action" and report them to the hypervisor via virtio. Let the VCPU
>> continue. This will require some memory to store the request. Small
>> hickup for the VCPU to kick of the reporting to the hypervisor.
>>
>> 3. On interrupt/response, go over the response and put the pages back to
>> the buddy.
>>
>> (assuming that reporting a bulk of frees is better than reporting every
>> single free obviously)
>>
>> This could allow nice things like "when OOM gets trigger, see if pages
>> are currently being reported and wait until they have been put back to
>> the buddy, return "new pages available", so in a real "low on memory"
>> scenario, no OOM killer would get involved. This could address the issue
>> Wei had with reporting when low on memory.
>>
>> Is that something you have in mind?
> 
> Yes that seems more future proof I think.

And it would satisfy your request for an asynchronous interface. + we
would get rid of the kthread(s).

> 
>> I assume we would have to allocate
>> memory when crafting the new requests. This is the only reason I tend to
>> prefer a synchronous interface for now. But if allocation is not a
>> problem, great.
> 
> There are two main ways to avoid allocation:
> 1. do not add extra data on top of each chunk passed
> 2. add extra data but pre-allocate buffers for it
> 

It could theoretically happen that while the old VCPU buffer is still
getting reported, that we want to free a page, so we need a new buffer I
assume. Busy waiting is an option (hmm), or have to skip that page, but
that is something I want to avoid. So allocating memory for the request
seems to be the cleanest approach.

But after all, as we are literally allocating buddy pages to report
temporarily, we can also most probably also allocate memory. We will
have to look into the details.

So the options I see so far are

1. Do a synchronous hypercall, reporting a bunch of pages as described
initially in this thread. Release page to the buddy when returning from
the hypercall.

2. Do an asynchronous hypercall (allocating memory for the request),
reporting a bunch of pages. Release page to the buddy when on response
via interrupt.

Thanks for the helpful discussion Michael!

-- 

Thanks,

David / dhildenb
