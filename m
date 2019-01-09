Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C93C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6EC20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfAISVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:21:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbfAISVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:21:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED156C057F37;
        Wed,  9 Jan 2019 18:21:29 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD34C60C45;
        Wed,  9 Jan 2019 18:21:29 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 8160C1808855;
        Wed,  9 Jan 2019 18:21:29 +0000 (UTC)
Date:   Wed, 9 Jan 2019 13:21:29 -0500 (EST)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Kevin Wolf <kwolf@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        jmoyer <jmoyer@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, lcapitulino@redhat.com,
        Igor Mammedov <imammedo@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Message-ID: <888499462.61280342.1547058089165.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4jsa709BVPAx_BT5eFrODf-PUPOZ4aguDsjZVawVXTVHQ@mail.gmail.com>
References: <20190109135024.14093-1-pagupta@redhat.com> <20190109135024.14093-4-pagupta@redhat.com> <CAPcyv4jsa709BVPAx_BT5eFrODf-PUPOZ4aguDsjZVawVXTVHQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] libnvdimm: add nd_region buffered dax_dev flag
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.35, 10.4.195.5]
Thread-Topic: libnvdimm: add nd_region buffered dax_dev flag
Thread-Index: rl0HzDCQAa/d1317fPlnfOMP97TLNA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 09 Jan 2019 18:21:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> > This patch adds 'DAXDEV_BUFFERED' flag which is set
> > for virtio pmem corresponding nd_region. This later
> > is used to disable MAP_SYNC functionality for ext4
> > & xfs filesystem.
> >
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/dax/super.c          | 17 +++++++++++++++++
> >  drivers/nvdimm/pmem.c        |  3 +++
> >  drivers/nvdimm/region_devs.c |  7 +++++++
> >  drivers/virtio/pmem.c        |  1 +
> >  include/linux/dax.h          |  9 +++++++++
> >  include/linux/libnvdimm.h    |  6 ++++++
> >  6 files changed, 43 insertions(+)
> >
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index 6e928f3..9128740 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -167,6 +167,8 @@ enum dax_device_flags {
> >         DAXDEV_ALIVE,
> >         /* gate whether dax_flush() calls the low level flush routine */
> >         DAXDEV_WRITE_CACHE,
> > +       /* flag to disable MAP_SYNC for virtio based host page cache flush
> > */
> > +       DAXDEV_BUFFERED,
> >  };
> >
> >  /**
> > @@ -335,6 +337,21 @@ bool dax_write_cache_enabled(struct dax_device
> > *dax_dev)
> >  }
> >  EXPORT_SYMBOL_GPL(dax_write_cache_enabled);
> >
> > +void virtio_pmem_host_cache(struct dax_device *dax_dev, bool wc)
> > +{
> > +       if (wc)
> > +               set_bit(DAXDEV_BUFFERED, &dax_dev->flags);
> > +       else
> > +               clear_bit(DAXDEV_BUFFERED, &dax_dev->flags);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_pmem_host_cache);
> 
> The "write_cache" property was structured this way because it can
> conceivably change at runtime. The MAP_SYNC capability should be
> static and never changed after init.

o.k. Will change.

> 
> > +bool virtio_pmem_host_cache_enabled(struct dax_device *dax_dev)
> > +{
> > +       return test_bit(DAXDEV_BUFFERED, &dax_dev->flags);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_pmem_host_cache_enabled);
> 
> Echoing Darrick and Jan this is should be a generic property of a
> dax_device and not specific to virtio. I don't like the "buffered"
> designation as that's not accurate. There may be hardware reasons why
> a dax_device is not synchronous, like a requirement to flush a
> write-pending queue or otherwise notify the device of new writes.

Agree.

> 
> I would just have a dax_synchronous() helper and a DAXDEV_SYNC flag. I
> would also modify alloc_dax() to take a flags argument so that the
> capability can be instantiated when the dax_device is allocated.

o.k. Will make the change.

Thanks,
Pankaj
> 
