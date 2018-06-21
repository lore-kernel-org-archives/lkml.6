Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814A2C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303162251D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a46q2rFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303162251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeFUXWB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:22:01 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34420 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932170AbeFUXV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:21:59 -0400
Received: by mail-ot0-f194.google.com with SMTP id r18-v6so5526730otk.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjossdpWt5D8KmkT2UMhykghlkFaPMSI50b15aLByC0=;
        b=a46q2rFwkUlsdmHRiRm+Uv/++8dsu5i79t9zM3QuhgAHrUplAEEAn7i1MZdiItRH/K
         5Cyw9oXbc4MmUiRYRiONOwvEij5OVWURV+igQO6QD2Jf6OuTf4v+jmu5bZivbdcNSORq
         K5suLYcAyKbZL9mFqeLhbZYzUQQQgxeVOTmI/2z95WWW7OGkl/JYty6Tf4MUkJQAwjgA
         kQ/3vY3oSXAJMeJEFxxpe4TZmi5cGkFVlwqncYsGGcmbw138S0bPOqPWstMDUMnxVhuC
         VJNkd7+wmp8bX27Pn/cq8tFOJXPy2ljJUbA2+DUZeKt0svkRn1PNgX/19tZ3PVAz5UNy
         9w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjossdpWt5D8KmkT2UMhykghlkFaPMSI50b15aLByC0=;
        b=ljNMNwJt/JEJSNrVVVLi7AMI/Umf68sAN1K63b56zp2AvG9VJjOAtO2rrpH4Tpo3jf
         XJoMN4CP6nYwa4448+ykf+bmTQeelVdTeM2Sd9KvUPPlD8h465yzj46ABtLWjKbyN2Ey
         8Db9tJkEXyKuRzq6L+KfdSgzq4wlAmcOGiI6ONjBq98UXtQs/RcrPb77+FND6fAJo5os
         8X4hCfL36ZMK797TEn2g78C8Vp0PSuI7t9mE09ieJ1grVTLUvx4YK/X5Pclc6UiRdknd
         1yvAWfDDp/qyf8mQBL/Qt5fT4RTFNEydeH8XxHujNIC4AS+GrRLhIiVVSt5rByi1+Uqk
         +6gQ==
X-Gm-Message-State: APt69E2ZG9518IvjaolPoMrYlBdxDp56dFeIshiPQsM/yC+p+FKWjP7u
        0ekQ7MFF3D4x9Urg0rAzKyiEJhpBUK/5Wk7XHHbZLQ==
X-Google-Smtp-Source: ADUXVKIn3op7qV9jrWgIclN+ukHHQiORsmgkemEUgWqY9Z9HsfUdTVBrC0MyvhjarfU78485KSbd+jFSExewUGCnHxU=
X-Received: by 2002:a9d:8ac:: with SMTP id 41-v6mr17833698otf.115.1529623318412;
 Thu, 21 Jun 2018 16:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180621220416.5412-1-tycho@tycho.ws> <20180621220416.5412-2-tycho@tycho.ws>
In-Reply-To: <20180621220416.5412-2-tycho@tycho.ws>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 22 Jun 2018 01:21:47 +0200
Message-ID: <CAG48ez2-vK57HfbRs94YLiz3SVJ7u4tTrxtAmbRepDqk6m-c_A@mail.gmail.com>
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
>
> This patch introduces a means for syscalls matched in seccomp to notify
> some other task that a particular filter has been triggered.
[...]
> +Userspace Notification
> +======================
> +
> +The ``SECCOMP_RET_USER_NOTIF`` return code lets seccomp filters pass a
> +particular syscall to userspace to be handled. This may be useful for
> +applications like container managers, which whish to intercept particular

typo: "wish"

[...]
> +passed around via ``SCM_RIGHTS`` or similar. Alternativley, a filter fd can be

typo: "Alternatively"

[...]
> +It is worth noting that ``struct seccomp_data`` contains the values of register
> +arguments to the syscall, but does not contain pointers to memory. The task's
> +memory is accessiable to suitably privileged traces via via ``ptrace()`` or

Typo: "accessible"

[...]
> +
> +static void seccomp_do_user_notification(int this_syscall,
> +                                        struct seccomp_filter *match,
> +                                        const struct seccomp_data *sd)
> +{
> +       int err;
> +       long ret = 0;
> +       struct seccomp_knotif n = {};
> +
> +       mutex_lock(&match->notify_lock);
> +       err = -ENOSYS;
> +       if (!match->has_listener)
> +               goto out;
> +
> +       n.pid = task_pid(current);
> +       n.state = SECCOMP_NOTIFY_INIT;
> +       n.data = sd;
> +       n.id = seccomp_next_notify_id(match);
> +       init_completion(&n.ready);
> +
> +       list_add(&n.list, &match->notifications);
> +       wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
> +
> +       mutex_unlock(&match->notify_lock);
> +       up(&match->request);
> +
> +       err = wait_for_completion_interruptible(&n.ready);
> +       mutex_lock(&match->notify_lock);
> +
> +       /*
> +        * Here it's possible we got a signal and then had to wait on the mutex
> +        * while the reply was sent, so let's be sure there wasn't a response
> +        * in the meantime.
> +        */
> +       if (err < 0 && n.state != SECCOMP_NOTIFY_REPLIED) {
> +               /*
> +                * We got a signal. Let's tell userspace about it (potentially
> +                * again, if we had already notified them about the first one).
> +                */
> +               if (n.state == SECCOMP_NOTIFY_SENT) {
> +                       n.state = SECCOMP_NOTIFY_INIT;
> +                       up(&match->request);
> +               }
> +               mutex_unlock(&match->notify_lock);
> +               err = wait_for_completion_killable(&n.ready);

Does this mean that when you get a signal that isn't SIGKILL,
wait_for_completion_interruptible() will bail out with -ERESTARTSYS,
but then you hang on this wait_for_completion_killable()? I don't
understand what's going on here. What's the point of using
wait_for_completion_interruptible() when you'll just hang on another
wait on the same "struct completion"?

> +               mutex_lock(&match->notify_lock);
> +               if (err < 0)
> +                       goto remove_list;
> +       }
> +
> +       ret = n.val;
> +       err = n.error;
> +
> +remove_list:
> +       list_del(&n.list);
> +out:
> +       mutex_unlock(&match->notify_lock);
> +       syscall_set_return_value(current, task_pt_regs(current),
> +                                err, ret);
> +}
