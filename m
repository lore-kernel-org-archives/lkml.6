Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeCVSuu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:50:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeCVSut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:50:49 -0400
Date: Thu, 22 Mar 2018 11:50:46 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC PATCH v2 2/4] mm/__free_one_page: skip merge for order-0
 page unless compaction failed
Message-ID: <20180322185046.GK28468@bombadil.infradead.org>
References: <20180320085452.24641-1-aaron.lu@intel.com>
 <20180320085452.24641-3-aaron.lu@intel.com>
 <7b1988e9-7d50-d55e-7590-20426fb257af@suse.cz>
 <20180320141101.GB2033@intel.com>
 <20180322171503.GH28468@bombadil.infradead.org>
 <9ab5a6dd-c1b2-8da3-31f1-dd2237ea0f44@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ab5a6dd-c1b2-8da3-31f1-dd2237ea0f44@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 02:39:17PM -0400, Daniel Jordan wrote:
> Shouldn't the anon column also contain lru?

Probably; I didn't finish investigating everything.  There should probably
also be another column for swap pages.  Maybe some other users use a
significant amount of the struct page ... ?
