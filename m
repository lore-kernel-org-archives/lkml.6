Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeDJSKX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:10:23 -0400
Received: from verein.lst.de ([213.95.11.211]:45691 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751876AbeDJSKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:10:22 -0400
Date: Tue, 10 Apr 2018 20:10:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Takashi Iwai <tiwai@suse.de>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] swiotlb: Fix unexpected swiotlb_alloc_coherent()
        failures
Message-ID: <20180410181020.GA28565@lst.de>
References: <20180410170513.22834-1-tiwai@suse.de> <20180410170615.GA27589@lst.de> <s5hzi2bat25.wl-tiwai@suse.de> <40618b9c-786d-7f5f-3f5b-fc1dd8375846@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40618b9c-786d-7f5f-3f5b-fc1dd8375846@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 06:50:04PM +0100, Robin Murphy wrote:
> In the first one, the machine appears to have enough RAM that most of it is 
> beyond the device's 36-bit DMA mask, thus it's fairly likely for the 
> initial direct alloc to come back with something unsuitable.

But we should try a GFP_DMA32 allocation first, so this is a bit
surprising.
