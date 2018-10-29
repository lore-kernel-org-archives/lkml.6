Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CC9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2582080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRnLkJR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2582080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbeJ3Evk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:51:40 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35717 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeJ3Evk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:51:40 -0400
Received: by mail-ua1-f68.google.com with SMTP id d8so2552884ual.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DB6pT+RAuv3Bcs3mcWxDTapTeILQ4C3TS2vnDSjssFU=;
        b=dRnLkJR3RiL/L8PWOOaXIFtME6i4rzFIZMP/mFIRV5kIJbk865INS5STtepD1JZsDQ
         Jq5VSbZJAy9MJrTQhwoohLpDNNyJhoOXzWk1B7UXwTuzBG3qatisgGwgmgjQIH89ww7W
         AJtz/77p8mfFI2OTbWAr0XpXQSftJIEhU4pLnCNUaZbEQqpHFARRJts904nnIhiwTWs1
         jKmbz9dt/Sz6Yt1ULc55LoW2hSRuIke5xd4ewYfCXvlMoyLv3UvZIVMZf1Wg9i9WZ+ju
         mTwMbdi5socClmSvlrmVUF5VYZJTQBhY9oAkbY/+GUYvLF3PuGhPlrBEeMqW2FGNOru4
         StFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DB6pT+RAuv3Bcs3mcWxDTapTeILQ4C3TS2vnDSjssFU=;
        b=gODzTDtQPttS5mgScxOoua3nWqE645owg+Y+8cy82BhpWg3EGTyvtE0yxaVcbdXT10
         TeLXPIkaB+Qx6eUfm7EIR8fyBUm4fGLyHuZNZWEkMzHjROIwPiC99++RRDpSJIdPVQU+
         5yW5qWRCwC4szlFoWQGyOQrmW+N68f7TUTWQAA1+lk2pcR0w02xBMuS235MgPF9mB8Gz
         qgERnDMyyKRkxc+sMg/ZCo/hbEvG4etiQqcKrHkR00zM6J1daRwumSUtdU0/K2t0O8pX
         545s0H6THmS15WGHd9hSDSQmKBkmlNjn6t2Iw+edDoZ+19fXjPlHz390E0uyqnHS72q7
         58Mg==
X-Gm-Message-State: AGRZ1gL6hN7ynmEGzMbYvg38GGQt1a1cgZ1+ufh2T3McrxPp3RoqlGNH
        bq7qoEuoIluHfGQ9dKXEfxO8yv/MIzup7nqImf1E0C0XCa4=
X-Google-Smtp-Source: AJdET5eU482AXvw3MTz0saWaOPeb2vjsAg0PN7LUfUpwaUhOjkiHp3kfSJmjhLvZcJF900KFHQf/bO5eTb9cFVbSyRg=
X-Received: by 2002:ab0:15a1:: with SMTP id i30mr7139243uae.11.1540843288013;
 Mon, 29 Oct 2018 13:01:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f492:0:0:0:0:0 with HTTP; Mon, 29 Oct 2018 13:01:27
 -0700 (PDT)
In-Reply-To: <CAJWu+opR5bU7b0ux5GZjO-Wu+=2F8sARke-E_y4PpH0XSubx9g@mail.gmail.com>
References: <20181029175322.189042-1-dancol@google.com> <CAJWu+opR5bU7b0ux5GZjO-Wu+=2F8sARke-E_y4PpH0XSubx9g@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 29 Oct 2018 20:01:27 +0000
Message-ID: <CAKOZuetEeP2QgowUL60LYoOgavN7e-WX52adzTdMQhZX0bZn-Q@mail.gmail.com>
Subject: Re: [RFC PATCH] Minimal non-child process exit notification support
To:     Joel Fernandes <joelaf@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking a look.

On Mon, Oct 29, 2018 at 7:45 PM, Joel Fernandes <joelaf@google.com> wrote:
>
> On Mon, Oct 29, 2018 at 10:53 AM Daniel Colascione <dancol@google.com> wrote:
> >
> > This patch adds a new file under /proc/pid, /proc/pid/exithand.
> > Attempting to read from an exithand file will block until the
> > corresponding process exits, at which point the read will successfully
> > complete with EOF.  The file descriptor supports both blocking
> > operations and poll(2). It's intended to be a minimal interface for
> > allowing a program to wait for the exit of a process that is not one
> > of its children.
> >
> > Why might we want this interface? Android's lmkd kills processes in
> > order to free memory in response to various memory pressure
> > signals. It's desirable to wait until a killed process actually exits
> > before moving on (if needed) to killing the next process. Since the
> > processes that lmkd kills are not lmkd's children, lmkd currently
> > lacks a way to wait for a proces to actually die after being sent
> > SIGKILL; today, lmkd resorts to polling the proc filesystem pid
>
> Any idea why it needs to wait and then send SIGKILL? Why not do
> SIGKILL and look for errno == ESRCH in a loop with a delay.

I want to get polling loops out of the system. Polling loops are bad
for wakeup attribution, bad for power, bad for priority inheritance,
and bad for latency. There's no right answer to the question "How long
should I wait before checking $CONDITION again?". If we can have an
explicit waitqueue interface to something, we should. Besides, PID
polling is vulnerable to PID reuse, whereas this mechanism (just like
anything based on struct pid) is immune to it.

> > entry. This interface allow lmkd to give up polling and instead block
> > and wait for process death.
>
> Can we use ptrace(2) for the exit notifications? I am assuming you
> already though about it but I'm curious what is the reason this is
> better.

Only one process can ptrace a given process at a time, so I don't like
ptrace as a mechanism for anything except debugging.

Relying on ptrace for exit notification would interfere with things
like debuggers and crash dump collection systems. Besides, ptrace can
do too much (like read and write process memory) and so requires very
strong privileges not necessary for this mechanism. Besides: ptrace's
interface is complicated and relies on repeated calls to various wait
functions, whereas the interface in this patch is simple enough to use
from the shell.
