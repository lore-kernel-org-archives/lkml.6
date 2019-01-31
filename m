Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A972AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7497D218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548946586;
	bh=bzMTTgRyGCbRDBHIrbsuD4dgSoDd5YrD4DzXeA71LWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oA83GWiht9S/0UKY74z/j2DThZkP4Q/bGxiEuk2uldO43cjBTlSMwxajIVYSIughQ
	 HV7U0wWzedyTNDCWEhNDOVI3BZxWWeKqkx5TNvyc4UFacbnThfPXY2SrABi5MtilJz
	 EeMi1VrcPjLI1nfG1d0iiApTgd9cKlIfauuL07XY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbfAaO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:56:24 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45931 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfAaO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:56:24 -0500
Received: by mail-yb1-f193.google.com with SMTP id t11so1375897ybi.12;
        Thu, 31 Jan 2019 06:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wqkae5/SZUXV0XpHwrdhyDmdmZuXObNbFvC+52gNI10=;
        b=T+tfKU9bLG/Ze8iEPeVXdRWijWD8iEUGg5hxZ7uE66Rm49Duni5enxE3uJgCj0ClBE
         8OHx1m0Y2s0wwyJHaSsN76bNKEbEG0RWW2e/Ft212//gGXoVP+sO1/qflAXTBx+FwUiS
         icEdvmjlo+NbU2KspZtxwijuTJEK40AKekvdtptVupBJ5hN23RQdGH9bPORrBFsiB59S
         eA+FsM2mQKfMnbjlR3cIWbUHKOfV0+fGr8LQPdnG3qcRwTzAK8lcHMa37eXx9CWGuAn5
         MvTn09SulsASG7+Bii1yDxsMlik+rv0QvEZYmbMwOyPxR9gviKae5xbVAcFtBvh+Xo0c
         1HiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wqkae5/SZUXV0XpHwrdhyDmdmZuXObNbFvC+52gNI10=;
        b=jClTGT5A/4PZLru3cFAGzfC51/g/84da9f9agQXCk5uqbaYEAnj/GBIFJ6I9tNykB5
         K+D298pqATYxW/cJUITSEPh042bDD6bzN/ktkxqb6CJ1DhFctYW5zA94m/KLCUZBBm02
         /7eV+rN2fXTvrb7iOamrPx3GE01YMKnXDJ9xUrlyD6DjCwMyT4B+GyBefbI758WlRNJ4
         dmxRRlR8ggX91PhdWs+m41amZTBmZh1oVXZvXwWhiCJuOwpgSKXyNlPp2pqPFf+q/B3i
         rrNhnjvO9+8RCaRM7Yc/Vaaa2HuS5LSVmGLp0j3MOZt2gw0DccyQijvKfT/YKDS8EH2g
         i+2A==
X-Gm-Message-State: AHQUAubgTzFlHoGd9QZfHjLykTtZ1Nq6sSe3f0Mqr/a1mZylhgbQw68C
        TXlFZZvj8AYpyBA69gB9sq4=
X-Google-Smtp-Source: AHgI3IbN//PVesytuT4ildCDrP3BYEXd6batBNJ0s56TIfUQfrflfE1eViTQwdfJVS6+wmyfKc03VA==
X-Received: by 2002:a25:3503:: with SMTP id c3mr6148458yba.321.1548946582781;
        Thu, 31 Jan 2019 06:56:22 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:b53a])
        by smtp.gmail.com with ESMTPSA id r188sm1666201ywb.30.2019.01.31.06.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 06:56:21 -0800 (PST)
Date:   Thu, 31 Jan 2019 06:56:20 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Herton Krzesinski <hkrzesin@redhat.com>,
        Jan Stancek <jstancek@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/pids: turn cgroup_subsys->free() into
 cgroup_subsys->release() to fix the accounting
Message-ID: <20190131145620.GC50184@devbig004.ftw2.facebook.com>
References: <20190128160013.GA21219@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128160013.GA21219@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:00:13PM +0100, Oleg Nesterov wrote:
> The only user of cgroup_subsys->free() callback is pids_cgrp_subsys which
> needs pids_free() to uncharge the pid.
> 
> However, ->free() is called from __put_task_struct()->cgroup_free() and this
> is too late. Even the trivial program which does
> 
> 	for (;;) {
> 		int pid = fork();
> 		assert(pid >= 0);
> 		if (pid)
> 			wait(NULL);
> 		else
> 			exit(0);
> 	}
> 
> can run out of limits because release_task()->call_rcu(delayed_put_task_struct)
> implies an RCU gp after the task/pid goes away and before the final put().
> 
> Test-case:
> 
> 	mkdir -p /tmp/CG
> 	mount -t cgroup2 none /tmp/CG
> 	echo '+pids' > /tmp/CG/cgroup.subtree_control
> 
> 	mkdir /tmp/CG/PID
> 	echo 2 > /tmp/CG/PID/pids.max
> 
> 	perl -e 'while ($p = fork) { wait; } $p // die "fork failed: $!\n"' &
> 	echo $! > /tmp/CG/PID/cgroup.procs
> 
> Without this patch the forking process fails soon after migration.
> 
> Rename cgroup_subsys->free() to cgroup_subsys->release() and move the callsite
> into the new helper, cgroup_release(), called by release_task() which actually
> frees the pid(s).
> 
> Reported-by: Herton R. Krzesinski <hkrzesin@redhat.com>
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Applied to cgroup/for-5.0.

Thanks, Oleg.

-- 
tejun
