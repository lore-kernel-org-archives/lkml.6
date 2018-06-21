Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BF0C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9FA22512
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXOxlCc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9FA22512
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933994AbeFUWsX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:48:23 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38900 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933828AbeFUWsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:48:21 -0400
Received: by mail-ot0-f193.google.com with SMTP id p95-v6so5440636ota.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1OVfuotkQ68Upc7n/9jDM5e1BYIaZxcBdqJubW5CfyI=;
        b=XXOxlCc59ZxIwBI37+MZMHRztSA7IoKbLwsbVS0udPHc8aJ04MWQWECExDTbeqW94H
         H0BHcBLVWzz2II2VB+DOm5npYz4mOAzjPydzWVQfbDMwFJmZYi97D9g4LrHVCsXg5lXB
         EnvO9DELy6MzfpwEceQyme9x7Nml+x8tX4H01bcCeLlL6kubVQ+M81vMtLYiZGRiKrDc
         e7u+X40W821aPchJjZHASlFX6uBetdE3Eu4Wfd1vLoSeJHBFc87Zl55QCWsnWJxt57Ro
         ET64dD+N2JmiWtzb+SjOKGc7eSpl88PXrlh/ImBnC23711cpVTNEa4907m4p9ZGBhcVd
         LtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1OVfuotkQ68Upc7n/9jDM5e1BYIaZxcBdqJubW5CfyI=;
        b=ibxtcNfzb4C/xqVgbSL9q32oKQdWkW2gRvlCmaW395TaDELpyG4ztUy+8p9FV7UjJv
         UBX4xxNrP85FMYeEyB+WYpMCyNQNXC4CFz0lkgMGd/DpkHpDswJA+sCscsjgj819uiAg
         0t8n716LUTl127UXjisZlhSt4EE2U7aallxmX57TDKIXI2LMPi6ysXrZ4cpeU7zxl2+g
         4GjhcqWpaB5FXPMY1TB1qart5O8Z8mLc9DT9IWebnXLpwmEd9ei0XSZTYq64SMnin9mN
         1a4J6qxoQ1EsyW2rJoebe7laMtkW5MEi+HpewCPdfnjTrns1nLrMkSwukQwwu2ooZOcG
         v5Mw==
X-Gm-Message-State: APt69E05Lo0mTHQGqNludOi1j/e11YjKBd10xKsXCospfGcEyCJhlo/j
        ls6otJQqcx6Bm1JCQxbKKvyhdfcqTC94FK4NMQwgHA==
X-Google-Smtp-Source: ADUXVKIFntvQZJZ3swMJIatqAFKxkI6TR/7cYSnwSP0QQocqcE90Ekee5ac4P8LkiwTaucx7bMaeKB3xRo7PFl/beq0=
X-Received: by 2002:a9d:350a:: with SMTP id o10-v6mr16024929otc.247.1529621301037;
 Thu, 21 Jun 2018 15:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180621220416.5412-1-tycho@tycho.ws> <20180621220416.5412-4-tycho@tycho.ws>
In-Reply-To: <20180621220416.5412-4-tycho@tycho.ws>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 22 Jun 2018 00:48:09 +0200
Message-ID: <CAG48ez3R+ZJ1vwGkDfGzKX2mz6f=jjJWsO5pCvnH68P+RKO8Ow@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] seccomp: add a way to get a listener fd from ptrace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:04 AM Tycho Andersen <tycho@tycho.ws> wrote:
> As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> version which can acquire filters is useful. There are at least two reasons
> this is preferable, even though it uses ptrace:
>
> 1. You can control tasks that aren't cooperating with you
> 2. You can control tasks whose filters block sendmsg() and socket(); if the
>    task installs a filter which blocks these calls, there's no way with
>    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
[...]
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index bbc24938c51d..b68a5d4a15cd 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1743,6 +1743,34 @@ static struct file *init_listener(struct task_struct *task,
>
>         return ret;
>  }
> +
> +long seccomp_new_listener(struct task_struct *task,
> +                         unsigned long filter_off)
> +{
> +       struct seccomp_filter *filter;
> +       struct file *listener;
> +       int fd;
> +
> +       filter = get_nth_filter(task, filter_off);
> +       if (IS_ERR(filter))
> +               return PTR_ERR(filter);
> +
> +       fd = get_unused_fd_flags(0);
> +       if (fd < 0) {
> +               __put_seccomp_filter(filter);
> +               return fd;
> +       }
> +
> +       listener = init_listener(task, task->seccomp.filter);
> +       __put_seccomp_filter(filter);
> +       if (IS_ERR(listener)) {
> +               put_unused_fd(fd);
> +               return PTR_ERR(listener);
> +       }
> +
> +       fd_install(fd, listener);
> +       return fd;
> +}

I think there's a security problem here. Imagine the following scenario:

1. task A (uid==0) sets up a seccomp filter that uses SECCOMP_RET_USER_NOTIF
2. task A forks off a child B
3. task B uses setuid(1) to drop its privileges
4. task B becomes dumpable again, either via prctl(PR_SET_DUMPABLE, 1)
or via execve()
5. task C (the attacker, uid==1) attaches to task B via ptrace
6. task C uses PTRACE_SECCOMP_NEW_LISTENER on task B
7. because the seccomp filter is shared by task A and task B, task C
is now able to influence syscall results for syscalls performed by
task A

Unless I'm missing something, you might have to add some extra
security check here: Either a check to ensure that no other task is
using the same seccomp filter, or (as a last resort) a check for
capable(CAP_SYS_ADMIN).
