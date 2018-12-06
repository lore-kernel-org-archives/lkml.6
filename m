Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965FEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCB120838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bjVjFYcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCB120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeLFTac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:30:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33654 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbeLFTaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:30:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so633904plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 11:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aP9MqadUSAqze7fmmjB1TUBDu5nK40IzOgjp14fhxfs=;
        b=bjVjFYcGhvg1OmEO6uYAMgcECz1sVF4qkzOyz6OnRlbsFx67P/+ugxrJCfnJMxkYFa
         /PkFwLPgJFwrN3pVbgcpCk2GlYrT6R9kV8KB4hp/po8XgT4JWSyCnu3bHlMbb4SvaCNj
         u1Yz2RLz8/bQjVrdf3A/LOD8sBnYsiLmNe4UG/D03RilDvWLAZdgCJHF2QCQMsWHJ7ho
         N9rkuu4MkMomWhqTD3hXKIzRAstIYKvThV+J5XtosxRok5imA8nE5rOhs7XSOHpWtzbD
         dYqpQKttO9GJPgjci+2wuPUoXDbviRln517hD4Ub0EGwOVpcJiNkoJOVFuTUWaXPg+5+
         hp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aP9MqadUSAqze7fmmjB1TUBDu5nK40IzOgjp14fhxfs=;
        b=olJR3iCdKbgWJewBvtwv3d62BYfncXsVETtqQN0KtCQTFGAuhobTd25oNp9I6VkBtQ
         q9Gsph7IasPUwRWRFEvPJ6BQb0U37FAFLO+AMyTha2Kj/Gj/SXenl0hAyNc9d+WaAdGU
         zsmyTmLsOYfrCn7tLTy0JXCJlpGko0+oxCG8QlAwo99lMtt1gaH0UJhKKxpOVBG/RIwD
         kvB0EUwBXjsR5+FDacXOY8gjOGDWlzQ6jTtB9DJU7eYT9XneBjauCdBCQb1Ze5Bm/ZmA
         sqmnmppi9/K4PEeqNHdfbhLytUzagiZlpaST+RjlD/IyKvQhGXRB0JXkgcqHat3CxQRB
         KF/Q==
X-Gm-Message-State: AA+aEWZubUpGZfKUdGjbCy5D58UlzDDSCGefoOr0+bIEzyiwoHLwYu1z
        3FkShltPnDqIy2PtXa/FYTMjuXR69Hm4Bg==
X-Google-Smtp-Source: AFSGD/X0qXubFBxD0AavwHjNpdCBFf8GNhCaAKJay5T9aJnLR6TB5JnWUqRsPHnA7OAs9tmrtQMH6w==
X-Received: by 2002:a17:902:ac8f:: with SMTP id h15mr28440273plr.245.1544124628707;
        Thu, 06 Dec 2018 11:30:28 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:b824:a031:b50e:f401])
        by smtp.gmail.com with ESMTPSA id v62sm2625073pfd.163.2018.12.06.11.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 11:30:28 -0800 (PST)
Date:   Thu, 6 Dec 2018 20:30:19 +0100
From:   Christian Brauner <christian@brauner.io>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, serge@hallyn.com, jannh@google.com,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        keescook@chromium.org, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
Message-ID: <20181206193017.wpxls5p3zgjd6rv2@brauner.io>
References: <20181206121858.12215-1-christian@brauner.io>
 <87sgzahf7k.fsf@xmission.com>
 <D372C766-572C-4897-8F02-2FD0E72CCFAC@brauner.io>
 <875zw6bh2z.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875zw6bh2z.fsf@xmission.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 01:17:24PM -0600, Eric W. Biederman wrote:
> Christian Brauner <christian@brauner.io> writes:
> 
> > On December 7, 2018 4:01:19 AM GMT+13:00, ebiederm@xmission.com wrote:
> >>Christian Brauner <christian@brauner.io> writes:
> >>
> >>> The kill() syscall operates on process identifiers (pid). After a
> >>process
> >>> has exited its pid can be reused by another process. If a caller
> >>sends a
> >>> signal to a reused pid it will end up signaling the wrong process.
> >>This
> >>> issue has often surfaced and there has been a push [1] to address
> >>this
> >>> problem.
> >>>
> >>> This patch uses file descriptors (fd) from proc/<pid> as stable
> >>handles on
> >>> struct pid. Even if a pid is recycled the handle will not change. The
> >>fd
> >>> can be used to send signals to the process it refers to.
> >>> Thus, the new syscall taskfd_send_signal() is introduced to solve
> >>this
> >>> problem. Instead of pids it operates on process fds (taskfd).
> >>
> >>I am not yet thrilled with the taskfd naming.
> >
> > Userspace cares about what does this thing operate on?
> > It operates on processes and threads.
> > The most common term people use is "task".
> > I literally "polled" ten non-kernel people for that purpose and asked:
> > "What term would you use to refer to a process and a thread?"
> > Turns out it is task. So if find this pretty apt.
> > Additionally, the proc manpage uses task in the exact same way (also see the commit message).
> > If you can get behind that name even if feeling it's not optimal it would be great.
> 
> Once I understand why threads and not process groups.  I don't see that
> logic yet.

The point is: userspace takes "task" to be a generic term for processes
and tasks. Which is what is important. The term also covers process
groups for all that its worth. Most of userspace isn't even aware of
that distinction necessarily.

fd_send_signal() makes the syscall name meaningless: what is userspace
signaling too? The point being that there's a lot more that you require
userspace to infer from fd_send_signal() than from task_send_signal()
where most people get the right idea right away: "signals to a process
or thread".

> 
> >>Is there any plan to support sesssions and process groups?
> >
> > I don't see the necessity.
> > As I said in previous mails:
> > we can emulate all interesting signal syscalls with this one.
> 
> I don't know what you mean by all of the interesting signal system
> calls.  I do know you can not replicate kill(2).

[1]: You cannot replicate certain aspects of kill *yet*. We have
established this before. If we want process group support later we do
have the flags argument to extend the sycall.

> 
> Sending signals to a process group the "kill(-pgrp)" case with kill
> sends the signals to an atomic snapshot of processes.  If the signal
> is SIGKILL then it is guaranteed that then entire process group is
> killed with no survivors.

See [1].

> 
> > We succeeded in doing that.
> 
> I am not certain you have.

See [1].

> 
> > No need to get more fancy.
> > There's currently no obvious need for more features.
> > Features should be implemented when someone actually needs them.
> 
> That is fair.  I don't understand what you are doing with sending
> signals to a thread.  That seems like one of the least useful
> corner cases of sending signals.

It's what glibc and Florian care about for pthreads and their our
biggest user atm so they get some I'd argue they get some say in this. :)

> 
> Eric
