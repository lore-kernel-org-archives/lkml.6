Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5395DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053B120657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vbdDqSLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053B120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeI1XKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:10:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40376 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeI1XKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:10:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id e9-v6so7314276qtp.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bld+VnZHzmH5jITF+rN/Hr8nuyy+G6e7pbEOctDCdrc=;
        b=vbdDqSLLhqbUy9xvU77G91sy22SjMM/mvo0YCtJLKvwCerQ5NAMEoK4a1xZ1/Rc7/l
         ZWFdp5H78lRpUOAtJMBYs7d1of/cedtArPY0YYK4NH3lpCh1njhCXbZyokkP9jWd+Tkb
         6uj7y4WI3/D/epMTN4ka3x0J5XOgmsgq67a0nSxc4r8Dnm68vdR+FKwa/0quLbseKiQb
         Tz2xqlCLiFW40QsXDtd7RCOt6KTUChoUmBVmLz/EZmxu1oFyeqobdF97gGtx2ItjjOk5
         pbhonvHzVwNIYZ5GCmM+PAUZ/mEr7oe83rxBM9bbE56iYdGosDj7wkVD6sq0C9wWDWVC
         x1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bld+VnZHzmH5jITF+rN/Hr8nuyy+G6e7pbEOctDCdrc=;
        b=duQgBSE8/B4IPF65sGvVVOyRGkxKxU6DjdC9GSF5xSzzNz81mjHq8W9vUpH7T+Gp+1
         yRkOvE/2u1bdTQe4dI+AvBIcL6D1m4w2YvgD+T0VaYVGEZUjaGviBRbZSwWFd6CUZIjx
         S34Ms+ZtTcb2K831A+UI8t8Ydb37ga0+2AnTSV+6SlIrQHig0hkDE9ccMMhLx+aDLBGo
         3GPbsE3Tu6bH6Ytb5R+JM1WQHqguCSf3xYvHWeil1HGbo+0bgVPxydnbKiIhNRga7TYp
         VI8RGBFLlRM+ibumElIb6MjZVp5Pv158ik731H9FkVPsWL8e3cfhLZi3VSvwZN7CiGTP
         an6g==
X-Gm-Message-State: ABuFfoh3RBBbiZ6Dk7JF92EXWTi7ZbsVyc03bKnA+noyc2WbLbWaGR4u
        qfg4av7Xm/u74iYf89YMkUS5MTa24Ns6W0dCBUSRxA==
X-Google-Smtp-Source: ACcGV63PqlrsSKxzj3TabLdijiFMi2OtQM+R4uf8/G6O+k28rrVqisA9P/8OB0GjB/gR/cOgUhqtyOYyyGFS7X51LnU=
X-Received: by 2002:a0c:d48d:: with SMTP id u13-v6mr12605367qvh.165.1538153144179;
 Fri, 28 Sep 2018 09:45:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2abb:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 09:45:43
 -0700 (PDT)
In-Reply-To: <c0ec8322-4256-d8ae-0978-25ab44e34d68@google.com>
References: <20180817182728.76129-1-smuckle@google.com> <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net> <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
 <ae94fb88-646b-1d82-b61d-103792965dbf@google.com> <20180827111458.GB24124@hirez.programming.kicks-ass.net>
 <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com> <CANRm+CwEKf9bBj3zBQAL2nYjdt-zymz1xg7=PRcFz6DUOjLVJg@mail.gmail.com>
 <62134bba-b6bd-ba16-a49b-e4887c326559@arm.com> <CANRm+CzasXnjUtA_Xkm27=YDArc-gcpLmpSHv1cAqxihfocxRw@mail.gmail.com>
 <fab279dd-0f6c-af7a-5a06-d26e77afad6a@arm.com> <CANRm+CyJQ_D9BP70OmB6z6r0zxDPoB0y828+E0tqis0x=jsd5A@mail.gmail.com>
 <c0ec8322-4256-d8ae-0978-25ab44e34d68@google.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Fri, 28 Sep 2018 09:45:43 -0700
Message-ID: <CAJWu+ooPKg_hE=AkTCXy9J7ToCqkDu6u_d9TYXM-HSpjYWMT2g@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from fair
To:     Steve Muckle <smuckle@google.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel de Dios <migueldedios@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>,
        Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 9:10 AM, 'Steve Muckle' via kernel-team
<kernel-team@android.com> wrote:
> On 09/27/2018 05:43 PM, Wanpeng Li wrote:
>>>>
>>>> On your CPU4:
>>>> scheduler_ipi()
>>>>    -> sched_ttwu_pending()
>>>>         -> ttwu_do_activate()    => p->sched_remote_wakeup should be
>>>> false, so ENQUEUE_WAKEUP is set, ENQUEUE_MIGRATED is not
>>>>              -> ttwu_activate()
>>>>                   -> activate_task()
>>>>                        -> enqueue_task()
>>>>                             -> enqueue_task_fair()
>>>>                                  -> enqueue_entity()
>>>>                                       bool renorm = !(flags &
>>>> ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATE)
>>>> so renorm is false in enqueue_entity(), why you mentioned that the
>>>> cfs_rq->min_vruntime is still added to the se->vruntime in
>>>> enqueue_task_fair()?
>>>
>>>
>>> Maybe this is a misunderstanding on my side but didn't you asked me to
>>> '... Could you point out when the fair rq's min_vruntime is added to the
>>> task's vruntime in your *later* scenario? ...'
>>
>>
>> Yeah, if the calltrace above and my analysis is correct, then the fair
>> rq's min_vruntime will not be added to the task's vruntime in your
>> *later* scenario, which means that your patch is not necessary.
>
>
> In the scenario I observed, the task is not waking - it is running and being
> deboosted from priority inheritance, transitioning from RT to CFS.
>
> Dietmar and I both were able to reproduce the issue with the testcase I
> posted earlier in this thread.

Can this issue still show up say if the wake up was not remote? Say
the task was locally awakened. In that case do we still need to check
the class in vruntime_normalized like John was doing? Just want to
make sure we caught all scenarios.

- Joel
