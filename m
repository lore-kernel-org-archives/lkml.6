Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C17ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4A021479
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="0BNZ+DZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4A021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeJRDeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:34:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36752 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbeJRDeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:34:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id x4so25998927otg.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5EPERwG7Rt2FJx6jlrxgsAT7CqRWmgc1U9eT9124S0=;
        b=0BNZ+DZdn3Sfab3DPt4S44cQaaXv5eKcABUuMKFJ44wtAAYHjQk0/kSOed0d3Y7SJk
         CxbLndA1ROAnvg4wOs1k1nBnCSzkQxHVXAnum4HYB62oOno1Mbtn50cR5E/ofIrvtU3L
         NE2d+PwcjFGH72doPWBL5R7V3kNeX1qZ/edFw003FNmFXN6lFKrdh7lVyKtHUgDVTq/Z
         D7FDdz9LBGDvaeq9afZK1cBkepzciBHBuLhzz37q199DfHigYWnriT/KoG/0wtRfx19k
         GRr5cTW1VgBn9NUkGA5cbOLGNQhHMrWPH9Jj5brUq5hBJ2PUoMPJCONcRr/TH8C9Uimf
         7Cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5EPERwG7Rt2FJx6jlrxgsAT7CqRWmgc1U9eT9124S0=;
        b=AOiL32WlfXEFUJJGdPgsDNo0+Cl8FA/17UgbQ4iXND8nOi5kIVPk85On2bkJ0wqebh
         hOtyiu230t7JyIRM63VjpGlgxQsdf7sOR7LyNr6A7g3AlR4sC4n6TDuqf0hiWxBohprq
         ISuypGapNhlH84wMn46b9Yr/I2cQEGRFPoe9o+G9Z4YDd0tddUXx+/VD/Nz0NBEEw4Wc
         r663OFYjM65NQeJt/DyOzY9NxZJLj/sbd50M2oKgljYOegwV1XT0aaBP1xqraF02lhQr
         CZiIbkbJlHYRhxmmi46ZIERdUq1DHeFE8T8Q10lv3NK3aSmTDrfxvZK5wm4fCtWecYZ5
         QKtA==
X-Gm-Message-State: ABuFfoi/oIBxcLLOodVLkLWihQbmdtPTj0wE4bgYm7NExWSSN6UaMcQ0
        cRShJe+Zrp1x0fqjsF3g/GaZKaIAWHYIW+s+nffTWw==
X-Google-Smtp-Source: ACcGV62RKyJ8NGBE9EPXNHGOAOLKjjxT1guOCHbWQAJZ35C7d99brfK5lzxjogk/k/+LLsQbeC3A6621K2Mu9K1CkWw=
X-Received: by 2002:a9d:4d0a:: with SMTP id n10mr16341195otf.95.1539805022185;
 Wed, 17 Oct 2018 12:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181013050021.11962-1-pagupta@redhat.com> <20181013050021.11962-3-pagupta@redhat.com>
 <CAPcyv4hroaVWA-HgjWCnr7QTd_y7U8sCvS+Up733ttnD6_cKzQ@mail.gmail.com> <431127218.21694133.1539803509205.JavaMail.zimbra@redhat.com>
In-Reply-To: <431127218.21694133.1539803509205.JavaMail.zimbra@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Oct 2018 12:36:51 -0700
Message-ID: <CAPcyv4joz_dPruJY4CYAxXSuMTD-NUoqm6kvGFrF19jt5dN=rg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtio-pmem: Add virtio pmem driver
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     Kevin Wolf <kwolf@redhat.com>, Jan Kara <jack@suse.cz>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        KVM list <kvm@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Qemu Developers <qemu-devel@nongnu.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, zwisler@kernel.org,
        lcapitulino@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        Nitesh Narayan Lal <nilal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:11 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>
>
> > On Fri, Oct 12, 2018 at 10:01 PM Pankaj Gupta <pagupta@redhat.com> wrote:
> > >
> > > This patch adds virtio-pmem driver for KVM guest.
> > >
> > > Guest reads the persistent memory range information from
> > > Qemu over VIRTIO and registers it on nvdimm_bus. It also
> > > creates a nd_region object with the persistent memory
> > > range information so that existing 'nvdimm/pmem' driver
> > > can reserve this into system memory map. This way
> > > 'virtio-pmem' driver uses existing functionality of pmem
> > > driver to register persistent memory compatible for DAX
> > > capable filesystems.
> > >
> > > This also provides function to perform guest flush over
> > > VIRTIO from 'pmem' driver when userspace performs flush
> > > on DAX memory range.
> >
> > Before we can move forward with this driver we need additional
> > filesystem enabling to detect when the backing device is fronting DAX
> > pmem or a paravirtualized page cache through virtio-pmem. Any
> > interface that requires fsync() and a round trip to the hypervisor to
> > flush host page cache is not DAX.
>
> I saw your proposal[1] for new mmap flag MAP_DIRECT. IIUIC mapping should fail for
> MAP_DIRECT if it requires explicit flush or buffer indirection. So, if we disable
> MAP_SYNC flag for virtio-pmem this should fail MAP_DIRECT as well? Otherwise
> without MAP_DIRECT, virtio-pmem should be defaulted to VIRTIO flush mechanism.

Right, although I wouldn't worry about MAP_DIRECT in the short term
since we're still discussing what the upstream interface. Regardless
of whether MAP_DIRECT is specified or not the virtio-flush mechanism
would always be used for virtio-pmem. I.e. there is no possibility to
get full DAX operation with virtio-pmem, only the page-cache bypass
sub-set.

Taking a look at where we could inject this check for filesystems it's
a bit awkward to do it in xfs_file_mmap() for example because we do
not have the backing device for the extents of the inode. So at a
minimum you would need to investigate calling xfs_inode_supports_dax()
from that path and teaching it about a new dax_device flag. I'm
thinking the dax_device flag should be called DAXDEV_BUFFERED to
indicate the presence of software buffering on a device that otherwise
supports bypassing the local page cache.
