Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeCONp7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:45:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53488 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbeCONp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:45:58 -0400
Date: Thu, 15 Mar 2018 14:45:47 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/14] x86: use dma-direct
In-Reply-To: <20180315134028.GA18074@lst.de>
Message-ID: <alpine.DEB.2.21.1803151445370.1525@nanos.tec.linutronix.de>
References: <20180314175213.20256-1-hch@lst.de> <20180314175213.20256-4-hch@lst.de> <alpine.DEB.2.21.1803150951540.1525@nanos.tec.linutronix.de> <20180315115348.GA16210@lst.de> <alpine.DEB.2.21.1803151352170.1525@nanos.tec.linutronix.de>
 <20180315134028.GA18074@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Christoph Hellwig wrote:
> On Thu, Mar 15, 2018 at 01:53:52PM +0100, Thomas Gleixner wrote:
> > > > > The generic dma-direct implementation is now functionally equivalent to
> > > > > the x86 nommu dma_map implementation, so switch over to using it.
> > > > 
> > > > Can you please convert the various drivers first and then remove the
> > > > unused code?
> > > 
> > > Which various drivers?
> > > 
> > > > > Note that the various iommu drivers are switched from x86_dma_supported
> > 
> > The various iommu drivers ....
> 
> It doesn't really make any sense to switch them separately.  They've
> inherited the ops from x86 which used to override it on an arch level,
> and we've now generalized the exactly same implementation to common code.

Fair enough.
