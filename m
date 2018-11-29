Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AC9C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C363420673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="D3v74xax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C363420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeK3KPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:15:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41428 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeK3KPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:15:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so1773919pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=37xWa5ppls1wBcn3ORaj0+L5Gz0YBCVILQxhZKoSFQo=;
        b=D3v74xaxjmaV2Q98XgwWS6ruPskB9hIrccOgMFOTAjEibQfg+jc9tl5FU2JjYTWUYu
         J+Ia1tj/xvBNEOfW0QsvXOiAFNyhB4OCNfGlfXaWJkqPdzTyZezlcuUrdJkxvKGj3WHL
         X9P00gUKkyZEvFoKMv9NIPqvCejjna1rCQU5RaKChOXC8mSJU23t+wWULKZifGiKjXgA
         6fCP0Sm2ZSTHUQ2Dt55hOlHXeGPzg6DHMcRF/Pow8UIqo+X9X1FB7zaxSWn7dLssrsUW
         X30eSrIlAOVGoz5xZ4RlXySs520wCRDbazZ8rIpdUknVmUCfLP1myMnleh4LCdZrq7DZ
         UcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=37xWa5ppls1wBcn3ORaj0+L5Gz0YBCVILQxhZKoSFQo=;
        b=GFlkUGsR8KVs4uma6CueZPZEXSKgunjq6jYQZJjy0dEONLJFQrh2bezDiXFpMuMX/A
         dx76UiDFTTjxtnQfbgT4tmiWk9E/gfCZSBAQ0lVGXRBUQQTaf5vJ2RppQC21RtvlmhOF
         ilwbLl2o0ATePXHxJRjvP2WTSlFqLnqDEhXmC9M3zU5czaaTC+OWT1ybibFOtP24OLrA
         OxF9Adweq0qQ++M4RCG6CIOgm3B0qi4ja5gi7S+Wuzqh6FG67XqeDaY1eVJZOF6fNnDW
         3rKvfCGqKCNgm3HRSto12WuGqhMtRsF78QBViENPez6ROotguA1O02RPNv7tJuQLPhlg
         GxAw==
X-Gm-Message-State: AA+aEWZoaH2jrIvXu81y6Ugpqy8Ek7sbi9bqUDbP1+oPQqVlREPt4S9W
        K3yKNhEAEWFf0LDjDTyKNvFVkQ==
X-Google-Smtp-Source: AFSGD/VaI+Krx6+6ZdUsuoRT4zyKf4Q1f42hP3RYrIPSy8iVIJCdQMYVcSNKwYSoJjqXW9xC6QfxdQ==
X-Received: by 2002:a62:190e:: with SMTP id 14mr3253200pfz.70.1543532909714;
        Thu, 29 Nov 2018 15:08:29 -0800 (PST)
Received: from cisco ([128.107.241.161])
        by smtp.gmail.com with ESMTPSA id v190sm4625799pfv.26.2018.11.29.15.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:08:28 -0800 (PST)
Date:   Thu, 29 Nov 2018 16:08:26 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
Message-ID: <20181129230826.GB4676@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029224031.29809-2-tycho@tycho.ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 04:40:30PM -0600, Tycho Andersen wrote:
> +	resp.id = req.id;
> +	resp.error = -512; /* -ERESTARTSYS */
> +	resp.val = 0;
> +
> +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);

So, it turns out this *doesn't* work, and the reason this test was
passing is because of poor hygiene on my part.

Per the documentation in include/linux/errno.h,

/*
 * These should never be seen by user programs.  To return one of ERESTART*
 * codes, signal_pending() MUST be set.  Note that ptrace can observe these
 * at syscall exit tracing, but they will never be left for the debugged user
 * process to see.
 */
#define ERESTARTSYS     512

So basically, if you respond with -ERESTARTSYS with no signal pending, you'll
leak it to userspace. It turns out this is already possible with
SECCOMP_RET_TRAP (and probably ptrace alone, although I didn't try it out),
see the program below.

The question is: do we care? If so, it seems like we may need to handle the
-ERESTARTSYS-style cases even when there is no signal pending. If we don't,
there's precedent for us to just do the same thing as what happens for
SECCOMP_RET_TRACE, but we should probably at least fix the docs.

Tycho


#include <stdio.h>
#include <stddef.h>
#include <stdbool.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <signal.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <sys/ptrace.h>
#include <sys/ioctl.h>
#include <inttypes.h>
#include <linux/filter.h>
#include <linux/seccomp.h>
#include <linux/ptrace.h>
#include <linux/elf.h>
#include <pthread.h>


static int filter_syscall(int syscall_nr)
{
	struct sock_filter filter[] = {
		BPF_STMT(BPF_LD+BPF_W+BPF_ABS, offsetof(struct seccomp_data, nr)),
		BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, syscall_nr, 0, 1),
		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_TRACE),
		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
	};

	struct sock_fprog bpf_prog = {
		.len = (unsigned short)(sizeof(filter)/sizeof(filter[0])),
		.filter = filter,
	};

	int ret;

	ret = syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER, 0, &bpf_prog);
	if (ret < 0) {
		perror("prctl failed");
		return -1;
	}

	return ret;
}

typedef struct {
        uint64_t        r15;
        uint64_t        r14;
        uint64_t        r13;
        uint64_t        r12;
        uint64_t        bp;
        uint64_t        bx;
        uint64_t        r11;
        uint64_t        r10;
        uint64_t        r9;
        uint64_t        r8;
        uint64_t        ax;
        uint64_t        cx;
        uint64_t        dx;
        uint64_t        si;
        uint64_t        di;
        uint64_t        orig_ax;
        uint64_t        ip;
        uint64_t        cs;
        uint64_t        flags;
        uint64_t        sp;
        uint64_t        ss;
        uint64_t        fs_base;
        uint64_t        gs_base;
        uint64_t        ds;
        uint64_t        es;
        uint64_t        fs;
        uint64_t        gs;
} user_regs_struct64;

int main(int argc, char **argv)
{
	pid_t pid;
	user_regs_struct64 regs;
	struct iovec iov = {.iov_base = &regs, .iov_len = sizeof(regs)};
	int status;

	pid = fork();

	if (pid == 0) {
		if (signal(SIGUSR1, signal_handler) == SIG_ERR) {
			perror("signal");
			exit(1);
		}

		if (filter_syscall(__NR_getpid) < 0)
			exit(1);

		/* i'm lazy, so sue me :) */
		sleep(1);

		errno = 0;
		pid = syscall(__NR_getpid);

		/*
		 * we get:
		 *   getpid(): -1, errno: 512
		 * probably should get
		 *   getpid(): <pid> errno: 0
		 */
		printf("getpid(): %d, errno: %d\n", pid, errno);
		exit(errno);
	}

	if (ptrace(PTRACE_ATTACH, pid, NULL, 0) < 0) {
		perror("ptrace attach");
		goto out;
	}

	if (waitpid(pid, NULL, 0) != pid) {
		perror("waitpid");
		goto out;
	}

	if (ptrace(PTRACE_SETOPTIONS, pid, NULL, PTRACE_O_TRACESECCOMP) < 0) {
		perror("ptrace setoptions");
		goto out;
	}

	if (ptrace(PTRACE_CONT, pid, NULL, 0) != 0) {
		perror("ptrace cont");
		goto out;
	}

	if (waitpid(pid, &status, 0) != pid) {
		perror("wait for trace");
		goto out;
	}

	if (status >> 8 != (SIGTRAP | (PTRACE_EVENT_SECCOMP<<8))) {
		printf("got bad trap event?\n");
		goto out;
	}

	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov) < 0) {
		perror("getregset");
		goto out;
	}

	/*
	 * Tell the syscall to restart. Per include/linux/errno.h this should
	 * only be set when signal_pending() is set. But we just won't send
	 * any signals to the process, and we'll see this in userspace.
	 */
	regs.ax = -512; /* -ERESTARTSYS */

	/*
	 * This makes the this_syscall < 0 check in __seccomp_filter()
	 * trigger, so we skip the syscall and return whatever is in ax
	 */
	regs.orig_ax = -512; /* -ERESTARTSYS */

	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov) < 0) {
		perror("setregset");
		goto out;
	}

	if (ptrace(PTRACE_CONT, pid, NULL, 0) < 0) {
		perror("cont after setregset");
		goto out;
	}

	while (1) {
		if (waitpid(pid, &status, 0) != pid) {
			perror("wait for death");
			goto out;
		}

		if (!WIFSTOPPED(status)) {
			break;
		}

		if (ptrace(PTRACE_CONT, pid, NULL, 0) < 0) {
			perror("cont after setregset");
			goto out;
		}

	}

	if (WIFSIGNALED(status)) {
		printf("didn't exit: %d\n", WTERMSIG(status));
		return 1;
	}

	if (WEXITSTATUS(status)) {
		printf("exited: %d\n", WEXITSTATUS(status));
		return 1;
	}

	return 0;
out:
	kill(pid, SIGKILL);
	return 1;
}
