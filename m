Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbeBIOHd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:07:33 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:34801 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753265AbeBIOHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:07:31 -0500
Date: Fri, 9 Feb 2018 06:07:28 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Michal Hocko <mhocko@suse.com>, Laura Abbott <labbott@redhat.com>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression after commit 19809c2da28a ("mm, vmalloc: use
 __GFP_HIGHMEM implicitly")
Message-ID: <20180209140728.GC16666@bombadil.infradead.org>
References: <627DA40A-D0F6-41C1-BB5A-55830FBC9800@canonical.com>
 <20180208130649.GA15846@bombadil.infradead.org>
 <20180208232004.GA21027@bombadil.infradead.org>
 <20180209040814.GA23828@bombadil.infradead.org>
 <2DB8D5E5-0955-47CF-A142-09A5BA71DF70@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2DB8D5E5-0955-47CF-A142-09A5BA71DF70@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 05:12:56PM +0800, Kai Heng Feng wrote:
> Hi Matthew,
> 
> > On Feb 9, 2018, at 12:08 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > Alternatively, try this.  It passes in GFP_DMA32 from vmalloc_32,
> > regardless of whether ZONE_DMA32 exists or not.  If ZONE_DMA32 doesn't
> > exist, then we clear it in __vmalloc_area_node(), after using it to
> > determine that we shouldn't set __GFP_HIGHMEM.
> 
> IIUC, I need to let drivers/media drivers start using vmalloc_32() with your
> patch, right?

Hopefully those that need to already are.  Otherwise they're broken
on 64-bit.  I do see several places already using vmalloc_32().
