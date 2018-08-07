Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE7DC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F8E2156E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="FFP5LOI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F8E2156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbeHGXHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:07:41 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34058 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeHGXHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:07:41 -0400
Received: by mail-yb0-f195.google.com with SMTP id e9-v6so19436ybq.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LXH+vbeC7TbhvpvP3n3UvGgZpjPp7Z254g8MvRDR5Iw=;
        b=FFP5LOI6fetKoWrXFfWNDwmcigNuPrL334R+jw2010W+QMTf0iz7ez2yG0RQ052z5Q
         bcP8McHXlbhvhfSY7TUXVk2iSG5OAyd7IzH7O00V3+8yl0mcMGD6iQCGOUJ/Dwtah5AR
         k/Uy3EXgXthFT83wSnm8xM+UypsvdpAaEMXuGTVv7Pd6HiaxBlVLqP/udmiqS+OLm9lU
         SW/pSN1VGWsE3JJCEkWtyvkCLcRkRP1VA81oJzuN+KPrSRBEOYXOWyckDWtVuf6SXcF5
         yCFFIBzNm6NJGAHfvD3a/Mo6YG7iJXEf098pKKfbVgVAJkDUpp+FX0UQNHPA/yeb4BsI
         xW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LXH+vbeC7TbhvpvP3n3UvGgZpjPp7Z254g8MvRDR5Iw=;
        b=Hz20hMUBuH+n/grIsbPJ1mXGWwKyuQGx7fATh0NOZetXrXYirCKkKkZwIKjpfjj5lY
         JjY+r4drpa44MAeyIv0YbNkbrRgZh+xoao1vKnFh1i+SYkLzYAEfgfkcQqIgOjoVV5+K
         sbol/5Z2U9vWU8dD+rWnSwYIR4RxoXYQ47vfBTdlO5a26JDsKkL+62e3gDHCmcNBI3L1
         BXuMwkxx+WV+q7SlkgmEYezCPDxa4HuSsl20zZny6RhkUZC6tpQJicwgY+7a2rDXXnVV
         DrkLEsoEks4E2ehyJ2Po2PtAkdOTFWwSuUJ96nnxBQoe1jjG/R8kNkhow1aDy7XEDNWh
         iv8g==
X-Gm-Message-State: AOUpUlEyoDGJv6lSVlNISW9S7n0VYoHeCbz4Nt8q6K0uYnLm1z4PRN1l
        9J4p1zNIpadmgYvYtsVGp+c7kw==
X-Google-Smtp-Source: AA+uWPxuDfsKbqF2mUhHeZDcJF+1RzjrVCcxFXe+6J1tKnH/8+1N8XZRhf0n3OAIbyBVDXP3EhJmzg==
X-Received: by 2002:a25:b9ce:: with SMTP id y14-v6mr17800ybj.258.1533675086710;
        Tue, 07 Aug 2018 13:51:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:97c3])
        by smtp.gmail.com with ESMTPSA id f5-v6sm933239ywa.39.2018.08.07.13.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 13:51:25 -0700 (PDT)
Date:   Tue, 7 Aug 2018 16:54:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        Greg Thelen <gthelen@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg, oom: be careful about races when warning about no
 reclaimable task
Message-ID: <20180807205425.GA5928@cmpxchg.org>
References: <20180807072553.14941-1-mhocko@kernel.org>
 <20180807200247.GA4251@cmpxchg.org>
 <20180807202332.GK10003@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807202332.GK10003@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 10:23:32PM +0200, Michal Hocko wrote:
> On Tue 07-08-18 16:02:47, Johannes Weiner wrote:
> > On Tue, Aug 07, 2018 at 09:25:53AM +0200, Michal Hocko wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > "memcg, oom: move out_of_memory back to the charge path" has added a
> > > warning triggered when the oom killer cannot find any eligible task
> > > and so there is no way to reclaim the oom memcg under its hard limit.
> > > Further charges for such a memcg are forced and therefore the hard limit
> > > isolation is weakened.
> > > 
> > > The current warning is however too eager to trigger  even when we are not
> > > really hitting the above condition. Syzbot[1] and Greg Thelen have noticed
> > > that we can hit this condition even when there is still oom victim
> > > pending. E.g. the following race is possible:
> > > 
> > > memcg has two tasks taskA, taskB.
> > > 
> > > CPU1 (taskA)			CPU2			CPU3 (taskB)
> > > try_charge
> > >   mem_cgroup_out_of_memory				try_charge
> > >       select_bad_process(taskB)
> > >       oom_kill_process		oom_reap_task
> > > 				# No real memory reaped
> > >     				  			  mem_cgroup_out_of_memory
> > > 				# set taskB -> MMF_OOM_SKIP
> > >   # retry charge
> > >   mem_cgroup_out_of_memory
> > >     oom_lock						    oom_lock
> > >     select_bad_process(self)
> > >     oom_kill_process(self)
> > >     oom_unlock
> > > 							    # no eligible task
> > > 
> > > In fact syzbot test triggered this situation by placing multiple tasks
> > > into a memcg with hard limit set to 0. So no task really had any memory
> > > charged to the memcg
> > > 
> > > : Memory cgroup stats for /ile0: cache:0KB rss:0KB rss_huge:0KB shmem:0KB mapped_file:0KB dirty:0KB writeback:0KB swap:0KB inactive_anon:0KB active_anon:0KB inactive_file:0KB active_file:0KB unevictable:0KB
> > > : Tasks state (memory values in pages):
> > > : [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> > > : [   6569]     0  6562     9427        1    53248        0             0 syz-executor0
> > > : [   6576]     0  6576     9426        0    61440        0             0 syz-executor6
> > > : [   6578]     0  6578     9426      534    61440        0             0 syz-executor4
> > > : [   6579]     0  6579     9426        0    57344        0             0 syz-executor5
> > > : [   6582]     0  6582     9426        0    61440        0             0 syz-executor7
> > > : [   6584]     0  6584     9426        0    57344        0             0 syz-executor1
> > > 
> > > so in principle there is indeed nothing reclaimable in this memcg and
> > > this looks like a misconfiguration. On the other hand we can clearly
> > > kill all those tasks so it is a bit early to warn and scare users. Do
> > > that by checking that the current is the oom victim and bypass the
> > > warning then. The victim is allowed to force charge and terminate to
> > > release its temporal charge along the way.
> > > 
> > > [1] http://lkml.kernel.org/r/0000000000005e979605729c1564@google.com
> > > Fixes: "memcg, oom: move out_of_memory back to the charge path"
> > > Noticed-by: Greg Thelen <gthelen@google.com>
> > > Reported-and-tested-by: syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > ---
> > >  mm/memcontrol.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 4603ad75c9a9..1b6eed1bc404 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1703,7 +1703,8 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
> > >  		return OOM_ASYNC;
> > >  	}
> > >  
> > > -	if (mem_cgroup_out_of_memory(memcg, mask, order))
> > > +	if (mem_cgroup_out_of_memory(memcg, mask, order) ||
> > > +			tsk_is_oom_victim(current))
> > >  		return OOM_SUCCESS;
> > >  
> > >  	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
> > 
> > This is really ugly. :(
> > 
> > If that check is only there to suppress the warning when the limit is
> > 0, this should really be a separate branch around the warning, with a
> > fat comment that this is a ridiculous cornercase, and not look like it
> > is an essential part of the memcg reclaim/oom process.
> 
> I do not mind having it in a separate branch. Btw. this is not just about
> hard limit set to 0. Similar can happen anytime we are getting out of
> oom victims. The likelihood goes up with the remote memcg charging
> merged recently.

What the global OOM killer does in that situation is dump the header
anyway:

	/* Found nothing?!?! Either we hang forever, or we panic. */
	if (!oc->chosen && !is_sysrq_oom(oc) && !is_memcg_oom(oc)) {
		dump_header(oc, NULL);
		panic("Out of memory and no killable processes...\n");
	}

I think that would make sense here as well - without the panic,
obviously, but we can add our own pr_err() line following the header.

That gives us the exact memory situation of the cgroup and who is
trying to allocate and from what context, but in a format that is
known to users without claiming right away that it's a kernel issue.
