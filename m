Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FEFC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9029720834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GdZClevA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9029720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJYWSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:18:46 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44246 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeJYWSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:18:46 -0400
Received: by mail-oi1-f195.google.com with SMTP id k19-v6so652829oic.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CAKsmhGwphcLYdeKebciBpfeYA9rdDjFD/uow+o+w7A=;
        b=GdZClevAy3MNu2TJeFu7kepEgmq1B32RuMQD9DsMWFqcCzRBOVYR5A8QkJ9KhxoVaD
         E/kVsOF0uSy+WMYG7+VqGtHJ3azsK4EKIi9U0v31VRvvvcU9WXLJqvVQsKhDap4k4MUn
         K7CUF2Pjcnb+fiiP8jJ4J0Cdc4msZGI4ZZ6hcAGnkWRun21IIxl3WkM9k/RiRu8VT1t0
         oXqC7AgULC8Brm+hJSCQ+T8+b6NudVa2fF4al0RlWmLapodQ1xpsxZmUVXGGr7tnYZL5
         MwOHoD4eponJOiaLfaN8G/5lpa7Gi0F4/YStKqZNxl4a8RtVqbXMsF5QeEJQJMi+NIJm
         oc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAKsmhGwphcLYdeKebciBpfeYA9rdDjFD/uow+o+w7A=;
        b=EqUbR2ZgfwTlBIHY1SR5RWbH8KLuacG45OeQOk92JWKWiUgE9nI1tX7X7NSEJsiuZF
         XlQ1pUmRNWw1Q9zWp3Ej8uMTVzDnrhgGhV8dXt/uC3bnjZciuJZCGkPTo/NouQ+i8a+5
         rD2ki/8jnrJwZ8LXKXJS8iLe4B8N0DnkonZonAWc+O0vmjRw+RAUemkvME1Ce0Ubo+Bs
         P/pVOKN/QgzsSi1v3yiT9M+ygdFeiDQLI+0nLtTK4cxHHZoC4g4bcJsmXO/6h2ufcqqE
         BiaUVMvPLLLpaCHtCxOoFpEF6BSITc5mhyO6ZPSbMjoV5GpZEpvbZbNB/lLhbckNdapZ
         0sPg==
X-Gm-Message-State: AGRZ1gIgfyvWnilMosPllowbM4/8KbTXF9WvE1xroz5DktbCTaDfyLXP
        bjtXwF7SGJWaiJCCm1TGizJVjOrYo6E33gVLroxmPQ==
X-Google-Smtp-Source: AJdET5fGp0p353JoApjSX6xR2DJrXZ6uTr/JXfeJBtQubpgUGxl/mzLuUYALqSN15nNFJ9mW0zFcGpJaorSrF0gBxoQ=
X-Received: by 2002:aca:c045:: with SMTP id q66-v6mr518965oif.22.1540475155893;
 Thu, 25 Oct 2018 06:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com> <87sh0vpj5q.fsf@xmission.com>
In-Reply-To: <87sh0vpj5q.fsf@xmission.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 25 Oct 2018 15:45:29 +0200
Message-ID: <CAG48ez2aJD1wcz3UjhaQvgqhg5UMeQ_-iMZesA=SfhYwUdGGyA@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/signal: Signal-based pre-coredump notification
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     enkechen@cisco.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, deller@gmx.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian@brauner.io, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Dave.Martin@arm.com,
        mchehab+samsung@kernel.org, Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        guro@fb.com, Marcos Souza <marcos.souza.org@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, linux@dominikbrodowski.net,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        yang.shi@linux.alibaba.com, Kees Cook <keescook@chromium.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Victor Kamensky <kamensky@cisco.com>,
        xe-linux-external@cisco.com, sstrogin@cisco.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 3:30 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Enke Chen <enkechen@cisco.com> writes:
> > For simplicity and consistency, this patch provides an implementation
> > for signal-based fault notification prior to the coredump of a child
> > process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
> > be used by an application to express its interest and to specify the
> > signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
> > signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
> >
> > Changes to prctl(2):
> >
> >    PR_SET_PREDUMP_SIG (since Linux 4.20.x)
> >           Set the child pre-coredump signal of the calling process to
> >           arg2 (either SIGUSR1, or SIUSR2, or SIGCHLD, or 0 to clear).
> >           This is the signal that the calling process will get prior to
> >           the coredump of a child process. This value is cleared across
> >           execve(2), or for the child of a fork(2).
> >
> >           When SIGCHLD is specified, the signal code will be set to
> >           CLD_PREDUMP in such an SIGCHLD signal.
[...]
> Ugh.  Your test case is even using signalfd.  So you don't even want
> this signal to be delivered as a signal.

Just to make sure everyone's on the same page: You're suggesting that
it might make sense to deliver the pre-dump notification via a new
type of file instead (along the lines of signalfd, timerfd, eventfd
and so on)?
