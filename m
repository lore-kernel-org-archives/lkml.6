Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BCDECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 17:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF5A21479
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 17:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UN4lJnHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF5A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeIWXHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 19:07:51 -0400
Received: from sonic312-28.consmr.mail.gq1.yahoo.com ([98.137.69.209]:39731
        "EHLO sonic312-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726223AbeIWXHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 19:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537722581; bh=GzkylycNNpDwgwWv64KvmwrIyWKI30DTaP7DolkP/SM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=UN4lJnHavJYIkuC62a5JSz4nx+1O88X/EpDjhFzEGlWQ/zd+Z5hjmcmWFSEMlt6a+DTHXoITSMV5iGjk/Bg3aQhkP5/kkTKQMbNssiLPZdmAag+eMF6gLUOyYKOb3IZpDPYm03068PFII1/Yly6VUbs74fVBXv9iXEdKr0TC6nCiMv/H6jKxErmGC9/C5XZKnXQ2Evr2CarWSNYOmKoTtuDeye1mkUdcxdDzRWJhfwBVf3ohL6zDoGwnGGUMZ4xhdda7XW6bY4D6x99xxWvaTRgmj3Tqs7B7z57a1dZgCc/iep3msG1Wer9foI9mx1Dnc5PgEVLTeXpx4jnJs2zPuQ==
X-YMail-OSG: DcLGYocVM1mq5r7Shq6CWxMnD3VqJURl2p39K5.BKOcYOE1_tepQEn6vDoex0NL
 aaLb0s5rTrdUcjz9dLGqoog.ysOFSA1_osN3ILAYkFj7blKjw.oULi8UB8GxNKswgLNg5hU3DG9K
 MmCzjrY.xdxGoex4eJSpqt4StqVr7OXq6vnHlJoPT1aoP8rAJbzVh5TYb2YOwKYKGT2ep6c7UMgU
 sqEtK1PLYFOsrlvOR.TS6royVgsOH4jfgry9j5atDxA45uC.es5BqX040qXTdk4ua17zNztavpyw
 wOOSOWRZq3JCpU6hCTHHPlKt7ixWtBGkJmubn5NWLM78e9JXCZcZ3lFBNYvC9rL8zzW1oPWEbd_5
 cEL4xoM3JNSeWRiOGQ6b1yLdPxob6RETBdpjK8oHfzd7HOUtVc5ikEYwyGq5wnMkou9kuCjVbD59
 BKBfco1DlF16a39nBrMpJxFvdGJy8gvnNvkVISbLW.0m_MO0mInFKwBWRFXe3YfcJ5FCL7cnBhte
 iKy6JfpPs2KWQ45YHh9onPWkuAeD6wwyIq83qbjK7O5pu9XUnXvyWCRWwLLr871PfCsYdeo8w7W0
 jcFCS_MDnNVLzlmWuTfMPgbPg3ssnJkCNLKtz5FAAn.ijhQh8N1q.Vl6gFctiPh2sNlfR1LkhX2Y
 wJXT_hvIuswpNaG2sOesj53l94f7hZsNpu14_GDiFSwvWOjUx_.fYNuucdjqidi8cEBVPfTvF8TY
 psQzrEePnwjRHFx4gimpxMet9Ys3GY2MFkYRuyE7ofdTX0drcu8OGacF6lgJth19PqMHL7Y6bxJs
 gBQYOhPFb3cncW1tDyrVyB7hVa0ilhpakAv0Na4De7o6aNSst2RKCYzD38XrSH2A3t9byuPkuPeh
 3fP_aYKnmo.X2u5.8_z_Jt87uwNPVyffB9UNx.8OlHb.ylDnwWVFNh5kEahaTxrGGFHtmni_mlZY
 .FRgQUq2AdrDPCLffw3hndzHtOaAQy_FyrG5SDe8Fj9oeScoppQCQXvr07XoVTRIb_7Dxm8rgArC
 imcu8TM0MnuRarKeKq8tEyg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Sun, 23 Sep 2018 17:09:41 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b3a78740edce3b822b2599ccdf9f6bb5;
          Sun, 23 Sep 2018 17:09:38 +0000 (UTC)
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and Landlock
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
 <680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
 <CAGXu5j+7FpFDNuOowdHzJ5RXgfETQMv=Fe-EU1gWo+nWK+goZA@mail.gmail.com>
 <39457e79-3816-824b-6b4d-89d21b03f9ce@i-love.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b209d4b8-81a5-30aa-f4d1-9372bbb1b842@schaufler-ca.com>
Date:   Sun, 23 Sep 2018 10:09:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <39457e79-3816-824b-6b4d-89d21b03f9ce@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/2018 8:59 AM, Tetsuo Handa wrote:
> On 2018/09/23 11:43, Kees Cook wrote:
>>>> I'm excited about getting this landed!
>>> Soon. Real soon. I hope. I would very much like for
>>> someone from the SELinux camp to chime in, especially on
>>> the selinux_is_enabled() removal.
>> Agreed.
>>
> This patchset from Casey lands before the patchset from Kees, doesn't it?

That is up for negotiation. We may end up combining them.

> OK, a few comments (if I didn't overlook something).
>
>   lsm_early_cred()/lsm_early_task() are called from only __init functions.

True.

>   lsm_cred_alloc()/lsm_file_alloc() are called from only security/security.c .

Also true.

>   lsm_early_inode() should be avoided because it is not appropriate to
>   call panic() when lsm_early_inode() is called after __init phase.

You're correct. In fact, lsm_early_inode() isn't needed at all
until multiple inode using modules are supported.

>   Since all free hooks are called when one of init hooks failed, each
>   free hook needs to check whether init hook was called. An example is
>   inode_free_security() in security/selinux/hooks.c (but not addressed in
>   this patch).

I *think* that selinux_inode_free_security() is safe in this
case because the blob will be zeroed, hence isec->list will
be NULL.

>   This patchset might fatally prevent LKM-based LSM modules, for LKM-based
>   LSMs cannot count on lsm_*_alloc() because size for lsm_*_alloc() cannot
>   be updated upon loading LKM-based LSMs.

LKM based security modules will require dynamically sized blobs.
These can be added to the scheme used here. Each blob would get a
header identifying the modules for which it contains data. When an
LKM is registered if has to declare it's blob space requirements
and gets back the offsets. All alloc operations have to put their
marks in the header. All LKM blob users have to check that the blob
they are looking at has the required data.

module_cred(struct cred *cred) {
	return cred->security + module_blob_sizes.lbs_cred;
}

becomes

module_cred(struct cred *cred) {
	if (blob_includes(module_id))
		return cred->security + module_blob_sizes.lbs_cred;
	return NULL;
}

and the calling code needs to accept a NULL return.
Blobs can never get smaller because readjusting the offsets
isn't going to work, so unloading an LKM security module isn't
going to be as complete as you might like. There may be a way
around this if you unload all the LKM modules, but that's a
special case and there may be dragon lurking in the mist.

>  If security_file_free() is called
>   regardless of whether lsm_file_cache is defined, LKM-based LSMs can be
>   loaded using current behavior (apart from the fact that legitimate
>   interface for appending to security_hook_heads is currently missing).
>   How do you plan to handle LKM-based LSMs?

My position all along has been that I don't plan to handle LKM
based LSMs, but that I won't do anything to prevent someone else
from adding them later. I believe that I've done that. Several
designs, including a separate list for dynamically loaded modules
have been proposed. I think some of those would work.

>  include/linux/lsm_hooks.h  |    6 ++----
>  security/security.c        |   31 ++++++-------------------------
>  security/smack/smack_lsm.c |    8 +++++++-
>  3 files changed, 15 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 7e8b32f..8014614 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2095,13 +2095,11 @@ static inline void __init yama_add_hooks(void) { }
>  static inline void loadpin_add_hooks(void) { };
>  #endif
>  
> -extern int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
>  extern int lsm_inode_alloc(struct inode *inode);
>  
>  #ifdef CONFIG_SECURITY
> -void lsm_early_cred(struct cred *cred);
> -void lsm_early_inode(struct inode *inode);
> -void lsm_early_task(struct task_struct *task);
> +void __init lsm_early_cred(struct cred *cred);
> +void __init lsm_early_task(struct task_struct *task);
>  #endif
>  
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/security.c b/security/security.c
> index e7c85060..341e8df 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -267,7 +267,7 @@ int unregister_lsm_notifier(struct notifier_block *nb)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
> +static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
>  {
>  	if (blob_sizes.lbs_cred == 0) {
>  		cred->security = NULL;
> @@ -286,7 +286,7 @@ int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
>   *
>   * Allocate the cred blob for all the modules if it's not already there
>   */
> -void lsm_early_cred(struct cred *cred)
> +void __init lsm_early_cred(struct cred *cred)
>  {
>  	int rc;
>  
> @@ -344,7 +344,7 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -int lsm_file_alloc(struct file *file)
> +static int lsm_file_alloc(struct file *file)
>  {
>  	if (!lsm_file_cache) {
>  		file->f_security = NULL;
> @@ -379,25 +379,6 @@ int lsm_inode_alloc(struct inode *inode)
>  }
>  
>  /**
> - * lsm_early_inode - during initialization allocate a composite inode blob
> - * @inode: the inode that needs a blob
> - *
> - * Allocate the inode blob for all the modules if it's not already there
> - */
> -void lsm_early_inode(struct inode *inode)
> -{
> -	int rc;
> -
> -	if (inode == NULL)
> -		panic("%s: NULL inode.\n", __func__);
> -	if (inode->i_security != NULL)
> -		return;
> -	rc = lsm_inode_alloc(inode);
> -	if (rc)
> -		panic("%s: Early inode alloc failed.\n", __func__);
> -}
> -
> -/**
>   * lsm_task_alloc - allocate a composite task blob
>   * @task: the task that needs a blob
>   *
> @@ -466,7 +447,7 @@ int lsm_msg_msg_alloc(struct msg_msg *mp)
>   *
>   * Allocate the task blob for all the modules if it's not already there
>   */
> -void lsm_early_task(struct task_struct *task)
> +void __init lsm_early_task(struct task_struct *task)
>  {
>  	int rc;
>  
> @@ -1202,11 +1183,11 @@ void security_file_free(struct file *file)
>  {
>  	void *blob;
>  
> +	call_void_hook(file_free_security, file);
> +
>  	if (!lsm_file_cache)
>  		return;
>  
> -	call_void_hook(file_free_security, file);
> -

Why does this make sense? If the lsm_file_cache isn't
initialized you can't have allocated any file blobs,
no module can have initialized a file blob, hence there
can be nothing for the module to do.

>  	blob = file->f_security;
>  	file->f_security = NULL;
>  	kmem_cache_free(lsm_file_cache, blob);
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 7843004..b0b4045 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -750,6 +750,13 @@ static int smack_set_mnt_opts(struct super_block *sb,
>  	if (sp->smk_flags & SMK_SB_INITIALIZED)
>  		return 0;
>  
> +	if (inode->i_security == NULL) {
> +		int rc = lsm_inode_alloc(inode);
> +
> +		if (rc)
> +			return rc;
> +	}
> +
>  	if (!smack_privileged(CAP_MAC_ADMIN)) {
>  		/*
>  		 * Unprivileged mounts don't get to specify Smack values.
> @@ -818,7 +825,6 @@ static int smack_set_mnt_opts(struct super_block *sb,
>  	/*
>  	 * Initialize the root inode.
>  	 */
> -	lsm_early_inode(inode);
>  	init_inode_smack(inode, sp->smk_root);
>  
>  	if (transmute) {

