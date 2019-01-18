Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C43C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D902086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfARJSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:18:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:41108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbfARJR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:17:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA2BFAEF0;
        Fri, 18 Jan 2019 09:17:58 +0000 (UTC)
Subject: Re: [PATCH 21/25] mm, compaction: Round-robin the order while
 searching the free lists for a target
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-22-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <71ad4f46-ca81-9a70-0b98-d1a1c46df47a@suse.cz>
Date:   Fri, 18 Jan 2019 10:17:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190104125011.16071-22-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 1:50 PM, Mel Gorman wrote:
> As compaction proceeds and creates high-order blocks, the free list
> search gets less efficient as the larger blocks are used as compaction
> targets. Eventually, the larger blocks will be behind the migration
> scanner for partially migrated pageblocks and the search fails. This
> patch round-robins what orders are searched so that larger blocks can be
> ignored and find smaller blocks that can be used as migration targets.
> 
> The overall impact was small on 1-socket but it avoids corner cases where
> the migration/free scanners meet prematurely or situations where many of
> the pageblocks encountered by the free scanner are almost full instead of
> being properly packed. Previous testing had indicated that without this
> patch there were occasional large spikes in the free scanner without this
> patch. By co-incidence, the 2-socket results showed a 54% reduction in
> the free scanner but will not be universally true.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
