Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C91C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7F6261F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0UFULaXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7F6261F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754937AbeFYWgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:36:13 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33512 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbeFYWgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:36:11 -0400
Received: by mail-lf0-f66.google.com with SMTP id b7-v6so4879265lfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZfVTcc8WiGZjHviOksOe2oQK9M8l9KVtDaK036ycWU=;
        b=0UFULaXg14BZBis5bvumFUxM8AEUKDN/tkpaw7EmcTNK7OwRh5KlkeW5W7w8wyC0V3
         Q9VEKhEEswzpco7N4FBCdxp407Y9zdGk+T0SpKhJX2EI24ZZ7pN5Kh7VAeshm9wkNeWy
         U3LxUz3LMi4HV8saeTL5SOuH96tHFzrpTv/5z5nKCS6XzzaackHIB0Tp6XiXA6+CGRMv
         inLw82bTWyL2wxyls94RyeSAJrNnVb/rxvUhs3KQDv6MO2CS2jAvtTE8BvUiG9VgovPT
         JNJwxppqhIy1pWbMoKEja1cZecJHZfoed8arcTYMdYEjY99Vm7SKHbuurDpBt/gpZyz/
         +gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZfVTcc8WiGZjHviOksOe2oQK9M8l9KVtDaK036ycWU=;
        b=kavN8m5a/qq6vRFc8gTuE71VbDt94MN9lP7LOc7ejcPs6GJLXC6u/fbZfCuxpWrgUT
         TS4Z/W044pgkdVq8MRhPeXcua/kVGiZdWL5mVY5ByfCux/9PvPaKnl1nof4EziDgiz/c
         7DYxo/qovcwEUk4fM9G9Fuq8fhgfBD0NeNuvQWcWt+uK1pgovbvyZfTMxe8S/Ba1uwyb
         htN/6BntasJlbSG0w2/7C2KCjQwSkCCVr/i3Cz/bmmm3gDLM/bdnPerlrwESLyznu0s8
         lyZOrvTnMiXOfOk/NNrn51w5wTN+IKhCPr9Cv1w4oC1LSoptORqH4dEMwj7sd5r3sgGJ
         hzvQ==
X-Gm-Message-State: APt69E0tL/9b/df0WK0+PpeMeJphJwzzmT53uDnvaN/sFUeO8aXC3KzI
        5nFeoZBFjl1lXT211SxYkAVcGJ49eBXidWappN6TR24=
X-Google-Smtp-Source: ADUXVKLs7hXzU8zWkyWJG45jBFIMbowxwsQyQ88KoJSfsJGcOb0+4w0+ruh93aVgeQX7aRJwU8adarYjgyIzK2f3L5M=
X-Received: by 2002:a19:d754:: with SMTP id o81-v6mr3188635lfg.124.1529966170287;
 Mon, 25 Jun 2018 15:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180625163425.216965-1-jannh@google.com>
In-Reply-To: <20180625163425.216965-1-jannh@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Jun 2018 18:35:59 -0400
Message-ID: <CAHC9VhTipjBx9CF4FdTbc2a8bSqKqWiHfi9Krv=Lu74Yvquyrg@mail.gmail.com>
Subject: Re: [PATCH] selinux: move user accesses in selinuxfs out of locked regions
To:     jannh@google.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        security@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 12:34 PM Jann Horn <jannh@google.com> wrote:
> If a user is accessing a file in selinuxfs with a pointer to a userspace
> buffer that is backed by e.g. a userfaultfd, the userspace access can
> stall indefinitely, which can block fsi->mutex if it is held.
>
> For sel_read_policy(), remove the locking, since this method doesn't seem
> to access anything that requires locking.

Forgive me, I'm thinking about this quickly so I could be very wrong
here, but isn't the mutex needed to prevent problems in multi-threaded
apps hitting the same fd at the same time?

> For sel_read_bool(), move the user access below the locked region.
>
> For sel_write_bool() and sel_commit_bools_write(), move the user access
> up above the locked region.
>
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  security/selinux/selinuxfs.c | 77 ++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 44 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index f3d374d2ca04..065f8cea84e3 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -445,18 +445,13 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
>         struct policy_load_memory *plm = filp->private_data;
>         int ret;
>
> -       mutex_lock(&fsi->mutex);
> -
>         ret = avc_has_perm(&selinux_state,
>                            current_sid(), SECINITSID_SECURITY,
>                           SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
>         if (ret)
> -               goto out;
> +               return ret;
>
> -       ret = simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
> -out:
> -       mutex_unlock(&fsi->mutex);
> -       return ret;
> +       return simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
>  }
>
>  static vm_fault_t sel_mmap_policy_fault(struct vm_fault *vmf)
> @@ -1188,25 +1183,29 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
>         ret = -EINVAL;
>         if (index >= fsi->bool_num || strcmp(name,
>                                              fsi->bool_pending_names[index]))
> -               goto out;
> +               goto out_unlock;
>
>         ret = -ENOMEM;
>         page = (char *)get_zeroed_page(GFP_KERNEL);
>         if (!page)
> -               goto out;
> +               goto out_unlock;
>
>         cur_enforcing = security_get_bool_value(fsi->state, index);
>         if (cur_enforcing < 0) {
>                 ret = cur_enforcing;
> -               goto out;
> +               goto out_unlock;
>         }
>         length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
>                           fsi->bool_pending_values[index]);
> -       ret = simple_read_from_buffer(buf, count, ppos, page, length);
> -out:
>         mutex_unlock(&fsi->mutex);
> +       ret = simple_read_from_buffer(buf, count, ppos, page, length);
> +out_free:
>         free_page((unsigned long)page);
>         return ret;
> +
> +out_unlock:
> +       mutex_unlock(&fsi->mutex);
> +       goto out_free;
>  }
>
>  static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
> @@ -1219,6 +1218,17 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
>         unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
>         const char *name = filep->f_path.dentry->d_name.name;
>
> +       if (count >= PAGE_SIZE)
> +               return -ENOMEM;
> +
> +       /* No partial writes. */
> +       if (*ppos != 0)
> +               return -EINVAL;
> +
> +       page = memdup_user_nul(buf, count);
> +       if (IS_ERR(page))
> +               return PTR_ERR(page);
> +
>         mutex_lock(&fsi->mutex);
>
>         length = avc_has_perm(&selinux_state,
> @@ -1233,22 +1243,6 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
>                                              fsi->bool_pending_names[index]))
>                 goto out;
>
> -       length = -ENOMEM;
> -       if (count >= PAGE_SIZE)
> -               goto out;
> -
> -       /* No partial writes. */
> -       length = -EINVAL;
> -       if (*ppos != 0)
> -               goto out;
> -
> -       page = memdup_user_nul(buf, count);
> -       if (IS_ERR(page)) {
> -               length = PTR_ERR(page);
> -               page = NULL;
> -               goto out;
> -       }
> -
>         length = -EINVAL;
>         if (sscanf(page, "%d", &new_value) != 1)
>                 goto out;
> @@ -1280,6 +1274,17 @@ static ssize_t sel_commit_bools_write(struct file *filep,
>         ssize_t length;
>         int new_value;
>
> +       if (count >= PAGE_SIZE)
> +               return -ENOMEM;
> +
> +       /* No partial writes. */
> +       if (*ppos != 0)
> +               return -EINVAL;
> +
> +       page = memdup_user_nul(buf, count);
> +       if (IS_ERR(page))
> +               return PTR_ERR(page);
> +
>         mutex_lock(&fsi->mutex);
>
>         length = avc_has_perm(&selinux_state,
> @@ -1289,22 +1294,6 @@ static ssize_t sel_commit_bools_write(struct file *filep,
>         if (length)
>                 goto out;
>
> -       length = -ENOMEM;
> -       if (count >= PAGE_SIZE)
> -               goto out;
> -
> -       /* No partial writes. */
> -       length = -EINVAL;
> -       if (*ppos != 0)
> -               goto out;
> -
> -       page = memdup_user_nul(buf, count);
> -       if (IS_ERR(page)) {
> -               length = PTR_ERR(page);
> -               page = NULL;
> -               goto out;
> -       }
> -
>         length = -EINVAL;
>         if (sscanf(page, "%d", &new_value) != 1)
>                 goto out;
> --
> 2.18.0.rc2.346.g013aa6912e-goog
>


-- 
paul moore
www.paul-moore.com
