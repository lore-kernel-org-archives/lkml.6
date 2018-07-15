Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C2EECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 06:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B542420870
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 06:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORzhQntN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B542420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeGOG4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 02:56:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37523 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeGOG4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 02:56:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so28747232wrd.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 23:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmIuNlja9tDzGR6QcBr5a9H/E35pQe2boNboyM5YycU=;
        b=ORzhQntNnL8Cg1RLJTfCjISxzkZ7XFqWOD9ibmB9SkmlNY40airbQGtHlTpk4QR2jM
         yOT62OWBsPdwpcfMjJGwFLG4HPNYd/5yi6zkWzi0joSkOsMH5iNG8HNy1smVEBOcnR6M
         ACHy97RO1Jfd9iKoeXL3lZV5p/APZheaO+WYIfg82a7uM3Ip3eWAfIA++Ta+XhBHA6q0
         pOK6uIwcueNjvEZvS6LkkttpzzKnN7c26Nt8L2Z8JelG4bKUC7U6JvLrqupssbtXuMoo
         YzShq2ZmkVpweDc8a/8uL2oNGbKyZIrnUaaX2qvEmsY0LXDXLTdRTwoVlXu9uS+WexMo
         YkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmIuNlja9tDzGR6QcBr5a9H/E35pQe2boNboyM5YycU=;
        b=LueG0dKCOcdfm0QWKeqW5U1KsxYgJZVhw5zfq6hvSnzWn6rcxMlSwG28fFIMMHFYUR
         H3ql1gNMSMwtQdDmugT6BSqyXKUtkUn4NBzSc7CvMJa4DWlwp4tRu5Y88r5hR/qozdzC
         NPC+TMsHREFFz8n1ldTGKMj1oRIC5V2/baNV1Xa5IQjpH4cm0bdvsMbmIVVEcTgeZsYC
         PEzPCqdV9BF4eZWYu7UH3fQJvI6Ak3i1jozeFUkQQPvK9F8IxLlgIvzmKdVE8YzlDbEB
         oEVJxFuhKvGXJYUcI4L4h+vHrh07L8M5xCvNSU9tPMEBOPet42GGfvtSkqh/FkXquvU5
         rrNw==
X-Gm-Message-State: AOUpUlHxmLlKRP54K5P1xwdnyPXR/NR7boQXFPrANVcfKlIUQ8m4wee4
        6xBWyV+ugudVVHMuHlyYNg/9cx4PqwqpZI7N2cd6ow==
X-Google-Smtp-Source: AAOMgpeDn/nike91oYQud8mWMhV4yTWS8bpFy6DsU0BbO86sQgogEiDX1RFIf24IBtswE9JcB14v1A89Zv/XBP+c3dY=
X-Received: by 2002:a5d:4a07:: with SMTP id m7-v6mr9699921wrq.8.1531636482885;
 Sat, 14 Jul 2018 23:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <1531557122-12540-1-git-send-email-laoar.shao@gmail.com>
 <CALvZod57QFRVQ7kM4LSNQJACQ+dGC_otJkqK-5+i-0b53Zq5aA@mail.gmail.com>
 <CALOAHbDV73+X-y7V2Z4nX1C7uCY6yzBPTPZhEvTpN3f7_qWwUw@mail.gmail.com>
 <CALvZod5d37v8fv=VCFLa7g+ntPvaT-h8jRQw1+iry2dxb=yXxQ@mail.gmail.com> <CALOAHbBQurMrE6ZCLLsdmbqFrUX3vFVpZtFLvvL_WGnPoF0OSA@mail.gmail.com>
In-Reply-To: <CALOAHbBQurMrE6ZCLLsdmbqFrUX3vFVpZtFLvvL_WGnPoF0OSA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 14 Jul 2018 23:34:30 -0700
Message-ID: <CALvZod6F4vM_U0obH1aU3iJqRs-3JEfR4cHKZoB9JVLTgdSmSQ@mail.gmail.com>
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

On Sat, Jul 14, 2018 at 10:26 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Sun, Jul 15, 2018 at 12:25 PM, Shakeel Butt <shakeelb@google.com> wrote:
> > On Sat, Jul 14, 2018 at 7:10 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >>
> >> On Sat, Jul 14, 2018 at 11:38 PM, Shakeel Butt <shakeelb@google.com> wrote:
> >> > On Sat, Jul 14, 2018 at 1:32 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >> >>
> >> >> try_charge maybe executed in packet receive path, which is in interrupt
> >> >> context.
> >> >> In this situation, the 'current' is the interrupted task, which may has
> >> >> no relation to the rx softirq, So it is nonsense to use 'current'.
> >> >>
> >> >
> >> > Have you actually seen this occurring?
> >>
> >> Hi Shakeel,
> >>
> >> I'm trying to produce this issue, but haven't find it occur yet.
> >>
> >> > I am not very familiar with the
> >> > network code but I can think of two ways try_charge() can be called
> >> > from network code. Either through kmem charging or through
> >> > mem_cgroup_charge_skmem() and both locations correctly handle
> >> > interrupt context.
> >> >
> >>
> >> Why do you say that mem_cgroup_charge_skmem() correctly hanle
> >> interrupt context ?
> >>
> >> Let me show you why mem_cgroup_charge_skmem isn't hanling interrupt
> >> context correctly.
> >>
> >> mem_cgroup_charge_skmem() is calling  try_charge() twice.
> >> The first one is with GFP_NOWAIT as the gfp_mask, and the second one
> >> is with  (GFP_NOWAIT |  __GFP_NOFAIL) as the gfp_mask.
> >>
> >> If page_counter_try_charge() failes at the first time, -ENOMEM is returned.
> >> Then mem_cgroup_charge_skmem() will call try_charge() once more with
> >> __GFP_NOFAIL set, and this time if If page_counter_try_charge() failes
> >> again the '
> >> force' label in  try_charge() will be executed and 0 is returned.
> >>
> >> No matter what, the 'current' will be used and touched, that is
> >> meaning mem_cgroup_charge_skmem() isn't hanling the interrupt context
> >> correctly.
> >>
> >
> > Hi Yafang,
> >
> > If you check mem_cgroup_charge_skmem(), the memcg passed is not
> > 'current' but is from the sock object i.e. sk->sk_memcg for which the
> > network buffer is allocated for.
> >
>
> That's correct, the memcg if from the sock object.
> But the point is, in this situation why 'current' is used in try_charge() ?
> As 'current' is not related with the memcg, which is just a interrupted task.
>

Hmm so you mean the behavior of memcg charging in the interrupt
context depends on the state of the interrupted task. As you have
noted, mem_cgroup_charge_skmem() tries charging again with
__GFP_NOFAIL and the charge succeeds. Basically the memcg charging by
mem_cgroup_charge_skmem() will always succeed irrespective of the
state of the interrupted task. However mem_cgroup_charge_skmem() can
return true if the interrupted task was exiting or a fatal signal is
pending or oom victim or reclaiming memory. Can you please explain why
this is bad?

Shakeel
