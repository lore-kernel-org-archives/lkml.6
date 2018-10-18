Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36333ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C0321470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C0321470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeJRJnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:43:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbeJRJnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:43:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E195F34CB;
        Thu, 18 Oct 2018 01:44:49 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD5F97AB6D;
        Thu, 18 Oct 2018 01:44:49 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 74C674BB74;
        Thu, 18 Oct 2018 01:44:49 +0000 (UTC)
Date:   Wed, 17 Oct 2018 21:44:49 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Kevin Wolf <kwolf@redhat.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        KVM list <kvm@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        Christoph Hellwig <hch@infradead.org>,
        Igor Mammedov <imammedo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        lcapitulino@redhat.com
Message-ID: <130749719.21742520.1539827089099.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4joz_dPruJY4CYAxXSuMTD-NUoqm6kvGFrF19jt5dN=rg@mail.gmail.com>
References: <20181013050021.11962-1-pagupta@redhat.com> <20181013050021.11962-3-pagupta@redhat.com> <CAPcyv4hroaVWA-HgjWCnr7QTd_y7U8sCvS+Up733ttnD6_cKzQ@mail.gmail.com> <431127218.21694133.1539803509205.JavaMail.zimbra@redhat.com> <CAPcyv4joz_dPruJY4CYAxXSuMTD-NUoqm6kvGFrF19jt5dN=rg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.19, 10.4.195.12]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: ZINno7w24VIktMciA68WO/yMY5QIDw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 18 Oct 2018 01:44:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> >
> > > On Fri, Oct 12, 2018 at 10:01 PM Pankaj Gupta <pagupta@redhat.com> wrote:
> > > >
> > > > This patch adds virtio-pmem driver for KVM guest.
> > > >
> > > > Guest reads the persistent memory range information from
> > > > Qemu over VIRTIO and registers it on nvdimm_bus. It also
> > > > creates a nd_region object with the persistent memory
> > > > range information so that existing 'nvdimm/pmem' driver
> > > > can reserve this into system memory map. This way
> > > > 'virtio-pmem' driver uses existing functionality of pmem
> > > > driver to register persistent memory compatible for DAX
> > > > capable filesystems.
> > > >
> > > > This also provides function to perform guest flush over
> > > > VIRTIO from 'pmem' driver when userspace performs flush
> > > > on DAX memory range.
> > >
> > > Before we can move forward with this driver we need additional
> > > filesystem enabling to detect when the backing device is fronting DAX
> > > pmem or a paravirtualized page cache through virtio-pmem. Any
> > > interface that requires fsync() and a round trip to the hypervisor to
> > > flush host page cache is not DAX.
> >
> > I saw your proposal[1] for new mmap flag MAP_DIRECT. IIUIC mapping should
> > fail for
> > MAP_DIRECT if it requires explicit flush or buffer indirection. So, if we
> > disable
> > MAP_SYNC flag for virtio-pmem this should fail MAP_DIRECT as well?
> > Otherwise
> > without MAP_DIRECT, virtio-pmem should be defaulted to VIRTIO flush
> > mechanism.
> 
> Right, although I wouldn't worry about MAP_DIRECT in the short term
> since we're still discussing what the upstream interface. Regardless
> of whether MAP_DIRECT is specified or not the virtio-flush mechanism
> would always be used for virtio-pmem. I.e. there is no possibility to
> get full DAX operation with virtio-pmem, only the page-cache bypass
> sub-set.

Agree. I will also follow the thread.

> 
> Taking a look at where we could inject this check for filesystems it's
> a bit awkward to do it in xfs_file_mmap() for example because we do
> not have the backing device for the extents of the inode. So at a
> minimum you would need to investigate calling xfs_inode_supports_dax()
> from that path and teaching it about a new dax_device flag. I'm
> thinking the dax_device flag should be called DAXDEV_BUFFERED to
> indicate the presence of software buffering on a device that otherwise
> supports bypassing the local page cache.

Sure. Will investigate XFS code as suggested. 
Thanks for the detail directions towards the solution. Will try to come up 
with a solution.

Best regards,
Pankaj
  
