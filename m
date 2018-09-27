Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B207C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20136216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5tGp/oM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20136216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeI0XKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:10:46 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46373 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI0XKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:10:46 -0400
Received: by mail-oi1-f196.google.com with SMTP id k64-v6so2736074oia.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjgEBjeMZkDXjOXNUaEg8wy8xbWViFb+frjvCZaeJkI=;
        b=H5tGp/oM+4fcxwl2/RhDdsE96XNRO++OCWzCKI768zDg7BuPRiAmrpcimp+8NvYnZd
         1eTdak/mId7rZpLDJ5Q6NrCmb/0fQbuQXsXgvF8kGaoba2Frci467rUSbHob7QJeDjs5
         Cdn+vaVKST13MFu0nvGhGJnrCRfIZ8+Y3u7UIBm7pnX7y0wsOq/K4rBJBYe15II1jTPo
         AotMUyCklM4ni4I/HT+mABpFOsf3qTu2MfncWRakauMkNCDK37ccJgjCxZhG6l0rpp03
         YGr/2c+UFt91OuMnARjUzsknS5OseiKsi5liecF1n2Ht8LrjNGFDwRb9bmszkm8BUi47
         DZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjgEBjeMZkDXjOXNUaEg8wy8xbWViFb+frjvCZaeJkI=;
        b=qxRSgvMXQLHlxmHBPFYQ5pFeGb7j7WCDSSCg+AOU0QRGL9DlFhtsBjg587C+dwUGSL
         fue6i6VEDcYtLAE0vVQl8re9qfdPPtx6LTDQAYsXmFFGlGQTlG/OM/sTkD2QUd3lf8Dw
         n6BMmSremrNeXtGxTWJ4BJdxODjBqUNfERjHNBE5feHA0T7X/YIO1Ih6QtdSxdRUHs7M
         +dwjaxQT6j0QWPVSE7vtuXE1PFf9uD0HL1m+A3sNLKc3rO+r21tMDTuLbz4vI4aSqIc3
         aD4ESMGYzuNW2lf2gQnhUXSefbI3yxJzfUs4zohBoAthNOdHj6BKWFqk10TF8YH9a1Tp
         04Yg==
X-Gm-Message-State: ABuFfojE/jAxgdZH45HSQQFtsJrD9z8499JEmlmDG5zzSr+lOe769Fkx
        tgNJLe9h2iWFe+UMtiN0lySuAZ71KSKC91YlVpznQw==
X-Google-Smtp-Source: ACcGV61n7Asf756JpW1H1LNTdGpuzbY2k66mRKtoqTTDMXPvJcO/dgw6elBYLvICK3D1rhzqY51PaM1kaa4EbcD3pzE=
X-Received: by 2002:aca:4d13:: with SMTP id a19-v6mr3386701oib.205.1538067096854;
 Thu, 27 Sep 2018 09:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-3-tycho@tycho.ws>
In-Reply-To: <20180927151119.9989-3-tycho@tycho.ws>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Sep 2018 18:51:10 +0200
Message-ID: <CAG48ez0-Zq74QCVJ+P0QZZOE4RG-Y_py-GiKhsD12njkbTgVgw@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
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
> In the next commit we'll use this same mnemonic to get a listener for the
> nth filter, so we need it available outside of CHECKPOINT_RESTORE in the
> USER_NOTIFICATION case as well.
>
> v2: new in v2
> v3: no changes
> v4: no changes
> v5: switch to CHECKPOINT_RESTORE || USER_NOTIFICATION to avoid warning when
>     only CONFIG_SECCOMP_FILTER is enabled.
> v7: drop USER_NOTIFICATION bits
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> CC: "Serge E. Hallyn" <serge@hallyn.com>
> CC: Christian Brauner <christian.brauner@ubuntu.com>
> CC: Tyler Hicks <tyhicks@canonical.com>
> CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>

Reviewed-by: Jann Horn <jannh@google.com>

> ---
>  kernel/seccomp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index fa6fe9756c80..44a31ac8373a 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1158,7 +1158,7 @@ long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
>         return do_seccomp(op, 0, uargs);
>  }
>
> -#if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
> +#if defined(CONFIG_SECCOMP_FILTER)
>  static struct seccomp_filter *get_nth_filter(struct task_struct *task,
>                                              unsigned long filter_off)
>  {
> @@ -1205,6 +1205,7 @@ static struct seccomp_filter *get_nth_filter(struct task_struct *task,
>         return filter;
>  }
>
> +#if defined(CONFIG_CHECKPOINT_RESTORE)
>  long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
>                         void __user *data)
>  {
> @@ -1277,7 +1278,8 @@ long seccomp_get_metadata(struct task_struct *task,
>         __put_seccomp_filter(filter);
>         return ret;
>  }
> -#endif
> +#endif /* CONFIG_CHECKPOINT_RESTORE */
> +#endif /* CONFIG_SECCOMP_FILTER */
>
>  #ifdef CONFIG_SYSCTL
>
> --
> 2.17.1
>
