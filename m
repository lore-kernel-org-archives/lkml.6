Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23D4C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C2F217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfBFIwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:52:02 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:50992 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727150AbfBFIwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:52:02 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 3D2A31C27B6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Feb 2019 08:52:00 +0000 (GMT)
Received: (qmail 30294 invoked from network); 6 Feb 2019 08:52:00 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Feb 2019 08:52:00 -0000
Date:   Wed, 6 Feb 2019 08:51:58 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/compaction: no stuck in __reset_isolation_pfn()
Message-ID: <20190206085158.GM9565@techsingularity.net>
References: <20190206034732.75687-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190206034732.75687-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 10:47:32PM -0500, Qian Cai wrote:
> The commit c68d77911c23 ("mm, compaction: be selective about what
> pageblocks to clear skip hints") introduced an infinite loop if a pfn is
> invalid, it will loop again without increasing page counters. It can be
> reproduced by running LTP tests on an arm64 server.
> 

That was careless of me but the patch looks
correct. Andrew, this is a fix to the mmotm patch
mm-compaction-be-selective-about-what-pageblocks-to-clear-skip-hints.patch

Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks Qian!

-- 
Mel Gorman
SUSE Labs
