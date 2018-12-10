Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD9DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B2120672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI8BAOgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B2120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeLJPNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:13:06 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41490 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeLJPNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:13:05 -0500
Received: by mail-yb1-f194.google.com with SMTP id e124so2876495ybb.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/yy2G9dlZwxfRkg/hFlgGrwjKjRU+KlUFGUUaVaTZCg=;
        b=SI8BAOgU1vt7oYSzbYjXfYK0rJggq0W67yDGv3Llr82RHR9Q1XvEYiNvl9JzZgNK8Q
         rD5NfYjd0GBXPjtLHbsCJCHKWhrvWSvijcsV6VoTy5Msf3h5hMstHGvkJANj+K/XSxTX
         P2/IV5AqIY1G/L59jjud4YpI0cFZtBXuYG80a/iYZzQk00P2DlNeEAzXjYzIiE/RTWH+
         eGDPpc1+kdIqFPEnNTYEABKORu/8ww6mVG8VKGy9dbw1uC0fDgokHVrBkOpxpXzPsuaL
         z7AnKp1wrT8m7jKfrEbwfclCBkeve71YG0t9kB4m9gcEd8YfLVxudzEAFOpPIxERm6dn
         59Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/yy2G9dlZwxfRkg/hFlgGrwjKjRU+KlUFGUUaVaTZCg=;
        b=NCDiJYwpUQwvp2Je5yBvXj0FyWGA1y6LhHB+yhv1gL+0oXoLVZv9Ear22n3IspVfZ0
         0NGL5SDvhlrUAPbLL40n20Rz5eGrsjavAfBXgPqaB7cv93dA9kP4K24YA0jeQGa+b7D4
         Xe6cau4/T5wsgYD15aS0jXVO9ST4KIMRjnyI0phS9tqI+1r67k1uxui0dPdmunrl7tMm
         mtegzHovGG6xQRS0agTux+DU9+NYUX8FzvU42p4kOawA3TIcYxij7F+/9cNACRhFKf4Q
         /Se1krdTjAqBQRywvpg8KBV2oLEq0XrdGcrTYJnJbdCmluxL9MfP+eY/ZHF+I/oYXk/B
         tpQw==
X-Gm-Message-State: AA+aEWa1HwwoU7YzssKahhDpA7Fm/uomLuIHWz7i8Wf0U/JB4W3zRLiY
        dxUDPuZajWRZI8NGiuz6FPrABgWJvJL+OrUxJas=
X-Google-Smtp-Source: AFSGD/XDs6b6Pq4hEwgspO/FtXGx1z/H3WqNdH1TYfXjOr1Kd3A5mk/XWtbqr2vYHAbbD8T2zVUH4Mg+ltklWKTExf4=
X-Received: by 2002:a25:c887:: with SMTP id y129-v6mr12039568ybf.264.1544454784105;
 Mon, 10 Dec 2018 07:13:04 -0800 (PST)
MIME-Version: 1.0
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
 <20181129131232.GN2131@hirez.programming.kicks-ass.net> <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
 <20181129160627.GU2131@hirez.programming.kicks-ass.net> <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net> <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com> <20181129213017.v3eljor54lfpoug2@linux-r8p5>
 <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5> <20181129221714.GF11632@hirez.programming.kicks-ass.net>
In-Reply-To: <20181129221714.GF11632@hirez.programming.kicks-ass.net>
From:   Yongji Xie <elohimes@gmail.com>
Date:   Mon, 10 Dec 2018 23:12:52 +0800
Message-ID: <CAONzpcZ_kQ0cwit+d5uL=v2SqwP=Fo0WSihdCr23uKCAFAhTbQ@mail.gmail.com>
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
To:     peterz@infradead.org
Cc:     dave@stgolabs.net, mingo@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@baidu.com>,
        zhangyu31@baidu.com, liuqi16@baidu.com, yuanlinsi01@baidu.com,
        nixun@baidu.com, lilin24@baidu.com, longman@redhat.com,
        andrea.parri@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 at 06:17, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 29, 2018 at 01:34:21PM -0800, Davidlohr Bueso wrote:
> > I messed up something such that waiman was not in the thread. Ccing.
> >
> > > On Thu, 29 Nov 2018, Waiman Long wrote:
> > >
> > > > That can be costly for x86 which will now have 2 locked instructions.
> > >
> > > Yeah, and when used as an actual queue we should really start to notice.
> > > Some users just have a single task in the wake_q because avoiding the cost
> > > of wake_up_process() with locks held is significant.
> > >
> > > How about instead of adding the barrier before the cmpxchg, we do it
> > > in the failed branch, right before we return. This is the uncommon
> > > path.
> > >
> > > Thanks,
> > > Davidlohr
> > >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 091e089063be..0d844a18a9dc 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -408,8 +408,14 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
> > >      * This cmpxchg() executes a full barrier, which pairs with the full
> > >      * barrier executed by the wakeup in wake_up_q().
> > >      */
> > > -   if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL))
> > > +   if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL)) {
> > > +           /*
> > > +            * Ensure, that when the cmpxchg() fails, the corresponding
> > > +            * wake_up_q() will observe our prior state.
> > > +            */
> > > +           smp_mb__after_atomic();
> > >             return;
> > > +   }
>
> So wake_up_q() does:
>
>   wake_up_q():
>         node->next = NULL;
>         /* implied smp_mb */
>         wake_up_process();
>
> So per the cross your variables 'rule', this side then should do:
>
>   wake_q_add():
>         /* wake_cond = true */
>         smp_mb()
>         cmpxchg_relaxed(&node->next, ...);
>
> So that the ordering pivots around node->next.
>
> Either we see NULL and win the cmpxchg (in which case we'll do the
> wakeup later) or, when we fail the cmpxchg, we must observe what came
> before the failure.
>
> If it wasn't so damn late, I'd try and write a litmus test for this,
> because now I'm starting to get confused -- also probably because it's
> late.
>

Hi Peter,

Please let me know If there is any progress on this issue. Thank you!

Thanks,
Yongji
