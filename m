Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E59C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB5321874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfADJqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:46:12 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:45602 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727022AbfADJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:46:11 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 0358698713
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 09:46:10 +0000 (UTC)
Received: (qmail 20655 invoked from network); 4 Jan 2019 09:46:09 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Jan 2019 09:46:09 -0000
Date:   Fri, 4 Jan 2019 09:46:08 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Qian Cai <cai@lca.pw>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+93d94a001cfbce9e60e1@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux@dominikbrodowski.net,
        Michal Hocko <mhocko@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] mm, page_alloc: Do not wake kswapd with zone lock held
Message-ID: <20190104094608.GK31517@techsingularity.net>
References: <20190103225712.GJ31517@techsingularity.net>
 <51d17b9f-5c5b-5964-0943-668b679964cd@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <51d17b9f-5c5b-5964-0943-668b679964cd@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 09:18:38AM +0100, Vlastimil Babka wrote:
> On 1/3/19 11:57 PM, Mel Gorman wrote:
> > While zone->flag could have continued to be unused, there is potential
> > for moving some existing fields into the flags field instead. Particularly
> > read-mostly ones like zone->initialized and zone->contiguous.
> > 
> > Reported-by: syzbot+93d94a001cfbce9e60e1@syzkaller.appspotmail.com
> > Tested-by: Qian Cai <cai@lca.pw>
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an
> external fragmentation event occurs")
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 

Thanks

-- 
Mel Gorman
SUSE Labs
