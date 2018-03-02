Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947125AbeCBSAa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:00:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:9986 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1947104AbeCBSA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:00:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,413,1515484800";
   d="scan'208";a="35471163"
Subject: Re: [PATCH v4 3/3] mm/free_pcppages_bulk: prefetch buddy while not
 holding lock
To: Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Aaron Lu <aaron.lu@intel.com>
References: <20180301062845.26038-1-aaron.lu@intel.com>
 <20180301062845.26038-4-aaron.lu@intel.com>
 <20180301140044.GK15057@dhcp22.suse.cz>
 <cb158b3d-c992-6679-24df-b37d2bb170e0@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <2433e857-fea7-9af4-d124-538ad17de454@intel.com>
Date: Fri, 2 Mar 2018 10:00:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cb158b3d-c992-6679-24df-b37d2bb170e0@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2018 09:55 AM, Vlastimil Babka wrote:
> It's even stranger to me. Struct page is 64 bytes these days, exactly a
> a cache line. Unless that changed, Intel CPUs prefetched a "buddy" cache
> line (that forms an aligned 128 bytes block with the one we touch).

I believe that was a behavior that was specific to the Pentium 4
"Netburst" era.  I don't think the 128-byte line behavior exists on
modern Intel cpus.
