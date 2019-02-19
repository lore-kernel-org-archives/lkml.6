Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DD0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903CA21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfBSHzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:55:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfBSHzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:55:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C214DA786B;
        Tue, 19 Feb 2019 07:55:08 +0000 (UTC)
Received: from [10.36.117.48] (ovpn-117-48.ams2.redhat.com [10.36.117.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E53E95D6AA;
        Tue, 19 Feb 2019 07:54:57 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
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
 <CAKgT0UfEeDJOYmm5L0Q9QSNrEm=w39_+5Js5CEx=0o2_fhkaGQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwX4EEwECACgFAljj9eoCGwMFCQlmAYAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEE3eEPcA/4Na5IIP/3T/FIQMxIfNzZshIq687qgG
 8UbspuE/YSUDdv7r5szYTK6KPTlqN8NAcSfheywbuYD9A4ZeSBWD3/NAVUdrCaRP2IvFyELj
 xoMvfJccbq45BxzgEspg/bVahNbyuBpLBVjVWwRtFCUEXkyazksSv8pdTMAs9IucChvFmmq3
 jJ2vlaz9lYt/lxN246fIVceckPMiUveimngvXZw21VOAhfQ+/sofXF8JCFv2mFcBDoa7eYob
 s0FLpmqFaeNRHAlzMWgSsP80qx5nWWEvRLdKWi533N2vC/EyunN3HcBwVrXH4hxRBMco3jvM
 m8VKLKao9wKj82qSivUnkPIwsAGNPdFoPbgghCQiBjBe6A75Z2xHFrzo7t1jg7nQfIyNC7ez
 MZBJ59sqA9EDMEJPlLNIeJmqslXPjmMFnE7Mby/+335WJYDulsRybN+W5rLT5aMvhC6x6POK
 z55fMNKrMASCzBJum2Fwjf/VnuGRYkhKCqqZ8gJ3OvmR50tInDV2jZ1DQgc3i550T5JDpToh
 dPBxZocIhzg+MBSRDXcJmHOx/7nQm3iQ6iLuwmXsRC6f5FbFefk9EjuTKcLMvBsEx+2DEx0E
 UnmJ4hVg7u1PQ+2Oy+Lh/opK/BDiqlQ8Pz2jiXv5xkECvr/3Sv59hlOCZMOaiLTTjtOIU7Tq
 7ut6OL64oAq+zsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCghCj/CA/lc/LMthqQ773ga
 uB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseBfDXHA6m4B3mUTWo13nid
 0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts6TZ+IrPOwT1hfB4WNC+X
 2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiuQmt3yqrmN63V9wzaPhC+
 xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKBTccu2AXJXWAE1Xjh6GOC
 8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvFFFyAS0Nk1q/7EChPcbRb
 hJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh2YmnmLRTro6eZ/qYwWkC
 u8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRkF3TwgucpyPtcpmQtTkWS
 gDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0LLH63+BrrHasfJzxKXzqg
 rW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4vq7oFCPsOgwARAQABwsFl
 BBgBAgAPBQJVy5+RAhsMBQkJZgGAAAoJEE3eEPcA/4NagOsP/jPoIBb/iXVbM+fmSHOjEshl
 KMwEl/m5iLj3iHnHPVLBUWrXPdS7iQijJA/VLxjnFknhaS60hkUNWexDMxVVP/6lbOrs4bDZ
 NEWDMktAeqJaFtxackPszlcpRVkAs6Msn9tu8hlvB517pyUgvuD7ZS9gGOMmYwFQDyytpepo
 YApVV00P0u3AaE0Cj/o71STqGJKZxcVhPaZ+LR+UCBZOyKfEyq+ZN311VpOJZ1IvTExf+S/5
 lqnciDtbO3I4Wq0ArLX1gs1q1XlXLaVaA3yVqeC8E7kOchDNinD3hJS4OX0e1gdsx/e6COvy
 qNg5aL5n0Kl4fcVqM0LdIhsubVs4eiNCa5XMSYpXmVi3HAuFyg9dN+x8thSwI836FoMASwOl
 C7tHsTjnSGufB+D7F7ZBT61BffNBBIm1KdMxcxqLUVXpBQHHlGkbwI+3Ye+nE6HmZH7IwLwV
 W+Ajl7oYF+jeKaH4DZFtgLYGLtZ1LDwKPjX7VAsa4Yx7S5+EBAaZGxK510MjIx6SGrZWBrrV
 TEvdV00F2MnQoeXKzD7O4WFbL55hhyGgfWTHwZ457iN9SgYi1JLPqWkZB0JRXIEtjd4JEQcx
 +8Umfre0Xt4713VxMygW0PnQt5aSQdMD58jHFxTk092mU+yIHj5LeYgvwSgZN4airXk5yRXl
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <77e71dc3-640b-bbf6-6a47-bb2371c06172@redhat.com>
Date:   Tue, 19 Feb 2019 08:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfEeDJOYmm5L0Q9QSNrEm=w39_+5Js5CEx=0o2_fhkaGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 19 Feb 2019 07:55:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.19 01:01, Alexander Duyck wrote:
> On Mon, Feb 18, 2019 at 1:04 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 18.02.19 21:40, Nitesh Narayan Lal wrote:
>>> On 2/18/19 3:31 PM, Michael S. Tsirkin wrote:
>>>> On Mon, Feb 18, 2019 at 09:04:57PM +0100, David Hildenbrand wrote:
>>>>>>>>>> So I'm fine with a simple implementation but the interface needs to
>>>>>>>>>> allow the hypervisor to process hints in parallel while guest is
>>>>>>>>>> running.  We can then fix any issues on hypervisor without breaking
>>>>>>>>>> guests.
>>>>>>>>> Yes, I am fine with defining an interface that theoretically let's us
>>>>>>>>> change the implementation in the guest later.
>>>>>>>>> I consider this even a
>>>>>>>>> prerequisite. IMHO the interface shouldn't be different, it will be
>>>>>>>>> exactly the same.
>>>>>>>>>
>>>>>>>>> It is just "who" calls the batch freeing and waits for it. And as I
>>>>>>>>> outlined here, doing it without additional threads at least avoids us
>>>>>>>>> for now having to think about dynamic data structures and that we can
>>>>>>>>> sometimes not report "because the thread is still busy reporting or
>>>>>>>>> wasn't scheduled yet".
>>>>>>>> Sorry I wasn't clear. I think we need ability to change the
>>>>>>>> implementation in the *host* later. IOW don't rely on
>>>>>>>> host being synchronous.
>>>>>>>>
>>>>>>>>
>>>>>>> I actually misread it :) . In any way, there has to be a mechanism to
>>>>>>> synchronize.
>>>>>>>
>>>>>>> If we are going via a bare hypercall (like s390x, like what Alexander
>>>>>>> proposes), it is going to be a synchronous interface either way. Just a
>>>>>>> bare hypercall, there will not really be any blocking on the guest side.
>>>>>> It bothers me that we are now tied to interface being synchronous. We
>>>>>> won't be able to fix it if there's an issue as that would break guests.
>>>>> I assume with "fix it" you mean "fix kfree taking longer on every X call"?
>>>>>
>>>>> Yes, as I initially wrote, this mimics s390x. That might be good (we
>>>>> know it has been working for years) and bad (we are inheriting the same
>>>>> problem class, if it exists). And being synchronous is part of the
>>>>> approach for now.
>>>> BTW on s390 are these hypercalls handled by Linux?
>>>>
>>>>> I tend to focus on the first part (we don't know anything besides it is
>>>>> working) while you focus on the second part (there could be a potential
>>>>> problem). Having a real problem at hand would be great, then we would
>>>>> know what exactly we actually have to fix. But read below.
>>>> If we end up doing a hypercall per THP, maybe we could at least
>>>> not block with interrupts disabled? Poll in guest until
>>>> hypervisor reports its done?  That would already be an
>>>> improvement IMHO. E.g. perf within guest will point you
>>>> in the right direction and towards disabling hinting.
>>>>
>>>>
>>>>>>> Via virtio, I guess it is waiting for a response to a requests, right?
>>>>>> For the buffer to be used, yes. And it could mean putting some pages
>>>>>> aside until hypervisor is done with them. Then you don't need timers or
>>>>>> tricks like this, you can get an interrupt and start using the memory.
>>>>> I am very open to such an approach as long as we can make it work and it
>>>>> is not too complicated. (-> simple)
>>>>>
>>>>> This would mean for example
>>>>>
>>>>> 1. Collect entries to be reported per VCPU in a buffer. Say magic number
>>>>> 256/512.
>>>>>
>>>>> 2. Once the buffer is full, do crazy "take pages out of the balloon
>>>>> action" and report them to the hypervisor via virtio. Let the VCPU
>>>>> continue. This will require some memory to store the request. Small
>>>>> hickup for the VCPU to kick of the reporting to the hypervisor.
>>>>>
>>>>> 3. On interrupt/response, go over the response and put the pages back to
>>>>> the buddy.
>>>>>
>>>>> (assuming that reporting a bulk of frees is better than reporting every
>>>>> single free obviously)
>>>>>
>>>>> This could allow nice things like "when OOM gets trigger, see if pages
>>>>> are currently being reported and wait until they have been put back to
>>>>> the buddy, return "new pages available", so in a real "low on memory"
>>>>> scenario, no OOM killer would get involved. This could address the issue
>>>>> Wei had with reporting when low on memory.
>>>>>
>>>>> Is that something you have in mind?
>>>> Yes that seems more future proof I think.
>>>>
>>>>> I assume we would have to allocate
>>>>> memory when crafting the new requests. This is the only reason I tend to
>>>>> prefer a synchronous interface for now. But if allocation is not a
>>>>> problem, great.
>>>> There are two main ways to avoid allocation:
>>>> 1. do not add extra data on top of each chunk passed
>>> If I am not wrong then this is close to what we have right now.
>>
>> Yes, minus the kthread(s) and eventually with some sort of memory
>> allocation for the request. Once you're asynchronous via a notification
>> mechanisnm, there is no real need for a thread anymore, hopefully.
>>
>>> One issue I see right now is that I am polling while host is freeing the
>>> memory.
>>> In the next version I could tie the logic which returns pages to the
>>> buddy and resets the per cpu array index value to 0 with the callback.
>>> (i.e.., it happens once we receive an response from the host)
>>
>> The question is, what happens when freeing pages and the array is not
>> ready to be reused yet. In that case, you want to somehow continue
>> freeing pages without busy waiting or eventually not reporting pages.
>>
>> The callback should put the pages back to the buddy and free the request
>> eventually to have a fully asynchronous mechanism.
>>
>>> Other change which I am testing right now is to only capture 'MAX_ORDER
>>
>> I am not sure if this is an arbitrary number we came up with here. We
>> should really play with different orders to find a hot spot. I wouldn't
>> consider this high priority, though. Getting the whole concept right to
>> be able to deal with any magic number we come up should be the ultimate
>> goal. (stuff that only works with huge pages I consider not future
>> proof, especially regarding fragmented guests which can happen easily)
> 
> This essentially just ends up being another trade-off of CPU versus
> memory though. Assuming we aren't using THP we are going to take a
> penalty in terms of performance but could then free individual pages
> less than HUGETLB_PAGE_ORDER, but the CPU utilization is going to be
> much higher in general even without the hinting. I figure for x86 we
> probably don't have too many options since if I am not mistaken
> MAX_ORDER is just one or two more than HUGETLB_PAGE_ORDER.

THP is an implementation detail in the hypervisor. Yes, it is the common
case on x86. But it is e.g. not available on s390x yet. And we also want
this mechanism to work on s390x (e.g. for nested virtualization setups
as discussed).

If we e.g. report any granularity after merging was done in the buddy,
we could end up reporting everything from page size up to MAX_SIZE - 1,
the hypervisor could ignore hints below a certain magic number, if it
makes its life easier.

> 
> As far as fragmentation my thought is that we may want to look into
> adding support to the guest for prioritizing defragmentation on pages
> lower than THP size. Then that way we could maintain the higher
> overall performance with or without the hinting since shuffling lower
> order pages around between guests would start to get expensive pretty
> quick.

My take would be, design an interface/mechanism that allows any kind of
granularity. You can than balance between cpu overead and space shifting.

I feel like repeating myself, but on s390x hinting is done on page
granularity, and I have never heard somebody say "how can I turn it off,
this is slowing down my system too much.". All we know is that one
hypercall per free is most probably not acceptable. We really have to
play with the numbers.

I tend to like an asynchronous reporting approach as discussed in this
thread, we would have to see if Nitesh could get it implemented.

Thanks Alexander!

-- 

Thanks,

David / dhildenb
