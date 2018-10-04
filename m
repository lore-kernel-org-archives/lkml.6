Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA4BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEFC21479
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJVG2WuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEFC21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeJECk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:40:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37057 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeJECk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:40:26 -0400
Received: by mail-io1-f66.google.com with SMTP id m16-v6so4691311ioj.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1CW1xtYMnKRE2dEASH2cpWl7IqrCtBVvjiSx7+lGCdg=;
        b=vJVG2WuXvdjUgiwoVAeFlHw2UWkNhA086gz1E7K9wYo5eT00pXxDX3kBX5lQePcrwG
         7+J3zjsuzND7UywJHxodMNVXuYkLOcuwZIkJ3brSIgkyj4sFBbRaFi6V34FR5kamku0M
         GpHYeFeHifqaqp18TmUHfvGMohPJxgNpX6Z3QKTAju8vzHydhX38mwbIP7DsLmNVn9s6
         ZV0sc8I0aq9XMsOg7EaxtQ9vw31JgpWgTssHkY8Ecl0TQuVKOGOVwu1HhYJL3ik3tm/H
         M7IJlHAQRzD11f6C0zW0RKgbJsoUskmpdB46iVLkZHCnnhc4R6c9ZojobttdxheLAk03
         PFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1CW1xtYMnKRE2dEASH2cpWl7IqrCtBVvjiSx7+lGCdg=;
        b=nLCK10Fmmy2ZYiHiE2CJrDUaTNbVrNUsdwTQPpNMPw4nha/qp92z18/pYBjKHtITNo
         Bcky09pFfRfl6Lv69y3a1bflZScCZqKggZ7+HtZyWVAC4GyVbAAFK3aJ9SyiJh5x3BMg
         fktf3Zd1ePe/RqUcJ1E0+dnK2A1nimk/vgpPX3TMxIZ4NEB8ZdEIzfgyYRfnKNcKWSEq
         IwW16+3VStKA2CMtGMglzPw1UMbRzyOUfCPdjlREJoD9zs2gjqWHYjhagkB7J7ZEN7/7
         a5tJUhXizkdJ64hfJFXVw/KBf6yrYHfR5KVcgCI7a50HTJmAwC82WOrsFIOIERb11rIK
         UTSQ==
X-Gm-Message-State: ABuFfogzCScStE8tTkyX3xOmHj9grhb2Lbhz8jIYr9MEU5cEubibfYbJ
        OnMLKLlWDiWdfo7fUMiTANfL+/LT4SGPPfI/UvzRSg==
X-Google-Smtp-Source: ACcGV60d2Djlr/xzk4r2bnSlqYQUYZLHh3stCrBSaAEaxw8HpZb//46GqRLoluSA+6+GLuKHSmeJzQdso5UePSC4UO0=
X-Received: by 2002:a6b:500e:: with SMTP id e14-v6mr6126487iob.73.1538682340750;
 Thu, 04 Oct 2018 12:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181004154749.111595-1-edumazet@google.com> <20181004185949.GA233675@dtor-ws>
 <CANn89iJMhGEkw13KrGbqrvGbznb45QZwdr7eLy_rUV6zitvs=Q@mail.gmail.com> <30074728-D1C4-46D4-8BF5-6AB8ECAE3EBD@gmail.com>
In-Reply-To: <30074728-D1C4-46D4-8BF5-6AB8ECAE3EBD@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 4 Oct 2018 12:45:29 -0700
Message-ID: <CANn89i+Xoyjrjg_XcwAj9G7KP7CXt+CvpJ38Bj4O53j3sac4Xw@mail.gmail.com>
Subject: Re: [PATCH] Input: mousedev - add a schedule point in mousedev_write()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-input@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 12:38 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On October 4, 2018 12:28:56 PM PDT, Eric Dumazet <edumazet@google.com> wrote:
> >On Thu, Oct 4, 2018 at 11:59 AM Dmitry Torokhov
> ><dmitry.torokhov@gmail.com> wrote:
> >>
> >> Hi Eric,
> >>
> >> On Thu, Oct 04, 2018 at 08:47:49AM -0700, Eric Dumazet wrote:
> >> > syzbot was able to trigger rcu stalls by calling write()
> >> > with large number of bytes.
> >> >
> >> > Add a cond_resched() in the loop to avoid this.
> >>
> >> I think this simply masks a deeper issue. The code fetches characters
> >> from userspace in a loop, takes a lock, quickly places response in an
> >> output buffer, and releases interrupt. I do not see why this should
> >> cause stalls as we do not hold spinlock/interrupts off for extended
> >> period of time.
> >>
> >> Adding Paul so he can straighten me out...
> >>
> >
> >Well...
> >
> >write(fd, buffer, 0x7FFF0000);
> >
> >Takes between 20 seconds and 2 minutes depending on CONFIG options ....
>
> That's fine even if it takes a couple of years. We are not holding spinlock for the entirety of this time, so we should get bumped off CPU at some point.

Well, you are saying that we could get rid of all cond_resched() calls
in the kernel.

You should send patches asap ;)

>
> >
> >So either apply my patch, or add a limit on the max count, and
> >possibly break legitimate user space ?
>
> Legitimate users write a single character at a time and read response, so exciting after, let's say, 32 bytes would be fine. But I still want to understand why we have to do that.
>
> >
> >I dunno...
> >
> >> >
> >> > Link: https://lkml.org/lkml/2018/8/23/1106
> >> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >> > Reported-by: syzbot+9436b02171ac0894d33e@syzkaller.appspotmail.com
> >> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> > Cc: linux-input@vger.kernel.org
> >> > ---
> >> >  drivers/input/mousedev.c | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
> >> > index
> >e08228061bcdd2f97aaadece31d6c83eb7539ae5..412fa71245afe26a7a8ad75705566f83633ba347
> >100644
> >> > --- a/drivers/input/mousedev.c
> >> > +++ b/drivers/input/mousedev.c
> >> > @@ -707,6 +707,7 @@ static ssize_t mousedev_write(struct file
> >*file, const char __user *buffer,
> >> >               mousedev_generate_response(client, c);
> >> >
> >> >               spin_unlock_irq(&client->packet_lock);
> >> > +             cond_resched();
> >> >       }
> >> >
> >> >       kill_fasync(&client->fasync, SIGIO, POLL_IN);
> >> > --
> >> > 2.19.0.605.g01d371f741-goog
> >> >
> >>
> >> Thanks.
> >>
> >> --
> >> Dmitry
>
>
> Thanks.
>
> --
> Dmitry
