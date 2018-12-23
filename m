Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995FBC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 14:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F16C21855
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 14:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="FF0ghTrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbeLWOEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 09:04:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50877 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeLWOEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 09:04:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so9363723wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 06:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=myDP5QPKg88xgD9tBBhOFVhtmIgKs6SI7mKn/Yy3ewM=;
        b=FF0ghTrVahccLjplPUFfj4UbCVhMWX+3VDUxyjRpNraeuqDaV+4G9sky94hQvi8aFT
         j8M0/Dt6moVPKifLfYPgjINTyK5Pp39TLgghMSHKeCVx4Cf2+LHhsVkFRPAVapamL4Fw
         LrW6oOMP91Bvh6wnlq45qxAJWLo7cZueOPLzWvhLZlotLkW6Em3Jzq0D81RT3bOuLoW0
         WeXjzfjIk8k+d0Y4rCfWUTvEBsWrsKSjxdCw4M6FJDXhRjqzSB/2CdP9sr7EESr5UtoH
         gsiLEjRqCKiZQpY/7dTozk+ndYAot4DVK1d4mfG+UhdH13F+V+dnVTtj93XiRpbANHDq
         lqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=myDP5QPKg88xgD9tBBhOFVhtmIgKs6SI7mKn/Yy3ewM=;
        b=DWd/tT4VUbaZB7nV4cDGE7YADQ2S6aASfIhilc9gwdnaav0xHCmRdrm+Qk1DAVl05C
         8ogvin5aAgdI8GQ3iNPWkryVUDXIH4Lq6LyUZWxxdzOnAFk7ZdBPXxRIs2WLJP+OGdQX
         XbIQOizkp4Kz6nfJbEY7NelnaxEiTu0LHlZ+t0tPbu3Nz4b+zKnZhLt/eGmAgNDJFKCL
         aP8JEOKWHe+TlqMNwLgbehjOfD8mJ17XdKBt5oUANYb9Z3/0LS9uw+RP5sm3trK6Ggir
         wltXOyU4rI8aPNF49qVce40xCXg/X7jPXVCpO6fEBA4JN6Bh4EG6fkfR1vjw0EQEbtsv
         gDEw==
X-Gm-Message-State: AA+aEWZbOp3ncjVvYCdD5G9IVynQZ7wdqFYx6VeJmHo9MEXhTRjZnHiY
        q/wgV/F7+DckarQWzw3SmV14JQ==
X-Google-Smtp-Source: ALg8bN7U4csGwKvIGM9lLNwRu5LQkGHnty4V1P9sYyIJthoL1PmkoeSPxWu68ZZZOZ7lK4KNM1yXGQ==
X-Received: by 2002:a1c:a895:: with SMTP id r143mr8945477wme.95.1545573479104;
        Sun, 23 Dec 2018 05:57:59 -0800 (PST)
Received: from brauner.io (p5B12DA88.dip0.t-ipconnect.de. [91.18.218.136])
        by smtp.gmail.com with ESMTPSA id n5sm20127721wrr.94.2018.12.23.05.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Dec 2018 05:57:58 -0800 (PST)
Date:   Sun, 23 Dec 2018 14:57:56 +0100
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] binderfs: implement "max" mount option
Message-ID: <20181223135755.sqnv5ave62jtj4se@brauner.io>
References: <20181222211806.1478-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181222211806.1478-1-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 10:18:06PM +0100, Christian Brauner wrote:
> Since binderfs can be mounted by userns root in non-initial user namespaces
> some precautions are in order. First, a way to set a maximum on the number
> of binder devices that can be allocated per binderfs instance and second, a
> way to reserve a reasonable chunk of binderfs devices for the initial ipc
> namespace.
> A first approach as seen in [1] used sysctls similiar to devpts but was
> shown to be flawed (cf. [2] and [3]) since some aspects were unneeded. This
> is an alternative approach which avoids sysctls completely and instead
> switches to a single mount option.
> 
> Starting with this commit binderfs instances can be mounted with a limit on
> the number of binder devices that can be allocated. The max=<count> mount
> option serves as a per-instance limit. If max=<count> is set then only
> <count> number of binder devices can be allocated in this binderfs
> instance.
> Additionally, the binderfs instance in the initial ipc namespace will
> always have a reserve of at least 1024 binder devices unless explicitly
> capped via max=<count>.
> 
> This allows to safely bind-mount binderfs instances into unprivileged user
> namespaces since userns root in a non-initial user namespace cannot change
> the mount option as long as it does not own the mount namespace the
> binderfs mount was created in and hence cannot drain the host of minor
> device numbers
> 
> [1]: https://lore.kernel.org/lkml/20181221133909.18794-1-christian@brauner.io/
> [2]; https://lore.kernel.org/lkml/20181221163316.GA8517@kroah.com/
> [3]: https://lore.kernel.org/lkml/CAHRSSEx+gDVW4fKKK8oZNAir9G5icJLyodO8hykv3O0O1jt2FQ@mail.gmail.com/
> [4]: https://lore.kernel.org/lkml/20181221192044.5yvfnuri7gdop4rs@brauner.io/
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  drivers/android/binderfs.c | 109 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 104 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 7496b10532aa..93aee00994d4 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -20,6 +20,7 @@
>  #include <linux/parser.h>
>  #include <linux/radix-tree.h>
>  #include <linux/sched.h>
> +#include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock_types.h>
>  #include <linux/stddef.h>
> @@ -39,6 +40,11 @@
>  #define INODE_OFFSET 3
>  #define INTSTRLEN 21
>  #define BINDERFS_MAX_MINOR (1U << MINORBITS)
> +/*
> + * Ensure that the initial ipc namespace always has a good chunk of devices
> + * available.
> + */
> +#define BINDERFS_MAX_MINOR_CAPPED (BINDERFS_MAX_MINOR - 1024)
>  
>  static struct vfsmount *binderfs_mnt;
>  
> @@ -46,6 +52,24 @@ static dev_t binderfs_dev;
>  static DEFINE_MUTEX(binderfs_minors_mutex);
>  static DEFINE_IDA(binderfs_minors);
>  
> +/**
> + * binderfs_mount_opts - mount options for binderfs
> + * @max: maximum number of allocatable binderfs binder devices
> + */
> +struct binderfs_mount_opts {
> +	int max;
> +};
> +
> +enum {
> +	Opt_max,
> +	Opt_err
> +};
> +
> +static const match_table_t tokens = {
> +	{ Opt_max, "max=%d" },
> +	{ Opt_err, NULL     }
> +};
> +
>  /**
>   * binderfs_info - information about a binderfs mount
>   * @ipc_ns:         The ipc namespace the binderfs mount belongs to.
> @@ -55,13 +79,16 @@ static DEFINE_IDA(binderfs_minors);
>   *                  created.
>   * @root_gid:       gid that needs to be used when a new binder device is
>   *                  created.
> + * @mount_opts:     The mount options in use.
> + * @device_count:   The current number of allocated binder devices.
>   */
>  struct binderfs_info {
>  	struct ipc_namespace *ipc_ns;
>  	struct dentry *control_dentry;
>  	kuid_t root_uid;
>  	kgid_t root_gid;
> -
> +	struct binderfs_mount_opts mount_opts;
> +	atomic_t device_count;
>  };
>  
>  static inline struct binderfs_info *BINDERFS_I(const struct inode *inode)
> @@ -107,13 +134,22 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
>  	struct inode *inode = NULL;
>  	struct super_block *sb = ref_inode->i_sb;
>  	struct binderfs_info *info = sb->s_fs_info;
> +	bool use_reserve = (info->ipc_ns == &init_ipc_ns);
>  
>  	/* Reserve new minor number for the new device. */
>  	mutex_lock(&binderfs_minors_mutex);
> -	minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR, GFP_KERNEL);
> +	if (atomic_inc_return(&info->device_count) < info->mount_opts.max)
> +		minor = ida_alloc_max(&binderfs_minors,
> +				      use_reserve ? BINDERFS_MAX_MINOR :
> +						    BINDERFS_MAX_MINOR_CAPPED,
> +				      GFP_KERNEL);
> +	else
> +		minor = -ENOSPC;
>  	mutex_unlock(&binderfs_minors_mutex);
> -	if (minor < 0)
> +	if (minor < 0) {
> +		atomic_dec(&info->device_count);
>  		return minor;
> +	}
>  
>  	ret = -ENOMEM;
>  	device = kzalloc(sizeof(*device), GFP_KERNEL);
> @@ -187,6 +223,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
>  	kfree(name);
>  	kfree(device);
>  	mutex_lock(&binderfs_minors_mutex);
> +	atomic_dec(&info->device_count);
>  	ida_free(&binderfs_minors, minor);
>  	mutex_unlock(&binderfs_minors_mutex);
>  	iput(inode);
> @@ -232,6 +269,7 @@ static long binder_ctl_ioctl(struct file *file, unsigned int cmd,
>  static void binderfs_evict_inode(struct inode *inode)
>  {
>  	struct binder_device *device = inode->i_private;
> +	struct binderfs_info *info = BINDERFS_I(inode);
>  
>  	clear_inode(inode);
>  
> @@ -239,6 +277,7 @@ static void binderfs_evict_inode(struct inode *inode)
>  		return;
>  
>  	mutex_lock(&binderfs_minors_mutex);
> +	atomic_dec(&info->device_count);
>  	ida_free(&binderfs_minors, device->miscdev.minor);
>  	mutex_unlock(&binderfs_minors_mutex);
>  
> @@ -246,9 +285,64 @@ static void binderfs_evict_inode(struct inode *inode)
>  	kfree(device);
>  }
>  
> +/**
> + * binderfs_parse_mount_opts - parse binderfs mount options
> + * @data: options to set (can be NULL in which case defaults are used)
> + */
> +static int binderfs_parse_mount_opts(char *data,
> +				     struct binderfs_mount_opts *opts)
> +{
> +	char *p;
> +	opts->max = BINDERFS_MAX_MINOR;
> +
> +	while ((p = strsep(&data, ",")) != NULL) {
> +		substring_t args[MAX_OPT_ARGS];
> +		int token;
> +		int max_devices;
> +
> +		if (!*p)
> +			continue;
> +
> +		token = match_token(p, tokens, args);
> +		switch (token) {
> +		case Opt_max:
> +			max_devices = match_int(&args[0], &max_devices);
> +			if (max_devices < 0 || (max_devices > BINDERFS_MAX_MINOR))
> +				return -EINVAL;

One should always account for their own stupid mistakes and here's one
I made: the ways match_int() is used here is nonsense since it
overwrites the parsed max_devices value. This should be:

if (match_int(&args[0], &max_devices) ||
    (max_devices < 0 ||
     (max_devices > BINDERFS_MAX_MINOR)))
        return -EINVAL;

Good that we have to have another version anyway. Sorry about that.

Christian

> +
> +			opts->max = max_devices;
> +			break;
> +		default:
> +			pr_err("Invalid mount options\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int binderfs_remount(struct super_block *sb, int *flags, char *data)
> +{
> +	struct binderfs_info *info = sb->s_fs_info;
> +	return binderfs_parse_mount_opts(data, &info->mount_opts);
> +}
> +
> +static int binderfs_show_mount_opts(struct seq_file *seq, struct dentry *root)
> +{
> +	struct binderfs_info *info;
> +
> +	info = root->d_sb->s_fs_info;
> +	if (info->mount_opts.max < BINDERFS_MAX_MINOR)
> +		seq_printf(seq, ",max=%d", info->mount_opts.max);
> +
> +	return 0;
> +}
> +
>  static const struct super_operations binderfs_super_ops = {
> -	.statfs = simple_statfs,
> -	.evict_inode = binderfs_evict_inode,
> +	.evict_inode    = binderfs_evict_inode,
> +	.remount_fs	= binderfs_remount,
> +	.show_options	= binderfs_show_mount_opts,
> +	.statfs         = simple_statfs,
>  };
>  
>  static int binderfs_rename(struct inode *old_dir, struct dentry *old_dentry,
> @@ -409,6 +503,10 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
>  	if (!info)
>  		goto err_without_dentry;
>  
> +	ret = binderfs_parse_mount_opts(data, &info->mount_opts);
> +	if (ret)
> +		goto err_without_dentry;
> +
>  	info->ipc_ns = ipc_ns;
>  	info->root_gid = make_kgid(sb->s_user_ns, 0);
>  	if (!gid_valid(info->root_gid))
> @@ -416,6 +514,7 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
>  	info->root_uid = make_kuid(sb->s_user_ns, 0);
>  	if (!uid_valid(info->root_uid))
>  		info->root_uid = GLOBAL_ROOT_UID;
> +	atomic_set(&info->device_count, 0);
>  
>  	sb->s_fs_info = info;
>  
> -- 
> 2.19.1
> 
