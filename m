Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F069EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB42218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAp2Dsb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfBAUmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:42:13 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38918 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfBAUmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:42:12 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so6519538edt.6;
        Fri, 01 Feb 2019 12:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5tjf7IKRp80+WhluVbTXbP6j3s3eavgeiaCoVoGtmp8=;
        b=dAp2Dsb4sfgdi00FIuXKbIJeVvBjM1b/ECNhyLftxyOKVJ/bRkSLEUMG/NWAV6uKVi
         ZSrW5dKfS2AbzCVAlk/SLWiiTwUXnH4wvrb6pX4cp4p9xFwIzrwIgJcE+4ZDfoyyz7/G
         OXT3W2S7Jz3v5A+A4HoCbvJ2HfClvPU+HbO5v//tgX3mf7NbbzYwxjCLnD4LlCPqXBwl
         NIkt2OBk4ilwzZV6xIP/Zkz+9gtRGIygTzRNeSmf/lUlCjOyD/5QRSvP9y0ryubGqwgE
         NhCpgbierpzD91iUPuObgNpNWNBhoEsyZveD3pGQYKxJIjvYZ3eYkMzUruJzlzZkkZE/
         +a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5tjf7IKRp80+WhluVbTXbP6j3s3eavgeiaCoVoGtmp8=;
        b=oWzaX/cveA8c0VtJFwAW+v1g/N6S/hTk3qWUtmX1dNPsS8l+0Vmr4v06ST1J0TMNSh
         6NfsvmKEvpCkrBFiVvj06yVZgy51Kt/ufOL8xzd6mi+gMwzggvWy9GdI9IwFasYzJLP0
         zDNaJ1djUoun21tNK0QZkkRo2JRavvS2qpj3l6pN5a+669uwX2szzyYy8KNLBeNu1Z8k
         22WqjL+WAwsJe0rXdpJMtMFeKRy8+f2gaJqunlqCSh5Mn7hyP/r1w6GyAZY2yZSzgHVx
         ATHqV/rUZWjKJn8VC2I14FWo9FiPnIAhU7n8gGOfcZCnphZqkaC4XI0Q3j9VfNaZLPxX
         4yTg==
X-Gm-Message-State: AHQUAubO3Rl0nLNK2v+7H2rfe8o/x4R+YEjTeuyJvpxd8uIx4d+ZdHHl
        Fm9w3p2Hgft6RZe64C8+0Wc=
X-Google-Smtp-Source: AHgI3IY92uFDjcrkNZxhroYOEc7rNdp1QKsSw9RIK1jYryEYEeFjLntF94kZsotZOsLFdVgUwCL/iw==
X-Received: by 2002:a17:906:9493:: with SMTP id t19mr1046894ejx.63.1549053729008;
        Fri, 01 Feb 2019 12:42:09 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id cf6sm1380974ejb.45.2019.02.01.12.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 12:42:07 -0800 (PST)
Date:   Fri, 1 Feb 2019 13:42:05 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH ghak100 V2 2/2] audit: ignore fcaps on umount
Message-ID: <20190201204205.GA26179@archlinux-ryzen>
References: <cover.1548196083.git.rgb@redhat.com>
 <397a8b086e6aa9eb797f1538901e95462822ecb0.1548196083.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <397a8b086e6aa9eb797f1538901e95462822ecb0.1548196083.git.rgb@redhat.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 01:35:00PM -0500, Richard Guy Briggs wrote:
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
>  	if (unlikely(error == -ESTALE))
>  		error = path_mountpoint(&nd, flags | LOOKUP_REVAL, path);
>  	if (likely(!error))
> -		audit_inode(name, path->dentry, 0);
> +		audit_inode(name, path->dentry, flags & LOOKUP_NO_EVAL);
>  	restore_nameidata();
>  	putname(name);
>  	return error;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a677b59efd74..e5de0e372df2 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1640,6 +1640,8 @@ int ksys_umount(char __user *name, int flags)
>  	if (!(flags & UMOUNT_NOFOLLOW))
>  		lookup_flags |= LOOKUP_FOLLOW;
>  
> +	lookup_flags |= LOOKUP_NO_EVAL;
> +
>  	retval = user_path_mountpoint_at(AT_FDCWD, name, lookup_flags, &path);
>  	if (retval)
>  		goto out;
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
>  #define AUDIT_INODE_PARENT	1	/* dentry represents the parent */
>  #define AUDIT_INODE_HIDDEN	2	/* audit record should be hidden */
> +#define AUDIT_INODE_NOEVAL	4	/* audit record incomplete */
>  extern void __audit_inode(struct filename *name, const struct dentry *dentry,
>  				unsigned int flags);
>  extern void __audit_file(const struct file *);
> @@ -285,12 +287,15 @@ static inline void audit_getname(struct filename *name)
>  }
>  static inline void audit_inode(struct filename *name,
>  				const struct dentry *dentry,
> -				unsigned int parent) {
> +				unsigned int flags) {
>  	if (unlikely(!audit_dummy_context())) {
> -		unsigned int flags = 0;
> -		if (parent)
> -			flags |= AUDIT_INODE_PARENT;
> -		__audit_inode(name, dentry, flags);
> +		unsigned int aflags = 0;
> +
> +		if (flags & LOOKUP_PARENT)
> +			aflags |= AUDIT_INODE_PARENT;
> +		if (flags & LOOKUP_NO_EVAL)
> +			aflags |= AUDIT_INODE_NOEVAL;
> +		__audit_inode(name, dentry, aflags);
>  	}
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
>  #define LOOKUP_FOLLOW		0x0001
>  #define LOOKUP_DIRECTORY	0x0002
> @@ -33,6 +35,7 @@
>  #define LOOKUP_REVAL		0x0020
>  #define LOOKUP_RCU		0x0040
>  #define LOOKUP_NO_REVAL		0x0080
> +#define LOOKUP_NO_EVAL		0x0100
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
> +	if (name->fcap_ver == -1) {
> +		audit_log_format(ab, " cap_fe=? cap_fver=? cap_fp=? cap_fi=?");
> +		return;
> +	}
>  	audit_log_cap(ab, "cap_fp", &name->fcap.permitted);
>  	audit_log_cap(ab, "cap_fi", &name->fcap.inheritable);
>  	audit_log_format(ab, " cap_fe=%d cap_fver=%x",
> @@ -2111,7 +2115,7 @@ static inline int audit_copy_fcaps(struct audit_names *name,
>  
>  /* Copy inode data into an audit_names. */
>  void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
> -		      struct inode *inode)
> +		      struct inode *inode, unsigned int flags)
>  {
>  	name->ino   = inode->i_ino;
>  	name->dev   = inode->i_sb->s_dev;
> @@ -2120,6 +2124,10 @@ void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
>  	name->gid   = inode->i_gid;
>  	name->rdev  = inode->i_rdev;
>  	security_inode_getsecid(inode, &name->osid);
> +	if (flags & AUDIT_INODE_NOEVAL) {

I don't know if this has been reported or if I am missing something but
on next-20190201, this line causes an error with arm allyesconfig (as
CONFIG_AUDITSYCALL doesn't get selected):

$ make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- allyesconfig kernel/audit.o
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/expr.o
  YACC    scripts/kconfig/parser.tab.h
  YACC    scripts/kconfig/parser.tab.c
  LEX     scripts/kconfig/lexer.lex.c
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --allyesconfig Kconfig
#
# configuration written to .config
#
  SYSHDR  arch/arm/include/generated/uapi/asm/unistd-common.h
  SYSHDR  arch/arm/include/generated/uapi/asm/unistd-oabi.h
  SYSHDR  arch/arm/include/generated/uapi/asm/unistd-eabi.h
  WRAP    arch/arm/include/generated/uapi/asm/bitsperlong.h
  WRAP    arch/arm/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/arm/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/arm/include/generated/uapi/asm/errno.h
  WRAP    arch/arm/include/generated/uapi/asm/msgbuf.h
  WRAP    arch/arm/include/generated/uapi/asm/ioctl.h
  WRAP    arch/arm/include/generated/uapi/asm/sembuf.h
  WRAP    arch/arm/include/generated/uapi/asm/shmbuf.h
  WRAP    arch/arm/include/generated/uapi/asm/param.h
  WRAP    arch/arm/include/generated/uapi/asm/poll.h
  WRAP    arch/arm/include/generated/uapi/asm/resource.h
  WRAP    arch/arm/include/generated/uapi/asm/siginfo.h
  WRAP    arch/arm/include/generated/uapi/asm/termbits.h
  WRAP    arch/arm/include/generated/uapi/asm/socket.h
  WRAP    arch/arm/include/generated/uapi/asm/sockios.h
  WRAP    arch/arm/include/generated/uapi/asm/termios.h
  UPD     include/generated/uapi/linux/version.h
  WRAP    arch/arm/include/generated/asm/current.h
  WRAP    arch/arm/include/generated/asm/compat.h
  WRAP    arch/arm/include/generated/asm/emergency-restart.h
  WRAP    arch/arm/include/generated/asm/early_ioremap.h
  WRAP    arch/arm/include/generated/asm/exec.h
  WRAP    arch/arm/include/generated/asm/irq_regs.h
  WRAP    arch/arm/include/generated/asm/extable.h
  WRAP    arch/arm/include/generated/asm/kdebug.h
  WRAP    arch/arm/include/generated/asm/local64.h
  WRAP    arch/arm/include/generated/asm/msi.h
  WRAP    arch/arm/include/generated/asm/parport.h
  WRAP    arch/arm/include/generated/asm/local.h
  WRAP    arch/arm/include/generated/asm/segment.h
  WRAP    arch/arm/include/generated/asm/mm-arch-hooks.h
  WRAP    arch/arm/include/generated/asm/preempt.h
  WRAP    arch/arm/include/generated/asm/simd.h
  WRAP    arch/arm/include/generated/asm/rwsem.h
  WRAP    arch/arm/include/generated/asm/seccomp.h
  WRAP    arch/arm/include/generated/asm/serial.h
  WRAP    arch/arm/include/generated/asm/timex.h
  WRAP    arch/arm/include/generated/asm/trace_clock.h
  WRAP    arch/arm/include/generated/asm/sizes.h
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/util.o
  HOSTCC  scripts/dtc/checks.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.h
  YACC    scripts/dtc/dtc-parser.tab.c
  HOSTCC  scripts/dtc/yamltree.o
  UPD     include/config/kernel.release
  UPD     include/generated/utsrelease.h
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  HOSTLD  scripts/dtc/dtc
  HOSTCC  scripts/bin2c
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/recordmcount
  HOSTCC  scripts/sortextable
  HOSTCC  scripts/sign-file
  HOSTCC  scripts/asn1_compiler
  HOSTCC  scripts/extract-cert
  HOSTCC  scripts/insert-sys-cert
  HOSTCC  scripts/genksyms/genksyms.o
  YACC    scripts/genksyms/parse.tab.c
  YACC    scripts/genksyms/parse.tab.h
  LEX     scripts/genksyms/lex.lex.c
  HOSTCXX -fPIC scripts/gcc-plugins/latent_entropy_plugin.o
  HOSTCXX -fPIC scripts/gcc-plugins/structleak_plugin.o
  GENSEED scripts/gcc-plugins/randomize_layout_seed.h
  HOSTCC  scripts/selinux/genheaders/genheaders
  HOSTCXX -fPIC scripts/gcc-plugins/arm_ssp_per_task_plugin.o
  HOSTCC  scripts/selinux/mdp/mdp
  HOSTCC  scripts/genksyms/parse.tab.o
  HOSTCC  scripts/genksyms/lex.lex.o
  HOSTLD  scripts/genksyms/genksyms
  HOSTCXX -fPIC scripts/gcc-plugins/randomize_layout_plugin.o
  HOSTLLD -shared scripts/gcc-plugins/structleak_plugin.so
  HOSTLLD -shared scripts/gcc-plugins/latent_entropy_plugin.so
  HOSTLLD -shared scripts/gcc-plugins/arm_ssp_per_task_plugin.so
  HOSTLLD -shared scripts/gcc-plugins/randomize_layout_plugin.so
  GEN     arch/arm/include/generated/asm/mach-types.h
  SYSNR   arch/arm/include/generated/asm/unistd-nr.h
  SYSTBL  arch/arm/include/generated/calls-oabi.S
  SYSTBL  arch/arm/include/generated/calls-eabi.S
  HOSTCC  scripts/mod/mk_elfconfig
  CC      scripts/mod/devicetable-offsets.s
  CC      scripts/mod/empty.o
  UPD     scripts/mod/devicetable-offsets.h
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTCC  scripts/mod/file2alias.o
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  CALL    scripts/atomic/check-atomics.sh
  UPD     include/generated/timeconst.h
  UPD     include/generated/bounds.h
  CC      arch/arm/kernel/asm-offsets.s
  UPD     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
<stdin>:1469:2: warning: #warning syscall pidfd_send_signal not implemented [-Wcpp]
  CC      kernel/audit.o
kernel/audit.c: In function 'audit_copy_inode':
kernel/audit.c:2130:14: error: 'AUDIT_INODE_NOEVAL' undeclared (first use in this function); did you mean 'AUDIT_TYPE_NORMAL'?
  if (flags & AUDIT_INODE_NOEVAL) {
              ^~~~~~~~~~~~~~~~~~
              AUDIT_TYPE_NORMAL
kernel/audit.c:2130:14: note: each undeclared identifier is reported only once for each function it appears in
make[2]: *** [scripts/Makefile.build:277: kernel/audit.o] Error 1
make[1]: *** [Makefile:1699: kernel/audit.o] Error 2
make: *** [Makefile:296: __build_one_by_one] Error 2

> +		name->fcap_ver = -1;
> +		return;
> +	}
>  	audit_copy_fcaps(name, dentry);
>  }
>  
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 6ffb70575082..25ab276be8e5 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -214,7 +214,7 @@ struct audit_context {
>  
>  extern void audit_copy_inode(struct audit_names *name,
>  			     const struct dentry *dentry,
> -			     struct inode *inode);
> +			     struct inode *inode, unsigned int flags);
>  extern void audit_log_cap(struct audit_buffer *ab, char *prefix,
>  			  kernel_cap_t *cap);
>  extern void audit_log_name(struct audit_context *context,
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 3d05d5fc6240..9a1257afc4d4 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1853,7 +1853,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
>  		n->type = AUDIT_TYPE_NORMAL;
>  	}
>  	handle_path(dentry);
> -	audit_copy_inode(n, dentry, inode);
> +	audit_copy_inode(n, dentry, inode, flags & AUDIT_INODE_NOEVAL);
>  }
>  
>  void __audit_file(const struct file *file)
> @@ -1952,7 +1952,7 @@ void __audit_inode_child(struct inode *parent,
>  		n = audit_alloc_name(context, AUDIT_TYPE_PARENT);
>  		if (!n)
>  			return;
> -		audit_copy_inode(n, NULL, parent);
> +		audit_copy_inode(n, NULL, parent, 0);
>  	}
>  
>  	if (!found_child) {
> @@ -1971,7 +1971,7 @@ void __audit_inode_child(struct inode *parent,
>  	}
>  
>  	if (inode)
> -		audit_copy_inode(found_child, dentry, inode);
> +		audit_copy_inode(found_child, dentry, inode, 0);
>  	else
>  		found_child->ino = AUDIT_INO_UNSET;
>  }
> -- 
> 1.8.3.1
> 
