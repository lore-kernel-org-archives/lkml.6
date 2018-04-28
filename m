Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeD1SzV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 14:55:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:48724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbeD1SzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 14:55:19 -0400
Date: Sat, 28 Apr 2018 18:55:14 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        mhocko@kernel.org, cl@linux.com, Jan Kara <jack@suse.cz>,
        matthew@wil.cx, x86@kernel.org, luto@amacapital.net,
        martin.petersen@oracle.com, jthumshirn@suse.de, broonie@kernel.org,
        Juergen Gross <jgross@suse.com>, linux-spi@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM TOPIC NOTES] x86 ZONE_DMA love
Message-ID: <20180428185514.GW27853@wotan.suse.de>
References: <20180426215406.GB27853@wotan.suse.de>
 <20180427053556.GB11339@infradead.org>
 <20180427161456.GD27853@wotan.suse.de>
 <20180428084221.GD31684@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428084221.GD31684@infradead.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 01:42:21AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 27, 2018 at 04:14:56PM +0000, Luis R. Rodriguez wrote:
> > Do we have a list of users for x86 with a small DMA mask?
> > Or, given that I'm not aware of a tool to be able to look
> > for this in an easy way, would it be good to find out which
> > x86 drivers do have a small mask?
> 
> Basically you'll have to grep for calls to dma_set_mask/
> dma_set_coherent_mask/dma_set_mask_and_coherent and their pci_*
> wrappers with masks smaller 32-bit.  Some use numeric values,
> some use DMA_BIT_MASK and various places uses local variables
> or struct members to parse them, so finding them will be a bit
> more work.  Nothing a coccinelle expert couldn't solve, though :)

Thing is unless we have a specific flag used consistently I don't believe we
can do this search with Coccinelle. ie, if we have local variables and based on
some series of variables things are set, this makes the grammatical expression
difficult to express.  So Cocinelle is not designed for this purpose.

But I believe smatch [0] is intended exactly for this sort of purpose, is that
right Dan? I gave a cursory look and I think it'd take me significant time to
get such hunt down.

[0] https://lwn.net/Articles/691882/

  Luis
