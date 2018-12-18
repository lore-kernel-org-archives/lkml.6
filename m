Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6446BC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4DF217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeLRJX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:23:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:52104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726388AbeLRJX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:23:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9BBC8AD64;
        Tue, 18 Dec 2018 09:23:54 +0000 (UTC)
Subject: Re: [PATCH 07/14] mm, compaction: Always finish scanning of a full
 pageblock
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20181214230310.572-1-mgorman@techsingularity.net>
 <20181214230310.572-8-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <d0b6cb2d-a5cd-b415-e56f-2ad145f86cbc@suse.cz>
Date:   Tue, 18 Dec 2018 10:23:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181214230310.572-8-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/18 12:03 AM, Mel Gorman wrote:
> When compaction is finishing, it uses a flag to ensure the pageblock is
> complete.  However, in general it makes sense to always complete migration
> of a pageblock. Minimally, skip information is based on a pageblock and
> partially scanned pageblocks may incur more scanning in the future. The
> pageblock skip handling also becomes more strict later in the series and
> the hint is more useful if a complete pageblock was always scanned.
> 
> The impact here is potentially on latencies as more scanning is done
> but it's not a consistent win or loss as the scanning is not always a
> high percentage of the pageblock and sometimes it is offset by future
> reductions in scanning. Hence, the results are not presented this time as
> it's a mix of gains/losses without any clear pattern. However, completing
> scanning of the pageblock is important for later patches.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
