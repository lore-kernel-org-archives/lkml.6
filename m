Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE80EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C2D218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ZMKuCP5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfAYVpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:45:22 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35706 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfAYVpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:45:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so9603280ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 13:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVKXefqp1XO0YcKL7WbWdvaIaPAfg36kkU6v4A//xCU=;
        b=ZMKuCP5l1t9OW+rN1PEHyE1NSESWLPC3amFbFoPa8Jq79q3OXLN3EZrlDP6Lmy7UzC
         7X0yAfeAtOl35Cm3Lplo+Tz+ziQVBHswyMNMp1kLNTn/Zi67HA9zzljkEwBByN+EhKH9
         vG6TKUPlFYNmBe7joL+KQd6Ife7vAOo8ln3sPULMq1W+KztK9wubRpVwGt4J+rfIjh0S
         ft9Lyll5re7XA3hBt6H0PpjyMpmMf+5rtQsSYPmjzVh0s7C7PSt59MPmo5ufdaEjicDY
         JgAljUe+izBBkomYC7CVMnNx3IPFq/X34S85zO5zEzBpfzRz318PTmbPqXAZfMIwzJ/s
         OR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVKXefqp1XO0YcKL7WbWdvaIaPAfg36kkU6v4A//xCU=;
        b=ODd4X1U0rlQcZgua05xzvnZR1Y+Msu6ItRkdEAwYa2INUqQQnEOdo6cgdNxVM5BT2D
         t3sYOycoTGHLRhFSmmI3ikz9fQzPdhQwwNMxVm87+9EXfttgJv7Ph8b4p4r0ufvLtR1D
         0D92cTHGiq4rA+1MJNQtuAmNebKn9CahC5Xph2KoWBIboUKWZzMgZOLAWUf4iNdMdyP7
         gcqaaOY0gBTY0WKTOSjgB8B6CCyks5VBptNNfPSE1bKsBcxGwhdTSMtLqHyMHHX+7NjK
         ETbLLCPFoNJ2i/ELvcBp4Pp1DVAK9TpI2TTIWy0VtO4qXOFYcS8XNddLE6mJpFIF9q6O
         +Z/A==
X-Gm-Message-State: AJcUukfiGrtLELPkTsMJcayoolxuR6rHHueYQ93d7otw2dGw55zsq0Zk
        c/nrHnf2nFVyLBgESgmwFpeuv80aRYxYMzYDPmie
X-Google-Smtp-Source: ALg8bN4iULNr1C/p8nDhaM3gey2CLmItT/uyRxagkVk6R80zgaZKzM5Qe4bxTZKVog0SLdtTDqlJJhYKg3VjHQUNONk=
X-Received: by 2002:a2e:3308:: with SMTP id d8-v6mr10001104ljc.38.1548452719221;
 Fri, 25 Jan 2019 13:45:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548196083.git.rgb@redhat.com> <397a8b086e6aa9eb797f1538901e95462822ecb0.1548196083.git.rgb@redhat.com>
In-Reply-To: <397a8b086e6aa9eb797f1538901e95462822ecb0.1548196083.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Jan 2019 16:45:07 -0500
Message-ID: <CAHC9VhQ14FtJAMxjmrGNu2-AkJe6ELjHnaEHjULLHjwo2FDhkQ@mail.gmail.com>
Subject: Re: [PATCH ghak100 V2 2/2] audit: ignore fcaps on umount
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 1:35 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Don't fetch fcaps when umount2 is called to avoid a process hang while
> it waits for the missing resource to (possibly never) re-appear.
>
> Note the comment above user_path_mountpoint_at():
>  * A umount is a special case for path walking. We're not actually interested
>  * in the inode in this situation, and ESTALE errors can be a problem.  We
>  * simply want track down the dentry and vfsmount attached at the mountpoint
>  * and avoid revalidating the last component.
>
> This can happen on ceph, cifs, 9p, lustre, fuse (gluster) or NFS.
>
> Please see the github issue tracker
> https://github.com/linux-audit/audit-kernel/issues/100
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/namei.c            |  2 +-
>  fs/namespace.c        |  2 ++
>  include/linux/audit.h | 15 ++++++++++-----
>  include/linux/namei.h |  3 +++
>  kernel/audit.c        | 10 +++++++++-
>  kernel/audit.h        |  2 +-
>  kernel/auditsc.c      |  6 +++---
>  7 files changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 914178cdbe94..87d7710a2e1d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2720,7 +2720,7 @@ int user_path_at_empty(int dfd, const char __user *name, unsigned flags,
>         if (unlikely(error == -ESTALE))
>                 error = path_mountpoint(&nd, flags | LOOKUP_REVAL, path);
>         if (likely(!error))
> -               audit_inode(name, path->dentry, 0);
> +               audit_inode(name, path->dentry, flags & LOOKUP_NO_EVAL);
>         restore_nameidata();
>         putname(name);
>         return error;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a677b59efd74..e5de0e372df2 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1640,6 +1640,8 @@ int ksys_umount(char __user *name, int flags)
>         if (!(flags & UMOUNT_NOFOLLOW))
>                 lookup_flags |= LOOKUP_FOLLOW;
>
> +       lookup_flags |= LOOKUP_NO_EVAL;
> +
>         retval = user_path_mountpoint_at(AT_FDCWD, name, lookup_flags, &path);
>         if (retval)
>                 goto out;
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index a625c29a2ea2..5d914b534536 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -25,6 +25,7 @@
>
>  #include <linux/sched.h>
>  #include <linux/ptrace.h>
> +#include <linux/namei.h>  /* LOOKUP_* */
>  #include <uapi/linux/audit.h>
>
>  #define AUDIT_INO_UNSET ((unsigned long)-1)
> @@ -225,6 +226,7 @@ extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
>
>  #define AUDIT_INODE_PARENT     1       /* dentry represents the parent */
>  #define AUDIT_INODE_HIDDEN     2       /* audit record should be hidden */
> +#define AUDIT_INODE_NOEVAL     4       /* audit record incomplete */
>  extern void __audit_inode(struct filename *name, const struct dentry *dentry,
>                                 unsigned int flags);
>  extern void __audit_file(const struct file *);
> @@ -285,12 +287,15 @@ static inline void audit_getname(struct filename *name)
>  }
>  static inline void audit_inode(struct filename *name,
>                                 const struct dentry *dentry,
> -                               unsigned int parent) {
> +                               unsigned int flags) {
>         if (unlikely(!audit_dummy_context())) {
> -               unsigned int flags = 0;
> -               if (parent)
> -                       flags |= AUDIT_INODE_PARENT;
> -               __audit_inode(name, dentry, flags);
> +               unsigned int aflags = 0;
> +
> +               if (flags & LOOKUP_PARENT)
> +                       aflags |= AUDIT_INODE_PARENT;
> +               if (flags & LOOKUP_NO_EVAL)
> +                       aflags |= AUDIT_INODE_NOEVAL;
> +               __audit_inode(name, dentry, aflags);
>         }
>  }
>  static inline void audit_file(struct file *file)
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index a78606e8e3df..9138b4471dbf 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -24,6 +24,8 @@
>   *  - internal "there are more path components" flag
>   *  - dentry cache is untrusted; force a real lookup
>   *  - suppress terminal automount
> + *  - skip revalidation
> + *  - don't fetch xattrs on audit_inode
>   */
>  #define LOOKUP_FOLLOW          0x0001
>  #define LOOKUP_DIRECTORY       0x0002
> @@ -33,6 +35,7 @@
>  #define LOOKUP_REVAL           0x0020
>  #define LOOKUP_RCU             0x0040
>  #define LOOKUP_NO_REVAL                0x0080
> +#define LOOKUP_NO_EVAL         0x0100
>
>  /*
>   * Intent data
> diff --git a/kernel/audit.c b/kernel/audit.c
> index ca55ccb46b76..45d5131943eb 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2081,6 +2081,10 @@ void audit_log_cap(struct audit_buffer *ab, char *prefix, kernel_cap_t *cap)
>
>  static void audit_log_fcaps(struct audit_buffer *ab, struct audit_names *name)
>  {
> +       if (name->fcap_ver == -1) {
> +               audit_log_format(ab, " cap_fe=? cap_fver=? cap_fp=? cap_fi=?");
> +               return;
> +       }
>         audit_log_cap(ab, "cap_fp", &name->fcap.permitted);
>         audit_log_cap(ab, "cap_fi", &name->fcap.inheritable);
>         audit_log_format(ab, " cap_fe=%d cap_fver=%x",
> @@ -2111,7 +2115,7 @@ static inline int audit_copy_fcaps(struct audit_names *name,
>
>  /* Copy inode data into an audit_names. */
>  void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
> -                     struct inode *inode)
> +                     struct inode *inode, unsigned int flags)
>  {
>         name->ino   = inode->i_ino;
>         name->dev   = inode->i_sb->s_dev;
> @@ -2120,6 +2124,10 @@ void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
>         name->gid   = inode->i_gid;
>         name->rdev  = inode->i_rdev;
>         security_inode_getsecid(inode, &name->osid);
> +       if (flags & AUDIT_INODE_NOEVAL) {
> +               name->fcap_ver = -1;
> +               return;
> +       }

I'm not in love with the -1 sentinel, especially without a cast in
front of it (style nit I suppose), but I love the idea of adding
another flag to audit_names even more.  Since it looks like the
version portion of cpu_vfs_cap_data.magic_etc is limited to eight bits
I suppose we could break up fcap_ver and use some of the 32 bits for
our own flags.  Not sure I like that option any more than the others.

I'm also beginning to wonder why we don't just include the fcaps
version info in the audit_cap_data struct; I can't think of a reason
why you would ever want to know one without the other.  Thoughts?

>         audit_copy_fcaps(name, dentry);
>  }
>
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 6ffb70575082..25ab276be8e5 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -214,7 +214,7 @@ struct audit_context {
>
>  extern void audit_copy_inode(struct audit_names *name,
>                              const struct dentry *dentry,
> -                            struct inode *inode);
> +                            struct inode *inode, unsigned int flags);
>  extern void audit_log_cap(struct audit_buffer *ab, char *prefix,
>                           kernel_cap_t *cap);
>  extern void audit_log_name(struct audit_context *context,
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 3d05d5fc6240..9a1257afc4d4 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1853,7 +1853,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
>                 n->type = AUDIT_TYPE_NORMAL;
>         }
>         handle_path(dentry);
> -       audit_copy_inode(n, dentry, inode);
> +       audit_copy_inode(n, dentry, inode, flags & AUDIT_INODE_NOEVAL);
>  }
>
>  void __audit_file(const struct file *file)
> @@ -1952,7 +1952,7 @@ void __audit_inode_child(struct inode *parent,
>                 n = audit_alloc_name(context, AUDIT_TYPE_PARENT);
>                 if (!n)
>                         return;
> -               audit_copy_inode(n, NULL, parent);
> +               audit_copy_inode(n, NULL, parent, 0);
>         }
>
>         if (!found_child) {
> @@ -1971,7 +1971,7 @@ void __audit_inode_child(struct inode *parent,
>         }
>
>         if (inode)
> -               audit_copy_inode(found_child, dentry, inode);
> +               audit_copy_inode(found_child, dentry, inode, 0);
>         else
>                 found_child->ino = AUDIT_INO_UNSET;
>  }
> --
> 1.8.3.1
>


-- 
paul moore
www.paul-moore.com
