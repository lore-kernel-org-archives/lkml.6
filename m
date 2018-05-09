Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbeEIFF2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 01:05:28 -0400
Received: from verein.lst.de ([213.95.11.211]:40974 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbeEIFF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 01:05:27 -0400
Date: Wed, 9 May 2018 07:08:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoph Hellwig <hch@lst.de>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nipun Gupta <nipun.gupta@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-intel tree
Message-ID: <20180509050855.GA18469@lst.de>
References: <20180508110716.53dfef41@canb.auug.org.au> <20180509150255.38a5b1cc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509150255.38a5b1cc@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 03:02:55PM +1000, Stephen Rothwell wrote:
> > -	ret = of_dma_configure(dev, NULL);
> > +	ret = of_dma_configure(dev, NULL, true);
> >  	if (ret < 0) {
> >  		DRM_ERROR("Cannot setup DMA ops, ret %d", ret);
> >  		return ret;
> > -- 
> > 2.17.0
> 
> This is now needed for the merge of the drm and dma-mapping trees.

FYI, because the dma_configure change touch so much code and the author
wants to base more work on it it actually is in a guranteed stable
branch with just those patches:

    git://git.infradead.org/users/hch/dma-mapping.git dma-configure

Gitweb:

    http://git.infradead.org/users/hch/dma-mapping.git/shortlog/refs/heads/dma-configure
  
Feel free to pull this into the drm tree.
