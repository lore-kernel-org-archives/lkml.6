Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AEFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1613C216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xw0XF1la"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1613C216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeI1BsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:48:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37139 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbeI1BsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:48:24 -0400
Received: by mail-oi1-f195.google.com with SMTP id e17-v6so2329788oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Tt7aG7/5AAYl6fdud2ktru1JKKccWVdcV8TSxRqWpw=;
        b=Xw0XF1la15hT+fQZ7KfWhWNpINrvsLds4E9go5w7iRHVO9U4wMDrNoHBx5SW/c6t6Y
         3f2vZVsXSjoO1Ktw8HuW1x07MPXAQp/HPrI4smZaKM4fayMaVozezJmk0gp7OnghUF7k
         pQHWuGLFW5eb3Bs3qz8D6AoJL4DHapMgYHBo+sUqfe7PBBNhLC54XGC7VbS0+sJZ3bDh
         ViRRU93+3qr3LhA0xYjpvGz5jPnBI7j2IDlanHY89g7YYOTeAC7foNUUuIyRQJpdHePI
         +XDl37ClIiTXlqcEO8OYcgck751Al1eR6GsUwsLG95jbCFUrA1M+1YzlUt+wTHj2ZU1j
         oPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Tt7aG7/5AAYl6fdud2ktru1JKKccWVdcV8TSxRqWpw=;
        b=UKkycUnlLP2kB1Hq2XAhUi18Ta7M3YBXNQgX2ikQirRWckSyqTWtQJTWE4JHjJzEaq
         KXTJi3BZ3u6rLXwFV+8bIVczVbFx0Xq1EwAmUh2zYV6If1jcLcT0x0WIxVh/S2824bUo
         AMGtGc5klIKhEUxCgI9cd2jNc9oFq55VtlI6j3Do5NCcKMWZ53+8IRwyhvVGaaZvo9U8
         su8kWJ/6iG3bmBCUYN00suf7KT0p6kvhhmi5Ibu62QMGWFCON4HJjSozHIRJRRuPhPJt
         aDmVfXMY2IKYpSTDM7zzmzWU1BDT7UD3X/6dTU+7Ip4A5D+ym1zZV7aKBet5xnoXh9iK
         jRyw==
X-Gm-Message-State: ABuFfojEew+ReUCBib+9jIGqTT/v+L/4SP5DXKdG5ZBMjkTqvKS6k5Dt
        DI+3df7sKHu32JSg/jZJWeUurLbvvJyNl1wyPy+890EaMRgu/uVJ
X-Google-Smtp-Source: ACcGV60aSXyU84yeTWTjuO3EPk+RxKbW6H1sWbJqavFYYLi9d6xEPy264lfe2lwLNf3hXJX0txaZYUoNUw2qP4zjv4A=
X-Received: by 2002:aca:c444:: with SMTP id u65-v6mr4048072oif.8.1538076514289;
 Thu, 27 Sep 2018 12:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-6-tycho@tycho.ws>
In-Reply-To: <20180927151119.9989-6-tycho@tycho.ws>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Sep 2018 21:28:07 +0200
Message-ID: <CAG48ez0JY=_fvgy+t92-08kBFgTAZ-3hgAp+OOAwmSd73MJ-QA@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] seccomp: add a way to pass FDs via a notification fd
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
        suda.akihiro@lab.ntt.co.jp, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 5:11 PM Tycho Andersen <tycho@tycho.ws> wrote:
> This patch adds a way to insert FDs into the tracee's process (also
> close/overwrite fds for the tracee). This functionality is necessary to
> mock things like socketpair() or dup2() or similar, but since it depends on
> external (vfs) patches, I've left it as a separate patch as before so the
> core functionality can still be merged while we argue about this. Except
> this time it doesn't add any ugliness to the API :)
[...]
> +static long seccomp_notify_put_fd(struct seccomp_filter *filter,
> +                                 unsigned long arg)
> +{
> +       struct seccomp_notif_put_fd req;
> +       void __user *buf = (void __user *)arg;
> +       struct seccomp_knotif *knotif = NULL;
> +       long ret;
> +
> +       if (copy_from_user(&req, buf, sizeof(req)))
> +               return -EFAULT;
> +
> +       if (req.fd < 0 && req.to_replace < 0)
> +               return -EINVAL;
> +
> +       ret = mutex_lock_interruptible(&filter->notify_lock);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = -ENOENT;
> +       list_for_each_entry(knotif, &filter->notif->notifications, list) {
> +               struct file *file = NULL;
> +
> +               if (knotif->id != req.id)
> +                       continue;

Are you intentionally permitting non-SENT states here? It shouldn't
make a big difference, but I think it'd be nice to at least block the
use of notifications in SECCOMP_NOTIFY_REPLIED state.

> +               if (req.fd >= 0)
> +                       file = fget(req.fd);
