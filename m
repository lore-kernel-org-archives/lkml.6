Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5131FC67837
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBE220644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EYuT8afB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBE220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJLEnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:43:23 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41410 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeJLEnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:43:23 -0400
Received: by mail-oi1-f196.google.com with SMTP id l197-v6so8248087oib.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=e68ODD2SwmXrBHJ/fcgCwU2Ra+8m7ojuXuXDxsXA/0s=;
        b=EYuT8afBJp+qHpGKxdfJ+P515OVHmDsNixocWW0vxSMUAYtBwVjHqQ5KeccB43xkYC
         Vm4eE2pKfR4nc5YnbHxqMMxX2nTpwqwBqG1IF+fg2+wjOv16cWvZ+wsU5E/zbWqg/qC/
         lniNPVfq3tLxfqk6l0xMsDEEYV1ec+z0k2GyYxvq7s67RYztoSmtf0aeVRrmQmr7FFZu
         fNrVQrUukaafdyiGfvu7dd6dqYLvB4dyvydQ6ynjROAZMJ1gmk9TWYLQnXrlE/1Do9YA
         CYsuZJXjC9jir5BgYKgwz92D5tQUr6gorm9aOWOoFPhklf60rKD4fqogcuqBllrQUduw
         wR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=e68ODD2SwmXrBHJ/fcgCwU2Ra+8m7ojuXuXDxsXA/0s=;
        b=PZiMkr3Bn+pwi4mQ0GQXM8XbNq35J866ZIwHBO1N3Wp5zuBONc3PRk82WE7XIgWE9H
         ked9hynH0QVCorKuvjwe22XYgLqbwkIkOrEQgomVgfsgATaYTCbrTtXugi1VAhkVfHtH
         XgZBEazVnOe6U8o8xOkL73lpxc0gzNZnJogJRx66gjo9vspOgWBPkmpdQtUY56sP44qg
         h834QrRA+fqRKzkhim9/R589Bur2PKYyrc2f/ZZiSJCiPRrgH04+7N6kuXd+DoVL+b39
         y53tdJ9++iINh9kTr6M8uuUZ7gchhucao/Bdtif5luOtvxc14RMsqvJRWwKEUw2suMfj
         in+w==
X-Gm-Message-State: ABuFfojdqMD++X7fce46DTuHOK8ynTU4SvC5aVx/kvLjbmWmSeuYaj8h
        iE0HHUpkci6Ou4zRjr4zR7gvRVayD5zAhdMVUN2X56GOREtN4g==
X-Google-Smtp-Source: ACcGV61wyg7W9kD94lAL3Y9DOrvyoTTHis6spTzk8ZDB3SpKERhNgL1lOfYoV5jHxub+yqs35ZOMLbhdFZ7wQHbe95o=
X-Received: by 2002:aca:490b:: with SMTP id w11-v6mr1782267oia.126.1539292459197;
 Thu, 11 Oct 2018 14:14:19 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Thu, 11 Oct 2018 23:13:52 +0200
Message-ID: <CAG48ez3_1h8pJD43zmPfkmyJ78xoToqmbmM99MiO0gXXXL=b5A@mail.gmail.com>
Subject: [RFC] proposal for resolving the cred_guard_mutex deadlock
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Michal Hocko <mhocko@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, John Johansen <john.johansen@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There is that old deadlock of cred_guard_mutex that I originally heard
about from Oleg, and that has come up on LKML sometimes since then; to
recap, essentially, the problem is demonstrated by the following
testcase:

========
#include <pthread.h>
#include <stdlib.h>
#include <sys/ptrace.h>
#include <unistd.h>
#include <signal.h>

void *thread(void *arg) {
        ptrace(PTRACE_TRACEME, 0, 0, 0);
        return NULL;
}

int main(void) {
        int pid = fork();

        if (!pid) {
                pthread_t pt;
                pthread_create(&pt, NULL, thread, NULL);
                pthread_join(pt, NULL);
                execlp("echo", "echo", "passed", NULL);
        }

        sleep(1);

        ptrace(PTRACE_ATTACH, pid, 0, 0);
        kill(pid, SIGCONT);

        return 0;
}
========

The parent gets stuck in ptrace(), waiting for the cred_guard_mutex:

========
[<0>] ptrace_attach+0x97/0x250
[<0>] __x64_sys_ptrace+0xa2/0x100
[<0>] do_syscall_64+0x55/0x110
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
========

The child gets stuck in execve(), waiting in de_thread() for its other thread:

========
? __schedule+0x2b7/0x880
schedule+0x28/0x80
flush_old_exec+0xc8/0x6c0
load_elf_binary+0x291/0x15d0
? get_user_pages_remote+0x137/0x1f0
? get_acl+0x1a/0x100
search_binary_handler+0x90/0x1c0
__do_execve_file.isra.37+0x6b8/0x880
__x64_sys_execve+0x34/0x40
do_syscall_64+0x55/0x110
entry_SYSCALL_64_after_hwframe+0x44/0xa9
========

But the other thread can't exit until the ptrace parent handles it;
and the ptrace parent is stuck in another syscall, and therefore can't
wait() for that thread.

This can cause debuggers to lock up, and also gets in the way of
taking cred_guard_mutex in more places (since that'd make the deadlock
worse).


IMO at the core of the problem is that the cred_guard_mutex is held
across pretty much all of sys_execve(), and in particular across
do_thread(). I think that actually, we could drop the cred_guard_mutex
before waiting for sibling threads if we make things like the ptrace
check a bit more complicated.

At the moment, cred_guard_mutex is held across de_thread() and beyond
to protect against things like seccomp TSYNC from a sibling thread or
ptrace attach. For TSYNC, this is necessary because another thread
could try to TSYNC to us as long as we're not done with de_thread();
for ptrace attach, this is necessary because we only switch
credentials after de_thread(). But just doing the credential switch
earlier would also be dangerous.

So here's my idea:
When we're done calculating the post-execve creds (which happens
before de_thread()), we stash a pointer to the post-exec creds in
current->signal (or in current?). Then, in de_thread(), once we know
that all our siblings have been zapped, we drop the cred_guard_mutex
*before* the loop that waits for the siblings to exit. At that point,
sibling threads that are mid-syscall and other processes can try to
interact with us again. This means:
For accesses that are permitted based on whether the access is
same-thread (in particular TSYNC and probably also the
same_thread_group() check in ptrace), we'll have to check whether exec
creds are stashed in current->signal; if so, we have to bail out. Any
error code we return there shouldn't be visible to userspace, since
this can only happen to a thread that has already been zapped.
For accesses that go through ptrace_may_access(), we'll have to expand
the check such that, if an attempt is made to access a task that is
currently going through execve, the access check is performed against
*both* its old and its new credentials. This also means that the
target credentials will have to be plumbed into the LSMs in addition
to the target task pointer.

Opinions? If nobody thinks that this is an incredibly stupid idea,
I'll try to come up with some patches.
