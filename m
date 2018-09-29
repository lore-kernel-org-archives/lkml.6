Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BA9C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C2020779
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq0k6Bcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C2020779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeI2Hdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 03:33:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46246 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbeI2Hdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 03:33:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id q4-v6so7741259otf.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 18:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGs0moIO4FdXq/oYSjepxSfEhassdyOHJ9IHXd44IBI=;
        b=hq0k6BcfUrQMCEMKkXjM75Z2hfd+5ohW2vrwE4PyultkTJUD2n95cDZhYrPTlnf0VW
         49g851WknF11970ROjNliw2EcGj0n9A2SZMTwBy4oFRb0VGnwnq6Iputk0esBC7u3zCV
         0U+P7ihhkcV/vUc5ypK4eBiq8bywbH+axELG6JMH0Lk/qizDB40ijEVSS4kvkIncc8Gr
         CeR/MuVokEoOQG4rYy+i5pIqg9j1zOIzrIlIO9xQ5PxjLZtLrSfxtfB4a3vUS7VV4R9F
         yNtRwreraPBGh1PM7387GfXxCMeb0DEo5EBhjkjeAJjy3ESRRMYyZYgQbSxmefPq27GP
         cTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGs0moIO4FdXq/oYSjepxSfEhassdyOHJ9IHXd44IBI=;
        b=sUUxJMlOhJOpjqbIrRlyXsJ2uqZ/mmCnKV/Xlxh65Afy4XnR1l4YF/eBHTc+RdC+Aq
         gYf3zltbksjz3eGFonMExUauTctkn7+IvNNbIf3il7dQJryg1dEXExTTM03K+ItOW4oS
         HU9Tj1dSyxgXTPEkyjLQ/onZ4o0IzfhShvksaeUabFRdT0y2shx1Q/V1Vk7QHHVADjbE
         c5fuMOMUc5gYFrxMDukO9A2sAN+OfSdOHSyqP7DtqBh4QLxxVMHPv3tySuGhfMbRPO9m
         MMP3WCJs/Hj0IQ+Psudsbbzdxq+Bg+HKTa0EgcpFJEZM0jAJ1PhjRTXZb3o4QNR9i8Vo
         kTrw==
X-Gm-Message-State: ABuFfoiIUBRIkSs2Uq9Wd6cmSOnbjTOnhde90D/94BgolaY0U+OiJV29
        H0uNiiG0/K4CVNPtV/CTOGkUM0J/tdOaUfmqLx/nBg==
X-Google-Smtp-Source: ACcGV62ml1H3ndEsGim7j5I9HB7oDzP9yAEB0rYLedExEgWEw1JQdmp8qz7Z4aZ4qLfqcoFbFrIWQIH9sA4SECYhggY=
X-Received: by 2002:a9d:4a9c:: with SMTP id i28-v6mr743336otf.138.1538183243051;
 Fri, 28 Sep 2018 18:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180817182728.76129-1-smuckle@google.com> <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net> <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
 <ae94fb88-646b-1d82-b61d-103792965dbf@google.com> <20180827111458.GB24124@hirez.programming.kicks-ass.net>
 <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com> <CANRm+CwEKf9bBj3zBQAL2nYjdt-zymz1xg7=PRcFz6DUOjLVJg@mail.gmail.com>
 <62134bba-b6bd-ba16-a49b-e4887c326559@arm.com> <CANRm+CzasXnjUtA_Xkm27=YDArc-gcpLmpSHv1cAqxihfocxRw@mail.gmail.com>
 <fab279dd-0f6c-af7a-5a06-d26e77afad6a@arm.com> <CANRm+CyJQ_D9BP70OmB6z6r0zxDPoB0y828+E0tqis0x=jsd5A@mail.gmail.com>
 <c0ec8322-4256-d8ae-0978-25ab44e34d68@google.com> <2cee0f7c-023d-7b20-0a19-c2a4427625d9@arm.com>
In-Reply-To: <2cee0f7c-023d-7b20-0a19-c2a4427625d9@arm.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Sat, 29 Sep 2018 09:07:28 +0800
Message-ID: <CANRm+Cy=EvxMtzLhvyD44qG0ze5jX6PiDUNZ-CvNa1RRmb08Kw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from fair
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Steve Muckle <smuckle@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel de Dios <migueldedios@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        quentin.perret@arm.com, Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris.Redpath@arm.com, Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>,
        Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2018 at 01:36, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 09/28/2018 06:10 PM, Steve Muckle wrote:
> > On 09/27/2018 05:43 PM, Wanpeng Li wrote:
> >>>> On your CPU4:
> >>>> scheduler_ipi()
> >>>>    -> sched_ttwu_pending()
> >>>>         -> ttwu_do_activate()    => p->sched_remote_wakeup should be
> >>>> false, so ENQUEUE_WAKEUP is set, ENQUEUE_MIGRATED is not
> >>>>              -> ttwu_activate()
> >>>>                   -> activate_task()
> >>>>                        -> enqueue_task()
> >>>>                             -> enqueue_task_fair()
> >>>>                                  -> enqueue_entity()
> >>>>                                       bool renorm = !(flags &
> >>>> ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATE)
> >>>> so renorm is false in enqueue_entity(), why you mentioned that the
> >>>> cfs_rq->min_vruntime is still added to the se->vruntime in
> >>>> enqueue_task_fair()?
> >>>
> >>> Maybe this is a misunderstanding on my side but didn't you asked me to
> >>> '... Could you point out when the fair rq's min_vruntime is added to the
> >>> task's vruntime in your *later* scenario? ...'
> >>
> >> Yeah, if the calltrace above and my analysis is correct, then the fair
> >> rq's min_vruntime will not be added to the task's vruntime in your
> >> *later* scenario, which means that your patch is not necessary.
> >
> > In the scenario I observed, the task is not waking - it is running and
> > being deboosted from priority inheritance, transitioning from RT to CFS.
> >
> > Dietmar and I both were able to reproduce the issue with the testcase I
> > posted earlier in this thread.
>
> Correct, and with the same testcase I got this call stack in this scenario:
>
> [   35.588509] CPU: 1 PID: 2926 Comm: fair_task Not tainted
> 4.18.0-rc6-00052-g11b7dafa2edb-dirty #5
> [   35.597217] Hardware name: ARM Juno development board (r0) (DT)
> [   35.603080] Call trace:
> [   35.605509]  dump_backtrace+0x0/0x168
> [   35.609138]  show_stack+0x24/0x30
> [   35.612424]  dump_stack+0xac/0xe4
> [   35.615710]  enqueue_task_fair+0xae0/0x11c0
> [   35.619854]  rt_mutex_setprio+0x5a0/0x628
> [   35.623827]  mark_wakeup_next_waiter+0x7c/0xc8
> [   35.628228]  __rt_mutex_futex_unlock+0x30/0x50
> [   35.632630]  do_futex+0x74c/0xb28
> [   35.635912]  sys_futex+0x118/0x198
> [   35.639280]  el0_svc_naked+0x30/0x34

Thanks for pointing out. :)

Regards,
Wanpeng Li
