Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02BBC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C02D20852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C02D20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754599AbeGIGek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:34:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:30644 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbeGIGej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:34:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 23:34:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,329,1526367600"; 
   d="scan'208";a="69722838"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jul 2018 23:34:36 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dan Williams <dan.j.williams@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <n-horiguchi@ah.jp.nec.com>, <zi.yan@cs.rutgers.edu>,
        <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 02/21] mm, THP, swap: Make CONFIG_THP_SWAP depends on CONFIG_SWAP
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180622035151.6676-3-ying.huang@intel.com>
        <CAA9_cmc2b97TCRAKz-r4Zhb9mq_hsr41Xwe1zQkyhsLUc5LWPg@mail.gmail.com>
Date:   Mon, 09 Jul 2018 14:34:35 +0800
In-Reply-To: <CAA9_cmc2b97TCRAKz-r4Zhb9mq_hsr41Xwe1zQkyhsLUc5LWPg@mail.gmail.com>
        (Dan Williams's message of "Sat, 7 Jul 2018 14:12:48 -0700")
Message-ID: <877em4lxxg.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@gmail.com> writes:

> On Thu, Jun 21, 2018 at 8:55 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> From: Huang Ying <ying.huang@intel.com>
>>
>> It's unreasonable to optimize swapping for THP without basic swapping
>> support.  And this will cause build errors when THP_SWAP functions are
>> defined in swapfile.c and called elsewhere.
>>
>> The comments are fixed too to reflect the latest progress.
>
> Looks good to me:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks!

Best Regards,
Huang, Ying
