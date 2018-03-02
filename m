Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933781AbeCBVZj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:25:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:24470 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933763AbeCBVZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:25:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,413,1515484800";
   d="scan'208";a="22426863"
Subject: Re: [PATCH v4 2/3] mm/free_pcppages_bulk: do not hold lock when
 picking pages to free
To: Andrew Morton <akpm@linux-foundation.org>,
        Aaron Lu <aaron.lu@intel.com>
References: <20180301062845.26038-1-aaron.lu@intel.com>
 <20180301062845.26038-3-aaron.lu@intel.com>
 <20180301160105.aca958fac871998d582307d4@linux-foundation.org>
 <20180302080125.GB6356@intel.com>
 <20180302132332.2c69559686ff24d15ff44ae8@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>, Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <1110bcae-f4c5-68ff-77df-28934a21dd86@intel.com>
Date: Fri, 2 Mar 2018 13:25:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302132332.2c69559686ff24d15ff44ae8@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2018 01:23 PM, Andrew Morton wrote:
>> On my Sandybridge desktop, with will-it-scale/page_fault1/single process
>> run to emulate uniprocessor system, the score is(average of 3 runs):
>>
>> base(patch 1/3):	649710 
>> this patch:		653554 +0.6%
> Does that mean we got faster or slower?

Faster.  The unit of measurement here is iterations through a loop.
More iterations are better.
