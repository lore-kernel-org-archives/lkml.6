Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CD6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B15B20672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="iXT7kCoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B15B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbeLCQgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:36:07 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38976 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeLCQgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:36:07 -0500
Received: by mail-yw1-f66.google.com with SMTP id j6so5627858ywj.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 08:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fo5judHZvSBImH/wG1Uv3rEljmo3HeRXo+o6dTCyr1I=;
        b=iXT7kCoe4yhumUlME04ZRiWq8uChJMQ537emGlv3v3K6b7+xsgiMBkjGup57YrHqmM
         WSTgKoTvXzdgIn00HLzf2xY/N3lq8y+tWeJmZD7wg2s4awPU3tMZ9sLsZl8YzxDVseZy
         2twBZraNivjcDD8vyrFlFgCSOqdPy+fTcC6BrK26n/Czr6c3SUjwsSLz21fOhTJ+VX0U
         3WppPstybn8Ox5GW3qLkBhdE2gcoeT2iQuWd84gkxHteThPErLoCtzprbi+SQ2zG6/Vx
         sYoF1LbhtM0WLTtXy0TUtF2Hx8Locdg19bYPEZQ1gOOJLdfH9sjYO3upoxcC12fM7VBn
         8hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fo5judHZvSBImH/wG1Uv3rEljmo3HeRXo+o6dTCyr1I=;
        b=J70grM2k8v7i7irJKqLsyG19fM7ENoREuob+SaQuM5e72Z4zmDfDgYWaXaCjvXhNUU
         BQSpgfu35KSRCQpYVg3BaW8yoOokoSoIoDPsvUqP5toO3ZBVduCYWEZcGebFtWfk3acp
         JvKecurq50vjlOeEH3esiDQ5JZNhP6So/NypGfOqlmPVKNISWmIw6HwJeyWRHY8azQjV
         SiGG3+qTawT+aHJ4UmlHFVLWcvtfTIhUMGHhs2Fv5G3gwZ+LohXTo24HeX4eTKQaODMD
         WG6E/umKb1PxrhTVcUSH6twwbgaei4e9hzJdcnGQlczy6ReHAvUCQEeGLwywaJsTvkX6
         HxYA==
X-Gm-Message-State: AA+aEWbQhMa3liwCIBA7LPXx/cx+JUjh9V9Mfee8E79pvXqF1TQ8Gwrt
        3q4SYZjXeEYiEXU6LnJPNnbJELWu2ZHUYNXKwH9Vag==
X-Google-Smtp-Source: AFSGD/U+6lzLIiKRXnkznBT9Br9bst3DRgf3n+YK/6g22i3hOaSx6pIRT3ick4hzo0+ASEGcEr/cpF4EkeCOJzIhQoU=
X-Received: by 2002:a81:b341:: with SMTP id r62mr16587412ywh.65.1543854962819;
 Mon, 03 Dec 2018 08:36:02 -0800 (PST)
MIME-Version: 1.0
References: <20181201012630.4459-1-tiny.windzz@gmail.com>
In-Reply-To: <20181201012630.4459-1-tiny.windzz@gmail.com>
From:   Todd Kjos <tkjos@android.com>
Date:   Mon, 3 Dec 2018 08:35:51 -0800
Message-ID: <CAD0t5oPbmV62N=72Xg_oU7Vtb41U5VT2OSehF_=LMaTj94tMzQ@mail.gmail.com>
Subject: Re: [PATCH] binder: remove BINDER_DEBUG_ENTRY()
To:     tiny.windzz@gmail.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Arve Hj??nnev??g" <arve@android.com>,
        Martijn Coenen <maco@android.com>, joel@joelfernandes.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 5:26 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> We already have the DEFINE_SHOW_ATTRIBUTE.There is no need to define
> such a macro,so remove BINDER_DEBUG_ENTRY.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Todd Kjos <tkjos@android.com>

> ---
>  drivers/android/binder.c | 48 ++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index cb30a524d16d..5496b8e07234 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -94,22 +94,8 @@ static struct dentry *binder_debugfs_dir_entry_root;
>  static struct dentry *binder_debugfs_dir_entry_proc;
>  static atomic_t binder_last_id;
>
> -#define BINDER_DEBUG_ENTRY(name) \
> -static int binder_##name##_open(struct inode *inode, struct file *file) \
> -{ \
> -       return single_open(file, binder_##name##_show, inode->i_private); \
> -} \
> -\
> -static const struct file_operations binder_##name##_fops = { \
> -       .owner = THIS_MODULE, \
> -       .open = binder_##name##_open, \
> -       .read = seq_read, \
> -       .llseek = seq_lseek, \
> -       .release = single_release, \
> -}
> -
> -static int binder_proc_show(struct seq_file *m, void *unused);
> -BINDER_DEBUG_ENTRY(proc);
> +static int proc_show(struct seq_file *m, void *unused);
> +DEFINE_SHOW_ATTRIBUTE(proc);
>
>  /* This is only defined in include/asm-arm/sizes.h */
>  #ifndef SZ_1K
> @@ -4964,7 +4950,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
>                 proc->debugfs_entry = debugfs_create_file(strbuf, 0444,
>                         binder_debugfs_dir_entry_proc,
>                         (void *)(unsigned long)proc->pid,
> -                       &binder_proc_fops);
> +                       &proc_fops);
>         }
>
>         return 0;
> @@ -5592,7 +5578,7 @@ static void print_binder_proc_stats(struct seq_file *m,
>  }
>
>
> -static int binder_state_show(struct seq_file *m, void *unused)
> +static int state_show(struct seq_file *m, void *unused)
>  {
>         struct binder_proc *proc;
>         struct binder_node *node;
> @@ -5631,7 +5617,7 @@ static int binder_state_show(struct seq_file *m, void *unused)
>         return 0;
>  }
>
> -static int binder_stats_show(struct seq_file *m, void *unused)
> +static int stats_show(struct seq_file *m, void *unused)
>  {
>         struct binder_proc *proc;
>
> @@ -5647,7 +5633,7 @@ static int binder_stats_show(struct seq_file *m, void *unused)
>         return 0;
>  }
>
> -static int binder_transactions_show(struct seq_file *m, void *unused)
> +static int transactions_show(struct seq_file *m, void *unused)
>  {
>         struct binder_proc *proc;
>
> @@ -5660,7 +5646,7 @@ static int binder_transactions_show(struct seq_file *m, void *unused)
>         return 0;
>  }
>
> -static int binder_proc_show(struct seq_file *m, void *unused)
> +static int proc_show(struct seq_file *m, void *unused)
>  {
>         struct binder_proc *itr;
>         int pid = (unsigned long)m->private;
> @@ -5703,7 +5689,7 @@ static void print_binder_transaction_log_entry(struct seq_file *m,
>                         "\n" : " (incomplete)\n");
>  }
>
> -static int binder_transaction_log_show(struct seq_file *m, void *unused)
> +static int transaction_log_show(struct seq_file *m, void *unused)
>  {
>         struct binder_transaction_log *log = m->private;
>         unsigned int log_cur = atomic_read(&log->cur);
> @@ -5735,10 +5721,10 @@ static const struct file_operations binder_fops = {
>         .release = binder_release,
>  };
>
> -BINDER_DEBUG_ENTRY(state);
> -BINDER_DEBUG_ENTRY(stats);
> -BINDER_DEBUG_ENTRY(transactions);
> -BINDER_DEBUG_ENTRY(transaction_log);
> +DEFINE_SHOW_ATTRIBUTE(state);
> +DEFINE_SHOW_ATTRIBUTE(stats);
> +DEFINE_SHOW_ATTRIBUTE(transactions);
> +DEFINE_SHOW_ATTRIBUTE(transaction_log);
>
>  static int __init init_binder_device(const char *name)
>  {
> @@ -5792,27 +5778,27 @@ static int __init binder_init(void)
>                                     0444,
>                                     binder_debugfs_dir_entry_root,
>                                     NULL,
> -                                   &binder_state_fops);
> +                                   &state_fops);
>                 debugfs_create_file("stats",
>                                     0444,
>                                     binder_debugfs_dir_entry_root,
>                                     NULL,
> -                                   &binder_stats_fops);
> +                                   &stats_fops);
>                 debugfs_create_file("transactions",
>                                     0444,
>                                     binder_debugfs_dir_entry_root,
>                                     NULL,
> -                                   &binder_transactions_fops);
> +                                   &transactions_fops);
>                 debugfs_create_file("transaction_log",
>                                     0444,
>                                     binder_debugfs_dir_entry_root,
>                                     &binder_transaction_log,
> -                                   &binder_transaction_log_fops);
> +                                   &transaction_log_fops);
>                 debugfs_create_file("failed_transaction_log",
>                                     0444,
>                                     binder_debugfs_dir_entry_root,
>                                     &binder_transaction_log_failed,
> -                                   &binder_transaction_log_fops);
> +                                   &transaction_log_fops);
>         }
>
>         /*
> --
> 2.17.0
>
