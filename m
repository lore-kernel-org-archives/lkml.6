Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A90C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F4D24D6C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F4D24D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeGBFT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 01:19:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:62491 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753325AbeGBFTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 01:19:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2018 22:19:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,298,1526367600"; 
   d="scan'208";a="63709690"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga003.jf.intel.com with ESMTP; 01 Jul 2018 22:19:51 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 03/21] mm, THP, swap: Support PMD swap mapping in swap_duplicate()
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180622035151.6676-4-ying.huang@intel.com>
        <20180629060412.GI7646@bombadil.infradead.org>
Date:   Mon, 02 Jul 2018 13:19:51 +0800
In-Reply-To: <20180629060412.GI7646@bombadil.infradead.org> (Matthew Wilcox's
        message of "Thu, 28 Jun 2018 23:04:12 -0700")
Message-ID: <87k1qexlhk.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Jun 22, 2018 at 11:51:33AM +0800, Huang, Ying wrote:
>> +++ b/mm/swap_state.c
>> @@ -433,7 +433,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>>  		/*
>>  		 * Swap entry may have been freed since our caller observed it.
>>  		 */
>> -		err = swapcache_prepare(entry);
>> +		err = swapcache_prepare(entry, false);
>>  		if (err == -EEXIST) {
>>  			radix_tree_preload_end();
>>  			/*
>
> This commit should be just a textual conflict.

Yes.  Will check it.

Best Regards,
Huang, Ying
