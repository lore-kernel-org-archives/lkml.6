Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9EDC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBCD23BF7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBCD23BF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbeF1F3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:29:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:5752 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeF1F3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:29:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 22:29:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,282,1526367600"; 
   d="scan'208";a="60753269"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jun 2018 22:29:09 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 00/21] mm, THP, swap: Swapout/swapin THP in one piece
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180627215144.73e98b01099191da59bff28c@linux-foundation.org>
Date:   Thu, 28 Jun 2018 13:29:09 +0800
In-Reply-To: <20180627215144.73e98b01099191da59bff28c@linux-foundation.org>
        (Andrew Morton's message of "Wed, 27 Jun 2018 21:51:44 -0700")
Message-ID: <87r2krfpi2.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Fri, 22 Jun 2018 11:51:30 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
>
>> This is the final step of THP (Transparent Huge Page) swap
>> optimization.  After the first and second step, the splitting huge
>> page is delayed from almost the first step of swapout to after swapout
>> has been finished.  In this step, we avoid splitting THP for swapout
>> and swapout/swapin the THP in one piece.
>
> It's a tremendously good performance improvement.  It's also a
> tremendously large patchset :(
>
> And it depends upon your
> mm-swap-fix-race-between-swapoff-and-some-swap-operations.patch and
> mm-fix-race-between-swapoff-and-mincore.patch, the first of which has
> been floating about since February without adequate review.
>
> I'll give this patchset a spin in -mm to see what happens and will come
> back later to take a closer look.  But the best I can do at this time
> is to hopefully cc some possible reviewers :)

Thanks a lot for your help!  Hope more people can review it!

Best Regards,
Huang, Ying
