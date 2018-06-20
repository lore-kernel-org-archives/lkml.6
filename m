Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EE2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071A620652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071A620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754845AbeFTJLy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:11:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:1519 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752308AbeFTJLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:11:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 02:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,246,1526367600"; 
   d="scan'208";a="60738562"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga003.jf.intel.com with ESMTP; 20 Jun 2018 02:11:47 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 20 Jun 2018 02:11:47 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 20 Jun 2018 02:11:47 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.223]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.87]) with mapi id 14.03.0319.002;
 Wed, 20 Jun 2018 17:11:40 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        "riel@redhat.com" <riel@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [virtio-dev] Re: [PATCH v33 2/4] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
Thread-Topic: [virtio-dev] Re: [PATCH v33 2/4] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
Thread-Index: AQHUBGb1uIuE7GdLXUGMzLE4+zixk6RgrO+AgACbr0D//5LxAIAAh+EwgANlzICAAQ0KgIAAj48AgAEfQ4D//6O1gIABpEBg
Date:   Wed, 20 Jun 2018 09:11:39 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396AE2EC@shsmsx102.ccr.corp.intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <1529037793-35521-3-git-send-email-wei.w.wang@intel.com>
 <20180615144000-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396A3D04@shsmsx102.ccr.corp.intel.com>
 <20180615171635-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396A5CB0@shsmsx102.ccr.corp.intel.com>
 <20180618051637-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396AA10C@shsmsx102.ccr.corp.intel.com>
 <20180619055449-mutt-send-email-mst@kernel.org> <5B28F371.9020308@intel.com>
 <20180619173256-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180619173256-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGYwOWMxNWUtNzNiYi00YTk3LTgzOWItNThkYzY3NjZlMmIwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZGFPNFhhY2tvWDNIV3FyK1hnVVJsb3E3TDdEVXFsSE1qZjNiMnIxaWhZcnJtQ2lYbnhmczZvRWVFZmNGSkJhdSJ9
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

On Tuesday, June 19, 2018 10:43 PM, Michael S. Tsirk wrote:
> On Tue, Jun 19, 2018 at 08:13:37PM +0800, Wei Wang wrote:
> > On 06/19/2018 11:05 AM, Michael S. Tsirkin wrote:
> > > On Tue, Jun 19, 2018 at 01:06:48AM +0000, Wang, Wei W wrote:
> > > > On Monday, June 18, 2018 10:29 AM, Michael S. Tsirkin wrote:
> > > > > On Sat, Jun 16, 2018 at 01:09:44AM +0000, Wang, Wei W wrote:
> > > > > > Not necessarily, I think. We have min(4m_page_blocks / 512,
> > > > > > 1024) above,
> > > > > so the maximum memory that can be reported is 2TB. For larger
> guests, e.g.
> > > > > 4TB, the optimization can still offer 2TB free memory (better
> > > > > than no optimization).
> > > > >
> > > > > Maybe it's better, maybe it isn't. It certainly muddies the waters even
> more.
> > > > > I'd rather we had a better plan. From that POV I like what
> > > > > Matthew Wilcox suggested for this which is to steal the necessary # of
> entries off the list.
> > > > Actually what Matthew suggested doesn't make a difference here.
> > > > That method always steal the first free page blocks, and sure can
> > > > be changed to take more. But all these can be achieved via kmalloc
> > > I'd do get_user_pages really. You don't want pages split, etc.
> 
> Oops sorry. I meant get_free_pages .

Yes, we can use __get_free_pages, and the max allocation is MAX_ORDER - 1, which can report up to 2TB free memory. 

"getting two pages isn't harder", do you mean passing two arrays (two allocations by get_free_pages(,MAX_ORDER -1)) to the mm API?

Please see if the following logic aligns to what you think:

        uint32_t i, max_hints, hints_per_page, hints_per_array, total_arrays;
        unsigned long *arrays;
 
     /*
         * Each array size is MAX_ORDER_NR_PAGES. If one array is not enough to
         * store all the hints, we need to allocate multiple arrays.
         * max_hints: the max number of 4MB free page blocks
         * hints_per_page: the number of hints each page can store
         * hints_per_array: the number of hints an array can store
         * total_arrays: the number of arrays we need
         */
        max_hints = totalram_pages / MAX_ORDER_NR_PAGES;
        hints_per_page = PAGE_SIZE / sizeof(__le64);
        hints_per_array = hints_per_page * MAX_ORDER_NR_PAGES;
        total_arrays = max_hints /  hints_per_array +
                       !!(max_hints % hints_per_array);
        arrays = kmalloc(total_arrays * sizeof(unsigned long), GFP_KERNEL);
        for (i = 0; i < total_arrays; i++) {
                arrays[i] = __get_free_pages(__GFP_ATOMIC | __GFP_NOMEMALLOC, MAX_ORDER - 1);

              if (!arrays[i])
                      goto out;
        }


- the mm API needs to be changed to support storing hints to multiple separated arrays offered by the caller.

Best,
Wei
