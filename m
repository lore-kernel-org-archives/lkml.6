Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56E1FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7510A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="aYkRz2Xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7510A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbeG3RUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:20:35 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:57308 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726758AbeG3RUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1532965501;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=XuCvqIOWAi33mdO15WNBW+3Ma6zJpryb3uU6AW8XLPc=;
        b=aYkRz2XssjKJqdzFV+Imod/hQvRITTwVHXRdO59588gvZh7SLCzlEV4BCY8YYODa
        0gdXktvgRAH9RJmmpXgMMaTRCBD9E2l8nnD7CnmW7x/ik7lK9OI+lqGfIKSek3M1aux
        HXo3N8uNOozC3kCnvDkkT73QNF3hulJDFNNI6u14=
Date:   Mon, 30 Jul 2018 15:45:01 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 3/7] mm, slab: allocate off-slab freelists as reclaimable
 when appropriate
In-Reply-To: <20180718133620.6205-4-vbabka@suse.cz>
Message-ID: <01000164ebdd3863-bc2d38db-9d61-442f-a2e4-6196106d5ce4-000000@email.amazonses.com>
References: <20180718133620.6205-1-vbabka@suse.cz> <20180718133620.6205-4-vbabka@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.07.30-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Vlastimil Babka wrote:

> In SLAB, OFF_SLAB caches allocate management structures (currently just the
> freelist) from kmalloc caches when placement in a slab page together with
> objects would lead to suboptimal memory usage. For SLAB_RECLAIM_ACCOUNT caches,
> we can allocate the freelists from the newly introduced reclaimable kmalloc
> caches, because shrinking the OFF_SLAB cache will in general result to freeing
> of the freelists as well. This should improve accounting and anti-fragmentation
> a bit.

Acked-by: Christoph Lameter <cl@linux.com>

