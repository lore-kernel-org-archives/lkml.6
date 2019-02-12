Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C4BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD002083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbfBLTeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:34:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23675 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbfBLTeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:34:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 085A05947A;
        Tue, 12 Feb 2019 19:34:30 +0000 (UTC)
Received: from [10.36.116.21] (ovpn-116-21.ams2.redhat.com [10.36.116.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B461F5C219;
        Tue, 12 Feb 2019 19:34:25 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     Nitesh Narayan Lal <nitesh@redhat.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "dodgen@google.com" <dodgen@google.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF68060@shsmsx102.ccr.corp.intel.com>
 <17adc05d-91f9-682b-d9a4-485e6a631422@redhat.com>
 <deb20a92-82bf-5d76-8a2b-447d9f2df36c@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <4d579090-ab81-b6ed-5f22-568b633a72e2@redhat.com>
Date:   Tue, 12 Feb 2019 20:34:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <deb20a92-82bf-5d76-8a2b-447d9f2df36c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 12 Feb 2019 19:34:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.02.19 18:24, Nitesh Narayan Lal wrote:
> 
> On 2/12/19 4:24 AM, David Hildenbrand wrote:
>> On 12.02.19 10:03, Wang, Wei W wrote:
>>> On Tuesday, February 5, 2019 4:19 AM, Nitesh Narayan Lal wrote:
>>>> The following patch-set proposes an efficient mechanism for handing freed
>>>> memory between the guest and the host. It enables the guests with no page
>>>> cache to rapidly free and reclaims memory to and from the host respectively.
>>>>
>>>> Benefit:
>>>> With this patch-series, in our test-case, executed on a single system and
>>>> single NUMA node with 15GB memory, we were able to successfully launch
>>>> atleast 5 guests when page hinting was enabled and 3 without it. (Detailed
>>>> explanation of the test procedure is provided at the bottom).
>>>>
>>>> Changelog in V8:
>>>> In this patch-series, the earlier approach [1] which was used to capture and
>>>> scan the pages freed by the guest has been changed. The new approach is
>>>> briefly described below:
>>>>
>>>> The patch-set still leverages the existing arch_free_page() to add this
>>>> functionality. It maintains a per CPU array which is used to store the pages
>>>> freed by the guest. The maximum number of entries which it can hold is
>>>> defined by MAX_FGPT_ENTRIES(1000). When the array is completely filled, it
>>>> is scanned and only the pages which are available in the buddy are stored.
>>>> This process continues until the array is filled with pages which are part of
>>>> the buddy free list. After which it wakes up a kernel per-cpu-thread.
>>>> This kernel per-cpu-thread rescans the per-cpu-array for any re-allocation
>>>> and if the page is not reallocated and present in the buddy, the kernel
>>>> thread attempts to isolate it from the buddy. If it is successfully isolated, the
>>>> page is added to another per-cpu array. Once the entire scanning process is
>>>> complete, all the isolated pages are reported to the host through an existing
>>>> virtio-balloon driver.
>>>  Hi Nitesh,
>>>
>>> Have you guys thought about something like below, which would be simpler:
>> Responding because I'm the first to stumble over this mail, hah! :)
>>
>>> - use bitmaps to record free pages, e.g. xbitmap: https://lkml.org/lkml/2018/1/9/304.
>>>   The bitmap can be indexed by the guest pfn, and it's globally accessed by all the CPUs;
>> Global means all VCPUs will be competing potentially for a single lock
>> when freeing/allocating a page, no? What if you have 64VCPUs
>> allocating/freeing memory like crazy?
>>
>> (I assume some kind of locking is required even if the bitmap would be
>> atomic. Also, doesn't xbitmap mean that we eventually have to allocate
>> memory at places where we don't want to - e.g. from arch_free_page ?)
>>
>> That's the big benefit of taking the pages of the buddy free list. Other
>> VCPUs won't stumble over them, waiting for them to get freed in the
>> hypervisor.
>>
>>> - arch_free_page(): set the bits of the freed pages from the bitmap
>>>  (no per-CPU array with hardcoded fixed length and no per-cpu scanning thread)
>>> - arch_alloc_page(): clear the related bits from the bitmap
>>> - expose 2 APIs for the callers:
>>>   -- unsigned long get_free_page_hints(unsigned long pfn_start, unsigned int nr); 
>>>      This API searches for the next free page chunk (@nr of pages), starting from @pfn_start.
>>>      Bits of those free pages will be cleared after this function returns.
>>>   -- void put_free_page_hints(unsigned long pfn_start, unsigned int nr);
>>>      This API sets the @nr continuous bits starting from pfn_start.
>>>
>>> Usage example with balloon:
>>> 1) host requests to start ballooning;
>>> 2) balloon driver get_free_page_hints and report the hints to host via report_vq;
>>> 3) host calls madvise(pfn_start, DONTNEED) for each reported chunk of free pages and put back pfn_start to ack_vq;
>>> 4) balloon driver receives pfn_start and calls put_free_page_hints(pfn_start) to have the related bits from the bitmap to be set, indicating that those free pages are ready to be allocated.
>> This sounds more like "the host requests to get free pages once in a
>> while" compared to "the host is always informed about free pages". At
>> the time where the host actually has to ask the guest (e.g. because the
>> host is low on memory), it might be to late to wait for guest action.
>> Nitesh uses MADV_FREE here (as far as I recall :) ), to only mark pages
>> as candidates for removal and if the host is low on memory, only
>> scanning the guest page tables is sufficient to free up memory.
>>
>> But both points might just be an implementation detail in the example
>> you describe.
>>
>>> In above 2), get_free_page_hints clears the bits which indicates that those pages are not ready to be used by the guest yet. Why?
>>> This is because 3) will unmap the underlying physical pages from EPT. Normally, when guest re-visits those pages, EPT violations and QEMU page faults will get a new host page to set up the related EPT entry. If guest uses that page before the page gets unmapped (i.e. right before step 3), no EPT violation happens and the guest will use the same physical page that will be unmapped and given to other host threads. So we need to make sure that the guest free page is usable only after step 3 finishes.
>>>
>>> Back to arch_alloc_page(), it needs to check if the allocated pages have "1" set in the bitmap, if that's true, just clear the bits. Otherwise, it means step 2) above has happened and step 4) hasn't been reached. In this case, we can either have arch_alloc_page() busywaiting a bit till 4) is done for that page
>>> Or better to have a balloon callback which prioritize 3) and 4) to make this page usable by the guest.
>> Regarding the latter, the VCPU allocating a page cannot do anything if
>> the page (along with other pages) is just being freed by the hypervisor.
>> It has to busy-wait, no chance to prioritize.
>>
>>> Using bitmaps to record free page hints don't need to take the free pages off the buddy list and return them later, which needs to go through the long allocation/free code path.
>>>
>> Yes, but it means that any process is able to get stuck on such a page
>> for as long as it takes to report the free pages to the hypervisor and
>> for it to call madvise(pfn_start, DONTNEED) on any such page.
>>
>> Nice idea, but I think we definitely need something the can potentially
>> be implemented per-cpu without any global locks involved.
>>
>> Thanks!
>>
>>> Best,
>>> Wei
>>>
> Hi Wei,
> 
> For your comment, I agree with David. If we have one global per-cpu, we
> will have to acquire a lock.
> Also as David mentioned the idea is to derive the hints from the guest,
> rather than host asking for free pages.
> 
> However, I am wondering if having per-cpu bitmaps is possible?
> Using this I can possibly get rid of the fixed array size issue.
> 

I assume we will have problems with dynamically sized bitmaps - memory
has to be allocated. Similar to a dynamically sized list.

But it is definitely worth investigating.

-- 

Thanks,

David / dhildenb
