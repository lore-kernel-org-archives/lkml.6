Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47954C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0904921903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfBSIGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:06:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfBSIGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:06:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A6DCC007336;
        Tue, 19 Feb 2019 08:06:14 +0000 (UTC)
Received: from [10.36.117.48] (ovpn-117-48.ams2.redhat.com [10.36.117.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DCFD600C0;
        Tue, 19 Feb 2019 08:06:02 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
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
 <CAKgT0UcHv0S1-ZUpAZ9w=GTLRtG8=-cuoT3fa4Ej2A==aky5dg@mail.gmail.com>
 <a3b64b60-a745-0ac1-574d-e5904c1bf161@redhat.com>
 <CAKgT0Ue=A16PhUzqziBBzMXdZ_C1H74-qCttwb8iD6tGCxfp6g@mail.gmail.com>
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
Message-ID: <93c78cb7-5dc9-39ae-83bf-a4d6426b5221@redhat.com>
Date:   Tue, 19 Feb 2019 09:06:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ue=A16PhUzqziBBzMXdZ_C1H74-qCttwb8iD6tGCxfp6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 19 Feb 2019 08:06:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.19 00:47, Alexander Duyck wrote:
> On Mon, Feb 18, 2019 at 9:42 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 18.02.19 18:31, Alexander Duyck wrote:
>>> On Mon, Feb 18, 2019 at 8:59 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 18.02.19 17:49, Michael S. Tsirkin wrote:
>>>>> On Sat, Feb 16, 2019 at 10:40:15AM +0100, David Hildenbrand wrote:
>>>>>> It would be worth a try. My feeling is that a synchronous report after
>>>>>> e.g. 512 frees should be acceptable, as it seems to be acceptable on
>>>>>> s390x. (basically always enabled, nobody complains).
>>>>>
>>>>> What slips under the radar on an arch like s390 might
>>>>> raise issues for a popular arch like x86. My fear would be
>>>>> if it's only a problem e.g. for realtime. Then you get
>>>>> a condition that's very hard to trigger and affects
>>>>> worst case latencies.
>>>>
>>>> Realtime should never use free page hinting. Just like it should never
>>>> use ballooning. Just like it should pin all pages in the hypervisor.
>>>>
>>>>>
>>>>> But really what business has something that is supposedly
>>>>> an optimization blocking a VCPU? We are just freeing up
>>>>> lots of memory why is it a good idea to slow that
>>>>> process down?
>>>>
>>>> I first want to know that it is a problem before we declare it a
>>>> problem. I provided an example (s390x) where it does not seem to be a
>>>> problem. One hypercall ~every 512 frees. As simple as it can get.
>>>>
>>>> No trying to deny that it could be a problem on x86, but then I assume
>>>> it is only a problem in specific setups.
>>>>
>>>> I would much rather prefer a simple solution that can eventually be
>>>> disabled in selected setup than a complicated solution that tries to fit
>>>> all possible setups. Realtime is one of the examples where such stuff is
>>>> to be disabled either way.
>>>>
>>>> Optimization of space comes with a price (here: execution time).
>>>
>>> One thing to keep in mind though is that if you are already having to
>>> pull pages in and out of swap on the host in order be able to provide
>>> enough memory for the guests the free page hinting should be a
>>> significant win in terms of performance.
>>
>> Indeed. And also we are in a virtualized environment already, we can
>> have any kind of sudden hickups. (again, realtime has special
>> requirements on the setup)
>>
>> Side note: I like your approach because it is simple. I don't like your
>> approach because it cannot deal with fragmented memory. And that can
>> happen easily.
>>
>> The idea I described here can be similarly be an extension of your
>> approach, merging in a "batched reporting" Nitesh proposed, so we can
>> report on something < MAX_ORDER, similar to s390x. In the end it boils
>> down to reporting via hypercall vs. reporting via virtio. The main point
>> is that it is synchronous and batched. (and that we properly take care
>> of the race between host freeing and guest allocation)
> 
> I'd say the discussion is even simpler then that. My concern is more
> synchronous versus asynchronous. I honestly think the cost for a
> synchronous call is being overblown and we are likely to see the fault
> and zeroing of pages cost more than the hypercall or virtio
> transaction itself.

The overhead of page faults and zeroing should be mitigated by
MADV_FREE, as Andrea correctly stated (thanks!). Then, the call overhead
(context switch) becomes relevant.

We have various discussions now :) And I think they are related.

synchronous versus asynchronous
batched vs. non-batched
MAX_ORDER - 1 vs. other/none magic number

1. synchronous call without batching on every kfree is bad. The
interface is fixed to big magic numbers, otherwise we end up having a
hypercall on every kfree. This is your approach.

2. asynchronous calls without batching would most probably have similar
problems with small granularities as we had when ballooning without
batching. Just overhead we can avoid.

3. synchronous and batched is what s390x does. It can deal with page
granularity. It is what I initially described in this sub-thread.

4. asynchronous and batched. This is the other approach we discussed
yesterday. If we can get it implemented, I would be interested in
performance numbers.

As far as I understood, Michael seems to favor something like 4 (and I
assume eventually 2 if it is similarly fast). I am a friend of either 3
or 4.

> 
> Also one reason why I am not a fan of working with anything less than
> PMD order is because there have been issues in the past with false
> memory leaks being created when hints were provided on THP pages that
> essentially fragmented them. I guess hugepaged went through and
> started trying to reassemble the huge pages and as a result there have
> been apps that ended up consuming more memory than they would have
> otherwise since they were using fragments of THP pages after doing an
> MADV_DONTNEED on sections of the page.

I understand your concerns, but we should not let bugs in the hypervisor
dictate the design. Bugs are there to be fixed. Interesting read,
though, thanks!

-- 

Thanks,

David / dhildenb
