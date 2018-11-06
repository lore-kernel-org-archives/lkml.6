Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A401C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E532086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E532086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbeKFScz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:32:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:38088 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729160AbeKFScz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:32:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A26B5B100;
        Tue,  6 Nov 2018 09:08:39 +0000 (UTC)
Date:   Tue, 6 Nov 2018 10:08:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kuo-Hsin Yang <vovoy@chromium.org>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v5] mm, drm/i915: mark pinned shmemfs pages as unevictable
Message-ID: <20181106090839.GE27423@dhcp22.suse.cz>
References: <20181106090352.64114-1-vovoy@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106090352.64114-1-vovoy@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-11-18 17:03:51, Kuo-Hsin Yang wrote:
> The i915 driver uses shmemfs to allocate backing storage for gem
> objects. These shmemfs pages can be pinned (increased ref count) by
> shmem_read_mapping_page_gfp(). When a lot of pages are pinned, vmscan
> wastes a lot of time scanning these pinned pages. In some extreme case,
> all pages in the inactive anon lru are pinned, and only the inactive
> anon lru is scanned due to inactive_ratio, the system cannot swap and
> invokes the oom-killer. Mark these pinned pages as unevictable to speed
> up vmscan.
> 
> Export pagevec API check_move_unevictable_pages().
> 
> This patch was inspired by Chris Wilson's change [1].
> 
> [1]: https://patchwork.kernel.org/patch/9768741/
> 
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
> Acked-by: Michal Hocko <mhocko@suse.com>

please make it explicit that the ack applies to mm part as i've
mentioned when giving my ack to the previous version.

E.g.
Acked-by: Michal Hocko <mhocko@use.com> # mm part

because i am not familiar with the drm code to ack any changes there.
-- 
Michal Hocko
SUSE Labs
