Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98976ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 15:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A03521473
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 15:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oPExDVCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A03521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeGOP1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 11:27:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53572 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbeGOP1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 11:27:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so5428836wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KiVpzbUIdMnr/7Qi4XDDfIzppRHFLk8uvimEcOZb7nU=;
        b=oPExDVCvEbA4l2ebxQG0mLkufq0C4ebM6EeB08H/iMiug3agRJAKA+s7DcILIYK74O
         WHUsBmY2kmLq1DQo1iGnQkYsZTzL5J2yiJjr1lY2XvtNA/yQTE7ccuIrVlUcEoVEGK7Y
         NX2HYcLdRdwu28ZzNvun6ydjYBwqa/qkmNZpLAB0cNOPbJuiPbdOVjuQPk/CH1MxSp/s
         f/bU4HJOvejfqGy1PVDP3wuuNI0fwC+TV43pDzu523xL5PhcqYZ+K0mD223jipRyvUGM
         8nW/y2NK00Xfas6RZTnalodEk/5RH9RcD1aMKngdDHyZEQ0+gNC/BbHUwqrywx9Fmns+
         wNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiVpzbUIdMnr/7Qi4XDDfIzppRHFLk8uvimEcOZb7nU=;
        b=qUOVvHbJ76vC/q9NNnrR5nUMNJ1V+JnHjZnEIMhdMCcoDLa3IXB/9PlcJhF0wF9C5g
         fB6okIPyFw3vFwMOk49mv/DUGmObEP9TMcfWvl3iLxKKKcn2vNjg04cD3CxJG0m5myQc
         bXDwbxc8gDUzimClYF3JwjqhipY7koCxIVYoa8KufF67MekHLgKLlU+hrxvwWKViyBjL
         tdJymeDFBLbhWBUp4bBQ78+8UUJrrJ3Svk22RtGrviZwYPDtXMSNTB9PDHnegx0f8Inr
         TmFfuL4cr9q2wpmwiz3RBZmJHFPRs/NC06MSMVpj7SHN9+dzPbxry5YCAdPs2qTZnxpz
         LjPg==
X-Gm-Message-State: AOUpUlHLa/Tr8J1wniqCfDTJUNNuRITqzJk5jhbhh3iNYLG6Y83vvtg4
        +xb0w3RHAaUKgLh66JBBkGGiX/5tZVcPz0+ailr2wg==
X-Google-Smtp-Source: AAOMgpfNX7j/J7hmBYHzkSOpTHrUelco2/uwYrl9e6B+5/DUBeCj5DPJBymzWVcn9KK8L4yFMdZS7WfT2uBbPDQdktg=
X-Received: by 2002:a1c:8b81:: with SMTP id n123-v6mr7679904wmd.142.1531667075756;
 Sun, 15 Jul 2018 08:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <1531557122-12540-1-git-send-email-laoar.shao@gmail.com>
 <CALvZod57QFRVQ7kM4LSNQJACQ+dGC_otJkqK-5+i-0b53Zq5aA@mail.gmail.com>
 <CALOAHbDV73+X-y7V2Z4nX1C7uCY6yzBPTPZhEvTpN3f7_qWwUw@mail.gmail.com>
 <CALvZod5d37v8fv=VCFLa7g+ntPvaT-h8jRQw1+iry2dxb=yXxQ@mail.gmail.com>
 <CALOAHbBQurMrE6ZCLLsdmbqFrUX3vFVpZtFLvvL_WGnPoF0OSA@mail.gmail.com>
 <CALvZod6F4vM_U0obH1aU3iJqRs-3JEfR4cHKZoB9JVLTgdSmSQ@mail.gmail.com> <CALOAHbByKH9t_c266Bi+Kv2r=07LLpa6UEQgsc7BNi2dZoeNhQ@mail.gmail.com>
In-Reply-To: <CALOAHbByKH9t_c266Bi+Kv2r=07LLpa6UEQgsc7BNi2dZoeNhQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 15 Jul 2018 08:04:24 -0700
Message-ID: <CALvZod6SVJQz84sxMkvRY7K4iZ2_uzbmMq85URBznsu7+ZP9OA@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid bothering interrupted task when charge memcg in softirq
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 1:02 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Sun, Jul 15, 2018 at 2:34 PM, Shakeel Butt <shakeelb@google.com> wrote:
> > On Sat, Jul 14, 2018 at 10:26 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >>
> >> On Sun, Jul 15, 2018 at 12:25 PM, Shakeel Butt <shakeelb@google.com> wrote:
> >> > On Sat, Jul 14, 2018 at 7:10 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >> >>
> >> >> On Sat, Jul 14, 2018 at 11:38 PM, Shakeel Butt <shakeelb@google.com> wrote:
> >> >> > On Sat, Jul 14, 2018 at 1:32 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >> >> >>
> >> >> >> try_charge maybe executed in packet receive path, which is in interrupt
> >> >> >> context.
> >> >> >> In this situation, the 'current' is the interrupted task, which may has
> >> >> >> no relation to the rx softirq, So it is nonsense to use 'current'.
> >> >> >>
> >> >> >
> >> >> > Have you actually seen this occurring?
> >> >>
> >> >> Hi Shakeel,
> >> >>
> >> >> I'm trying to produce this issue, but haven't find it occur yet.
> >> >>
> >> >> > I am not very familiar with the
> >> >> > network code but I can think of two ways try_charge() can be called
> >> >> > from network code. Either through kmem charging or through
> >> >> > mem_cgroup_charge_skmem() and both locations correctly handle
> >> >> > interrupt context.
> >> >> >
> >> >>
> >> >> Why do you say that mem_cgroup_charge_skmem() correctly hanle
> >> >> interrupt context ?
> >> >>
> >> >> Let me show you why mem_cgroup_charge_skmem isn't hanling interrupt
> >> >> context correctly.
> >> >>
> >> >> mem_cgroup_charge_skmem() is calling  try_charge() twice.
> >> >> The first one is with GFP_NOWAIT as the gfp_mask, and the second one
> >> >> is with  (GFP_NOWAIT |  __GFP_NOFAIL) as the gfp_mask.
> >> >>
> >> >> If page_counter_try_charge() failes at the first time, -ENOMEM is returned.
> >> >> Then mem_cgroup_charge_skmem() will call try_charge() once more with
> >> >> __GFP_NOFAIL set, and this time if If page_counter_try_charge() failes
> >> >> again the '
> >> >> force' label in  try_charge() will be executed and 0 is returned.
> >> >>
> >> >> No matter what, the 'current' will be used and touched, that is
> >> >> meaning mem_cgroup_charge_skmem() isn't hanling the interrupt context
> >> >> correctly.
> >> >>
> >> >
> >> > Hi Yafang,
> >> >
> >> > If you check mem_cgroup_charge_skmem(), the memcg passed is not
> >> > 'current' but is from the sock object i.e. sk->sk_memcg for which the
> >> > network buffer is allocated for.
> >> >
> >>
> >> That's correct, the memcg if from the sock object.
> >> But the point is, in this situation why 'current' is used in try_charge() ?
> >> As 'current' is not related with the memcg, which is just a interrupted task.
> >>
> >
> > Hmm so you mean the behavior of memcg charging in the interrupt
> > context depends on the state of the interrupted task.
>
> Yes.
>
> > As you have
> > noted, mem_cgroup_charge_skmem() tries charging again with
> > __GFP_NOFAIL and the charge succeeds. Basically the memcg charging by
> > mem_cgroup_charge_skmem() will always succeed irrespective of the
> > state of the interrupted task. However mem_cgroup_charge_skmem() can
> > return true if the interrupted task was exiting or a fatal signal is
> > pending or oom victim or reclaiming memory. Can you please explain why
> > this is bad?
> >
>
> Let me show you the possible issues cause by this behavoir.
> 1.  In mem_cgroup_oom(), some  members in 'current' is set.
>      That means an innocent task will be in  task_in_memcg_oom state.
>      But this task may be in a different memcg, I mean the memcg of
> the 'current' may be differenct with the sk->sk_memcg.
>      Then when this innocent 'current' do try_charge it will hit  "if
> (unlikely(task_in_memcg_oom(current)))" and  -ENOMEM is returned,
> While there're maybe some free memory (or some memory could be freed )
> in the memcg of the innocent 'task'.
>

No memory will be freed as try_charge() is in interrupt context.

> 2.  If the interrupted task was exiting or a fatal signal is  pending
> or oom victim,
>      it will directly goto force and 0 is returned, and then
> mem_cgroup_charge_skmem() will return true.
>      But mem_cgroup_charge_skmem() maybe need to try the second time
> and return false.
>
> That are all unexpected behavoir.
>

Yes, this is inconsistent behavior. Can you explain how this will
affect network traffic? Basically mem_cgroup_charge_skmem() was
supposed to return false but sometime based on the interrupted task,
mem_cgroup_charge_skmem() returns true. How is this behavior bad for
network traffic?

Please note that I am not against this patch. I just want that the
motivation/reason behind it is very clear.

thanks,
Shakeel
