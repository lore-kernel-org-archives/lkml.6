Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeCCRJs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 12:09:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeCCRJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 12:09:46 -0500
Date: Sat, 3 Mar 2018 09:09:44 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 02/61] radix tree: Use bottom four bits of gfp_t for
 flags
Message-ID: <20180303170944.GB29990@bombadil.infradead.org>
References: <20180219194556.6575-1-willy@infradead.org>
 <20180219194556.6575-3-willy@infradead.org>
 <1520081076.4280.18.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520081076.4280.18.camel@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 03, 2018 at 07:44:36AM -0500, Jeff Layton wrote:
> > -	return root->gfp_mask & __GFP_BITS_MASK;
> > +	return root->gfp_mask & ((__GFP_BITS_MASK >> 4) << 4);
> 
> Maybe phrase this in terms of a constant like GFP_ZONEMASK here? Would
> this be more appropriate?

Yeah, that's a better idea.  This is only interim; once all radix tree users
are converted to the xarray, we stop storing GFP flags here.  So I hadn't
put much thought into it, but I'll change it.
