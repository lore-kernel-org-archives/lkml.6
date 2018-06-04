Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753538AbeFDOdz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:33:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:59991 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbeFDOdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:33:54 -0400
Message-ID: <acdfef1327f73f6ac67645d9f1a8e9204a0f22fb.camel@kernel.crashing.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au
Date: Mon, 04 Jun 2018 23:14:36 +1000
In-Reply-To: <20180604125530.GA16378@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
         <20180523213703-mutt-send-email-mst@kernel.org>
         <f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
         <20180604153558-mutt-send-email-mst@kernel.org>
         <20180604125530.GA16378@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-04 at 05:55 -0700, Christoph Hellwig wrote:
> On Mon, Jun 04, 2018 at 03:43:09PM +0300, Michael S. Tsirkin wrote:
> > Another is that given the basic functionality is in there, optimizations
> > can possibly wait until per-device quirks in DMA API are supported.
> 
> We have had per-device dma_ops for quite a while.

I've asked Ansuman to start with a patch that converts virtio to use
DMA ops always, along with an init quirk to hookup "direct" ops when
the IOMMU flag isn't set.

This will at least remove that horrid duplication of code path we have
in there.

Then we can just involve the arch in that init quirk so we can chose an
alternate set of ops when running a secure VM.

This is completely orthogonal to whether an iommu exist qemu side or
not, and should be entirely solved on the Linux side.

Cheers,
Ben.
