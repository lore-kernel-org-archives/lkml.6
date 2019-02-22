Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF40DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09DD2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKVss5xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfBVR7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:59:00 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43602 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:58:59 -0500
Received: by mail-ot1-f66.google.com with SMTP id n71so2567337ota.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 09:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GUH2mvQ+Y+Jhx48HtQhpGLhr3IvVxeBv5fSTfJb0brM=;
        b=qKVss5xwWGSjuS/gWYhea0UYwIwjBtzAnKdihSdgZetHZXAxaVECrMdnUCHN1ZYQ0D
         I/YYUddXYIAuyyTytDWh9K1WvwtobsrORZY5lZnbq9l1QzT53wvy7jL+KlM8IJHjFYpl
         sQljArnym8f877i4OH6jntP6x0Zx8UGt5axhMu1FmrqIFaxP2eG2yTIs8kG565Q6uvdz
         3ZkSn3uLLrCb0AOUCJ42iTDqNZfMSUgmh0H84Aq5FecTS+KSZ8qplJ4cPc3pGx/qeCqd
         wll8DHie7y4Q2lRPwie1zrsHWk3qOpNhc4zLN+RmGOdBcI6HTDG1YabyRI5Ns/dWxEnK
         YxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GUH2mvQ+Y+Jhx48HtQhpGLhr3IvVxeBv5fSTfJb0brM=;
        b=VZ9b0v8TBnjPtZkio0ZJQEX2N+LdKb1sQaqXGegxdojEJneOIJ5/dq11XOqlO7XhX1
         NBo23XB8S9gQxQQHAuxj3JwaZXfQY1UWMcOOKDTPfBPhN6VHqxJJ8pzY50q7Ozd9WDRg
         tigg674/hw681jt67OQOdNHBVLgxzprAQlBOp3y9XJy8LmJmpA2rIzsYo5TjapPNsYAj
         ZM3c9CEkzc4JECUrI5jkck2KaU+arwsC3yWGr6N5aBKd20F2iqB+k4l0Epd8I80/AQqt
         Xt4W8QMraWu4s+OUaZwyjteFet9e7/v1V0AO/dRdapwtkKPxrR1t+94N4P7j+j3INJCX
         uK8Q==
X-Gm-Message-State: AHQUAubW565kGO9QQOppo5Z87gyH321/Sm/hX9LTJ7nEWVDq8cvu1nED
        dfcEkNrNz4PY83OLA+9Me9dNIEaVA0VvoxsGUV8=
X-Google-Smtp-Source: AHgI3IaWM5pJepHWqKSfeo/K9Batt0+cKnRNbN8MpnTE5Y9VG31R0ovzrDtto1bQCbtDDMIW6f/X/tbTeMmqE8dRT0o=
X-Received: by 2002:a05:6830:20da:: with SMTP id z26mr3566600otq.204.1550858338446;
 Fri, 22 Feb 2019 09:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20190201203959.10050-1-albertvaka@gmail.com>
In-Reply-To: <20190201203959.10050-1-albertvaka@gmail.com>
From:   Albert Vaca Cintora <albertvaka@gmail.com>
Date:   Fri, 22 Feb 2019 18:58:32 +0100
Message-ID: <CAAQViEv2eBf9o7EaXo1=6hJrhDQJawf3jreFt=CWPDJCUzGRxw@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/ucounts: expose count of inotify watches in use
To:     Albert Vaca Cintora <albertvaka@gmail.com>,
        akpm@linux-foundation.org, rdunlap@infradead.org, mingo@kernel.org,
        Jan Kara <jack@suse.cz>, ebiederm@xmission.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, mbrugger@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 9:42 PM Albert Vaca Cintora <albertvaka@gmail.com> wrote:
>
> Adds a readonly 'current_inotify_watches' entry to the user sysctl table.
> The handler for this entry is a custom function that ends up calling
> proc_dointvec. Said sysctl table already contains 'max_inotify_watches'
> and it gets mounted under /proc/sys/user/.
>
> Inotify watches are a finite resource, in a similar way to available file
> descriptors. The motivation for this patch is to be able to set up
> monitoring and alerting before an application starts failing because
> it runs out of inotify watches.
>
> Signed-off-by: Albert Vaca Cintora <albertvaka@gmail.com>
> Acked-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Friendly ping. Any comments on this?

> ---
>  kernel/ucount.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index f48d1b6376a4..d8b11e53f098 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -57,6 +57,11 @@ static struct ctl_table_root set_root = {
>         .permissions = set_permissions,
>  };
>
> +#ifdef CONFIG_INOTIFY_USER
> +int proc_read_inotify_watches(struct ctl_table *table, int write,
> +                    void __user *buffer, size_t *lenp, loff_t *ppos);
> +#endif
> +
>  static int zero = 0;
>  static int int_max = INT_MAX;
>  #define UCOUNT_ENTRY(name)                             \
> @@ -79,6 +84,12 @@ static struct ctl_table user_table[] = {
>  #ifdef CONFIG_INOTIFY_USER
>         UCOUNT_ENTRY("max_inotify_instances"),
>         UCOUNT_ENTRY("max_inotify_watches"),
> +       {
> +               .procname       = "current_inotify_watches",
> +               .maxlen         = sizeof(int),
> +               .mode           = 0444,
> +               .proc_handler   = proc_read_inotify_watches,
> +       },
>  #endif
>         { }
>  };
> @@ -226,6 +237,24 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
>         put_ucounts(ucounts);
>  }
>
> +#ifdef CONFIG_INOTIFY_USER
> +int proc_read_inotify_watches(struct ctl_table *table, int write,
> +                    void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +       struct ucounts *ucounts;
> +       struct ctl_table fake_table;
> +       int count;
> +
> +       ucounts = get_ucounts(current_user_ns(), current_euid());
> +       count = atomic_read(&ucounts->ucount[UCOUNT_INOTIFY_WATCHES]);
> +       put_ucounts(ucounts);
> +
> +       fake_table.data = &count;
> +       fake_table.maxlen = sizeof(count);
> +       return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
> +}
> +#endif
> +
>  static __init int user_namespace_sysctl_init(void)
>  {
>  #ifdef CONFIG_SYSCTL
> --
> 2.20.1
>
