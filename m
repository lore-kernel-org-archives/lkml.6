Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0D5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8EC2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfAOFhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:37:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfAOFhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:37:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18BB43DFCD;
        Tue, 15 Jan 2019 05:37:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7DB85D777;
        Tue, 15 Jan 2019 05:37:22 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 940AC3F953;
        Tue, 15 Jan 2019 05:37:22 +0000 (UTC)
Date:   Tue, 15 Jan 2019 00:37:22 -0500 (EST)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        KVM list <kvm@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>,
        Jason Wang <jasowang@redhat.com>,
        Qemu Developers <qemu-devel@nongnu.org>,
        virtualization@lists.linux-foundation.org,
        adilger kernel <adilger.kernel@dilger.ca>,
        Ross Zwisler <zwisler@kernel.org>,
        dave jiang <dave.jiang@intel.com>,
        darrick wong <darrick.wong@oracle.com>,
        vishal l verma <vishal.l.verma@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        jmoyer <jmoyer@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <208236727.64320322.1547530642536.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190114205031-mutt-send-email-mst@kernel.org>
References: <20190109144736.17452-1-pagupta@redhat.com> <20190113232902.GD4205@dastard> <20190113233820.GX6310@bombadil.infradead.org> <942065073.64011540.1547450140670.JavaMail.zimbra@redhat.com> <20190114212501.GG4205@dastard> <CAPcyv4jtPcLV-s0sKNHwwk0ug7GLBV6699dpm1h3r2xSo879dg@mail.gmail.com> <20190114222132.GH4205@dastard> <20190114205031-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] kvm "virtio pmem" device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.141, 10.4.195.25]
Thread-Topic: kvm "virtio pmem" device
Thread-Index: KDa63AjJmiORNbo34aRj26i0GjRiXg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 15 Jan 2019 05:37:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > > >
> > > > On Mon, Jan 14, 2019 at 02:15:40AM -0500, Pankaj Gupta wrote:
> > > > >
> > > > > > > Until you have images (and hence host page cache) shared between
> > > > > > > multiple guests. People will want to do this, because it means
> > > > > > > they
> > > > > > > only need a single set of pages in host memory for executable
> > > > > > > binaries rather than a set of pages per guest. Then you have
> > > > > > > multiple guests being able to detect residency of the same set of
> > > > > > > pages. If the guests can then, in any way, control eviction of
> > > > > > > the
> > > > > > > pages from the host cache, then we have a guest-to-guest
> > > > > > > information
> > > > > > > leak channel.
> > > > > >
> > > > > > I don't think we should ever be considering something that would
> > > > > > allow a
> > > > > > guest to evict page's from the host's pagecache [1].  The guest
> > > > > > should
> > > > > > be able to kick its own references to the host's pagecache out of
> > > > > > its
> > > > > > own pagecache, but not be able to influence whether the host or
> > > > > > another
> > > > > > guest has a read-only mapping cached.
> > > > > >
> > > > > > [1] Unless the guest is allowed to modify the host's file;
> > > > > > obviously
> > > > > > truncation, holepunching, etc are going to evict pages from the
> > > > > > host's
> > > > > > page cache.
> > > > >
> > > > > This is so correct. Guest does not not evict host page cache pages
> > > > > directly.
> > > >
> > > > They don't right now.
> > > >
> > > > But someone is going to end up asking for discard to work so that
> > > > the guest can free unused space in the underlying spares image (i.e.
> > > > make use of fstrim or mount -o discard) because they have workloads
> > > > that have bursts of space usage and they need to trim the image
> > > > files afterwards to keep their overall space usage under control.
> > > >
> > > > And then....
> > > 
> > > ...we reject / push back on that patch citing the above concern.
> > 
> > So at what point do we draw the line?
> > 
> > We're allowing writable DAX mappings, but as I've pointed out that
> > means we are going to be allowing  a potential information leak via
> > files with shared extents to be directly mapped and written to.
> > 
> > But we won't allow useful admin operations that allow better
> > management of host side storage space similar to how normal image
> > files are used by guests because it's an information leak vector?
> > 
> > That's splitting some really fine hairs there...
> 
> May I summarize that th security implications need to
> be documented?
> 
> In fact that would make a fine security implications section
> in the device specification.

This is a very good suggestion. 

I will document the security implications in details in device specification
with details of what all filesystem features we don't support and why.

Best regards,
Pankaj

> 
> 
> 
> 
> 
> > > > > In case of virtio-pmem & DAX, guest clears guest page cache
> > > > > exceptional entries.
> > > > > Its solely decision of host to take action on the host page cache
> > > > > pages.
> > > > >
> > > > > In case of virtio-pmem, guest does not modify host file directly i.e
> > > > > don't
> > > > > perform hole punch & truncation operation directly on host file.
> > > >
> > > > ... this will no longer be true, and the nuclear landmine in this
> > > > driver interface will have been armed....
> > > 
> > > I agree with the need to be careful when / if explicit cache control
> > > is added, but that's not the case today.
> > 
> > "if"?
> > 
> > I expect it to be "when", not if. Expect the worst, plan for it now.
> > 
> > Cheers,
> > 
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
> 
> 
