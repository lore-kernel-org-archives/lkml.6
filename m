Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0E8C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316632087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wv3KQJCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316632087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeJMDkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:40:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45328 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeJMDkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:40:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id u22so13467122ota.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uuFoRplXvuDg46hTY7eUtJi9J7lxsD7NBeqO8bQS2sU=;
        b=Wv3KQJCwZZffnr9xmpNIUnptsIKSFgA9EiAwatfbv+YM20VkNox/0y55fUkx/7ghw+
         pnrbPE0fitpeqXABKqxZ+DtjjL1Qu65KSmBgc6CHpwdWI14YfGcE3F2yVTuv/ffTEm8n
         9uNpIqAY5Cfz8GNrip5DtYxjdXBAvNeKaUEaATCpizlb+zBSQ/p2lqI0G8N9xrcEdkRR
         wcZAQdPiZzGnBZK70fstC3MWOVJUy1OJ2wX6V5udh8g8RziR4jbHd448LKVYGMrfF/Xg
         PKqv8XwX3EY6kTW+wGvHdUqy3ETgGyZKA9nqRVw5SxMRe7kN+Eb979vgqqbfvjy6zjXT
         b4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uuFoRplXvuDg46hTY7eUtJi9J7lxsD7NBeqO8bQS2sU=;
        b=BKuSPvD6KRGJ9fRcrvVkq8Ity1hYfDSPGNQeVOBn3/ZqcNVAbvpEY8sf3V5fzl6F5I
         VgDS045jZopOAqFYNRusAEcqSK4PV+iugHxShz0kTrdrzbVi5UqDxfPZL188md/uM4gT
         amHlLCHGU8M+nU9V1Kto+rv3/6fQ3HnAMOlsEkJIjIU2yn6KjK7EymRYyn3lqGipPVBk
         KG9o7oh04E90hkdf2dyAk8DYa/5khw+FxN5PmDkPc4KOAgAPgqh/oQhl1fwaXd7DvEv5
         jDpzgNJWLgmQY9YGm9A+WRmIZj9Cl5Ht3r9y7z2/upsHH6+jqWMJLalghDsM0bDEYIGb
         cLoA==
X-Gm-Message-State: ABuFfogMcyIq/kO6U9LH5VyJB2TgaJK3kUZan8fmmsLeOA2a0B4X/qB9
        WkNtmWwtRu0A1aE5/t/7OtG8TRH8lfwBP/vmRxMyEg==
X-Google-Smtp-Source: ACcGV62U4W/sXvna70NoU1KyEKejpbKQBChwBNYTGG28EyCI8YeyFJcWp1xqVhTcTI5fj1vWnuvWWF345JRwK/1HisM=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr4905031otf.242.1539374787986;
 Fri, 12 Oct 2018 13:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181008181815.pwnqxngj22mhm2vj@brauner.io> <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io> <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <CAHC9VhQfzJgG3i=Q8C+pGY2Lpr+2MRTwxgUWec_heGOecd=xRg@mail.gmail.com>
 <CAG48ez2hTBFwmA65FXv0zJjc0_wpc1S-uOBn1t+X=0vPH25YvQ@mail.gmail.com>
 <16662034750.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAG48ez0=NRRu2FUZFwdDSMmkdWsFi1XSSPTO8bL84YAY=jOzMQ@mail.gmail.com>
 <1666564e4f8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CALCETrV1fWKJe96ow3XGy_kmZoXoehb99e4AZehsO84YGxKjgQ@mail.gmail.com> <20181012200220.GC5530@cisco>
In-Reply-To: <20181012200220.GC5530@cisco>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 12 Oct 2018 22:06:00 +0200
Message-ID: <CAG48ez3o0t6UjtdsuiUck7ijJiA39uy5Jfno28UMMq_Q1d=s8g@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from ptrace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Paul Moore <paul@paul-moore.com>, christian@brauner.io,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, suda.akihiro@lab.ntt.co.jp,
        Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:02 PM Tycho Andersen <tycho@tycho.ws> wrote:
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

From a security perspective, I think that would be fine, assuming that
we know that the target task is stopped. (But note that if the target
process e.g. uses the filter on multiple threads, the refcount will be
higher.)
