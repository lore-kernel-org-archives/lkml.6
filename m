Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE334C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B2E20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nabL5K7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B2E20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeLFQRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:17:33 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36561 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeLFQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:17:33 -0500
Received: by mail-vs1-f68.google.com with SMTP id v205so623252vsc.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iydoUaKnECal97zKodAjnGwDbheh8CCIMkvtG0Rihzo=;
        b=nabL5K7lyZfrbMbCTyxakS/qo9eBpyBVzxbHoNbV5SmiTvTQZzwFHm9yFisc9iYVvE
         aF4T/pXSjDJ71IlIkzQ2wNLuwV81y2XNSpWljXBsOmS7XYI484S2OD2erUehbbBZRK0G
         /oN4zbDdhM38zCJt0cBMUOmUzzRdosfAB6vmHYicssPyXMe9mUVmmpCwPyCSj6M7J6p6
         Ze0CHzCpHR0me33z1gzN+A/I1eTcxozl5/Baf2QwECh75Ne8UBekatrJZMZqmRfTyKTD
         GXkJw59tPmTi2Fr0b4kM4WtqbbUTk4+0t+ch3XJiqNAyma2iKui1Fa10bBKKC7I4EqZO
         5p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iydoUaKnECal97zKodAjnGwDbheh8CCIMkvtG0Rihzo=;
        b=fdvUw62B0Gcn26gq72eAHzJc89yUQRQrPPwEzHycG9Nb290uGq2RoADOcMYAO4dEDm
         gDKECIHnbnR0GnbihklAc5aPN+JN23SWHg9ZIC602G3GuIALMM2GWff1UnTzPVtZl6wO
         Li+QZcNZmQoMnGtXYb3ZZ++PqOTInjgjb5ArlczcJ2TpxTWSX7IONdxkUu4vDKgUZDGc
         hVfr+23eYLbCO50MeDZculPVg7IN9n/kCMJ9W0MG1Tpdlr8eegrEOlgRW40KTenfd1fW
         DpMC06/neAXTV2188ZgBxgsiPjSGvUCYX4hgAGJlB5HQeKfbtUeTpYg9IUjmUx8FX6Nu
         0cuQ==
X-Gm-Message-State: AA+aEWZbHXpmzHHneQ5Z0KVgnb11NjQhQ5/0cK50lyB8TJIxHNTnz3FB
        GrrtG1xz4TM4NS1il53tn2WpNdXBy/5fyJTktFU8icUHxcM=
X-Google-Smtp-Source: AFSGD/UIJ+kY4dPzhuGHOztj8UL+chtTyfAwLiK5b2MnSHwJKoJHVxddWuAIVXhbdIeai24/uIoS6sYohOsuAhfWbVs=
X-Received: by 2002:a67:105:: with SMTP id 5mr12576458vsb.183.1544113051175;
 Thu, 06 Dec 2018 08:17:31 -0800 (PST)
MIME-Version: 1.0
References: <20181206121858.12215-1-christian@brauner.io> <87sgzahf7k.fsf@xmission.com>
In-Reply-To: <87sgzahf7k.fsf@xmission.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 6 Dec 2018 08:17:18 -0800
Message-ID: <CAKOZuet4ayDu-54u2tO9tRDCgxa9JQ4avAiYS8xEtReN4MMhAA@mail.gmail.com>
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
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

On Thu, Dec 6, 2018 at 7:02 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Christian Brauner <christian@brauner.io> writes:
>
> > The kill() syscall operates on process identifiers (pid). After a process
> > has exited its pid can be reused by another process. If a caller sends a
> > signal to a reused pid it will end up signaling the wrong process. This
> > issue has often surfaced and there has been a push [1] to address this
> > problem.
> >
> > This patch uses file descriptors (fd) from proc/<pid> as stable handles on
> > struct pid. Even if a pid is recycled the handle will not change. The fd
> > can be used to send signals to the process it refers to.
> > Thus, the new syscall taskfd_send_signal() is introduced to solve this
> > problem. Instead of pids it operates on process fds (taskfd).
>
> I am not yet thrilled with the taskfd naming.

Both the old and new names were fine. Do you want to suggest a name at
this point? You can't just say "I don't like this. Guess again"
forever.

> Is there any plan to support sesssions and process groups?

Such a thing could be added with flags in the future. Why complicate this patch?

> I am concerned about using kill_pid_info.  It does this:
>
>
>         rcu_read_lock();
>         p = pid_task(pid, PIDTYPE_PID);
>         if (p)
>                 error = group_send_sig_info(sig, info, p, PIDTYPE_TGID);
>         rcu_read_unlock();
>
> That pid_task(PIDTYPE_PID) is fine for existing callers that need bug
> compatibility.  For new interfaces I would strongly prefer pid_task(PIDTYPE_TGID).

What is the bug that PIDTYPE_PID preserves?
