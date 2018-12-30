Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7E4C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 23:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6B420828
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 23:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="cU4/X0EZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeL3X1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 18:27:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38354 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeL3X1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 18:27:17 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so21574912ede.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 15:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q8jSNdVsCfir3ZfP+QQoxe+2uq0bpqlX43VRhX8yuPE=;
        b=cU4/X0EZQjd6EyL/NbImFTxlXq59Bi73Vc+Qb8PB1maVoQxBYpZne3kIS5+8s4QD1o
         T1MsiBIqp4s7N0qUDfwnxH7epc7Oo3a4+Fw/m/+qzr+6UxCj4/5NYbjuJdhT2nXzh+1N
         STN5S35e09Jx9jAj4LlV8zTjxve6XpwDuvWrq6W3ZkjNOx9aB/X4WUF9Zl4gtlw7+uNd
         +GxbcUeYNv/PwK+vRxuRVzW3sygBovz5QvqyQeN1YIJcUDZ7LB15pWb+onYu93KdtLpp
         eYGZZzyc42u2e2t0EClcW1cdI8JNzjJcCrsizJ+yW/AWwN5zQHuC7jDCh5chvs9YdXRw
         bw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q8jSNdVsCfir3ZfP+QQoxe+2uq0bpqlX43VRhX8yuPE=;
        b=ju/tjT0ih+c9q50rfxS+3yVoHMvGjyuHgFO1ZQAo8cPBKoCP37CBMJv5L8D3E2SPdR
         aROdV0azDuh50GfufnQvOeRkSVCO0zObv0ezD6FdWCFDUj6ZakTkRkSZ+KiRcRQHUw88
         QrgZkhAyujQECJn3vmNzC48Ah4zL/cu8vsE2AMguC5NJQM23BrE8blGQMnV4lma+0Qv/
         cm877GY1mH4pkzdZD61MUD7iIzrZEmztTWJBxJHUQtmmeIoludP4pCiYCoSSTs2PdvmW
         cyWcfksw0d97XpRDQqEpXlNzWkReM4gEvmj50MMNryU7+nW0ckNrualV7SXMaXD32qmC
         HGcA==
X-Gm-Message-State: AJcUuke76IkkWfgkdkMMRbIs0cBFyqw/4rMw0OVAjL1OQHgLkE3sdXh6
        8c1oLMZZBXYNUQvTwYowoQl0Aw==
X-Google-Smtp-Source: ALg8bN7sHoRsDBhtIrnnk2cHrgmC9KJS/MTSekbvt3MBV6YVa5ZUOc6zaCxJBDEkW6sHrypRPmcNHg==
X-Received: by 2002:a17:906:3f55:: with SMTP id f21-v6mr1200592ejj.120.1546212434916;
        Sun, 30 Dec 2018 15:27:14 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:d6c:c95d:2ebe:c81e:96a0])
        by smtp.gmail.com with ESMTPSA id e35sm17112759eda.13.2018.12.30.15.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Dec 2018 15:27:14 -0800 (PST)
Date:   Mon, 31 Dec 2018 00:27:13 +0100
From:   Christian Brauner <christian@brauner.io>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, keescook@chromium.org,
        akpm@linux-foundation.org, jannh@google.com, oleg@redhat.com,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, dancol@google.com,
        timmurray@google.com, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH v6 2/2] selftests: add tests for pidfd_send_signal()
Message-ID: <20181230232711.7aayb7vnhogbv4co@brauner.io>
References: <20181229222756.30027-1-christian@brauner.io>
 <20181229222756.30027-2-christian@brauner.io>
 <20181230210245.GA30252@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181230210245.GA30252@mail.hallyn.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 03:02:45PM -0600, Serge Hallyn wrote:
> On Sat, Dec 29, 2018 at 11:27:56PM +0100, Christian Brauner wrote:
> > As suggested by Andrew Morton in [1] add selftests for the new
> > sys_pidfd_send_signal() syscall.
> > This tests whether we can send a signal to an existing process and whether
> > sending a signal to a process that has already exited fails with ESRCH.
> > 
> > [1]: https://lore.kernel.org/lkml/20181228152012.dbf0508c2508138efc5f2bbe@linux-foundation.org/
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Serge Hallyn <serge@hallyn.com>
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>
> 
> Not saying you need to do this, but it would be neat if you could test
> sending to a pid which has been recycled :)

Yeah, I thought about it but it's a little weird code. First of all, we
can't set /proc/sys/kernel/pid_max to a very low value since this is a
system wide setting. So we need to recycle a lot via fork(). Something
along the lines of:
- unshare pid namespace
- fork to create pid 1 in new pid namespace
- cycle with fork() until pid > 300 since pids lower than 300 are
  reserved by the kernel.
  (That means if we simply use the first fork() after we created pid 1 we
  would never be able to recycle the pid since we skip over it. :))
- get pidfd to the pid > 300 we just created
- wait on the pid > 300
- cycle via fork() until we have reached the same pid > 300 again
- send SIGSTOP to that recycled process
- test that we cannot send SIGCONT to this SIGSTOPed task via the pidfd we
  received before
- send SIGCONT to the SIGSTOPed recycled pid and exit

Christian

> 
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Andy Lutomirsky <luto@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Florian Weimer <fweimer@redhat.com>
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> > ---
> > /* Changelog */
> > v6:
> > - patch introduced
> > v5..v0:
> > - patch not present
> > ---
> >  tools/testing/selftests/Makefile           |   1 +
> >  tools/testing/selftests/pidfd/Makefile     |   6 +
> >  tools/testing/selftests/pidfd/pidfd_test.c | 130 +++++++++++++++++++++
> >  3 files changed, 137 insertions(+)
> >  create mode 100644 tools/testing/selftests/pidfd/Makefile
> >  create mode 100644 tools/testing/selftests/pidfd/pidfd_test.c
> > 
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> > index 24b9934fb269..63b0d8a0ebf7 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -27,6 +27,7 @@ TARGETS += net
> >  TARGETS += netfilter
> >  TARGETS += networking/timestamping
> >  TARGETS += nsfs
> > +TARGETS += pidfd
> >  TARGETS += powerpc
> >  TARGETS += proc
> >  TARGETS += pstore
> > diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
> > new file mode 100644
> > index 000000000000..deaf8073bc06
> > --- /dev/null
> > +++ b/tools/testing/selftests/pidfd/Makefile
> > @@ -0,0 +1,6 @@
> > +CFLAGS += -g -I../../../../usr/include/
> > +
> > +TEST_GEN_PROGS := pidfd_test
> > +
> > +include ../lib.mk
> > +
> > diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> > new file mode 100644
> > index 000000000000..edcd59979b10
> > --- /dev/null
> > +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> > @@ -0,0 +1,130 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#define _GNU_SOURCE
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <linux/types.h>
> > +#include <signal.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <syscall.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +
> > +#include "../kselftest.h"
> > +
> > +static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
> > +					unsigned int flags)
> > +{
> > +	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
> > +}
> > +
> > +static int signal_received;
> > +
> > +static void do_exit_success(int sig)
> > +{
> > +	signal_received = 1;
> > +}
> > +
> > +/*
> > + * Straightforward test to see whether pidfd_send_signal() works is to send
> > + * a signal to ourselves.
> > + */
> > +static int test_pidfd_send_signal_simple_success(void)
> > +{
> > +	int pidfd, ret;
> > +	const char *test_name = "pidfd_send_signal send SIGUSR1";
> > +
> > +	pidfd = open("/proc/self", O_DIRECTORY | O_CLOEXEC);
> > +	if (pidfd < 0)
> > +		ksft_exit_fail_msg(
> > +			"%s test: Failed to open process file descriptor\n",
> > +			test_name);
> > +
> > +	signal(SIGUSR1, do_exit_success);
> > +
> > +	ret = sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0);
> > +	close(pidfd);
> > +	if (ret < 0)
> > +		ksft_exit_fail_msg("%s test: Failed to send signal\n",
> > +				   test_name);
> > +
> > +	if (signal_received != 1)
> > +		ksft_exit_fail_msg("%s test: Failed to receive signal\n",
> > +				   test_name);
> > +
> > +	signal_received = 0;
> > +	ksft_test_result_pass("%s test: Sent signal\n", test_name);
> > +	return 0;
> > +}
> > +
> > +static void wait_for_pid(pid_t pid)
> > +{
> > +	int status, ret;
> > +
> > +again:
> > +	ret = waitpid(pid, &status, 0);
> > +	if (ret == -1) {
> > +		if (errno == EINTR)
> > +			goto again;
> > +
> > +		return;
> > +	}
> > +
> > +	if (ret != pid)
> > +		goto again;
> > +}
> > +
> > +static int test_pidfd_send_signal_exited_fail(void)
> > +{
> > +	int pidfd, ret, saved_errno;
> > +	char buf[256];
> > +	pid_t pid;
> > +	const char *test_name = "pidfd_send_signal signal exited process";
> > +
> > +	pid = fork();
> > +	if (pid < 0)
> > +		ksft_exit_fail_msg("%s test: Failed to create new process\n",
> > +				   test_name);
> > +
> > +	if (pid == 0)
> > +		_exit(EXIT_SUCCESS);
> > +
> > +	snprintf(buf, sizeof(buf), "/proc/%d", pid);
> > +
> > +	pidfd = open(buf, O_DIRECTORY | O_CLOEXEC);
> > +
> > +	wait_for_pid(pid);
> > +
> > +	if (pidfd < 0)
> > +		ksft_exit_fail_msg(
> > +			"%s test: Failed to open process file descriptor\n",
> > +			test_name);
> > +
> > +	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
> > +	saved_errno = errno;
> > +	close(pidfd);
> > +	if (ret == 0)
> > +		ksft_exit_fail_msg(
> > +			"%s test: Managed to send signal to process even though it should have failed\n",
> > +			test_name);
> > +
> > +	if (saved_errno != ESRCH)
> > +		ksft_exit_fail_msg(
> > +			"%s test: Expected to receive ESRCH as errno value but received %d instead\n",
> > +			test_name, saved_errno);
> > +
> > +	ksft_test_result_pass("%s test: Failed to send signal as expected\n",
> > +			      test_name);
> > +	return 0;
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	ksft_print_header();
> > +
> > +	test_pidfd_send_signal_simple_success();
> > +	test_pidfd_send_signal_exited_fail();
> > +
> > +	return ksft_exit_pass();
> > +}
> > -- 
> > 2.19.1
