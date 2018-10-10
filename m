Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7EEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65392075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="pS6dmdPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65392075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJKBI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:08:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54219 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeJKBI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:08:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id y11-v6so6378251wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=twvXee+ZkXSW/lskOcIxV+SOvNLvv8J3pTzYe6+z5XA=;
        b=pS6dmdPqgWNW/gWzX9hZD9NnZ/K+uMa4XqvBRURuZNSDGXwsAq5L5CcGagCFyCZRsO
         Qb5Rcf/ze8bG0Ej+ON+uuAtyH5q7KVrZgbhecjf/9ByqWYSDex3Ig2RtxQ9R+5mkXn1t
         8Aq253p5oPHNpVh50ti4CbLJjh1ZkaoUzofyKYwqeRBsFK78wQ8PwOeCfuP7GsEkxuEn
         fUfFsyheOVnD3xQjBctofhWUZSKfNMCQZWA7NOOHaqCLJSon7J5DoKSRPuXypIiDnux/
         k12y62WtOY5VAlKDgX9ittjGTIfxfDwoMa1PdQbFA/ryB8SmqBglGsW5d5a3s1/LnkBn
         FtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twvXee+ZkXSW/lskOcIxV+SOvNLvv8J3pTzYe6+z5XA=;
        b=IcdltRjdJ7HIcZzZwJevALCvI/3OZLRraSvcz1RXljozbLkR3u6rgQP6uiB4u3TVZ6
         5DGBisgn6JO9kfgWc7wR4ynauA5HcXeiW4e9njb5YCBWkXXdys7a+ui35tHIhSXForgb
         Yf0WDGp9je97iHFRrGSkBwQRz2mYP3YqyRoCqK4U1INJ6rezePF7IQjn4gXI/b0nWQ/J
         HDFZzBpud5qiSoSYOF+ALCPys8QNKk1CNgfONjScntEmgbmdsHH83a0iOQLDHmokupJh
         hcNBhQtb4d5Z26H6ICtiN2FlCwV2J2icKN7esg2UKpfptU+lnNBVgXA1Ajasb7/nMDsf
         Ypdw==
X-Gm-Message-State: ABuFfoiGPPWrFvFsryl2bwADMPOv1oKDaIW9ZBono2xWNOPON/WPrmKz
        x0fnoWEnelAEOmgT+2/TXSO2WOd0dTtBQPUHkJfW5g==
X-Google-Smtp-Source: ACcGV60gipJPJFBhrs5uKcT/bHdGH37CM4pGcO+m9yoEe3Wed41TKT7SB4Ix+7DHgibz+pRYcZ3R2d+ocfyWCwIpitE=
X-Received: by 2002:a1c:4054:: with SMTP id n81-v6mr1796541wma.82.1539193542092;
 Wed, 10 Oct 2018 10:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-4-tycho@tycho.ws>
 <20181008151629.hkgzzsluevwtuclw@brauner.io> <20181008180043.GE28238@cisco.lan>
In-Reply-To: <20181008180043.GE28238@cisco.lan>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 10 Oct 2018 10:45:29 -0700
Message-ID: <CALCETrVtkvG1NihqMF4qMhhtcXFuLbwS2DW=C5F=Lp5riMa9dg@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from ptrace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 11:00 AM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Mon, Oct 08, 2018 at 05:16:30PM +0200, Christian Brauner wrote:
> > On Thu, Sep 27, 2018 at 09:11:16AM -0600, Tycho Andersen wrote:
> > > As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> > > version which can acquire filters is useful. There are at least two reasons
> > > this is preferable, even though it uses ptrace:
> > >
> > > 1. You can control tasks that aren't cooperating with you
> > > 2. You can control tasks whose filters block sendmsg() and socket(); if the
> > >    task installs a filter which blocks these calls, there's no way with
> > >    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
> >
> > So for the slow of mind aka me:
> > I'm not sure I completely understand this problem. Can you outline how
> > sendmsg() and socket() are involved in this?
> >
> > I'm also not sure that this holds (but I might misunderstand the
> > problem) afaict, you could do try to get the fd out via CLONE_FILES and
> > other means so something like:
> >
> > // let's pretend the libc wrapper for clone actually has sane semantics
> > pid = clone(CLONE_FILES);
> > if (pid == 0) {
> >         fd = seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_NEW_LISTENER, &prog);
> >
> >         // Now this fd will be valid in both parent and child.
> >         // If you haven't blocked it you can inform the parent what
> >         // the fd number is via pipe2(). If you have blocked it you can
> >         // use dup2() and dup to a known fd number.
> > }
>
> But what if your seccomp filter wants to block both pipe2() and
> dup2()? Whatever syscall you want to use to do this could be blocked
> by some seccomp policy, which means you might not be able to use this
> feature in some cases.

You don't need a syscall at all. You can use shared memory.

>
> Perhaps it's unlikely, and we can just go forward knowing this. But it
> seems like it is worth at least acknowledging that you can wedge
> yourself into a corner.
>

I think that what we *really* want is a way to create a seccomp fitter
and activate it later (on execve or via another call to seccomp(),
perhaps).  And we already sort of have that using ptrace() but a
better interface would be nice when a real use case gets figured out.
