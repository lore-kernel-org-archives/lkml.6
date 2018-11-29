Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FC7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C325320863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjfBNbjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C325320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeK3BHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:07:45 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39323 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeK3BHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:07:45 -0500
Received: by mail-yw1-f65.google.com with SMTP id j6so784436ywj.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/jjV9KGWquWLOwtCollysS/p7Dp1rsTMNfcsFZuikHU=;
        b=GjfBNbjGV3galjxtE3pCfF1n4l2nktyw7vwRiOmahMqDnn3Yxhs2R95TDp7uQIBPlp
         ag/JF6XSSJyUjU3bJqDmfPrfudQ0IPIFDYMlw1OkSQAccGWym/k7nG+FRzbMz041gPbJ
         X6hboXpzdZZB+HtK62KagpQxB6J9SFtI2hjPjOg35RE0s8mUuXrZ0wCFSaL5IcK05xPH
         JYrKsg2x8h7qwkbRnce16NLGk826XR/i7tezEI7Bs6ijBU8pYMj7J3i8pRfffzNJTVkn
         ymq57Qcypz6qKGB2HNtuE3j/6ZKQ6ouK+PZrvyo2jk2FL/WnSi2O8NePsyN5V98+LaU2
         hotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jjV9KGWquWLOwtCollysS/p7Dp1rsTMNfcsFZuikHU=;
        b=gJ+ePwQlg0Vg8M3jPh+QChrtC3OMnZZ12aI45yE/zKAY7x85XL/GGFLrJbNy4UVipi
         5Vo4kYyufdx01igeW/6OTx36cDD+eLNHnz8rDt5YyK1ceGN8ulQrADhGTpHvTOQsDOFQ
         ia1mmWgRcV1h1RAJfKoNhVARKq6FyTebZ3Mj3ApNwEQ3J5iyRRSlvNVkqDaiUObj6+3e
         ipPTTkgqqYf1mUCiiFH7+muFjrduN2e7/NaTw9VbsVzR48igkigsn+bMqV7QKxGSaqmg
         3mQGtbAfNPP7xikg9SFEhk/0iyopSrYBiUnAVnKf05HgYnoFQKwSDAfXoPIMnV6oHDT5
         Qs2w==
X-Gm-Message-State: AA+aEWZrTewNPnYWxCkc0vSkjDbWRTXF45f2vrYj8knDg52pRsP/fuD4
        o7fmBfTmgjtrjV+MzhH+kR77DlgaDlBmBbX80W0=
X-Google-Smtp-Source: AFSGD/VayezC3VVX8Q0DtZ4jr0X5i+0jliBZyWRZrD2X/Gulr772HfaeLEJtZeLJMOMrzY7MjzGOVgcSgRKt9/rr3sY=
X-Received: by 2002:a81:a70a:: with SMTP id e10mr1402739ywh.233.1543500137133;
 Thu, 29 Nov 2018 06:02:17 -0800 (PST)
MIME-Version: 1.0
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
 <20181129131232.GN2131@hirez.programming.kicks-ass.net> <20181129134449.GH2149@hirez.programming.kicks-ass.net>
In-Reply-To: <20181129134449.GH2149@hirez.programming.kicks-ass.net>
From:   Yongji Xie <elohimes@gmail.com>
Date:   Thu, 29 Nov 2018 22:02:03 +0800
Message-ID: <CAONzpcaNdKEr8txXT0gx6qyR8rnen-sqX6sxKHUObju3_cLAXg@mail.gmail.com>
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, xieyongji@baidu.com,
        zhangyu31@baidu.com, liuqi16@baidu.com, yuanlinsi01@baidu.com,
        nixun@baidu.com, lilin24@baidu.com, dave@stgolabs.net,
        longman@redhat.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 at 21:45, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 29, 2018 at 02:12:32PM +0100, Peter Zijlstra wrote:
> >
> > +Cc davidlohr and waiman
>
> > Urgh; so the case where the cmpxchg() fails because it already has a
> > wakeup in progress, which then 'violates' our expectation of when the
> > wakeup happens.
> >
> > Yes, I think this is real, and worse, I think we need to go audit all
> > wake_q_add() users and document this behaviour.
> >
> > In the ideal case we'd delay the actual wakeup to the last wake_up_q(),
> > but I don't think we can easily fix that.
>
> See commit: 1d0dcb3ad9d3 ("futex: Implement lockless wakeups"), I think
> that introduces the exact same bug.
>

Hmm...Yes, even the thread may be in futex's wake_q and lead to rwsem's wakeup
missing.

Seems like fix this problem casy by case and document the behaviour is easier
than delay the actual wakeup to the last wake_up_q()...

Thanks,
Yongji

> Something like the below perhaps, altough this pattern seems to want a
> wake_a_add() variant that already assumes get_task_struct().
>
> diff --git a/kernel/futex.c b/kernel/futex.c
> index f423f9b6577e..d14971f6ed3d 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -1387,11 +1387,7 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
>         if (WARN(q->pi_state || q->rt_waiter, "refusing to wake PI futex\n"))
>                 return;
>
> -       /*
> -        * Queue the task for later wakeup for after we've released
> -        * the hb->lock. wake_q_add() grabs reference to p.
> -        */
> -       wake_q_add(wake_q, p);
> +       get_task_struct(p);
>         __unqueue_futex(q);
>         /*
>          * The waiting task can free the futex_q as soon as q->lock_ptr = NULL
> @@ -1401,6 +1397,13 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
>          * plist_del in __unqueue_futex().
>          */
>         smp_store_release(&q->lock_ptr, NULL);
> +
> +       /*
> +        * Queue the task for later wakeup for after we've released
> +        * the hb->lock. wake_q_add() grabs reference to p.
> +        */
> +       wake_q_add(wake_q, p);
> +       put_task_struct(p);
>  }
>
>  /*
