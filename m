Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CC6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EE921874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="QzcxsxhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeL1Xhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 18:37:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38392 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeL1Xhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 18:37:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so22143946wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 15:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fGXqVmnlFdvBMBazXaxX8RQXGpXOzNVj0PDYM9hNvAA=;
        b=QzcxsxhKkqQUiJkE36iF7xoNBWiQR1gnXPDjJdA/4p6DNnToEq1E9vJ/21dnX8l1Mt
         jFzAz2jQ2bptr22bsnJ52uwheUwj4sCg5ewtHozkOuypVbDWd3kjVvplBZ/d5EqrzaNE
         Tn3EaGKIdprSRXCdlvpua756Iq/GGH3yHrJI0CtrZBFMaR/zVeh2jTKuf72YdiMrMASE
         8rGjrlsT2xLT+5KLPd/qiIKNIuhdFvku7p526P2Wo6VcPTmpnQQKnUZo2S6RyUOqssrJ
         2KpAmXgdz/NbyrByFSAEAyi55WfPR0FhP4ALmRMrK5BEFKNO6IlYW+x04SE1wDc5ykN9
         KojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fGXqVmnlFdvBMBazXaxX8RQXGpXOzNVj0PDYM9hNvAA=;
        b=jBim3bKw8v6t0Mw/CLXFoJjrXcoxcFRP1b3+u7IEs/wMSh+ka4V9TOlViuGVqF4h7Q
         tq28gOb0b+xg2y6Ol71B1BRudaU3zJoYwgkrDRnxcrCH0g17TByT8GVg2Vl7tE6oujQo
         QSwgbMPSxClilEenEdj3AVo6BPSP+jiA4h6DOrgaqY8ZbB+fh39LNuWv9WmFMpjWm13j
         2l2CrBhETwlfjreSMtO7l6Xo0oosqKAOpOuPzEsBayVqaPCtxdZAqIXViKHUIdS1b+Dz
         DNkrKeMZpLOqJRGmuLuGhVRD1cjgxtIy+OrhBae+UittGyZp/d6ECW2V/nzA/9ZRGlt1
         xfig==
X-Gm-Message-State: AJcUukfAkDcp4BZVeuX2NEU4e2PmBzwK7DEwBLi7EKyczHMXxu/LBpPQ
        zNH4hfKUztQk08rsMcwF3qUlIQ==
X-Google-Smtp-Source: ALg8bN41GF80Wg5igOq6+8latjruEVagJ/KlNyQFpgro17wQzus9luNS+By3zkIEkd1GX3wwxrVffA==
X-Received: by 2002:a5d:6487:: with SMTP id r7mr27291344wru.263.1546040248983;
        Fri, 28 Dec 2018 15:37:28 -0800 (PST)
Received: from brauner.io (p5B2A6FA4.dip0.t-ipconnect.de. [91.42.111.164])
        by smtp.gmail.com with ESMTPSA id a17sm18593469wma.15.2018.12.28.15.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 15:37:28 -0800 (PST)
Date:   Sat, 29 Dec 2018 00:37:26 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, serge@hallyn.com,
        keescook@chromium.org, jannh@google.com, oleg@redhat.com,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, dancol@google.com,
        timmurray@google.com, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH v5 RESEND] signal: add pidfd_send_signal() syscall
Message-ID: <20181228233725.722tdfgijxcssg76@brauner.io>
References: <20181228224853.26032-1-christian@brauner.io>
 <20181228152012.dbf0508c2508138efc5f2bbe@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181228152012.dbf0508c2508138efc5f2bbe@linux-foundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 03:20:12PM -0800, Andrew Morton wrote:
> On Fri, 28 Dec 2018 23:48:53 +0100 Christian Brauner <christian@brauner.io> wrote:
> 
> > The kill() syscall operates on process identifiers (pid). After a process
> > has exited its pid can be reused by another process. If a caller sends a
> > signal to a reused pid it will end up signaling the wrong process. This
> > issue has often surfaced and there has been a push to address this problem [1].
> > 
> > This patch uses file descriptors (fd) from proc/<pid> as stable handles on
> > struct pid. Even if a pid is recycled the handle will not change. The fd
> > can be used to send signals to the process it refers to.
> > Thus, the new syscall pidfd_send_signal() is introduced to solve this
> > problem. Instead of pids it operates on process fds (pidfd).

So most of the questions you ask have been extensively discussed in
prior threads. All of them have links above in the long commit message.

> 
> I can't see a description of what happens when the target process has
> exited.  Is the task_struct pinned by the fd?  Does the entire procfs

A reference to struct pid is kept. struct pid - as far as I understand -
was created exactly for the reason to not require to pin struct
task_struct. This is also noted in the comments to struct pid:
https://elixir.bootlin.com/linux/v4.20-rc1/source/include/linux/pid.h#L16

> directory remain visible?  Just one entry within it?  Does the pid

The same thing that happens when you currently keep an fd to /proc/<pid>
open.

> remain reserved?  Do attempts to signal that fd return errors? 

The pid does not remain reserved. Which leads back to your question
about what happens when you try to signal a process that has exited: you
get ESRCH.

> etcetera.  These behaviors should be described in the changelog and
> manipulate please.

I can add those questions to the changelog too.

> 
> The code in signal.c appears to be compiled in even when
> CONFIG_PROC_FS=y.  Can we add the appropriate ifdefs and an entry in
> sys_ni.c?

Without having looked super close at this from the top of my head I'd
say, yes we can.

> 
> A selftest in toole/testing/selftests would be nice.  And it will be
> helpful to architecture maintainers as they wire this up.

I can extend the sample program in the commit message to a selftest.

> 
> The feature doesn't have its own Kconfig setting.  Perhaps it should?
> It should presumably depend on PROC_FS.

Not sure why we should do this.

> 
> I must say that I dislike the linkage to procfs.  procfs is a
> high-level thing which is manipulated using syscalls.  To turn around
> and make a syscall dependent upon the presence of procfs seems just ...
> wrong.  Is there a cleaner way of obtaining the fd?  Another syscall
> perhaps.

We may do something like this in the future. There's another syscall
lined up at some point translate_pid() which we may extend to also give
back an fd to a process. For now the open() on /proc/<pid> is the
cleanest way of doing this.

> 
> This fd-for-a-process sounds like a handy thing and people may well
> think up other uses for it in the future, probably unrelated to
> signals.  Are the code and the interface designed to permit such future
> applications?  I guess "no" - it presently assumes that anything which

This too has been discussed in prior threads linked in the commit
message. Yes, it does permit of such extension and we have already
publicly discussed future extensions (e.g. wait maybe a new clone
syscall).

> is written to that fd is a signal.  Perhaps there should be a tag at
> the start of the message (which is what it is) which identifies the
> message's type?
> 
> Now I think about it, why a new syscall?  This thing is looking rather
> like an ioctl?

Again, we have had a lengthy discussion about this and by now we all
agree that a dedicated syscall makes more sense than an ioctl() for
security reasons, because processes are a core-kernel concept, and we
intend to extend this api with syscalls in the future (e.g. wait etc.
also discussed in prior threads linked in here). There's also a summary
article on lwn about parts of this (https://lwn.net/Articles/773459/).

Thanks!
Christian
