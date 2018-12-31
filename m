Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97362C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A51121871
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miLLMeLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeLaMDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 07:03:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36610 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeLaMDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 07:03:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so23327693otk.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 04:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8dBJmLcQdaLLq1HdXuuJNw83XKuooJ1ZctjUGhMN7o=;
        b=miLLMeLcRBAz/geft3qlQi7pchr4kE9mJdo4IvWeP/4crlSQkz8IM8eGS4uMqcbEJg
         ynCSpSyVm8oJ8Q1999w/Wh9fz3eUmsntnJ7Dbv4ovUa0gOYA//D3mU+Kcj/TD2ymTGew
         j6Ta51e7ut1q3UzzreXFxKnOLAOHTi4Gn/v8gvrcrOh8kOzAzf9R+/6WN5VDJ2/JiixV
         MrDjRR/PnCMW7JELNm1Mw2B6ZCZqzpwai8j0Mg9AIZYw1bLrNdf8s6rF7Jm/cBiaYeOH
         2FqouJcMXr+TsmJYh2GfLk3xkCa6yvDHsIPp2Zg4ltTs7a8jjhE9K9dO8NCPa3TV16ms
         Xh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8dBJmLcQdaLLq1HdXuuJNw83XKuooJ1ZctjUGhMN7o=;
        b=uIxuZvkgui7f0XAi0bOUvVKQyBhgqE+0rvrZBjbb4f5WCavSWvrXS/XwW2VjZYBWBC
         c2Hx3FKNDO5MMSNvM7MD8BcTpeWJQDnrrqYfTcnB6B4YNcsmuzfF2WH9Bf1zh7w3Dx8P
         KKhzpe0eQZwr+NarefDef7fUlv3ZeiNfGbYRQlS17L4sX8HORfOiXG+kZP1pAADa5gJo
         fOJOcmXHNYILxIAYsXbPVy4iVdhsGe6dg374Ucwv5k/Zy91h9dn7fUmiMlJCtPlOk+CL
         OEVgbPweCGVKtMmLQXGZtHhGkmxKuuUxeivZqDJSvbFytERehTS85eF3xCxRd2o3YkD1
         ksbA==
X-Gm-Message-State: AJcUukcp7UUQNpsvhei5VuDzSRI1VRDYM09C3WT0e2FF3hu7gEsHJnK2
        3KCu+MG0O19h6XBo8W4l1BsztIGf+wNukxmO1+xMBA==
X-Google-Smtp-Source: ALg8bN7G5yxWG0yuzNVzNBDCaR1i4N5+zTh0cMM7rCGErPa11EKjlk4VfP6Sc8FvIcvwlQEH1ndLMbPvQhcYBWjXA9A=
X-Received: by 2002:a9d:460e:: with SMTP id y14mr26713852ote.198.1546257781654;
 Mon, 31 Dec 2018 04:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20181230132856.24095-1-jlee@suse.com> <20181230132856.24095-3-jlee@suse.com>
 <20181230144835.GB18985@kroah.com> <20181231093851.GN3506@linux-l9pv.suse> <20181231104055.GB27420@kroah.com>
In-Reply-To: <20181231104055.GB27420@kroah.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 31 Dec 2018 13:02:35 +0100
Message-ID: <CAG48ez3-YEVsyuk1H6hjGy9Ogm-z46bmdnqy0JbW9YL297FsTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / Sleep: Check the file capability when writing
 wake lock interface
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        joeyli <jlee@suse.com>, Andy Lutomirski <luto@kernel.org>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 11:41 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 31, 2018 at 05:38:51PM +0800, joeyli wrote:
> > Hi Greg,
> >
> > On Sun, Dec 30, 2018 at 03:48:35PM +0100, Greg Kroah-Hartman wrote:
> > > On Sun, Dec 30, 2018 at 09:28:56PM +0800, Lee, Chun-Yi wrote:
> > > > The wake lock/unlock sysfs interfaces check that the writer must has
> > > > CAP_BLOCK_SUSPEND capability. But the checking logic can be bypassed
> > > > by opening sysfs file within an unprivileged process and then writing
> > > > the file within a privileged process. The tricking way has been exposed
> > > > by Andy Lutomirski in CVE-2013-1959.
> > >
> > > Don't you mean "open by privileged and then written by unprivileged?"
> > > Or if not, exactly how is this a problem?  You check the capabilities
> > > when you do the write and if that is not allowed then, well
> > >
> >
> > Sorry for I didn't provide clear explanation.
> >
> > The privileged means CAP_BLOCK_SUSPEND but not file permission. The file permission
> > has already relaxed for non-root user. Then the expected behavior is that non-root
> > process must has CAP_BLOCK_SUSPEND capability for writing wake_lock sysfs.
> >
> > But, the CAP_BLOCK_SUSPEND restrict can be bypassed:
> >
> > int main(int argc, char* argv[])
> > {
> >         int fd, ret = 0;
> >
> >         fd = open("/sys/power/wake_lock", O_RDWR);
> >         if (fd < 0)
> >                 err(1, "open wake_lock");
> >
> >         if (dup2(fd, 1) != 1) // overwrite the stdout with wake_lock
> >                 err(1, "dup2");
> >         sleep(1);
> >         execl("./string", "string");  //string has capability
> >
> >         return ret;
> > }
> >
> > This program is an unpriviledged process (has no CAP_BLOCK_SUSPEND), it opened
> > wake_lock sysfs and overwrited stdout. Then it executes the "string" program
> > that has CAP_BLOCK_SUSPEND.
>
> That's the problem right there, do not give CAP_BLOCK_SUSPEND rights to
> "string".  If any user can run that program, there's nothing the kernel
> can do about this, right?  Just don't allow that program on the system :)
>
> > The string program writes to stdout, which means that it writes to
> > wake_lock. So an unpriviledged opener can trick an priviledged writer
> > for writing sysfs.
>
> That sounds like a userspace program that was somehow given incorrect
> rights by the admin, and a user is taking advantage of it.  That's not
> the kernel's fault.

Isn't it? Pretty much any setuid program will write to stdout or
stderr; even the glibc linker code does so if you set LD_DEBUG.
(Normally the output isn't entirely attacker-controlled, but it is in
the case of stuff like "procmail", which I think Debian still ships as
setuid root.) setuid programs should always be able to safely call
read() and write() on caller-provided file descriptors. Also, you're
supposed to be able to receive file descriptors over unix domain
sockets and then write to them without trusting the sender. Basically,
the ->read and ->write VFS handlers should never look at the caller's
credentials, only the opener's (with the exception of LSMs, which tend
to do weird things to the system's security model).
