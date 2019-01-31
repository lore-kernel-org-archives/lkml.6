Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25166C4151A
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83BA218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbfAaPpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:45:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:51586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbfAaPpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:45:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8B16B0B9;
        Thu, 31 Jan 2019 15:45:16 +0000 (UTC)
Subject: Re: [PATCH 21/22] mm, compaction: Be selective about what pageblocks
 to clear skip hints
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
 <20190118175136.31341-22-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <9318efb7-cf20-b87d-9038-27406925b161@suse.cz>
Date:   Thu, 31 Jan 2019 16:45:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118175136.31341-22-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 6:51 PM, Mel Gorman wrote:
> Pageblock hints are cleared when compaction restarts or kswapd makes enough
> progress that it can sleep but it's over-eager in that the bit is cleared
> for migration sources with no LRU pages and migration targets with no free
> pages. As pageblock skip hint flushes are relatively rare and out-of-band
> with respect to kswapd, this patch makes a few more expensive checks to
> see if it's appropriate to even clear the bit. Every pageblock that is
> not cleared will avoid 512 pages being scanned unnecessarily on x86-64.
> 
> The impact is variable with different workloads showing small differences
> in latency, success rates and scan rates. This is expected as clearing
> the hints is not that common but doing a small amount of work out-of-band
> to avoid a large amount of work in-band later is generally a good thing.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
