Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E09C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2608525FC9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2608525FC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965828AbeF0QyF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:54:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965107AbeF0QyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:54:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39481401CC41;
        Wed, 27 Jun 2018 16:54:03 +0000 (UTC)
Received: from redhat.com (ovpn-122-22.rdu2.redhat.com [10.10.122.22])
        by smtp.corp.redhat.com (Postfix) with SMTP id B06A111166E8;
        Wed, 27 Jun 2018 16:53:57 +0000 (UTC)
Date:   Wed, 27 Jun 2018 19:53:57 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        peterx@redhat.com
Subject: Re: [virtio-dev] Re: [PATCH v34 2/4] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
Message-ID: <20180627192306-mutt-send-email-mst@kernel.org>
References: <20180626002822-mutt-send-email-mst@kernel.org>
 <5B31B71B.6080709@intel.com>
 <20180626064338-mutt-send-email-mst@kernel.org>
 <5B323140.1000306@intel.com>
 <20180626163139-mutt-send-email-mst@kernel.org>
 <5B32E742.8080902@intel.com>
 <20180627053952-mutt-send-email-mst@kernel.org>
 <5B32FDB5.4040506@intel.com>
 <20180627065637-mutt-send-email-mst@kernel.org>
 <5B33205B.2040702@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B33205B.2040702@intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 27 Jun 2018 16:54:03 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 27 Jun 2018 16:54:03 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 01:27:55PM +0800, Wei Wang wrote:
> On 06/27/2018 11:58 AM, Michael S. Tsirkin wrote:
> > On Wed, Jun 27, 2018 at 11:00:05AM +0800, Wei Wang wrote:
> > > On 06/27/2018 10:41 AM, Michael S. Tsirkin wrote:
> > > > On Wed, Jun 27, 2018 at 09:24:18AM +0800, Wei Wang wrote:
> > > > > On 06/26/2018 09:34 PM, Michael S. Tsirkin wrote:
> > > > > > On Tue, Jun 26, 2018 at 08:27:44PM +0800, Wei Wang wrote:
> > > > > > > On 06/26/2018 11:56 AM, Michael S. Tsirkin wrote:
> > > > > > > > On Tue, Jun 26, 2018 at 11:46:35AM +0800, Wei Wang wrote:
> > > > > > > > 
> > > > > > > > > > > +	if (!arrays)
> > > > > > > > > > > +		return NULL;
> > > > > > > > > > > +
> > > > > > > > > > > +	for (i = 0; i < max_array_num; i++) {
> > > > > > > > > > So we are getting a ton of memory here just to free it up a bit later.
> > > > > > > > > > Why doesn't get_from_free_page_list get the pages from free list for us?
> > > > > > > > > > We could also avoid the 1st allocation then - just build a list
> > > > > > > > > > of these.
> > > > > > > > > That wouldn't be a good choice for us. If we check how the regular
> > > > > > > > > allocation works, there are many many things we need to consider when pages
> > > > > > > > > are allocated to users.
> > > > > > > > > For example, we need to take care of the nr_free
> > > > > > > > > counter, we need to check the watermark and perform the related actions.
> > > > > > > > > Also the folks working on arch_alloc_page to monitor page allocation
> > > > > > > > > activities would get a surprise..if page allocation is allowed to work in
> > > > > > > > > this way.
> > > > > > > > > 
> > > > > > > > mm/ code is well positioned to handle all this correctly.
> > > > > > > I'm afraid that would be a re-implementation of the alloc functions,
> > > > > > A re-factoring - you can share code. The main difference is locking.
> > > > > > 
> > > > > > > and
> > > > > > > that would be much more complex than what we have. I think your idea of
> > > > > > > passing a list of pages is better.
> > > > > > > 
> > > > > > > Best,
> > > > > > > Wei
> > > > > > How much memory is this allocating anyway?
> > > > > > 
> > > > > For every 2TB memory that the guest has, we allocate 4MB.
> > > > Hmm I guess I'm missing something, I don't see it:
> > > > 
> > > > 
> > > > +       max_entries = max_free_page_blocks(ARRAY_ALLOC_ORDER);
> > > > +       entries_per_page = PAGE_SIZE / sizeof(__le64);
> > > > +       entries_per_array = entries_per_page * (1 << ARRAY_ALLOC_ORDER);
> > > > +       max_array_num = max_entries / entries_per_array +
> > > > +                       !!(max_entries % entries_per_array);
> > > > 
> > > > Looks like you always allocate the max number?
> > > Yes. We allocated the max number and then free what's not used.
> > > For example, a 16TB guest, we allocate Four 4MB buffers and pass the 4
> > > buffers to get_from_free_page_list. If it uses 3, then the remaining 1 "4MB
> > > buffer" will end up being freed.
> > > 
> > > For today's guests, max_array_num is usually 1.
> > > 
> > > Best,
> > > Wei
> > I see, it's based on total ram pages. It's reasonable but might
> > get out of sync if memory is onlined quickly. So you want to
> > detect that there's more free memory than can fit and
> > retry the reporting.
> > 
> 
> 
> - AFAIK, memory hotplug isn't expected to happen during live migration
> today. Hypervisors (e.g. QEMU) explicitly forbid this.

That's a temporary limitation.

> - Allocating buffers based on total ram pages already gives some headroom
> for newly plugged memory if that could happen in any case. Also, we can
> think about why people plug in more memory - usually because the existing
> memory isn't enough, which implies that the free page list is very likely to
> be close to empty.

Or maybe because guest is expected to use more memory.

> - This method could be easily scaled if people really need more headroom for
> hot-plugged memory. For example, calculation based on "X * total_ram_pages",
> X could be a number passed from the hypervisor.

All this in place of a simple retry loop within guest?

> - This is an optimization feature, and reporting less free memory in that
> rare case doesn't hurt anything.

People working on memory hotplug can't be expected to worry about
balloon. And maintainers have other things to do than debug hard to
trigger failure reports from the field.

> 
> So I think it is good to start from a fundamental implementation, which
> doesn't confuse people, and complexities can be added when there is a real
> need in the future.
> 
> Best,
> Wei

The usefulness of the whole patchset hasn't been proven in the field yet.
The more uncovered corner cases there are, the higher the chance that
it will turn out not to be useful after all.

> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
