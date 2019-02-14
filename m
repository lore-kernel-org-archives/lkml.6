Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41971C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFD7222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394947AbfBNJIx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:08:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:29880 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387637AbfBNJIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:08:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 01:08:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="318932935"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga006.fm.intel.com with ESMTP; 14 Feb 2019 01:08:50 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 14 Feb 2019 01:08:50 -0800
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 14 Feb 2019 01:08:50 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.207]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.162]) with mapi id 14.03.0415.000;
 Thu, 14 Feb 2019 17:08:48 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     'David Hildenbrand' <david@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
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
Subject: RE: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Thread-Topic: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Thread-Index: AQHUvMb57IQCd72gCkOm4okDUKYrcaXb13cw//+SQwCAAKVowIAA64iAgAGk3nA=
Date:   Thu, 14 Feb 2019 09:08:48 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DF6F195@shsmsx102.ccr.corp.intel.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF68060@shsmsx102.ccr.corp.intel.com>
 <17adc05d-91f9-682b-d9a4-485e6a631422@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF6B52A@shsmsx102.ccr.corp.intel.com>
 <62b43699-f548-e0da-c944-80702ceb7202@redhat.com>
In-Reply-To: <62b43699-f548-e0da-c944-80702ceb7202@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGQxZDdiMDAtYzY0Yy00NjhhLWI4YzEtOGRjNGU5M2NhYzE0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiXC8xYW1KdUI0MEJPaHR3V3ZpaHNPTHljNWpZcThuTjdUS2N1ZVdxR2k2ZE5UeVRSOEgzZnlNcWRuYzlnQkdFMDAifQ==
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

On Wednesday, February 13, 2019 5:19 PM, David Hildenbrand wrote:
> If you have to resize/alloc/coordinate who will report, you will need locking.
> Especially, I doubt that there is an atomic xbitmap  (prove me wrong :) ).

Yes, we need change xbitmap to support it.

Just thought of another option, which would be better:
- xb_preload in prepare_alloc_pages to pre-allocate the bitmap memory;
- xb_set/clear the bit under the zone->lock, i.e. in rmqueue and free_one_page

So we use the existing zone->lock to guarantee that the xb ops
will not be concurrently called to race on the same bitmap.
And we don't add any new locks to generate new doubts.
Also, we can probably remove the arch_alloc/free_page part.

For the first step, we could optimize VIRTIO_BALLOON_F_FREE_PAGE_HINT for the live migration optimization:
- just replace alloc_pages(VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG,
                           VIRTIO_BALLOON_FREE_PAGE_ORDER)
with get_free_page_hints()

get_free_page_hints() was designed to clear the bit, and need put_free_page_hints() to set it later after host finishes madvise. For the live migration usage, as host doesn't free the backing host pages, so we can give get_free_page_hints a parameter option to not clear the bit for this usage. It will be simpler and faster.

I think get_free_page_hints() to read hints via bitmaps should be much faster than that allocation function, which takes around 15us to get a 4MB block. Another big bonus is that we don't need free_pages() to return all the pages back to buddy (it's a quite expensive operation too) when migration is done.

For the second step, we can improve ballooning, e.g. a new feature VIRTIO_BALLOON_F_ADVANCED_BALLOON to use the same get_free_page_hints() and another put_free_page_hints(), along with the virtio-balloon's report_vq and ack_vq to wait for the host's ack before making the free page ready.
(I think waiting for the host ack is the overhead that the guest has to suffer for enabling memory overcommitment, and even with this v8 patch series it also needs to do that. The optimization method was described yesterday)

> Yes, but as I mentioned this has other drawbacks. Relying on a a guest to free
> up memory when you really need it is not going to work. 

why not working? Host can ask at any time (including when not urgently need it) depending on the admin's configuration.

>It might work for
> some scenarios but should not dictate the design. It is a good start though if
> it makes things easier.
 > Enabling/disabling free page hintning by the hypervisor via some
> mechanism is on the other hand a good idea. "I have plenty of free space,
> don't worry".

Also guests are not treated identically, host can decide whom to offer the free pages first (offering free pages will cause the guest some performance drop).

Best,
Wei
