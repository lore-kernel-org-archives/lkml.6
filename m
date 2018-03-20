Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752405AbeCTIh6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:37:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39070 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeCTIh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:37:56 -0400
X-Google-Smtp-Source: AG47ELuLszeCAWqKkl1gvSVxFSUWUHzCC4wU84dLDPuZvQvf4AI0ObBf3sH279Mg8MXlwJtLwZuwYA==
Date: Tue, 20 Mar 2018 09:37:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: use generic dma-direct and swiotlb code for x86 V3
Message-ID: <20180320083751.nrpt64dsmpqbhzc6@gmail.com>
References: <20180319103826.12853-1-hch@lst.de>
 <20180319152737.GK1110@char.us.oracle.com>
 <20180319152840.GA28041@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319152840.GA28041@lst.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Mar 19, 2018 at 11:27:37AM -0400, Konrad Rzeszutek Wilk wrote:
> > On Mon, Mar 19, 2018 at 11:38:12AM +0100, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series switches the x86 code the the dma-direct implementation
> > > for direct (non-iommu) dma and the generic swiotlb ops.  This includes
> > > getting rid of the special ops for the AMD memory encryption case and
> > > the STA2x11 SOC.  The generic implementations are based on the x86
> > > code, so they provide the same functionality.
> > 
> > I need to test this on my baremertal and Xen setup - and I lost your
> > git repo URL - any chance you mention point out to me so I can
> > kick of a build?
> 
> git://git.infradead.org/users/hch/misc.git dma-direct-x86

Btw., what's the upstreaming route for these patches?

While it's a multi-arch series it's all pretty x86-heavy as well so we can host it 
in -tip (in tip:core/dma or such), but feel free to handle it yourself as well:

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
