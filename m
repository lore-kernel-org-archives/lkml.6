Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0C4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6C1216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZ7X4bM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6C1216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeI0W6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:58:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44630 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI0W6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:58:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id 36-v6so3164721oth.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W+NSFHXC1p7u5iKRZ3HUB2PYuPEIC+MQP01YmK7YI6w=;
        b=KZ7X4bM/YsPzjj35WqOrg2UGCcJ4bckA/Y4vHxEKNxSdRx/XcW5qTohQifYPa/gBJt
         DdrlJDiioYy6DHBq6D9lXk0VIKTLa8uEqWwoVYaeVLY8A8ByxkfsyFwBnG8J/2dE0Vzw
         34FP9Q4BJ8O4tWpXUy3F2PDPvBigCMBw6AWlXlFkaL72dOBDMbWh8W+/1/OoglJbHI1s
         MIpAm6YSy2Xp9fF4V6313h3Yjghc+9p96FGI29m+uSsCDdkWkfW99uyCDeOO+smK6E+s
         0vnEsSjGX1xINcs+Z9hJ3SbDRO1jPj/n8efAnVcdv/wFmvH+FwAMSi7+MSIdgf+rcm5C
         WV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W+NSFHXC1p7u5iKRZ3HUB2PYuPEIC+MQP01YmK7YI6w=;
        b=hVMGAi9XrqMIJVIOX4NaMn+/ccfq0MtRl1W21z7757jE4bJ4vtkMDvLn3oIAhDoShO
         xrCc8OIBivGHdIZQShALUvBEbROstAObbgf4jkoeUDncU+gSlZtHLk4i7mLHcV9n7vsY
         JaemmY0G+T8NmkIuTJOX2DArb/4j4tGyPOPYq8UUYGvQ1LJj7xFcZo7hEoey2w9twDUC
         rQn7qVIC1rg38XTHt5IQ8T835w7fbUlGkdojts3thGV1DNQZGY8hzc90akm6AeE8oU82
         4B5R7efthOcsodoPdIEv9bZ5vJKkyR2gBU8mn5GgBtlC7erFSNaBCkrRjs/QhXTu+cKC
         Tvfw==
X-Gm-Message-State: ABuFfoj1q1844c0RBf0DMu7i0I3cp22wY0AyKh/X/7wEAwib5Ev/Ic1g
        uGEHq8iEstEn4TewUo210nN9arWGJ7+VvUsNLmLQpg==
X-Google-Smtp-Source: ACcGV61QNnJiluT64xkUX685JOGbFehISM7FM2VJe+Jex2+3MJ9tVmebgUtYHZ19XCziDEvFETLb8nJPhkqWx+EYL6c=
X-Received: by 2002:a9d:4716:: with SMTP id a22-v6mr7853743otf.242.1538066369286;
 Thu, 27 Sep 2018 09:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-6-tycho@tycho.ws>
In-Reply-To: <20180927151119.9989-6-tycho@tycho.ws>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Sep 2018 18:39:02 +0200
Message-ID: <CAG48ez2vJJQm8-Rdz4b=cvBQn2Ws-9wazVuVUXQFYqMMZh64YA@mail.gmail.com>
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
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 17685803a2af..07a05ad59731 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -41,6 +41,8 @@
>  #include <linux/tracehook.h>
>  #include <linux/uaccess.h>
>  #include <linux/anon_inodes.h>
> +#include <linux/fdtable.h>
> +#include <net/cls_cgroup.h>
>
>  enum notify_state {
>         SECCOMP_NOTIFY_INIT,
> @@ -1684,6 +1686,56 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
>         return ret;
>  }
>
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
> +
> +               if (req.fd >= 0)
> +                       file = fget(req.fd);

So here we take a reference on `file`.

> +               if (req.to_replace >= 0) {
> +                       ret = replace_fd_task(knotif->task, req.to_replace,
> +                                             file, req.fd_flags);

Then here we try to place the file in knotif->task's file descriptor
table. This can either fail (e.g. due to exceeded rlimit), in which
case nothing happens, or it can do do_dup2(), which first takes an
extra reference to the file, then places it in the task's fd table.

Either way, afterwards, we still hold a reference to the file.

> +               } else {
> +                       unsigned long max_files;
> +
> +                       max_files = task_rlimit(knotif->task, RLIMIT_NOFILE);
> +                       ret = __alloc_fd(knotif->task->files, 0, max_files,
> +                                        req.fd_flags);
> +                       if (ret < 0)
> +                               break;

If we bail out here, we still hold a reference to `file`.

Suggestion: Change this to "if (ret >= 0) {" and make the following
code conditional instead of breaking.

> +                       __fd_install(knotif->task->files, ret, file);

But if we reach this point, __fd_install() consumes the file pointer,
so `file` is a dangling pointer now.

Suggestion: Add "break;" here.

> +               }

Suggestion: Add "if (file != NULL) fput(file);" here.

> +               break;
> +       }
> +
> +       mutex_unlock(&filter->notify_lock);
> +       return ret;
> +}
