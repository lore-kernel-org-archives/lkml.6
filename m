Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230B2C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CA32502B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CA32502B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936808AbeF2Pzt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:55:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:54114 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935951AbeF2Pzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:55:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 08:55:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="241736123"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2018 08:55:07 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 29 Jun 2018 08:55:07 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 29 Jun 2018 08:55:06 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.223]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.82]) with mapi id 14.03.0319.002;
 Fri, 29 Jun 2018 23:55:05 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     David Hildenbrand <david@redhat.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        "riel@redhat.com" <riel@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: RE: [PATCH v34 0/4] Virtio-balloon: support free page reporting
Thread-Topic: [PATCH v34 0/4] Virtio-balloon: support free page reporting
Thread-Index: AQHUDIBXCAcukqzfc0qkpOxZ4k7fNaRzbrIAgAMxUID//7tdgIAAxSEA//+AAYCAALR78A==
Date:   Fri, 29 Jun 2018 15:55:04 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396C254C@shsmsx102.ccr.corp.intel.com>
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
 <c4dd0a13-91fb-c0f5-b41f-54421fdacca9@redhat.com>
 <5B35ACD5.4090800@intel.com>
 <4840cbb7-dd3f-7540-6a7c-13427de2f0d1@redhat.com>
 <5B36189E.5050204@intel.com>
 <34bb25eb-97f3-8a9f-8a13-401dfcf39a2c@redhat.com>
In-Reply-To: <34bb25eb-97f3-8a9f-8a13-401dfcf39a2c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjcyZjk1NmQtYWJiOC00ZGE3LTlmYzYtMDU2MjExNTViOTAzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVnk0NDRuQ3pxU1k4YVI1aW5QQ3NKMDRlUGVYUFIzTnpUQ1VoTmkwZEx3Q1RVelplSVBSeTl6N0t2XC9FMVY3R00ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 29, 2018 7:54 PM, David Hildenbrand wrote:
> On 29.06.2018 13:31, Wei Wang wrote:
> > On 06/29/2018 03:46 PM, David Hildenbrand wrote:
> >>>
> >>> I'm afraid it can't. For example, when we have a guest booted,
> >>> without too many memory activities. Assume the guest has 8GB free
> >>> memory. The arch_free_page there won't be able to capture the 8GB
> >>> free pages since there is no free() called. This results in no free pages
> reported to host.
> >>
> >> So, it takes some time from when the guest boots up until the balloon
> >> device was initialized and therefore page hinting can start. For that
> >> period, you won't get any arch_free_page()/page hinting callbacks, correct.
> >>
> >> However in the hypervisor, you can theoretically track which pages
> >> the guest actually touched ("dirty"), so you already know "which
> >> pages were never touched while booting up until virtio-balloon was
> >> brought to life". These, you can directly exclude from migration. No
> >> interface required.
> >>
> >> The remaining problem is pages that were touched ("allocated") by the
> >> guest during bootup but freed again, before virtio-balloon came up.
> >> One would have to measure how many pages these usually are, I would
> >> say it would not be that many (because recently freed pages are
> >> likely to be used again next for allocation). However, there are some
> >> pages not being reported.
> >>
> >> During the lifetime of the guest, this should not be a problem,
> >> eventually one of these pages would get allocated/freed again, so the
> >> problem "solves itself over time". You are looking into the special
> >> case of migrating the VM just after it has been started. But we have
> >> the exact same problem also for ordinary free page hinting, so we
> >> should rather solve that problem. It is not migration specific.
> >>
> >> If we are looking for an alternative to "problem solves itself",
> >> something like "if virtio-balloon comes up, it will report all free
> >> pages step by step using free page hinting, just like we would have
> >> from "arch_free_pages()"". This would be the same interface we are
> >> using for free page hinting - and it could even be made configurable in the
> guest.
> >>
> >> The current approach we are discussing internally for details about
> >> Nitesh's work ("how the magic inside arch_fee_pages() will work
> >> efficiently) would allow this as far as I can see just fine.
> >>
> >> There would be a tiny little window between virtio-balloon comes up
> >> and it has reported all free pages step by step, but that can be
> >> considered a very special corner case that I would argue is not worth
> >> it to be optimized.
> >>
> >> If I am missing something important here, sorry in advance :)
> >>
> >
> > Probably I didn't explain that well. Please see my re-try:
> >
> > That work is to monitor page allocation and free activities via
> > arch_alloc_pages and arch_free_pages. It has per-CPU lists to record
> > the pages that are freed to the mm free list, and the per-CPU lists
> > dump the recorded pages to a global list when any of them is full.
> > So its own per-CPU list will only be able to get free pages when there
> > is an mm free() function gets called. If we have 8GB free memory on
> > the mm free list, but no application uses them and thus no mm free()
> > calls are made. In that case, the arch_free_pages isn't called, and no
> > free pages added to the per-CPU list, but we have 8G free memory right
> > on the mm free list.
> > How would you guarantee the per-CPU lists have got all the free pages
> > that the mm free lists have?
> 
> As I said, if we have some mechanism that will scan the free pages (not
> arch_free_page() once and report hints using the same mechanism step by
> step (not your bulk interface)), this problem is solved. And as I said, this is
> not a migration specific problem, we have the same problem in the current
> page hinting RFC. These pages have to be reported.
> 
> >
> > - I'm also worried about the overhead of maintaining so many per-CPU
> > lists and the global list. For example, if we have applications
> > frequently allocate and free 4KB pages, and each per-CPU list needs to
> > implement the buddy algorithm to sort and merge neighbor pages. Today
> > a server can have more than 100 CPUs, then there will be more than 100
> > per-CPU lists which need to sync to a global list under a lock, I'm
> > not sure if this would scale well.
> 
> The overhead in the current RFC is definitely too high. But I consider this a
> problem to be solved before page hinting would go upstream. And we are
> discussing right now "if we have a reasonable page hinting implementation,
> why would we need your interface in addition".
> 
> >
> > - This seems to be a burden imposed on the core mm memory
> > allocation/free path. The whole overhead needs to be carried during
> > the whole system life cycle. What we actually expected is to just make
> > one call to get the free page hints only when live migration happens.
> 
> You're focusing too much on the actual implementation of the page hinting
> RFC right now. Assume for now that we would have
> - efficient page hinting without degrading other CPUs and little
>   overhead
> - a mechanism that solves reporting free pages once after we started up
>   virtio-balloon and actual free page hinting starts
> 
> Why would your suggestion still be applicable?
> 
> Your point for now is "I might not want to have page hinting enabled due to
> the overhead, but still a live migration speedup". If that overhead actually
> exists (we'll have to see) or there might be another reason to disable page
> hinting, then we have to decide if that specific setup is worth it merging your
> changes.

All the above "if we have", "assume we have" don't sound like a valid argument to me.
 
> I am not (and don't want to be) in the position to make any decisions here :) I
> just want to understand if two interfaces for free pages actually make sense.

I responded to Nitesh about the differences, you may want to check with him about this.
I would suggest you to send out your patches to LKML to get a discussion with the mm folks.

Best,
Wei

