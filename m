Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103A8C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E300214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ha433zy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E300214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeJIT5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:57:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39311 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeJIT5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:57:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id l58so1426262otd.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 05:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUh7DZePWQGubrujTdGMYRhGcavfDkqyiRLdHw9pBtM=;
        b=ha433zy1NgQMlpuhkgWe4HK1wA/AA1KTB3ZKzt4+yir5gHg6v7AgyeTGffriqO2kRV
         suVQJiFZiRY6dXYMIcZInxplnJWBKQqyupEYdsP/aXsDFQB3iV9/WdSOlCLoaJqnswh4
         JFoPGvlCTZkCQIxpFRHF7SUABQGMHNveoCZV8BI4mUe+BBNnOJrV3eaKv5duYJ/LfC0J
         9n1RvVBk7dWCgGo7VmdKKlxZKlWSkl0EButgX8TxuTaIg8GTOowUIYUrmrwiPtFcZfeQ
         bYpgYpCG/8jAvgWQoN+CKHSu3TbWQzBN8T6y0OVm7gUg8zENhXbtv7eiuVr1POdfVqrz
         xmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUh7DZePWQGubrujTdGMYRhGcavfDkqyiRLdHw9pBtM=;
        b=I27vfkNQGOQKAMI10BacQOvnfmjjBCK3K0ClRWKQNQY2fpXemv+wmF61SgDn0gSy3z
         EMmaUTPy1gFkhyl2yBgn7KZBK1pXDgz2ZRCjv8kROQpu8H8ytHLR6YTicjOHl9O9Kpqd
         YqzO8khw97rmHWP/60YCnm06+igDt7uXr8rmlL6hEkqyBO0nxuZcAgbVYhS24a9uCpI8
         Xb7ozWbDuXF0uMo0qPbNOMNrYesogq0jd901GV3Mzgmg2eslbOlfuZiNY1CIK8QBhSgg
         YH6qzY7PuMTQtmyTnBDVHjtio3Vbsdc8VGxZ5c3lyOtYXoYLBIESyh7XTjODy5acZ9Uq
         goaA==
X-Gm-Message-State: ABuFfoj63BBf8L0RvqcdUA2aH3QL3K8gW9U2Z3ZamaYAnak7HXz9wTd1
        LbMSPvYp2nmAAH+2NS1Oj2LsjK8E6x1Q1hX5/YtCDw==
X-Google-Smtp-Source: ACcGV62CbDOKw4X0OO63JV+0x8ib6PwKGS5lHP8efeduwL6b0tYIbn/cIbLIn/E5LdA6EitdpFz1km/jb766MMhKCjE=
X-Received: by 2002:a9d:4917:: with SMTP id e23mr14890956otf.73.1539088820572;
 Tue, 09 Oct 2018 05:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-4-tycho@tycho.ws>
 <20181008151629.hkgzzsluevwtuclw@brauner.io> <CAG48ez3zaqOXH_jHN8=+jXjOf3vhFyWUkM_6KLPi9T8HcQySeg@mail.gmail.com>
 <20181008162147.ubfxxsv2425l2zsp@brauner.io> <CAG48ez3O+wAkq+0yDfoMt73ybnCOEPpi3Mu-uF57_v=6hA8ZEw@mail.gmail.com>
 <20181008181815.pwnqxngj22mhm2vj@brauner.io>
In-Reply-To: <20181008181815.pwnqxngj22mhm2vj@brauner.io>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 9 Oct 2018 14:39:53 +0200
Message-ID: <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from ptrace
To:     christian@brauner.io
Cc:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, suda.akihiro@lab.ntt.co.jp,
        Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 8:18 PM Christian Brauner <christian@brauner.io> wrote:
> On Mon, Oct 08, 2018 at 06:42:00PM +0200, Jann Horn wrote:
> > On Mon, Oct 8, 2018 at 6:21 PM Christian Brauner <christian@brauner.io> wrote:
> > > On Mon, Oct 08, 2018 at 05:33:22PM +0200, Jann Horn wrote:
> > > > On Mon, Oct 8, 2018 at 5:16 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > On Thu, Sep 27, 2018 at 09:11:16AM -0600, Tycho Andersen wrote:
> > > > > > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > > > > index 44a31ac8373a..17685803a2af 100644
> > > > > > --- a/kernel/seccomp.c
> > > > > > +++ b/kernel/seccomp.c
> > > > > > @@ -1777,4 +1777,35 @@ static struct file *init_listener(struct task_struct *task,
> > > > > >
> > > > > >       return ret;
> > > > > >  }
> > > > > > +
> > > > > > +long seccomp_new_listener(struct task_struct *task,
> > > > > > +                       unsigned long filter_off)
> > > > > > +{
> > > > > > +     struct seccomp_filter *filter;
> > > > > > +     struct file *listener;
> > > > > > +     int fd;
> > > > > > +
> > > > > > +     if (!capable(CAP_SYS_ADMIN))
> > > > > > +             return -EACCES;
> > > > >
> > > > > I know this might have been discussed a while back but why exactly do we
> > > > > require CAP_SYS_ADMIN in init_userns and not in the target userns? What
> > > > > if I want to do a setns()fd, CLONE_NEWUSER) to the target process and
> > > > > use ptrace from in there?
> > > >
> > > > See https://lore.kernel.org/lkml/CAG48ez3R+ZJ1vwGkDfGzKX2mz6f=jjJWsO5pCvnH68P+RKO8Ow@mail.gmail.com/
> > > > . Basically, the problem is that this doesn't just give you capability
> > > > over the target task, but also over every other task that has the same
> > > > filter installed; you need some sort of "is the caller capable over
> > > > the filter and anyone who uses it" check.
> > >
> > > Thanks.
> > > But then this new ptrace feature as it stands is imho currently broken.
> > > If you can install a seccomp filter with SECCOMP_RET_USER_NOTIF if you
> > > are ns_cpabable(CAP_SYS_ADMIN) and also get an fd via seccomp() itself
> > > if you are ns_cpabable(CAP_SYS_ADMIN)

Actually, you don't need CAP_SYS_ADMIN for seccomp() at all as long as
you enable the NNP flag, I think?

> > > then either the new ptrace() api
> > > extension should be fixed to allow for this too or the seccomp() way of
> > > retrieving the pid - which I really think we want - needs to be fixed to
> > > require capable(CAP_SYS_ADMIN) too.
> > > The solution where both require ns_capable(CAP_SYS_ADMIN) is - imho -
> > > the preferred way to solve this.
> > > Everything else will just be confusing.
> >
> > First you say "broken", then you say "confusing". Which one do you mean?
>
> Both. It's broken in so far as it places a seemingly unnecessary
> restriction that could be fixed. You outlined one possible fix yourself
> in the link you provided.

If by "possible fix" you mean "check whether the seccomp filter is
only attached to a single task": That wouldn't fundamentally change
the situation, it would only add an additional special case.

> And it's confusing in so far as there is a way
> via seccomp() to get the fd without said requirement.

I don't find it confusing at all. seccomp() and ptrace() are very
different situations: When you use seccomp(), infrastructure is
already in place for ensuring that your filter is only applied to
processes over which you are capable, and propagation is limited by
inheritance from your task down. When you use ptrace(), you need a
pretty different sort of access check that checks whether you're
privileged over ancestors, siblings and so on of the target task.

But thinking about it more, I think that CAP_SYS_ADMIN over the saved
current->mm->user_ns of the task that installed the filter (stored as
a "struct user_namespace *" in the filter) should be acceptable.
