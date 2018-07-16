Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B6AECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6A620871
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6A620871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeGPNkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:40:12 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:47960 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728477AbeGPNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:40:12 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id AE2231DC006
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 13:12:47 +0000 (UTC)
Received: (qmail 27916 invoked from network); 16 Jul 2018 13:12:47 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.66])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 16 Jul 2018 13:12:47 -0000
Date:   Mon, 16 Jul 2018 14:12:46 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Rik van Riel <riel@surriel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "kirill.shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        kernel-team <kernel-team@fb.com>
Subject: Re: [PATCH] Revert "mm: always flush VMA ranges affected by
 zap_page_range"
Message-ID: <20180716131246.iacuzs5ntzktangk@techsingularity.net>
References: <1530896635.5350.25.camel@surriel.com>
 <20180706131019.51e3a5f0@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180706131019.51e3a5f0@imladris.surriel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 01:10:19PM -0400, Rik van Riel wrote:
> There was a bug in Linux that could cause madvise (and mprotect?)
> system calls to return to userspace without the TLB having been
> flushed for all the pages involved.
> 
> This could happen when multiple threads of a process made simultaneous
> madvise and/or mprotect calls.
> 
> This was noticed in the summer of 2017, at which time two solutions
> were created:
> 56236a59556c ("mm: refactor TLB gathering API")
> 99baac21e458 ("mm: fix MADV_[FREE|DONTNEED] TLB flush miss problem")
> and
> 4647706ebeee ("mm: always flush VMA ranges affected by zap_page_range")
> 
> We need only one of these solutions, and the former appears to be
> a little more efficient than the latter, so revert that one.
> 
> This reverts commit 4647706ebeee6e50f7b9f922b095f4ec94d581c3.
> ---
>  mm/memory.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
