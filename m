Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0F0C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73633216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jthJIQ8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73633216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeI1HE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:04:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33450 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeI1HE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:04:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id m23-v6so4454262otf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 17:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/qrlf1dK3fn9eJSI6b4QMDt8+4BwVqHtak2+oPBAkw=;
        b=jthJIQ8ZsIRPyHhJ70aboUAVfoD7CU1nI/OJiWb8f76Z/UbagDAP48Z95sG+f20Qu/
         L/VNGrEdRb8HrqY1j5VNCAzd/GQlV48dlac4Q2gf1ngGfwwj7EZ3pChnatVRk6STkSfv
         h5AFxrxwdazr1mfa7v62j02gYDiHf5y7DAfjtwcuRa7XY3KxFIC3eQwm+cLHNLTRbzND
         Qk10qtBTlkCrTemWxSp+KwcHVXcLzPKFzwradJmzirn5hluH1ksF3+9zcT1rYtn8BSok
         fl6yUgQDr4sa64t9v/bxxzr94aWBxdLVu7dSBpeGY0ludhpWSkUTh5A/fDYN/fmVp4Oc
         PDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/qrlf1dK3fn9eJSI6b4QMDt8+4BwVqHtak2+oPBAkw=;
        b=VXuRmEGM/iq7ysCQViME5lKMhpmsFEs8oYbkBKIp3fN+SbgtB0kP0axUwSmiPelWjw
         bz4BpiLH+HigBm9DdoexWycsAYcEDtfMtzSQO8FapagazWizHaHz12VgzeVn7ScBEjdV
         rLX56UChrWm9eexNqxLzi2lJ79uKk0Z8rvil9YEKhs0vdK1vpvGyAW6ervFA7ylMuSi/
         CAUbR7x0O4LWZ+0hHBWnBIau2G4DDgeTuyUILVpIxYSPvm88ladyN/2dC2unVk94oJgy
         RpAxCFzw655Mk3Nwm0XgPqioFqo4pXjxyjMAb5MqGnSc9EWzOkSMgslEWAdIMDZ/19nL
         sd1g==
X-Gm-Message-State: ABuFfoipNAwG09lm+/1rkXe3sjVa5+fBuUik/hiHCUSxokERZnZevIdX
        LI8TXg/SjrEK1KI+jr209SIDcIuyexSuaORiLd+eHvJU
X-Google-Smtp-Source: ACcGV63+NsbQ+4UfL5TPUZOVCjadd/uor6digTd4EecEwmo3NPku0PvymT10fBgHd7ygn6aQryo/XWX68pQ5989mtvU=
X-Received: by 2002:a9d:4316:: with SMTP id s22-v6mr8522008ote.153.1538095406022;
 Thu, 27 Sep 2018 17:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180817182728.76129-1-smuckle@google.com> <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net> <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
 <ae94fb88-646b-1d82-b61d-103792965dbf@google.com> <20180827111458.GB24124@hirez.programming.kicks-ass.net>
 <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com> <CANRm+CwEKf9bBj3zBQAL2nYjdt-zymz1xg7=PRcFz6DUOjLVJg@mail.gmail.com>
 <62134bba-b6bd-ba16-a49b-e4887c326559@arm.com> <CANRm+CzasXnjUtA_Xkm27=YDArc-gcpLmpSHv1cAqxihfocxRw@mail.gmail.com>
 <fab279dd-0f6c-af7a-5a06-d26e77afad6a@arm.com>
In-Reply-To: <fab279dd-0f6c-af7a-5a06-d26e77afad6a@arm.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 28 Sep 2018 08:43:27 +0800
Message-ID: <CANRm+CyJQ_D9BP70OmB6z6r0zxDPoB0y828+E0tqis0x=jsd5A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from fair
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steve Muckle <smuckle@google.com>,
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

On Thu, 27 Sep 2018 at 21:23, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 09/27/2018 03:19 AM, Wanpeng Li wrote:
> > On Thu, 27 Sep 2018 at 06:38, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> Hi,
> >>
> >> On 09/26/2018 11:50 AM, Wanpeng Li wrote:
> >>> Hi Dietmar,
> >>> On Tue, 28 Aug 2018 at 22:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>>>
> >>>> On 08/27/2018 12:14 PM, Peter Zijlstra wrote:
> >>>>> On Fri, Aug 24, 2018 at 02:24:48PM -0700, Steve Muckle wrote:
> >>>>>> On 08/24/2018 02:47 AM, Peter Zijlstra wrote:
> >>>>>>>>> On 08/17/2018 11:27 AM, Steve Muckle wrote:
> >>
> >> [...]
> >>
> >>>>>>>>>> - later, when the prio is deboosted and the task is moved back
> >>>>>>>>>>        to the fair class, the fair rq's min_vruntime is added to
> >>>>>>>>>>        the task's vruntime, even though it wasn't subtracted earlier.
> >>>
> >>> Could you point out when the fair rq's min_vruntime is added to the
> >>> task's vruntime in your *later* scenario? attach_task_cfs_rq will not
> >>> do that the same reason as detach_task_cfs_rq. fair task's
> >>> sched_remote_wakeup is false which results in vruntime will not be
> >>> renormalized in enqueue_entity.
> >>
> >> The cfs_rq->min_vruntime is still added to the se->vruntime in
> >> enqueue_task_fair().
> >
> > I understand what your patch done,
>
> It's not my patch ;-) I just helped to find out under which
> circumstances this issue can happen.
>
> > On your CPU4:
> > scheduler_ipi()
> >   -> sched_ttwu_pending()
> >        -> ttwu_do_activate()    => p->sched_remote_wakeup should be
> > false, so ENQUEUE_WAKEUP is set, ENQUEUE_MIGRATED is not
> >             -> ttwu_activate()
> >                  -> activate_task()
> >                       -> enqueue_task()
> >                            -> enqueue_task_fair()
> >                                 -> enqueue_entity()
> >                                      bool renorm = !(flags &
> > ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATE)
> > so renorm is false in enqueue_entity(), why you mentioned that the
> > cfs_rq->min_vruntime is still added to the se->vruntime in
> > enqueue_task_fair()?
>
> Maybe this is a misunderstanding on my side but didn't you asked me to
> '... Could you point out when the fair rq's min_vruntime is added to the
> task's vruntime in your *later* scenario? ...'

Yeah, if the calltrace above and my analysis is correct, then the fair
rq's min_vruntime will not be added to the task's vruntime in your
*later* scenario, which means that your patch is not necessary.

Regards,
Wanpeng Li
