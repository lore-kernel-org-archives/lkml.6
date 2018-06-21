Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3020C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D972254B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMaZXZwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D972254B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932950AbeFUXec (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:34:32 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46934 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932686AbeFUXea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:34:30 -0400
Received: by mail-oi0-f65.google.com with SMTP id h79-v6so4510324oig.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0oBq3QGclfaOlKxFfvw2X1QxVWGTvFKxFI+SyLJsL78=;
        b=hMaZXZwJpGE3gLnoWQte1firukqRMXIEGnU3esNF0WlfWUsBR6nAay85jNpPZDxzyu
         0g+Gz6jINOB2daHyVYxf7/GPB7jJ/nMlYHD3CIs9YVKJkB4y6TAirXSOuUfTSqJKb4Xx
         vOgKDMjPR/e8Xx+UUXN9xcMUTn2LLcd79J9nu3fKS46tBLdraI7L2+vUT/HdCUrCceZF
         Wj8bZMDtP8oj9EVruR9KPTxtvLAkvgyQdyjTJzS0zyLlu+TzdIA+mleukDduXg+WZlDe
         mbaD9d6p4eg0f5LsA0+er1RoUz8phbeSykULDbXPu6+286SDRcb9WQmIJDDYzjUnGKZ+
         x7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0oBq3QGclfaOlKxFfvw2X1QxVWGTvFKxFI+SyLJsL78=;
        b=NA7rq9wN+Vm8yM6ufotTpBfmqY6Q3hMPvCgomoBRcc90/qzGtnmFhTpqAU2wo6KeMd
         q8F81Zks3albt18wsMfRgLs0THAwCYDVIGGfOOggbUbr32RRFw7vXi99VSKagoj0RjBA
         FMBIsqvAcsFBk3/bow6gibv6rmn+ldxp2hfjh+eZM7lB2vIMxCTSXDhDCpCA95pHptmG
         qw8xYz768nSJwNgzA6c0ca+0g7WgqtzD/NWoC/xBYpH25pyFGkTQxUqd0iDnY87cLYCz
         4hvSQlVcTcUC4w1Zv+hSzd2m6Oc5SQtN72gw6gktPpNHiG+jQS5/MTNsgEcyyoEjwpO6
         Sbkw==
X-Gm-Message-State: APt69E1tv15kw3TQQY25RbS5yiU7ogpADQOaV4mg4OH/XTnE0k/4KgK2
        v3hTeblEUsp/E8XirQ7GqLGfsJGIhu0LVvwLdPiBVg==
X-Google-Smtp-Source: ADUXVKJJEtdqq9XNeCILcOQrSkw3INZPmWuAsenXd8XHiKcvehAKnso/z6dbOdpRrVw0EMTvz9n4vi8vYIhbetIIyQA=
X-Received: by 2002:aca:5bd5:: with SMTP id p204-v6mr16228542oib.91.1529624069452;
 Thu, 21 Jun 2018 16:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180621220416.5412-1-tycho@tycho.ws> <20180621220416.5412-5-tycho@tycho.ws>
In-Reply-To: <20180621220416.5412-5-tycho@tycho.ws>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 22 Jun 2018 01:34:18 +0200
Message-ID: <CAG48ez0d+tRsfvstU3Kd7T=kkdKbbfpNS+19NLTchhSL1fUyNg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] seccomp: add support for passing fds via USER_NOTIF
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
>
> The idea here is that the userspace handler should be able to pass an fd
> back to the trapped task, for example so it can be returned from socket().
[...]
> +Userspace can also return file descriptors. For example, one may decide to
> +intercept ``socket()`` syscalls, and return some file descriptor from those
> +based on some policy. To return a file descriptor, the ``return_fd`` member
> +should be non-zero, the ``fd`` argument should be the fd in the listener's
> +table to send to the tracee (similar to how ``SCM_RIGHTS`` works), and
> +``fd_flags`` should be the flags that the fd in the tracee's table is opened
> +with (e.g. ``O_EXCL`` or similar).

fd_flags only contains file descriptor flags (meaning only O_CLOEXEC).
O_EXCL is a file creation flag, so setting it here wouldn't make sense.
Setting file status flags like O_APPEND does make sense, but those are
stored in the `struct file` and don't need to be passed separately;
the caller can e.g. set them via fcntl(fd, F_SETFD, flags) or on
open().
(The fcntl.2 manpage explains these.)
