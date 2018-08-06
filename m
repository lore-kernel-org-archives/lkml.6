Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DD2C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E097F219A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hu3v8VDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E097F219A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeHFJ6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 05:58:46 -0400
Received: from ozlabs.org ([203.11.71.1]:48519 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725735AbeHFJ6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 05:58:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41kVFT6z80z9s5H;
        Mon,  6 Aug 2018 17:50:53 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533541854;
        bh=8WQ5uxrEzSKUBNlYSF6XD+0hrCPhNz+2lrEvgAO3/vk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hu3v8VDaGsa2Z4DZ8kviyuf27qlF5HcEyEWjuQPrwkD2N5YYzyJsSF+se1uH0GKh7
         ESmcdTZXvHC4iuuNf5fRqPvGi8EEhl/9GxuVJk7iJu+A4Qm5KNBSWbemryNyJxuSGf
         /Ujjr/GDYXQMDtTWCTDAlcvVFp2fHry7E+cRf1kxqgBdLP0GYQRT3lqxhvzj0CHG0z
         FEUVm/VJz/pSlkbn8sRoUYGMkleziz1O0aOOzRm3Q83Ehe7vhIrJEbPY3pSwvljyAw
         3Y/WJUKhBdqYf1UAI9T9lbXEVMXFOZP8FS7Fb19T+JhYIKDKY3EUkaeGtSy15pJ0Ps
         Cq4cOTKfFlJ7g==
Date:   Mon, 6 Aug 2018 17:50:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the userns tree with the vfs tree
Message-ID: <20180806175047.5b612a77@canb.auug.org.au>
In-Reply-To: <20180620123905.348181b2@canb.auug.org.au>
References: <20180620123905.348181b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rofUT+4VBDf2TIihD7HKpP4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rofUT+4VBDf2TIihD7HKpP4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 20 Jun 2018 12:39:05 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the userns tree got a conflict in:
>=20
>   fs/proc/inode.c
>   fs/proc/root.c
>=20
> between commit:
>=20
>   0223e0999be2 ("procfs: Move proc_fill_super() to fs/proc/root.c")
>   83cd45075c36 ("proc: Add fs_context support to procfs")
>=20
> from the vfs tree and commit:
>=20
>   cc8cda3af2ba ("proc: Simplify and fix proc by removing the kernel mount=
")
>   9303f5f81bd4 ("proc: Change proc_parse_options to return an errno value=
")
>   04035aa33a12 ("proc: Don't change mount options on remount failure.")
>=20
> from the userns tree.
>=20
> I effectively reverted 9303f5f81bd4 and 04035aa33a12 since (I think)
> they are subsumed by the vfs tree changes.
>=20
> I fixed it up (I think I got it mostly right this time - see below) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc fs/proc/root.c
> index efbdc08a3c86,3dceff6cd121..91e9b417bc6d
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@@ -80,71 -78,21 +80,74 @@@ static int proc_parse_option(struct fs_
>   	return 0;
>   }
>  =20
>  -int proc_remount(struct super_block *sb, int *flags, char *data)
>  +static void proc_set_options(struct super_block *s,
>  +			     struct fs_context *fc,
>  +			     struct pid_namespace *pid_ns,
>  +			     struct user_namespace *user_ns)
>   {
>  -	struct pid_namespace *pid =3D sb->s_fs_info;
>  -	struct proc_mount_options opts =3D {
>  -		.pid_gid  =3D pid->pid_gid,
>  -		.hide_pid =3D pid->hide_pid,
>  -	};
>  +	struct proc_fs_context *ctx =3D fc->fs_private;
>  +
>  +	if (ctx->mask & (1 << Opt_gid))
>  +		pid_ns->pid_gid =3D make_kgid(user_ns, ctx->gid);
>  +	if (ctx->mask & (1 << Opt_hidepid))
>  +		pid_ns->hide_pid =3D ctx->hidepid;
>  +}
>  +
>  +static int proc_fill_super(struct super_block *s, struct fs_context *fc)
>  +{
>  +	struct pid_namespace *pid_ns =3D get_pid_ns(s->s_fs_info);
>  +	struct inode *root_inode;
>   	int ret;
>  =20
>  -	sync_filesystem(sb);
>  -	ret =3D proc_parse_options(data, &opts);
>  -	if (ret)
>  +	proc_set_options(s, fc, pid_ns, current_user_ns());
>  +
>  +	/* User space would break if executables or devices appear on proc */
>  +	s->s_iflags |=3D SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
>  +	s->s_flags |=3D SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
>  +	s->s_blocksize =3D 1024;
>  +	s->s_blocksize_bits =3D 10;
>  +	s->s_magic =3D PROC_SUPER_MAGIC;
>  +	s->s_op =3D &proc_sops;
>  +	s->s_time_gran =3D 1;
>  +
>  +	/*
>  +	 * procfs isn't actually a stacking filesystem; however, there is
>  +	 * too much magic going on inside it to permit stacking things on
>  +	 * top of it
>  +	 */
>  +	s->s_stack_depth =3D FILESYSTEM_MAX_STACK_DEPTH;
>  +
>  +	pde_get(&proc_root);
>  +	root_inode =3D proc_get_inode(s, &proc_root);
>  +	if (!root_inode) {
>  +		pr_err("proc_fill_super: get root inode failed\n");
>  +		return -ENOMEM;
>  +	}
>  +
>  +	s->s_root =3D d_make_root(root_inode);
>  +	if (!s->s_root) {
>  +		pr_err("proc_fill_super: allocate dentry failed\n");
>  +		return -ENOMEM;
>  +	}
>  +
>  +	ret =3D proc_setup_self(s);
>  +	if (ret) {
>   		return ret;
>  -	pid->pid_gid  =3D opts.pid_gid;
>  -	pid->hide_pid =3D opts.hide_pid;
>  +	}
> - 	return proc_setup_thread_self(s);
> ++	ret =3D proc_setup_thread_self(s);
> ++
> ++	rcu_assign_pointer(pid_ns->proc_super, s);
> ++	return ret;
>  +}
>  +
>  +int proc_reconfigure(struct super_block *sb, struct fs_context *fc)
>  +{
>  +	struct pid_namespace *pid =3D sb->s_fs_info;
>  +
>  +	sync_filesystem(sb);
>  +
>  +	if (fc)
>  +		proc_set_options(sb, fc, pid, current_user_ns());
>   	return 0;
>   }
>  =20
> @@@ -288,44 -208,23 +292,22 @@@ struct proc_dir_entry proc_root =3D=20
>   	.proc_fops	=3D &proc_root_operations,
>   	.parent		=3D &proc_root,
>   	.subdir		=3D RB_ROOT,
>  -	.name		=3D proc_root.inline_name,
>  -	.inline_name	=3D "/proc",
>  +	.name		=3D "/proc",
>   };
>  =20
> - int pid_ns_prepare_proc(struct pid_namespace *ns)
> + #if defined(CONFIG_SYSCTL_SYSCALL) || defined(CONFIG_MCONSOLE)
> + struct file *file_open_proc(const char *pathname, int flags, umode_t mo=
de)
>   {
> - 	struct proc_fs_context *ctx;
> - 	struct fs_context *fc;
>   	struct vfsmount *mnt;
> - 	int ret;
> -=20
> - 	fc =3D vfs_new_fs_context(&proc_fs_type, NULL, 0,
> - 				FS_CONTEXT_FOR_KERNEL_MOUNT);
> - 	if (IS_ERR(fc))
> - 		return PTR_ERR(fc);
> -=20
> - 	ctx =3D fc->fs_private;
> - 	if (ctx->pid_ns !=3D ns) {
> - 		put_pid_ns(ctx->pid_ns);
> - 		get_pid_ns(ns);
> - 		ctx->pid_ns =3D ns;
> - 	}
> + 	struct file *file;
>  =20
> - 	ret =3D vfs_get_tree(fc);
> - 	if (ret < 0) {
> - 		put_fs_context(fc);
> - 		return ret;
> - 	}
> -=20
> - 	mnt =3D vfs_create_mount(fc, 0);
> - 	put_fs_context(fc);
> + 	mnt =3D kern_mount(&proc_fs_type);
>   	if (IS_ERR(mnt))
> - 		return PTR_ERR(mnt);
> + 		return ERR_CAST(mnt);
>  =20
> - 	ns->proc_mnt =3D mnt;
> - 	return 0;
> - }
> + 	file =3D file_open_root(mnt->mnt_root, mnt, pathname, flags, mode);
> + 	kern_unmount(mnt);
>  =20
> - void pid_ns_release_proc(struct pid_namespace *ns)
> - {
> - 	kern_unmount(ns->proc_mnt);
> + 	return file;
>   }
> + #endif

Are there any comments on this resolution.  I just had to do it all
again due to slight changes in the vfs tree.  What are you guys going
to tell Linus when he comes to merge this?

--=20
Cheers,
Stephen Rothwell

--Sig_/rofUT+4VBDf2TIihD7HKpP4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltn/dcACgkQAVBC80lX
0GzUgAf/fN1WKttEXYQXy0Gm9uUrx6q6cftGCGn95K0e3FsicbZnalLVl1pSQu+1
So05el+10rSL9yWOLGI/nBqFpnU5fndugYe8TnwffWs2a6nw12q2F/iAR4+w0LlS
slGHDDEQgxSaqnZ7ixkttxa/Pdm0O+LrthV+hsjKIYLaE5++h2PdipJui7ubpkxe
gyyzzsW3z4X7ZTGHiyZ5vYnVRjd0Z/36ZfN292p3ZSdKPcSGLdFs9YHXa7NogeHo
7k1au/LjaC3DbesoXhWa7d6pi3laY/3fKwrQjUFD5N72NRCgBC2oU2fE84hB520f
gNB470hqdHWDrJB/7t25yXALLHqCtQ==
=8ttQ
-----END PGP SIGNATURE-----

--Sig_/rofUT+4VBDf2TIihD7HKpP4--
