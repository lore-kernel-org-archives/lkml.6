Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92709C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C402470F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C402470F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbeGDC77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:59:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:57263 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752916AbeGDC75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:59:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 19:59:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="72071482"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga002.jf.intel.com with ESMTP; 03 Jul 2018 19:59:55 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 00/21] mm, THP, swap: Swapout/swapin THP in one piece
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180627215144.73e98b01099191da59bff28c@linux-foundation.org>
        <20180704021153.GA3346@jagdpanzerIV>
        <878t6rvj12.fsf@yhuang-dev.intel.com>
        <20180704022734.GB3346@jagdpanzerIV>
Date:   Wed, 04 Jul 2018 10:59:55 +0800
In-Reply-To: <20180704022734.GB3346@jagdpanzerIV> (Sergey Senozhatsky's
        message of "Wed, 4 Jul 2018 11:27:34 +0900")
Message-ID: <87zhz7u2ms.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> writes:

> On (07/04/18 10:20), Huang, Ying wrote:
>> > On (06/27/18 21:51), Andrew Morton wrote:
>> >> On Fri, 22 Jun 2018 11:51:30 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
>> >> 
>> >> > This is the final step of THP (Transparent Huge Page) swap
>> >> > optimization.  After the first and second step, the splitting huge
>> >> > page is delayed from almost the first step of swapout to after swapout
>> >> > has been finished.  In this step, we avoid splitting THP for swapout
>> >> > and swapout/swapin the THP in one piece.
>> >> 
>> >> It's a tremendously good performance improvement.  It's also a
>> >> tremendously large patchset :(
>> >
>> > Will zswap gain a THP swap out/in support at some point?
>> >
>> >
>> > mm/zswap.c: static int zswap_frontswap_store(...)
>> > ...
>> > 	/* THP isn't supported */
>> > 	if (PageTransHuge(page)) {
>> > 		ret = -EINVAL;
>> > 		goto reject;
>> > 	}
>> 
>> That's not on my TODO list.  Do you have interest to work on this?
>
> I'd say I'm interested. Can't promise that I'll have enough spare time
> any time soon, tho.

Thanks!

> The numbers you posted do look fantastic indeed, embedded devices
> [which normally use zswap/zram quite heavily] _probably_ should see
> some performance improvement as well once zswap [and may be zram] can
> handle THP.

Yes.  I think so too.

Best Regards,
Huang, Ying
