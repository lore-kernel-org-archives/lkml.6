Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F901C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA91C2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA91C2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbeGZJAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:00:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:45212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728378AbeGZJAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:00:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93754AECB;
        Thu, 26 Jul 2018 07:44:31 +0000 (UTC)
Date:   Thu, 26 Jul 2018 09:44:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "zhaowuyun@wingtech.com" <zhaowuyun@wingtech.com>
Cc:     akpm <akpm@linux-foundation.org>,
        mgorman <mgorman@techsingularity.net>,
        minchan <minchan@kernel.org>, vinmenon <vinmenon@codeaurora.org>,
        hannes <hannes@cmpxchg.org>,
        "hillf.zj" <hillf.zj@alibaba-inc.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Re: [PATCH] [PATCH] mm: disable preemption before swapcache_free
Message-ID: <20180726074430.GV28386@dhcp22.suse.cz>
References: <2018072514375722198958@wingtech.com>
 <20180725141643.6d9ba86a9698bc2580836618@linux-foundation.org>
 <2018072610214038358990@wingtech.com>
 <20180726060640.GQ28386@dhcp22.suse.cz>
 <20180726150323057627100@wingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726150323057627100@wingtech.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-07-18 15:03:23, zhaowuyun@wingtech.com wrote:
> >On Thu 26-07-18 10:21:40, zhaowuyun@wingtech.com wrote:
> >[...]
> >> Our project really needs a fix to this issue
> >
> >Could you be more specific why? My understanding is that RT tasks
> >usually have all the memory mlocked otherwise all the real time
> >expectations are gone already.
> >--
> >Michal Hocko
> >SUSE Labs 
> 
> 
> The RT thread is created by a process with normal priority, and the process was sleep, 
> then some task needs the RT thread to do something, so the process create this thread, and set it to RT policy.
> I think that is the reason why RT task would read the swap.

OK I see. This design is quite fragile though. You are opening ticket to
priority inversions and what not.

Anyway, the underlying swap issue should be fixed. Unfortunatelly I do
not have a great idea how to do that properly.

-- 
Michal Hocko
SUSE Labs
