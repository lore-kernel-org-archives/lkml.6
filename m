Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6898FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 01:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B34B21852
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 01:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbeLSBw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 20:52:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:18152 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727718AbeLSBw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 20:52:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 17:52:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="99798708"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.10])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2018 17:52:24 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -V9 10/21] swap: Swapin a THP in one piece
References: <20181214062754.13723-1-ying.huang@intel.com>
        <20181214062754.13723-11-ying.huang@intel.com>
        <20181218205638.zsoumw2ob6fxl6ub@ca-dmjordan1.us.oracle.com>
Date:   Wed, 19 Dec 2018 09:52:24 +0800
In-Reply-To: <20181218205638.zsoumw2ob6fxl6ub@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Tue, 18 Dec 2018 12:56:38 -0800")
Message-ID: <87ftuuqo4n.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Fri, Dec 14, 2018 at 02:27:43PM +0800, Huang Ying wrote:
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 1cec1eec340e..644cb5d6b056 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -33,6 +33,8 @@
>>  #include <linux/page_idle.h>
>>  #include <linux/shmem_fs.h>
>>  #include <linux/oom.h>
>> +#include <linux/delayacct.h>
>> +#include <linux/swap.h>
>
> swap.h is already #included in this file.

Will fix this, Thanks!

Best Regards,
Huang, Ying
