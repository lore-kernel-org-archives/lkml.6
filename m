Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0376EC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9732F20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="g302sTf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9732F20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389288AbeG0Uur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:50:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34242 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389075AbeG0Uuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:50:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so3780859pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 12:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eq4vYoTjawd2wS8YijCOlr/6RQwQa67WMzQTI6ZaKV8=;
        b=g302sTf0RZEogmcOaBFc6aq3rRxXc2xSlQ8HU59m4k9gtWzlyqXWUg1Alpd0ZHzYkQ
         RzDaynGmumv4Rk6u5tp02HmVHz5sYSAAReLj2HV3ZGvMu8cilxOLpS9v3zSkY5YU0o3Z
         9z8kwN2EDNlE8IwSqwozDljmCw72MtRzep7G1TUjoBruVwxMUEYDWmmo5zrLOaWiPP8y
         ir2uccN6VPPDH2swJ+VmAEi+jnV+7aKhp4b8c34SRFLyrtGUYTm1aB/Y9cpeyz+M6M99
         iIyCehp+RRyyL2r7E+lOGRov7gMo3Le7hibeiVC5z2u4wwW1HHfO8JvjoByymuSO47in
         5XnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eq4vYoTjawd2wS8YijCOlr/6RQwQa67WMzQTI6ZaKV8=;
        b=FANxxfCtgYtLhOmMCuAGMDJJ+ozwJV79wsgbNjam1qKOpHHq41Us43+bwdCmDY+Yfa
         vxnL3LSE9dOQbtl/BHct8EhlH0vBv9LE3Ba2i7oEZ6PeLIu9a+5K51s2rn1LEh1Vtn4y
         64l0VKmIEvgQT0155y005kaX7CgqLuQhKMZnWEZQRBzwEm85i7Fsy6cI8DEwlfHtZmaX
         SgP/pAY68/QGmo+Rl4DfcjqwENF85Sg+11chsn7FlVBLKI67cMq+JI5PQ/pfCKUGzFGo
         oNWKFhfiQPxQDS5Ph6+L9HzP7pVbS3beHlp7T2fuJqUUk92r2yjJHC8wDIAJaS3Le6Zg
         Km4Q==
X-Gm-Message-State: AOUpUlEh8guuYAPJVcyTndmZsvCNwgQ7ipXMmZNYJ1LQrcK5e+U6TY+d
        YiZzvtOBStWM3jU7U++43HKq4A==
X-Google-Smtp-Source: AAOMgpenrOMsQSmXB7yTnzSBRd7MfxTzCohhBVJ8lEMYNcTb9J8+FKYaCP8XBKbCUi4Syaw/tSi0DA==
X-Received: by 2002:a62:6d02:: with SMTP id i2-v6mr7878628pfc.218.1532719648482;
        Fri, 27 Jul 2018 12:27:28 -0700 (PDT)
Received: from [10.254.67.164] (150.sub-97-41-129.myvzw.com. [97.41.129.150])
        by smtp.gmail.com with ESMTPSA id p11-v6sm9079812pfj.72.2018.07.27.12.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 12:27:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 30/38] vfs: syscall: Add fsmount() to create a mount for a superblock [ver #10]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <153271288242.9458.18050138471208178879.stgit@warthog.procyon.org.uk>
Date:   Fri, 27 Jul 2018 12:27:23 -0700
Cc:     viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D09916DC-DA22-48AA-A62B-F874BB3C15BC@amacapital.net>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk> <153271288242.9458.18050138471208178879.stgit@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 27, 2018, at 10:34 AM, David Howells <dhowells@redhat.com> wrote:
>=20
> Provide a system call by which a filesystem opened with fsopen() and
> configured by a series of writes can be mounted:
>=20
>    int ret =3D fsmount(int fsfd, unsigned int flags,
>              unsigned int ms_flags);
>=20
> where fsfd is the file descriptor returned by fsopen().  flags can be 0 or=

> FSMOUNT_CLOEXEC.  ms_flags is a bitwise-OR of the following flags:

I have a potentially silly objection. For the old timers, =E2=80=9Cmount=E2=80=
=9D means to stick a reel of tape or some similar object onto a reader, whic=
h seems to imply that =E2=80=9Cmount=E2=80=9D means to start up the filesyst=
em. For younguns, this meaning is probably lost, and the more obvious meanin=
g is to =E2=80=9Cmount=E2=80=9D it into some location in the VFS hierarchy a=
 la vfsmount. The patch description doesn=E2=80=99t disambiguate it, and obv=
iously people used to mount(2)/mount(8) are just likely to be confused.

At the very least, your description should make it absolutely clear what you=
 mean. Even better IMO would be to drop the use of the word =E2=80=9Cmount=E2=
=80=9D entirely and maybe rename the syscall.

=46rom a very brief reading, I think you are giving it the meaning that woul=
d be implied by fsstart(2).

>=20
>    MS_RDONLY
>    MS_NOSUID
>    MS_NODEV
>    MS_NOEXEC
>    MS_NOATIME
>    MS_NODIRATIME
>    MS_RELATIME
>    MS_STRICTATIME
>=20
>    MS_UNBINDABLE
>    MS_PRIVATE
>    MS_SLAVE
>    MS_SHARED
>=20
> In the event that fsmount() fails, it may be possible to get an error
> message by calling read() on fsfd.  If no message is available, ENODATA
> will be reported.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-api@vger.kernel.org
> ---
>=20
> arch/x86/entry/syscalls/syscall_32.tbl |    1=20
> arch/x86/entry/syscalls/syscall_64.tbl |    1=20
> fs/namespace.c                         |  140 ++++++++++++++++++++++++++++=
+++-
> include/linux/syscalls.h               |    1=20
> include/uapi/linux/fs.h                |    2=20
> 5 files changed, 141 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/sysca=
lls/syscall_32.tbl
> index f9970310c126..c78b68256f8a 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -402,3 +402,4 @@
> 388    i386    move_mount        sys_move_mount            __ia32_sys_move=
_mount
> 389    i386    fsopen            sys_fsopen            __ia32_sys_fsopen
> 390    i386    fsconfig        sys_fsconfig            __ia32_sys_fsconfig=

> +391    i386    fsmount            sys_fsmount            __ia32_sys_fsmou=
nt
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysca=
lls/syscall_64.tbl
> index 4185d36e03bb..d44ead5d4368 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -347,6 +347,7 @@
> 336    common    move_mount        __x64_sys_move_mount
> 337    common    fsopen            __x64_sys_fsopen
> 338    common    fsconfig        __x64_sys_fsconfig
> +339    common    fsmount            __x64_sys_fsmount
>=20
> #
> # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ea07066a2731..b1661b90256d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2503,7 +2503,7 @@ static int do_move_mount(struct path *old_path, stru=
ct path *new_path)
>=20
>    attached =3D mnt_has_parent(old);
>    /*
> -     * We need to allow open_tree(OPEN_TREE_CLONE) followed by
> +     * We need to allow open_tree(OPEN_TREE_CLONE) or fsmount() followed b=
y
>     * move_mount(), but mustn't allow "/" to be moved.
>     */
>    if (old->mnt_ns && !attached)
> @@ -3348,9 +3348,141 @@ struct vfsmount *kern_mount(struct file_system_typ=
e *type)
> EXPORT_SYMBOL_GPL(kern_mount);
>=20
> /*
> - * Move a mount from one place to another.
> - * In combination with open_tree(OPEN_TREE_CLONE [| AT_RECURSIVE]) it can=
 be
> - * used to copy a mount subtree.
> + * Create a kernel mount representation for a new, prepared superblock
> + * (specified by fs_fd) and attach to an open_tree-like file descriptor.
> + */
> +SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags, unsigned int, m=
s_flags)
> +{
> +    struct fs_context *fc;
> +    struct file *file;
> +    struct path newmount;
> +    struct fd f;
> +    unsigned int mnt_flags =3D 0;
> +    long ret;
> +
> +    if (!may_mount())
> +        return -EPERM;
> +
> +    if ((flags & ~(FSMOUNT_CLOEXEC)) !=3D 0)
> +        return -EINVAL;
> +
> +    if (ms_flags & ~(MS_RDONLY | MS_NOSUID | MS_NODEV | MS_NOEXEC |
> +             MS_NOATIME | MS_NODIRATIME | MS_RELATIME |
> +             MS_STRICTATIME))
> +        return -EINVAL;
> +
> +    if (ms_flags & MS_RDONLY)
> +        mnt_flags |=3D MNT_READONLY;
> +    if (ms_flags & MS_NOSUID)
> +        mnt_flags |=3D MNT_NOSUID;
> +    if (ms_flags & MS_NODEV)
> +        mnt_flags |=3D MNT_NODEV;
> +    if (ms_flags & MS_NOEXEC)
> +        mnt_flags |=3D MNT_NOEXEC;
> +    if (ms_flags & MS_NODIRATIME)
> +        mnt_flags |=3D MNT_NODIRATIME;
> +
> +    if (ms_flags & MS_STRICTATIME) {
> +        if (ms_flags & MS_NOATIME)
> +            return -EINVAL;
> +    } else if (ms_flags & MS_NOATIME) {
> +        mnt_flags |=3D MNT_NOATIME;
> +    } else {
> +        mnt_flags |=3D MNT_RELATIME;
> +    }
> +
> +    f =3D fdget(fs_fd);
> +    if (!f.file)
> +        return -EBADF;
> +
> +    ret =3D -EINVAL;
> +    if (f.file->f_op !=3D &fscontext_fops)
> +        goto err_fsfd;
> +
> +    fc =3D f.file->private_data;
> +
> +    /* There must be a valid superblock or we can't mount it */
> +    ret =3D -EINVAL;
> +    if (!fc->root)
> +        goto err_fsfd;
> +
> +    ret =3D -EPERM;
> +    if (mount_too_revealing(fc->root->d_sb, &mnt_flags)) {
> +        pr_warn("VFS: Mount too revealing\n");
> +        goto err_fsfd;
> +    }
> +
> +    ret =3D mutex_lock_interruptible(&fc->uapi_mutex);
> +    if (ret < 0)
> +        goto err_fsfd;
> +
> +    ret =3D -EBUSY;
> +    if (fc->phase !=3D FS_CONTEXT_AWAITING_MOUNT)
> +        goto err_unlock;
> +
> +    ret =3D -EPERM;
> +    if ((fc->sb_flags & SB_MANDLOCK) && !may_mandlock())
> +        goto err_unlock;
> +
> +    newmount.mnt =3D vfs_create_mount(fc, mnt_flags);
> +    if (IS_ERR(newmount.mnt)) {
> +        ret =3D PTR_ERR(newmount.mnt);
> +        goto err_unlock;
> +    }
> +    newmount.dentry =3D dget(fc->root);
> +
> +    /* We've done the mount bit - now move the file context into more or
> +     * less the same state as if we'd done an fspick().  We don't want to=

> +     * do any memory allocation or anything like that at this point as we=

> +     * don't want to have to handle any errors incurred.
> +     */
> +    if (fc->ops && fc->ops->free)
> +        fc->ops->free(fc);
> +    fc->fs_private =3D NULL;
> +    fc->s_fs_info =3D NULL;
> +    fc->sb_flags =3D 0;
> +    fc->sloppy =3D false;
> +    fc->silent =3D false;
> +    security_fs_context_free(fc);
> +    fc->security =3D NULL;
> +    kfree(fc->subtype);
> +    fc->subtype =3D NULL;
> +    kfree(fc->source);
> +    fc->source =3D NULL;
> +
> +    fc->purpose =3D FS_CONTEXT_FOR_RECONFIGURE;
> +    fc->phase =3D FS_CONTEXT_AWAITING_RECONF;
> +
> +    /* Attach to an apparent O_PATH fd with a note that we need to unmoun=
t
> +     * it, not just simply put it.
> +     */
> +    file =3D dentry_open(&newmount, O_PATH, fc->cred);
> +    if (IS_ERR(file)) {
> +        ret =3D PTR_ERR(file);
> +        goto err_path;
> +    }
> +    file->f_mode |=3D FMODE_NEED_UNMOUNT;
> +
> +    ret =3D get_unused_fd_flags((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0=
);
> +    if (ret >=3D 0)
> +        fd_install(ret, file);
> +    else
> +        fput(file);
> +
> +err_path:
> +    path_put(&newmount);
> +err_unlock:
> +    mutex_unlock(&fc->uapi_mutex);
> +err_fsfd:
> +    fdput(f);
> +    return ret;
> +}
> +
> +/*
> + * Move a mount from one place to another.  In combination with
> + * fsopen()/fsmount() this is used to install a new mount and in combinat=
ion
> + * with open_tree(OPEN_TREE_CLONE [| AT_RECURSIVE]) it can be used to cop=
y
> + * a mount subtree.
>  *
>  * Note the flags value is a combination of MOVE_MOUNT_* flags.
>  */
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 9628d14a7ede..65db661cc2da 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -907,6 +907,7 @@ asmlinkage long sys_move_mount(int from_dfd, const cha=
r __user *from_path,
> asmlinkage long sys_fsopen(const char __user *fs_name, unsigned int flags)=
;
> asmlinkage long sys_fsconfig(int fs_fd, unsigned int cmd, const char __use=
r *key,
>                 const void __user *value, int aux);
> +asmlinkage long sys_fsmount(int fs_fd, unsigned int flags, unsigned int m=
s_flags);
>=20
> /*
>  * Architecture-specific system calls
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 7c9e165e8689..297362908d01 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -349,6 +349,8 @@ typedef int __bitwise __kernel_rwf_t;
>  */
> #define FSOPEN_CLOEXEC        0x00000001
>=20
> +#define FSMOUNT_CLOEXEC        0x00000001
> +
> /*
>  * The type of fsconfig() call made.
>  */
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-api" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
