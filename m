Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68A2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89471206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKrlt8FK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89471206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeIGMiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:38:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45791 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeIGMiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:38:46 -0400
Received: by mail-io1-f68.google.com with SMTP id e12-v6so873071iok.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFqGn8H2XOLdxAUMmK92mhg66LSV5fxaPWcARY7X16s=;
        b=jKrlt8FKwbifwVjOkDnGIdfy9Ztr7XSEDM0U4xQRpZKTJK1viEKx9UvquyIksGCWtS
         xk0MWsmlbgKZBaUEg6NHJFcIC8gWm3cpuUUSzguPe644gnIKJivForIVx7k8oxJoez60
         SKiOrqZ3ZoC2/H+Rl5p450jjYxpYLUlxwg5oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFqGn8H2XOLdxAUMmK92mhg66LSV5fxaPWcARY7X16s=;
        b=NtIpMrMtbi9Fu9fFiCeC34JSt0X2q/4y5f6xz8t3EYzrwFHN/2cRQlYPKUY0SjAzeV
         HvFsiHYlXK9njm4c53wcX5PcEwR5Med/c3KYF1wSYubzaBqYT3NatnTNU/eky65uQhM8
         ImUOGflKgHTU42lxIpkYfFnBEMK1bBgojfrX2wGL/K6NwWmFomkVANT9Qyz2buQ3Jg/w
         1doFInHCEfQdY+t70ZZiO/lLqUYGK9tt3HIn92shMHWCcqNBAhh9A3zZmLq3XCyC/in6
         +7/2LX6MgcvqeZtKYMmqII/PXRS8sGhjmOKaTBExcrdRSsvy82se5O2IgzQaloHdMkCz
         ObEQ==
X-Gm-Message-State: APzg51AclFnlLdOsm9sD78v36SXGRkioy8oYdLm3Z3F2mM+IO2hWFGnK
        KSAcIJdv7tojjiDu8eIdpv1Kbo2XPa9NcbH1RBJBqw==
X-Google-Smtp-Source: ANB0VdY0+D4jHgyjWgtUHxV6w8zECd0G7dzPiyeNU0Hi/5SoK38T0+XtmLsOCSW6LZZvuPP78v1zEx/WBfIQRt4IqPI=
X-Received: by 2002:a6b:fe0d:: with SMTP id x13-v6mr4869597ioh.294.1536307141910;
 Fri, 07 Sep 2018 00:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180817182728.76129-1-smuckle@google.com> <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <b27b2354-cbfe-7c16-bdc1-d88ed3be90bd@arm.com> <20180824065419.GB24860@localhost.localdomain>
 <5fa77995-428e-077e-e236-7cc4a2e82577@arm.com> <20180907071602.GA29405@localhost.localdomain>
In-Reply-To: <20180907071602.GA29405@localhost.localdomain>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 7 Sep 2018 09:58:50 +0200
Message-ID: <CAKfTPtCpqhQAMeQnUtuePbris0vyjmzfXo40zdprffqh9Pwv=A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from fair
To:     Juri Lelli <juri.lelli@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        migueldedios@google.com, "Cc: Steve Muckle" <smuckle@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018 at 09:16, Juri Lelli <juri.lelli@gmail.com> wrote:
>
> On 06/09/18 16:25, Dietmar Eggemann wrote:
> > Hi Juri,
> >
> > On 08/23/2018 11:54 PM, Juri Lelli wrote:
> > > On 23/08/18 18:52, Dietmar Eggemann wrote:
> > > > Hi,
> > > >
> > > > On 08/21/2018 01:54 AM, Miguel de Dios wrote:
> > > > > On 08/17/2018 11:27 AM, Steve Muckle wrote:
> > > > > > From: John Dias <joaodias@google.com>
> >
> > [...]
> >
> > > >
> > > > I tried to catch this issue on my Arm64 Juno board using pi_test (and a
> > > > slightly adapted pip_test (usleep_val = 1500 and keep low as cfs)) from
> > > > rt-tests but wasn't able to do so.
> > > >
> > > > # pi_stress --inversions=1 --duration=1 --groups=1 --sched id=low,policy=cfs
> > > >
> > > > Starting PI Stress Test
> > > > Number of thread groups: 1
> > > > Duration of test run: 1 seconds
> > > > Number of inversions per group: 1
> > > >       Admin thread SCHED_FIFO priority 4
> > > > 1 groups of 3 threads will be created
> > > >        High thread SCHED_FIFO priority 3
> > > >         Med thread SCHED_FIFO priority 2
> > > >         Low thread SCHED_OTHER nice 0
> > > >
> > > > # ./pip_stress
> > > >
> > > > In both cases, the cfs task entering  rt_mutex_setprio() is queued, so
> > > > dequeue_task_fair()->dequeue_entity(), which subtracts cfs_rq->min_vruntime
> > > > from se->vruntime, is called on it before it gets the rt prio.
> > > >
> > > > Maybe it requires a very specific use of the pthread library to provoke this
> > > > issue by making sure that the cfs tasks really blocks/sleeps?
> > >
> > > Maybe one could play with rt-app to recreate such specific use case?
> > >
> > > https://github.com/scheduler-tools/rt-app/blob/master/doc/tutorial.txt#L459
> >
> > I played a little bit with rt-app on hikey960 to re-create Steve's test
> > program.
>
> Oh, nice! Thanks for sharing what you have got.
>
> > Since there is no semaphore support (sem_wait(), sem_post()) I used
> > condition variables (wait: pthread_cond_wait() , signal:
> > pthread_cond_signal()). It's not really the same since this is stateless but
> > sleeps before the signals help to maintain the state in this easy example.
> >
> > This provokes the vruntime issue e.g. for cpus 0,4 and it doesn't for 0,1:
> >
> >
> >     "global": {
> >         "calibration" : 130,
> >       "pi_enabled" : true
> >     },
> >     "tasks": {
> >         "rt_task": {
> >           "loop" : 100,
> >           "policy" : "SCHED_FIFO",
> >           "cpus" : [0],
> >
> >           "lock" : "b_mutex",
> >           "wait" : { "ref" : "b_cond", "mutex" : "b_mutex" },
> >           "unlock" : "b_mutex",
> >           "sleep" : 3000,
> >           "lock1" : "a_mutex",
> >           "signal" : "a_cond",
> >           "unlock1" : "a_mutex",
> >           "lock2" : "pi-mutex",
> >           "unlock2" : "pi-mutex"
> >         },
> >       "cfs_task": {
> >           "loop" : 100,
> >           "policy" : "SCHED_OTHER",
> >           "cpus" : [4],
> >
> >           "lock" : "pi-mutex",
> >           "sleep" : 3000,
> >           "lock1" : "b_mutex",
> >           "signal" : "b_cond",
> >           "unlock" : "b_mutex",
> >           "lock2" : "a_mutex",
> >           "wait" : { "ref" : "a_cond", "mutex" : "a_mutex" },
> >           "unlock1" : "a_mutex",
> >           "unlock2" : "pi-mutex"
> >       }
> >     }
> > }
> >
> > Adding semaphores is possible but rt-app has no easy way to initialize
> > individual objects, e.g. sem_init(..., value). The only way I see is via the
> > global section, like "pi_enabled". But then, this is true for all objects of
> > this kind (in this case mutexes)?
>
> Right, global section should work fine. Why do you think this is a
> problem/limitation?

keep in mind that rt-app still have "ressources" section. This one is
optional and almost never used as resources can be created on the fly
but it's still there and can be used to initialize resources if needed
like semaphore

>
> > So the following couple of lines extension to rt-app works because both
> > semaphores can be initialized to 0:
> >
> >  {
> >     "global": {
> >         "calibration" : 130,
> >       "pi_enabled" : true
> >     },
> >     "tasks": {
> >         "rt_task": {
> >           "loop" : 100,
> >           "policy" : "SCHED_FIFO",
> >           "cpus" : [0],
> >
> >           "sem_wait" : "b_sem",
> >           "sleep" : 1000,
> >           "sem_post" : "a_sem",
> >
> >           "lock" : "pi-mutex",
> >           "unlock" : "pi-mutex"
> >         },
> >       "cfs_task": {
> >           "loop" : 100,
> >           "policy" : "SCHED_OTHER",
> >           "cpus" : [4],
> >
> >           "lock" : "pi-mutex",
> >           "sleep" : 1000,
> >           "sem_post" : "b_sem",
> >           "sem_wait" : "a_sem",
> >           "unlock" : "pi-mutex"
> >       }
> >     }
> > }
> >
> > Any thoughts on that? I can see something like this as infrastructure to
> > create a regression test case based on rt-app and standard ftrace.
>
> Agree. I guess we should add your first example to the repo (you'd be
> very welcome to create a PR) already and then work to support the second?
