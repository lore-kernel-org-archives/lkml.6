Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754195AbeDZH1K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:27:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46832 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbeDZH1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:27:04 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>, Peter Anvin <hpa@zytor.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, Kevin Easton <kevin@guarana.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:timers/urgent] Revert: Unify CLOCK_MONOTONIC and CLOCK_BOOTTIME
Date: Thu, 26 Apr 2018 09:26:52 +0200
Message-ID: <2607066.J1TAXLeWPN@aspire.rjw.lan>
In-Reply-To: <20180426071925.GA30908@amd>
References: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org> <1862218.3bTVVn1vea@aspire.rjw.lan> <20180426071925.GA30908@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 26, 2018 9:19:25 AM CEST Pavel Machek wrote:
> Hi!
> 
> > > > For the record, I just run plain F27, obviously with my own kernel
> > > > (and a tweaked config, but it approaches just being a "make
> > > > localmodconfig" of the distro config).
> > > 
> > > So... I do have debian 8.10.
> > 
> > Does that use systemd at all?
> 
> pavel@duo:/data/l/linux$ systemd --version
> systemd 215
> +PAM +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ
> -SECCOMP -APPARMOR

OK
 
> > > With 4.17-rc1, I get "networking
> > > disabled" message from network manager (and broken network), about
> > > half of the time.

I'm not sure if NM is affected by systemd, though.

> > > But there's more visible symptom: suspend/resume with 4.16, machine is
> > > okay after resume. With 4.17-rc1, just after resume, display starts
> > > dimming and screensaver will kick in. MATE desktop.
> > 
> > Yeah, why not.  It thinks that you've been inactive for the duration of system
> > sleep. :-)
> 
> Well, its rather annoying.

Yes, it is, no question about that.

> "Wake up!" (hitting a key) "OOh, I'm slowly
> waking up.." (few seconds, wakeup is not instant) "and now I'm going
> back to sleep".

I just wanted to say that you could expect that if the clock used by it
was counting over suspend/resume.
