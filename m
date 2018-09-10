Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D46C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1607A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIQ3tkOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1607A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeIJV4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:56:11 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36200 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeIJV4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:56:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id r69-v6so41556869oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zK8Fd0kJOvKg2PjbnxicjT6vqSDeRw4iZMBXsXoGFmM=;
        b=dIQ3tkOuAhOd9PniRN6RdV95MMYfadce67k4y2v6gKC7B1IXs+umPZ2k4BHhUMpnc6
         nKpPU/Nf6wDZ5iLmRNePphh4SrHZyTgC8rQ3bnVzBpXBLz9nhkRb8WIg6SLjPQDRznKK
         eysLL2rrTTqKpHv1TrxbH0iVJ023lBrzFDDYW+75FtCv29xoyMNToxUFzGoiJl+CH0Cy
         RBeeBLAgdeo6GXmo6CchekthW1U3ED39MmPd5UoZcRXm+F9Ij63I8hEu2ogPXNhxanMj
         p9f0X9uiTA7g6+IlBx6QTKzdIVcXHonsaHLlmfChpcIhxxQvbhhnCOsi7R/yTe/MZxs/
         Fmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zK8Fd0kJOvKg2PjbnxicjT6vqSDeRw4iZMBXsXoGFmM=;
        b=VAehwM6ouYx1xb2k4Ru9MHlNxGhroaNkdXQ7WomCHet0VS3H0QN6hIUUkAJ+eO+zHI
         mEfNsKFYMkcQ3/8BfNJKlC78Wq/YlFuB19651fi6mo2he1Lmfk1BP3vcguPb7tLNlfeR
         KrlJUiw+qYOGrPgGKD2otI/tzECUdrnAOgyDL7JWmy0tkX7UuG6FLz2VRRWPUryPScVq
         YP1RcS1450M/46ynZ8gMPuMiAktUfZqlnsSJnZb81xoPplqSh/WHiAzkKIhfhchH551B
         m+V2Xtf5immm0aqmjd5iUL93laPH4QpczQJoRZolfifiXa1FDMML2NdIvILi9QWHeGtg
         gCzg==
X-Gm-Message-State: APzg51D2JY7DOGVdcJUavbmR9jbplLkPqkHrw63xC/HcY4J8JlWUS7Qa
        LgUzv4M49IcgJXglpz9vpCKk2OB6TmYOYzzYs+wAZw==
X-Google-Smtp-Source: ANB0VdYOwN+16dKhNnVX5M4qCXUYw6X4il+CqO7GcCXEUNzCVCQIJoT29npfryu23lM4z9VANC4DLR3hBp0cePxjuAo=
X-Received: by 2002:aca:c585:: with SMTP id v127-v6mr23202338oif.348.1536598869584;
 Mon, 10 Sep 2018 10:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180906152859.7810-1-tycho@tycho.ws> <20180906152859.7810-5-tycho@tycho.ws>
 <CAG48ez2oQnAb=OMGOUz0GfSWMsjqydPe8dmp6L=QswSQpSpVXA@mail.gmail.com>
 <20180906162246.GB3326@cisco.cisco.com> <20180906183018.GC3326@cisco.cisco.com>
In-Reply-To: <20180906183018.GC3326@cisco.cisco.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 10 Sep 2018 19:00:43 +0200
Message-ID: <CAG48ez0Dx+35fGcrBzzNRSOsmFhuiQBN+-S5+b3_9m9eWbLeQQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] seccomp: add support for passing fds via USER_NOTIF
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>, suda.akihiro@lab.ntt.co.jp
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 8:30 PM Tycho Andersen <tycho@tycho.ws> wrote:
> On Thu, Sep 06, 2018 at 10:22:46AM -0600, Tycho Andersen wrote:
> > On Thu, Sep 06, 2018 at 06:15:18PM +0200, Jann Horn wrote:
> > > On Thu, Sep 6, 2018 at 5:29 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > > The idea here is that the userspace handler should be able to pass an fd
> > > > back to the trapped task, for example so it can be returned from socket().
> > > [...]
> > > > diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
> > > > index d1498885c1c7..1c0aab306426 100644
> > > > --- a/Documentation/userspace-api/seccomp_filter.rst
> > > > +++ b/Documentation/userspace-api/seccomp_filter.rst
> > > > @@ -235,6 +235,9 @@ The interface for a seccomp notification fd consists of two structures:
> > > >          __u64 id;
> > > >          __s32 error;
> > > >          __s64 val;
> > > > +        __u8 return_fd;
> > > > +        __u32 fd;
> > > > +        __u32 fd_flags;
> > >
> > > Normally,  syscalls that take an optional file descriptor accept a
> > > signed 32-bit number, with -1 standing for "no file descriptor". Is
> > > there a reason why this uses a separate variable to signal whether an
> > > fd was provided?
> >
> > No real reason other than I looked at the bpf code and they were using
> > __u32 for bpf (but I think in their case the fd args are not
> > optional). I'll switch it to __s32/-1 for the next version.
>
> Oh, I think there is a reason actually: since this is an API addition,
> the "0" value needs to be the previously default behavior if userspace
> doesn't specify it. Since the previously default behavior was not to
> return an fd, and we want to allow fd == 0, we need the extra flag to
> make this work.
>
> This is really only a problem because we're introducing this stuff in
> a second patch (mostly to illustrate how extending the response
> structure would work). I could fold this into the first patch if we
> want, or we could keep the return_fd bits if the illustration is
> useful.

I feel like adding extra struct fields just so that it is possible to
write programs against the intermediate new API between two kernel
commits is taking things a bit far.
