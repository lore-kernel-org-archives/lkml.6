Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A36C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215E62089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215E62089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbeGJF1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:27:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:43508 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbeGJF06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:26:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 22:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,332,1526367600"; 
   d="scan'208";a="53220959"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jul 2018 22:26:55 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Shaohua Li" <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 02/21] mm, THP, swap: Make CONFIG_THP_SWAP depends on CONFIG_SWAP
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180622035151.6676-3-ying.huang@intel.com>
        <4a56313b-1184-56d0-e269-30d5f2ffa706@linux.intel.com>
        <87wou3j3a9.fsf@yhuang-dev.intel.com>
        <66d12d39-5079-c836-744c-ee97ce40d553@linux.intel.com>
Date:   Tue, 10 Jul 2018 13:26:55 +0800
In-Reply-To: <66d12d39-5079-c836-744c-ee97ce40d553@linux.intel.com> (Dave
        Hansen's message of "Mon, 9 Jul 2018 18:59:14 -0700")
Message-ID: <87d0vvirts.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

> On 07/09/2018 06:19 PM, Huang, Ying wrote:
>> Dave Hansen <dave.hansen@linux.intel.com> writes:
>> 
>>>>  config THP_SWAP
>>>>  	def_bool y
>>>> -	depends on TRANSPARENT_HUGEPAGE && ARCH_WANTS_THP_SWAP
>>>> +	depends on TRANSPARENT_HUGEPAGE && ARCH_WANTS_THP_SWAP && SWAP
>>>>  	help
>>>
>>> This seems like a bug-fix.  Is there a reason this didn't cause problems
>>> up to now?
>> Yes.  The original code has some problem in theory, but not in practice
>> because all code enclosed by
>> 
>> #ifdef CONFIG_THP_SWAP
>> #endif
>> 
>> are in swapfile.c.  But that will be not true in this patchset.
>
> That's great info for the changelog.

Sure.  Will add it.

Best Regards,
Huang, Ying
