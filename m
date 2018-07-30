Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A048160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCDC20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keGh3Bvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCDC20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbeG3Q3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:29:50 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37738 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeG3Q3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:29:50 -0400
Received: by mail-yb0-f195.google.com with SMTP id r3-v6so4845506ybo.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ojuTHsLBxhIuoIq1BfGa9lBzfoAegDCEyU9zfL2a5QE=;
        b=keGh3BvoN3BvvLHnfxl43/+LkM0heeZ4S+khckqdvMxDA+/qtQIucdg9sQy293U6+8
         B7/tWvTYws/1byLvGRRHEHsP04BHRlDWg7PXWuVMY67mE9DCSN3eg5/mzh6nQMTTGWn8
         bXjDQmqVTEfKXqvjPKolV6fDHsNC3kzrm2jrkzISUN4Dn9UhovXeHnwAvlW8z+d5wp8m
         vUZ79Sdm2JwgzZmyJTL+7y3dHcss63+eg8vJm89PuHcUiZcDjnNcRIQrjqClUlWOExqb
         Z4CrQdtbEps05FkRwDOHRjG400KU8cqy2KhzKbwyTmNFmYcpzKTlzIXEW/TDmUv+ea7r
         u2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ojuTHsLBxhIuoIq1BfGa9lBzfoAegDCEyU9zfL2a5QE=;
        b=uD7S8sPqiMSjRWA+G+dPifYhepNxbe/hd7m7lSIzFEPeBBGlfzTJ6jQ1EIcph0y7GY
         30zEuEwMHUZHgXti5/IjsyPZD9xASryciWSYeWXFfdPzBvVVGN3iYKy/cpi8H3yrPR9d
         WBPbpfmjB48544d2nT3ua3H83LaWGFfxhpFlI6H26Ywp51bF4buYUL0fo7ODCXw/mphs
         K8/XM9R2263uSGHLIBTwKXWk41MnYkzE3IC3aREJkAtX6Fqv5zi6Nj76mqd2EzorREg4
         2Un3llNOd7b0uxlTChXp6uUSVlE6I4NxluBztzu2vZg73dXJBdFGuDJ2sRsQCw+EVSdo
         41vA==
X-Gm-Message-State: AOUpUlGeRSee+bAK4d+LJ03WeVHC9XF+UTGKrSQkEFfKTcRc0Wp5Np8w
        oTwEWAGhKEi02s35rFPrNv4=
X-Google-Smtp-Source: AAOMgpcmA7BztyQSHt+t82eXMkGJcDrtMSeCHKtc/0a2P/3Gttxb+h2nPc6EuApalJUy1LHqiXJ8oQ==
X-Received: by 2002:a25:2803:: with SMTP id o3-v6mr9529676ybo.138.1532962468124;
        Mon, 30 Jul 2018 07:54:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:4bfe])
        by smtp.gmail.com with ESMTPSA id s63-v6sm841134ywd.63.2018.07.30.07.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 07:54:27 -0700 (PDT)
Date:   Mon, 30 Jul 2018 07:54:25 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at
 should_reclaim_retry().
Message-ID: <20180730145425.GE1206094@devbig004.ftw2.facebook.com>
References: <ca3da8b8-1bb5-c302-b190-fa6cebab58ca@I-love.SAKURA.ne.jp>
 <20180726113958.GE28386@dhcp22.suse.cz>
 <55c9da7f-e448-964a-5b50-47f89a24235b@i-love.sakura.ne.jp>
 <20180730093257.GG24267@dhcp22.suse.cz>
 <9158a23e-7793-7735-e35c-acd540ca59bf@i-love.sakura.ne.jp>
 <20180730144647.GX24267@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730144647.GX24267@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 30, 2018 at 04:46:47PM +0200, Michal Hocko wrote:
> On Mon 30-07-18 23:34:23, Tetsuo Handa wrote:
> > On 2018/07/30 18:32, Michal Hocko wrote:
> [...]
> > > This one is waiting for draining and we are in mm_percpu_wq WQ context
> > > which has its rescuer so no other activity can block us for ever. So
> > > this certainly shouldn't deadlock. It can be dead slow but well, this is
> > > what you will get when your shoot your system to death.
> > 
> > We need schedule_timeout_*() to allow such WQ_MEM_RECLAIM workqueues to wake up. (Tejun,
> > is my understanding correct?) Lack of schedule_timeout_*() does block WQ_MEM_RECLAIM
> > workqueues forever.
> 
> Hmm. This doesn't match my understanding of what WQ_MEM_RECLAIM actually
> guarantees. If you are right then the whole thing sounds quite fragile
> to me TBH.

Workqueue doesn't think the cpu is stalled as long as one of the
per-cpu kworkers is running.  The assumption is that kernel threads
are not supposed to be busy-looping indefinitely (and they really
shouldn't).  We can add timeout mechanism to workqueue so that it
kicks off other kworkers if one of them is in running state for too
long, but idk, if there's an indefinite busy loop condition in kernel
threads, we really should get rid of them and hung task watchdog is
pretty effective at finding these cases (at least with preemption
disabled).

Thanks.

-- 
tejun
