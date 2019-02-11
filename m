Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD8FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F6920823
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfBKJ2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:28:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfBKJ2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:28:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC71A87623;
        Mon, 11 Feb 2019 09:28:45 +0000 (UTC)
Received: from [10.36.116.241] (ovpn-116-241.ams2.redhat.com [10.36.116.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A3501A7D1;
        Mon, 11 Feb 2019 09:28:32 +0000 (UTC)
Subject: Re: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and report
 free pages
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
References: <20190204201854.2328-7-nitesh@redhat.com>
 <20190205153607-mutt-send-email-mst@kernel.org>
 <ab671cf4-f379-7be7-50d3-ffb41c3b91ba@redhat.com>
 <20190205165514-mutt-send-email-mst@kernel.org>
 <CAKgT0UdcrbUw-wfeXQPjnnbTWrvNB0zpwq-bCv4EEWcOSizL_w@mail.gmail.com>
 <ab03c35e-b2bb-cb96-4701-436a4e2770d1@redhat.com>
 <CAKgT0UcEFi7Rq9+EnLNNm61782QYRT6XZQDgbWFt2S8eMLf=qA@mail.gmail.com>
 <e304f4ed-5aea-4a2b-1b83-7d4f8bb37e6e@redhat.com>
 <20190208163601-mutt-send-email-mst@kernel.org>
 <CAKgT0UcKkS2RsZj28sB3SzMyX9_VrMtZTd+aGYD_FPJn_DA4UA@mail.gmail.com>
 <20190209192104-mutt-send-email-mst@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <19f6d1f2-9287-6113-07b8-1988907b6108@redhat.com>
Date:   Mon, 11 Feb 2019 10:28:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190209192104-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 11 Feb 2019 09:28:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.02.19 01:38, Michael S. Tsirkin wrote:
> On Fri, Feb 08, 2019 at 02:05:09PM -0800, Alexander Duyck wrote:
>> On Fri, Feb 8, 2019 at 1:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> On Fri, Feb 08, 2019 at 03:41:55PM -0500, Nitesh Narayan Lal wrote:
>>>>>> I am also planning to try Michael's suggestion of using MAX_ORDER - 1.
>>>>>> However I am still thinking about a workload which I can use to test its
>>>>>> effectiveness.
>>>>> You might want to look at doing something like min(MAX_ORDER - 1,
>>>>> HUGETLB_PAGE_ORDER). I know for x86 a 2MB page is the upper limit for
>>>>> THP which is the most likely to be used page size with the guest.
>>>> Sure, thanks for the suggestion.
>>>
>>> Given current hinting in balloon is MAX_ORDER I'd say
>>> share code. If you feel a need to adjust down the road,
>>> adjust both of them with actual testing showing gains.
>>
>> Actually I'm left kind of wondering why we are even going through
>> virtio-balloon for this?
> 
> Just look at what does it do.
> 
> It improves memory overcommit if guests are cooperative, and it does
> this by giving the hypervisor addresses of pages which it can discard.
> 
> It's just *exactly* like the balloon with all the same limitations.

I agree, this belongs to virtio-balloon *unless* we run into real
problems implementing it via an asynchronous mechanism.

> 
>> It seems like this would make much more sense
>> as core functionality of KVM itself for the specific architectures
>> rather than some side thing.

Whatever can be handled in user space and does not have significant
performance impacts should be handled in user space. If we run into real
problems with that approach, fair enough. (e.g. vcpu yielding is a good
example where an implementation in KVM makes sense, not going via QEMU)

> 
> Well same as balloon: whether it's useful to you at all
> would very much depend on your workloads.
> 
> This kind of cooperative functionality is good for co-located
> single-tenant VMs. That's pretty niche.  The core things in KVM
> generally don't trust guests.
> 
> 
>> In addition this could end up being
>> redundant when you start getting into either the s390 or PowerPC
>> architectures as they already have means of providing unused page
>> hints.

I'd like to note that on s390x the functionality is not provided when
running nested guests. And there are real problems getting it ever
supported. (see description below how it works on s390x, the issue for
nested guests are the bits in the guest -> host page tables we cannot
support for nested guests).

Hinting only works for guests running one level under LPAR (with a
recent machine), but not nested guests.

(LPAR -> KVM1 works, LPAR - KVM1 -> KVM2 foes not work for the latter)

So an implementation for s390 would still make sense for this scenario.

> 
> Interesting. Is there host support in kvm?

On s390x there is. It works on page granularity and synchronization
between guest/host ("don't drop a page in the host while the guest is
reusing it") is done via special bits in the host->guest page table.
Instructions in the guest are able to modify these bits. A guest can
configure a "usage state" of it's backed PTEs. E.g. "unused" or "stable".

Whenever a page in the guest is freed/reused, the ESSA instruction is
triggered in the guest. It will modify the page table bits and add the
guest phyical pfn to a buffer in the host. Once that buffer is full,
ESSA will trigger an intercept to the hypervisor. Here, all these
"unused" pages can be zapped.

Also, when swapping a page out in the hypervisor, if it was masked by
the guest as unused or logically zero, instead of swapping out the page,
it can simply be dropped and a fresh zero page can be supplied when the
guest tries to access it.

"ESSA" is implemented in KVM in arch/s390/kvm/priv.c:handle_essa().

So on s390x, it works because the synchronization with the hypervisor is
directly built into hw vitualization support (guest->host page tables +
instruction) and ESSA will not intercept on every call (due to the buffer).
> 
> 
>> I have a set of patches I proposed that add similar functionality via
>> a KVM hypercall for x86 instead of doing it as a part of a Virtio
>> device[1].  I'm suspecting the overhead of doing things this way is
>> much less then having to make multiple madvise system calls from QEMU
>> back into the kernel.
> 
> Well whether it's a virtio device is orthogonal to whether it's an
> madvise call, right? You can build vhost-pagehint and that can
> handle requests in a VQ within balloon and do it
> within host kernel directly.
> 
> virtio rings let you pass multiple pages so it's really hard to
> say which will win outright - maybe it's more important
> to coalesce exits.

We don't know until we measure it.

-- 

Thanks,

David / dhildenb
