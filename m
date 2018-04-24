Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932834AbeDXDvO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 23:51:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:6409 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932729AbeDXDvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 23:51:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,321,1520924400";
   d="scan'208";a="53133611"
Date: Tue, 24 Apr 2018 09:25:49 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Radhey Shyam Pandey <radheys@xilinx.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
Message-ID: <20180424035548.GA6014@localhost>
References: <20180411090854.GY6014@localhost>
 <BN6PR02MB32825FDF8601D8A310C2270BC7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
 <7f549d2e-fc96-8c7e-d839-edb86ae088a5@metafoo.de>
 <4ba085c7-5256-6c8a-5697-c0d5736a6e46@ti.com>
 <1fc10bec-5c2c-98f1-1d5b-b768dea844ed@metafoo.de>
 <78828d31-e4cd-5211-f1b6-8918ac38f599@ti.com>
 <e5a6c1ad-e263-7b9d-a5e2-744884c9d6de@metafoo.de>
 <a6ac9ca8-91b4-c7b1-0f0c-c04dd10048e2@ti.com>
 <d7432292-cedd-7d61-f219-8b63eb6c1d50@metafoo.de>
 <8c7a5ac8-0747-9dad-f6e5-74890b64f618@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c7a5ac8-0747-9dad-f6e5-74890b64f618@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 02:40:26PM +0300, Peter Ujfalusi wrote:
> 
> On 2018-04-18 16:06, Lars-Peter Clausen wrote:
> >> Hrm, true, but it is hardly the metadata use case. It is more like
> >> different DMA transfer type.
> > 
> > When I look at this with my astronaut architect view from high high up above
> > I do not see a difference between metadata and multi-planar data.
> 
> I tend to disagree.

and we will love to hear more :)

> > Both split the data that is sent to the peripheral into multiple
> > sub-streams, each carrying part of the data. I'm sure there are peripherals
> > that interleave data and metadata on the same data stream. Similar to how we
> > have left and right channel interleaved in a audio stream.
> 
> Slimbus, S/PDIF?
> 
> > What about metadata that is not contiguous and split into multiple segments.
> > How do you handle passing a sgl to the metadata interface? And then it
> > suddenly looks quite similar to the normal DMA descriptor interface.
> 
> Well, the metadata is for the descriptor. The descriptor describe the
> data transfer _and_ can convey additional information. Nothing is
> interleaved, the data and the descriptor are different things. It is
> more like TCP headers detached from the data (but pointing to it).
> 
> > But maybe that's just one abstraction level to high.
> 
> I understand your point, but at the end the metadata needs to end up in
> the descriptor which is describing the data that is going to be moved.
> 
> The descriptor is not sent as a separate DMA trasnfer, it is part of the
> DMA transfer, it is handled internally by the DMA.

That is bit confusing to me. I thought DMA was transparent to meta data and
would blindly collect and transfer along with the descriptor. So at high
level we are talking about two transfers (probably co-joined at hip and you
want to call one transfer) but why can't we visualize this as just a DMA
transfers. maybe you want to signal/attach to transfer, cant we do that with
additional flag DMA_METADATA etc..?

-- 
~Vinod
