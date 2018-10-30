Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBF7C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EE22064C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g7Sx35Zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EE22064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJ3MNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 08:13:43 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36760 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeJ3MNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 08:13:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so11917961qth.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 20:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0EIfBijL/UxPZzgpFvC5osTlwjsHUFUOn8FK6CMeE0=;
        b=g7Sx35ZdD2zh3XwwtEKoP5iZ32Lvbwhco11LrGDEGm0J9Qd5lxaa0TH1mK2ViLzzjE
         gTHlru2iDdufhuax2QBjEaSTcVnloI/C5+cnIi/3zS4zKPB2XBsTA5T5WG0LFMu4Tt4u
         9NwXPFrJP9H7XtbaTVDDeWxy8nE3yLwg58W7YwRTnfutxwlfWYeez4Djd1fyvTZk2ufZ
         KdtP9IwvpUe4Y5tqwMA/z5IfTR6uz5IfiNMM7FKhnVtgFxn09SEMNxI25WtUmvFLZMJx
         2cd23e3OegjAjsnDLtgqOpX/yr83uK97UHhORLW5Bs+Pe0Oq2GXqqEWpFh9JrWCLfSQz
         IrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0EIfBijL/UxPZzgpFvC5osTlwjsHUFUOn8FK6CMeE0=;
        b=YTdwC7bcG+4qMIr0U3MAT0Jl+TE2k6zE09NJYYXYL+/LM6sM+ABpHdgOICdcUan8cf
         zkpO0mIhZr38dhJiB4IIdTCJfDzbGtYXpUeQ6B5uBEdL4X/1o6isTQh6+4uBdbUTUoQ7
         J5YPfAWRdrShXbfVLyLJIEk5UKz4wX4p6KxzgYsRlra07d3Enwipv1oVlUx2ZsovGqut
         v5cCDYnh0Z7MtiM5CyweAy2DTFWdA11kzBD6BzsX7qg/LWKjzUGj7Bfmwqek5UsSK+NF
         2LPLJGbgmsqgwCS46kQAOK0L+ockUgc+KSybhgtkTk3ClcwfRt67/+RtCGWo22/cSZKp
         LZXQ==
X-Gm-Message-State: AGRZ1gKB4wEUfT7S7WD49o55v9A5IXb9OHVDlpxReITu9AtY6Zt1EjkP
        +cUyYBHmOYHe/BbgL8H8IpJJ2hcDjjPJO3qjFpXOiulhpaGaaA==
X-Google-Smtp-Source: AJdET5eb3hfa1ey1nucc08s0dyfdfy4DlErsfvuM/TStMtSGRewKhHJLhqX9Fx1JbLQRqNlaZAnyzlfnwE4V9dMo7n4=
X-Received: by 2002:aed:2ec1:: with SMTP id k59-v6mr849818qtd.304.1540869722757;
 Mon, 29 Oct 2018 20:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181029221037.87724-1-dancol@google.com>
In-Reply-To: <20181029221037.87724-1-dancol@google.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 29 Oct 2018 20:21:51 -0700
Message-ID: <CAJWu+oquh1RXz+1tD91NzvicYAL3GP0KVi7RLR2cgouSgHXjOw@mail.gmail.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
To:     Daniel Colascione <dancol@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 3:11 PM Daniel Colascione <dancol@google.com> wrote:
>
> Add a simple proc-based kill interface. To use /proc/pid/kill, just
> write the signal number in base-10 ASCII to the kill file of the
> process to be killed: for example, 'echo 9 > /proc/$$/kill'.
>
> Semantically, /proc/pid/kill works like kill(2), except that the
> process ID comes from the proc filesystem context instead of from an
> explicit system call parameter. This way, it's possible to avoid races
> between inspecting some aspect of a process and that process's PID
> being reused for some other process.
>
> With /proc/pid/kill, it's possible to write a proper race-free and
> safe pkill(1). An approximation follows. A real program might use
> openat(2), having opened a process's /proc/pid directory explicitly,
> with the directory file descriptor serving as a sort of "process
> handle".

How long does the 'inspection' procedure take? If its a short
duration, then is PID reuse really an issue, I mean the PIDs are not
reused until wrap around and the only reason this can be a problem is
if you have the wrap around while the 'inspecting some aspect'
procedure takes really long.

Also the proc fs is typically not the right place for this. Some
entries in proc are writeable, but those are for changing values of
kernel data structures. The title of man proc(5) is "proc - process
information pseudo-filesystem". So its "information" right?

IMO without a really good reason for this, it could really be a hard
sell but the RFC was worth it anyway to discuss it ;-)

thanks,

- Joel
