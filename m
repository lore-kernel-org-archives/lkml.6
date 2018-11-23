Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD0EC04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B9420861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uJj+LkTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B9420861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441199AbeKXFtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:49:43 -0500
Received: from sonic312-28.consmr.mail.ne1.yahoo.com ([66.163.191.209]:43212
        "EHLO sonic312-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437318AbeKXFtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1542999845; bh=+mpW5xSOh9pK415LA4XI29oBu1LkOiJlnczzG3Cdrzc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=uJj+LkTSjoG7IG+XzqflKi9/fQ2wYT+fV2mSaN5YmeBTvYTZo9i/53vfm6sgj1HYAGRtxyx3P2Oui9tI/1jVdMbGmdgUBhq6mubyLz3VrnP75wAUz2PddX0zSKKDjxMNvhrpnFgPIWYni4yp+SMPyp63mwSaRZXD4XozLnQUNBhBw08SjTak8Po7vYrfObkb4ij1ssO1ARSIHe+WOnaPVGKx3BnCBOKGTtvDsN8qLwBi5CbYxG5RIkOuQgLr5+Oq78dSinJmjbtxzp8PY2hCm5K76iFCrg/aAXHXQDCCMuJxrC5EX1utKBs2HFCeUThEMUJ4nYpQsxDsGK9Zz1IoNQ==
X-YMail-OSG: UPYqOecVM1kFt0e4wzManBLdCqqdDbWGBxotDuSlVHIRr2dJsr5K2M.3PhtqSzR
 riM0yByvWzfQCGFXgOZiAa._6HdYjxhPeYb84uE0jFJwIqCgvCuQ4ra.BXNlbath3lz5pD0X1qky
 vLbaeewGbNhFiTdCwihAp5sbvj5XR9_Qn7PE4eabtbNpBLnS1vOHpxPcRupQ1De0BHOX5xCZwKuS
 zNxdhvIFwIesuk_vnGKxVd7bacxAX.U9ZrHb1TNWz0X9sjov0mPN9O0QWP2YItjtsrIkyaQvrCR1
 _zuZABmm8vgpxJJ1TW0kDK8iHifger6tNAUjo0FF7YDPituh_iMV7VT0U8NKqIj_RiuuCbkIhjDJ
 bYKKpVskMyHVsR1fkvBGG8C3elx5dujcztEa4u9UBg3HSQP0X5QvcBxGncN.Gu1iOkslmHjjpuLC
 Yn9poKJgjtymWqFkuj6w0eTeoRv_hZw7nNqw2SzBX0CBcfeUxLaoMbXhnbElRCCRRSAKT6EjeOfP
 8SaNlhcbFir6aC0uUGMzzMfiHiOS6yz26mxi6Sy9sstO_ZCtR5J1FpjEob3CSmowNoddNp4_gkAf
 cGqM6vmVCBsRdwP6G34mjsdbv00hUHEwQCLLt_c2tMlzg9iI_4vgGxy53A5k5upIouinyI5eTWfg
 GtqURs0An8t05.t2KqrbAt5A7xBfqjtK8sD3VRF_cs5eKzMNk4Bfx8cFpre6XkeL8xsE4kUXWTfp
 HIjWYnfYEYkXim219mi0PnYe2Xdboc9WDLMz7njp6lnkfa5mjx_MSHaiQz.LKq1L2oV6RiF0DsP5
 xn8TiEyUBlwCzuBBO6CR25l9rXRJ1htBFlR5jFiC_3cFJilYDlXXgNSr7hf21a6wMZgah9GaW7za
 rIN1jC.XjZw759eZSD6QUo2NjFTLfw7wV_Q.03xY_hlB5w33QE03af6oFUzA5Z2UsfY5eqWbijZQ
 iRTMldBw1sz1rDqx_8xYkRtJh7SlGs1bWEpM9hfhEx_NlN1QiMOfBd3YZg6doUfXjSuuVpptHmWW
 ECiwlRPO_xgdqHkpAKk8R369vruUtOOsA9VvhREuNVbOdoqvyIIRlstmGwKqpbBJVn1DAsrdStxq
 HNmSEdwQoS6on6bj_sxsVcrCukSXTasQxWA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 23 Nov 2018 19:04:05 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp419.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c37e294fc8cfbaf5cf1006121fe05e0e;
          Fri, 23 Nov 2018 19:04:02 +0000 (UTC)
Subject: Re: [RFC][PATCH] fs: set xattrs in initramfs from regular files
To:     Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, initramfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com
References: <20181122154942.18262-1-roberto.sassu@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3d1bfbd7-7d45-4cf1-32d6-7f6985b42393@schaufler-ca.com>
Date:   Fri, 23 Nov 2018 11:03:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181122154942.18262-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/2018 7:49 AM, Roberto Sassu wrote:
> Although rootfs (tmpfs) supports xattrs, they are not set due to the
> limitation of the cpio format. A new format called 'newcx' was proposed to
> overcome this limitation.
>
> However, it looks like that adding a new format is not simple: 15 kernel
> patches; user space tools must support the new format; mistakes made in the
> past should be avoided; it is unclear whether the kernel should switch from
> cpio to tar.
>
> The aim of this patch is to provide the same functionality without
> introducing a new format. The value of xattrs is placed in regular files
> having the same file name as the files xattrs are added to, plus a
> separator and the xattr name (<filename>.xattr-<xattr name>).
>
> Example:
>
> '/bin/cat.xattr-security.ima' is the name of a file containing the value of
> the security.ima xattr to be added to /bin/cat.
>
> At kernel initialization time, the kernel iterates over the rootfs
> filesystem, and if it encounters files with the '.xattr-' separator, it
> reads the content and adds the xattr to the file without the suffix.

No.

Really, no.

It would be incredibly easy to use this mechanism to break
into systems.
 

> This proposal requires that LSMs and IMA allow the read and setxattr
> operations. This should not be a concern since: files with xattr values
> are not parsed by the kernel; user space processes are not yet executed.
>
> It would be possible to include all xattrs in the same file, but this
> increases the risk of the kernel being compromised by parsing the content.

The kernel mustn't do this.

>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/Makefile        |   2 +-
>  fs/readxattr.c     | 171 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |   2 +
>  init/main.c        |   1 +
>  4 files changed, 175 insertions(+), 1 deletion(-)
>  create mode 100644 fs/readxattr.c
>
> diff --git a/fs/Makefile b/fs/Makefile
> index 293733f61594..738e1a4e4aff 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -12,7 +12,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
>  		attr.o bad_inode.o file.o filesystems.o namespace.o \
>  		seq_file.o xattr.o libfs.o fs-writeback.o \
>  		pnode.o splice.o sync.o utimes.o d_path.o \
> -		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o
> +		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o readxattr.o
>  
>  ifeq ($(CONFIG_BLOCK),y)
>  obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
> diff --git a/fs/readxattr.c b/fs/readxattr.c
> new file mode 100644
> index 000000000000..01838f6f1e92
> --- /dev/null
> +++ b/fs/readxattr.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation, version 2 of the
> + * License.
> + *
> + * File: readxattr.c
> + *      Read extended attributes from regular files in the initial ram disk
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/export.h>
> +#include <linux/xattr.h>
> +#include <linux/file.h>
> +#include <linux/cred.h>
> +#include <linux/namei.h>
> +#include <linux/fs.h>
> +
> +#include "internal.h"
> +
> +#define SETXATTR_FILENAME ".setxattr"
> +#define FILENAME_XATTR_SEP ".xattr-"
> +
> +
> +struct readdir_callback {
> +	struct dir_context ctx;
> +	struct path *path;
> +};
> +
> +LIST_HEAD(dir_list);
> +
> +struct dir_path {
> +	struct list_head next;
> +	struct path path;
> +};
> +
> +static int __init read_set_xattr(struct dir_context *__ctx, const char *name,
> +				 int namelen, loff_t offset, u64 ino,
> +				 unsigned int d_type)
> +{
> +	struct readdir_callback *ctx = container_of(__ctx, typeof(*ctx), ctx);
> +	struct path *dir = ctx->path, source_path, target_path;
> +	char filename[NAME_MAX + 1], *xattrname, *separator;
> +	struct dir_path *subdir;
> +	struct file *file;
> +	void *datap;
> +	loff_t size;
> +	int result;
> +
> +	if (!strcmp(name, ".") || !strcmp(name, ".."))
> +		return 0;
> +
> +	result = vfs_path_lookup(dir->dentry, dir->mnt, name, 0, &source_path);
> +	if (result)
> +		return 0;
> +
> +	size = i_size_read(source_path.dentry->d_inode);
> +	if (size > XATTR_SIZE_MAX)
> +		goto out;
> +
> +	if (source_path.dentry->d_inode->i_sb != dir->dentry->d_inode->i_sb)
> +		goto out;
> +
> +	if (!S_ISREG(source_path.dentry->d_inode->i_mode) &&
> +	    !S_ISDIR(source_path.dentry->d_inode->i_mode))
> +		goto out;
> +
> +	if (S_ISREG(source_path.dentry->d_inode->i_mode)) {
> +		separator = strstr(name, FILENAME_XATTR_SEP);
> +		if (!separator)
> +			goto out;
> +
> +		xattrname = separator + sizeof(FILENAME_XATTR_SEP) - 1;
> +		if (strlen(xattrname) > XATTR_NAME_MAX)
> +			goto out;
> +	} else {
> +		subdir = kmalloc(sizeof(*subdir), GFP_KERNEL);
> +		if (subdir) {
> +			subdir->path.dentry = source_path.dentry;
> +			subdir->path.mnt = source_path.mnt;
> +
> +			list_add(&subdir->next, &dir_list);
> +		}
> +
> +		return 0;
> +	}
> +
> +	file = dentry_open(&source_path, O_RDONLY, current_cred());
> +	if (IS_ERR(file))
> +		goto out;
> +
> +	result = kernel_read_file(file, &datap, &size, 0, READING_XATTR);
> +	if (result)
> +		goto out_fput;
> +
> +	if (separator != name) {
> +		snprintf(filename, sizeof(filename), "%.*s",
> +			 (int)(namelen - strlen(separator)), name);
> +
> +		result = vfs_path_lookup(dir->dentry, dir->mnt, filename, 0,
> +					&target_path);
> +		if (result)
> +			goto out_vfree;
> +
> +		inode_lock(target_path.dentry->d_inode);
> +	} else {
> +		target_path.dentry = dir->dentry;
> +		target_path.mnt = dir->mnt;
> +	}
> +
> +	__vfs_setxattr_noperm(target_path.dentry, xattrname, datap, size, 0);
> +
> +	if (separator != name) {
> +		inode_unlock(target_path.dentry->d_inode);
> +		path_put(&target_path);
> +	}
> +out_vfree:
> +	vfree(datap);
> +out_fput:
> +	fput(file);
> +out:
> +	path_put(&source_path);
> +	return 0;
> +}
> +
> +void __init set_xattrs_initrd(void)
> +{
> +	struct readdir_callback buf = {
> +		.ctx.actor = read_set_xattr,
> +	};
> +
> +	struct dir_path dir, *cur_dir;
> +	struct path path;
> +	struct file *file;
> +	int result;
> +
> +	result = kern_path(SETXATTR_FILENAME, 0, &path);
> +	if (result)
> +		return;
> +
> +	path_put(&path);
> +
> +	result = kern_path("/", 0, &dir.path);
> +	if (result)
> +		return;
> +
> +	list_add(&dir.next, &dir_list);
> +
> +	while (!list_empty(&dir_list)) {
> +		cur_dir = list_first_entry(&dir_list, typeof(*cur_dir), next);
> +
> +		file = dentry_open(&cur_dir->path, O_RDONLY, current_cred());
> +		if (file) {
> +			buf.path = &cur_dir->path;
> +			iterate_dir(file, &buf.ctx);
> +			fput(file);
> +		}
> +
> +		path_put(&cur_dir->path);
> +		list_del(&cur_dir->next);
> +
> +		if (cur_dir != &dir)
> +			kfree(cur_dir);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(set_xattrs_initrd);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c95c0807471f..b04edc1c32e9 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2894,6 +2894,7 @@ extern int do_pipe_flags(int *, int);
>  	id(KEXEC_INITRAMFS, kexec-initramfs)	\
>  	id(POLICY, security-policy)		\
>  	id(X509_CERTIFICATE, x509-certificate)	\
> +	id(XATTR, xattr)	\
>  	id(MAX_ID, )
>  
>  #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
> @@ -3156,6 +3157,7 @@ const char *simple_get_link(struct dentry *, struct inode *,
>  extern const struct inode_operations simple_symlink_inode_operations;
>  
>  extern int iterate_dir(struct file *, struct dir_context *);
> +extern void set_xattrs_initrd(void);
>  
>  extern int vfs_statx(int, const char __user *, int, struct kstat *, u32);
>  extern int vfs_statx_fd(unsigned int, struct kstat *, u32, unsigned int);
> diff --git a/init/main.c b/init/main.c
> index ee147103ba1b..a2f63bc8f9d4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1180,5 +1180,6 @@ static noinline void __init kernel_init_freeable(void)
>  	 */
>  
>  	integrity_load_keys();
> +	set_xattrs_initrd();
>  	load_default_modules();
>  }

