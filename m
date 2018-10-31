Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1751BECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E1B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMNUZEE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E1B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbeKACn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:43:29 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35475 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbeKACn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:43:28 -0400
Received: by mail-ua1-f68.google.com with SMTP id d8so5245890ual.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4vcOD6E25VumNhaqeNzWwPkzPZMJ/b+SNHRZfcLSucc=;
        b=eMNUZEE6SapBZfp2ttNijdIrk7ZDP0eekCrv00i6SpEDZ+kQlTv78eOMLL0DNs0nl4
         BOjqwz6JTy2AABOVXFXMDEOvz1OkJjHmhZopMP67TIpx2vNhGy0k/aotuaHAiNjolaTu
         0aklovUNOk2mmAzIoxQAx2wNan7EA0XVBDwJcHR0GSB3+uHjTERKUyzgYZy7tOv1JlU5
         zApt+g7DPB/l6EnRcLfN8yr/PdmLBg6Jzr82XigOiPzLu8cOBHmZdzr+MIATtRM5b9qh
         0xKTif2osoLIwnaMV8/Cr+BAJ9ytMcPDcZj23U39NT+AhGxA49UJtlBqoqqsEgJYVW2x
         4d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4vcOD6E25VumNhaqeNzWwPkzPZMJ/b+SNHRZfcLSucc=;
        b=SupTLcxnBKml0+G/5OMUjqiB9zBBMgeEEZm9Y3s6txi7lqCxSiPSJoVYl7LjJOCMIH
         0YobtrCWPgganNoPgmbY/R43H9lFsW9x9rBbek4JANer6hOvIIQHLpJxjUjgCl2wEtRk
         jw9gGf4KNDslOODjTCMi/Jn6m04wRSChl2I76gQCHX1ARFjPWg23B47+bW2yxQQMi5bq
         mT6DV6IhpPpnLS52afJKz7By34SGDbRuZu+HEPOgywWAiviYr53+BCXnFgCwkipoR5Tv
         WDKt5HwHFU6+xmH1RecYZKFFKTduwFUUowLPDR06YRZD0TBS5syKo8PR3bhNL2tV0fJR
         QR2Q==
X-Gm-Message-State: AGRZ1gL50qS6jbs9VpQgEEPgTd0CwtOaCcr5pqSyfWOoYFvKARM0d4rf
        hTAWfJVJi8aJ0CEzwtG8onqQiEizBVmCXUZ+WLYIjA==
X-Google-Smtp-Source: AJdET5eAx8TA0ypoL3INz/fcwVZi9WE87p5oP6iUr2i9RckyVsRzNBWquG+n/qLmZeX48/qknP3eQT8zA12Mm4d7rR4=
X-Received: by 2002:ab0:15a1:: with SMTP id i30mr1889024uae.11.1541007867134;
 Wed, 31 Oct 2018 10:44:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 10:44:24
 -0700 (PDT)
In-Reply-To: <175DDE5D-E738-4C35-B664-6AD8B9CF446D@amacapital.net>
References: <20181029175322.189042-1-dancol@google.com> <CAKOZueuX6GL+rXZbtd_X2RaxF1MdNiEnHFbTRE2X8bsY9bOzuA@mail.gmail.com>
 <175DDE5D-E738-4C35-B664-6AD8B9CF446D@amacapital.net>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 31 Oct 2018 17:44:24 +0000
Message-ID: <CAKOZuevXXqwJepmLNUtrU=f8jtdgdKAzUAnAA2+KVcWoMxMyFg@mail.gmail.com>
Subject: Re: [RFC PATCH] Minimal non-child process exit notification support
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 5:25 PM, Andy Lutomirski <luto@amacapital.net> wrot=
e:
> I had an old patch to do much the same thing:

It's a perennial idea. :-)

> https://lore.kernel.org/patchwork/patch/345098/
>
> Can you comment as to how your API compares to my old patch?

Sure. Basically, my approach is sort-of eventfd-esque, whereas your
approach involves adding a very unusual operation (poll support) to a
type of file (a directory) that normally doesn't support it. My
approach feels a bit more "conventional" than poll on a dfd.
Additionally, my approach is usable from the shell. In your model,
poll(2) returning *is* the notification, whereas in my approach, the
canonical notification is read() yielding EOF, with poll(2) acting
like a wakeup hint, just like for eventfd. (You can set O_NONBLOCK on
the exithand FD just like you would any other FD.)

The use of read() for notification of exit also allows for a simple
extension in which we return a siginfo_t with exit information to the
waiter, without changing the API model. My initial patch doesn't
include this feature because I wanted to keep the initial version as
simple as possible.

> You=E2=80=99re using
> some fairly gnarly global synchronization

The global synchronization only kicks for a particular process exit if
somebody has used an exithand FD to wait on that process. (Or more
precisely, that process's struct signal.) Since most process exits
don't require global synchronization, I don't think the global
waitqueue for exithand is a big problem, but if it is, there are
options for fixing it.

> , and that seems unnecessary

It is necessary, and I don't see how your patch is correct. In your
proc_task_base_poll, you call poll_wait() with &task->detach_wqh. What
prevents that waitqueue disappearing (and the poll table waitqueue
pointer dangling) immediately after proc_task_base_poll returns? The
proc_inode maintains a reference to a struct pid, not a task_struct,
but your waitqueue lives in task_struct.

The waitqueue living in task_struct is also wrong in the case that a
multithreaded program execs from a non-main thread; in this case (if
I'm reading the code in exec.c right) we destroy the old main thread
task_struct and have the caller-of-exec's task_struct adopt the old
main thread's struct pid. That is, identity-continuity of struct task
is not the same as identity-continuity of the logical thread group.
