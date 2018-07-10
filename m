Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC44C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45DF20B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AUbbOBeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45DF20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbeGJXPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:15:14 -0400
Received: from sonic308-16.consmr.mail.gq1.yahoo.com ([98.137.68.40]:44975
        "EHLO sonic308-16.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732253AbeGJXPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1531264432; bh=6c58RIx/nuzAzosbC7ygEo7GIgFnRoYnbIimGYkGxI4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=AUbbOBeU7bI14q4u9wVuMqAn1KwL93b008lsxvQakA30D24r9CO7qfLlDw7aQ+M3xTxM/yH0xr0e57HEcAS52vQ4UyeBAoG+GF79EOOMV1x0o4hPbUOlL50pEDooc85p5cl5LFmsPpT3fbn4lI1Kpzc/b8/OI4oiVdElSTFe7NrVmgO6jPK6v1Eg/MiS3yZXdIOEWZZCply4uUtGXbmvHgHe1wlAvZca4xrJwPhn4jtaP5/kU5QGDQ4gaXRL3/VWCTgUcljqcYL37dosJJOfuVbCBsfsclc3qAJC+5razM8MCXhzfuxw5p7/RdhcIGNJhFlmjRozqjR125DzRknxvw==
X-YMail-OSG: el09_esVM1nnoA6Jl2Fm0yGLqwsq9VJLlEeYhQq6e6hQMphIofw_PZzpgIsFnOd
 KX5vfDA_y8ld_h8WdMzDidTwh_VK1PE9E08wQnWrA8RzRF11n7FR1Dii_UcKSB1.hQfRksEUqXbd
 KndKWcxRLneiq.ycNW2eW20_ccmwz7mWxyuRVYONrfcCJapTmv4.y67dPjag7U2NnCJ8imJcI1wa
 xpwMoIAgRzV_weFP1Mr.ZzKlJ4tCvA8bz8YbGgNRqtSnk50_YdfojGhZ2fWT9hbjdLJPXUvbgIUi
 0mEGuNuQKYi.7B6tbJkM12gZh4bx7a7zT8WCxT9zQrZQmPX_4ourbfALEKsQbwIPowzvdYHS_0dG
 S3Nvdx0Kobv3JQL6poc7a8l6LKcdqHi_JdQPJbBP9MF2RemzdUWWgLcWLxsrYlNw5wqQvEFDlm7b
 TWQwzoqaTYIJ8H4GcpIRXGNQJjC28GVJGywcakklcAdREebIHPmmZ8tXMTjYxG1laRHbGe3mrbwU
 X08.oOgSOJroaR3oCtZiDU.trT9C54AMJhdCB87jakLQaPjrsPerIjcd_v_3K3fwXT0.6F44QHzW
 fVY7LjVgjr.u421jh51fs5xp7ZC8IPDvlOxyr9M3de453pq2.CvhiKz2D_qQVm8nCU1SG8WOnZzM
 4zhoRUPEurVvtZtFbzfol3pK0bcFbR2JSo009fuhpIOf7v1w4aR9w8UVljmUrimIjOlkPK3ngRpr
 30GQGGer96K9F5jiv7N9ppWOdu7Bp3yYepvqy1_1e5RL9a2cVyQDqlQZmCjJHapDSxRYddKlqAtH
 ggGqKNmi_0BvKETQ9gBbGPK7JZ4hO1NpqobqhedhQXE7m3QhaRbAO9N8ZqdFPPVBiTHifKGkWXEd
 rCQ6gYw3.w0nqLVcnmi3u0qf2GO_bwGBGpf8XImqE9LybnBAfc5LBAFa_AT9.SLPje3sz1mWogHP
 Qk2CKb_AEJ.dPNUTMUFIffQ6i5ID.IvPQitogjdwOt9zZWwgq8HQNwJiff8QSg9QFXn9NHcXUHYP
 zsDqGyc3RzytIc1z1RkdLQs8LXvFk5ew1JII-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Tue, 10 Jul 2018 23:13:52 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp410.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5ab543fe3b7cbd076c5f6ec66f9d84f2;
          Tue, 10 Jul 2018 23:13:51 +0000 (UTC)
Subject: Re: [PATCH 08/32] smack: Implement filesystem context security hooks
 [ver #9]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126254346.14533.14191961720018099798.stgit@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <dc5039cb-97cf-fe72-d601-f48eb26e8e66@schaufler-ca.com>
Date:   Tue, 10 Jul 2018 16:13:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <153126254346.14533.14191961720018099798.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/2018 3:42 PM, David Howells wrote:
> Implement filesystem context security hooks for the smack LSM.
>
> Question: Should the ->fs_context_parse_source() hook be implemented to
> check the labels on any source devices specified?

Checking the label on a block device when doing a mount
is just going to end in tears. If you're remounting from
an already mounted filesystem it might make sense to check
that the new mount doesn't provide greater access than the
existing mount. If the original mount has smackfsdefault="_"
I could see prohibiting the additional mount having
smackfsdefault="*" on a filesystem that doesn't support
xattrs. But that requires that a (hopefully) privileged
process be involved, and we expect them to have a clue.
So no, I don't see it necessary.

>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-security-module@vger.kernel.org
> ---
>
>  security/smack/smack_lsm.c |  309 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 309 insertions(+)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 7ad226018f51..39780b06469b 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -42,6 +42,7 @@
>  #include <linux/shm.h>
>  #include <linux/binfmts.h>
>  #include <linux/parser.h>
> +#include <linux/fs_context.h>
>  #include "smack.h"
>  
>  #define TRANS_TRUE	"TRUE"
> @@ -521,6 +522,307 @@ static int smack_syslog(int typefrom_file)
>  	return rc;
>  }
>  
> +/*
> + * Mount context operations
> + */
> +
> +struct smack_fs_context {
> +	union {
> +		struct {
> +			char		*fsdefault;
> +			char		*fsfloor;
> +			char		*fshat;
> +			char		*fsroot;
> +			char		*fstransmute;
> +		};
> +		char			*ptrs[5];
> +
> +	};
> +	struct superblock_smack		*sbsp;
> +	struct inode_smack		*isp;
> +	bool				transmute;
> +};
> +
> +/**
> + * smack_fs_context_free - Free the security data from a filesystem context
> + * @fc: The filesystem context to be cleaned up.
> + */
> +static void smack_fs_context_free(struct fs_context *fc)
> +{
> +	struct smack_fs_context *ctx = fc->security;
> +	int i;
> +
> +	if (ctx) {
> +		for (i = 0; i < ARRAY_SIZE(ctx->ptrs); i++)
> +			kfree(ctx->ptrs[i]);
> +		kfree(ctx->isp);
> +		kfree(ctx->sbsp);
> +		kfree(ctx);
> +		fc->security = NULL;
> +	}
> +}
> +
> +/**
> + * smack_fs_context_alloc - Allocate security data for a filesystem context
> + * @fc: The filesystem context.
> + * @reference: Reference dentry (automount/reconfigure) or NULL
> + *
> + * Returns 0 on success or -ENOMEM on error.
> + */
> +static int smack_fs_context_alloc(struct fs_context *fc,
> +				  struct dentry *reference)
> +{
> +	struct smack_fs_context *ctx;
> +	struct superblock_smack *sbsp;
> +	struct inode_smack *isp;
> +	struct smack_known *skp;
> +
> +	ctx = kzalloc(sizeof(struct smack_fs_context), GFP_KERNEL);
> +	if (!ctx)
> +		goto nomem;
> +	fc->security = ctx;
> +
> +	sbsp = kzalloc(sizeof(struct superblock_smack), GFP_KERNEL);
> +	if (!sbsp)
> +		goto nomem_free;
> +	ctx->sbsp = sbsp;
> +
> +	isp = new_inode_smack(NULL);
> +	if (!isp)
> +		goto nomem_free;
> +	ctx->isp = isp;
> +
> +	if (reference) {
> +		if (reference->d_sb->s_security)
> +			memcpy(sbsp, reference->d_sb->s_security, sizeof(*sbsp));
> +	} else if (!smack_privileged(CAP_MAC_ADMIN)) {
> +		/* Unprivileged mounts get root and default from the caller. */
> +		skp = smk_of_current();
> +		sbsp->smk_root = skp;
> +		sbsp->smk_default = skp;
> +	} else {
> +		sbsp->smk_root = &smack_known_floor;
> +		sbsp->smk_default = &smack_known_floor;
> +		sbsp->smk_floor = &smack_known_floor;
> +		sbsp->smk_hat = &smack_known_hat;
> +		/* SMK_SB_INITIALIZED will be zero from kzalloc. */
> +	}
> +
> +	return 0;
> +
> +nomem_free:
> +	smack_fs_context_free(fc);
> +nomem:
> +	return -ENOMEM;
> +}
> +
> +/**
> + * smack_fs_context_dup - Duplicate the security data on fs_context duplication
> + * @fc: The new filesystem context.
> + * @src_fc: The source filesystem context being duplicated.
> + *
> + * Returns 0 on success or -ENOMEM on error.
> + */
> +static int smack_fs_context_dup(struct fs_context *fc,
> +				struct fs_context *src_fc)
> +{
> +	struct smack_fs_context *dst, *src = src_fc->security;
> +	int i;
> +
> +	dst = kzalloc(sizeof(struct smack_fs_context), GFP_KERNEL);
> +	if (!dst)
> +		goto nomem;
> +	fc->security = dst;
> +
> +	dst->sbsp = kmemdup(src->sbsp, sizeof(struct superblock_smack),
> +			    GFP_KERNEL);
> +	if (!dst->sbsp)
> +		goto nomem_free;
> +
> +	for (i = 0; i < ARRAY_SIZE(dst->ptrs); i++) {
> +		if (src->ptrs[i]) {
> +			dst->ptrs[i] = kstrdup(src->ptrs[i], GFP_KERNEL);
> +			if (!dst->ptrs[i])
> +				goto nomem_free;
> +		}
> +	}
> +
> +	return 0;
> +
> +nomem_free:
> +	smack_fs_context_free(fc);
> +nomem:
> +	return -ENOMEM;
> +}
> +
> +/**
> + * smack_fs_context_parse_option - Parse a single mount option
> + * @fc: The new filesystem context being constructed.
> + * @opt: The option text buffer.
> + * @len: The length of the text.
> + *
> + * Returns 0 on success or -ENOMEM on error.
> + */
> +static int smack_fs_context_parse_option(struct fs_context *fc, char *p, size_t len)
> +{
> +	struct smack_fs_context *ctx = fc->security;
> +	substring_t args[MAX_OPT_ARGS];
> +	int rc = -ENOMEM;
> +	int token;
> +
> +	/* Unprivileged mounts don't get to specify Smack values. */
> +	if (!smack_privileged(CAP_MAC_ADMIN))
> +		return -EPERM;
> +
> +	token = match_token(p, smk_mount_tokens, args);
> +	switch (token) {
> +	case Opt_fsdefault:
> +		if (ctx->fsdefault)
> +			goto error_dup;
> +		ctx->fsdefault = match_strdup(&args[0]);
> +		if (!ctx->fsdefault)
> +			goto error;
> +		break;
> +	case Opt_fsfloor:
> +		if (ctx->fsfloor)
> +			goto error_dup;
> +		ctx->fsfloor = match_strdup(&args[0]);
> +		if (!ctx->fsfloor)
> +			goto error;
> +		break;
> +	case Opt_fshat:
> +		if (ctx->fshat)
> +			goto error_dup;
> +		ctx->fshat = match_strdup(&args[0]);
> +		if (!ctx->fshat)
> +			goto error;
> +		break;
> +	case Opt_fsroot:
> +		if (ctx->fsroot)
> +			goto error_dup;
> +		ctx->fsroot = match_strdup(&args[0]);
> +		if (!ctx->fsroot)
> +			goto error;
> +		break;
> +	case Opt_fstransmute:
> +		if (ctx->fstransmute)
> +			goto error_dup;
> +		ctx->fstransmute = match_strdup(&args[0]);
> +		if (!ctx->fstransmute)
> +			goto error;
> +		break;
> +	default:
> +		pr_warn("Smack:  unknown mount option\n");
> +		goto error_inval;
> +	}
> +
> +	return 0;
> +
> +error_dup:
> +	pr_warn("Smack: duplicate mount option\n");
> +error_inval:
> +	rc = -EINVAL;
> +error:
> +	return rc;
> +}
> +
> +/**
> + * smack_fs_context_validate - Validate the filesystem context security data
> + * @fc: The filesystem context.
> + *
> + * Returns 0 on success or -ENOMEM on error.
> + */
> +static int smack_fs_context_validate(struct fs_context *fc)
> +{
> +	struct smack_fs_context *ctx = fc->security;
> +	struct superblock_smack *sbsp = ctx->sbsp;
> +	struct inode_smack *isp = ctx->isp;
> +	struct smack_known *skp;
> +
> +	if (ctx->fsdefault) {
> +		skp = smk_import_entry(ctx->fsdefault, 0);
> +		if (IS_ERR(skp))
> +			return PTR_ERR(skp);
> +		sbsp->smk_default = skp;
> +	}
> +
> +	if (ctx->fsfloor) {
> +		skp = smk_import_entry(ctx->fsfloor, 0);
> +		if (IS_ERR(skp))
> +			return PTR_ERR(skp);
> +		sbsp->smk_floor = skp;
> +	}
> +
> +	if (ctx->fshat) {
> +		skp = smk_import_entry(ctx->fshat, 0);
> +		if (IS_ERR(skp))
> +			return PTR_ERR(skp);
> +		sbsp->smk_hat = skp;
> +	}
> +
> +	if (ctx->fsroot || ctx->fstransmute) {
> +		skp = smk_import_entry(ctx->fstransmute ?: ctx->fsroot, 0);
> +		if (IS_ERR(skp))
> +			return PTR_ERR(skp);
> +		sbsp->smk_root = skp;
> +		ctx->transmute = !!ctx->fstransmute;
> +	}
> +
> +	isp->smk_inode = sbsp->smk_root;
> +	return 0;
> +}
> +
> +/**
> + * smack_sb_get_tree - Assign the context to a newly created superblock
> + * @fc: The new filesystem context.
> + *
> + * Returns 0 on success or -ENOMEM on error.
> + */
> +static int smack_sb_get_tree(struct fs_context *fc)
> +{
> +	struct smack_fs_context *ctx = fc->security;
> +	struct superblock_smack *sbsp = ctx->sbsp;
> +	struct dentry *root = fc->root;
> +	struct inode *inode = d_backing_inode(root);
> +	struct super_block *sb = root->d_sb;
> +	struct inode_smack *isp;
> +	bool transmute = ctx->transmute;
> +
> +	if (sb->s_security)
> +		return 0;
> +
> +	if (!smack_privileged(CAP_MAC_ADMIN)) {
> +		/*
> +		 * For a handful of fs types with no user-controlled
> +		 * backing store it's okay to trust security labels
> +		 * in the filesystem. The rest are untrusted.
> +		 */
> +		if (fc->user_ns != &init_user_ns &&
> +		    sb->s_magic != SYSFS_MAGIC && sb->s_magic != TMPFS_MAGIC &&
> +		    sb->s_magic != RAMFS_MAGIC) {
> +			transmute = true;
> +			sbsp->smk_flags |= SMK_SB_UNTRUSTED;
> +		}
> +	}
> +
> +	sbsp->smk_flags |= SMK_SB_INITIALIZED;
> +	sb->s_security = sbsp;
> +	ctx->sbsp = NULL;
> +
> +	/* Initialize the root inode. */
> +	isp = inode->i_security;
> +	if (isp == NULL) {
> +		isp = ctx->isp;
> +		ctx->isp = NULL;
> +		inode->i_security = isp;
> +	} else
> +		isp->smk_inode = sbsp->smk_root;
> +
> +	if (transmute)
> +		isp->smk_flags |= SMK_INODE_TRANSMUTE;
> +
> +	return 0;
> +}
>  
>  /*
>   * Superblock Hooks.
> @@ -4647,6 +4949,13 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
>  	LSM_HOOK_INIT(syslog, smack_syslog),
>  
> +	LSM_HOOK_INIT(fs_context_alloc, smack_fs_context_alloc),
> +	LSM_HOOK_INIT(fs_context_dup, smack_fs_context_dup),
> +	LSM_HOOK_INIT(fs_context_free, smack_fs_context_free),
> +	LSM_HOOK_INIT(fs_context_parse_option, smack_fs_context_parse_option),
> +	LSM_HOOK_INIT(fs_context_validate, smack_fs_context_validate),
> +	LSM_HOOK_INIT(sb_get_tree, smack_sb_get_tree),
> +
>  	LSM_HOOK_INIT(sb_alloc_security, smack_sb_alloc_security),
>  	LSM_HOOK_INIT(sb_free_security, smack_sb_free_security),
>  	LSM_HOOK_INIT(sb_copy_data, smack_sb_copy_data),
>
>

