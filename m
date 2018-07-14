Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834EEECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32635208CC
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32635208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeGNNQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 09:16:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:8313 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbeGNNQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 09:16:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2018 05:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,352,1526367600"; 
   d="scan'208";a="215988572"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga004.jf.intel.com with ESMTP; 14 Jul 2018 05:57:08 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Shaohua Li" <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 6/6] swap, put_swap_page: Share more between huge/normal code path
References: <20180712233636.20629-1-ying.huang@intel.com>
        <20180712233636.20629-7-ying.huang@intel.com>
        <20180713201858.zj43xzsnxqk3ozks@ca-dmjordan1.us.oracle.com>
Date:   Sat, 14 Jul 2018 20:57:07 +0800
In-Reply-To: <20180713201858.zj43xzsnxqk3ozks@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Fri, 13 Jul 2018 13:18:58 -0700")
Message-ID: <87a7qudlgc.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Fri, Jul 13, 2018 at 07:36:36AM +0800, Huang, Ying wrote:
>> From: Huang Ying <ying.huang@intel.com>
>> 
>> In this patch, locking related code is shared between huge/normal code
>> path in put_swap_page() to reduce code duplication.  And `free_entries
>> == 0` case is merged into more general `free_entries !=
>> SWAPFILE_CLUSTER` case, because the new locking method makes it easy.
>
> Might be a bit easier to think about the two changes if they were split up.

I just think the second change appears too trivial to be a separate patch.

> Agree with Dave's comment from patch 1, but otherwise the series looks ok to
> me.  I like the nr_swap_entries macro, that's clever.

Thanks!

Best Regards,
Huang, Ying
