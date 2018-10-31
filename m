Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D995ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3F72054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iRGvdz7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3F72054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeJaWZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:25:51 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39263 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbeJaWZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:25:50 -0400
Received: by mail-vs1-f65.google.com with SMTP id h78so8914203vsi.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2BqGOyVGXWPflr9Rtt+Abjo9SwKjA/bLxv2fxPOVw78=;
        b=iRGvdz7XI8aLeAOqzkspep0nDCgjCHkkNiK/v43+cNKnw5SLUTLz6mIKAn7eEe3c4T
         WO6cnO3cDeNfmVLUkODp5X7qNodvmMPgONBk+4KXzm0y3+nVAwsl7XItnPkQWJ11dVlL
         2ceQ3J43eIu5z4cldwECaGnIMdDMQoSDgR4dq0zfep68VmKRJQJ2adKC5ZtTrhQ51qnH
         2mzbmyur0EVVAW3lkR2tDwNeD4ShjpIMaeKlWvSl12sGsv86JG2psdKKLTMWqzfMbvKU
         xtBP3lssK+0cviSZy8BNRN+Cn9dnhehy/fCiJYa+xqzVSURgH2X3TohSXGQPyWFdI4tR
         1YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2BqGOyVGXWPflr9Rtt+Abjo9SwKjA/bLxv2fxPOVw78=;
        b=jvs4ArRzTnzUN6oVAcscpyJeb7DIm4RMc2I/XuJc3AYImErCcBKlBsEgEuD+YU9qfr
         51QWhpTF776StXI5k9IJzNh1jJ97X0y9RrnZYSSOJeB1FaUrv3h3vO4kEKCQh74MZxwP
         JhSQJRbpFVCA4zZsmZ9PQ3nUFvohtYo3eQUdT9h/TfSIu3v0pXs/Az5Y8bPLLWBK3snN
         rAZAJHWYDj9LPdSM39jqDTtQVF/v4COLwck7jCg1Y+KJ+eEmJXts86iZ5jJ1PPJyXJdV
         Di58Z98hdAudpH0Iy3lY9MPTL8qxfo8SeZSlQ5Z39Vqj63/iL6AHby9C+4McqU+6snVj
         4aIg==
X-Gm-Message-State: AGRZ1gIAA/OlN6bRb5W9+m+YjRqqM5Ah2AYOPMZtbmslH2SHoUH3ezPo
        GVPhJReVY6yfDrHa+ieffr946OE55GYCFeO4BF6zxg==
X-Google-Smtp-Source: AJdET5cFglYntx4M3h7N8ObeZ4AXJ/ljIVVNylWcCR8bHBURwySSYJgYsSJlbTj51ls0UGfF+mEAOKlPaZOB61CWTKE=
X-Received: by 2002:a67:6cc1:: with SMTP id h184mr1232291vsc.149.1540992467718;
 Wed, 31 Oct 2018 06:27:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 06:27:46
 -0700 (PDT)
In-Reply-To: <20181031124435.GA9007@redhat.com>
References: <20181029221037.87724-1-dancol@google.com> <87bm7a3et9.fsf@xmission.com>
 <20181031124435.GA9007@redhat.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 31 Oct 2018 13:27:46 +0000
Message-ID: <CAKOZuevTF2cjJ0-nK7nv7jbgFexyW-deScaYVzE3iEPC48SAJg@mail.gmail.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:44 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 10/30, Eric W. Biederman wrote:
>>
>> At a bare minimum you need to perform the permission check using the
>> credentials of the opener of the file.    Which means refactoring
>> kill_pid so that you can perform the permission check for killing the
>> application during open.

Absolutely right. Thanks for spotting that.

> perhaps it would be simpler to do
>
>         my_cred = override_creds(file->f_cred);
>         kill_pid(...);
>         revert_creds(my_cred);

Thanks for the suggestion. That looks neat, but it's not quite enough.
The problem is that check_kill_permission looks for
same_thread_group(current, t) _before_ checking kill_of_by_cred, so
with just this code snippet, it'd still be possible for an
unprivileged process to open /proc/$PRIVILEGED_PID/kill and hand the
FD to $PRIVILEGED_PID, which would write to it and kill itself or any
of its threads. I think, with some rearrangement of permissions
checks, this problem can be overcome.

There's another problem though: say we open /proc/pid/5/kill *, with
proc 5 being an ordinary unprivileged process, e.g., the shell. At
open(2) time, the access check passes. Now suppose PID 5 execve(2)s
into a setuid process. The kill FD is still open, so the kill FD's
holder can send a signal to a process it normally wouldn't be able to
kill.

You might say, "let's somehow invalidate open kill FDs upon setuid
exec", but the problem that then results is then that a legitimate
privileged user of /proc/pid/kill (say, Android lmkd) might see its
/proc/pid/kill handle spuriously become invalidated if the process to
which it refers execs in a setuid way. Maybe in this case we make
could write(2) on the kill FD fail with ECHILD ("no child process"?)
and have callers, if they see ECHILD, close the kill FD, re-open it,
and try again. But now we're getting into an interface that's too
complicated to use from the shell.

Maybe a simpler approach would be to bind the kill FD to the struct
cred that opened it and keep the access check in write(2) --- a
write(2) with current->cred not equal to f_cred would fail with EPERM.
This way, you could play standard-output-of-setuid-program or
SCM_RIGHTS games with the kill FD itself, but you wouldn't be able to
do anything with the FD having done so.

Honestly, though, maybe a new procfs_sigqueue(2) system call would be
simpler and more robust. With a single system call, we wouldn't split
the permissions check between open(2) and write(2), and so the whole
problem disappears.

The downside is that you wouldn't be able to use the new feature via
the shell without a helper program. :-(

What do you think?

* I actually have a local variant of the patch that would have you
open "/proc/$PID/kill/$SIGNO" instead, since different signal numbers
have different permission checks.

This approach is kind of neat, since /proc/pid/kill/$SIGNO would act
as an "option" to kill a process only with a particular signal, and a
write(2) to a /proc/$PID/kill/$SIGNO file would allow you to specify a
sigqueue(2)-style siginfo value along with the actual signal number
(since the signal number is encoded in the filename). For example, a
privileged process could open /proc/self/kill/10 (SIGUSR1) and hand
the FD to an unprivileged process, letting that process signal (via
signal) completion of some process without giving that unprivileged
process the ability to send *any* signal to the privileged process.
But eventfd is almost certainly a better choice in this situation
anyway, I think.
