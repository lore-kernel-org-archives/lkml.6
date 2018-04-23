Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeDWFSm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:18:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:14688 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbeDWFSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:18:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,316,1520924400";
   d="scan'208";a="222540900"
Date: Mon, 23 Apr 2018 10:53:17 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Radhey Shyam Pandey <radheys@xilinx.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'RADHEYCS@GMAIL.COM'" <RADHEYCS@GMAIL.COM>
Subject: Re: [RFC 4/6] dmaengine: xilinx_dma: Freeup active list based on
 descriptor completion bit
Message-ID: <20180423052317.GZ6014@localhost>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-5-git-send-email-radheys@xilinx.com>
 <20180411091102.GZ6014@localhost>
 <BN6PR02MB3282D60BCF6A4B40BCC7A5B8C7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR02MB3282D60BCF6A4B40BCC7A5B8C7B70@BN6PR02MB3282.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 12:28:52PM +0000, Radhey Shyam Pandey wrote:

> > > +		if ((seg->hw.status & XILINX_DMA_COMP_MASK) ||
> > > +			(!chan->xdev->has_axieth_connected)) {
> > 
> > why the second case ? That is not expalined in log?
> In the current implementation, delay timeout is enabled only for
> has_axieth_connected usecase. For ethernet, we need real-time processing
> while still having benefit of interrupt coalescing. Example: In RX interrupt
> coalescing is set to 0x3.  Without delay timeout, DMA engine will wait for
> all frames and then issue completion interrupt. In ethernet usecase, this
> can introduce huge latencies. Delay timeout interrupt will trigger if delay
> time period has expired and we can notify dma client with received frames.
> 
> The second case is added to keep the previous implementation as is.(i.e when
> Delay timeout interrupt is not enabled - move all active desc to done list). 
> Sure I will add a description for it in the commit log.

That should help, it didn't seem to have anything to do with log or other
changes, please keep in mind again that changelog should describe the change
and help ppl review...

-- 
~Vinod
