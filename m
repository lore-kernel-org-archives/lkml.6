Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E58C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE9B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE9B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755375AbeFRVdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:33:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49268 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754227AbeFRVdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:33:20 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 20C17D60;
        Mon, 18 Jun 2018 21:33:19 +0000 (UTC)
Date:   Mon, 18 Jun 2018 14:33:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-api@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 6/7] mm, proc: add KReclaimable to /proc/meminfo
Message-Id: <20180618143317.eb8f5d7b6c667784343ef902@linux-foundation.org>
In-Reply-To: <20180618091808.4419-7-vbabka@suse.cz>
References: <20180618091808.4419-1-vbabka@suse.cz>
        <20180618091808.4419-7-vbabka@suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 11:18:07 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> The vmstat NR_KERNEL_MISC_RECLAIMABLE counter is for kernel non-slab
> allocations that can be reclaimed via shrinker. In /proc/meminfo, we can show
> the sum of all reclaimable kernel allocations (including slab) as
> "KReclaimable". Add the same counter also to per-node meminfo under /sys

Why do you consider this useful enough to justify adding it to
/pro/meminfo?  How will people use it, what benefit will they see, etc?


Maybe you've undersold this whole patchset, but I'm struggling a bit to
see what the end-user benefits are.  What would be wrong with just
sticking with what we have now?
