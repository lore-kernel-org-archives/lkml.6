Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EFE72C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9882084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="YeOURg+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9882084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934852AbeFLXQU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:16:20 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44056 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934322AbeFLXQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:16:17 -0400
Received: by mail-pl0-f65.google.com with SMTP id z9-v6so346257plk.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hSk+BWwWvJ1oCRxLvBFa9PHhZTRFiiGxRl0Lqe3WWIQ=;
        b=YeOURg+MhaHmsQ1UjUgltqKJO6UnOFXKE3Q27Jjdc0zO3A02v1RjyIWDeT2sCS8OLL
         tFtqJ6RE2M1s+w3C5U8a1ahVeKTacYCuIr5IC+JnPlv4kG3fcY+k6TSrazAMmG3mzoA3
         RAhFzLS/mp274BzBqOmZz5ihCx0vxHBE4dZ3sBvrOWPFHlk7CirG/2g/lhiH+jZQDRrt
         yUfZnTdHF/UVgtQrD0vb381ib/8hfiKpwcsujMA68YKg+KWJPfwRnMbTT2DQZw0G4Jiv
         ZEZjsWuKEmpLC8cLqG1lVQXS8Lbedm06qCVMNOYCkwfMPjQ3EVmHwlizGNN3yuHJuge6
         xE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hSk+BWwWvJ1oCRxLvBFa9PHhZTRFiiGxRl0Lqe3WWIQ=;
        b=cJVhRso7aBx0yb2bAReKbklT+necoLa94sEzJ3dsUMseX1RnuwaXxfY8clUYj6jeHe
         a1IgWab6rcAOwIE7ICOCX5MUwUkQ+eq+D27ixKEyYbL7DMsp61pFLp7UZQRhavZP8A7h
         mzITiEqCTOep5Ib3Fo8F7IX/EpiwuKjUMwNOyKQ8NSvqMYTrrRhPumLzAoQszRpVVmXH
         Bzgzpv9Qz1d8V1EVXaBqW8RhnrobkR+DEC4OJKZ+IYd5HHdbb2j2+QbDV48Sh0UDHp36
         o0PccS4UoJWMkJkaKbl3BC7JMQJiV2uyUnmiOlSngLCmN0kpn/jKFvAyr1Umvf5u9nMx
         qUSg==
X-Gm-Message-State: APt69E0jkGEZZDQCZhGS83ucsFqxTqoE6zlkc0RLyst5gf57uEuPjVa0
        0GG2YW1OayCpL5u6glvtcQRvIQ==
X-Google-Smtp-Source: ADUXVKLlXk1sjoGLVyDVceEeFyWGvOh0npHTfirsG94YKw65zkJ+Rp5S7W4kC9g0OjKk4W0RXTeRCQ==
X-Received: by 2002:a17:902:3041:: with SMTP id u59-v6mr2515204plb.208.1528845376831;
        Tue, 12 Jun 2018 16:16:16 -0700 (PDT)
Received: from cisco ([2001:420:28d:1250:4fa:4ea4:93fe:a612])
        by smtp.gmail.com with ESMTPSA id i65-v6sm2204916pfd.17.2018.06.12.16.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 16:16:14 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:16:10 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Matthew Helsley <matt.helsley@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        "Tobin C . Harding" <me@tobin.cc>,
        Kees Cook <keescook@chromium.org>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH v3 1/4] seccomp: add a return code to trap to userspace
Message-ID: <20180612231610.GA3837@cisco>
References: <20180531144949.24995-1-tycho@tycho.ws>
 <20180531144949.24995-2-tycho@tycho.ws>
 <CA+RrjuW98m2coL+TOKq5cL0QhAb=HYxo2DpNoqMzdiwjqhc2BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+RrjuW98m2coL+TOKq5cL0QhAb=HYxo2DpNoqMzdiwjqhc2BA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Tue, Jun 12, 2018 at 02:39:03PM -0700, Matthew Helsley wrote:
> On Thu, May 31, 2018 at 7:49 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> 
> <snip>
> 
> 
> > +struct seccomp_notif {
> > +       __u64 id;
> > +       pid_t pid;
> > +       struct seccomp_data data;
> > +};
> >
> 
> Since it's part of the UAPI I think it would be good to add documentation
> to this patch series. Part of that documentation should talk about which
> pid namespaces this pid value is relevant in. This is especially important
> since the feature is designed for use by things like container/sandbox
> managers.

Yes, at least Documentation/userspace-api/seccomp_filter.txt should be
updated. I'll add that for the next series.

> > +static void seccomp_do_user_notification(int this_syscall,
> > +                                        struct seccomp_filter *match,
> > +                                        const struct seccomp_data *sd)
> > +{
> > +       int err;
> > +       long ret = 0;
> > +       struct seccomp_knotif n = {};
> > +
> > +       mutex_lock(&match->notify_lock);
> > +       err = -ENOSYS;
> > +       if (!match->has_listener)
> > +               goto out;
> > +
> > +       n.pid = current->pid;
> >
> 
> How have you tested this code for correctness? I don't see many
> combinations being tested below nor here:
> https://github.com/tych0/kernel-utils/blob/master/seccomp/notify_stress.c
> 
> What about processes in different pid namespaces? Make tests that vary key
> parameters like these between the task generating the notifications and the
> task interested in processing the notifications. Make tests that try to
> kill them at interesting times too. etc. Make tests that pass the
> notification fd around and see how they work (or not).
> 
> I ask about testing because you're effectively returning a pid value to
> userspace here but not using the proper macros to access the task's struct
> pid for that purpose. That will work so long as both processes are in the
> same pid namespace but breaks otherwise.
> 
> Furthermore, a pid value is not the best solution for the queueing of these
> notifications because a single pid value is not meaningful/correct outside
> current's pid namespace and the seccomp notification file descriptor could
> be passed on to processes in another pid namespaces; this pid value will
> almost always not be relevant or correct there hence taking a reference to

Well, it *has* to be relevant in some cases: if you want to access
some of the task's memory to e.g. read the args to the syscall, you
need to ptrace or map_files to access the memory. So we do need to
pass it, but,

> the struct pid is useful. Then, during read(), the code would use the
> proper macro to turn the struct pid reference into a pid value relevant in
> the *reader's* pid namespace *or* return something obviously bogus if the
> reader is in a pid namespace that can't see that pid. This could prevent
> management processes from being tricked into clobbering the wrong process,
> feeding the wrong process sensitive information via syscall results, etc.

Yes, this makes sense. Seems like we need to do some magic about
passing the tracee's task struct to the listener, so it can do
task_pid_vnr(). We could perhaps require the listener to be in the
init_pid_ns case, but I think things like socket() might still be
useful even if you can't read the tracee's memory.

> Alternately, you could choose to specify that the seccomp manager is
> expected to be in the pid namespace of the process it's managing at all
> times. That's not necessarily trivial either because the process(es) it
> manages could potentially create new child pid namespaces. It also means
> that the processes being managed can "see" the manager process at all times.

Right, I think we don't want to require this.

> Regardless, you still need to use the proper macros to access current's pid
> for export to userspace.

Yes, thanks.

Tycho
