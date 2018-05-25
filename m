Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752553-1527251096-2-14663768255514898341
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527251096; b=QFku8qFkb7UWK3GmYm/JiUPX7F1LZs1U+RHPma9SW4Lmr2lVRg
    aMva+CiVrhCszPxiEE0qimb5pwt+dgcUyw2NPGxGmy6/dNvNVd1D4CFTHXw7YEP2
    BAt9NmSGGZhmyxiFQj/mxkUM5NEuV8cADegYD1UwsoOmLpcxX6eH01Ur/OfO0paJ
    7E8lRUKrHOwaGep/DO2MfeHmkxpk2ZLm6BRrCQXFKW7rpO/Hr1n0+ZsyQcGvo9yb
    bitPdXeAvmdIAVABvLON7UhwCxcrf212acNy7oEVBs5dF033wWRWJtUE/XVQ6S88
    tzHP72eFiyZMvZROlJeLEBBGnh+XzZTfezZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1527251096; bh=9o7aBvaCmb97
    NNAHly0eFmHIaSSeTzHObf3tbYrHAd0=; b=Uwyv6D49PgulpVzu1ILMD6truvxA
    Q+N+noUn0k35DDut8Wl4roZ5HalYaMPUmAh/7+rNhimVtn4u0YK0Wrfj0fJgQVG6
    6FL7G82bw0Ht99C+dMdPECnYWGWfoWNKZr4qcOz9NcxagK7bo3js5k4xpo61wMU/
    OJcQgLPYVHhw6vjI26MLXEdhso5PX5Ny8HgP25+ppQ5GVQ0x6mmfCAzeN9U8ChbK
    2/t9l6lDEVkhRW978KAZfjWmzlR+LU2sbT+MnSaj/zXTnLtVA0bjIwiy78lYlZI3
    oKo2ON0V1ARDzboO+MVlQrEWdT0mOaFG3ILY9D2X7myx0zG6eglymo6RbQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMNjQ5Ro8SCpTQD6aWOLy/A2y3IQOBCEcXa5vbEwbmbfRz/RJgbJc6oEPN91L5fuzb1cSK4UjfffKRqtNcQ86aqTAd6OGF6e5g/Za3kmVXPvwIKOY+VM
    j8qxuuQPgK90ikt04EMIPjU8OGHAPU8FKumY2s6dYrqHNKyiR00vOICRHYgRTkQqMLh9mGPmya683mOcmbuxA6KTXc8NffTHq7j86Wkk0rLm/pBx8z/79Kqo
    CAqC6KOwFqXqxBJDbu/L3w==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=yynovAVwzO0WX1HY8yIA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966729AbeEYMYs (ORCPT <rfc822;linux@kroah.com>);
        Fri, 25 May 2018 08:24:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966964AbeEYMWa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 25 May 2018 08:22:30 -0400
Subject: Re: [PATCH v3 1/7] security: rename security_kernel_read_file() hook
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Date: Fri, 25 May 2018 08:22:09 -0400
In-Reply-To: <87po1k2304.fsf@xmission.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com>
         <87po1k2304.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18052512-0020-0000-0000-0000042136BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052512-0021-0000-0000-000042B67EEB
Message-Id: <1527250929.3424.146.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805250134
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-05-24 at 15:49 -0500, Eric W. Biederman wrote:

Thank you for the sample code below.  It needs to be broken up into
proper patches, with some changes, but it is a good start.

Mimi 

> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 358354148dec..04536ff81bd2 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -294,9 +294,7 @@ static ssize_t firmware_loading_store(struct device *dev,
>  				dev_err(dev, "%s: map pages failed\n",
>  					__func__);
>  			else
> -				rc = security_kernel_post_read_file(NULL,
> -						fw_priv->data, fw_priv->size,
> -						READING_FIRMWARE);
> +				rc = security_kernel_arg(KARG_FIRMWARE);
> 
>  			/*
>  			 * Same logic as fw_load_abort, only the DONE bit
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 0e4647e0eb60..9fb42736ba29 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -11,6 +11,7 @@
>  #define _LINUX_IMA_H
> 
>  #include <linux/fs.h>
> +#include <linux/security.h>
>  #include <linux/kexec.h>
>  struct linux_binprm;
> 
> @@ -19,7 +20,7 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
>  extern int ima_file_check(struct file *file, int mask, int opened);
>  extern void ima_file_free(struct file *file);
>  extern int ima_file_mmap(struct file *file, unsigned long prot);
> -extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
> +extern int ima_kernel_arg(enum kernel_arg_id id);
>  extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  			      enum kernel_read_file_id id);
>  extern void ima_post_path_mknod(struct dentry *dentry);
> @@ -49,7 +50,7 @@ static inline int ima_file_mmap(struct file *file, unsigned long prot)
>  	return 0;
>  }
> 
> -static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
> +static inline int ima_kernel_arg(enum kernel_arg_id id)
>  {
>  	return 0;
>  }
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 9d0b286f3dba..7f8bc3030784 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -576,6 +576,10 @@
>   *	userspace to load a kernel module with the given name.
>   *	@kmod_name name of the module requested by the kernel
>   *	Return 0 if successful.
> + * @kernel_arg:
> + *	Use a syscall argument
> + *	@id kernel argument identifier
> + *	Return 0 if permission is granted.
>   * @kernel_read_file:
>   *	Read a file specified by userspace.
>   *	@file contains the file structure pointing to the file being read
> @@ -1577,6 +1581,7 @@ union security_list_options {
>  	int (*kernel_act_as)(struct cred *new, u32 secid);
>  	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
>  	int (*kernel_module_request)(char *kmod_name);
> +	int (*kernel_arg)(enum kernel_arg_id id);
>  	int (*kernel_read_file)(struct file *file, enum kernel_read_file_id id);
>  	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
>  				     enum kernel_read_file_id id);
> @@ -1866,6 +1871,7 @@ struct security_hook_heads {
>  	struct hlist_head cred_getsecid;
>  	struct hlist_head kernel_act_as;
>  	struct hlist_head kernel_create_files_as;
> +	struct hlist_head kernel_arg;
>  	struct hlist_head kernel_read_file;
>  	struct hlist_head kernel_post_read_file;
>  	struct hlist_head kernel_module_request;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 200920f521a1..6cf1bd87f041 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -159,6 +159,32 @@ extern int mmap_min_addr_handler(struct ctl_table *table, int write,
>  typedef int (*initxattrs) (struct inode *inode,
>  			   const struct xattr *xattr_array, void *fs_data);
> 
> +#define __kernel_arg_id(id) \
> +	id(UNKNOWN, unknown)		\
> +	id(FIRMWARE, firmware)		\
> +	id(MODULE, kernel-module)	\
> +	id(MAX_ID, )
> +
> +#define __karg_enumify(ENUM, dummy) KARG_ ## ENUM,
> +#define __karg_stringify(dummy, str) #str,
> +
> +enum kernel_arg_id {
> +	__kernel_arg_id(__karg_enumify)
> +};
> +
> +static const char * const kernel_arg_str[] = {
> +	__kernel_arg_id(__karg_stringify)
> +};
> +
> +static inline const char *kernel_arg_id_str(enum kernel_arg_id id)
> +{
> +	if ((unsigned)id >= KARG_MAX_ID)
> +		return kernel_arg_str[KARG_UNKNOWN];
> +
> +	return kernel_arg_str[id];
> +}
> +
> +
>  #ifdef CONFIG_SECURITY
> 
>  struct security_mnt_opts {
> @@ -326,6 +352,7 @@ void security_cred_getsecid(const struct cred *c, u32 *secid);
>  int security_kernel_act_as(struct cred *new, u32 secid);
>  int security_kernel_create_files_as(struct cred *new, struct inode *inode);
>  int security_kernel_module_request(char *kmod_name);
> +int security_kernel_arg(enum kernel_arg_id id);
>  int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
>  int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
>  				   enum kernel_read_file_id id);
> @@ -923,6 +950,11 @@ static inline int security_kernel_module_request(char *kmod_name)
>  	return 0;
>  }
> 
> +static inline int security_kernel_arg(enum kernel_arg_id id)
> +{
> +	return 0;
> +}
> +
>  static inline int security_kernel_read_file(struct file *file,
>  					    enum kernel_read_file_id id)
>  {
> diff --git a/kernel/module.c b/kernel/module.c
> index ce8066b88178..03a1dd21ad4a 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2879,7 +2879,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
>  	if (info->len < sizeof(*(info->hdr)))
>  		return -ENOEXEC;
> 
> -	err = security_kernel_read_file(NULL, READING_MODULE);
> +	err = security_kernel_arg(KARG_MODULE);
>  	if (err)
>  		return err;
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 74d0bd7e76d7..d51a8ca97238 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -421,32 +421,6 @@ void ima_post_path_mknod(struct dentry *dentry)
>  		iint->flags |= IMA_NEW_FILE;
>  }
> 
> -/**
> - * ima_read_file - pre-measure/appraise hook decision based on policy
> - * @file: pointer to the file to be measured/appraised/audit
> - * @read_id: caller identifier
> - *
> - * Permit reading a file based on policy. The policy rules are written
> - * in terms of the policy identifier.  Appraising the integrity of
> - * a file requires a file descriptor.
> - *
> - * For permission return 0, otherwise return -EACCES.
> - */
> -int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
> -{
> -	bool sig_enforce = is_module_sig_enforced();
> -
> -	if (!file && read_id == READING_MODULE) {
> -		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
> -		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> -			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
> -			return -EACCES;	/* INTEGRITY_UNKNOWN */
> -		}
> -		return 0;	/* We rely on module signature checking */
> -	}
> -	return 0;
> -}
> -
>  static int read_idmap[READING_MAX_ID] = {
>  	[READING_FIRMWARE] = FIRMWARE_CHECK,
>  	[READING_MODULE] = MODULE_CHECK,
> @@ -474,21 +448,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  	enum ima_hooks func;
>  	u32 secid;
> 
> -	if (!file && read_id == READING_FIRMWARE) {
> -		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> -		    (ima_appraise & IMA_APPRAISE_ENFORCE))
> -			return -EACCES;	/* INTEGRITY_UNKNOWN */
> -		return 0;
> -	}
> -
> -	if (!file && read_id == READING_MODULE) /* MODULE_SIG_FORCE enabled */
> -		return 0;
> -
> -	/* permit signed certs */
> -	if (!file && read_id == READING_X509_CERTIFICATE)
> -		return 0;
> -
> -	if (!file || !buf || size == 0) { /* should never happen */
> +	if (!buf || size == 0) { /* should never happen */
>  		if (ima_appraise & IMA_APPRAISE_ENFORCE)
>  			return -EACCES;
>  		return 0;
> @@ -500,6 +460,40 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  				   MAY_READ, func, 0);
>  }
> 
> +/**
> + * ima_kernel_arg - pre-measure/appraise hook decision based on policy
> + * @id: caller identifier
> + *
> + * Permit using an argument to a syscall based on policy. The policy
> + * rules are written in terms of the policy identifier.
> + *
> + * For permission return 0, otherwise return -EACCES.
> + */
> +int ima_kernel_arg(enum kernel_arg_id id)
> +{
> +	if (id == KARG_MODULE) {
> +		bool sig_enforce = is_module_sig_enforced();
> +		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
> +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> +			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
> +			return -EACCES;	/* INTEGRITY_UNKNOWN */
> +		}
> +		return 0;	/* We rely on module signature checking */
> +	}
> +	else if (id == KARG_FIRMWARE) {
> +		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> +		    (ima_appraise & IMA_APPRAISE_ENFORCE))
> +			return -EACCES;	/* INTEGRITY_UNKNOWN */
> +		return 0;
> +	}
> +	else {
> +		if (ima_appraise & IMA_APPRAISE_ENFORCE)
> +			return -EACCES;
> +		return 0;
> +	}
> +	return 0;
> +}
> +
>  static int __init init_ima(void)
>  {
>  	int error;
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 5fa191252c8f..f5333e5abac9 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -121,23 +121,24 @@ static void loadpin_sb_free_security(struct super_block *mnt_sb)
>  	}
>  }
> 
> -static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
> +static int loadpin_read_data(enum kernel_read_data_id id)
>  {
> -	struct super_block *load_root;
> -	const char *origin = kernel_read_file_id_str(id);
> +	const char *origin = kernel_arg_id_str(id);
> 
>  	/* This handles the older init_module API that has a NULL file. */
> -	if (!file) {
> -		if (!enabled) {
> -			report_load(origin, NULL, "old-api-pinning-ignored");
> -			return 0;
> -		}
> -
> -		report_load(origin, NULL, "old-api-denied");
> -		return -EPERM;
> +	if (!enabled) {
> +		report_load(origin, NULL, "old-api-pinning-ignored");
> +		return 0;
>  	}
> 
> -	load_root = file->f_path.mnt->mnt_sb;
> +	report_load(origin, NULL, "old-api-denied");
> +	return -EPERM;
> +}
> +
> +static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
> +{
> +	struct super_block *load_root;
> +	const char *origin = kernel_read_file_id_str(id);
> 
>  	/* First loaded module/firmware defines the root for all others. */
>  	spin_lock(&pinned_root_spinlock);
> @@ -175,6 +176,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
> 
>  static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
> +	LSM_HOOK_INIT(kernel_read_data, loadpin_read_data),
>  	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
>  };
> 
> diff --git a/security/security.c b/security/security.c
> index 7bc2fde023a7..9b5f43c24ee2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1033,14 +1033,19 @@ int security_kernel_module_request(char *kmod_name)
>  	return call_int_hook(kernel_module_request, 0, kmod_name);
>  }
> 
> -int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
> +int security_kernel_arg(enum kernel_arg_id id)
>  {
>  	int ret;
> 
> -	ret = call_int_hook(kernel_read_file, 0, file, id);
> -	if (ret)
> -		return ret;
> -	return ima_read_file(file, id);
> +	ret = call_int_hook(kernel_arg, 0, id);
> +	if (!ret)
> +		ret = ima_kernel_arg(id);
> +	return ret;
> +}
> +
> +int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
> +{
> +	return call_int_hook(kernel_read_file, 0, file, id);
>  }
>  EXPORT_SYMBOL_GPL(security_kernel_read_file);
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 4cafe6a19167..76843099fed6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4010,6 +4010,15 @@ static int selinux_kernel_module_request(char *kmod_name)
>  			    SYSTEM__MODULE_REQUEST, &ad);
>  }
> 
> +static int selinux_kernel_module_arg(void)
> +{
> +	/* init_module */
> +	u32 sid = current_sid();
> +	return avc_has_perm(&selinux_state,
> +			    sid, sid, SECCLASS_SYSTEM,
> +			    SYSTEM__MODULE_LOAD, NULL);
> +}
> +
>  static int selinux_kernel_module_from_file(struct file *file)
>  {
>  	struct common_audit_data ad;
> @@ -4018,12 +4027,6 @@ static int selinux_kernel_module_from_file(struct file *file)
>  	u32 sid = current_sid();
>  	int rc;
> 
> -	/* init_module */
> -	if (file == NULL)
> -		return avc_has_perm(&selinux_state,
> -				    sid, sid, SECCLASS_SYSTEM,
> -					SYSTEM__MODULE_LOAD, NULL);
> -
>  	/* finit_module */
> 
>  	ad.type = LSM_AUDIT_DATA_FILE;
> @@ -4043,6 +4046,20 @@ static int selinux_kernel_module_from_file(struct file *file)
>  				SYSTEM__MODULE_LOAD, &ad);
>  }
> 
> +static int selinux_kernel_arg(enum kernel_arg_id id)
> +{
> +	int rc = 0;
> +
> +	switch (id) {
> +	case KARG_MODULE:
> +		rc = selinux_kernel_module_arg();
> +		break;
> +	default:
> +		break;
> +	}
> +	return rc;
> +}
> +
>  static int selinux_kernel_read_file(struct file *file,
>  				    enum kernel_read_file_id id)
>  {
> @@ -6938,6 +6955,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
>  	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
>  	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
> +	LSM_HOOK_INIT(kernel_arg, selinux_kernel_arg),
>  	LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
>  	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
>  	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

