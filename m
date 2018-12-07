Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17643C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAAE20989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHXsqgtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAAE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeLGBje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:39:34 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43988 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGBjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:39:32 -0500
Received: by mail-ua1-f68.google.com with SMTP id z11so865883uaa.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 17:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6teGcfJ5GPLKZYIwA7JP22Ly6vDLlFf+78gQtNDaTz8=;
        b=lHXsqgtbiGzQ1sA3ZsPRQKCa11Y7TbKQrJ3BhCG4K2B2lRYNRYyBlodAq7Z1K1jmfi
         c4yIjSVmuMUwWDVBekoAH5RFQagwIVkXThxjIf5Atu86CVqEEn5dNBY7Ph4F5ZsjT85P
         dBUw7Y2kL2XBkXJwTDnW9ZPfPP79aoie4l9BvHS/3zC/S5uymDgRhBJzrZr4aGsn0HU8
         D+eCX8lYd62RN+KBgPj2aYKSnsqDkCByaA0RvQyfN9phzn48sj5H7yXAMPeALzAqO6pr
         +in8ta8udf8lIwXnXqIhoL6c787hNDrOzOa78hpQyihcorZYoODxhwMhFmlSldDqUE0R
         ZJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6teGcfJ5GPLKZYIwA7JP22Ly6vDLlFf+78gQtNDaTz8=;
        b=sFy9BpfWCiIN+KK7+Uu/HwpGet6AuShDzhamE+a/upu5VZqoezPCSwiqDknQva9w3z
         p4kcZYBKNkpU/AYg3RixGDej6ythX/4uflvCzJC8qymm9zqyDTLsE4OxSpU5eTMzMH53
         kEBKeBu3Tl/dAaoLmPx5vZN2bRzw/++V/3DPkL+0bpIxjYPzPi7DaYuvDs0MkIhtVFya
         v/3fYYykYdLFwcJI4NWqLSRLRtMj12JWXM1uJXg3iqX+89zMfAqCefeaMgLPzrRSLRAG
         9oq46K9UVU+l9a56zPwHIOJgO+cBmjwsxKSNaEdhXwoPeupIMbBQzQPXlaX+i9yzksP0
         l0Ng==
X-Gm-Message-State: AA+aEWa8SrWtj8Av3KG05BMfB4DKH2iae800Ass6aen99y2nvV/QFHnj
        qaJaxFW8MjuNks7f9sI8Ahrxnbf4BwVtt/ofFMkekw==
X-Google-Smtp-Source: AFSGD/V7WJgG9vHqYS1hC7dFvycU+c+Zthw6j51hYwcYQ/KAvR2aQZvEvq6c8T64/2EKJpHHI3ACChE765GaeBLI5ek=
X-Received: by 2002:ab0:72a:: with SMTP id h39mr119611uah.11.1544146771009;
 Thu, 06 Dec 2018 17:39:31 -0800 (PST)
MIME-Version: 1.0
References: <D372C766-572C-4897-8F02-2FD0E72CCFAC@brauner.io>
 <875zw6bh2z.fsf@xmission.com> <20181206193017.wpxls5p3zgjd6rv2@brauner.io>
 <871s6u9z6u.fsf@xmission.com> <20181206213152.gvci7ijr3dokew7w@brauner.io>
 <87o99y72gi.fsf@xmission.com> <20181206223948.gyfdtkgbhtozmpsp@brauner.io>
 <20181206231742.xxi4ghn24z4h2qki@brauner.io> <20181207003124.GA11160@mail.hallyn.com>
 <CAKOZuevgF7ObKcVvu-iuNK3xLMX2Ze_S+adBEGNZCdfXRibh1A@mail.gmail.com> <20181207005917.GA11302@mail.hallyn.com>
In-Reply-To: <20181207005917.GA11302@mail.hallyn.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 6 Dec 2018 17:39:18 -0800
Message-ID: <CAKOZuesqmPvYoibx3MvVj86EMWRRW4My=7n6iiiBJa+MXo-GJA@mail.gmail.com>
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>, tglx@linutronix.de,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 4:59 PM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Thu, Dec 06, 2018 at 04:34:54PM -0800, Daniel Colascione wrote:
> > On Thu, Dec 6, 2018 at 4:31 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > >
> > > On Fri, Dec 07, 2018 at 12:17:45AM +0100, Christian Brauner wrote:
> > > > On Thu, Dec 06, 2018 at 11:39:48PM +0100, Christian Brauner wrote:
> > > > > On Thu, Dec 06, 2018 at 03:46:53PM -0600, Eric W. Biederman wrote:
> > > > > > Christian Brauner <christian@brauner.io> writes:
> > > > > >
> > > > > > >> Your intention is to add the thread case to support pthreads once the
> > > > > > >> process case is sorted out.  So this is something that needs to be made
> > > > > > >> clear.  Did I miss how you plan to handle threads?
> > > > > > >
> > > > > > > Yeah, maybe you missed it in the commit message [2] which is based on a
> > > > > > > discussion with Andy [3] and Arnd [4]:
> > > > > >
> > > > > > Looking at your references I haven't missed it.  You are not deciding
> > > > > > anything as of yet to keep it simple.  Except you are returning
> > > > > > EOPNOTSUPP.  You are very much intending to do something.
> > > > >
> > > > > That was clear all along and was pointed at every occassion in the
> > > > > threads. I even went through the hazzle to give you all of the
> > > > > references when there's lore.kernel.org.
> > > > >
> > > > > >
> > > > > > Decide.  Do you use the flags parameter or is the width of the
> > > > > > target depending on the flags.
> > > >
> > > > Ok, let's try to be constructive. I understand the general concern for
> > > > the future so let's put a contract into the commit message stating that
> > > > the width of the target aka *what is signaled* will be based on a flag
> > > > parameter if we ever extend it:
> > > >
> > > > taskfd_send_signal(fd, SIGSTOP, NULL, TASKFD_PGID);
> > > > taskfd_send_signal(fd, SIGSTOP, NULL, TASKFD_TID);
> > > >
> > > > with the current default being
> > > >
> > > > taskfd_send_signal(fd, SIGSTOP, NULL, TASKFD_PID);
> > > >
> > > > This seems to me the cleanest solution as we only use one type of file
> > > > descriptor. Can everyone be on board with this? If so I'm going to send
> > > > out a new version of the patch.
> > > >
> > > > Christian
> > >
> > > I'm on board with this, but I think you need to also clarify what exactly
> > > the fd stands for.  I think that (a) userspace should not have to care
> > > about the struct pid implementation, and so (b) the procfd should stand
> > > for all the pids.  So when taskfd_send_signal(fd, SIGSTOP, NULL, TASKFD_PGID)
> > > becomes implemented, then open(/proc/5) will pin all three pids, as will
> > > open(/proc/5/task/6).
> >
> > This change doesn't "pin" any PID, and it makes no sense to make a
> > process FD stand for all its threads. What does that even mean?
>
> Currently the patch relies on the procfd inode saving a copy to the PIDTYPE_PID
> pid.

struct pid doesn't have a type field. The interpretation depends on
the caller's use of the struct pid, and in the current path, that's
PIDTYPE_PID. What, specifically, is wrong with the current approach?

> I'm not sure offhand, can it go to the PIDTYPE_PGID from that after the
> task has died, or not?   I didn't think so.  If it can then great.

You're arguing that something that does, in fact, work, is somehow
broken in some unspecified way. The kill_pid_info lookup works fine.
What, specifically, is wrong with the semantics as implemented?

> The point is (a) these are details which should not have to bother userspace,

These details *don't* bother userspace.

You're raising concerns that are either imaginary or long-since
addressed. Does the patch cause some kind of maintenance burden? No,
it doesn't, not moreso than any other piece of code. Does the
interface have unclear semantics? No, it clearly sends a signal to a
process, just like kill. Does the patch expose kernel implementation
details? No, it doesn't, because the interface is simply not defined
in terms of these details. Do we need to change how signal delivery
works? No, because if it's fine for kill, it's fine for this facility,
and if some future signal cleanup separates the cases more, that
cleanup can change this code as well.

The change is well-documented, simple, extensible, and addresses an
actual problem. Every legitimate technical criticism has now been
addressed. I don't understand where this opposition is coming from,
since the objections refer to nothing that's actually in the patch or
exposed to the user.

> and (b) how to decide who we're sending the signal to (tid/pid/pgid) should
> be specified in precisely one way.  So either a flag, or comign from the type
> of fd that was opened.

You can't send signals to a thread with the current patch. There's no
ambiguity in providing zero ways to do something.
