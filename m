Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbeFDQeX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:34:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751233AbeFDQeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:34:21 -0400
Date: Mon, 4 Jun 2018 19:34:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180604193310-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
 <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
 <20180604153558-mutt-send-email-mst@kernel.org>
 <20180604125530.GA16378@infradead.org>
 <acdfef1327f73f6ac67645d9f1a8e9204a0f22fb.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acdfef1327f73f6ac67645d9f1a8e9204a0f22fb.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 11:14:36PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-06-04 at 05:55 -0700, Christoph Hellwig wrote:
> > On Mon, Jun 04, 2018 at 03:43:09PM +0300, Michael S. Tsirkin wrote:
> > > Another is that given the basic functionality is in there, optimizations
> > > can possibly wait until per-device quirks in DMA API are supported.
> > 
> > We have had per-device dma_ops for quite a while.
> 
> I've asked Ansuman to start with a patch that converts virtio to use
> DMA ops always, along with an init quirk to hookup "direct" ops when
> the IOMMU flag isn't set.
> 
> This will at least remove that horrid duplication of code path we have
> in there.
> 
> Then we can just involve the arch in that init quirk so we can chose an
> alternate set of ops when running a secure VM.
> 
> This is completely orthogonal to whether an iommu exist qemu side or
> not, and should be entirely solved on the Linux side.
> 
> Cheers,
> Ben.

Sounds good to me.

-- 
MST
