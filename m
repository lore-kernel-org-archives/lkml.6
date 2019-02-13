Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9215DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479F0222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393494AbfBMR73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:59:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfBMR73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:59:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB8F731A338;
        Wed, 13 Feb 2019 17:59:28 +0000 (UTC)
Received: from [10.36.116.51] (ovpn-116-51.ams2.redhat.com [10.36.116.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CFD55C219;
        Wed, 13 Feb 2019 17:59:24 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "Wang, Wei W" <wei.w.wang@intel.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "dodgen@google.com" <dodgen@google.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF68060@shsmsx102.ccr.corp.intel.com>
 <17adc05d-91f9-682b-d9a4-485e6a631422@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF6B52A@shsmsx102.ccr.corp.intel.com>
 <62b43699-f548-e0da-c944-80702ceb7202@redhat.com>
 <20190213121000-mutt-send-email-mst@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <a0035ddf-c871-b4e5-ca56-61da5c192dac@redhat.com>
Date:   Wed, 13 Feb 2019 18:59:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213121000-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 13 Feb 2019 17:59:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>
>>>> Nitesh uses MADV_FREE here (as far as I recall :) ), to only mark pages as
>>>> candidates for removal and if the host is low on memory, only scanning the
>>>> guest page tables is sufficient to free up memory.
>>>>
>>>> But both points might just be an implementation detail in the example you
>>>> describe.
>>>
>>> Yes, it is an implementation detail. I think DONTNEED would be easier
>>> for the first step.
>>>
>>>>
>>>>>
>>>>> In above 2), get_free_page_hints clears the bits which indicates that those
>>>> pages are not ready to be used by the guest yet. Why?
>>>>> This is because 3) will unmap the underlying physical pages from EPT.
>>>> Normally, when guest re-visits those pages, EPT violations and QEMU page
>>>> faults will get a new host page to set up the related EPT entry. If guest uses
>>>> that page before the page gets unmapped (i.e. right before step 3), no EPT
>>>> violation happens and the guest will use the same physical page that will be
>>>> unmapped and given to other host threads. So we need to make sure that
>>>> the guest free page is usable only after step 3 finishes.
>>>>>
>>>>> Back to arch_alloc_page(), it needs to check if the allocated pages
>>>>> have "1" set in the bitmap, if that's true, just clear the bits. Otherwise, it
>>>> means step 2) above has happened and step 4) hasn't been reached. In this
>>>> case, we can either have arch_alloc_page() busywaiting a bit till 4) is done
>>>> for that page Or better to have a balloon callback which prioritize 3) and 4)
>>>> to make this page usable by the guest.
>>>>
>>>> Regarding the latter, the VCPU allocating a page cannot do anything if the
>>>> page (along with other pages) is just being freed by the hypervisor.
>>>> It has to busy-wait, no chance to prioritize.
>>>
>>> I meant this:
>>> With this approach, essentially the free pages have 2 states:
>>> ready free page: the page is on the free list and it has "1" in the bitmap
>>> non-ready free page: the page is on the free list and it has "0" in the bitmap
>>> Ready free pages are those who can be allocated to use.
>>> Non-ready free pages are those who are in progress of being reported to
>>> host and the related EPT mapping is about to be zapped. 
>>>
>>> The non-ready pages are inserted into the report_vq and waiting for the
>>> host to zap the mappings one by one. After the mapping gets zapped
>>> (which means the backing host page has been taken away), host acks to
>>> the guest to mark the free page as ready free page (set the bit to 1 in the bitmap).
>>
>> Yes, that's how I understood your approach. The interesting part is
>> where somebody finds a buddy page and wants to allocate it.
>>
>>>
>>> So the non-ready free page may happen to be used when they are waiting in
>>> the report_vq to be handled by the host to zap the mapping, balloon could
>>> have a fast path to notify the host:
>>> "page 0x1000 is about to be used, don’t zap the mapping when you get
>>> 0x1000 from the report_vq"  /*option [1] */
>>
>> This requires coordination and in any case there will be a scenario
>> where you have to wait for the hypervisor to eventually finish a madv
>> call. You can just try to make that scenario less likely.
>>
>> What you propose is synchronous in the worst case. Getting pages of the
>> buddy makes it possible to have it done completely asynchronous. Nobody
>> allocating a page has to wait.
>>
>>>
>>> Or
>>>
>>> "page 0x1000 is about to be used, please zap the mapping NOW, i.e. do 3) and 4) above,
>>> so that the free page will be marked as ready free page and the guest can use it".
>>> This option will generate an extra EPT violation and QEMU page fault to get a new host
>>> page to back the guest ready free page.
>>
>> Again, coordination with the hypervisor while allocating a page. That is
>> to be avoided in any case.
>>
>>>
>>>>
>>>>>
>>>>> Using bitmaps to record free page hints don't need to take the free pages
>>>> off the buddy list and return them later, which needs to go through the long
>>>> allocation/free code path.
>>>>>
>>>>
>>>> Yes, but it means that any process is able to get stuck on such a page for as
>>>> long as it takes to report the free pages to the hypervisor and for it to call
>>>> madvise(pfn_start, DONTNEED) on any such page.
>>>
>>> This only happens when the guest thread happens to get allocated on a page which is
>>> being reported to the host. Using option [1] above will avoid this.
>>
>> I think getting pages out of the buddy system temporarily is the only
>> way we can avoid somebody else stumbling over a page currently getting
>> reported by the hypervisor. Otherwise, as I said, there are scenarios
>> where a allocating VCPU has to wait for the hypervisor to finish the
>> "freeing" task. While you can try to "speedup" that scenario -
>> "hypervisor please prioritize" you cannot avoid it. There will be busy
>> waiting.
> 
> Right - there has to be waiting. But it does not have to be busy -
> if you can defer page use until interrupt, that's one option.
> Further if you are ready to exit to hypervisor it does not have to be
> busy waiting.  In particular right now virtio does not have a capability
> to stop queue processing by device.  We could add that if necessary.  In
> that case, you would stop queue and detach buffers.  It is already
> possible by reseting the balloon.  Naturally there is no magic - you
> exit to hypervisor and block there. It's not all that great
> in that VCPU does not run at all. But it is not busy waiting.

Of course, you can always yield to the hypervisor and not call it busy
waiting. From the guest point of view, it is busy waiting. The VCPU is
to making progress. If I am not wrong, one can easily construct examples
where all VCPUs in the guest are waiting for the hypervisor to
madv(dontneed) pages. I don't like that approach

Especially if temporarily getting pages out of the buddy resolves these
issues and seems to work.


-- 

Thanks,

David / dhildenb
