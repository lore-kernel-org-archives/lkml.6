Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E710CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3DA20846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3DA20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbeGKOMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:12:10 -0400
Received: from uhil19pa09.eemsg.mail.mil ([214.24.21.82]:24973 "EHLO
        uhil19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeGKOMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:12:09 -0400
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa09.eemsg.mail.mil with ESMTP/TLS/AES256-SHA; 11 Jul 2018 14:07:34 +0000
X-IronPort-AV: E=Sophos;i="5.51,338,1526342400"; 
   d="scan'208";a="13667426"
IronPort-PHdr: =?us-ascii?q?9a23=3A2SvjIReGcRwzCJqaTfFTYDGklGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc24YRGN2/xhgRfzUJnB7Loc0qyK6/6mATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbJ/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMfhEo4X4oVYFsBmwChS2BO731zFGmHH206053e?=
 =?us-ascii?q?ovHw7J0w4vEM4BvnnPsNX4Nr0fXfypwKTGzzjOae5d1zfn6IjPdxAsueyCXa?=
 =?us-ascii?q?5ufsrJyUkgCQXFhUiNp4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIUEylarVLJ4h2aA/mY?=
 =?us-ascii?q?YJvUTfHi75hEX2jKiMekUi5ueo8Pjobq/jpp+dM494kgD+MqIwlcyjGek0Lw?=
 =?us-ascii?q?cDUmeB9em8ybHv51P1TbpUgvEsj6XVqJXaKt4apq69DQ9VyIEj6xOnAje9zd?=
 =?us-ascii?q?sYhmIKLE5FeR2bj4jpPEvCIPbjDfilmVisnzBrx+7eMr37HprNNmTDkKvmfb?=
 =?us-ascii?q?tl9kFcyA0zzN5B6JJQDrEBO+n+WlXvu9PFDh82KRC0z/z7B9V604MUQXiPDb?=
 =?us-ascii?q?OBMKPOrV+I4foiI/eNZI8PvzbwMPkk6ODojX84h18RZ62p3ZoRaHClEfVqOU?=
 =?us-ascii?q?KZYWDjgtsbDGcKvRI0TPb2h12aTT5Te3GyUrok5j4hFYKmCZzORpi3j7yc2C?=
 =?us-ascii?q?e3B5hWZmdBClCWD3jkbZmLW/AJaCiKOM9ujiQEVaS9S48mzRyusA76y7x6Lu?=
 =?us-ascii?q?vb4yEYtozs1MJz5+LNkRE/7iJ0D8uD3GGXVW10nX0HRyUw3K9hpUxx0FCD0b?=
 =?us-ascii?q?J3g/ZAD9xc++tJUhsmNZ7b1+F6D9HyWgTcftaGUVqmWcupDi0sTtIrwt8Of0?=
 =?us-ascii?q?Z8F8ynjhDEwiWqHrsVmKKQCZwq/aLTwWLxK9x+y3nYzqkhiUcpQs9VOW2hnK?=
 =?us-ascii?q?5/+BDZB5TVnEWBi6aqaaMc0TbJ9GeCy2qOoU5ZXBd+UaXeQH8QeFXWosr95k?=
 =?us-ascii?q?7ZUb+uBqooMhFbxc6BNKRKcNvpgktCRPv5P9TeeW2xkX+qBRmU3rOMcJbqe2?=
 =?us-ascii?q?IF0SXBD0gEiR4T8myCNQcjHSesuGbeDD1oFVLybELg6Od+qHSmTk8y0g6FdV?=
 =?us-ascii?q?Fh17uy+h4Tn/CcTOkT3r1X8Bsm/hl9Alexl/LRFNeEoxEpKKlcZsww5FNc/X?=
 =?us-ascii?q?jUuwx0ItqrKKU0whYAch5wl1Hj0RRpTIFBl9U66nQww0xvKvG2ylREIgiE0I?=
 =?us-ascii?q?jwN7ufEWz7+BSieuaCwV3F+MqH8acIrvIjohPsux//RRlqyGluz9QAiyjU3Z?=
 =?us-ascii?q?7NFgdHFMurCks=3D?=
X-IPAS-Result: =?us-ascii?q?A2DYAADZDUZb/wHyM5BcGwEBAQEDAQEBCQEBAYMfgXoSK?=
 =?us-ascii?q?IN6iARfjCQBAQEBAQEGgQgIJJUyFIFmhHcCgl40GAECAQEBAQEBAgFsKII1J?=
 =?us-ascii?q?AGCXAEBAQECASMEUhALDgoCAiYCAlcGAQwGAgEBglEMP4FzBQipfXszhFuFK?=
 =?us-ascii?q?oELiQKBB4EQJwyCMC6EY4MZglUCh1yEej1ui1YJjyEGjWGTUziBUisIAhgII?=
 =?us-ascii?q?Q+DJIIlF44zIzAMixArghsBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 11 Jul 2018 14:07:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6BE7VmV032302;
        Wed, 11 Jul 2018 10:07:32 -0400
Subject: Re: [PATCH 07/32] selinux: Implement the new mount API LSM hooks [ver
 #9]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126253554.14533.643647579195359736.stgit@warthog.procyon.org.uk>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <078bdc66-3726-72ae-cc1e-85290bb7a16a@tycho.nsa.gov>
Date:   Wed, 11 Jul 2018 10:08:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <153126253554.14533.643647579195359736.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 06:42 PM, David Howells wrote:
> Implement the new mount API LSM hooks for SELinux.  At some point the old
> hooks will need to be removed.
> 
> Question: Should the ->fs_context_parse_source() hook be implemented to
> check the labels on any source devices specified?

The hook interface doesn't appear to lend itself to such validation, since you are just passing a string, not an inode.
Looking up the inode within the security module could easily yield a different object than what is ultimately used for the actual mount.

> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paul Moore <paul@paul-moore.com>
> cc: Stephen Smalley <sds@tycho.nsa.gov>
> cc: selinux@tycho.nsa.gov
> cc: linux-security-module@vger.kernel.org
> ---
> 
>  security/selinux/hooks.c |  264 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 264 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5bb53edd74cc..bdecae4b7306 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -48,6 +48,7 @@
>  #include <linux/fdtable.h>
>  #include <linux/namei.h>
>  #include <linux/mount.h>
> +#include <linux/fs_context.h>
>  #include <linux/netfilter_ipv4.h>
>  #include <linux/netfilter_ipv6.h>
>  #include <linux/tty.h>
> @@ -2973,6 +2974,261 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
>  				   FILESYSTEM__UNMOUNT, NULL);
>  }
>  
> +/* fsopen mount context operations */
> +
> +static int selinux_fs_context_alloc(struct fs_context *fc,
> +				    struct dentry *reference)
> +{
> +	struct security_mnt_opts *opts;
> +
> +	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
> +	if (!opts)
> +		return -ENOMEM;
> +
> +	fc->security = opts;
> +	return 0;
> +}
> +
> +static int selinux_fs_context_dup(struct fs_context *fc,
> +				  struct fs_context *src_fc)
> +{
> +	const struct security_mnt_opts *src = src_fc->security;
> +	struct security_mnt_opts *opts;
> +	int i, n;
> +
> +	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
> +	if (!opts)
> +		return -ENOMEM;
> +	fc->security = opts;
> +
> +	if (!src || !src->num_mnt_opts)
> +		return 0;
> +	n = opts->num_mnt_opts = src->num_mnt_opts;
> +
> +	if (src->mnt_opts) {
> +		opts->mnt_opts = kcalloc(n, sizeof(char *), GFP_KERNEL);
> +		if (!opts->mnt_opts)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < n; i++) {
> +			if (src->mnt_opts[i]) {
> +				opts->mnt_opts[i] = kstrdup(src->mnt_opts[i],
> +							    GFP_KERNEL);
> +				if (!opts->mnt_opts[i])
> +					return -ENOMEM;
> +			}
> +		}
> +	}
> +
> +	if (src->mnt_opts_flags) {
> +		opts->mnt_opts_flags = kmemdup(src->mnt_opts_flags,
> +					       n * sizeof(int), GFP_KERNEL);
> +		if (!opts->mnt_opts_flags)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void selinux_fs_context_free(struct fs_context *fc)
> +{
> +	struct security_mnt_opts *opts = fc->security;
> +
> +	if (opts) {
> +		security_free_mnt_opts(opts);
> +		fc->security = NULL;
> +	}
> +}
> +
> +static int selinux_fs_context_parse_option(struct fs_context *fc, char *opt, size_t len)
> +{
> +	struct security_mnt_opts *opts = fc->security;
> +	substring_t args[MAX_OPT_ARGS];
> +	unsigned int have;
> +	char *c, **oo;
> +	int token, ctx, i, *of;
> +
> +	token = match_token(opt, tokens, args);
> +	if (token == Opt_error)
> +		return 0; /* Doesn't belong to us. */
> +
> +	have = 0;
> +	for (i = 0; i < opts->num_mnt_opts; i++)
> +		have |= 1 << opts->mnt_opts_flags[i];
> +	if (have & (1 << token))
> +		return -EINVAL;
> +
> +	switch (token) {
> +	case Opt_context:
> +		if (have & (1 << Opt_defcontext))
> +			goto incompatible;
> +		ctx = CONTEXT_MNT;
> +		goto copy_context_string;
> +
> +	case Opt_fscontext:
> +		ctx = FSCONTEXT_MNT;
> +		goto copy_context_string;
> +
> +	case Opt_rootcontext:
> +		ctx = ROOTCONTEXT_MNT;
> +		goto copy_context_string;
> +
> +	case Opt_defcontext:
> +		if (have & (1 << Opt_context))
> +			goto incompatible;
> +		ctx = DEFCONTEXT_MNT;
> +		goto copy_context_string;
> +
> +	case Opt_labelsupport:
> +		return 1;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +copy_context_string:
> +	if (opts->num_mnt_opts > 3)
> +		return -EINVAL;
> +
> +	of = krealloc(opts->mnt_opts_flags,
> +		      (opts->num_mnt_opts + 1) * sizeof(int), GFP_KERNEL);
> +	if (!of)
> +		return -ENOMEM;
> +	of[opts->num_mnt_opts] = 0;
> +	opts->mnt_opts_flags = of;
> +
> +	oo = krealloc(opts->mnt_opts,
> +		      (opts->num_mnt_opts + 1) * sizeof(char *), GFP_KERNEL);
> +	if (!oo)
> +		return -ENOMEM;
> +	oo[opts->num_mnt_opts] = NULL;
> +	opts->mnt_opts = oo;
> +
> +	c = match_strdup(&args[0]);
> +	if (!c)
> +		return -ENOMEM;
> +	opts->mnt_opts[opts->num_mnt_opts] = c;
> +	opts->mnt_opts_flags[opts->num_mnt_opts] = ctx;
> +	opts->num_mnt_opts++;
> +	return 1;
> +
> +incompatible:
> +	return -EINVAL;
> +}
> +
> +/*
> + * Validate the security parameters supplied for a reconfiguration/remount
> + * event.
> + */
> +static int selinux_validate_for_sb_reconfigure(struct fs_context *fc)
> +{
> +	struct super_block *sb = fc->root->d_sb;
> +	struct superblock_security_struct *sbsec = sb->s_security;
> +	struct security_mnt_opts *opts = fc->security;
> +	int rc, i, *flags;
> +	char **mount_options;
> +
> +	if (!(sbsec->flags & SE_SBINITIALIZED))
> +		return 0;
> +
> +	mount_options = opts->mnt_opts;
> +	flags = opts->mnt_opts_flags;
> +
> +	for (i = 0; i < opts->num_mnt_opts; i++) {
> +		u32 sid;
> +
> +		if (flags[i] == SBLABEL_MNT)
> +			continue;
> +
> +		rc = security_context_str_to_sid(&selinux_state, mount_options[i],
> +						 &sid, GFP_KERNEL);
> +		if (rc) {
> +			pr_warn("SELinux: security_context_str_to_sid"
> +				"(%s) failed for (dev %s, type %s) errno=%d\n",
> +				mount_options[i], sb->s_id, sb->s_type->name, rc);
> +			goto inval;
> +		}
> +
> +		switch (flags[i]) {
> +		case FSCONTEXT_MNT:
> +			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
> +				goto bad_option;
> +			break;
> +		case CONTEXT_MNT:
> +			if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
> +				goto bad_option;
> +			break;
> +		case ROOTCONTEXT_MNT: {
> +			struct inode_security_struct *root_isec;
> +			root_isec = backing_inode_security(sb->s_root);
> +
> +			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
> +				goto bad_option;
> +			break;
> +		}
> +		case DEFCONTEXT_MNT:
> +			if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
> +				goto bad_option;
> +			break;
> +		default:
> +			goto inval;
> +		}
> +	}
> +
> +	rc = 0;
> +out:
> +	return rc;
> +
> +bad_option:
> +	pr_warn("SELinux: unable to change security options "
> +		"during remount (dev %s, type=%s)\n",
> +		sb->s_id, sb->s_type->name);
> +inval:
> +	rc = -EINVAL;
> +	goto out;
> +}
> +
> +/*
> + * Validate the security context assembled from the option data supplied to
> + * mount.
> + */
> +static int selinux_fs_context_validate(struct fs_context *fc)
> +{
> +	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
> +		return selinux_validate_for_sb_reconfigure(fc);
> +	return 0;
> +}
> +
> +/*
> + * Set the security context on a superblock.
> + */
> +static int selinux_sb_get_tree(struct fs_context *fc)
> +{
> +	const struct cred *cred = current_cred();
> +	struct common_audit_data ad;
> +	int rc;
> +
> +	rc = selinux_set_mnt_opts(fc->root->d_sb, fc->security, 0, NULL);
> +	if (rc)
> +		return rc;
> +
> +	/* Allow all mounts performed by the kernel */
> +	if (fc->purpose == FS_CONTEXT_FOR_KERNEL_MOUNT)
> +		return 0;
> +
> +	ad.type = LSM_AUDIT_DATA_DENTRY;
> +	ad.u.dentry = fc->root;
> +	return superblock_has_perm(cred, fc->root->d_sb, FILESYSTEM__MOUNT, &ad);
> +}
> +
> +static int selinux_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
> +				 unsigned int mnt_flags)
> +{
> +	const struct cred *cred = current_cred();
> +
> +	return path_has_perm(cred, mountpoint, FILE__MOUNTON);
> +}
> +
>  /* inode security operations */
>  
>  static int selinux_inode_alloc_security(struct inode *inode)
> @@ -6905,6 +7161,14 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
>  	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
>  
> +	LSM_HOOK_INIT(fs_context_alloc, selinux_fs_context_alloc),
> +	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
> +	LSM_HOOK_INIT(fs_context_free, selinux_fs_context_free),
> +	LSM_HOOK_INIT(fs_context_parse_option, selinux_fs_context_parse_option),
> +	LSM_HOOK_INIT(fs_context_validate, selinux_fs_context_validate),
> +	LSM_HOOK_INIT(sb_get_tree, selinux_sb_get_tree),
> +	LSM_HOOK_INIT(sb_mountpoint, selinux_sb_mountpoint),
> +
>  	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
>  	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
>  	LSM_HOOK_INIT(sb_copy_data, selinux_sb_copy_data),
> 

