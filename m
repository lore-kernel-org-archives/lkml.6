Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CC5C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB3F218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="XwT43BZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfAYSdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:33:37 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34743 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfAYSdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:33:37 -0500
Received: by mail-yw1-f66.google.com with SMTP id g75so4303821ywb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 10:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B3t51C6OYPvt5o6UtPBjFZI7V6rBh757zuDBU08ALjY=;
        b=XwT43BZEal/mmUG0ScgCH1tj0dyst1bywR9tZ/PFS0Z2ALpe3xQDZ0XJWPs05jbamg
         kIt/UwpnbH9BNb5NI5M3dC46mW8lIYy5PoZ4s5gjUi9j38wmV91tn653wh9MIIkZgkEE
         /q506Lsupk/fJiqGl3PzIHX5jWETrO6amAIxuKR4DHH/DXxlwW2wNaZdDFtpS9xcgGdk
         uIK/jGv2ozgGTpXELHtw+xx6cShaElkosanG0Iye1SjQCfc2kn93KtCokMPWgGi1YiRJ
         p6bqbmlF+L6oho2wdA9oFJ+KMB3UCZvjvTFw/Uz/AyHoR10Z8S0fA5zuxrhFYO5NHtFJ
         ztVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B3t51C6OYPvt5o6UtPBjFZI7V6rBh757zuDBU08ALjY=;
        b=KyGqLcKOhyBVPZBetWlriCE7qC30Pk5Fh9icS7T5HRjOpR4rOiyjlwmgTMo5OyzsWX
         Lk1VmdiSOkwtIw7lueFxs+TkbW8H4br0qVhVwAjbPM9ftTWon6ZvNokDTdVc+bByiyIG
         mEv7tL6t6/LK5z4xFhWgQZPiwgOoolzmJ5kK5DCCctDcSmNCien7MPSdpTdxpxzNVh4l
         e9M/XV77E+fFRR1s/c0GNRhESc5jGZ0Ngd6kzrKZif0HNJlv1b1ZttUz1uKu7ZZg0x0+
         H8WSc5NqGW8OeV+HfLpiTF+4TYRnIo1ul0tA0GA5E4vvIlrkZWmkWb7rbxuHYaIx9xmZ
         ZMHg==
X-Gm-Message-State: AJcUukc6XHOFeAUVRhh3PnQ+1DMMUo05PqDuIzvMJB+vQwWS+k1LrngF
        B1+HQaADDdjz525hGPzDUMTf0Q==
X-Google-Smtp-Source: ALg8bN7iSxQEInhSs9aXnyY7dh0MKxgol4eZM2JRf6b7H26rID6Jn0WphY9GGB7GYe68uL2N+kr53Q==
X-Received: by 2002:a0d:cb11:: with SMTP id n17mr12283202ywd.357.1548441215556;
        Fri, 25 Jan 2019 10:33:35 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:144f])
        by smtp.gmail.com with ESMTPSA id 77sm11458979ywb.54.2019.01.25.10.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 10:33:34 -0800 (PST)
Date:   Fri, 25 Jan 2019 13:33:33 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: + memcg-do-not-report-racy-no-eligible-oom-tasks.patch added to
 -mm tree
Message-ID: <20190125183333.GA19686@cmpxchg.org>
References: <20190109190306.rATpT%akpm@linux-foundation.org>
 <20190125165624.GA17719@cmpxchg.org>
 <20190125172416.GB20411@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125172416.GB20411@dhcp22.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 06:24:16PM +0100, Michal Hocko wrote:
> On Fri 25-01-19 11:56:24, Johannes Weiner wrote:
> > On Wed, Jan 09, 2019 at 11:03:06AM -0800, akpm@linux-foundation.org wrote:
> > > 
> > > The patch titled
> > >      Subject: memcg: do not report racy no-eligible OOM tasks
> > > has been added to the -mm tree.  Its filename is
> > >      memcg-do-not-report-racy-no-eligible-oom-tasks.patch
> > > 
> > > This patch should soon appear at
> > >     http://ozlabs.org/~akpm/mmots/broken-out/memcg-do-not-report-racy-no-eligible-oom-tasks.patch
> > > and later at
> > >     http://ozlabs.org/~akpm/mmotm/broken-out/memcg-do-not-report-racy-no-eligible-oom-tasks.patch
> > > 
> > > Before you just go and hit "reply", please:
> > >    a) Consider who else should be cc'ed
> > >    b) Prefer to cc a suitable mailing list as well
> > >    c) Ideally: find the original patch on the mailing list and do a
> > >       reply-to-all to that, adding suitable additional cc's
> > > 
> > > *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
> > > 
> > > The -mm tree is included into linux-next and is updated
> > > there every 3-4 working days
> > > 
> > > ------------------------------------------------------
> > > From: Michal Hocko <mhocko@suse.com>
> > > Subject: memcg: do not report racy no-eligible OOM tasks
> > > 
> > > Tetsuo has reported [1] that a single process group memcg might easily
> > > swamp the log with no-eligible oom victim reports due to race between the
> > > memcg charge and oom_reaper
> > > 
> > > Thread 1		Thread2				oom_reaper
> > > try_charge		try_charge
> > > 			  mem_cgroup_out_of_memory
> > > 			    mutex_lock(oom_lock)
> > >   mem_cgroup_out_of_memory
> > >     mutex_lock(oom_lock)
> > > 			      out_of_memory
> > > 			        select_bad_process
> > > 				oom_kill_process(current)
> > > 				  wake_oom_reaper
> > > 							  oom_reap_task
> > > 							  MMF_OOM_SKIP->victim
> > > 			    mutex_unlock(oom_lock)
> > >     out_of_memory
> > >       select_bad_process # no task
> > > 
> > > If Thread1 didn't race it would bail out from try_charge and force the
> > > charge.  We can achieve the same by checking tsk_is_oom_victim inside the
> > > oom_lock and therefore close the race.
> > > 
> > > [1] http://lkml.kernel.org/r/bb2074c0-34fe-8c2c-1c7d-db71338f1e7f@i-love.sakura.ne.jp
> > > Link: http://lkml.kernel.org/r/20190107143802.16847-3-mhocko@kernel.org
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > 
> > It looks like this problem is happening in production systems:
> > 
> > https://www.spinics.net/lists/cgroups/msg21268.html
> > 
> > where the threads don't exit because they are trapped writing out the
> > oom messages to a slow console (running the reproducer from this email
> > thread triggers the oom flooding).
> > 
> > So IMO we should put this into 5.0 and add:
> 
> Please note that Tetsuo has found out that this will not work with the
> CLONE_VM without CLONE_SIGHAND cases and his http://lkml.kernel.org/r/01370f70-e1f6-ebe4-b95e-0df21a0bc15e@i-love.sakura.ne.jp
> should handle this case as well. I've only had objections to the
> changelog but other than that the patch looked sensible to me.

I see. Yeah that looks reasonable to me too.

Tetsuo, could you include the Fixes: and CC: stable in your patch?
