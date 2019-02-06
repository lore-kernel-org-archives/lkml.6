Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1FDC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B3620823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gS6kMifr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfBFUNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:13:50 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37246 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBFUNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:13:49 -0500
Received: by mail-yw1-f67.google.com with SMTP id k14so3690910ywe.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 12:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Fmv2pHx4Se62c9cNHSKeysG38vPJoMpvl0ss48/iNo=;
        b=gS6kMifrlF4I8CvmXfF9O36hzXl+mNI0bVW+/H4/9E8Bdcv1uFvnow7ztsxgcthhh4
         gj7tq+Tw1qcM1EKHbPH3q6/vgnPsVSovzYDCLo+IWTEbM3L2UA+4wEBGbT0f6+xyMIvc
         ur2sO2WPb503M48n4hWtuowS9JP0Ch0gwqcGbgyMAHx14+qBp0qx5kuamqkRt6CZukib
         YGXq5aIvimZWxenVH+VBvTI1Dl7nxuEqowf26N6hJAuj1P0ILDGv6/OqER4nzbw2y4la
         S88pO3NS80hQoWhG4zT6v4GInPcWtMKtcPr8JB5mj49siBvI9aEYBiwLCP+j5pTeMGlr
         jkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Fmv2pHx4Se62c9cNHSKeysG38vPJoMpvl0ss48/iNo=;
        b=lOTqy/ZygwdWb+DSqgp7vt5Rrvo25P1XFeJKYUo7WtBsO1AseCgJxQ728V6tTDUw3V
         F/Q1dVyzR9+x8HattQNYzAQAxjTj4ZdT8VtdAqnURVAfsToXnAtIPboLWOFpEkCz2WT7
         1GKNyS7t5QikuuDDoUA/md3+J7sIu7pMrDhUN03zvDqBFygmxw+UFEA/aOUuC6SdfNxH
         T6gVmymu3YbeJuLGUum8xS7cuGxMo7lEtpHQljClQmBQIzibuu2SR7W464Xb9FfC/lt7
         cBFVAobPbcVlhK7BpEKhgTydoEZVywMvVf1bXNPlKUMX3sLSckyQnze+HMiioBug6cIc
         qeyA==
X-Gm-Message-State: AHQUAuZGbZXzxYOXb+srFYFH+3RXkCLnpy6dkj5NEuUmGkPjlSwX/NjS
        h4N+fFqhLv/OBBC+p9hGt152+dHGOoNmkMLxfagUPg==
X-Google-Smtp-Source: AHgI3IYOBCso6vSV1Zf9CMJ3PeTFwrA/TcFWhmPZugafE4Xsn+TygWmSXPKcOyqD2KRRD2gw65Gn7Flu85hYUQkAdB8=
X-Received: by 2002:a81:6189:: with SMTP id v131mr10122048ywb.37.1549484028175;
 Wed, 06 Feb 2019 12:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20190206195354.40576-1-sqazi@google.com>
In-Reply-To: <20190206195354.40576-1-sqazi@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 6 Feb 2019 12:13:35 -0800
Message-ID: <CANn89iJm6nehnTobQi6n=FUL1A8Nmc9UZ_S0ELNziQmEtZuo1g@mail.gmail.com>
Subject: Re: [PATCH] fs, ipc: Use an asynchronous version of kern_unmount in IPC
To:     Salman Qazi <sqazi@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 11:54 AM Salman Qazi <sqazi@google.com> wrote:
>
> Prior to this patch, the kernel can spend a lot of time with
> this stack trace:
>
> [<ffffffffbe5491e3>] __wait_rcu_gp+0x93/0xe0
> [<ffffffffbe549418>] synchronize_sched+0x48/0x60
> [<ffffffffbe7ae5b3>] kern_unmount+0x3a/0x46
> [<ffffffffbe847c02>] mq_put_mnt+0x15/0x17
> [<ffffffffbe8481af>] put_ipc_ns+0x36/0x8b
>
> This patch solves the issue by removing synchronize_rcu from mq_put_mnt.
> This is done by implementing an asynchronous version of kern_unmount.
>
> Since mntput() sleeps, it needs to be deferred to a work queue.
>
> Additionally, the callers of mq_put_mnt appear to be safe having
> it behave asynchronously.  In particular, put_ipc_ns calls
> mq_clear_sbinfo which renders the inode inaccessible for the purposes of
> mqueue_create by making s_fs_info NULL.  This appears
> to be the thing that prevents access while free_ipc_ns is taking place.
> So, the unmount should be able to proceed lazily.
>
> Tested: Ran the following program:
>
>     int main(void)
>     {
>             int pid;
>             int status;
>             int i;
>
>             for (i = 0; i < 1000; i++) {
>                     pid = fork();
>                     if (!pid) {
>                             assert(!unshare(CLONE_NEWUSER|
>                                       CLONE_NEWIPC|CLONE_NEWNS));
>                             return 0;
>                     }
>
>                     assert(waitpid(pid, &status, 0) == pid);
>             }
>     }
>
> Before:
>
> $ time ./unshare2
>
> real    0m9.784s
> user    0m0.428s
> sys     0m0.000s
>
> After:
>
> $ time ./unshare2
>
> real    0m0.368s
> user    0m0.226s
> sys     0m0.122s
>
> Signed-off-by: Salman Qazi <sqazi@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

> ---
>  fs/namespace.c     | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  1 +
>  ipc/mqueue.c       |  2 +-
>  3 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a677b59efd74..caa51ca81605 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3323,6 +3323,47 @@ void kern_unmount(struct vfsmount *mnt)
>  }
>  EXPORT_SYMBOL(kern_unmount);
>
> +struct async_unmount_cb {
> +       struct vfsmount *mnt;
> +       struct work_struct work;
> +       struct rcu_head rcu_head;
> +};
> +
> +static void kern_unmount_work(struct work_struct *work)
> +{
> +       struct async_unmount_cb *cb = container_of(work,
> +                       struct async_unmount_cb, work);
> +
> +       mntput(cb->mnt);
> +       kfree(cb);
> +}
> +
> +static void kern_unmount_rcu_cb(struct rcu_head *rcu_head)
> +{
> +       struct async_unmount_cb *cb = container_of(rcu_head,
> +                       struct async_unmount_cb, rcu_head);
> +
> +       INIT_WORK(&cb->work, kern_unmount_work);
> +       schedule_work(&cb->work);
> +
> +}
> +
> +void kern_unmount_async(struct vfsmount *mnt)
> +{
> +       /* release long term mount so mount point can be released */
> +       if (!IS_ERR_OR_NULL(mnt)) {
> +               struct async_unmount_cb *cb = kmalloc(sizeof(*cb), GFP_KERNEL);
> +
> +               if (cb) {
> +                       real_mount(mnt)->mnt_ns = NULL;
> +                       cb->mnt = mnt;
> +                       call_rcu(&cb->rcu_head, kern_unmount_rcu_cb);
> +               } else {
> +                       kern_unmount(mnt);
> +               }
> +       }
> +}
> +
>  bool our_mnt(struct vfsmount *mnt)
>  {
>         return check_mnt(real_mount(mnt));
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 29d8e2cfed0e..8865997a8722 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2274,6 +2274,7 @@ extern int register_filesystem(struct file_system_type *);
>  extern int unregister_filesystem(struct file_system_type *);
>  extern struct vfsmount *kern_mount_data(struct file_system_type *, void *data);
>  #define kern_mount(type) kern_mount_data(type, NULL)
> +extern void kern_unmount_async(struct vfsmount *mnt);
>  extern void kern_unmount(struct vfsmount *mnt);
>  extern int may_umount_tree(struct vfsmount *);
>  extern int may_umount(struct vfsmount *);
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index c595bed7bfcb..a8c2465ac0cb 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -1554,7 +1554,7 @@ void mq_clear_sbinfo(struct ipc_namespace *ns)
>
>  void mq_put_mnt(struct ipc_namespace *ns)
>  {
> -       kern_unmount(ns->mq_mnt);
> +       kern_unmount_async(ns->mq_mnt);
>  }
>
>  static int __init init_mqueue_fs(void)
> --
> 2.20.1.611.gfbb209baf1-goog
>
