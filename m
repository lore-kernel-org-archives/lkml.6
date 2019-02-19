Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39755C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D1821738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfBSWg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:36:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729814AbfBSWg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:36:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5483CC068BF8;
        Tue, 19 Feb 2019 22:36:57 +0000 (UTC)
Received: from [10.36.116.45] (ovpn-116-45.ams2.redhat.com [10.36.116.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F068D60BF6;
        Tue, 19 Feb 2019 22:36:44 +0000 (UTC)
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
 <77e71dc3-640b-bbf6-6a47-bb2371c06172@redhat.com>
 <CAKgT0UfqSQoBehg7JZ=tzmk7wqSF=h9aMnsk_wpQXqh0NyRCHA@mail.gmail.com>
 <eadcb5c5-2252-80f4-e396-0d2bbbd53694@redhat.com>
 <CAKgT0Uc5CXZLUAqR8G4=aMmsfu2SMHfvGUjwPBmDCPT839Q-rg@mail.gmail.com>
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
Message-ID: <3c999cd8-245c-513f-c314-2337bccb927e@redhat.com>
Date:   Tue, 19 Feb 2019 23:36:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uc5CXZLUAqR8G4=aMmsfu2SMHfvGUjwPBmDCPT839Q-rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 19 Feb 2019 22:36:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> I can't follow. We are talking about something as simple as a minimum
>> page granularity here that can easily be configured. Nothing that
>> screams for different implementations. But I get your point, we could
>> tune for different architectures.
> 
> I was thinking about the guest side of things. Basically if we need to
> define different page orders for different architectures then we start
> needing to do architecture specific includes. Then if we throw in
> stuff like the fact that the first level of KVM can make use of the
> host style hints then that is another thing that will be a difference
> int he different architectures. I'm just worried this stuff is going
> to start adding up to a bunch of "#ifdef" cruft if we are trying to do
> this as a virtio driver.

I agree that something like that is to be avoided. As MST pointed out,
feature bits and config space are a nice way to solve that at least on
the virtio side.

> 
>>>
>>>>>
>>>>> As far as fragmentation my thought is that we may want to look into
>>>>> adding support to the guest for prioritizing defragmentation on pages
>>>>> lower than THP size. Then that way we could maintain the higher
>>>>> overall performance with or without the hinting since shuffling lower
>>>>> order pages around between guests would start to get expensive pretty
>>>>> quick.
>>>>
>>>> My take would be, design an interface/mechanism that allows any kind of
>>>> granularity. You can than balance between cpu overead and space shifting.
>>>
>>> The problem with using "any kind of granularity" is that in the case
>>> of memory we are already having problems with 4K pages being deemed
>>> too small of a granularity to be useful for anything and making
>>> operations too expensive.
>>
>> No, sorry, s390x does it. And via batch reporting it could work. Not
>> saying we should do page granularity, but "to be useful for anything" is
>> just wrong.
> 
> Yeah, I was engaging in a bit of hyperbole. I have had a headache this
> morning so I am a bit cranky.

No worries, I am very happy about this discussion. :)

> 
> So I am assuming the batching is the reason why you also have a
> arch_alloc_page then for the s390 so that you can abort the hint if a
> page is reallocated before the hint is processed then? I just want to
> confirm so that my understanding of this is correct.

s390x is very special as it actually communicates the page state to the
hypervisor via page table bits in the guest->host mapping. The reporting
is then done batched (and synchronous) via a list of PFNs. But via the
special page table bits (along with the ESSA instruction), requests for
single pages can be canceled any time. So allocation paths are *only*
blocked by a special page lock also part of the page table bits in the
guest->host mapping.

I guess now you are completely confused. The main point is: actual
reporting to _perform_ the free is synchronous + batched. Canceling any
time possible via special synchronization mechanism per page. (that's
why pages are not taken out of the buddy, because canceling is easy)

> 
> If that is the case I would be much happier with an asynchronous page
> hint setup as this doesn't deprive the guest of memory while waiting
> on the hint. The current logic in the patches from Nitesh has the
> pages unavailable to the guest while waiting on the hint and that has
> me somewhat concerned as it is going to hurt cache locality as it will
> guarantee that we cannot reuse the same page if we are doing a cycle
> of alloc and free for the same page size.

My view on things on the current plan and your question:

1. We queue up *potential* hints on kfree per VCPU. We might only queue
after merging in the buddy and if we exceed a certain page order.

2. When that list is full, we *try to* take these pages out of the
buddy. We then trigger asynchronous reporting for the ones where we
succeeded.

3. Once reporting returns, we put back the pages to the buddy.

Between 1 and 2, any page can be reallocated. 2. will simply ignore the
page if it is no longer in the buddy. Pages are removed from the buddy
only between 2 and 3. So hopefully a very short time.

Especially, the queuing might mitigate cache locality issues. And there
are the pcpu lists that - as far as I remember - won't be touched as
these pages are not "official buddy pages" (yet). But this is an
interesting point to keep in mind.

> 
>>>
>>> I'm open to using other page orders for other architectures. Nothing
>>> says we have to stick with THP sized pages for all architectures. I
>>> have just been focused on x86 and this seems like the best fit for the
>>> balance between CPU and freeing of memory for now on that
>>> architecture.
>>>
>>>> I feel like repeating myself, but on s390x hinting is done on page
>>>> granularity, and I have never heard somebody say "how can I turn it off,
>>>> this is slowing down my system too much.". All we know is that one
>>>> hypercall per free is most probably not acceptable. We really have to
>>>> play with the numbers.
>>>
>>> My thought was we could look at doing different implementations for
>>> other architectures such as s390 and powerPC. Odds are the
>>> implementations would be similar but have slight differences where
>>> appropriate such as what order we should start hinting on, or if we
>>> bypass the hypercall/virtio-balloon for a host native approach if
>>> available.
>>>
>>>> I tend to like an asynchronous reporting approach as discussed in this
>>>> thread, we would have to see if Nitesh could get it implemented.
>>>
>>> I agree it would be great if it could work. However I have concerns
>>> given that work on this patch set dates back to 2017, major issues
>>> such as working around device assignment have yet to be addressed, and
>>> it seems like most of the effort is being focused on things that in my
>>> opinion are being over-engineered for little to no benefit.
>>
>> I can understand that you are trying to push your solution. I would do
>> the same. Again, I don't like a pure synchronous approach that works on
>> one-element-at-a-time. Period. Other people might have other opinions.
>> This is mine - luckily I don't have anything to say here :)
>>
>> MST also voted for an asynchronous solution if we can make it work.
>> Nitesh made significant improvements since the 2017. Complicated stuff
>> needs time. No need to rush. People have been talking about free page
>> hinting since 2006. I talked to various people that experimented with
>> bitmap based solutions two years ago.
> 
> Now that I think I have a better understanding of how the s390x is
> handling this I'm beginning to come around to the idea of an
> asynchronous setup. The one thing that has been bugging me about the
> asynchronous approach is the fact that the pages are not available to
> the guest while waiting on the hint to be completed. If we can do
> something like an arch_alloc_page and that would abort the hint and
> allow us to keep the page available while waiting on the hint that
> would be my preferred way of handling this.

We'll have to see if any kind of abortion is easily possible and even
necessary. s390x has the advantage that this synchronization (e.g. for
abortion of a free) is built into the architecture (guest->host page
tables). I guess we cannot tell before Nitesh has some kind of prototype
how much of an issue this actually is.

> 
>> So much to that, if you think your solution is the way to go, please
>> follow up on it. Nitesh seems to have decided to look into the
>> asynchronous approach you also called "great if it could work". As long
>> as we don't run into elementary blockers there, to me it all looks like
>> we are making progress, which is good. If we find out asynchronous
>> doesn't work, synchronous is the only alternative.
> 
> I plan to follow up in the next week or so.
> 
>> And just so you don't get me wrong: Thanks for looking and working on
>> this. And thanks for sharing your opinions and insights! However making
>> a decision about going your way at this point does not seem reasonable
>> to me. We have plenty of time.
> 
> I appreciate the feedback. Sorry if I seemed a bit short. As I
> mentioned I've had a headache most of the morning which hasn't really
> helped my mood.

Absolutely no problem Alex, thanks!


-- 

Thanks,

David / dhildenb
