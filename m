Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977B0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A582073D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfBLJEC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:04:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:36381 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbfBLJEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:04:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 01:04:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="299075799"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2019 01:04:01 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 12 Feb 2019 01:04:00 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 12 Feb 2019 01:04:00 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.207]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.194]) with mapi id 14.03.0415.000;
 Tue, 12 Feb 2019 17:03:58 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "david@redhat.com" <david@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "dodgen@google.com" <dodgen@google.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: RE: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Thread-Topic: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Thread-Index: AQHUvMb57IQCd72gCkOm4okDUKYrcaXb13cw
Date:   Tue, 12 Feb 2019 09:03:57 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DF68060@shsmsx102.ccr.corp.intel.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
In-Reply-To: <20190204201854.2328-1-nitesh@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWMyOTkzODItZTAzYi00NjIwLWI5ZDgtNThhOTE1MmRmMGIxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUVwvSHhTS28xTERXNWIwWVpUSHlHd21Jc2VqVTdGNGZ0cVJybXVRYUI4NnlNSFl2V0NpRnZVSjM3Mm13NkZqdSsifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 5, 2019 4:19 AM, Nitesh Narayan Lal wrote:
> The following patch-set proposes an efficient mechanism for handing freed
> memory between the guest and the host. It enables the guests with no page
> cache to rapidly free and reclaims memory to and from the host respectively.
> 
> Benefit:
> With this patch-series, in our test-case, executed on a single system and
> single NUMA node with 15GB memory, we were able to successfully launch
> atleast 5 guests when page hinting was enabled and 3 without it. (Detailed
> explanation of the test procedure is provided at the bottom).
> 
> Changelog in V8:
> In this patch-series, the earlier approach [1] which was used to capture and
> scan the pages freed by the guest has been changed. The new approach is
> briefly described below:
> 
> The patch-set still leverages the existing arch_free_page() to add this
> functionality. It maintains a per CPU array which is used to store the pages
> freed by the guest. The maximum number of entries which it can hold is
> defined by MAX_FGPT_ENTRIES(1000). When the array is completely filled, it
> is scanned and only the pages which are available in the buddy are stored.
> This process continues until the array is filled with pages which are part of
> the buddy free list. After which it wakes up a kernel per-cpu-thread.
> This kernel per-cpu-thread rescans the per-cpu-array for any re-allocation
> and if the page is not reallocated and present in the buddy, the kernel
> thread attempts to isolate it from the buddy. If it is successfully isolated, the
> page is added to another per-cpu array. Once the entire scanning process is
> complete, all the isolated pages are reported to the host through an existing
> virtio-balloon driver.

 Hi Nitesh,

Have you guys thought about something like below, which would be simpler:

- use bitmaps to record free pages, e.g. xbitmap: https://lkml.org/lkml/2018/1/9/304.
  The bitmap can be indexed by the guest pfn, and it's globally accessed by all the CPUs;
- arch_free_page(): set the bits of the freed pages from the bitmap
 (no per-CPU array with hardcoded fixed length and no per-cpu scanning thread)
- arch_alloc_page(): clear the related bits from the bitmap
- expose 2 APIs for the callers:
  -- unsigned long get_free_page_hints(unsigned long pfn_start, unsigned int nr); 
     This API searches for the next free page chunk (@nr of pages), starting from @pfn_start.
     Bits of those free pages will be cleared after this function returns.
  -- void put_free_page_hints(unsigned long pfn_start, unsigned int nr);
     This API sets the @nr continuous bits starting from pfn_start.

Usage example with balloon:
1) host requests to start ballooning;
2) balloon driver get_free_page_hints and report the hints to host via report_vq;
3) host calls madvise(pfn_start, DONTNEED) for each reported chunk of free pages and put back pfn_start to ack_vq;
4) balloon driver receives pfn_start and calls put_free_page_hints(pfn_start) to have the related bits from the bitmap to be set, indicating that those free pages are ready to be allocated.

In above 2), get_free_page_hints clears the bits which indicates that those pages are not ready to be used by the guest yet. Why?
This is because 3) will unmap the underlying physical pages from EPT. Normally, when guest re-visits those pages, EPT violations and QEMU page faults will get a new host page to set up the related EPT entry. If guest uses that page before the page gets unmapped (i.e. right before step 3), no EPT violation happens and the guest will use the same physical page that will be unmapped and given to other host threads. So we need to make sure that the guest free page is usable only after step 3 finishes.

Back to arch_alloc_page(), it needs to check if the allocated pages have "1" set in the bitmap, if that's true, just clear the bits. Otherwise, it means step 2) above has happened and step 4) hasn't been reached. In this case, we can either have arch_alloc_page() busywaiting a bit till 4) is done for that page
Or better to have a balloon callback which prioritize 3) and 4) to make this page usable by the guest.

Using bitmaps to record free page hints don't need to take the free pages off the buddy list and return them later, which needs to go through the long allocation/free code path.

Best,
Wei
