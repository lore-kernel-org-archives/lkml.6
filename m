Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bNI/LAWUGFthCwAAmS7hNA
	; Thu, 07 Jun 2018 02:10:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 916C9608BA; Thu,  7 Jun 2018 02:10:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C3C186089E;
	Thu,  7 Jun 2018 02:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3C186089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753728AbeFGB7J (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 21:59:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:48716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753103AbeFGB7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 21:59:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 31B03AD26;
        Thu,  7 Jun 2018 01:58:59 +0000 (UTC)
Subject: Re: [PATCH 26/32] afs: Use fs_context to pass parameters over
 automount [ver #8]
To: David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720689245.9073.17300569813645143102.stgit@warthog.procyon.org.uk>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=rgoldwyn@suse.de; prefer-encrypt=mutual; keydata=
 xsDiBEaI9tIRBAC+jCQxwxm9mPCrzNiUskTzyLKUPLdW4n8Rjmt/N4ISt0AZWDKq7SpiDQjr
 yfOORLFFBFsfSH40OJlBjIpO+mh9XHPbc83bOESJdT5huIbC/0yuqR0xYVt+U0FLXQJ3w70N
 9eALGVxPPcQ3uIBpdTJUqkvKf9x3xLUdqRe/GQnXcwCgjKJ0sON51KlW36oNEyj4gF50Pg8D
 /jis+JcqnVlunIkGljWiYu6gNVXBXXiFqqbxnwWDGrA1e86Xl8A/aJn5tP/XELURNU7L1H1L
 f1g3K/usDaTkNsJ1HwmH378ctJTu7JYx/euCoz7MhKEJ2EgLC0Ob262cnk9JLAnpJOYPwIhA
 dgdtcdqASfln8gfP+6M+qFqOopfKA/9xLmyVSfxEoy4qdhlUC3GRFjZ5Ste2aOr9G0JXnWIg
 jccn/dT4sOb2lhKIKHiJmD4ns8Io01QPh/Cd6ecZ6Cx3InCQHyzMOVvZn0fdbO9/+348yRSl
 YOBXoViPxlUWGc/52eWohuleDhsrtn0aVX4d1zvhc5oswj6dKDDvDnnN580lR29sZHd5biBS
 b2RyaWd1ZXMgPHJnb2xkd3luQHN1c2UuY29tPsKVBBMRAgBVAhsjBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgAIZAQUJHC+BBRYhBO+WsixA7W+EivWnh0m5sHYwIjhsBQJamCrlEhhoa3A6
 Ly9wZ3AubWl0LmVkdQAKCRBJubB2MCI4bHt8AJwKjLlv73VEx6e63oQfUoOJKibHWwCfXIG1
 LHEVJbYPWAPKQ6Zk8ZCodXrOwU0ERoj26RAIAKKaKET9+fkkdP745IAQ17wrIzkpU/pAz90C
 fjJVhKngrb6PMFHyOPXlRAyJPCpp8Whl8P+KmAM7SZof4n8aLyrl+SVYFMe9RwYSshD7eNBD
 WmPNJd2qK8JJLUC8/ZRb5yw/bHfIRITogS9Tie5WJwHjMapizdQV8dyI+hSpYmWPDSOUaYCF
 T/nWaQP2NObZDFpBX3P8kP3LSTP+JW3Fz06CrJ03bAtm2CPDNI02sc5MHvRJXGNM2grvh+bK
 4V0sDrBeWr9sHy5ADoIx9PXGIfNH4NbSVBSGW3Oy8dmZnDfMgtAb9oY6HaGKZDj/F+AgxywB
 8oyvGfrJhfizIYROmycAAwUH/AtsttodDYydHeM9GFiZy0o/n4FAseYiMJKRI8fC2pYvrojt
 zbpQKXa64vQv2INtJHm8D1iGpzdrNkjL5jlqPKSUIkhwt9yUpOH3UQifwYOeKZUiv7vrapnW
 1gJb7RWhg4ske+qOa2FKvFVMsJ2quuu0qHOH0K8l7T8VqaW8FH4097c3TeSO17qRtwnNm+F7
 a+cXijMOaajZ9Xp4X04+wrEf7Rmvhc0zr96t3Z5QYx4ZwoyDfLefm5ORUe2CcRva7TnycB9P
 IxdGoVS2eIyepO+RMjvq5e6xjkpoiJ3cybQhsUt+pZd/KGSkZmhHpId3Y6zivOq7Lj+ELOtW
 dOTcV0TCTwQYEQIADwIbDAUCWVJ2GQUJHC+AsAAKCRBJubB2MCI4bC2IAJoDDDkaRi7G/lzz
 fUIV2179DCq38wCaAmivz68q3lkN6rF6vnh5DEGS74c=
Message-ID: <1917614e-97dc-c911-c2d1-cc5d002d2071@suse.de>
Date: Wed, 6 Jun 2018 20:58:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152720689245.9073.17300569813645143102.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/24/2018 07:08 PM, David Howells wrote:
> Alter the AFS automounting code to create and modify an fs_context struct
> when parameterising a new mount triggered by an AFS mountpoint rather than
> constructing device name and option strings.
> 
> Also remove the cell=, vol= and rwpath options as they are then redundant.
> The reason they existed is because the 'device name' may be derived
> literally from a mountpoint object in the filesystem, so default cell and
> parent-type information needed to be passed in by some other method from
> the automount routines.  The vol= option didn't end up being used.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Eric W. Biederman <ebiederm@redhat.com>
> ---
> 
>  fs/afs/internal.h |    1 
>  fs/afs/mntpt.c    |  148 +++++++++++++++++++++++++++--------------------------
>  fs/afs/super.c    |   43 +--------------
>  3 files changed, 79 insertions(+), 113 deletions(-)
> 
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index eb6e75e00181..90af5001f8c8 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -35,7 +35,6 @@ struct pagevec;
>  struct afs_call;
>  
>  struct afs_fs_context {
> -	bool			rwpath;		/* T if the parent should be considered R/W */
>  	bool			force;		/* T to force cell type */
>  	bool			autocell;	/* T if set auto mount operation */
>  	bool			dyn_root;	/* T if dynamic root */
> diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
> index c45aa1776591..fc383d727552 100644
> --- a/fs/afs/mntpt.c
> +++ b/fs/afs/mntpt.c
> @@ -47,6 +47,8 @@ static DECLARE_DELAYED_WORK(afs_mntpt_expiry_timer, afs_mntpt_expiry_timed_out);
>  
>  static unsigned long afs_mntpt_expiry_timeout = 10 * 60;
>  
> +static const char afs_root_volume[] = "root.cell";
> +
>  /*
>   * no valid lookup procedure on this sort of dir
>   */
> @@ -68,107 +70,107 @@ static int afs_mntpt_open(struct inode *inode, struct file *file)
>  }
>  
>  /*
> - * create a vfsmount to be automounted
> + * Set the parameters for the proposed superblock.
>   */
> -static struct vfsmount *afs_mntpt_do_automount(struct dentry *mntpt)
> +static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
>  {
> -	struct afs_super_info *as;
> -	struct vfsmount *mnt;
> -	struct afs_vnode *vnode;
> -	struct page *page;
> -	char *devname, *options;
> -	bool rwpath = false;
> +	struct afs_fs_context *ctx = fc->fs_private;
> +	struct afs_vnode *vnode = AFS_FS_I(d_inode(mntpt));
> +	struct afs_cell *cell;
> +	const char *p;
>  	int ret;
>  
> -	_enter("{%pd}", mntpt);
> -
> -	BUG_ON(!d_inode(mntpt));
> -
> -	ret = -ENOMEM;
> -	devname = (char *) get_zeroed_page(GFP_KERNEL);
> -	if (!devname)
> -		goto error_no_devname;
> -
> -	options = (char *) get_zeroed_page(GFP_KERNEL);
> -	if (!options)
> -		goto error_no_options;
> -
> -	vnode = AFS_FS_I(d_inode(mntpt));
>  	if (test_bit(AFS_VNODE_PSEUDODIR, &vnode->flags)) {
>  		/* if the directory is a pseudo directory, use the d_name */
> -		static const char afs_root_cell[] = ":root.cell.";
>  		unsigned size = mntpt->d_name.len;
>  
> -		ret = -ENOENT;
> -		if (size < 2 || size > AFS_MAXCELLNAME)
> -			goto error_no_page;
> +		if (size < 2)
> +			return -ENOENT;
>  
> +		p = mntpt->d_name.name;
>  		if (mntpt->d_name.name[0] == '.') {
> -			devname[0] = '%';
> -			memcpy(devname + 1, mntpt->d_name.name + 1, size - 1);
> -			memcpy(devname + size, afs_root_cell,
> -			       sizeof(afs_root_cell));
> -			rwpath = true;
> -		} else {
> -			devname[0] = '#';
> -			memcpy(devname + 1, mntpt->d_name.name, size);
> -			memcpy(devname + size + 1, afs_root_cell,
> -			       sizeof(afs_root_cell));
> +			size--;
> +			p++;
> +			ctx->type = AFSVL_RWVOL;
> +			ctx->force = true;
> +		}
> +		if (size > AFS_MAXCELLNAME)
> +			return -ENAMETOOLONG;
> +
> +		cell = afs_lookup_cell(ctx->net, p, size, NULL, false);
> +		if (IS_ERR(cell)) {
> +			pr_err("kAFS: unable to lookup cell '%pd'\n", mntpt);
> +			return PTR_ERR(cell);
>  		}
> +		afs_put_cell(ctx->net, ctx->cell);
> +		ctx->cell = cell;
> +
> +		ctx->volname = afs_root_volume;
> +		ctx->volnamesz = sizeof(afs_root_volume) - 1;
>  	} else {
>  		/* read the contents of the AFS special symlink */
> +		struct page *page;
>  		loff_t size = i_size_read(d_inode(mntpt));
>  		char *buf;
>  
> -		ret = -EINVAL;
>  		if (size > PAGE_SIZE - 1)
> -			goto error_no_page;
> +			return -EINVAL;
>  
>  		page = read_mapping_page(d_inode(mntpt)->i_mapping, 0, NULL);
> -		if (IS_ERR(page)) {
> -			ret = PTR_ERR(page);
> -			goto error_no_page;
> -		}
> +		if (IS_ERR(page))
> +			return PTR_ERR(page);
>  
> -		ret = -EIO;
> -		if (PageError(page))
> -			goto error;
> +		if (PageError(page)) {
> +			put_page(page);
> +			return -EIO;
> +		}
>  
> -		buf = kmap_atomic(page);
> -		memcpy(devname, buf, size);
> -		kunmap_atomic(buf);
> +		buf = kmap(page);
> +		ret = vfs_set_fs_source(fc, buf, size);
> +		kunmap(page);
>  		put_page(page);
> -		page = NULL;
> +		if (ret < 0)
> +			return ret;
>  	}
>  
> -	/* work out what options we want */
> -	as = AFS_FS_S(mntpt->d_sb);
> -	if (as->cell) {
> -		memcpy(options, "cell=", 5);
> -		strcpy(options + 5, as->cell->name);
> -		if ((as->volume && as->volume->type == AFSVL_RWVOL) || rwpath)
> -			strcat(options, ",rwpath");
> -	}
> +	return 0;
> +}
>  
> -	/* try and do the mount */
> -	_debug("--- attempting mount %s -o %s ---", devname, options);
> -	mnt = vfs_submount(mntpt, &afs_fs_type, devname,
> -			   options, strlen(options) + 1);
> -	_debug("--- mount result %p ---", mnt);
> +/*
> + * create a vfsmount to be automounted
> + */
> +static struct vfsmount *afs_mntpt_do_automount(struct dentry *mntpt)
> +{
> +	struct fs_context *fc;
> +	struct vfsmount *mnt;
> +	int ret;
> +
> +	BUG_ON(!d_inode(mntpt));
> +
> +	fc = vfs_new_fs_context(&afs_fs_type, mntpt, 0,
> +				FS_CONTEXT_FOR_SUBMOUNT);
> +	if (IS_ERR(fc))
> +		return ERR_CAST(fc);
> +
> +	ret = afs_mntpt_set_params(fc, mntpt);
> +	if (ret < 0)
> +		goto error_fc;
> +
> +	ret = vfs_get_tree(fc);
> +	if (ret < 0)
> +		goto error_fc;
> +
> +	mnt = vfs_create_mount(fc, 0);
> +	if (IS_ERR(mnt)) {
> +		ret = PTR_ERR(mnt);
> +		goto error_fc;
> +	}
>  
> -	free_page((unsigned long) devname);
> -	free_page((unsigned long) options);
> -	_leave(" = %p", mnt);
> +	put_fs_context(fc);
>  	return mnt;
>  

Why are you performing a put_fs_context(fc) in the success code path? Do
we not need a reference of fc anymore?


> -error:
> -	put_page(page);
> -error_no_page:
> -	free_page((unsigned long) options);
> -error_no_options:
> -	free_page((unsigned long) devname);
> -error_no_devname:
> -	_leave(" = %d", ret);
> +error_fc:
> +	put_fs_context(fc);
>  	return ERR_PTR(ret);
>  }
>  
-- 
Goldwyn
