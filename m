Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64242C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0808423C21
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="ALL1J2t8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0808423C21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934202AbeFVBjU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:39:20 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35795 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934101AbeFVBjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:39:19 -0400
Received: by mail-qk0-f196.google.com with SMTP id d130-v6so2914894qkc.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 18:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZXrm2QbwUEcIOOlsFuNZkZCtBMd9TXcxicJo9yvprfM=;
        b=ALL1J2t885rqrCN8DJFyqbgWuk9Ns3BoqB/Dos0GG3XqVQU+0T73Vii4atfXqpPCwz
         CAeKr1Fj1OeoVzQnrklv0hPlELnjBPv/u5kYXvrlqyH+Gho5ANxQ2LAI3Z/9mW1yvT3m
         gJm0RCuXviAwyrTmoB+JNDTGPwPGeZ7uXRYx9PevGIXuXD9XeZ3ILJ+FBCL1UydppOYC
         Er+kU3rZ8jzmC3Gp0c8XeyClBCpFJcoqHByINKBgUjTMU0K5aDgiS5+IGkGENUgf66+F
         /igVVksZVqG3PFRcoD67J96aqNVthqIjobb30aTpHTPQ9EGzClh2lW2oJmF3xvvDs983
         YDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZXrm2QbwUEcIOOlsFuNZkZCtBMd9TXcxicJo9yvprfM=;
        b=mCzvtNNNFInhIgKRQWZnbnQ3xqK2qbrOeYXEn/CRZRbqoTFl9lzti8b6BshnbRnuyp
         xeMP1c+Z8PitrKVrZJeSPza93eWU9O6mbv25bnE3RqaAb+3/NYb3tVZ3cpndX1v/zFVH
         IJ/6Kcnxx1oAYEZKQH48BQfoBYnkclr3hyjP669t07X6kL4qaga7pnqdD2VMX/qosmd7
         +cFZETG5/oJRoSAK336lJEOD7uhFXptsWT7aZFNRBIJ6MqPuyzI6ChvTUDxA64aEyFmh
         NOOzC0c6nqwwh5G6zIbO5ODlRI81DmzrkPBvuF0VY+8nW92czUK/cZ1a5eYljuFGDH3p
         EyzA==
X-Gm-Message-State: APt69E0GtE6IDEbTNjmN3KwXa+W+f1kCf40rcroFaqc5JexMQMI10+nj
        c/g4S7WiVC5jZjQBwVq220jjJQ==
X-Google-Smtp-Source: ADUXVKJuNNZ4s5U61cFR8Yek6UWe9cJyBO0hUvHQhoSlNigdJFByCnQTX5XiqpSjygbxavbkfXlmlA==
X-Received: by 2002:a37:6853:: with SMTP id d80-v6mr4158210qkc.218.1529631557973;
        Thu, 21 Jun 2018 18:39:17 -0700 (PDT)
Received: from cisco ([173.38.117.67])
        by smtp.gmail.com with ESMTPSA id f9-v6sm3280043qkb.43.2018.06.21.18.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 18:39:16 -0700 (PDT)
Date:   Thu, 21 Jun 2018 19:39:14 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH v4 1/4] seccomp: add a return code to trap to userspace
Message-ID: <20180622013914.GL3992@cisco>
References: <20180621220416.5412-1-tycho@tycho.ws>
 <20180621220416.5412-2-tycho@tycho.ws>
 <CAG48ez2-vK57HfbRs94YLiz3SVJ7u4tTrxtAmbRepDqk6m-c_A@mail.gmail.com>
 <20180622005829.GK3992@cisco>
 <CAG48ez1Wob-CrbrPfgP_OBoG7zas4bJwFdLFFQLtgQAkj+HEOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1Wob-CrbrPfgP_OBoG7zas4bJwFdLFFQLtgQAkj+HEOQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 03:28:24AM +0200, Jann Horn wrote:
> On Fri, Jun 22, 2018 at 2:58 AM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > On Fri, Jun 22, 2018 at 01:21:47AM +0200, Jann Horn wrote:
> > > On Fri, Jun 22, 2018 at 12:05 AM Tycho Andersen <tycho@tycho.ws> wrote:
> > > [...]
> > > > +
> > > > +static void seccomp_do_user_notification(int this_syscall,
> > > > +                                        struct seccomp_filter *match,
> > > > +                                        const struct seccomp_data *sd)
> > > > +{
> > > > +       int err;
> > > > +       long ret = 0;
> > > > +       struct seccomp_knotif n = {};
> > > > +
> > > > +       mutex_lock(&match->notify_lock);
> > > > +       err = -ENOSYS;
> > > > +       if (!match->has_listener)
> > > > +               goto out;
> > > > +
> > > > +       n.pid = task_pid(current);
> > > > +       n.state = SECCOMP_NOTIFY_INIT;
> > > > +       n.data = sd;
> > > > +       n.id = seccomp_next_notify_id(match);
> > > > +       init_completion(&n.ready);
> > > > +
> > > > +       list_add(&n.list, &match->notifications);
> > > > +       wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
> > > > +
> > > > +       mutex_unlock(&match->notify_lock);
> > > > +       up(&match->request);
> > > > +
> > > > +       err = wait_for_completion_interruptible(&n.ready);
> > > > +       mutex_lock(&match->notify_lock);
> > > > +
> > > > +       /*
> > > > +        * Here it's possible we got a signal and then had to wait on the mutex
> > > > +        * while the reply was sent, so let's be sure there wasn't a response
> > > > +        * in the meantime.
> > > > +        */
> > > > +       if (err < 0 && n.state != SECCOMP_NOTIFY_REPLIED) {
> > > > +               /*
> > > > +                * We got a signal. Let's tell userspace about it (potentially
> > > > +                * again, if we had already notified them about the first one).
> > > > +                */
> > > > +               if (n.state == SECCOMP_NOTIFY_SENT) {
> > > > +                       n.state = SECCOMP_NOTIFY_INIT;
> > > > +                       up(&match->request);
> > > > +               }
> > > > +               mutex_unlock(&match->notify_lock);
> > > > +               err = wait_for_completion_killable(&n.ready);
> > >
> > > Does this mean that when you get a signal that isn't SIGKILL,
> > > wait_for_completion_interruptible() will bail out with -ERESTARTSYS,
> > > but then you hang on this wait_for_completion_killable()? I don't
> > > understand what's going on here. What's the point of using
> > > wait_for_completion_interruptible() when you'll just hang on another
> > > wait on the same "struct completion"?
> >
> > This is the implementation of this suggestion by Andy:
> > https://lkml.org/lkml/2018/3/15/1122
> >
> > The idea is to alert the listener that there was a signal exactly
> > once, in case it's in the middle of processing a request it could bail
> > out and do something else. So the killable wait is intended to ignore
> > other (non-fatal) signals after the first one and wait for whatever
> > the handler decides to do with the signal it received.
> 
> How can the listener tell that a signal arrived? When the first
> non-fatal signal comes in, you just set the state to
> SECCOMP_NOTIFY_INIT if it was SECCOMP_NOTIFY_SENT, right? So the
> listener will potentially see the request twice, but with no
> additional indicator that a signal arrived? And in particular, if the
> listener doesn't read the request before the signal arrives, it will
> only see the request once, just as if it was a normal request with no
> signals involved?

I was thinking just parsing /proc/pid/status (given that people are
already going to be mapping things in /proc/pid/map_files to read
arguments and stuff, I didn't think too much of it),

> Would it perhaps make sense to add a field to struct seccomp_notif
> that indicates whether the notification is for a normal syscall or a
> canceled syscall?

Sure, I'll add a __u32 signal and set it to the value of the signal if
we got one.

Thanks!

Tycho
