Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6776C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8092C20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="q9E9PKka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8092C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389605AbeG0VTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:19:22 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33945 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389340AbeG0VTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:19:22 -0400
Received: by mail-yb0-f195.google.com with SMTP id e9-v6so2468027ybq.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 12:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bh5p8Te6Lt0TIFIhpD8wpZ0lwUnLWLjDJguAumW93Pc=;
        b=q9E9PKka3zgNFJAOJOpjYpKcBVTWg/TsIHBw/uj0ragoKPG15Z7SgalwOrRRmdu6yn
         ZCaUtTs5UPbjU7TLKVPPoSOke29G1+WxRPqYEGz4gnrOsD62/ucS2uyOzn22pbtE5Om9
         620ZCu7115MmkyfYueg0oRCcqa28Yhg4v6O+r1Hr0JOCyanM9R/CKyP2zIIlXWsgfed0
         YWbCNLR9nOe4AHoJkiz4SdnQobfw2DXzGWpAemaJfLIZfs4xb84k3tLYioDNTy0QnV8X
         NsjvvQJttmHsQ/6giQqw6AC/g9PNJYuePxJH7SbridYqV39HmCt8dQ/FcDSscf7d74yK
         Pexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bh5p8Te6Lt0TIFIhpD8wpZ0lwUnLWLjDJguAumW93Pc=;
        b=jAYI41Z+OdFPsQrVJ0ghXvh9ZBLthnFBsebPh0qRAk98oMYYA/XGwtJOMXkJY5MTg4
         HjhECunr1uCz/Sb7Y8VBWoCwubEd23va6dJrJsBTeyXW0o3z2WV8oflhYtGqx/b4rcZo
         vcHAud6e+apIBU+b5Vqx3bAKA37A8U5vCgI6BPuP5MOY8rnL+Zi4/oDLa7fVUq0bEUW/
         fbJpSGFmIFqGD9FICEbSa8OQh/B5LjWfZdeyZK5spOdhW+a7jkxrYwTBAjjZJgKVs/QM
         liKe47JpJe6XQhYtykBsbiFlWkoIM5FaJITVBXSY7nOJA0fUMedJh9w4olIbvxvH5sww
         pmTQ==
X-Gm-Message-State: AOUpUlGeW5M1SYq1JMokMziH5cHodke9vgnnnBxMXhmTgHf5zjFQS5kJ
        cP4hCCAw4VLLBv3CWwVYd9jalg==
X-Google-Smtp-Source: AAOMgpfoR4i/psb4JEIQOqQZVswJbM6mk7jw5y6ayRrgAMrirPl8xkxbSi+iZO18BRqn+4CqDbYTyw==
X-Received: by 2002:a25:e406:: with SMTP id b6-v6mr4225899ybh.397.1532721357631;
        Fri, 27 Jul 2018 12:55:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:b944])
        by smtp.gmail.com with ESMTPSA id l204-v6sm1545362ywe.50.2018.07.27.12.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 12:55:56 -0700 (PDT)
Date:   Fri, 27 Jul 2018 15:58:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-patch-test@lists.linaro.org
Subject: Re: [PATCH] mm: terminate the reclaim early when direct reclaiming
Message-ID: <20180727195848.GA12399@cmpxchg.org>
References: <1532683165-19416-1-git-send-email-zhaoyang.huang@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532683165-19416-1-git-send-email-zhaoyang.huang@spreadtrum.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhaoyang,

On Fri, Jul 27, 2018 at 05:19:25PM +0800, Zhaoyang Huang wrote:
> This patch try to let the direct reclaim finish earlier than it used
> to be. The problem comes from We observing that the direct reclaim
> took a long time to finish when memcg is enabled. By debugging, we
> find that the reason is the softlimit is too low to meet the loop
> end criteria. So we add two barriers to judge if it has reclaimed
> enough memory as same criteria as it is in shrink_lruvec:
> 1. for each memcg softlimit reclaim.
> 2. before starting the global reclaim in shrink_zone.

Yes, the soft limit reclaim cycle is fairly aggressive and can
introduce quite some allocation latency into the system. Let me say
right up front, though, that we've spend hours in conference sessions
and phone calls trying to fix this and could never agree on
anything. You might have better luck trying cgroup2 which implements
memory.low in a more scalable manner. (Due to the default value of 0
instead of infinitity, it can use a smoother 2-pass reclaim cycle.)

On your patch specifically:

should_continue_reclaim() is for compacting higher order pages. It
assumes you have already made a full reclaim cycle and returns false
for most allocations without checking any sort of reclaim progress.

You may end up in a situation where soft limit reclaim finds nothing,
and you still abort without trying a regular reclaim cycle. That can
trigger the OOM killer while there is still plenty of reclaimable
memory in other groups.

So if you want to fix this, you'd have to look for a different
threshold for soft limit reclaim and. Maybe something like this
already works:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ee91e8cbeb5a..5b2388fa6bc4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2786,7 +2786,8 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 						&nr_soft_scanned);
 			sc->nr_reclaimed += nr_soft_reclaimed;
 			sc->nr_scanned += nr_soft_scanned;
-			/* need some check for avoid more shrink_zone() */
+			if (nr_soft_reclaimed)
+				continue;
 		}
 
 		/* See comment about same check for global reclaim above */
