Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5EBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A27420652
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547031478;
	bh=5dMsOG2ooVJ/o0qyvBE9q6suGLBhEG63fYfJxNQNO2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=16hWjt5zK0O/dc1fhbVWSk6v7t9AAD+i/Q5oAdJzGQz/muJ9FfxIAuGerHZi3NRGF
	 ccH5plO0J8xYBW0DlhQJ4N1kReWoeyhs85tEc4G5SH6eUKcGjKCR6a1mCENzRIMj+w
	 apcsmSsyEezrmiHgppsQ04g2kPqQhIuH629o2P9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfAIK55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:57:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:51178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730049AbfAIK55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:57:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DAF98ABCB;
        Wed,  9 Jan 2019 10:57:55 +0000 (UTC)
Date:   Wed, 9 Jan 2019 11:57:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        arunks.linux@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v7] mm/page_alloc.c: memory_hotplug: free pages as higher
 order
Message-ID: <20190109105754.GR31793@dhcp22.suse.cz>
References: <1546578076-31716-1-git-send-email-arunks@codeaurora.org>
 <fb6465c99b3ada2c6af587a7eb00016d96d56f77.camel@linux.intel.com>
 <20190108181352.GI31793@dhcp22.suse.cz>
 <bfb543b6e343c21c3e263a110f234e08@codeaurora.org>
 <20190109073718.GM31793@dhcp22.suse.cz>
 <a053bd9b93e71baae042cdfc3432f945@codeaurora.org>
 <20190109084031.GN31793@dhcp22.suse.cz>
 <e005e71b125b9b8ddee668d1df9ad5ec@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e005e71b125b9b8ddee668d1df9ad5ec@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-01-19 16:12:48, Arun KS wrote:
[...]
> It will be called once per online of a section and the arg value is always
> set to 0 while entering online_pages_range.

You rare right that this will be the case in the most simple scenario.
But the point is that the callback can be called several times from
walk_system_ram_range and then your current code wouldn't work properly.
-- 
Michal Hocko
SUSE Labs
