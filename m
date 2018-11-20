Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39655C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C4E2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Ab0LcbOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C4E2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeKTU7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:59:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44218 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeKTU7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:59:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so707640pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 02:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/EFxstJMLDS25mXkSsk0TprE8ahyWLiTIe0oxvOTKDk=;
        b=Ab0LcbOukpl1RKj4bXR4S7uMqtG+SHfmhkNUsSiDuRCuxofS3HLEP4lwD00zSmsa5z
         yhJheJW0YQt8QuehWG590K0TlgGqEPSsauD8BaCk6KopnxgfcZwWnpgPe1k276LKSdTl
         V8EUY7fdsdvPpQOFG5xEQcK1mmFF5Xh1uvq64yQYFJW7o4gqeGhmWPqUP8/wMFLCCTnw
         oEat9Iqb8mLFtW8XENtyzeo1bT/Za2541/0kTw1UYUI2oYIDALKzxbso/A2P547nbTSL
         LF+NIOn52Xp4eqfbJyULAsJ1TWvX5pZUh+iTrdMwvlWDkkYlC9rcODGuXg/IN1ZhGVHk
         WTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/EFxstJMLDS25mXkSsk0TprE8ahyWLiTIe0oxvOTKDk=;
        b=rLeGUvG0R5hyslbLxaR+HPgqBts4x+/aIsoTJaDprzkCI5avIiFaMRRjdfwwXVklPH
         NAVIUn4gPGORdYz5HCr5T6aq90T5Ij22ExQhhfv+q8VEdj9rZB/hDOjdecPljKP297KW
         c6Hddl1wgbkHI0XqflaGaMxmgLQIN0TXB27v2p4KScbeX/7TzZPWgwQl1ep6x+lKydDh
         vOujUp2aEpVFukh7iRSVX5cFmhnFcR3CtS+hTZ6cPHQXavaFS4N6cP0Gt3Hvhp1X+T9X
         LIvHfPzOluUrYbVAkZMFDyMI3lf68nl7IlYofLRBxcGsck0oGL3FKc8M2Xwv3voZsl01
         3nWQ==
X-Gm-Message-State: AA+aEWaIW7yD79WlqI2fHXxeFEMrHXVylqviRfOI2cS31BUdJS3ElSyf
        4fVHAQd7FMiqMBdE5SzhuJgYMQ==
X-Google-Smtp-Source: AJdET5f5peULasrrPDxDOPD1bSuYXYALzWePFZ1hyhDmKdywl8IQBV4NXrNq9CfS1S2tEP9KYRzccQ==
X-Received: by 2002:a63:310:: with SMTP id 16mr1344727pgd.79.1542709882898;
        Tue, 20 Nov 2018 02:31:22 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id c13sm7268033pfe.93.2018.11.20.02.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 02:31:22 -0800 (PST)
Date:   Tue, 20 Nov 2018 11:31:13 +0100
From:   Christian Brauner <christian@brauner.io>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181120103111.etlqp7zop34v6nv4@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181119202857.k5zw742xjfrw677j@yavin>
 <20181119205518.btew3vxwgva4w3zh@brauner.io>
 <20181119211810.73ptfhnwdmkngfi4@yavin>
 <20181119212126.u2nkijmula6wcfqi@brauner.io>
 <CAKOZuevEx6CbcxrR8eVZrUXDcN5y1GPsXdSoHfQteSQKypx0qw@mail.gmail.com>
 <20181119213722.z54huio5g4kuldxk@brauner.io>
 <CAKOZueup5L9Fd=tTK5g1415x0muLP_cPkxf4o26-kCPtH_caqw@mail.gmail.com>
 <87muq4xs2n.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87muq4xs2n.fsf@xmission.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 10:59:12PM -0600, Eric W. Biederman wrote:
> Daniel Colascione <dancol@google.com> writes:
> 
> > On Mon, Nov 19, 2018 at 1:37 PM Christian Brauner <christian@brauner.io> wrote:
> >>
> >> On Mon, Nov 19, 2018 at 01:26:22PM -0800, Daniel Colascione wrote:
> >> > On Mon, Nov 19, 2018 at 1:21 PM, Christian Brauner <christian@brauner.io> wrote:
> >> > > That can be done without a loop by comparing the level counter for the
> >> > > two pid namespaces.
> >> > >
> >> > >>
> >> > >> And you can rewrite pidns_get_parent to use it. So you would instead be
> >> > >> doing:
> >> > >>
> >> > >>     if (pidns_is_descendant(proc_pid_ns, task_active_pid_ns(current)))
> >> > >>         return -EPERM;
> >> > >>
> >> > >> (Or you can just copy the 5-line loop into procfd_signal -- though I
> >> > >> imagine we'll need this for all of the procfd_* APIs.)
> >> >
> >> > Why is any of this even necessary? Why does the child namespace we're
> >> > considering even have a file descriptor to its ancestor's procfs? If
> >>
> >> Because you can send file descriptors between processes and container
> >> runtimes tend to do that.
> >
> > Right. But why *would* a container runtime send one of these procfs
> > FDs to a container?
> >
> >> > it has one of these FDs, it can already *read* all sorts of
> >> > information it really shouldn't be able to acquire, so the additional
> >> > ability to send a signal (subject to the usual permission checks)
> >> > feels like sticking a finger in a dike that's already well-perforated.
> >> > IMHO, we shouldn't bother with this check. The patch would be simpler
> >> > without it.
> >>
> >> We will definitely not allow signaling processes in an ancestor pid
> >> namespace! That is a security issue! I can imagine container runtimes
> >> killing their monitoring process etc. pp. Not happening, unless someone
> >> with deep expertise in signals can convince me otherwise.
> >
> > If parent namespace procfs FDs or mounts really can leak into child
> > namespaces as easily as Aleksa says, then I don't mind adding the
> > check. I was under the impression that if you find yourself in this
> > situation, you already have a big problem.
> 
> There is one big reason to have the check, and I have not seen it
> mentioned yet in this thread.
> 
> When SI_USER is set we report the pid of the sender of the signal in
> si_pid.  When the signal comes from the kernel si_pid == 0.  When signal
> is sent from an ancestor pid namespace si_pid also equals 0 (which is
> reasonable).
> 
> A signal out to a process in a parent pid namespace such as SIGCHLD is
> reasonable as we can map the pid.  I really don't see the point of
> forbidding that.  From the perspective of the process in the parent pid
> namespace it is just another process in it's pid namespace.  So it
> should pose no problem from the perspective of the receiving process.
> 
> A signal to a process in a pid namespace that is neither a parent nor a
> descendent pid namespace would be a problem, as there is no well defined
> notion of what si_pid should be set to.  So for that case perhaps we
> should have something like a noprocess pid that we can set.  Perhaps we
> could set si_pid to 0xffffffff.  That would take a small extension to
> pid_nr_ns.
> 
> File descriptors are not namespaced.  It is completely legitimate to use
> file descriptors to get around limitations of namespaces.

Frankly, I don't see a good argument for why we would allow that even if
safe. I have not heard a legitimate use-case or need for this.
At this point I care about very simple semantics. Being able to signal
into ancestor pid namespaces and cousin namespaces is interesting but
makes the syscall more brittle and harder to understand.
Changing pid_nr_ns() might be the solution but this function is called
all over the place in the kernel and I'm not going to risk breaking
something by changing it for a feature that no one so far has ever
asked for.
If you are ok with this then we should hold off on this. We can always
add this feature later by removing the check when someone has a use-case
for it.
I'll send a v2 of the patch that keeps the restriction for now. If you
insist on it being removed we can make the change in a follow-up
iteration.

Christian

> 
> Adding limitations to a file descriptor based api because someone else
> can't set up their processes in such a way as to get the restrictions
> they are looking for seems very sad.
> 
> Frankly I think it is one of the better features of namespaces that we
> have to carefully handle and define these cases so that when the
> inevitable leaks happen you are not immediately in a world of hurt.  All
> of the other permission checks etc continue to do their job.  Plus you
> are prepared for the case when someone wants their containers to have an
> interesting communication primitive.
> 
> Eric
> 
> 
> 
> 
