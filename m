Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C9AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44EB243D7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shkot1KP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44EB243D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933465AbeFVOkf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:40:35 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42840 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeFVOkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:40:33 -0400
Received: by mail-oi0-f68.google.com with SMTP id k190-v6so6305443oib.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UDFFAK6YG0nXhX9eGMT0TlkHJmq30znLwXFK5xsnDGE=;
        b=shkot1KPzpRUS9eQAntvPyY3TmPJauprL4MH2BqRMylvObek3JB3LxxzBbdPP4To2Q
         UG4wL1Nz5TiRHuScLPQDZgXVavcPsSPE5pBPX7QqqLdfjXaXVt0RVvaETF1K4nVnH/u4
         xE4DHN5mlE0kQv0c2HFWoXDh2GKu8K28EqjJ/2HIZjoK0OMrHaMBbau0BWztMIqgynXO
         co7KRqTeH+gPVfRXRGjaKhAaLN3UHo7gTh+YfWecYuGeN8XwWlqwtaiAoKzBtEVZe2ld
         TH9puX9nPA72Esoxk/Gc1h9A8y+5HcgJ+sbLG6xjeLFHdS3VD4DmJLVkFfxIgH6o/ZBB
         6dKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UDFFAK6YG0nXhX9eGMT0TlkHJmq30znLwXFK5xsnDGE=;
        b=qeTZnHcQdR99CFu3gxphAmeMSOsjVIWENilYA5+xwT75mALzK7f/C3olU77so6MKlw
         q4wu+po0AGKP8PsPoK+ZZNeT09lfKTMzLKaZoogICiC3oTa3CcnXCLxcwEmhiIm/8Ivx
         rTBRrB6obCtbrR7wiH+dy/U8uf+yYFgjqIQk+683HZ4PH43FpPKo7wtlDbNMfX65WyiH
         J7EwejGvqZsQIfZuUoyZL5LQsrI7+/xdQs4kCxeLbj3iwmgvXTEVDpBNsQiog5azmg/+
         K8wlW4LR8MenGt03xuhKV6QaQd+0Ui0khAVZhN0xk2D/sd4wusZi14/ybc0X+rEGI6ed
         ddqA==
X-Gm-Message-State: APt69E3/c2lHdDNKKnaWOtKiNjpgHmsmhX4Q/BnY2PCHebjMR8LNVoVp
        xIi3aX6Q0esqYYp0eXn+0FWY+GhOmRi+Z2Pca918kA==
X-Google-Smtp-Source: AAOMgpegKVv0MFpizJR3UmsTqzk0yz2XT6W3pOteHvYwXgNHwxTdKlRxSs1jNLWynDdhRRbdCgJE/ZIxqpGSLDtmN3I=
X-Received: by 2002:aca:5bd5:: with SMTP id p204-v6mr1052666oib.91.1529678432096;
 Fri, 22 Jun 2018 07:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180621220416.5412-1-tycho@tycho.ws> <20180621220416.5412-2-tycho@tycho.ws>
In-Reply-To: <20180621220416.5412-2-tycho@tycho.ws>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 22 Jun 2018 16:40:20 +0200
Message-ID: <CAG48ez3Ek_KG54ejR=Q=XtW_HDs8hQ+cgFODzn4rQ0nVDVpODg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] seccomp: add a return code to trap to userspace
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

On Fri, Jun 22, 2018 at 12:05 AM Tycho Andersen <tycho@tycho.ws> wrote:
> This patch introduces a means for syscalls matched in seccomp to notify
> some other task that a particular filter has been triggered.
>
> The motivation for this is primarily for use with containers. For example,
> if a container does an init_module(), we obviously don't want to load this
> untrusted code, which may be compiled for the wrong version of the kernel
> anyway. Instead, we could parse the module image, figure out which module
> the container is trying to load and load it on the host.
>
> As another example, containers cannot mknod(), since this checks
> capable(CAP_SYS_ADMIN). However, harmless devices like /dev/null or
> /dev/zero should be ok for containers to mknod, but we'd like to avoid hard
> coding some whitelist in the kernel. Another example is mount(), which has
> many security restrictions for good reason, but configuration or runtime
> knowledge could potentially be used to relax these restrictions.
>
> This patch adds functionality that is already possible via at least two
> other means that I know about, both of which involve ptrace(): first, one
> could ptrace attach, and then iterate through syscalls via PTRACE_SYSCALL.
> Unfortunately this is slow, so a faster version would be to install a
> filter that does SECCOMP_RET_TRACE, which triggers a PTRACE_EVENT_SECCOMP.
> Since ptrace allows only one tracer, if the container runtime is that
> tracer, users inside the container (or outside) trying to debug it will not
> be able to use ptrace, which is annoying. It also means that older
> distributions based on Upstart cannot boot inside containers using ptrace,
> since upstart itself uses ptrace to start services.
>
> The actual implementation of this is fairly small, although getting the
> synchronization right was/is slightly complex.
>
> Finally, it's worth noting that the classic seccomp TOCTOU of reading
> memory data from the task still applies here, but can be avoided with
> careful design of the userspace handler: if the userspace handler reads all
> of the task memory that is necessary before applying its security policy,
> the tracee's subsequent memory edits will not be read by the tracer.

I've been thinking about how one would actually write userspace code
that uses this API, and whether PID reuse is an issue here. As far as
I can tell, the following situation can happen:

 - seccomped process tries to perform a syscall that gets trapped
 - notification is sent to the supervisor
 - supervisor reads the notification
 - seccomped process gets SIGKILLed
 - new process appears with the PID that the seccomped process had
 - supervisor tries to access memory of the seccomped process via
process_vm_{read,write}v or /proc/$pid/mem
 - supervisor unintentionally accesses memory of the new process instead

This could have particularly nasty consequences if the supervisor has
to write to memory of the seccomped process for some reason.
It might make sense to explicitly document how the API has to be used
to avoid such a scenario from occuring. AFAICS,
process_vm_{read,write}v are fundamentally unsafe for this;
/proc/$pid/mem might be safe if you do the following dance in the
supervisor to validate that you have a reference to the right struct
mm before starting to actually access memory:

 - supervisor reads a syscall notification for the seccomped process with PID $A
 - supervisor opens /proc/$A/mem [taking a reference on the mm of the
process that currently has PID $A]
 - supervisor reads all pending events from the notification FD; if
one of them says that PID $A was signalled, send back -ERESTARTSYS (or
-ERESTARTNOINTR?) and bail out
 - [at this point, the open FD to /proc/$A/mem is known to actually
refer to the mm struct of the seccomped process]
 - read and write on the open FD to /proc/$A/mem as necessary
 - send back the syscall result

It might be nice if the kernel was able to directly give the
supervisor an FD to /proc/$A/mem that is guaranteed to point to the
right struct mm, but trying to implement that would probably make this
patch set significantly larger?
