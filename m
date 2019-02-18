Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB1DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE7921773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732966AbfBRSaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:30:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731024AbfBRS37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:29:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21897811D3;
        Mon, 18 Feb 2019 18:29:59 +0000 (UTC)
Received: from [10.36.116.84] (ovpn-116-84.ams2.redhat.com [10.36.116.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 214715D717;
        Mon, 18 Feb 2019 18:29:44 +0000 (UTC)
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
Message-ID: <f396836d-9bbd-e3e2-c7b0-d921bf1c9ed1@redhat.com>
Date:   Mon, 18 Feb 2019 19:29:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218122636-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 18 Feb 2019 18:29:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.02.19 18:54, Michael S. Tsirkin wrote:
> On Mon, Feb 18, 2019 at 05:59:06PM +0100, David Hildenbrand wrote:
>> On 18.02.19 17:49, Michael S. Tsirkin wrote:
>>> On Sat, Feb 16, 2019 at 10:40:15AM +0100, David Hildenbrand wrote:
>>>> It would be worth a try. My feeling is that a synchronous report after
>>>> e.g. 512 frees should be acceptable, as it seems to be acceptable on
>>>> s390x. (basically always enabled, nobody complains).
>>>
>>> What slips under the radar on an arch like s390 might
>>> raise issues for a popular arch like x86. My fear would be
>>> if it's only a problem e.g. for realtime. Then you get
>>> a condition that's very hard to trigger and affects
>>> worst case latencies.
>>
>> Realtime should never use free page hinting.
> 
> OK maybe document this in commit log. RT project has
> enough work as it is without need to untangle
> complex dependencies with other features.

We most certainly should!!

> 
>> Just like it should never
>> use ballooning.
> 
> Well its an aside but why not ballooning? As long as hypervisor does not touch the balloon,
> and you don't touch the (weird, not really documented properly)
> deflate on oom, you are fine.
> Real time is violated when you reconfigure balloon,
> but  after you are done guest is real time again.
> And management certainly knows it that it did something
> with balloon at the exact same time there was a latency spike.

Fair enough, this is a potential use case. But it goes hand in hand with
pinning/unpinning pages. So yes, while this would be possible - modify
balloon in  "no real time period", I doubt this is a real life scenario.
As always, I like to be taught differently :)

Similar to "start reporting on !RT activity" and "stop reporting on RT
activity"

> 
> 
> I think this might not work well right now, but generally
> I think it should be fine. No?
> 
> 
>> Just like it should pin all pages in the hypervisor.
> 
> BTW all this is absolutely interesting to fix.
> But I agree wrt hinting being kind of like pinning.

Yes, this is all interesting stuff :)

> 
> 
>>>
>>> But really what business has something that is supposedly
>>> an optimization blocking a VCPU? We are just freeing up
>>> lots of memory why is it a good idea to slow that
>>> process down?
>>
>> I first want to know that it is a problem before we declare it a
>> problem. I provided an example (s390x) where it does not seem to be a
>> problem. One hypercall ~every 512 frees. As simple as it can get.
>>
>> No trying to deny that it could be a problem on x86, but then I assume
>> it is only a problem in specific setups.
> 
> But which setups? How are we going to identify them?

I guess is simple (I should be carefuly with this word ;) ): As long as
you don't isolate + pin your CPUs in the hypervisor, you can expect any
kind of sudden hickups. We're in a virtualized world. Real time is one
example.

Using kernel threads like Nitesh does right now? It can be scheduled
anytime by the hypervisor on the exact same cpu. Unless you isolate +
pin in the hypervor. So the same problem applies.

> 
>> I would much rather prefer a simple solution that can eventually be
>> disabled in selected setup than a complicated solution that tries to fit
>> all possible setups.
> 
> Well I am not sure just disabling it is reasonable.  E.g. Alex shows
> drastic boot time speedups.  You won't be able to come to people later
> and say oh you need to disable this feature yes you will stop getting
> packet loss once in a while but you also won't be able to boot your VMs
> quickly enough.

The guest is always free to disable once up. Yes, these are nice
details, but I consider these improvements we can work on later.

> 
> So I'm fine with a simple implementation but the interface needs to
> allow the hypervisor to process hints in parallel while guest is
> running.  We can then fix any issues on hypervisor without breaking
> guests.

Yes, I am fine with defining an interface that theoretically let's us
change the implementation in the guest later. I consider this even a
prerequisite. IMHO the interface shouldn't be different, it will be
exactly the same.

It is just "who" calls the batch freeing and waits for it. And as I
outlined here, doing it without additional threads at least avoids us
for now having to think about dynamic data structures and that we can
sometimes not report "because the thread is still busy reporting or
wasn't scheduled yet".

> 
> 
>> Realtime is one of the examples where such stuff is
>> to be disabled either way.
> 
> OK so we have identified realtime. Nice even though it wasn't documented
> anywhere. Are there other workloads? What are they?

As stated above, I think these environments are easy to spot. As long as
you don't isolate and pin, surprises can happen anytime. Can you think
of others?

(this stuff really has to be documented)

> 
> 
>> Optimization of space comes with a price (here: execution time).
> 
> I am not sure I agree. If hinting patches just slowed everyone down they
> would be useless. Note how Alex show-cased this by demonstrating
> faster boot times.

Of course, like compressing the whole guest memory, things you might not
want to do ;) In the end, there has to be a net benefit.

> 
> Unlike regular ballooning, this doesn't do much to optimize space. There
> are no promises so host must still have enough swap to fit guest memory
> anyway.
> 
> All free page hinting does is reduce IO on the hypervisor.
> 
> So it's a tradeoff.

+1 to that.


The nice thing about this approach is that we can easily tweak "how many
to report in one shot" and "which sizes to report". We can play with it
fairly easily.

-- 

Thanks,

David / dhildenb
