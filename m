Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E2FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF622089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJHN50J2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfAGRSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:18:51 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42384 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfAGRSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:18:51 -0500
Received: by mail-oi1-f194.google.com with SMTP id w13so929151oiw.9;
        Mon, 07 Jan 2019 09:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09u//zL7URWGZa65o6V5MzeZW8U394vnK4ViVebK/Z0=;
        b=fJHN50J21ocULzw5SQKZ/6JkVmaIiXRG0+a4cx+txTqjYlf73nyZzp1VWVrnqPddSQ
         mQJUct6fzftHPy9JYJxMYm+0/9sfQX3ulBCwvym1k5zUli6aOPjAXvGYu7tycFK9CnnK
         XM6/ORoqs+RCBvBDw9uozMJX53g5SOC+31b3lq1n5QbLm5k1QKQwLk/F7chGi/u/Elju
         ztBWeT5Tf3yMbXsN5OFZm9YhWhk6zotEY4D6K5DlcZIb4J/H2L7wTHASrVWi7br+wFDE
         djxSp36fJxz0KLZ5oYnH975d1ICJpn7yP7pHzGYqhJjpnwx4kunp2FdlyYBvpZYxjhJ5
         5L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09u//zL7URWGZa65o6V5MzeZW8U394vnK4ViVebK/Z0=;
        b=ezkfV7Vr283ErHTv9RAB/bCmifYOpQskcvSSouCR5Pz+JiVtDpLQDiEigL2HZ8fwsp
         JA4Nb4LPIuT7jify5xlv2mZheCmeht3hvVQ5ADzji5OqUZZoLT+W6VR1Ewgg+HXhK34s
         dIS3eB04SjFOoMm4L4HYqgPQYc1ZMM+Fqx+JHCe4HX3LfjhBSuNTk22X4y+HwVpmNr7X
         xLnIIwwMkKUO7+7ryMcofk74RVoUBSTR/thFECifJsgjPK7dYLbz1kRerheKBS5sRe+g
         XmpdnuSgg2o12p9g9i1vpTn4NkbWYQUvo9k7UA9xG18v+kbhzo0MHJ7pKAIPoxHcaUWo
         FCuA==
X-Gm-Message-State: AA+aEWbDi3NjYIeTmin+WF67t/e2f3iMHo9JSnhmb0ddtZvxbH+rEzK1
        fdbvyMJDv99wP2fKYgme6dLWazU42Jw0aooTDCL22w==
X-Google-Smtp-Source: AFSGD/UFo2FmV/AM051FSAMB/1lcnOBNqPngz8dtF1TaE5LJUACD588Eafy+8z7Rpim4TIS4Bp7RqbGmz2BGr1H4aBU=
X-Received: by 2002:aca:d4d7:: with SMTP id l206mr43859461oig.320.1546881530597;
 Mon, 07 Jan 2019 09:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20190107121014.13499-1-ap420073@gmail.com> <20190107.072507.2123333109511407402.davem@davemloft.net>
In-Reply-To: <20190107.072507.2123333109511407402.davem@davemloft.net>
From:   Taehee Yoo <ap420073@gmail.com>
Date:   Tue, 8 Jan 2019 02:18:38 +0900
Message-ID: <CAMArcTVAWYBYhEwaWT0qZfo2=6p-OBqVvGqMHKj2wtkv8am-GA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/4] umh: add exit routine for UMH process
To:     David Miller <davem@davemloft.net>
Cc:     Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 at 00:25, David Miller <davem@davemloft.net> wrote:
>
> From: Taehee Yoo <ap420073@gmail.com>
> Date: Mon,  7 Jan 2019 21:10:14 +0900
>
> > @@ -679,6 +688,29 @@ static int proc_cap_handler(struct ctl_table *table, int write,
> >       return 0;
> >  }
> >
> > +void exit_umh(struct task_struct *tsk)
> > +{
> > +     struct umh_info *info;
> > +     pid_t pid = tsk->pid;
> > +
> > +     if (!(tsk->flags & PF_UMH))
> > +             return;
>
> Let's really make this low cost.
>
> In linux/sched.h or similar:
>
> void __exit_umh(struct task_struct *tsk);
>
> static inline void exit_umh(struct task_struct *tsk)
> {
>         if (unlikely(tsk->flags & PF_UMH))
>                 __exit_umh(tsk);
> }
>
> Thank you.

Thanks a lot for the review!

I will send a v4 patch.
