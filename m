Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933492AbeBMHHE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:07:04 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:42321 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933366AbeBMHHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:07:02 -0500
X-IronPort-AV: E=Sophos;i="5.46,506,1511823600";
   d="scan'208";a="313264434"
Date: Tue, 13 Feb 2018 08:07:00 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Vinod Koul <vinod.koul@intel.com>
cc: sean.wang@mediatek.com, dan.j.williams@intel.com, robh+dt@kernel.org,
        mark.rutland@arm.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH v4 5/5] dmaengine: mediatek: fix zalloc-simple.cocci
 warnings
In-Reply-To: <20180213064659.GD3666@localhost>
Message-ID: <alpine.DEB.2.20.1802130805550.2264@hadrien>
References: <cover.1518110810.git.sean.wang@mediatek.com> <ede5702c460a5b4b41186a8cff1e3c29b2380c08.1518110810.git.sean.wang@mediatek.com> <20180209125817.GB3666@localhost> <alpine.DEB.2.20.1802091555290.2944@hadrien> <20180213064659.GD3666@localhost>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Feb 2018, Vinod Koul wrote:

> On Fri, Feb 09, 2018 at 03:55:58PM +0100, Julia Lawall wrote:
> >
> > > > -	ring->txd = dma_alloc_coherent(hsdma2dev(hsdma),
> > > > -				       pc->sz_ring, &ring->tphys,
> > > > -				       GFP_ATOMIC | __GFP_ZERO);
> > > > +	ring->txd = dma_zalloc_coherent(hsdma2dev(hsdma), pc->sz_ring,
> > > > +					&ring->tphys, GFP_ATOMIC);
> > > >  	if (!ring->txd)
> > > >  		return -ENOMEM;
> > > >
> > > > -	memset(ring->txd, 0, pc->sz_ring);
> > >
> > > This should be folded back..
> >
> > Sorry, I'm not sure what you mean by "folded back".
>
> Since the original patch is also up for review in this series, it doesn't
> help much to add a change and fix on top in a series. The fix should be
> folded back into the original commit. IIRC Fengguang's bot also recommends
> so..

Sure, no problem.  Thanks.  (I thought you meant folding or unfolding of a
function definition).

julia
