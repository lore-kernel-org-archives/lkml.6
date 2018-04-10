Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeDJJmT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:42:19 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:62432 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeDJJmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:42:18 -0400
Date: Tue, 10 Apr 2018 11:41:36 +0200
From: Christian Brauner <christian.brauner@getenv.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        gregkh@linuxfoundation.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 4/4 v5 RESEND] selftests: add devpts selftests
Message-ID: <20180410094136.GA3438@mailbox.org>
References: <20180313165527.24038-1-christian.brauner@ubuntu.com>
 <20180313165527.24038-5-christian.brauner@ubuntu.com>
 <87efjnbn0j.fsf@concordia.ellerman.id.au>
 <20180410084208.GA14520@mailbox.org>
 <87bmerbe1f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bmerbe1f.fsf@concordia.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 07:34:36PM +1000, Michael Ellerman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> > On Tue, Apr 10, 2018 at 04:20:44PM +1000, Michael Ellerman wrote:
> >> Christian Brauner <christian.brauner@ubuntu.com> writes:
> >> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> >> > index 7442dfb73b7f..dbda89c9d9b9 100644
> >> > --- a/tools/testing/selftests/Makefile
> >> > +++ b/tools/testing/selftests/Makefile
> >> > @@ -7,6 +7,7 @@ TARGETS += cpufreq
> >> >  TARGETS += cpu-hotplug
> >> >  TARGETS += efivarfs
> >> >  TARGETS += exec
> >> > +TARGETS += filesystems
> >>    ^ This, and ...
> >> 
> >> > diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
> >> > index 13a73bf725b5..4e6d09fb166f 100644
> >> > --- a/tools/testing/selftests/filesystems/Makefile
> >> > +++ b/tools/testing/selftests/filesystems/Makefile
> >> > @@ -1,5 +1,5 @@
> >> >  # SPDX-License-Identifier: GPL-2.0
> >> > -TEST_PROGS := dnotify_test
> >> > +TEST_PROGS := dnotify_test devpts_pts
> >>                  ^
> >>                  this ...
> >> 
> >> Have the unfortunate effect of running dnotify_test as part of the
> >> default selftest run.
> >> 
> >> dnotify_test boils down to:
> >> 
> >> 	while (1) {
> >> 		pause();
> >> 		printf("Got event on fd=%d\n", event_fd);
> >> 	}
> >> 
> >> 
> >> ie. an infinite loop :)
> >
> > Hi Michael,
> >
> > Ugh, didn't notice this before. Weird test.
> 
> No worries. It looks like it was copied from Documentation where it was
> really just sample code, rather than a test.
>  
> >> I'll send a patch to fix it.
> >
> > Excellent, you can likely route it through Greg's tty tree.
> 
> I've sent it to the kselftest list as well as Greg, so whoever wants to
> merge it is fine by me.

Perfect, thanks!
Christian
