Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44679C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C6820671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C6820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeGSJ2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:28:09 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:43879 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbeGSJ2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:28:09 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 46D4BB8758
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 09:46:02 +0100 (IST)
Received: (qmail 24007 invoked from network); 19 Jul 2018 08:46:02 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.66])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 19 Jul 2018 08:46:02 -0000
Date:   Thu, 19 Jul 2018 09:46:01 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 7/7] mm, slab: shorten kmalloc cache names for large
 sizes
Message-ID: <20180719084601.bl7zeq3ube7vulgq@techsingularity.net>
References: <20180718133620.6205-1-vbabka@suse.cz>
 <20180718133620.6205-8-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180718133620.6205-8-vbabka@suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 03:36:20PM +0200, Vlastimil Babka wrote:
> Kmalloc cache names can get quite long for large object sizes, when the sizes
> are expressed in bytes. Use 'k' and 'M' prefixes to make the names as short
> as possible e.g. in /proc/slabinfo. This works, as we mostly use power-of-two
> sizes, with exceptions only below 1k.
> 
> Example: 'kmalloc-4194304' becomes 'kmalloc-4M'
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

There is a slight chance this will break any external tooling that
calculates fragmentation stats for slab/slub if they are particularly
stupid parsers but other than that;

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
