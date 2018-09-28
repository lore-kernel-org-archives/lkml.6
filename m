Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64408C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C45206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="udrTHRWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C45206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeI2E2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:28:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46228 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeI2E2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:28:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id d8-v6so5149695pfo.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DEpx5TG66rcd4Z2ytd18XX/tOyyZDkshRv3fyOh2Nhk=;
        b=udrTHRWlBJGnPnqJKHivAZau1tHBKUyNW3vlgWma06MjqtPssVF3PjDI8EpIkPPCCc
         mPrVh8U4O7P10OpXRI3KrkZmFER8/SxeSTCm0CmC6Mc80IimlBEqvHVd5Eqr2pnxUg2k
         +UTDhquYQ3M1HEzz/DRcIjbXrXVA2vZFE7FJy6wEE6hziSCxMmabyoVnCKbNYx/rWL7c
         hzJqUf03Ct92zmiTgoLM3DUR0ffU3ZgI4Uv/oG3gjkw+B3Fi2FMyQSVTdsbE2CAB7G8f
         1ehnxYFoCIHwJfflknGvSa1oQMUM8s+U893o7ziDK1HrMENC9A2NqVZuTszueyImi+3D
         EwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DEpx5TG66rcd4Z2ytd18XX/tOyyZDkshRv3fyOh2Nhk=;
        b=OxqGJlblfhhHOC6iZJJteZ9fpOrTLt5ETRaoJTo+JiHgPAadrOghmnyQTTKbkJQsBT
         vOJqeegzKINxbAXRbhObxG94aLT7YIaUFFZyQPQE2IiJkZONSJKFyJ2D05C7BaIfMq2Y
         T3Bbnv4VaCAtl/ThFYqx2bN2MAS1lw+JJIcDl0lUn7cZT1yBx5YozZ+OXXPZDmVKMQTI
         l7CZG1kFSdO2Ezt8W1RFs+sZurwB7dmWDoO+qXgNUAXrOzFaEmKz9iSZubbAuLx4rDey
         oz2lLb2Kmjb0Cu9Ed+Y3DsXrEi58wk4N+XWkr1lEdhLDorHm93qH3uYyikzMYoGglLtD
         L7PQ==
X-Gm-Message-State: ABuFfogYnh/IzW/L5DAUuyqaiRM59NQ2S246ZkuZsiwFdLrogyQCeC11
        gmZXV5Ri4qnqUcjo7RFKxLftug==
X-Google-Smtp-Source: ACcGV60/lAkWQr0S1MYTyOT96uQhEFw3up52kLQjJKK6u9Qrsk+hWOupWS4oxONJ3Jb4fP0dYykFFw==
X-Received: by 2002:a62:52cc:: with SMTP id g195-v6mr488883pfb.241.1538172166265;
        Fri, 28 Sep 2018 15:02:46 -0700 (PDT)
Received: from cisco.lan ([128.107.241.171])
        by smtp.gmail.com with ESMTPSA id k3-v6sm15483040pfk.60.2018.09.28.15.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 15:02:45 -0700 (PDT)
Date:   Fri, 28 Sep 2018 16:02:43 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 3/3] seccomp: introduce read protection for struct seccomp
Message-ID: <20180928220243.GE18045@cisco.lan>
References: <20180928154648.6320-1-tycho@tycho.ws>
 <20180928154648.6320-3-tycho@tycho.ws>
 <CAG48ez2h51s1VG8hf1ASHHq88r5b+6rS4nSkgvre77jgsJLbhg@mail.gmail.com>
 <20180928205652.GC18045@cisco.lan>
 <CAG48ez1CpPmk6BFOztA-=w1U-pvaNBXou6JpcfMKx_ELGSwDVA@mail.gmail.com>
 <20180928213557.GD18045@cisco.lan>
 <CAG48ez18dg1dZ-jDQjDQ6zmo7R54SHJYYAZpunFLojOChwZ=9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez18dg1dZ-jDQjDQ6zmo7R54SHJYYAZpunFLojOChwZ=9g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 11:54:22PM +0200, Jann Horn wrote:
> On Fri, Sep 28, 2018 at 11:36 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > On Fri, Sep 28, 2018 at 11:10:48PM +0200, Jann Horn wrote:
> > > On Fri, Sep 28, 2018 at 10:56 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > >
> > > > On Fri, Sep 28, 2018 at 10:33:34PM +0200, Jann Horn wrote:
> > > > > On Fri, Sep 28, 2018 at 5:47 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > > > > As Jann pointed out, there is a race between SECCOMP_FILTER_FLAG_TSYNC and
> > > > > > the ptrace code that can inspect a filter of another process. Let's
> > > > > > introduce read locking into the two ptrace accesses so that we don't race.
> > > > >
> > > > > Hmm. Is that true? The ptrace code uses get_nth_filter(), which holds
> > > > > the siglock while grabbing the seccomp filter and bumping its
> > > > > refcount. And TSYNC happens from seccomp_set_mode_filter(), which
> > > > > takes the siglock. So this looks okay to me?
> > > >
> > > > Oh, yes, you're right. So I guess we should just change the comment to
> > > > say we're using siglock to represent the read lock.
> > >
> > > Hmm... actually, looking at this closer, I think you only need the
> > > siglock for writing. As far as I can tell, any read (no matter if
> > > current or non-current) can just use READ_ONCE(), because once a
> > > seccomp filter is in a task's seccomp filter chain, it can't be freed
> > > until the task reaches free_task() and calls put_seccomp_filter() from
> > > there. And if the task whose seccomp filter you're trying to read can
> > > reach free_task(), you have bigger problems.
> >
> > Ok; looks like get_nth_filter() took the siglock anyway. Since we get
> > the filters in these two functions in get_nth_filter(), I think it's
> > enough just to just,
> >
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index f65d47650ac1..79d833ed4c34 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -1001,7 +1001,7 @@ static struct seccomp_filter *get_nth_filter(struct task_struct *task,
> >                 return ERR_PTR(-EINVAL);
> >         }
> >
> > -       orig = task->seccomp.filter;
> > +       orig = READ_ONCE(task->seccomp.filter);
> >         __get_seccomp_filter(orig);
> >         spin_unlock_irq(&task->sighand->siglock);
> 
> Huh? Now you're holding the siglock *and* you're using READ_ONCE()?
> I'm not sure what you're trying to accomplish here.

Yes, let's just drop this patch all together.

Tycho
