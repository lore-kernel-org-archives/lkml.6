Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32551C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27952178F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ut7Lvj5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27952178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbeHCUzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 16:55:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35165 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHCUzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 16:55:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6-v6so3257369pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rj40mg9Xb51R1c2uuHTuNoY8IlKKEY01gojzJ1OKAL0=;
        b=ut7Lvj5flrqTKo5kvp9V8cPepJcnzyIlVbNGEE+/+I+Y3GJKssZxezNPbnHXcpY1vE
         1FVeDUKMwFjlXc+It5U6g38dXrcYSwG89sIV0vM10Psd1bYQuUZpTqmP3WQPKpxpowzr
         qfAY1wyg4uNWwzEpGDMnkbxil2tTbVS7kOa1SqPIN2bbeUU9WY0MHiSdGcSzlGSmCkUj
         DNQiemln766XEeAstfQbJIiVrC3RNdM+MatxGWF4TpyLPhi5xocb6bCTkqpqVbHTyhmJ
         0cUPImzl7A0oSwSfeppT4wm8Bdpr88IG0a3kEAvUgvIksTqHddgcNDG2tBZB2eN1fQsY
         OZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rj40mg9Xb51R1c2uuHTuNoY8IlKKEY01gojzJ1OKAL0=;
        b=HvWFWNon+SILAc2ADBNz+N1H/Jo8vWgDSQj89H6VKfZgCvO/rAiR3zxzkmo2pXmXg/
         pUMRh206pXGkIn6hJ+4FkY0TJ3Idt4PFRPviZj45w8Y6Q8kyOQeVYpi0i4BPN/OvnKQ/
         AR2IQMM324q70ZByqsMP51b3UENukZjEA+cuS8JKLWAvIJ/JcWpfHK19/vQLJzRR0JQ/
         IJ1622WJbtjFznP1v3/ke0d1e/wV5ZNq5NNoSffJohSJ3RyNckePFgkF2K/DnSfApAzX
         YBrzctUS8S8SU5gEKkovbFBw7kp4c1krCud8YjLuZbqOPuCWq16/6Aet/3ZE1yjKMxPI
         5+0Q==
X-Gm-Message-State: AOUpUlEu3SQMzdZTTYKckoNKjHd+XrAg9NIwso+R0bb6TpxjlS2UK2fI
        SAXVysQ7mRlmG4r5GnpKpUzzI91/JzQy+2a2/yE=
X-Google-Smtp-Source: AAOMgpd/XIcoZRmGS125NIaZBb3blj4vU0yJFgYOLkVlueHh7rNt+qoaNPysTGSNcN/f0LNMLRKDPZbhAG7rxU81Cgw=
X-Received: by 2002:a62:3545:: with SMTP id c66-v6mr5837945pfa.63.1533322663970;
 Fri, 03 Aug 2018 11:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180728002409.5781-1-xiyou.wangcong@gmail.com>
 <ef0e1185-51d6-0707-cda4-6f2ea987b651@linux.alibaba.com> <CAM_iQpVeK2VQDuahreZC2-L4eEzx0WtD8Bz=oHH68VSAiMqLGQ@mail.gmail.com>
 <fad5ebe6-ec49-c67b-7b4f-78a413723aa8@linux.alibaba.com> <xm26ftzz8h0r.fsf@bsegall-linux.svl.corp.google.com>
 <CAM_iQpXGCqo9AAp2kpSKk9sHx0ZRK7JU_c07sWh4vR9kFQ+LxA@mail.gmail.com> <0939a9c3-e9c0-ae8a-3f56-0dde1ab2fc8e@linux.alibaba.com>
In-Reply-To: <0939a9c3-e9c0-ae8a-3f56-0dde1ab2fc8e@linux.alibaba.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 3 Aug 2018 11:57:31 -0700
Message-ID: <CAM_iQpVkU9Qf_V+DvUuqxLqsiGN=Qg+Uyt1Kpiu5HuQVRi=KqQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: sync expires_seq in distribute_cfs_runtime()
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Ben Segall <bsegall@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 8:24 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>
> Let's see the unthrottle cases.
> 1. for the periodic timer
> distribute_cfs_runtime updates the throttled cfs_rq->runtime_expires to
> be a new value, so expire_cfs_rq_runtime does nothing because of:
>   rq_clock(rq_of(cfs_rq)) - cfs_rq->runtime_expires < 0
>
> Afterwards assign_cfs_rq_runtime() will sync its expires_seq.

Is there any guarantee rq_clock(cfs_rq) is always ahead of
cfs_rq->runtime_expires in this case?

I doubt, because cfs_rq->runtime_expires could be assigned
by a sched_clock() on a different CPU running the periodic timer.

Also, rq_clock() is behind sched_clock() on the same CPU too,
sometimes it is merely hundreds of nanoseconds, sometimes it is
tens of thousands nanoseconds in my environment. (I have a
different patch to address this, but still not sure if it is correct.)


>
> 2. for the slack timer
> the two expires_seq should be the same, so if clock drift happens soon,
> expire_cfs_rq_runtime regards it as true clock drift:
>   cfs_rq->runtime_expires += TICK_NSEC
> If it happens that global expires_seq advances, it also doesn't matter,
> expire_cfs_rq_runtime will clear the stale expire_cfs_rq_runtime as
> expected.

Hmm, looks like due to the runtime_refresh_within() check in
slack timer.



>
> >
> >>
> >> Nothing /important/ goes wrong because distribute_cfs_runtime only fills
> >> runtime_remaining up to 1, not a real amount.
> >
> > No, runtime_remaining is updated right before expire_cfs_rq_runtime():
> >
> > static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
> > {
> >         /* dock delta_exec before expiring quota (as it could span periods) */
> >         cfs_rq->runtime_remaining -= delta_exec;
> >         expire_cfs_rq_runtime(cfs_rq);
> >
> > so almost certainly it can't be 1.
>
> I think Ben means it firstly gets a distributtion of 1 to run after
> unthrottling, soon it will have a negative runtime_remaining, and go
> to assign_cfs_rq_runtime().

That is obvious, being 1 in distribute_cfs_runtime is not relevant to the
discussion here.
