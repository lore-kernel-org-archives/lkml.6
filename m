Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753434AbeEWAC7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:02:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34166 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753319AbeEWAC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:02:58 -0400
Date: Tue, 22 May 2018 17:02:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joonsoo Kim <js1304@gmail.com>
Cc: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
        <ville.syrjala@linux.intel.com>,
        Laura Abbott <labbott@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Tony Lindgren <tony@atomide.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Nazarewicz <mina86@mina86.com>,
        Minchan Kim <minchan@kernel.org>, Rik van Riel <riel@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert
 "mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE"
Message-Id: <20180522170257.ae5387d8717e81def908a53b@linux-foundation.org>
In-Reply-To: <20180521061631.GA26882@js1304-desktop>
References: <20180517125959.8095-1-ville.syrjala@linux.intel.com>
        <20180517132109.GU12670@dhcp22.suse.cz>
        <20180517133629.GH23723@intel.com>
        <20180517135832.GI23723@intel.com>
        <20180517164947.GV12670@dhcp22.suse.cz>
        <20180517170816.GW12670@dhcp22.suse.cz>
        <ccbe3eda-0880-1d59-2204-6bd4b317a4fe@redhat.com>
        <20180518040104.GA17433@js1304-desktop>
        <20180519144632.GE23723@intel.com>
        <20180521061631.GA26882@js1304-desktop>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2018 15:16:33 +0900 Joonsoo Kim <js1304@gmail.com> wrote:

> > (gdb) list *(dma_direct_alloc+0x22f)
> > 0x573fbf is in dma_direct_alloc (../lib/dma-direct.c:104).
> > 94	
> > 95		if (!page)
> > 96			return NULL;
> > 97		ret = page_address(page);
> > 98		if (force_dma_unencrypted()) {
> > 99			set_memory_decrypted((unsigned long)ret, 1 << page_order);
> > 100			*dma_handle = __phys_to_dma(dev, page_to_phys(page));
> > 101		} else {
> > 102			*dma_handle = phys_to_dma(dev, page_to_phys(page));
> > 103		}
> > 104		memset(ret, 0, size);
> > 105		return ret;
> > 106	}
> > 
> 
> Okay. I find the reason about this error.

It's getting rather late and we don't seem to have a final set of fixes
yet.  Perhaps the best approach here is to revert and try again for
4.18?
