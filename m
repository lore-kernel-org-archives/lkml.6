Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E81DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FE821741
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfAIKPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:15:55 -0500
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:58547 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729964AbfAIKPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:15:54 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 13537B89F9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 10:15:53 +0000 (GMT)
Received: (qmail 6696 invoked from network); 9 Jan 2019 10:15:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jan 2019 10:15:52 -0000
Date:   Wed, 9 Jan 2019 10:15:51 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] mm, compaction: remove set but not used variables
 'a, b, c'
Message-ID: <20190109101551.GR31517@techsingularity.net>
References: <1547002967-6127-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1547002967-6127-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 03:02:47AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> mm/compaction.c: In function 'compact_zone':
> mm/compaction.c:2063:22: warning:
>  variable 'c' set but not used [-Wunused-but-set-variable]
> mm/compaction.c:2063:19: warning:
>  variable 'b' set but not used [-Wunused-but-set-variable]
> mm/compaction.c:2063:16: warning:
>  variable 'a' set but not used [-Wunused-but-set-variable]
> 
> This never used since 94d5992baaa5 ("mm, compaction: finish pageblock
> scanning on contention")
> 

Dang. This is left-over debugging code that got accidentally merged
during a rebase.  Andrew, can you pick this up as a fix to the mmotm
patch mm-compaction-finish-pageblock-scanning-on-contention.patch please?

Thanks YueHaibing.

-- 
Mel Gorman
SUSE Labs
