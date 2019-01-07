Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB802087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfAGXn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:43:56 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfAGXn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:43:56 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7684825A;
        Mon,  7 Jan 2019 23:43:55 +0000 (UTC)
Date:   Mon, 7 Jan 2019 15:43:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, ying.huang@intel.com,
        kirill@shutemov.name,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/25] Increase success rates and reduce latency of
 compaction v2
Message-Id: <20190107154354.b0805ca15767fc7ea9e37545@linux-foundation.org>
In-Reply-To: <20190104125011.16071-1-mgorman@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Jan 2019 12:49:46 +0000 Mel Gorman <mgorman@techsingularity.net> wrote:

> This series reduces scan rates and success rates of compaction, primarily
> by using the free lists to shorten scans, better controlling of skip
> information and whether multiple scanners can target the same block and
> capturing pageblocks before being stolen by parallel requests. The series
> is based on the 4.21/5.0 merge window after Andrew's tree had been merged.
> It's known to rebase cleanly.
> 
> ...
>
>  include/linux/compaction.h |    3 +-
>  include/linux/gfp.h        |    7 +-
>  include/linux/mmzone.h     |    2 +
>  include/linux/sched.h      |    4 +
>  kernel/sched/core.c        |    3 +
>  mm/compaction.c            | 1031 ++++++++++++++++++++++++++++++++++----------
>  mm/internal.h              |   23 +-
>  mm/migrate.c               |    2 +-
>  mm/page_alloc.c            |   70 ++-
>  9 files changed, 908 insertions(+), 237 deletions(-)

Boy that's a lot of material.  I just tossed it in there unread for
now.  Do you have any suggestions as to how we can move ahead with
getting this appropriately reviewed and tested?

