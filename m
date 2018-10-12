Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61795C71123
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D2F20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="cNGOb0SP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D2F20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJMDqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:46:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41370 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeJMDqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:46:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id x12-v6so14643737wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 13:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/22EgvWHixaIJnreyqMAb8eGvNuURDo/SHpTjnP7eZ0=;
        b=cNGOb0SPpv3m5cxT3bG5bMNGbDib2mC+syROY1kHr91vrs7Zg1yLa8OqsykcAyHBPd
         FdRVBWtjVR69Wm6RTHkazZogKgk4HFUrnVf0/qcQ7mJjxMQWBhLHP42fGhopvo80ydPj
         TQSQjg2atF3FIfB9Z5D8W7VUZ0C5yX8NMUD9LayQgeJev/whptsYVp+YjtXk3PShD2lF
         Gn6xuWieADOLNLP3CKntRnj5W3LYGY5CBweINgAlRYTOiLbd2mOIr2Bz2iiO0itjjhs4
         MY6ZSr6kWNLeB9X5K0np0gNiWCrLudyTR7fuZY/MXCj/MIct6kqTxTbasT/WOdEkihP/
         P4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/22EgvWHixaIJnreyqMAb8eGvNuURDo/SHpTjnP7eZ0=;
        b=KurkKyD8FZrum6BFgVxt8vB3Qm1kr03JRQKv+DSmwGTPJWmcERrs8oOiUr8LzBapCd
         ZSOvhtC3X8X6KXG3XRXQR1qZJZoKQl8HosDBBxbEHTR8qS9MsFD/geEoFgrfiOZGe8XL
         QeH5xnmBg9hRIUR0CZU1bS0VnAUZjra82vGqk3F4w7X2Yz441Se3dGCeZjqLp4Xi1Two
         MxNg0Hw+qREem5H652FIetgyEKVYQhGGVvc3HZPbCzreMEblx47Kth+cYH1g6PjPvdX2
         +98WHfAH9iFzPwzeID8MO5UdcZrHiS2saQpKS/z0+wEqAY9JV3sYQHG2sKsDtEfvx7VR
         d6Bg==
X-Gm-Message-State: ABuFfojqR6SNqQ7AZyiWubHSvPSSjTvjrTkCqwrGgKIeyTgF/oRieV3s
        uQ/qE+aFwPa3ShHMQiVOzwbW2g==
X-Google-Smtp-Source: ACcGV61D+KwvzjWsC5n9Kvh8mh3UAf1aKv8t4LfNiv+6t7r4aGvpe2Dj2VMiYSt2RF61GE5oyqz/qQ==
X-Received: by 2002:adf:a144:: with SMTP id r4-v6mr6385385wrr.169.1539375122303;
        Fri, 12 Oct 2018 13:12:02 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id u76-v6sm4056140wmd.10.2018.10.12.13.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 13:12:01 -0700 (PDT)
Date:   Fri, 12 Oct 2018 22:11:54 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
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
Message-ID: <20181012201153.psyjrjzpiyjksqba@brauner.io>
References: <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io>
 <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <CAHC9VhQfzJgG3i=Q8C+pGY2Lpr+2MRTwxgUWec_heGOecd=xRg@mail.gmail.com>
 <CAG48ez2hTBFwmA65FXv0zJjc0_wpc1S-uOBn1t+X=0vPH25YvQ@mail.gmail.com>
 <16662034750.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAG48ez0=NRRu2FUZFwdDSMmkdWsFi1XSSPTO8bL84YAY=jOzMQ@mail.gmail.com>
 <1666564e4f8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CALCETrV1fWKJe96ow3XGy_kmZoXoehb99e4AZehsO84YGxKjgQ@mail.gmail.com>
 <20181012200220.GC5530@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181012200220.GC5530@cisco>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 01:02:20PM -0700, Tycho Andersen wrote:
> On Thu, Oct 11, 2018 at 06:02:06PM -0700, Andy Lutomirski wrote:
> > On Thu, Oct 11, 2018 at 4:10 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On October 11, 2018 9:40:06 AM Jann Horn <jannh@google.com> wrote:
> > > > On Thu, Oct 11, 2018 at 9:24 AM Paul Moore <paul@paul-moore.com> wrote:
> > > >> On October 10, 2018 11:34:11 AM Jann Horn <jannh@google.com> wrote:
> > > >>> On Wed, Oct 10, 2018 at 5:32 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >>>> On Tue, Oct 9, 2018 at 9:36 AM Jann Horn <jannh@google.com> wrote:
> > > >>>>> +cc selinux people explicitly, since they probably have opinions on this
> > > >>>>
> > > >>>> I just spent about twenty minutes working my way through this thread,
> > > >>>> and digging through the containers archive trying to get a good
> > > >>>> understanding of what you guys are trying to do, and I'm not quite
> > > >>>> sure I understand it all.  However, from what I have seen, this
> > > >>>> approach looks very ptrace-y to me (I imagine to others as well based
> > > >>>> on the comments) and because of this I think ensuring the usual ptrace
> > > >>>> access controls are evaluated, including the ptrace LSM hooks, is the
> > > >>>> right thing to do.
> > > >>>
> > > >>> Basically the problem is that this new ptrace() API does something
> > > >>> that doesn't just influence the target task, but also every other task
> > > >>> that has the same seccomp filter. So the classic ptrace check doesn't
> > > >>> work here.
> > > >>
> > > >> Due to some rather unfortunate events today I'm suddenly without easy access to the kernel code, but would it be possible to run the LSM ptrace access control checks against all of the affected tasks?  If it is possible, how painful would it be?
> > > >
> > > > There are currently no backlinks from seccomp filters to the tasks
> > > > that use them; the only thing you have is a refcount. If the refcount
> > > > is 1, and the target task uses the filter directly (it is the last
> > > > installed one), you'd be able to infer that the ptrace target is the
> > > > only task with a reference to the filter, and you could just do the
> > > > direct check; but if the refcount is >1, you might end up having to
> > > > take some spinlock and then iterate over all tasks' filters with that
> > > > spinlock held, or something like that.
> > >
> > > That's what I was afraid of.
> > >
> > > Unfortunately, I stand by my previous statements that we still probably want a LSM access check similar to what we currently do for ptrace.
> > >
> > 
> > I would argue that once "LSM" enters this conversation, it just means
> > we're on the wrong track.  Let's try to make this work without ptrace
> > if possible :)  The whole seccomp() mechanism is very carefully
> > designed so that it's perfectly safe to install seccomp filters
> > without involving LSM or even involving credentials at all.
> 
> In a last ditch effort to save the ptrace() interface: can we just
> only allow it when refcount_read(filter->usage) == 1?

I mean, the filter->usage == 1 means lets us get rid of
capable(CAP_SYS_ADMIN) making the ptrace() way of getting an fd useable
in nesting scenarios and from within user namespaces. That makes it a
whole lot more useful and aligns it with the seccomp() way of getting
the fd. So I wouldn't argue against it.
I guess it comes down to (for me) whether you consider this a necessary
part of this patchset aka meaning without it it wouldn't be useable.

Christian
