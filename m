Return-Path: <christian.brauner@ubuntu.com>
X-Google-Smtp-Source: AIpwx4/1JTVxgrOl2CyUXBFoo4MSXhB93fQJqxR9xxUEWQ2Qur3AG2fuGTiThdhQdXOGEAWf/Xgo
ARC-Seal: i=1; a=rsa-sha256; t=1523349735; cv=none;
        d=google.com; s=arc-20160816;
        b=HCd+eA1E9snCK/T1K9v2w3GsKQV7mc5jxAjtogqx2iMAoZhRiXzcizfb2JK7uThNBg
         L2Ccc5M0QtjX3zYZHwMB+aCuhiyuvhoy8jy1F1vDp45Exj1tn7bH+xLni760yEjwx7/E
         icM8EOZpCF+AdUdqQMCxuoNnbhyHcB8zlD9hkSfXL3pWOxL6atJ9UyzYjOPbijnOIwkJ
         F4S/tOiC2rYa9i752hkEhBYRTrEGHLWYq1qQyYIybO4oHjsxx1fK7uo0J+ptLzwzM6e4
         c/BV3tnR5fj9heAl5NCi8dI8OD0Oq4hxo7IIgSX7CYtbuOhdlyBp2uhNyMn0oxM3NbXe
         e1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=M42kDVVoeY9YQa8lNusSNyCHssAjjTQN49WDF7mvIxs=;
        b=u7rBCp2xRW7j3DVkl44zVOb27te79AgePl1iiFx7WpFgB+eHVmQzWvllEy4X6bD2vM
         6HQxLWDTukPGyVcESGM/lZWz+W2IeNh0wfY4u1K6etx+DVl1TF3BifYzCbQ3DE1wm3xP
         imzDa5g4QlP7+HFV44dr2eDKlrGxp1N8k8F5jf/G3RxkyD2JtHx3tzWE55j0M2w3pGGv
         IrIzBgZKOPvwj9EUpnAo4FsobXvjzROtbzL/g+tm385SCIa7Y7zn5s2eEmDsEjR/AoQc
         btiNMcU08gOOkoY80t+8xl7NCQxXQ7lk8g7Emnx4oKrnH5uM6KsBAhSS33pYuHvULuDa
         ViTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.241.60.215 is neither permitted nor denied by best guess record for domain of christian.brauner@ubuntu.com) smtp.mailfrom=christian.brauner@ubuntu.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.241.60.215 is neither permitted nor denied by best guess record for domain of christian.brauner@ubuntu.com) smtp.mailfrom=christian.brauner@ubuntu.com
Date: Tue, 10 Apr 2018 10:42:09 +0200
From: Christian Brauner <christian.brauner@ubuntu.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
	ebiederm@xmission.com, torvalds@linux-foundation.org,
	gregkh@linuxfoundation.org, containers@lists.linux-foundation.org
Subject: Re: [PATCH 4/4 v5 RESEND] selftests: add devpts selftests
Message-ID: <20180410084208.GA14520@mailbox.org>
References: <20180313165527.24038-1-christian.brauner@ubuntu.com>
 <20180313165527.24038-5-christian.brauner@ubuntu.com>
 <87efjnbn0j.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87efjnbn0j.fsf@concordia.ellerman.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594842300602680139?=
X-GMAIL-MSGID: =?utf-8?q?1597347971817477608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 04:20:44PM +1000, Michael Ellerman wrote:
> Hi Christian,
> 
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> > index 7442dfb73b7f..dbda89c9d9b9 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -7,6 +7,7 @@ TARGETS += cpufreq
> >  TARGETS += cpu-hotplug
> >  TARGETS += efivarfs
> >  TARGETS += exec
> > +TARGETS += filesystems
>    ^ This, and ...
> 
> > diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
> > index 13a73bf725b5..4e6d09fb166f 100644
> > --- a/tools/testing/selftests/filesystems/Makefile
> > +++ b/tools/testing/selftests/filesystems/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -TEST_PROGS := dnotify_test
> > +TEST_PROGS := dnotify_test devpts_pts
>                  ^
>                  this ...
> 
> Have the unfortunate effect of running dnotify_test as part of the
> default selftest run.
> 
> dnotify_test boils down to:
> 
> 	while (1) {
> 		pause();
> 		printf("Got event on fd=%d\n", event_fd);
> 	}
> 
> 
> ie. an infinite loop :)

Hi Michael,

Ugh, didn't notice this before. Weird test.

> 
> I'll send a patch to fix it.

Excellent, you can likely route it through Greg's tty tree.

Thanks!
Christian
