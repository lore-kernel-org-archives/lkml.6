Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03CCC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A0520657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNXybYl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A0520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbeI1XHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:07:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38542 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbeI1XHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:07:49 -0400
Received: by mail-qk1-f196.google.com with SMTP id 204-v6so3578492qkd.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8Cb/DQIaYzta2SyDUga23E6hAgj/e33tq3DL8c560fk=;
        b=mNXybYl1ZTDvd7WQdLglwD/n7PHY2OVGDpEq8TF8RQB3BgZM64uOvej3ancAGr/soE
         DM4+KOUhVdA+nnSe3B5SZx8oGbxxnSfUxORbLtW/RDbT0oLa/ocVwuYZx+Qo9h+VwOzr
         TFmCbDcT9hBq61inte143kOf90a23vmFAZziappv6b23VURRLN6TvWtQVXAnp7Nz/ajy
         1iPqhGvXVgF2zNqGHaup3/F9L847bP85vTGTDqjoBFZ6+p4zykOpnh6KtaaGHZ3iwZsm
         VLBpoGAzvNLxSR9zUIbslRXVffnQ1fhIFUbZhXmAHgiF3nJrdyULceKgglMPVH8NcgUu
         XDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8Cb/DQIaYzta2SyDUga23E6hAgj/e33tq3DL8c560fk=;
        b=PIWrFtQLiTLGQ8NvttqBjdzQa4AbhDYrDe7DVKe3C6eKj+peA+C9NI47uEOnyU6raU
         IextwCIbV0s/wBKczq7heAyEH6Wn3teu/SK9KRlMiVOUoP+pQtJHU7+fCGHVvoidTTnl
         SjIc5xzULVhL+5cnJWsF0cwiG01JNgkhKmt7Em7tiFzkK78m5HDih6RpZuD5jrMAKYm9
         +XbK6jR7ETo7yfKQYrcxQU4SecFc3XOumvLJkyrgvlR6Xf8sGDcC5sqRhnbO3NWq1g7J
         vEo7Gobs9ytCkkJcfhrcXJdnk6dYeldd13fNKvAKFq84H6BG3BzBttpOFUxYk0hgd1nN
         mcJw==
X-Gm-Message-State: ABuFfoi4Vc1AImUVd7CP3IdpbClkOPDmH5BNWM7Nx89hu/wQwGEA3pKX
        +NvaSDkcXggeQsd+1uFj3k9U17PoNZ/LLZ7QkFHEFfTFr50=
X-Google-Smtp-Source: ACcGV62aWtdG9LGPgDFrP6Ujr6V6XaJITX6sYh+/8Ts15QPe5w+Azn1udftkjNkIWRpqqa8HplaUrGdNxp54cGeW4js=
X-Received: by 2002:a37:c603:: with SMTP id b3-v6mr12409669qkj.176.1538152993284;
 Fri, 28 Sep 2018 09:43:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2abb:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 09:43:12
 -0700 (PDT)
In-Reply-To: <CANRm+CzasXnjUtA_Xkm27=YDArc-gcpLmpSHv1cAqxihfocxRw@mail.gmail.com>
References: <20180817182728.76129-1-smuckle@google.com> <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net> <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
 <ae94fb88-646b-1d82-b61d-103792965dbf@google.com> <20180827111458.GB24124@hirez.programming.kicks-ass.net>
 <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com> <CANRm+CwEKf9bBj3zBQAL2nYjdt-zymz1xg7=PRcFz6DUOjLVJg@mail.gmail.com>
 <62134bba-b6bd-ba16-a49b-e4887c326559@arm.com> <CANRm+CzasXnjUtA_Xkm27=YDArc-gcpLmpSHv1cAqxihfocxRw@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Fri, 28 Sep 2018 09:43:12 -0700
Message-ID: <CAJWu+oojnBfPvEa6YP=p4Cfp8r9hBdtL4ygjvk9=C4EhpgDkoA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from fair
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steve Muckle <smuckle@google.com>,
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

On Wed, Sep 26, 2018 at 6:19 PM, Wanpeng Li <kernellwp@gmail.com> wrote:
> On Thu, 27 Sep 2018 at 06:38, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> Hi,
>>
>> On 09/26/2018 11:50 AM, Wanpeng Li wrote:
>> > Hi Dietmar,
>> > On Tue, 28 Aug 2018 at 22:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>> >>
>> >> On 08/27/2018 12:14 PM, Peter Zijlstra wrote:
>> >>> On Fri, Aug 24, 2018 at 02:24:48PM -0700, Steve Muckle wrote:
>> >>>> On 08/24/2018 02:47 AM, Peter Zijlstra wrote:
>> >>>>>>> On 08/17/2018 11:27 AM, Steve Muckle wrote:
>>
>> [...]
>>
>> >>>>>>>> - later, when the prio is deboosted and the task is moved back
>> >>>>>>>>       to the fair class, the fair rq's min_vruntime is added to
>> >>>>>>>>       the task's vruntime, even though it wasn't subtracted earlier.
>> >
>> > Could you point out when the fair rq's min_vruntime is added to the
>> > task's vruntime in your *later* scenario? attach_task_cfs_rq will not
>> > do that the same reason as detach_task_cfs_rq. fair task's
>> > sched_remote_wakeup is false which results in vruntime will not be
>> > renormalized in enqueue_entity.
>>
>> The cfs_rq->min_vruntime is still added to the se->vruntime in
>> enqueue_task_fair().
>
> I understand what your patch done,
>
> On your CPU4:
> scheduler_ipi()
>  -> sched_ttwu_pending()
>       -> ttwu_do_activate()    => p->sched_remote_wakeup should be
> false, so ENQUEUE_WAKEUP is set, ENQUEUE_MIGRATED is not
>            -> ttwu_activate()
>                 -> activate_task()
>                      -> enqueue_task()
>                           -> enqueue_task_fair()
>                                -> enqueue_entity()
>                                     bool renorm = !(flags &
> ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATE)
> so renorm is false in enqueue_entity(), why you mentioned that the
> cfs_rq->min_vruntime is still added to the se->vruntime in
> enqueue_task_fair()?

If I understand John's original patch correctly, the additional
vruntime is added when the class of the waking task is changed during
priority deboost so that path is different from the one you listed
above? Perhaps you should be looking at rt_mutex_setprio?

 - Joel
