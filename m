Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578FFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BCF2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkguI0Xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BCF2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeIQVT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:19:26 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43556 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbeIQVTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:19:25 -0400
Received: by mail-yb1-f196.google.com with SMTP id k5-v6so7924999ybo.10;
        Mon, 17 Sep 2018 08:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAi13+z7iGe276I+dwbsQx9WJlQiTtbnVYUsw0Kiq9o=;
        b=SkguI0XlmNIcq6uNIdi6Hju5HR2MpVWNwz3bDd3Gn9XDZSuMppIsAgPg8xz0LcBZ1W
         lnUaQwuIcxKym03yDeKfVtBqo1Ms6lVyPs1iLHI26qTQ5mT4Cy43d05Pt6btTyYMFmJi
         v4l5YGhTCUjrnWPEBbNvgvpSOEu39MY3xlftP61rceFKdDiRz+QR1rkZc4SzucPwnMjX
         wXX826XHRP87SdKbbVjzF6nzcFBUMypR3Prv+1uYL4C02FBC0d95ipnbQ/VWI7a3vOcM
         eBQ75tGzZNBi0rhHPFM4cFSwUrXR6B9DP31lWwRU/mFPrf5pND6rBuvIhgJn/nrgqk3E
         uwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAi13+z7iGe276I+dwbsQx9WJlQiTtbnVYUsw0Kiq9o=;
        b=ZRHtjZun6cSoDzZsv7g+ttX2fIaRl1a62UsFYJgZ6TSu4Uo3APeaI/SKzr3v2F2mnd
         pjZSK7Yst+OXORxTdixOvoAbycoVCXW53+vUZN+9UyrmYqKVsIvFdcleO7xRwhieloSG
         ElI54ST8dHcphxOsBrCWFGm4fhDaMeEdetdA8Wu+qakMOWJgi0ID0+I+eWnQGvR4ujCo
         28RjjoXwaPkKJubsAMKie+duDx33l947FDyUtd8Iwr4+xcLYOBhJFt+0wlY1yyHqITf6
         zsejIyfPD3WkA1tA0/QyUfMDbibDJ76tHX2x1Y+Rps1b44HVr4H2+quMj3mYBHMdUyv6
         4IPw==
X-Gm-Message-State: APzg51D3wo0EuEayAk6LDidxUnec9EwbtftDR6I8BhYrY36B5HTo7MOl
        6gicoozrkMDnnF+iRjYRT+49hFK+3lwNbSXn2/h3hkvS
X-Google-Smtp-Source: ANB0VdYwvtcgtOA0JqbwvtfVcTIFPqZDYGHG1FuTlC3JkrqVozw0wMh4xZzK1CbgR+DKxXxSXnck2rxXcDffCuDyDig=
X-Received: by 2002:a25:5555:: with SMTP id j82-v6mr4826347ybb.337.1537199489397;
 Mon, 17 Sep 2018 08:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180917141950.111841-1-nixiaoming@huawei.com>
In-Reply-To: <20180917141950.111841-1-nixiaoming@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 17 Sep 2018 18:51:18 +0300
Message-ID: <CAOQ4uxj_o9FP8EH9_=TX=Tv9WDfExykrni7OjE3992YZrJDpZg@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify reports the thread id of the event trigger
To:     nixiaoming@huawei.com
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 6:05 PM nixiaoming <nixiaoming@huawei.com> wrote:
>
> In order to identify which thread triggered the event in the
> multi-threaded program, add the FAN_EVENT_INFO_TID tag in fanotify_init

According to code and man page this is a 'flag' not a 'tag'
Please stick to existing terminology.

> to select whether to report the event creator's thread id information.
>
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> ---
>  fs/notify/fanotify/fanotify.c      | 5 ++++-
>  fs/notify/fanotify/fanotify_user.c | 5 +++--
>  include/linux/fsnotify_backend.h   | 1 +
>  include/uapi/linux/fanotify.h      | 1 +
>  4 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 94b5215..5a3af87 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -171,7 +171,10 @@ struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
>                 goto out;
>  init: __maybe_unused
>         fsnotify_init_event(&event->fse, inode, mask);
> -       event->tgid = get_pid(task_tgid(current));
> +       if (group->fanotify_data.should_report_tid)
> +               event->tgid = get_pid(task_pid(current));
> +       else
> +               event->tgid = get_pid(task_tgid(current));
>         if (path) {
>                 event->path = *path;
>                 path_get(&event->path);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 6905488..3aa425b 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -693,9 +693,9 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>                 return -EPERM;
>
>  #ifdef CONFIG_AUDITSYSCALL
> -       if (flags & ~(FAN_ALL_INIT_FLAGS | FAN_ENABLE_AUDIT))
> +       if (flags & ~(FAN_ALL_INIT_FLAGS | FAN_ENABLE_AUDIT | FAN_EVENT_INFO_TID))
>  #else
> -       if (flags & ~FAN_ALL_INIT_FLAGS)
> +       if (flags & ~(FAN_ALL_INIT_FLAGS | FAN_EVENT_INFO_TID))

Not this way. You need to add FAN_EVENT_INFO_TID to FAN_ALL_INIT_FLAGS.

>  #endif
>                 return -EINVAL;
>
> @@ -731,6 +731,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>         }
>
>         group->fanotify_data.user = user;
> +       group->fanotify_data.should_report_tid = (flags & FAN_EVENT_INFO_TID) ? true : false;

Please drop "? true : false" its not needed.

>         atomic_inc(&user->fanotify_listeners);
>         group->memcg = get_mem_cgroup_from_mm(current->mm);
>
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index b8f4182..44c659f 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -193,6 +193,7 @@ struct fsnotify_group {
>                         unsigned int max_marks;
>                         struct user_struct *user;
>                         bool audit;
> +                       bool should_report_tid;

For brevity I would call that report_tid, but not insisting.

>                 } fanotify_data;
>  #endif /* CONFIG_FANOTIFY */
>         };
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index 7424791..4eba41c 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -18,6 +18,7 @@
>
>  #define FAN_ONDIR              0x40000000      /* event occurred against dir */
>
> +#define FAN_EVENT_INFO_TID     0x02000000      /* reports the thread id of the event trigger */

That is not the right place nor the sensible value for this flag, but this:

#define FAN_UNLIMITED_QUEUE     0x00000010
#define FAN_UNLIMITED_MARKS     0x00000020
#define FAN_ENABLE_AUDIT        0x00000040
+#define FAN_EVENT_INFO_TID     0x00000080

Thanks,
Amir.
