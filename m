Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC65C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9B621477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="ChM4m4T1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9B621477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeJMDga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:36:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41915 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeJMDga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:36:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id q17-v6so6405650plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vdPSDV1B51J0pwMLq40tWD88fqUwXxbWUb+50kgxuLY=;
        b=ChM4m4T1i7GmucBU/JzgZcdOBchmQMqV863MHvfTtOF4s+NnnLc265AvTnM96PjZT5
         WbQwbeC0yfsIXLgkmthuurYIB75taeGLI6vpqi/lwf3/s900+Tmajz93MaNSCUu+ucZb
         ERyg95dOq3h4e9WHPn9BQYj7PD9lKK/1dym1Z+UdoJ4t1/kNr8As+d5xA6Oj3vyPOKQ5
         CkWICxcewCPGYcMaHABsvuUvgmEvnCDRSY+Gl5v3+pnXa2Gi6xKTS4fnpRWWIE6EcU4Y
         rr6xYYB3f5pjFCQTp2kXsdDJ1so6YuSOZLJU4BrFqeT+VkRMeI/uCQO+bmtbnBQ2wMqD
         UsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vdPSDV1B51J0pwMLq40tWD88fqUwXxbWUb+50kgxuLY=;
        b=Z8qFIIzVrur0E2eFhg6XGj1Oi778jA4Cfruba6dTYz45Dev/knOwijfUcyTGIEn7Kr
         erE9Z6sT4sxrfL4512QVa6uURcLsVkJ8HPqw2+5WUTzSNG8iNgbvYGVZHvG5QJjt4ry3
         Ql4o8/qQclz1QUryk0bfI41mHf4mFPAreFAFd4p182R22ZcmHdHBiVfG5BJmjboiQPFa
         pVdC0ZlSyWNgvA91pS3+HruIGqwuwBptkXgebSqmENfQ/DNflFNqMURIOMpaUJKyPGhi
         4e4h3usf1TmXNRj7fU7XCIVjIZk65rDAWqkxKkxjbKaa7dYic2gXYbHd0P5WnT5TAeDt
         iaYQ==
X-Gm-Message-State: ABuFfoiAbHYp+S+gsrPHRk+09NXwzLch04mV/a9Z/K3B5LuXSQQ+ivfQ
        yvk0078GfZPHfUgVR1iDF4IblA==
X-Google-Smtp-Source: ACcGV63kYvoDYx3c4gGc5V+dnS9PX9Zaf4WDN9ntwJ2Q1nx/EjA/Q57lSDzO93IlzSprxxNCt9xyeA==
X-Received: by 2002:a17:902:2:: with SMTP id 2-v6mr7334285pla.178.1539374542955;
        Fri, 12 Oct 2018 13:02:22 -0700 (PDT)
Received: from cisco ([128.107.241.177])
        by smtp.gmail.com with ESMTPSA id q25-v6sm3658697pfk.154.2018.10.12.13.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 13:02:21 -0700 (PDT)
Date:   Fri, 12 Oct 2018 13:02:20 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        SELinux-NSA <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20181012200220.GC5530@cisco>
References: <20181008181815.pwnqxngj22mhm2vj@brauner.io>
 <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io>
 <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <CAHC9VhQfzJgG3i=Q8C+pGY2Lpr+2MRTwxgUWec_heGOecd=xRg@mail.gmail.com>
 <CAG48ez2hTBFwmA65FXv0zJjc0_wpc1S-uOBn1t+X=0vPH25YvQ@mail.gmail.com>
 <16662034750.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAG48ez0=NRRu2FUZFwdDSMmkdWsFi1XSSPTO8bL84YAY=jOzMQ@mail.gmail.com>
 <1666564e4f8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CALCETrV1fWKJe96ow3XGy_kmZoXoehb99e4AZehsO84YGxKjgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV1fWKJe96ow3XGy_kmZoXoehb99e4AZehsO84YGxKjgQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 06:02:06PM -0700, Andy Lutomirski wrote:
> On Thu, Oct 11, 2018 at 4:10 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On October 11, 2018 9:40:06 AM Jann Horn <jannh@google.com> wrote:
> > > On Thu, Oct 11, 2018 at 9:24 AM Paul Moore <paul@paul-moore.com> wrote:
> > >> On October 10, 2018 11:34:11 AM Jann Horn <jannh@google.com> wrote:
> > >>> On Wed, Oct 10, 2018 at 5:32 PM Paul Moore <paul@paul-moore.com> wrote:
> > >>>> On Tue, Oct 9, 2018 at 9:36 AM Jann Horn <jannh@google.com> wrote:
> > >>>>> +cc selinux people explicitly, since they probably have opinions on this
> > >>>>
> > >>>> I just spent about twenty minutes working my way through this thread,
> > >>>> and digging through the containers archive trying to get a good
> > >>>> understanding of what you guys are trying to do, and I'm not quite
> > >>>> sure I understand it all.  However, from what I have seen, this
> > >>>> approach looks very ptrace-y to me (I imagine to others as well based
> > >>>> on the comments) and because of this I think ensuring the usual ptrace
> > >>>> access controls are evaluated, including the ptrace LSM hooks, is the
> > >>>> right thing to do.
> > >>>
> > >>> Basically the problem is that this new ptrace() API does something
> > >>> that doesn't just influence the target task, but also every other task
> > >>> that has the same seccomp filter. So the classic ptrace check doesn't
> > >>> work here.
> > >>
> > >> Due to some rather unfortunate events today I'm suddenly without easy access to the kernel code, but would it be possible to run the LSM ptrace access control checks against all of the affected tasks?  If it is possible, how painful would it be?
> > >
> > > There are currently no backlinks from seccomp filters to the tasks
> > > that use them; the only thing you have is a refcount. If the refcount
> > > is 1, and the target task uses the filter directly (it is the last
> > > installed one), you'd be able to infer that the ptrace target is the
> > > only task with a reference to the filter, and you could just do the
> > > direct check; but if the refcount is >1, you might end up having to
> > > take some spinlock and then iterate over all tasks' filters with that
> > > spinlock held, or something like that.
> >
> > That's what I was afraid of.
> >
> > Unfortunately, I stand by my previous statements that we still probably want a LSM access check similar to what we currently do for ptrace.
> >
> 
> I would argue that once "LSM" enters this conversation, it just means
> we're on the wrong track.  Let's try to make this work without ptrace
> if possible :)  The whole seccomp() mechanism is very carefully
> designed so that it's perfectly safe to install seccomp filters
> without involving LSM or even involving credentials at all.

In a last ditch effort to save the ptrace() interface: can we just
only allow it when refcount_read(filter->usage) == 1?

Tycho
