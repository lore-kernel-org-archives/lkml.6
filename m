Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754692AbeDTK66 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:58:58 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:38056 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754462AbeDTK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:58:56 -0400
X-Google-Smtp-Source: AIpwx4/AXj2h4EOQmSWBEcCwF01rMfIRSdvPse+f2cSyND/5J9RogUjqrF4+yN1026fVtr+rz7VmDg==
Date: Fri, 20 Apr 2018 12:58:52 +0200
From: Juri Lelli <juri.lelli@gmail.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Rework for_each_process_thread() iterations in
 tg_has_rt_tasks()
Message-ID: <20180420105852.GH24599@localhost.localdomain>
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
 <20180420092540.GG24599@localhost.localdomain>
 <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/18 12:43, Kirill Tkhai wrote:
> On 20.04.2018 12:25, Juri Lelli wrote:

[...]

> > Isn't this however checking against the current (dynamic) number of
> > runnable tasks/groups instead of the "static" group membership (which
> > shouldn't be affected by a task running state)?
> 
> Ah, you are sure. I forgot that rt_nr_running does not contain sleeping tasks.
> We need to check something else here. I'll try to find another way.

n/p. Maybe a per rt_rq flag linked to "static" membership (I didn't
really thought this through though :).

BTW, since you faced this problem, I guess this is on RT_GROUP_SCHED
enabled boxes, so I'd have a couple of questions (not strictly related
to the problem at hand):

 - do such boxes rely on RT throttling being performed at root level?
 - is RT_RUNTIME_SHARE enabled?

Thanks,

- Juri
