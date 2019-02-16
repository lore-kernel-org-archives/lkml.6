Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65A2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 09:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64801222D7
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 09:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbfBPJkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 04:40:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfBPJkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 04:40:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43A0C81DE3;
        Sat, 16 Feb 2019 09:40:30 +0000 (UTC)
Received: from [10.36.116.77] (ovpn-116-77.ams2.redhat.com [10.36.116.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C765600C5;
        Sat, 16 Feb 2019 09:40:16 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
        yang.zhang.wz@gmail.com, riel@surriel.com, mst@redhat.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
Date:   Sat, 16 Feb 2019 10:40:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204201854.2328-1-nitesh@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sat, 16 Feb 2019 09:40:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.02.19 21:18, Nitesh Narayan Lal wrote:

Hi Nitesh,

I thought again about how s390x handles free page hinting. As that seems
to work just fine, I guess sticking to a similar model makes sense.


I already explained in this thread how it works on s390x, a short summary:

1. Each VCPU has a buffer of pfns to be reported to the hypervisor. If I
am not wrong, it contains 512 entries, so is exactly 1 page big. This
buffer is stored in the hypervisor and is on page granularity.

2. This page buffer is managed via the ESSA instruction. In addition, to
synchronize with the guest ("page reused when freeing in the
hypervisor"), special bits in the host->guest page table can be
set/locked via the ESSA instruction by the guest and similarly accessed
by the hypervisor.

3. Once the buffer is full, the guest does a synchronous hypercall,
going over all 512 entries and zapping them (== similar to MADV_DONTNEED)


To mimic that, we

1. Have a static buffer per VCPU in the guest with 512 entries. You
basically have that already.

2. On every free, add the page _or_ the page after merging by the buddy
(e.g. MAX_ORDER - 1) to the buffer (this is where we could be better
than s390x). You basically have that already.

3. If the buffer is full, try to isolate all pages and do a synchronous
report to the hypervisor. You have the first part already. The second
part would require a change (don't use a separate/global thread to do
the hinting, just do it synchronously).

4. One hinting is done, putback all isolated pages to the budy. You
basically have that already.


For 3. we can try what you have right now, using virtio. If we detect
that's a problem, we can do it similar to what Alexander proposes and
just do a bare hypercall. It's just a different way of carrying out the
same task.


This approach
1. Mimics what s390x does, besides supporting different granularities.
To synchronize guest->host we simply take the pages off the buddy.

2. Is basically what Alexander does, however his design limitation is
that doing any hinting on smaller granularities will not work because
there will be too many synchronous hints. Bad on fragmented guests.

3. Does not require any dynamic data structures in the guest.

4. Does not block allocation paths.

5. Blocks on e.g. every 512'ed free. It seems to work on s390x, why
shouldn't it for us. We have to measure.

6. We are free to decide which granularity we report.

7. Potentially works even if the guest memory is fragmented (little
MAX_ORDER - 1) pages.

It would be worth a try. My feeling is that a synchronous report after
e.g. 512 frees should be acceptable, as it seems to be acceptable on
s390x. (basically always enabled, nobody complains).

We would have to play with how to enable/disable reporting and when to
not report because it's not worth it in the guest (e.g. low on memory).


Do you think something like this would be easy to change/implement and
measure?

Thanks!

> The following patch-set proposes an efficient mechanism for handing freed memory between the guest and the host. It enables the guests with no page cache to rapidly free and reclaims memory to and from the host respectively.
> 
> Benefit:
> With this patch-series, in our test-case, executed on a single system and single NUMA node with 15GB memory, we were able to successfully launch atleast 5 guests 
> when page hinting was enabled and 3 without it. (Detailed explanation of the test procedure is provided at the bottom).
> 
> Changelog in V8:
> In this patch-series, the earlier approach [1] which was used to capture and scan the pages freed by the guest has been changed. The new approach is briefly described below:
> 
> The patch-set still leverages the existing arch_free_page() to add this functionality. It maintains a per CPU array which is used to store the pages freed by the guest. The maximum number of entries which it can hold is defined by MAX_FGPT_ENTRIES(1000). When the array is completely filled, it is scanned and only the pages which are available in the buddy are stored. This process continues until the array is filled with pages which are part of the buddy free list. After which it wakes up a kernel per-cpu-thread.
> This kernel per-cpu-thread rescans the per-cpu-array for any re-allocation and if the page is not reallocated and present in the buddy, the kernel thread attempts to isolate it from the buddy. If it is successfully isolated, the page is added to another per-cpu array. Once the entire scanning process is complete, all the isolated pages are reported to the host through an existing virtio-balloon driver.
> 
> Known Issues:
> 	* Fixed array size: The problem with having a fixed/hardcoded array size arises when the size of the guest varies. For example when the guest size increases and it starts making large allocations fixed size limits this solution's ability to capture all the freed pages. This will result in less guest free memory getting reported to the host.
> 
> Known code re-work:
> 	* Plan to re-use Wei's work, which communicates the poison value to the host.
> 	* The nomenclatures used in virtio-balloon needs to be changed so that the code can easily be distinguished from Wei's Free Page Hint code.
> 	* Sorting based on zonenum, to avoid repetitive zone locks for the same zone.
> 
> Other required work:
> 	* Run other benchmarks to evaluate the performance/impact of this approach.
> 
> Test case:
> Setup:
> Memory-15837 MB
> Guest Memory Size-5 GB
> Swap-Disabled
> Test Program-Simple program which allocates 4GB memory via malloc, touches it via memset and exits.
> Use case-Number of guests that can be launched completely including the successful execution of the test program.
> Procedure: 
> The first guest is launched and once its console is up, the test allocation program is executed with 4 GB memory request (Due to this the guest occupies almost 4-5 GB of memory in the host in a system without page hinting). Once this program exits at that time another guest is launched in the host and the same process is followed. We continue launching the guests until a guest gets killed due to low memory condition in the host.
> 
> Result:
> Without Hinting-3 Guests
> With Hinting-5 to 7 Guests(Based on the amount of memory freed/captured).
> 
> [1] https://www.spinics.net/lists/kvm/msg170113.html 
> 
> 


-- 

Thanks,

David / dhildenb
