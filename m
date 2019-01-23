Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC298C41518
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73CC21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfAWKSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:18:44 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:36178 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727010AbfAWKSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:18:43 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 8A4634013; Wed, 23 Jan 2019 11:18:42 +0100 (CET)
Date:   Wed, 23 Jan 2019 11:18:42 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [PATCH] mm,memory_hotplug: Fix scan_movable_pages for gigantic
 hugepages
Message-ID: <20190123101838.qxsapn4dhcergs6t@d104.suse.de>
References: <20190122154407.18417-1-osalvador@suse.de>
 <20190123094717.GQ4087@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123094717.GQ4087@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 10:47:17AM +0100, Michal Hocko wrote:
> So this should be probably folded into the above patch as it is
> incomplete unless I am missing something.

Well, they are triggered from different paths.
The former error was triggered in:

removable_show
 is_mem_section_removable
  is_pageblock_removable_nolock
   has_unmovable_pages

while this one is triggered when actually doing the offline operation

__offline_pages
 scan_movable_pages
 
But I do agree that one without the other is not really useful, an incomplete.
The truth is that I did not spot this one when fixing [1] because I did not
really try to offline the memblock back then, so my fault.

While I agree that the best approach would be to fold this one into [1],
I am not sure if it is too late for that as it seems that [1] was already
released into mainline, and moreover to stable.

I guess I will have Andrew decide what is the best way to carry on here.

[1] https://patchwork.kernel.org/patch/10739963/

> 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> Other than that the change looks good to me.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
-- 
Oscar Salvador
SUSE L3
