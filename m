Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeCOMw1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:52:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53306 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeCOMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:52:26 -0400
Date: Thu, 15 Mar 2018 13:52:14 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] x86: use generic swiotlb_ops
In-Reply-To: <20180315115426.GB16210@lst.de>
Message-ID: <alpine.DEB.2.21.1803151351280.1525@nanos.tec.linutronix.de>
References: <20180314175213.20256-1-hch@lst.de> <20180314175213.20256-5-hch@lst.de> <alpine.DEB.2.21.1803150956300.1525@nanos.tec.linutronix.de> <20180315115426.GB16210@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Christoph Hellwig wrote:

> On Thu, Mar 15, 2018 at 10:00:57AM +0100, Thomas Gleixner wrote:
> > On Wed, 14 Mar 2018, Christoph Hellwig wrote:
> > >  #if defined(CONFIG_INTEL_IOMMU) || defined(CONFIG_AMD_IOMMU)
> > >  	void *iommu; /* hook for IOMMU specific extension */
> > >  #endif
> > > +#ifdef CONFIG_STA2X11
> > > +	bool is_sta2x11 : 1;
> > 
> > Huch? Please use either bool or an unsigned int based bitfield. A boolean
> > bitfield doesn't make sense.
> 
> bool bitfields are perfectly valid in C99 and used in various places in
> the kernel. But if you want either bool or an unsigned bitfield let me
> know and I'll switch it over.

Yeah, I know that the standard defines it, but that doesn't mean it makes
sense. At least not to me.

Thanks,

	tglx
