Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EEBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261A521773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfBSOVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:21:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfBSOVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:21:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1804C05D41E;
        Tue, 19 Feb 2019 14:21:10 +0000 (UTC)
Received: from [10.36.117.212] (ovpn-117-212.ams2.redhat.com [10.36.117.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4695414A;
        Tue, 19 Feb 2019 14:21:07 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
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
 <18d87846-72c7-adf0-5ca3-7312540bb31b@redhat.com>
 <478a9574-a604-0aa9-d569-6a5cd98d7cdc@redhat.com>
 <e2273f4a-dfe9-45fe-d924-598d3e8b38b5@redhat.com>
 <1abac6db-5e1a-2889-9831-707c2b78b0f3@redhat.com>
 <0d7ff493-71f3-8707-8400-b51f1ce1a2bd@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <ebbcda69-d806-ed0b-b3c2-612d21c0f57e@redhat.com>
Date:   Tue, 19 Feb 2019 15:21:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0d7ff493-71f3-8707-8400-b51f1ce1a2bd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 19 Feb 2019 14:21:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.19 15:17, Nitesh Narayan Lal wrote:
> On 2/19/19 8:03 AM, David Hildenbrand wrote:
>>>>>> There are two main ways to avoid allocation:
>>>>>> 1. do not add extra data on top of each chunk passed
>>>>> If I am not wrong then this is close to what we have right now.
>>>> Yes, minus the kthread(s) and eventually with some sort of memory
>>>> allocation for the request. Once you're asynchronous via a notification
>>>> mechanisnm, there is no real need for a thread anymore, hopefully.
>>> Whether we should go with kthread or without it, I would like to do some
>>> performance comparison before commenting on this.
>>>>> One issue I see right now is that I am polling while host is freeing the
>>>>> memory.
>>>>> In the next version I could tie the logic which returns pages to the
>>>>> buddy and resets the per cpu array index value to 0 with the callback.
>>>>> (i.e.., it happens once we receive an response from the host)
>>>> The question is, what happens when freeing pages and the array is not
>>>> ready to be reused yet. In that case, you want to somehow continue
>>>> freeing pages without busy waiting or eventually not reporting pages.
>>> This is what happens right now.
>>> Having kthread or not should not effect this behavior.
>>> When the array is full the current approach simply skips collecting the
>>> free pages.
>> Well, it somehow does affect your implementation. If you have a kthread
>> you always have to synchronize against the VCPU: "Is the pcpu array
>> ready to be used again".
>>
>> Once you do it asynchronously from your VCPU without another thread
>> being involved, such synchronization is not required. Simply prepare a
>> request and send it off. Reuse the pcpu array instantly. At least that's
>> the theory :)
>>
>> If you have a guest bulk freeing a lot of memory, I guess temporarily
>> dropping free page hints could be counter-productive. It really depends
>> on how fast the thread gets scheduled and how long the hinting process
>> takes. Having another thread involved might add a lot to that latency to
>> that formula. We'll have to measure, but my gut feeling is that once we
>> do stuff asynchronously, there is no need for a thread anymore.
> This is true.
>>
>>>> The callback should put the pages back to the buddy and free the request
>>>> eventually to have a fully asynchronous mechanism.
>>>>
>>>>> Other change which I am testing right now is to only capture 'MAX_ORDER
>>>> I am not sure if this is an arbitrary number we came up with here. We
>>>> should really play with different orders to find a hot spot. I wouldn't
>>>> consider this high priority, though. Getting the whole concept right to
>>>> be able to deal with any magic number we come up should be the ultimate
>>>> goal. (stuff that only works with huge pages I consider not future
>>>> proof, especially regarding fragmented guests which can happen easily)
>>> Its quite possible that when we are only capturing MAX_ORDER - 1 and run
>>> a specific workload we don't get any memory back until we re-run the
>>> program and buddy finally starts merging of pages of order MAX_ORDER -1.
>>> This is why I think we may make this configurable from compile time and
>>> keep capturing MAX_ORDER - 1 so that we don't end up breaking anything.
>> Eventually pages will never get merged. Assume you have 1 page of a
>> MAX_ORDER - 1 chunk still allocated somewhere (e.g. !movable via
>> kmalloc). You skip reporting that chunk completely. Roughly 1mb/2mb/4mb
>> wasted (depending on the arch). This stuff can sum up.
> 
> After the discussion, here are the changes on which I am planning to
> work next:
> 1. Get rid of the kthread and dynamically allocate a per-cpu array to
> hold the
> isolated pages. As soon as the initial per-cpu array is completely
> scanned, release it
> so that we don't end up blocking anything.
> 2. Continue capturing MAX_ORDER - 1, for now. Reduce the initial per-cpu
> array size to 256
> for now. As we are doing asynchronous reporting we should be fine with a
> lower size array.
> 3. As soon as the host responds, release the pages back to the buddy
> from the callback and free the request.
> 
> Benefits wrt current implementation:
> 1. We will not eat up performance due to kernel thread.
> 2. We will still be doing reporting asynchronously=> no blocking.
> 3. Hopefully, we will be able to free more memory.
> 

+1 to that approach. We can fine tune the numbers (array size, sizes to
report) easily later on. Let us know if you run into problems doing the
allocation for the request. If that is a blocker, all we left with is a
synchronous approach I guess. Let's cross fingers. :)

-- 

Thanks,

David / dhildenb
