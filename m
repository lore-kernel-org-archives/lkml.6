Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-958837-1526310256-2-4774689640294618013
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526310256; b=YzB+myoFvccOxDwW6Bzh1SRm4xs0AokJtQ+cF3jhvoPmtj87f8
    rDDMJEblsGr6ABbCt6XzJM3ddPsq8c9Wk7gNTBQIUu5mhQykgfKdwhIciJSjXLMJ
    47lmzQ/BDvPvRf5CLnkqbE6ACLAMRvvQhaxcl+BFpwi1hP2E1ppMo0181mtvHFq6
    zQbXvwOEIyl+Ei9KZWRv/Fi/FIDsyp+JW9oS84y6sMV6VkEjPQa2QfCL5A3WVxtp
    oH04C/g6vNk7QGo5JD6XEUQvPnLPTEmF9RsgmsmG2aLHY1y3AzE9rAv0avruUkcy
    xzkV8WLo1nQW3qcYCxxpVFENuBvT3Ua1eHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526310256;
    bh=xxWDnDywMuqakl4OgiSy0fJ+x3e17ZJ7R8eipxeJPbU=; b=FU/Zfg/t4hMT
    mDGlw6yIigptGAlhb4d87N4uxVkyHJ3WpVVNbm+gvG61sBen3iJXeAANPRL5NaVl
    JfkPSjAWrf4GpSDLF1TgYINLMRavcP8W/4ntxkG/d5Vfgc4I13yyqlfIirrYH+i9
    /N3nyF7IWKBEeU/i/WikHM8r5gmxgTblWt61/cAhLte7QQ63xQKC7V6caoHDw3Ui
    nxX885dKBhPxh8C/4aON8J/4//kflItgcvFn6aHv2/TIZx2xUB3HnaRiaoIWxFNv
    WHo3O1VL0Lv3GlJNzRJsi6yhPg3TmFpr9lj8PLkhGu+X5DikdSnhTPPPSsUp3w+E
    Iq3vyhyd/Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.nsa.gov;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=tycho.nsa.gov header.result=pass
    header_org.domain=nsa.gov header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-110 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.nsa.gov;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=tycho.nsa.gov header.result=pass
      header_org.domain=nsa.gov header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-110 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJu2kM/WRPD8yeq+AnTNtOkIBCMZN58tfb0c59uOLwsAJqEfV9AW+bTyuAL60RhYMLcqEhIP34ZLC9bKuk9suirhWC8RQqsT0GuvjY/9BwPCYWP4HHNu
    +xbnUVAL0awFTuREdsbyOv0zeD7fV7uIrs0d2ItL7ScQA7qmFfA3rjEtk5axLB7VFxiiuHAJFUgyP1CnxOCPGLLjw4Rb/3NCWXwgRvcNKWWMCB4muIWtS0Th
    lX5vWoyauVDafuWaN2jT8Q==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=vpqfxihKAAAA:8 a=VwQbUJbxAAAA:8 a=wgJJmsxKKT7CQQFHvbIA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AULIiLoY-XQsE5F6gcqX:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeENPEM (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 11:04:12 -0400
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:45983 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbeENPEJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 May 2018 11:04:09 -0400
X-IronPort-AV: E=Sophos;i="5.49,400,1520899200";
   d="scan'208";a="512417573"
X-IronPort-AV: E=Sophos;i="5.49,400,1520899200";
   d="scan'208";a="11754010"
IronPort-PHdr: =?us-ascii?q?9a23=3A2lbgxRXsr19A9WU9/Mywyj/GgnfV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZROGtKdThVPEFb/W9+hDw7KP9fy4AipYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uIhi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpUsZXxq14IoBCjBwejGfnvxydViHHo06000+?=
 =?us-ascii?q?cvHw/I0wMvHd0BrHvaoc7pNKoQS+250LXEwDvBYv5QxDzz6JLIchckofyUQL?=
 =?us-ascii?q?xwbdTeyVEvFwzbiFWbtJHrPzaP2eQJt2iU8ephXv+ohm48tg5xuSOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUNJN2T9s/T2xntys20L0LtY?=
 =?us-ascii?q?OhcCQUx5kr2QTTZ+GBfoOV+BzsTvyRLi19hH99fbK/gAu9/la4x+3nU8m0zE?=
 =?us-ascii?q?5Kri1YktnQrnwN1wLc6syASvZl4keuwyyP1wHO6uFfO0w0iaraJIIhwr43jJ?=
 =?us-ascii?q?YTt1jMHjTql0nsia+Wd0Ek9vCp6+ThfLrmuoeRO5J7hwzxKKgjmtGzDf4mPg?=
 =?us-ascii?q?UBQWSX4/mw2KXm/ULjQbVKivM2krPesJDfPckbvbO2AxRO34Y/6xewEzem0N?=
 =?us-ascii?q?MCkXkBN1JKYgiLj4fuO1HQOPz4F+uwg0ywkDd3wPDLJqHuDY/WLnfdkLbsZq?=
 =?us-ascii?q?195FJcyAUp0NBf6ZZUBa8bIP7qRkD+rsbUAQM+Mwyx2+znEsly1psCWWKTBa?=
 =?us-ascii?q?+UKKfSsV6O5uIyLOiAfZQVtyjhJPg4/f7ujGM5mF8Ecams2psYdW24HvB4LE?=
 =?us-ascii?q?iCf3rsjckOEX0Qsgo9UuPqkluCXiBXZ3qoWKI8/D47Apq8DYjfXoCtnKCB3C?=
 =?us-ascii?q?CjE51SZ2BGDE2MEHjxe4WHRfgMciSSLdFlkjEfS7ihRJEu1Qu0uA/51bVnNO?=
 =?us-ascii?q?zU9TMctZ7509h1/eLTnwko9TNoF8Sdz32NT2Zsk2MQXTA2waR/rFdlyliZzK?=
 =?us-ascii?q?h4h+VUFdlU5/NOSAc1K4TQwPB9C9D3QgjBZMuGSE66QtW6BjE8Vs8/zdgSbk?=
 =?us-ascii?q?tjHtuulw3M3yuxA7AJiryLH4c0/7nY33jwPMZ9123G2LM9g1U7WMdPMnemhq?=
 =?us-ascii?q?Fn/QjJG4HJi1mZl7qtdakE3i7N82eDzWyUsEFaVw5wUb/KXXYEZkTIq9T0/V?=
 =?us-ascii?q?/NQKWoCbQgNAtByNKNJbFOatHzkVpGQ/LjMszEY22tg2ewGQqIxrSUYYrpZW?=
 =?us-ascii?q?oSwj7dB1QDkwAU/naLLhQxBie7o2LZCTxuFE/vY0b2/el5snO7QVc+zxuWYE?=
 =?us-ascii?q?15y7q15hkViOSES/wN2LIEtzohqzRyHFqk3NLZFcCApwx/c6VYet494U5L1W?=
 =?us-ascii?q?betwxjIJOsNbtiiUQdcwRqpUPhzQ97CoNensQwrnMq1BJ4KbiE31NZazOYwZ?=
 =?us-ascii?q?fwN6XVKmn3+xCvcbTW2lDF0NuN/KcA8vE4pEvivA2zEUoi6XpngJFp1C6374?=
 =?us-ascii?q?7HHUIpWpL4T0gz+gIy87rTeSQsz5jf1XRxP625qHrJ0pQiA+5zjl6ERPIXZK?=
 =?us-ascii?q?eFEhLiVtYXDNW0KfA73l2uYg8AMchM+6MuecCrbf2L3OisJuk22HqCrkBiqN?=
 =?us-ascii?q?R500SR529/R/TO0pIt3f6VxE2EWi36gVPntdr4z8QMXTgPGiKazi/+CcYFfq?=
 =?us-ascii?q?Rvea4TAHqqZsiwwc9zwZXqXigcvGWOT3cH3tK5MU6JYlj82xBA/VgGqnyg3y?=
 =?us-ascii?q?2jxnp7lC9/6uLV5wnn6MeneBscMXNQX0FmjEzwOs7s1pYdRkfiJ1wSsTKOxg?=
 =?us-ascii?q?P2xrNQub9kB23SWltTOXCvaWZ4Xf30/piFY8gHypQouCNMXeL0NVKdSri7oR?=
 =?us-ascii?q?wa2iX4Em12zzk9cDersZz92Rd9jTTZZFV+oWGRUsZ3xl+L59HRXvVW2TkuTy?=
 =?us-ascii?q?lijjzWG136OMOmq5Hcq5rfqf25H0KoUJFaOX3zwIWPqSq9oG5nGxuym9iy39?=
 =?us-ascii?q?ngDwV8yib4ysNjEyPF6hTkNM2j9a2/PPkvW05yHl7no554H4ZkiIorrJcZ3H?=
 =?us-ascii?q?UbwJKP8ixUv330NIBgxa/mbHcLDQUOytrR7RmtjFZvNVqV1on5UTOb2cInaN?=
 =?us-ascii?q?6kNDBFkhkh5txHXf/HpIdPmjF49x/h91rc?=
X-IPAS-Result: =?us-ascii?q?A2C3BQCNpPla/wHyM5BcGwEBAQEDAQEBCQEBAYMYK4FcK?=
 =?us-ascii?q?INylHJFAQEBAQEBBn8pdRqVKjYBhEACgxEhOBQBAgEBAQEBAQIBayiCNSQBg?=
 =?us-ascii?q?k4BAQEBAyMEYgsRAwECAQICJgICTwgGAQwGAgEBgl9AgXQNqmSBaTODeAEBX?=
 =?us-ascii?q?oNlgieBCYccgQyBB4EPI4IzNYFUhh+CVAKHFxkIhGCBIIp+CY5LBoxvkggzI?=
 =?us-ascii?q?YFSKwgCGAghDzuCQ4IgF41hAVEjMHoBAY9tAQE?=
Subject: Re: [PATCH 10/23] LSM: Infrastructure management of the inode
 security
To: Casey Schaufler <casey@schaufler-ca.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
 <fd3c36e4-6e75-4eec-afdf-a493889c696f@schaufler-ca.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a38fb118-8c72-e18d-e55a-48fdc40e21f4@tycho.nsa.gov>
Date: Mon, 14 May 2018 11:04:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <fd3c36e4-6e75-4eec-afdf-a493889c696f@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/10/2018 08:53 PM, Casey Schaufler wrote:
> From: Casey Schaufler <casey@schaufler-ca.com>
> Date: Thu, 10 May 2018 14:23:27 -0700
> Subject: [PATCH 10/23] LSM: Infrastructure management of the inode security
>  blob
> 
> Move management of the inode->i_security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h         |  3 ++
>  security/security.c               | 85 +++++++++++++++++++++++++++++++++++++--
>  security/selinux/hooks.c          | 32 +--------------
>  security/selinux/include/objsec.h |  5 +--
>  security/smack/smack_lsm.c        | 70 +++++---------------------------
>  5 files changed, 99 insertions(+), 96 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 3ba96e406827..a935ab92906d 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2017,6 +2017,7 @@ struct security_hook_list {
>  struct lsm_blob_sizes {
>  	int	lbs_cred;
>  	int	lbs_file;
> +	int	lbs_inode;
>  	int	lbs_task;
>  };
>  
> @@ -2080,10 +2081,12 @@ static inline void loadpin_add_hooks(void) { };
>  #endif
>  
>  extern int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
> +extern int lsm_inode_alloc(struct inode *inode);
>  
>  #ifdef CONFIG_SECURITY
>  void lsm_early_cred(struct cred *cred);
>  void lsm_early_task(struct task_struct *task);
> +void lsm_early_inode(struct inode *inode);
>  #endif
>  
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/security.c b/security/security.c
> index b414186ad45f..02df9b608b7e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -41,6 +41,7 @@ struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
>  
>  static struct kmem_cache *lsm_file_cache;
> +static struct kmem_cache *lsm_inode_cache;
>  
>  char *lsm_names;
>  static struct lsm_blob_sizes blob_sizes;
> @@ -98,6 +99,10 @@ int __init security_init(void)
>  		lsm_file_cache = kmem_cache_create("lsm_file_cache",
>  						   blob_sizes.lbs_file, 0,
>  						   SLAB_PANIC, NULL);
> +	if (blob_sizes.lbs_inode)
> +		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
> +						    blob_sizes.lbs_inode, 0,
> +						    SLAB_PANIC, NULL);
>  	/*
>  	 * The second call to a module specific init function
>  	 * adds hooks to the hook lists and does any other early
> @@ -108,8 +113,9 @@ int __init security_init(void)
>  #ifdef CONFIG_SECURITY_LSM_DEBUG
>  	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
>  	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
> +	pr_info("LSM: inode blob size      = %d\n", blob_sizes.lbs_inode);
>  	pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
> -#endif
> +#endif /* CONFIG_SECURITY_LSM_DEBUG */
>  
>  	return 0;
>  }
> @@ -285,6 +291,13 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
>  	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
>  	lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
>  	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
> +	/*
> +	 * The inode blob gets an rcu_head in addition to
> +	 * what the modules might need.
> +	 */
> +	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
> +		blob_sizes.lbs_inode = sizeof(struct rcu_head);
> +	lsm_set_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
>  }
>  
>  /**
> @@ -348,6 +361,46 @@ void lsm_early_task(struct task_struct *task)
>  		panic("%s: Early task alloc failed.\n", __func__);
>  }
>  
> +/**
> + * lsm_inode_alloc - allocate a composite inode blob
> + * @inode: the inode that needs a blob
> + *
> + * Allocate the inode blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +int lsm_inode_alloc(struct inode *inode)
> +{
> +	if (!lsm_inode_cache) {
> +		inode->i_security = NULL;
> +		return 0;
> +	}
> +
> +	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, GFP_KERNEL);

Should be GFP_NOFS (and was that way in SELinux and Smack).

> +	if (inode->i_security == NULL)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +/**
> + * lsm_early_inode - during initialization allocate a composite inode blob
> + * @inode: the inode that needs a blob
> + *
> + * Allocate the inode blob for all the modules if it's not already there
> + */
> +void lsm_early_inode(struct inode *inode)
> +{
> +	int rc;
> +
> +	if (inode == NULL)
> +		panic("%s: NULL inode.\n", __func__);
> +	if (inode->i_security != NULL)
> +		return;
> +	rc = lsm_inode_alloc(inode);
> +	if (rc)
> +		panic("%s: Early inode alloc failed.\n", __func__);
> +}
> +
>  /*
>   * Hook list operation macros.
>   *
> @@ -594,14 +647,40 @@ EXPORT_SYMBOL(security_sb_parse_opts_str);
>  
>  int security_inode_alloc(struct inode *inode)
>  {
> -	inode->i_security = NULL;
> -	return call_int_hook(inode_alloc_security, 0, inode);
> +	int rc = lsm_inode_alloc(inode);
> +
> +	if (unlikely(rc))
> +		return rc;
> +	rc = call_int_hook(inode_alloc_security, 0, inode);
> +	if (unlikely(rc))
> +		security_inode_free(inode);
> +	return rc;
> +}
> +
> +static void inode_free_by_rcu(struct rcu_head *head)
> +{
> +	/*
> +	 * The rcu head is at the start of the inode blob
> +	 */
> +	kmem_cache_free(lsm_inode_cache, head);
>  }
>  
>  void security_inode_free(struct inode *inode)
>  {
>  	integrity_inode_free(inode);
>  	call_void_hook(inode_free_security, inode);
> +	/*
> +	 * The inode may still be referenced in a path walk and
> +	 * a call to security_inode_permission() can be made
> +	 * after inode_free_security() is called. Ideally, the VFS
> +	 * wouldn't do this, but fixing that is a much harder
> +	 * job. For now, simply free the i_security via RCU, and
> +	 * leave the current inode->i_security pointer intact.
> +	 * The inode will be freed after the RCU grace period too.
> +	 */
> +	if (inode->i_security)
> +		call_rcu((struct rcu_head *)inode->i_security,
> +				inode_free_by_rcu);
>  }
>  
>  int security_dentry_init_security(struct dentry *dentry, int mode,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index baefd36b44df..493328a1c789 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -148,8 +148,6 @@ static int __init checkreqprot_setup(char *str)
>  }
>  __setup("checkreqprot=", checkreqprot_setup);
>  
> -static struct kmem_cache *sel_inode_cache;
> -
>  /**
>   * selinux_secmark_enabled - Check to see if SECMARK is currently enabled
>   *
> @@ -245,13 +243,9 @@ static inline u32 task_sid(const struct task_struct *task)
>  
>  static int inode_alloc_security(struct inode *inode)
>  {
> -	struct inode_security_struct *isec;
> +	struct inode_security_struct *isec = selinux_inode(inode);
>  	u32 sid = current_sid();
>  
> -	isec = kmem_cache_zalloc(sel_inode_cache, GFP_NOFS);
> -	if (!isec)
> -		return -ENOMEM;
> -
>  	spin_lock_init(&isec->lock);
>  	INIT_LIST_HEAD(&isec->list);
>  	isec->inode = inode;
> @@ -259,7 +253,6 @@ static int inode_alloc_security(struct inode *inode)
>  	isec->sclass = SECCLASS_FILE;
>  	isec->task_sid = sid;
>  	isec->initialized = LABEL_INVALID;
> -	inode->i_security = isec;
>  
>  	return 0;
>  }
> @@ -338,14 +331,6 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
>  	return selinux_inode(inode);
>  }
>  
> -static void inode_free_rcu(struct rcu_head *head)
> -{
> -	struct inode_security_struct *isec;
> -
> -	isec = container_of(head, struct inode_security_struct, rcu);
> -	kmem_cache_free(sel_inode_cache, isec);
> -}
> -
>  static void inode_free_security(struct inode *inode)
>  {
>  	struct inode_security_struct *isec = selinux_inode(inode);
> @@ -366,17 +351,6 @@ static void inode_free_security(struct inode *inode)
>  		list_del_init(&isec->list);
>  		spin_unlock(&sbsec->isec_lock);
>  	}
> -
> -	/*
> -	 * The inode may still be referenced in a path walk and
> -	 * a call to selinux_inode_permission() can be made
> -	 * after inode_free_security() is called. Ideally, the VFS
> -	 * wouldn't do this, but fixing that is a much harder
> -	 * job. For now, simply free the i_security via RCU, and
> -	 * leave the current inode->i_security pointer intact.
> -	 * The inode will be freed after the RCU grace period too.
> -	 */
> -	call_rcu(&isec->rcu, inode_free_rcu);
>  }
>  
>  static int file_alloc_security(struct file *file)
> @@ -6794,6 +6768,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
>  struct lsm_blob_sizes selinux_blob_sizes = {
>  	.lbs_cred = sizeof(struct task_security_struct),
>  	.lbs_file = sizeof(struct file_security_struct),
> +	.lbs_inode = sizeof(struct inode_security_struct),
>  };
>  
>  static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> @@ -7061,9 +7036,6 @@ static __init int selinux_init(void)
>  
>  	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
>  
> -	sel_inode_cache = kmem_cache_create("selinux_inode_security",
> -					    sizeof(struct inode_security_struct),
> -					    0, SLAB_PANIC, NULL);
>  	avc_init();
>  
>  	avtab_cache_init();
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 168a96104fa0..60d109caaeef 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -59,10 +59,7 @@ enum label_initialized {
>  
>  struct inode_security_struct {
>  	struct inode *inode;	/* back pointer to inode object */
> -	union {
> -		struct list_head list;	/* list of inode_security_struct */
> -		struct rcu_head rcu;	/* for freeing the inode_security_struct */
> -	};
> +	struct list_head list;	/* list of inode_security_struct */
>  	u32 task_sid;		/* SID of creating task */
>  	u32 sid;		/* SID of this object */
>  	u16 sclass;		/* security class of this object */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index b9db97470e06..cfabb9f5cc9b 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -287,24 +287,18 @@ static struct smack_known *smk_fetch(const char *name, struct inode *ip,
>  }
>  
>  /**
> - * new_inode_smack - allocate an inode security blob
> + * init_inode_smack - initialize an inode security blob
> + * @isp: the blob to initialize
>   * @skp: a pointer to the Smack label entry to use in the blob
>   *
> - * Returns the new blob or NULL if there's no memory available
>   */
> -static struct inode_smack *new_inode_smack(struct smack_known *skp)
> +static void init_inode_smack(struct inode *inode, struct smack_known *skp)
>  {
> -	struct inode_smack *isp;
> -
> -	isp = kmem_cache_zalloc(smack_inode_cache, GFP_NOFS);
> -	if (isp == NULL)
> -		return NULL;
> +	struct inode_smack *isp = smack_inode(inode);
>  
>  	isp->smk_inode = skp;
>  	isp->smk_flags = 0;
>  	mutex_init(&isp->smk_lock);
> -
> -	return isp;
>  }
>  
>  /**
> @@ -823,17 +817,13 @@ static int smack_set_mnt_opts(struct super_block *sb,
>  	/*
>  	 * Initialize the root inode.
>  	 */
> -	isp = smack_inode(inode);
> -	if (isp == NULL) {
> -		isp = new_inode_smack(sp->smk_root);
> -		if (isp == NULL)
> -			return -ENOMEM;
> -		inode->i_security = isp;
> -	} else
> -		isp->smk_inode = sp->smk_root;
> +	lsm_early_inode(inode);
> +	init_inode_smack(inode, sp->smk_root);
>  
> -	if (transmute)
> +	if (transmute) {
> +		isp = smack_inode(inode);
>  		isp->smk_flags |= SMK_INODE_TRANSMUTE;
> +	}
>  
>  	return 0;
>  }
> @@ -962,48 +952,10 @@ static int smack_inode_alloc_security(struct inode *inode)
>  {
>  	struct smack_known *skp = smk_of_current();
>  
> -	inode->i_security = new_inode_smack(skp);
> -	if (inode->i_security == NULL)
> -		return -ENOMEM;
> +	init_inode_smack(inode, skp);
>  	return 0;
>  }
>  
> -/**
> - * smack_inode_free_rcu - Free inode_smack blob from cache
> - * @head: the rcu_head for getting inode_smack pointer
> - *
> - *  Call back function called from call_rcu() to free
> - *  the i_security blob pointer in inode
> - */
> -static void smack_inode_free_rcu(struct rcu_head *head)
> -{
> -	struct inode_smack *issp;
> -
> -	issp = container_of(head, struct inode_smack, smk_rcu);
> -	kmem_cache_free(smack_inode_cache, issp);
> -}
> -
> -/**
> - * smack_inode_free_security - free an inode blob using call_rcu()
> - * @inode: the inode with a blob
> - *
> - * Clears the blob pointer in inode using RCU
> - */
> -static void smack_inode_free_security(struct inode *inode)
> -{
> -	struct inode_smack *issp = smack_inode(inode);
> -
> -	/*
> -	 * The inode may still be referenced in a path walk and
> -	 * a call to smack_inode_permission() can be made
> -	 * after smack_inode_free_security() is called.
> -	 * To avoid race condition free the i_security via RCU
> -	 * and leave the current inode->i_security pointer intact.
> -	 * The inode will be freed after the RCU grace period too.
> -	 */
> -	call_rcu(&issp->smk_rcu, smack_inode_free_rcu);
> -}
> -
>  /**
>   * smack_inode_init_security - copy out the smack from an inode
>   * @inode: the newly created inode
> @@ -4589,6 +4541,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
>  struct lsm_blob_sizes smack_blob_sizes = {
>  	.lbs_cred = sizeof(struct task_smack),
>  	.lbs_file = sizeof(struct smack_known *),
> +	.lbs_inode = sizeof(struct inode_smack),
>  };
>  
>  static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
> @@ -4607,7 +4560,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(bprm_set_creds, smack_bprm_set_creds),
>  
>  	LSM_HOOK_INIT(inode_alloc_security, smack_inode_alloc_security),
> -	LSM_HOOK_INIT(inode_free_security, smack_inode_free_security),
>  	LSM_HOOK_INIT(inode_init_security, smack_inode_init_security),
>  	LSM_HOOK_INIT(inode_link, smack_inode_link),
>  	LSM_HOOK_INIT(inode_unlink, smack_inode_unlink),
> 

