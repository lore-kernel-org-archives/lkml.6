Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2204151-1521842089-2-984795570883191366
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521842088; b=lqqStN5UhWLrH9l7uumBa+VhY339ovEfmkZmcoZmRw6D1xi
    ksdDidstaXrVdTeHsFTL7R9ureU0Y8IE4QfTeDPHrxVxrO8d6kA3ydskWl3NxLVr
    S0BbKDO+a2uEd/efOoKrNCTQYBM2owIneq0NjlSkdka0Qjh2XkwZyv0xzI993HoK
    nfT5u4iRdOacRiSMsvtr81uW0oTlW4uxcE/OCsadntTmtfrwx3EbSTi0OQHVYjHz
    4189nHI+gnCShJRAR9LcSgWP1vmnVjgqbtTr3dK0R+31Nc6XuT0x2IghHqngqp83
    KTxh5L571d1e/vCNQK8jFHTAAoEZnyLCvKyIKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521842088; bh=SAt+RVEXwLNSF1ahstiDUjqMYAFmbO9sewGlnwTnIG0=; b=W
    HbooboLeDvmbLnbB74R3oz3TukS/URJiqmhNaEwFoLQqwTDL2HNHIUv9y37nZ1C8
    IWGBrFSDQesl7xI4SdiqgNS3H/MR3+HF2UlTlvNhsMc+ZLb2ruHNEGp3hb8jIQO4
    Wx3QQQG9sQfFuBEQ5hfE1gQToXrdK/yHOAVy5DNZ+qu5f33Puy7HtH9tS+xK8g2k
    21lnFwIdxzyjLTAdpofQdaeAh8MHC89CXM55tk+EoGrZ0IUId+ZxTroXtwlVLh2G
    fcJCaLV6Mpdrsu+5WNlVdef/gKn2yf19t/CTEuu7Cm1Zgd7vYcMpZLNjTJRnDER3
    weoVn/XrGOyYpNkp2rYPA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=lEnpfX5Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=schaufler-ca.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=lEnpfX5Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=schaufler-ca.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeCWVyo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 17:54:44 -0400
Received: from sonic309-20.consmr.mail.bf2.yahoo.com ([74.6.129.194]:37080
        "EHLO sonic309-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751981AbeCWVyo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 17:54:44 -0400
X-YMail-OSG: 7rHkrB8VM1kI3hyWdciFS_37zg9D3iU51w7Tc8gtTbOsiCO64PWpyJym1zTQkRD
 Pkdd_yOEKhxO6Nl90EkiB7saVeD4iyEv7Hmqe0_wnKfzDvIEv4sbSxRV_QqWV2uIOZlMy3BfXmx9
 OEURYlzLg6y4WDF9H5llbKH4gdl2Wtq_T5rpH2aJohCEDdlG7XThORTy7wCxGaU_VpxcC7oLIjhv
 IoB9S6hmt9y0S7CyiCE1IZDmmnuX7_Dk1_BqLePCQByH.NNoYLgNex226hfMci0LeCJQaxe7litC
 ZiS2HrzUGJDDH1olbulqw5uOcmXIA_o.L6UXy8z1wUx4r2UDwv4PWa92zH4xHsvg5OMRYesIf0qV
 bWULSygmtgUFQe5I_BWq9eKZwoFTCNhSgLsMzapXQRT9_iq9vObycBc.VD7L8_AJNogdJ47PzOj0
 iRoGUsGNcCXCJ0hltjHJ4Kh9pI7XFzQwYJpj9xocCafcafbG7AbPU4WPHIY4UMe_IIJvxMs9bbTl
 bPJ0qLFl0UDjj0yBvgN8BA9aT
Subject: Re: [REVIEW][PATCH 02/11] shm/security: Pass kern_ipc_perm not
 shmid_kernel into the shm security hooks
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
References: <87vadmobdw.fsf_-_@xmission.com>
 <20180323191614.32489-2-ebiederm@xmission.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <29520d7d-21c7-c291-d321-f70b98c8025f@schaufler-ca.com>
Date: Fri, 23 Mar 2018 14:54:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323191614.32489-2-ebiederm@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/23/2018 12:16 PM, Eric W. Biederman wrote:
> All of the implementations of security hooks that take shmid_kernel only
> access shm_perm the struct kern_ipc_perm member.  This means the
> dependencies of the shm security hooks can be simplified by passing
> the kern_ipc_perm member of shmid_kernel..
>
> Making this change will allow struct shmid_kernel to become private to ipc/shm.c.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  include/linux/lsm_hooks.h  | 10 +++++-----
>  include/linux/security.h   | 21 ++++++++++-----------
>  ipc/shm.c                  | 17 +++++++----------
>  security/security.c        | 10 +++++-----
>  security/selinux/hooks.c   | 28 ++++++++++++++--------------
>  security/smack/smack_lsm.c | 22 +++++++++++-----------

Can I reference the comments I made in PATCH 01 of this set
regarding the Smack changes? The problem in all of your changes
is the same. You aren't preserving the naming conventions, and
you've left in some code that is just silly.
 

>  6 files changed, 52 insertions(+), 56 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index e4a94863a88c..cac7a8082c43 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1585,11 +1585,11 @@ union security_list_options {
>  				struct task_struct *target, long type,
>  				int mode);
>  
> -	int (*shm_alloc_security)(struct shmid_kernel *shp);
> -	void (*shm_free_security)(struct shmid_kernel *shp);
> -	int (*shm_associate)(struct shmid_kernel *shp, int shmflg);
> -	int (*shm_shmctl)(struct shmid_kernel *shp, int cmd);
> -	int (*shm_shmat)(struct shmid_kernel *shp, char __user *shmaddr,
> +	int (*shm_alloc_security)(struct kern_ipc_perm *shp);
> +	void (*shm_free_security)(struct kern_ipc_perm *shp);
> +	int (*shm_associate)(struct kern_ipc_perm *shp, int shmflg);
> +	int (*shm_shmctl)(struct kern_ipc_perm *shp, int cmd);
> +	int (*shm_shmat)(struct kern_ipc_perm *shp, char __user *shmaddr,
>  				int shmflg);
>  
>  	int (*sem_alloc_security)(struct kern_ipc_perm *sma);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index fa7adac4b99a..f390755808ea 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -49,7 +49,6 @@ struct qstr;
>  struct iattr;
>  struct fown_struct;
>  struct file_operations;
> -struct shmid_kernel;
>  struct msg_msg;
>  struct msg_queue;
>  struct xattr;
> @@ -362,11 +361,11 @@ int security_msg_queue_msgsnd(struct msg_queue *msq,
>  			      struct msg_msg *msg, int msqflg);
>  int security_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
>  			      struct task_struct *target, long type, int mode);
> -int security_shm_alloc(struct shmid_kernel *shp);
> -void security_shm_free(struct shmid_kernel *shp);
> -int security_shm_associate(struct shmid_kernel *shp, int shmflg);
> -int security_shm_shmctl(struct shmid_kernel *shp, int cmd);
> -int security_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr, int shmflg);
> +int security_shm_alloc(struct kern_ipc_perm *shp);
> +void security_shm_free(struct kern_ipc_perm *shp);
> +int security_shm_associate(struct kern_ipc_perm *shp, int shmflg);
> +int security_shm_shmctl(struct kern_ipc_perm *shp, int cmd);
> +int security_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr, int shmflg);
>  int security_sem_alloc(struct kern_ipc_perm *sma);
>  void security_sem_free(struct kern_ipc_perm *sma);
>  int security_sem_associate(struct kern_ipc_perm *sma, int semflg);
> @@ -1077,26 +1076,26 @@ static inline int security_msg_queue_msgrcv(struct msg_queue *msq,
>  	return 0;
>  }
>  
> -static inline int security_shm_alloc(struct shmid_kernel *shp)
> +static inline int security_shm_alloc(struct kern_ipc_perm *shp)
>  {
>  	return 0;
>  }
>  
> -static inline void security_shm_free(struct shmid_kernel *shp)
> +static inline void security_shm_free(struct kern_ipc_perm *shp)
>  { }
>  
> -static inline int security_shm_associate(struct shmid_kernel *shp,
> +static inline int security_shm_associate(struct kern_ipc_perm *shp,
>  					 int shmflg)
>  {
>  	return 0;
>  }
>  
> -static inline int security_shm_shmctl(struct shmid_kernel *shp, int cmd)
> +static inline int security_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
>  {
>  	return 0;
>  }
>  
> -static inline int security_shm_shmat(struct shmid_kernel *shp,
> +static inline int security_shm_shmat(struct kern_ipc_perm *shp,
>  				     char __user *shmaddr, int shmflg)
>  {
>  	return 0;
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 4643865e9171..387a786e7be1 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -181,7 +181,7 @@ static void shm_rcu_free(struct rcu_head *head)
>  							rcu);
>  	struct shmid_kernel *shp = container_of(ptr, struct shmid_kernel,
>  							shm_perm);
> -	security_shm_free(shp);
> +	security_shm_free(&shp->shm_perm);
>  	kvfree(shp);
>  }
>  
> @@ -554,7 +554,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>  	shp->mlock_user = NULL;
>  
>  	shp->shm_perm.security = NULL;
> -	error = security_shm_alloc(shp);
> +	error = security_shm_alloc(&shp->shm_perm);
>  	if (error) {
>  		kvfree(shp);
>  		return error;
> @@ -635,10 +635,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>   */
>  static inline int shm_security(struct kern_ipc_perm *ipcp, int shmflg)
>  {
> -	struct shmid_kernel *shp;
> -
> -	shp = container_of(ipcp, struct shmid_kernel, shm_perm);
> -	return security_shm_associate(shp, shmflg);
> +	return security_shm_associate(ipcp, shmflg);
>  }
>  
>  /*
> @@ -835,7 +832,7 @@ static int shmctl_down(struct ipc_namespace *ns, int shmid, int cmd,
>  
>  	shp = container_of(ipcp, struct shmid_kernel, shm_perm);
>  
> -	err = security_shm_shmctl(shp, cmd);
> +	err = security_shm_shmctl(&shp->shm_perm, cmd);
>  	if (err)
>  		goto out_unlock1;
>  
> @@ -934,7 +931,7 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
>  	if (ipcperms(ns, &shp->shm_perm, S_IRUGO))
>  		goto out_unlock;
>  
> -	err = security_shm_shmctl(shp, cmd);
> +	err = security_shm_shmctl(&shp->shm_perm, cmd);
>  	if (err)
>  		goto out_unlock;
>  
> @@ -978,7 +975,7 @@ static int shmctl_do_lock(struct ipc_namespace *ns, int shmid, int cmd)
>  	}
>  
>  	audit_ipc_obj(&(shp->shm_perm));
> -	err = security_shm_shmctl(shp, cmd);
> +	err = security_shm_shmctl(&shp->shm_perm, cmd);
>  	if (err)
>  		goto out_unlock1;
>  
> @@ -1348,7 +1345,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
>  	if (ipcperms(ns, &shp->shm_perm, acc_mode))
>  		goto out_unlock;
>  
> -	err = security_shm_shmat(shp, shmaddr, shmflg);
> +	err = security_shm_shmat(&shp->shm_perm, shmaddr, shmflg);
>  	if (err)
>  		goto out_unlock;
>  
> diff --git a/security/security.c b/security/security.c
> index d3b9aeb6b73b..77b69bd6f234 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1195,27 +1195,27 @@ int security_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
>  	return call_int_hook(msg_queue_msgrcv, 0, msq, msg, target, type, mode);
>  }
>  
> -int security_shm_alloc(struct shmid_kernel *shp)
> +int security_shm_alloc(struct kern_ipc_perm *shp)
>  {
>  	return call_int_hook(shm_alloc_security, 0, shp);
>  }
>  
> -void security_shm_free(struct shmid_kernel *shp)
> +void security_shm_free(struct kern_ipc_perm *shp)
>  {
>  	call_void_hook(shm_free_security, shp);
>  }
>  
> -int security_shm_associate(struct shmid_kernel *shp, int shmflg)
> +int security_shm_associate(struct kern_ipc_perm *shp, int shmflg)
>  {
>  	return call_int_hook(shm_associate, 0, shp, shmflg);
>  }
>  
> -int security_shm_shmctl(struct shmid_kernel *shp, int cmd)
> +int security_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
>  {
>  	return call_int_hook(shm_shmctl, 0, shp, cmd);
>  }
>  
> -int security_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr, int shmflg)
> +int security_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr, int shmflg)
>  {
>  	return call_int_hook(shm_shmat, 0, shp, shmaddr, shmflg);
>  }
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index cce994e9fc0a..14f9e6c08273 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5674,53 +5674,53 @@ static int selinux_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
>  }
>  
>  /* Shared Memory security operations */
> -static int selinux_shm_alloc_security(struct shmid_kernel *shp)
> +static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
>  	u32 sid = current_sid();
>  	int rc;
>  
> -	rc = ipc_alloc_security(&shp->shm_perm, SECCLASS_SHM);
> +	rc = ipc_alloc_security(shp, SECCLASS_SHM);
>  	if (rc)
>  		return rc;
>  
> -	isec = shp->shm_perm.security;
> +	isec = shp->security;
>  
>  	ad.type = LSM_AUDIT_DATA_IPC;
> -	ad.u.ipc_id = shp->shm_perm.key;
> +	ad.u.ipc_id = shp->key;
>  
>  	rc = avc_has_perm(sid, isec->sid, SECCLASS_SHM,
>  			  SHM__CREATE, &ad);
>  	if (rc) {
> -		ipc_free_security(&shp->shm_perm);
> +		ipc_free_security(shp);
>  		return rc;
>  	}
>  	return 0;
>  }
>  
> -static void selinux_shm_free_security(struct shmid_kernel *shp)
> +static void selinux_shm_free_security(struct kern_ipc_perm *shp)
>  {
> -	ipc_free_security(&shp->shm_perm);
> +	ipc_free_security(shp);
>  }
>  
> -static int selinux_shm_associate(struct shmid_kernel *shp, int shmflg)
> +static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
>  	u32 sid = current_sid();
>  
> -	isec = shp->shm_perm.security;
> +	isec = shp->security;
>  
>  	ad.type = LSM_AUDIT_DATA_IPC;
> -	ad.u.ipc_id = shp->shm_perm.key;
> +	ad.u.ipc_id = shp->key;
>  
>  	return avc_has_perm(sid, isec->sid, SECCLASS_SHM,
>  			    SHM__ASSOCIATE, &ad);
>  }
>  
>  /* Note, at this point, shp is locked down */
> -static int selinux_shm_shmctl(struct shmid_kernel *shp, int cmd)
> +static int selinux_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
>  {
>  	int perms;
>  	int err;
> @@ -5749,11 +5749,11 @@ static int selinux_shm_shmctl(struct shmid_kernel *shp, int cmd)
>  		return 0;
>  	}
>  
> -	err = ipc_has_perm(&shp->shm_perm, perms);
> +	err = ipc_has_perm(shp, perms);
>  	return err;
>  }
>  
> -static int selinux_shm_shmat(struct shmid_kernel *shp,
> +static int selinux_shm_shmat(struct kern_ipc_perm *shp,
>  			     char __user *shmaddr, int shmflg)
>  {
>  	u32 perms;
> @@ -5763,7 +5763,7 @@ static int selinux_shm_shmat(struct shmid_kernel *shp,
>  	else
>  		perms = SHM__READ | SHM__WRITE;
>  
> -	return ipc_has_perm(&shp->shm_perm, perms);
> +	return ipc_has_perm(shp, perms);
>  }
>  
>  /* Semaphore security operations */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 0402b8c1aec1..a3398c7f32c9 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2950,9 +2950,9 @@ static void smack_msg_msg_free_security(struct msg_msg *msg)
>   *
>   * Returns a pointer to the smack value
>   */
> -static struct smack_known *smack_of_shm(struct shmid_kernel *shp)
> +static struct smack_known *smack_of_shm(struct kern_ipc_perm *shp)
>  {
> -	return (struct smack_known *)shp->shm_perm.security;
> +	return (struct smack_known *)shp->security;
>  }
>  
>  /**
> @@ -2961,9 +2961,9 @@ static struct smack_known *smack_of_shm(struct shmid_kernel *shp)
>   *
>   * Returns 0
>   */
> -static int smack_shm_alloc_security(struct shmid_kernel *shp)
> +static int smack_shm_alloc_security(struct kern_ipc_perm *shp)
>  {
> -	struct kern_ipc_perm *isp = &shp->shm_perm;
> +	struct kern_ipc_perm *isp = shp;
>  	struct smack_known *skp = smk_of_current();
>  
>  	isp->security = skp;
> @@ -2976,9 +2976,9 @@ static int smack_shm_alloc_security(struct shmid_kernel *shp)
>   *
>   * Clears the blob pointer
>   */
> -static void smack_shm_free_security(struct shmid_kernel *shp)
> +static void smack_shm_free_security(struct kern_ipc_perm *shp)
>  {
> -	struct kern_ipc_perm *isp = &shp->shm_perm;
> +	struct kern_ipc_perm *isp = shp;
>  
>  	isp->security = NULL;
>  }
> @@ -2990,7 +2990,7 @@ static void smack_shm_free_security(struct shmid_kernel *shp)
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smk_curacc_shm(struct shmid_kernel *shp, int access)
> +static int smk_curacc_shm(struct kern_ipc_perm *shp, int access)
>  {
>  	struct smack_known *ssp = smack_of_shm(shp);
>  	struct smk_audit_info ad;
> @@ -2998,7 +2998,7 @@ static int smk_curacc_shm(struct shmid_kernel *shp, int access)
>  
>  #ifdef CONFIG_AUDIT
>  	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_IPC);
> -	ad.a.u.ipc_id = shp->shm_perm.id;
> +	ad.a.u.ipc_id = shp->id;
>  #endif
>  	rc = smk_curacc(ssp, access, &ad);
>  	rc = smk_bu_current("shm", ssp, access, rc);
> @@ -3012,7 +3012,7 @@ static int smk_curacc_shm(struct shmid_kernel *shp, int access)
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smack_shm_associate(struct shmid_kernel *shp, int shmflg)
> +static int smack_shm_associate(struct kern_ipc_perm *shp, int shmflg)
>  {
>  	int may;
>  
> @@ -3027,7 +3027,7 @@ static int smack_shm_associate(struct shmid_kernel *shp, int shmflg)
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smack_shm_shmctl(struct shmid_kernel *shp, int cmd)
> +static int smack_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
>  {
>  	int may;
>  
> @@ -3062,7 +3062,7 @@ static int smack_shm_shmctl(struct shmid_kernel *shp, int cmd)
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smack_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr,
> +static int smack_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr,
>  			   int shmflg)
>  {
>  	int may;

