Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7937DC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F91222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391065AbfBMJAP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:00:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:12298 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391010AbfBMJAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:00:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 01:00:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="138220584"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2019 01:00:07 -0800
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 13 Feb 2019 01:00:05 -0800
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 13 Feb 2019 01:00:04 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.207]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.162]) with mapi id 14.03.0415.000;
 Wed, 13 Feb 2019 17:00:02 +0800
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
Thread-Index: AQHUvMb57IQCd72gCkOm4okDUKYrcaXdemAg
Date:   Wed, 13 Feb 2019 09:00:02 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DF6B56A@shsmsx102.ccr.corp.intel.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
In-Reply-To: <20190204201854.2328-1-nitesh@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDM1MjAxYTMtMzVkYy00N2Y5LWJlZDctOTY0NmY4NTQ1MmNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieG1WVUdhSjV0aHk4Y21CTVFRQnY3R3J0dXFQckVadlBiSFkrSHMwYk16YjFCaVFQSk02WXM0XC9TQ0xtOFNrK3oifQ==
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

The free page is removed from the buddy list here. When will they get returned to the buddy list so that the guest threads can use them normally?

Best,
Wei
