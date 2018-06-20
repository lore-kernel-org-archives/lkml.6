Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851C9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF6E20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF6E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754101AbeFTOOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:14:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754017AbeFTOOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:14:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE7054022414;
        Wed, 20 Jun 2018 14:14:43 +0000 (UTC)
Received: from redhat.com (ovpn-122-53.rdu2.redhat.com [10.10.122.53])
        by smtp.corp.redhat.com (Postfix) with SMTP id 24B9E2156880;
        Wed, 20 Jun 2018 14:14:42 +0000 (UTC)
Date:   Wed, 20 Jun 2018 17:14:41 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
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
Subject: Re: [virtio-dev] Re: [PATCH v33 2/4] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
Message-ID: <20180620171320-mutt-send-email-mst@kernel.org>
References: <20180615144000-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396A3D04@shsmsx102.ccr.corp.intel.com>
 <20180615171635-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396A5CB0@shsmsx102.ccr.corp.intel.com>
 <20180618051637-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396AA10C@shsmsx102.ccr.corp.intel.com>
 <20180619055449-mutt-send-email-mst@kernel.org>
 <5B28F371.9020308@intel.com>
 <20180619173256-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396AE2EC@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F7396AE2EC@shsmsx102.ccr.corp.intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 20 Jun 2018 14:14:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 20 Jun 2018 14:14:43 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 09:11:39AM +0000, Wang, Wei W wrote:
> On Tuesday, June 19, 2018 10:43 PM, Michael S. Tsirk wrote:
> > On Tue, Jun 19, 2018 at 08:13:37PM +0800, Wei Wang wrote:
> > > On 06/19/2018 11:05 AM, Michael S. Tsirkin wrote:
> > > > On Tue, Jun 19, 2018 at 01:06:48AM +0000, Wang, Wei W wrote:
> > > > > On Monday, June 18, 2018 10:29 AM, Michael S. Tsirkin wrote:
> > > > > > On Sat, Jun 16, 2018 at 01:09:44AM +0000, Wang, Wei W wrote:
> > > > > > > Not necessarily, I think. We have min(4m_page_blocks / 512,
> > > > > > > 1024) above,
> > > > > > so the maximum memory that can be reported is 2TB. For larger
> > guests, e.g.
> > > > > > 4TB, the optimization can still offer 2TB free memory (better
> > > > > > than no optimization).
> > > > > >
> > > > > > Maybe it's better, maybe it isn't. It certainly muddies the waters even
> > more.
> > > > > > I'd rather we had a better plan. From that POV I like what
> > > > > > Matthew Wilcox suggested for this which is to steal the necessary # of
> > entries off the list.
> > > > > Actually what Matthew suggested doesn't make a difference here.
> > > > > That method always steal the first free page blocks, and sure can
> > > > > be changed to take more. But all these can be achieved via kmalloc
> > > > I'd do get_user_pages really. You don't want pages split, etc.
> > 
> > Oops sorry. I meant get_free_pages .
> 
> Yes, we can use __get_free_pages, and the max allocation is MAX_ORDER - 1, which can report up to 2TB free memory. 
> 
> "getting two pages isn't harder", do you mean passing two arrays (two allocations by get_free_pages(,MAX_ORDER -1)) to the mm API?

Yes, or generally a list of pages with as many as needed.


> Please see if the following logic aligns to what you think:
> 
>         uint32_t i, max_hints, hints_per_page, hints_per_array, total_arrays;
>         unsigned long *arrays;
>  
>      /*
>          * Each array size is MAX_ORDER_NR_PAGES. If one array is not enough to
>          * store all the hints, we need to allocate multiple arrays.
>          * max_hints: the max number of 4MB free page blocks
>          * hints_per_page: the number of hints each page can store
>          * hints_per_array: the number of hints an array can store
>          * total_arrays: the number of arrays we need
>          */
>         max_hints = totalram_pages / MAX_ORDER_NR_PAGES;
>         hints_per_page = PAGE_SIZE / sizeof(__le64);
>         hints_per_array = hints_per_page * MAX_ORDER_NR_PAGES;
>         total_arrays = max_hints /  hints_per_array +
>                        !!(max_hints % hints_per_array);
>         arrays = kmalloc(total_arrays * sizeof(unsigned long), GFP_KERNEL);
>         for (i = 0; i < total_arrays; i++) {
>                 arrays[i] = __get_free_pages(__GFP_ATOMIC | __GFP_NOMEMALLOC, MAX_ORDER - 1);
> 
>               if (!arrays[i])
>                       goto out;
>         }
> 
> 
> - the mm API needs to be changed to support storing hints to multiple separated arrays offered by the caller.
> 
> Best,
> Wei

Yes. And add an API to just count entries so we know how many arrays to allocate.

-- 
MST
