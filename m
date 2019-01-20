Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC02C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046A92085B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JV5L725L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbfATJuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 04:50:00 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34509 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfATJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 04:49:59 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so4681338itd.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 01:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QRhh3MgqkQ+o0iAmITxeFxcHU8KQEzEQmaT6o1rKx0=;
        b=JV5L725LmmE6TtGtFPSQEw5fk363XOS9k3gAU7q7edMh75KyHGzI7+0qmsk/ulbsr4
         7ngw6zTPl6M+rOjT7gSUJYkEPhxDw3ektdCkDd/FLvK2x4xFgiUa8+lukrkmnhlh5RQm
         xp4k0giotbWJ//my4e5A+B2+7LVMvnvkCJL0MH+oJxkUv5sllaoK8VFpmeknyrcphVod
         qfGmXbEh10UfOlv9frt20hu+nEDU2uqPF4WHyfXxPNB001JGAdpN4fPR3BGa7u3dOBiv
         uK/5Nluv3oL5Mfg2LFpO6ay7/4/3jLE1+ID/kMyp+bdl1LpoRDgoe3P2GuywnXd68Arg
         TtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QRhh3MgqkQ+o0iAmITxeFxcHU8KQEzEQmaT6o1rKx0=;
        b=S0MmQQsQp8NNkdkT5pHORhlBOE4w5ssh0BgCLULxjcvngCe6NvobmPgkNUKKwW/e4f
         VDp9Wad0Qv5oijzL3IonwopZp1PBJGGqeMTvcZOJZW6dxXU6x1U8vhAbMrcS1jXSYVkx
         GowUZIIIDNMnkq8W7P1PoGstx9OkUduCaoLkEZNrcVrgBuaEuGyVY9TFO214HgKd3J4j
         eRi6bW2X0cmLz7Y9byrlnJ7tTrqCRL1ZMa+pPLvJBGSG5sRxc83pzh93UfDOKi9JBsdt
         gU4B9IYbTXBqp+Fw45NerBcVOhagY/cy0tJgqwB9lE3cZewjEmiVL5v+XUfTjuE2vjJd
         StVw==
X-Gm-Message-State: AJcUukdcCA/hh9ybe8s4uql7keNqKPKBTW5rZgcorgWgj3E6pZxmGHbM
        Oscgw//WKW5p42j6UyKLEBAEZ8CBPTGF+LVp+fv+zA==
X-Google-Smtp-Source: ALg8bN4T2vmREzVc1W1X4Q9zhYYhykBH5wopxgJA1ubETFQmDlWNqxxnnmbBgzI24F05fZNxDKKFACZPEt37EiBnn6U=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr12827471itl.144.1547977798246;
 Sun, 20 Jan 2019 01:49:58 -0800 (PST)
MIME-Version: 1.0
References: <94eb2c0810d04f5a46055ffc71aa@google.com> <CACT4Y+Y6UhNQOc7VUPgvXZ3yGPusjg2WJ9-OXMCRGM2Q1bx7ZQ@mail.gmail.com>
 <6012a726-069a-13a5-9c8d-6a11730d8414@I-love.SAKURA.ne.jp>
 <468f7418-a02d-79cc-3d94-91bbe146567e@I-love.SAKURA.ne.jp>
 <20180406121411.GJ4082@hirez.programming.kicks-ass.net> <201804062255.HEJ82361.FJOFHVtSLOMOQF@I-love.SAKURA.ne.jp>
 <20180406154343.GK4082@hirez.programming.kicks-ass.net> <20180406155905.GA11697@vader>
 <CACT4Y+ZaL=zPbb-r7PKvOsY8aBRiMEEHMc+-HVGm+dRTax+DfA@mail.gmail.com> <faf9772a-f865-1475-ea0b-f9efb04ea974@i-love.sakura.ne.jp>
In-Reply-To: <faf9772a-f865-1475-ea0b-f9efb04ea974@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 20 Jan 2019 10:49:45 +0100
Message-ID: <CACT4Y+bjNLQB7za=aciTuPnBeCEfn-v7gJFOe7Cc9R4iPYw+sA@mail.gmail.com>
Subject: Re: INFO: task hung in lo_ioctl
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@fb.com>,
        syzbot 
        <bot+abdba5bc6de135d7622f00756da97998425b6de5@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>,
        Hannes Reinecke <hare@suse.de>, shli@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, knikanth@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 3:36 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/01/20 3:56, Dmitry Vyukov wrote:
> >> Seems easy enough to fix without resorting to __mutex_owner() (untested):
> >>
> >>
> >> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> >> index 264abaaff662..cee258d12a1e 100644
> >> --- a/drivers/block/loop.c
> >> +++ b/drivers/block/loop.c
> >> @@ -1300,12 +1300,13 @@ loop_get_status_old(struct loop_device *lo, struct loop_info __user *arg) {
> >>  static int
> >>  loop_get_status64(struct loop_device *lo, struct loop_info64 __user *arg) {
> >>         struct loop_info64 info64;
> >> -       int err = 0;
> >> +       int err;
> >>
> >> -       if (!arg)
> >> -               err = -EINVAL;
> >> -       if (!err)
> >> -               err = loop_get_status(lo, &info64);
> >> +       if (!arg) {
> >> +               mutex_unlock(&lo->lo_ctl_mutex);
> >> +               return -EINVAL;
> >> +       }
> >> +       err = loop_get_status(lo, &info64);
> >>         if (!err && copy_to_user(arg, &info64, sizeof(info64)))
> >>                 err = -EFAULT;
> >>
> >>
> >> I'll test it and send it up when I get into the office.
> >
> >
> > Was this ever submitted? Or some other fix for this?
> >
> > The bug is still open, but last happened 289 days ago:
> > https://syzkaller.appspot.com/bug?id=608144371e7fc2cb6285b9ed871fb1eb817a61ce
> >
> > But it also has 10 duplicates, some of which happened much more recently.
> > If a fix was submitted, but Reported-by tag wasn't added this open bug
> > can now mask lots of other new bugs.
> >
>
> The commit for this specific patch is bdac616db9bbadb9 ("loop: fix LOOP_GET_STATUS
> lock imbalance"). But the root cause of these hung tasks would be fixed by a series
> containing commit 1dded9acf6dc9a34 ("Avoid circular locking dependency between
> loop_ctl_mutex and bd_mutex") or commit 04906b2f542c2362 ("blockdev: Fix livelocks
> on loop device"). We were not aware of these bugs when you marked these reports as
> duplicates on 2017/12/12. You can undup them and fix them if you want.

OK, let's just do then:

#syz fix: blockdev: Fix livelocks on loop device
