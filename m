Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087EBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC23420880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfBTIdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:33:49 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:56333 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbfBTIdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:33:49 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 79CB2432B; Wed, 20 Feb 2019 09:33:47 +0100 (CET)
Date:   Wed, 20 Feb 2019 09:33:47 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <OSalvador@suse.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org,
        Michal Hocko <mhocko@suse.com>, rong.a.chen@intel.com
Subject: Re: [RFC PATCH] mm, memory_hotplug: fix off-by-one in
 is_pageblock_removable
Message-ID: <20190220083343.g5hdxxmekqsjwo63@d104.suse.de>
References: <20190218052823.GH29177@shao2-debian>
 <20190218181544.14616-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218181544.14616-1-mhocko@kernel.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 07:15:44PM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>

> Fixes: efad4e475c31 ("mm, memory_hotplug: is_mem_section_removable do not pass the end of a zone")
> Reported-by: <rong.a.chen@intel.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Looks good to me.
I glanced quickly over the memhotplug code and I did not see any other place
that could trigger the same problem.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
