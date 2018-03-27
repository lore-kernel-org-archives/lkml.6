Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeC0Odn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:33:43 -0400
Received: from verein.lst.de ([213.95.11.211]:40625 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750944AbeC0Odm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:33:42 -0400
Date: Tue, 27 Mar 2018 16:33:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: dma_zalloc_coherent broken with
        57bf5a8963f80fb3828c46c3e3a5b2dd790e09a7
Message-ID: <20180327143341.GA4968@lst.de>
References: <alpine.LFD.2.21.1803270944490.1726@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1803270944490.1726@schleppi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 10:12:54AM +0200, Sebastian Ott wrote:
> Hi,
> 
> commit 57bf5a8963f80fb3828c46c3e3a5b2dd790e09a7 broke usage of dma
> allocations specifying __GFP_ZERO by silently removing that flag.
> 
> Why should "the memory returned [] always be zeroed."?

Because that is what the current implementations do - we always zero
the memory returned from dma_map_ops.alloc().
