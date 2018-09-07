Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A60FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2701D20861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sruWDCwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2701D20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeIGLzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:55:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37679 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeIGLzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:55:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so13819825wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WAcTWorLVziaKbF69W7ubAgfrLu6JqXMDUbsCTpCx+U=;
        b=sruWDCwl8SNWfJbPx2DqpmhqFNpwHq5rZzrDx1ClSQ3rbqOfkEM89WX6JiXUwzPlDw
         gfkrakND3w+duqFrGd9sPgv9/52ujQFWh+iWk2idxixEghNGTnbdaJ3BHXBTsON3oZsg
         0DzAUmJ/CUNOFiEVUhA8XtRNyJ4x+xhKbUsXgwX1klhCzS5h66UBF8UZFPrY+iK5oxtc
         4Cz2y69EZEl5K4CcnezC1BLqIj40CBV0hataR7Bfu26K1J3Y192LSk7j+Nh5btCE8ed6
         pfbBtdHhygleo8HDHp27SpF6RK8A2gleWYU2BuKemsGg2h1DxYYG0VfdYXfwhiAzCvOP
         Su9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WAcTWorLVziaKbF69W7ubAgfrLu6JqXMDUbsCTpCx+U=;
        b=iF5fFfiE/TB2Z9oIhVZpnlx/95A9+oq15GzbPr+RfI5bmfoGRD6MTTxTkv5oaWVjOx
         ulgdSc9aJ0cyzrpnfhxyM4GZTgY+ClZYX6AEtqY3Ubykdp3wUXUXtiN0Gp+loWAFLajj
         jS++wD7AhOPeHM2MvrsLtoCeIUc1nIhvsay0L5eeR8OnhzwO1HARt8Ig2USngkQeWips
         ibqsTH8Rwc2pjZHE7fP+AkEBbRo5T+wbymNjOVm++gcinbXH09ij54jjBUEVKqT/LXIu
         tYks+6Hz9Wv8+zRCFjH/uZhVCtswXcx54kQTZVQ3VhO3V8SJcfS2ufs7Bb3WDlvinWjF
         H6Ng==
X-Gm-Message-State: APzg51AHw3ZSHKXW2/gOvUtUVmM+6HysAi12arWKBhfz4GECXyO/kQc1
        pWntrArWUYa6+rypqOpgza4=
X-Google-Smtp-Source: ANB0Vdb/kSJfvM0rA4f/EUDFp+fIbMU2HaWp27LCAGWF25jlKQlniQ++GrciAqW5HHWhSZHKyXmdrQ==
X-Received: by 2002:a5d:418c:: with SMTP id m12-v6mr4955713wrp.8.1536304565639;
        Fri, 07 Sep 2018 00:16:05 -0700 (PDT)
Received: from localhost.localdomain ([151.15.227.30])
        by smtp.gmail.com with ESMTPSA id n11-v6sm7925882wra.26.2018.09.07.00.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 00:16:04 -0700 (PDT)
Date:   Fri, 7 Sep 2018 09:16:02 +0200
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Miguel de Dios <migueldedios@google.com>,
        Steve Muckle <smuckle@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Todd Kjos <tkjos@google.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching
 from fair
Message-ID: <20180907071602.GA29405@localhost.localdomain>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <b27b2354-cbfe-7c16-bdc1-d88ed3be90bd@arm.com>
 <20180824065419.GB24860@localhost.localdomain>
 <5fa77995-428e-077e-e236-7cc4a2e82577@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa77995-428e-077e-e236-7cc4a2e82577@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/18 16:25, Dietmar Eggemann wrote:
> Hi Juri,
> 
> On 08/23/2018 11:54 PM, Juri Lelli wrote:
> > On 23/08/18 18:52, Dietmar Eggemann wrote:
> > > Hi,
> > > 
> > > On 08/21/2018 01:54 AM, Miguel de Dios wrote:
> > > > On 08/17/2018 11:27 AM, Steve Muckle wrote:
> > > > > From: John Dias <joaodias@google.com>
> 
> [...]
> 
> > > 
> > > I tried to catch this issue on my Arm64 Juno board using pi_test (and a
> > > slightly adapted pip_test (usleep_val = 1500 and keep low as cfs)) from
> > > rt-tests but wasn't able to do so.
> > > 
> > > # pi_stress --inversions=1 --duration=1 --groups=1 --sched id=low,policy=cfs
> > > 
> > > Starting PI Stress Test
> > > Number of thread groups: 1
> > > Duration of test run: 1 seconds
> > > Number of inversions per group: 1
> > >       Admin thread SCHED_FIFO priority 4
> > > 1 groups of 3 threads will be created
> > >        High thread SCHED_FIFO priority 3
> > >         Med thread SCHED_FIFO priority 2
> > >         Low thread SCHED_OTHER nice 0
> > > 
> > > # ./pip_stress
> > > 
> > > In both cases, the cfs task entering  rt_mutex_setprio() is queued, so
> > > dequeue_task_fair()->dequeue_entity(), which subtracts cfs_rq->min_vruntime
> > > from se->vruntime, is called on it before it gets the rt prio.
> > > 
> > > Maybe it requires a very specific use of the pthread library to provoke this
> > > issue by making sure that the cfs tasks really blocks/sleeps?
> > 
> > Maybe one could play with rt-app to recreate such specific use case?
> > 
> > https://github.com/scheduler-tools/rt-app/blob/master/doc/tutorial.txt#L459
> 
> I played a little bit with rt-app on hikey960 to re-create Steve's test
> program.

Oh, nice! Thanks for sharing what you have got.

> Since there is no semaphore support (sem_wait(), sem_post()) I used
> condition variables (wait: pthread_cond_wait() , signal:
> pthread_cond_signal()). It's not really the same since this is stateless but
> sleeps before the signals help to maintain the state in this easy example.
> 
> This provokes the vruntime issue e.g. for cpus 0,4 and it doesn't for 0,1:
> 
> 
>     "global": {
>         "calibration" : 130,
> 	"pi_enabled" : true
>     },
>     "tasks": {
>         "rt_task": {
> 	    "loop" : 100,
> 	    "policy" : "SCHED_FIFO",
> 	    "cpus" : [0],
> 
> 	    "lock" : "b_mutex",
> 	    "wait" : { "ref" : "b_cond", "mutex" : "b_mutex" },
> 	    "unlock" : "b_mutex",
> 	    "sleep" : 3000,
> 	    "lock1" : "a_mutex",
> 	    "signal" : "a_cond",
> 	    "unlock1" : "a_mutex",
> 	    "lock2" : "pi-mutex",
> 	    "unlock2" : "pi-mutex"
>         },
> 	"cfs_task": {
> 	    "loop" : 100,
> 	    "policy" : "SCHED_OTHER",
> 	    "cpus" : [4],
> 
> 	    "lock" : "pi-mutex",
> 	    "sleep" : 3000,
> 	    "lock1" : "b_mutex",
> 	    "signal" : "b_cond",
> 	    "unlock" : "b_mutex",
> 	    "lock2" : "a_mutex",
> 	    "wait" : { "ref" : "a_cond", "mutex" : "a_mutex" },
> 	    "unlock1" : "a_mutex",
> 	    "unlock2" : "pi-mutex"
> 	}
>     }
> }
> 
> Adding semaphores is possible but rt-app has no easy way to initialize
> individual objects, e.g. sem_init(..., value). The only way I see is via the
> global section, like "pi_enabled". But then, this is true for all objects of
> this kind (in this case mutexes)?

Right, global section should work fine. Why do you think this is a
problem/limitation?

> So the following couple of lines extension to rt-app works because both
> semaphores can be initialized to 0:
> 
>  {
>     "global": {
>         "calibration" : 130,
> 	"pi_enabled" : true
>     },
>     "tasks": {
>         "rt_task": {
> 	    "loop" : 100,
> 	    "policy" : "SCHED_FIFO",
> 	    "cpus" : [0],
> 
> 	    "sem_wait" : "b_sem",
> 	    "sleep" : 1000,
> 	    "sem_post" : "a_sem",
> 
> 	    "lock" : "pi-mutex",
> 	    "unlock" : "pi-mutex"
>         },
> 	"cfs_task": {
> 	    "loop" : 100,
> 	    "policy" : "SCHED_OTHER",
> 	    "cpus" : [4],
> 
> 	    "lock" : "pi-mutex",
> 	    "sleep" : 1000,
> 	    "sem_post" : "b_sem",
> 	    "sem_wait" : "a_sem",
> 	    "unlock" : "pi-mutex"
> 	}
>     }
> }
> 
> Any thoughts on that? I can see something like this as infrastructure to
> create a regression test case based on rt-app and standard ftrace.

Agree. I guess we should add your first example to the repo (you'd be
very welcome to create a PR) already and then work to support the second?
