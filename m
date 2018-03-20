Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750968AbeCTEmr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 00:42:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:46767 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750768AbeCTEmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 00:42:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,333,1517904000";
   d="scan'208";a="213112687"
Date: Tue, 20 Mar 2018 10:16:51 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.14 064/109] dmaengine: bcm2835-dma: Use
 vchan_terminate_vdesc() instead of desc_free
Message-ID: <20180320044651.GR15443@localhost>
References: <20180316152329.844663293@linuxfoundation.org>
 <20180316152333.462064800@linuxfoundation.org>
 <20180316184640.rxw6kwvqghsmdgcc@xps>
 <20180317143253.GI15443@localhost>
 <20180318102417.GA30164@kroah.com>
 <20180318104451.GA19721@kroah.com>
 <20180319030840.GJ15443@localhost>
 <e83c7924-7e52-eeab-adf2-ba2af159cfac@ti.com>
 <20180319072341.GL15443@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319072341.GL15443@localhost>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 12:53:41PM +0530, Vinod Koul wrote:
> On Mon, Mar 19, 2018 at 09:14:00AM +0200, Peter Ujfalusi wrote:
> > On 2018-03-19 05:08, Vinod Koul wrote:
> > > On Sun, Mar 18, 2018 at 11:44:51AM +0100, Greg Kroah-Hartman wrote:
> > >> On Sun, Mar 18, 2018 at 11:24:17AM +0100, Greg Kroah-Hartman wrote:

> > >> Let me just go drop this patch, and the two dmaengine patches that
> > >> relied on this one.  If you think these should be applied to the stable
> > >> trees, can you send me a series of working patches?
> > > 
> > > Okay let me grab your tree and cherry-pick all that is required and send
> > > you. Stay tuned...

As Peter pointed out we missed 6af149d2b142.
Here is the complete list of patches:

3ee7e42f3c9b dmaengine: k3dma: Use vchan_terminate_vdesc() instead of desc_free
397c59bce6cb dmaengine: img-mdc-dma: Use vchan_terminate_vdesc() instead of desc_free
47d71bc75d07 dmaengine: amba-pl08x: Use vchan_terminate_vdesc() instead of desc_free
f0dd52c85d61 dmaengine: dma-jz4780: Use vchan_terminate_vdesc() instead of desc_free
de92436ac40f dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_free
174334bcd9f8 dmaengine: edma: Use vchan_terminate_vdesc() instead of desc_free
b1faf0f564ff dmaengine: omap-dma: Use vchan_terminate_vdesc() instead of desc_free
1c7f072d94e8 dmaengine: virt-dma: Support for race free transfer termination
6af149d2b142 dmaengine: virt-dma: Add helper to free/reuse a descriptor

Last time we missed 6af149d2b142.

Also I have got a 4.9 break report which is also due to missing 6af149d2b142
and 1c7f072d94e8

Thanks
-- 
~Vinod
