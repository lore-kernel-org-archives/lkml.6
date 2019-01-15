Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C80C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD4720866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfAONuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:50:52 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:26770 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727927AbfAONuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:50:52 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 591593F47; Tue, 15 Jan 2019 14:50:50 +0100 (CET)
Date:   Tue, 15 Jan 2019 14:50:49 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Oscar Salvador <OSalvador@suse.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm, memory_hotplug: __offline_pages fix wrong locking
Message-ID: <20190115135042.qxu2yoy3zs2fs6cy@d104.suse.de>
References: <20190115120307.22768-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115120307.22768-1-mhocko@kernel.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 01:03:07PM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Jan has noticed that we do double unlock on some failure paths when
> offlining a page range. This is indeed the case when test_pages_in_a_zone
> respp. start_isolate_page_range fail. This was an omission when forward
> porting the debugging patch from an older kernel.
> 
> Fix the issue by dropping mem_hotplug_done from the failure condition
> and keeping the single unlock in the catch all failure path.
> 
> Reported-by: Jan Kara <jack@suse.cz>
> Fixes: 7960509329c2 ("mm, memory_hotplug: print reason for the offlining failure")
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Uhmf, I overlooked that while reviewing the patch.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks
-- 
Oscar Salvador
SUSE L3
