Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04ADC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BBF2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwbJlGvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BBF2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeJ3Efr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:35:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39155 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeJ3Efr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:35:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id g10-v6so10742738qtq.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 12:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJfEqvXjSJFZIKPMb7koFbsr5lcSz/UqGK41kz6HJuw=;
        b=vwbJlGvKbhgGN4q3jCJCl/ZtI7GlE8sZ+f/JXUs6/miQoGCj7VkwjCSSR+slF+cG/l
         5F9zXSkU/c2F7+vOibpZmDG8Jf60FVCORuYPCnK53oVdg5wMwuBQlywIlFAj+rU8mWYp
         yTt+wMR8lsfYOLpIZTSy4zwy6WTDK/d74s1uifZ87xdjLMCUptE/YXKgkAK+hpVvyYUx
         XLL+TYcFDHyyBoICf6Kbdo8/cOA3nPm0IzSyJO6/uTkFAXLk62HQcre6tNX07yXLfKul
         BQ2PjJe6+SXcdG57qQGZDUkZcoUkhznAipj9MVBLwTBVItKbqKsKRu1jik0F3Cfoveqa
         8Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJfEqvXjSJFZIKPMb7koFbsr5lcSz/UqGK41kz6HJuw=;
        b=Od0t8DRFNSYYbPWSyVAkN5WYzznt+4UK9Krg+t9i59oBjoJWvt5NBJrN/I+nI0cY1b
         nKSyoHmwmNxn4aNVqWAcgE8UV2bG5az3hfM6vrhUrPG4wWOrTaSUN90xCznPJsbruSuJ
         DE1TcvEJo5C1gAsFC7Aa9ReDUOqObDWpQOE5lIANoZ6jxughdHbUwQhY8vAjUwLb8H0+
         cZ7UiOaKCPGNZJcbbjwA7FW0+e059sKvGeMIp7aQfsCGvKtHI22b0N3rg1+Z3eJZM5q5
         gJDKv04GajfiyU4YS8nHhQren3ut36BAOt5nI5n2qMvDEfMf+1li+pYNPbaAWHsmnr7I
         ZBzQ==
X-Gm-Message-State: AGRZ1gJK7V4r1ikfwKShIBI+1rL9AMbjLqxZHbpwyeZ1sE0ersLvp5u2
        awvoMWcN3SzbrVZ/cpCuNCsNLtsiycQZXD7RG9n3EQ==
X-Google-Smtp-Source: AJdET5frkdwyON9cKPnD/Zquxk2m1tcobUf97QsFRIvz3PA34xfJhvX5wQtlMcfKiRB3X17YUFko8AycnFHmNq4C7W0=
X-Received: by 2002:a0c:b137:: with SMTP id q52mr14200970qvc.58.1540842338982;
 Mon, 29 Oct 2018 12:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181029175322.189042-1-dancol@google.com>
In-Reply-To: <20181029175322.189042-1-dancol@google.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 29 Oct 2018 12:45:25 -0700
Message-ID: <CAJWu+opR5bU7b0ux5GZjO-Wu+=2F8sARke-E_y4PpH0XSubx9g@mail.gmail.com>
Subject: Re: [RFC PATCH] Minimal non-child process exit notification support
To:     Daniel Colascione <dancol@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:53 AM Daniel Colascione <dancol@google.com> wrote:
>
> This patch adds a new file under /proc/pid, /proc/pid/exithand.
> Attempting to read from an exithand file will block until the
> corresponding process exits, at which point the read will successfully
> complete with EOF.  The file descriptor supports both blocking
> operations and poll(2). It's intended to be a minimal interface for
> allowing a program to wait for the exit of a process that is not one
> of its children.
>
> Why might we want this interface? Android's lmkd kills processes in
> order to free memory in response to various memory pressure
> signals. It's desirable to wait until a killed process actually exits
> before moving on (if needed) to killing the next process. Since the
> processes that lmkd kills are not lmkd's children, lmkd currently
> lacks a way to wait for a proces to actually die after being sent
> SIGKILL; today, lmkd resorts to polling the proc filesystem pid

Any idea why it needs to wait and then send SIGKILL? Why not do
SIGKILL and look for errno == ESRCH in a loop with a delay.

> entry. This interface allow lmkd to give up polling and instead block
> and wait for process death.

Can we use ptrace(2) for the exit notifications? I am assuming you
already though about it but I'm curious what is the reason this is
better.

thanks,

-Joel
