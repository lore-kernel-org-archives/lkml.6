Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD643C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D712075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aa57Wlz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D712075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbeIFUV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:21:58 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33854 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbeIFUV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:21:58 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so21494064ois.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCF/qGOGTlsPnERb2AnClt8bZvvrNKHSZvr5ZA3FL0k=;
        b=aa57Wlz1qcEqmNezU9oMI1c4IduE1+jZlS4oLQi3GhO8k0luazSwPnf/itreCnQuWC
         YvBc6yxiLs7EXup3uizv3vOekIITSlftGLa17iQXpH/qiqG8PCSvh50H5psGWi99LR+8
         HdVivpK1pcFozuqMzOTsyJLdAwbSw2wl+Fwl9rgjvMvwi6qnDrzIFU/4D9dn2mrb2A/p
         d8ub7R/71qIZX92wWBLNURWs6h6la6dS2Z9YA+K1nEDJZeGtzLkRlMsi6mjS/u45g+MV
         rQo1QkOvTZXB2kqehGeOC85po2j8QsLDmBhXUy3mU/EfaRm5j1IJzNw+EYvwjymRwWuf
         ELxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCF/qGOGTlsPnERb2AnClt8bZvvrNKHSZvr5ZA3FL0k=;
        b=RsnKFwaqAVN0XeEWjg9czWIMyxrb4PnCssH5kRlH0BMArKA8d4yx6GK4pY5Z9taKcL
         rtq61q8HrVExBAzripsdkPVxj8oQIvN+AP8eNX1exxWyO02L5voUUHet0rBeYaf6tX4Z
         Yn2X0M4Wq+A16SqQ7SjfW6lgH7YD1AYdpz36ffGwpBOz1Zu8KKQZRZ1/uiWozjpHUMom
         1kdmkvKixpCDgT/CdBBYGrfLF2s/cE2YcDouEQcAkpcfT8nJNqvmN8knGgqmZ0PYUgsA
         T6DRS5xBt+BFaqL4yb+jG6BQyhsrM9jBoGRxPoVfoQ8G4eDLl7X6L7bnxVvs+3RbbMOu
         Ws2w==
X-Gm-Message-State: APzg51C+EbS7qmB4WHx2v1Qi7TyIbXAwaGep5IdzSMc3fDChi9pZDt4z
        dptIgEuDIv2dWdothJwF9vIXOWnGFG7ohbdwSA9BYA==
X-Google-Smtp-Source: ANB0VdZnZ5IzqRwr29PPnWagZEt+JFJXf5cTrL0IpHw6BbSWedX58v1ysRQWamQ8EcxSHrEvcuBHlE9kvBwZjJjZuIw=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr3501091oia.229.1536248751783;
 Thu, 06 Sep 2018 08:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180906152859.7810-1-tycho@tycho.ws> <20180906152859.7810-4-tycho@tycho.ws>
In-Reply-To: <20180906152859.7810-4-tycho@tycho.ws>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Sep 2018 17:45:25 +0200
Message-ID: <CAG48ez3gRpGZT4Vk7ZZXk5dkYeVfnGsaqeFZeOio0GpqFd=Vow@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] seccomp: add a way to get a listener fd from ptrace
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
        Tyler Hicks <tyhicks@canonical.com>, suda.akihiro@lab.ntt.co.jp
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 5:29 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> version which can acquire filters is useful. There are at least two reasons
> this is preferable, even though it uses ptrace:
>
> 1. You can control tasks that aren't cooperating with you
> 2. You can control tasks whose filters block sendmsg() and socket(); if the
>    task installs a filter which blocks these calls, there's no way with
>    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
[...]
> +long seccomp_new_listener(struct task_struct *task,
> +                         unsigned long filter_off)
> +{
> +       struct seccomp_filter *filter;
> +       struct file *listener;
> +       int fd;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EACCES;
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

Did you mean to write something like `init_listener(task, filter)` here?
