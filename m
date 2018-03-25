Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-868544-1521936330-2-10897850162277524125
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521936329; b=mx5VVNcRVWk03SCOQtEYGz1VDPhf32Zv3786L1SEFUT/o3z
    pRejLb+SpVnPqpT+m2mUjLSfUPfaO2nctyXDNZfjT7XfEfcoBbYgsfWCAKqvQf6s
    R0NsG01a2LvYNQDydD4yuaxTjAsqIr+1MfFhAVhidVcehVcXSulGRgaAOwCUqwhM
    owbsfMRWE+2YcJ268I11KE4JAnbxWGNj48jB9xoHtSw9xifCUekwu/8B5u9TXNZ6
    X+LtsXs9Gy2133i1/ZGj0v16gBIBAaQF1Bcx8tdtNMJ+nJQTRMcSucQkskvR5aOv
    kIz8f+Y77+G0tYI3BxZFtKS952a4Y84rgoftmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521936329; bh=A/gd5VMG5J+CRCuC5SvImpcZhxRHmMZBob3H6V0jZlU=; b=K
    syFJkBwUEbr+egJHzx4DfpB9PFjP4Wgyt95iQswuCXCPSejH/Jz4Ysf/w9ZQRlLC
    whSZsiOo4poPzlBNec9pTiH1mLAylwf65VoAiUSyBOC44rDL9I/6sMEaeehkNCk/
    kRqibVjhaz/pVxdJVBnfK3W03Vy3oix7vW7bpw8rORlysZXb+ma6ldTEes0bBRRi
    qlKX3O155sB/T2w3NrkEzNVlrxRnmQT4a9jbmJOq2eGz4fsItthX+EaxoBd21VqK
    xCZpmw/p0inYyYc6AUTWIJ92gWn51MTV+VNsaNaYCua2ada3/Ep8G1m/5QY9rLaE
    qwUFiF34hsehQWz8J03WQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=lyh2J1NI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=schaufler-ca.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=lyh2J1NI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=schaufler-ca.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeCYAFQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 20:05:16 -0400
Received: from sonic309-21.consmr.mail.bf2.yahoo.com ([74.6.129.195]:36700
        "EHLO sonic309-21.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752317AbeCYAFP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 24 Mar 2018 20:05:15 -0400
X-YMail-OSG: YX1SLx0VM1l0GHJuGWXhMiFTWV.Q4krAJ04ZxUvTdZ0cjI2TlO7ReFWc9wyzTjg
 eqadY1RnUF8iFpTi7NJxVdma.efYRF85FC1PMurs9eqX0UFgz1r7Ll.o9oLidutNPf8UvcRBIYmm
 qYoqmocrh_TVVwhsmb6tkAiDv1b65k9EzIYgbumc3hU3nuUzJGxLNxxNh6Kq_bbic1ca59vYv__r
 1_kdzelFslY8XK5ZtF5RZEbOsmd3fwy06zRjvvCwFEsfHdO7Eid6hdzCq8u1jW2Yl6KDTPgQtHqD
 RgUawwJLsTMr9k8dFoHE3Tt3XGNITX5hHyRoLzA.iO5zL43J4W4O_GE4wo74UWY1nDOhwK6qz8av
 QPkvH4TqSQ9r1U9Rzc3UCSNJm73q_5O70cdPc1Arzhuc_YO1G5L8clPmLa7vMoU_gUTFyghrX.wZ
 FfmWfasXsa6HYWVVgQ5Z78cCKnFDcgluw0WM5zsWzEmL70KwnU4eDSzq2gbUbJbb.oTCXOaDjBAx
 wRCmmuT0Wn.OQP5rT1TkKOIe_
Subject: Re: [REVIEW][PATCH 13/11] ipc/smack: Tidy up from the change in type
 of the ipc security hooks
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc: esyr@redhat.com, jannh@google.com, khlebnikov@yandex-team.ru,
        linux-api@vger.kernel.org, serge.hallyn@ubuntu.com,
        linux-kernel@vger.kernel.org, prakash.sangappa@oracle.com,
        linux-security-module@vger.kernel.org, luto@kernel.org,
        oleg@redhat.com, akpm@linux-foundation.org,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <87vadzqqq6.fsf@xmission.com>
 <990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
 <877eqejowd.fsf@xmission.com>
 <3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
 <87a7v2z2qa.fsf@xmission.com> <87vadmobdw.fsf_-_@xmission.com>
 <87y3iikp1y.fsf_-_@xmission.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <80cd2fea-c9a8-4f26-acbb-e0ecb34e4e40@schaufler-ca.com>
Date: Sat, 24 Mar 2018 17:05:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87y3iikp1y.fsf_-_@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/23/2018 10:42 PM, Eric W. Biederman wrote:
> Rename the variables shp, sma, msq to isp. As that is how the code already
> refers to those variables.

Thanks. It's important to keep the code readable.

> Collapse smack_of_shm, smack_of_sem, and smack_of_msq into smack_of_ipc,
> as the three functions had become completely identical.

Thanks. Completely reasonable and correct.

> Collapse smack_shm_alloc_security, smack_sem_alloc_security and
> smack_msg_queue_alloc_security into smack_ipc_alloc_security as the
> three functions had become identical.
>
> Collapse smack_shm_free_security, smack_sem_free_security and
> smack_msg_queue_free_security into smack_ipc_free_security as the three
> functions had become identical.

This is reasonable but unprecedented. Nowhere else is the
same function used to supply multiple LSM hooks. Does anyone
out there see a reason not to do this?

> Requested-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  security/smack/smack_lsm.c | 197 +++++++++++++--------------------------------
>  1 file changed, 58 insertions(+), 139 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index d960c2ea8d79..0735b8db158b 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2945,25 +2945,24 @@ static void smack_msg_msg_free_security(struct msg_msg *msg)
>  }
>  
>  /**
> - * smack_of_shm - the smack pointer for the shm
> - * @shp: the object
> + * smack_of_ipc - the smack pointer for the ipc
> + * @isp: the object
>   *
>   * Returns a pointer to the smack value
>   */
> -static struct smack_known *smack_of_shm(struct kern_ipc_perm *shp)
> +static struct smack_known *smack_of_ipc(struct kern_ipc_perm *isp)
>  {
> -	return (struct smack_known *)shp->security;
> +	return (struct smack_known *)isp->security;
>  }
>  
>  /**
> - * smack_shm_alloc_security - Set the security blob for shm
> - * @shp: the object
> + * smack_ipc_alloc_security - Set the security blob for ipc
> + * @isp: the object
>   *
>   * Returns 0
>   */
> -static int smack_shm_alloc_security(struct kern_ipc_perm *shp)
> +static int smack_ipc_alloc_security(struct kern_ipc_perm *isp)
>  {
> -	struct kern_ipc_perm *isp = shp;
>  	struct smack_known *skp = smk_of_current();
>  
>  	isp->security = skp;
> @@ -2971,34 +2970,32 @@ static int smack_shm_alloc_security(struct kern_ipc_perm *shp)
>  }
>  
>  /**
> - * smack_shm_free_security - Clear the security blob for shm
> - * @shp: the object
> + * smack_ipc_free_security - Clear the security blob for ipc
> + * @isp: the object
>   *
>   * Clears the blob pointer
>   */
> -static void smack_shm_free_security(struct kern_ipc_perm *shp)
> +static void smack_ipc_free_security(struct kern_ipc_perm *isp)
>  {
> -	struct kern_ipc_perm *isp = shp;
> -
>  	isp->security = NULL;
>  }
>  
>  /**
>   * smk_curacc_shm : check if current has access on shm
> - * @shp : the object
> + * @isp : the object
>   * @access : access requested
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smk_curacc_shm(struct kern_ipc_perm *shp, int access)
> +static int smk_curacc_shm(struct kern_ipc_perm *isp, int access)
>  {
> -	struct smack_known *ssp = smack_of_shm(shp);
> +	struct smack_known *ssp = smack_of_ipc(isp);
>  	struct smk_audit_info ad;
>  	int rc;
>  
>  #ifdef CONFIG_AUDIT
>  	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_IPC);
> -	ad.a.u.ipc_id = shp->id;
> +	ad.a.u.ipc_id = isp->id;
>  #endif
>  	rc = smk_curacc(ssp, access, &ad);
>  	rc = smk_bu_current("shm", ssp, access, rc);
> @@ -3007,27 +3004,27 @@ static int smk_curacc_shm(struct kern_ipc_perm *shp, int access)
>  
>  /**
>   * smack_shm_associate - Smack access check for shm
> - * @shp: the object
> + * @isp: the object
>   * @shmflg: access requested
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smack_shm_associate(struct kern_ipc_perm *shp, int shmflg)
> +static int smack_shm_associate(struct kern_ipc_perm *isp, int shmflg)
>  {
>  	int may;
>  
>  	may = smack_flags_to_may(shmflg);
> -	return smk_curacc_shm(shp, may);
> +	return smk_curacc_shm(isp, may);
>  }
>  
>  /**
>   * smack_shm_shmctl - Smack access check for shm
> - * @shp: the object
> + * @isp: the object
>   * @cmd: what it wants to do
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smack_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
> +static int smack_shm_shmctl(struct kern_ipc_perm *isp, int cmd)
>  {
>  	int may;
>  
> @@ -3051,81 +3048,42 @@ static int smack_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
>  	default:
>  		return -EINVAL;
>  	}
> -	return smk_curacc_shm(shp, may);
> +	return smk_curacc_shm(isp, may);
>  }
>  
>  /**
>   * smack_shm_shmat - Smack access for shmat
> - * @shp: the object
> + * @isp: the object
>   * @shmaddr: unused
>   * @shmflg: access requested
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smack_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr,
> +static int smack_shm_shmat(struct kern_ipc_perm *ipc, char __user *shmaddr,
>  			   int shmflg)
>  {
>  	int may;
>  
>  	may = smack_flags_to_may(shmflg);
> -	return smk_curacc_shm(shp, may);
> -}
> -
> -/**
> - * smack_of_sem - the smack pointer for the sem
> - * @sma: the object
> - *
> - * Returns a pointer to the smack value
> - */
> -static struct smack_known *smack_of_sem(struct kern_ipc_perm *sma)
> -{
> -	return (struct smack_known *)sma->security;
> -}
> -
> -/**
> - * smack_sem_alloc_security - Set the security blob for sem
> - * @sma: the object
> - *
> - * Returns 0
> - */
> -static int smack_sem_alloc_security(struct kern_ipc_perm *sma)
> -{
> -	struct kern_ipc_perm *isp = sma;
> -	struct smack_known *skp = smk_of_current();
> -
> -	isp->security = skp;
> -	return 0;
> -}
> -
> -/**
> - * smack_sem_free_security - Clear the security blob for sem
> - * @sma: the object
> - *
> - * Clears the blob pointer
> - */
> -static void smack_sem_free_security(struct kern_ipc_perm *sma)
> -{
> -	struct kern_ipc_perm *isp = sma;
> -
> -	isp->security = NULL;
> +	return smk_curacc_shm(ipc, may);
>  }
>  
>  /**
>   * smk_curacc_sem : check if current has access on sem
> - * @sma : the object
> + * @isp : the object
>   * @access : access requested
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smk_curacc_sem(struct kern_ipc_perm *sma, int access)
> +static int smk_curacc_sem(struct kern_ipc_perm *isp, int access)
>  {
> -	struct smack_known *ssp = smack_of_sem(sma);
> +	struct smack_known *ssp = smack_of_ipc(isp);
>  	struct smk_audit_info ad;
>  	int rc;
>  
>  #ifdef CONFIG_AUDIT
>  	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_IPC);
> -	ad.a.u.ipc_id = sma->id;
> +	ad.a.u.ipc_id = isp->id;
>  #endif
>  	rc = smk_curacc(ssp, access, &ad);
>  	rc = smk_bu_current("sem", ssp, access, rc);
> @@ -3134,27 +3092,27 @@ static int smk_curacc_sem(struct kern_ipc_perm *sma, int access)
>  
>  /**
>   * smack_sem_associate - Smack access check for sem
> - * @sma: the object
> + * @isp: the object
>   * @semflg: access requested
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smack_sem_associate(struct kern_ipc_perm *sma, int semflg)
> +static int smack_sem_associate(struct kern_ipc_perm *isp, int semflg)
>  {
>  	int may;
>  
>  	may = smack_flags_to_may(semflg);
> -	return smk_curacc_sem(sma, may);
> +	return smk_curacc_sem(isp, may);
>  }
>  
>  /**
>   * smack_sem_shmctl - Smack access check for sem
> - * @sma: the object
> + * @isp: the object
>   * @cmd: what it wants to do
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smack_sem_semctl(struct kern_ipc_perm *sma, int cmd)
> +static int smack_sem_semctl(struct kern_ipc_perm *isp, int cmd)
>  {
>  	int may;
>  
> @@ -3184,12 +3142,12 @@ static int smack_sem_semctl(struct kern_ipc_perm *sma, int cmd)
>  		return -EINVAL;
>  	}
>  
> -	return smk_curacc_sem(sma, may);
> +	return smk_curacc_sem(isp, may);
>  }
>  
>  /**
>   * smack_sem_semop - Smack checks of semaphore operations
> - * @sma: the object
> + * @isp: the object
>   * @sops: unused
>   * @nsops: unused
>   * @alter: unused
> @@ -3198,67 +3156,28 @@ static int smack_sem_semctl(struct kern_ipc_perm *sma, int cmd)
>   *
>   * Returns 0 if access is allowed, error code otherwise
>   */
> -static int smack_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
> +static int smack_sem_semop(struct kern_ipc_perm *isp, struct sembuf *sops,
>  			   unsigned nsops, int alter)
>  {
> -	return smk_curacc_sem(sma, MAY_READWRITE);
> -}
> -
> -/**
> - * smack_msg_alloc_security - Set the security blob for msg
> - * @msq: the object
> - *
> - * Returns 0
> - */
> -static int smack_msg_queue_alloc_security(struct kern_ipc_perm *msq)
> -{
> -	struct kern_ipc_perm *kisp = msq;
> -	struct smack_known *skp = smk_of_current();
> -
> -	kisp->security = skp;
> -	return 0;
> -}
> -
> -/**
> - * smack_msg_free_security - Clear the security blob for msg
> - * @msq: the object
> - *
> - * Clears the blob pointer
> - */
> -static void smack_msg_queue_free_security(struct kern_ipc_perm *msq)
> -{
> -	struct kern_ipc_perm *kisp = msq;
> -
> -	kisp->security = NULL;
> -}
> -
> -/**
> - * smack_of_msq - the smack pointer for the msq
> - * @msq: the object
> - *
> - * Returns a pointer to the smack label entry
> - */
> -static struct smack_known *smack_of_msq(struct kern_ipc_perm *msq)
> -{
> -	return (struct smack_known *)msq->security;
> +	return smk_curacc_sem(isp, MAY_READWRITE);
>  }
>  
>  /**
>   * smk_curacc_msq : helper to check if current has access on msq
> - * @msq : the msq
> + * @isp : the msq
>   * @access : access requested
>   *
>   * return 0 if current has access, error otherwise
>   */
> -static int smk_curacc_msq(struct kern_ipc_perm *msq, int access)
> +static int smk_curacc_msq(struct kern_ipc_perm *isp, int access)
>  {
> -	struct smack_known *msp = smack_of_msq(msq);
> +	struct smack_known *msp = smack_of_ipc(isp);
>  	struct smk_audit_info ad;
>  	int rc;
>  
>  #ifdef CONFIG_AUDIT
>  	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_IPC);
> -	ad.a.u.ipc_id = msq->id;
> +	ad.a.u.ipc_id = isp->id;
>  #endif
>  	rc = smk_curacc(msp, access, &ad);
>  	rc = smk_bu_current("msq", msp, access, rc);
> @@ -3267,27 +3186,27 @@ static int smk_curacc_msq(struct kern_ipc_perm *msq, int access)
>  
>  /**
>   * smack_msg_queue_associate - Smack access check for msg_queue
> - * @msq: the object
> + * @isp: the object
>   * @msqflg: access requested
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smack_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
> +static int smack_msg_queue_associate(struct kern_ipc_perm *isp, int msqflg)
>  {
>  	int may;
>  
>  	may = smack_flags_to_may(msqflg);
> -	return smk_curacc_msq(msq, may);
> +	return smk_curacc_msq(isp, may);
>  }
>  
>  /**
>   * smack_msg_queue_msgctl - Smack access check for msg_queue
> - * @msq: the object
> + * @isp: the object
>   * @cmd: what it wants to do
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smack_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
> +static int smack_msg_queue_msgctl(struct kern_ipc_perm *isp, int cmd)
>  {
>  	int may;
>  
> @@ -3310,29 +3229,29 @@ static int smack_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
>  		return -EINVAL;
>  	}
>  
> -	return smk_curacc_msq(msq, may);
> +	return smk_curacc_msq(isp, may);
>  }
>  
>  /**
>   * smack_msg_queue_msgsnd - Smack access check for msg_queue
> - * @msq: the object
> + * @isp: the object
>   * @msg: unused
>   * @msqflg: access requested
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smack_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *msg,
> +static int smack_msg_queue_msgsnd(struct kern_ipc_perm *isp, struct msg_msg *msg,
>  				  int msqflg)
>  {
>  	int may;
>  
>  	may = smack_flags_to_may(msqflg);
> -	return smk_curacc_msq(msq, may);
> +	return smk_curacc_msq(isp, may);
>  }
>  
>  /**
>   * smack_msg_queue_msgsnd - Smack access check for msg_queue
> - * @msq: the object
> + * @isp: the object
>   * @msg: unused
>   * @target: unused
>   * @type: unused
> @@ -3340,10 +3259,10 @@ static int smack_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *msg
>   *
>   * Returns 0 if current has read and write access, error code otherwise
>   */
> -static int smack_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
> +static int smack_msg_queue_msgrcv(struct kern_ipc_perm *isp, struct msg_msg *msg,
>  			struct task_struct *target, long type, int mode)
>  {
> -	return smk_curacc_msq(msq, MAY_READWRITE);
> +	return smk_curacc_msq(isp, MAY_READWRITE);
>  }
>  
>  /**
> @@ -4756,21 +4675,21 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(msg_msg_alloc_security, smack_msg_msg_alloc_security),
>  	LSM_HOOK_INIT(msg_msg_free_security, smack_msg_msg_free_security),
>  
> -	LSM_HOOK_INIT(msg_queue_alloc_security, smack_msg_queue_alloc_security),
> -	LSM_HOOK_INIT(msg_queue_free_security, smack_msg_queue_free_security),
> +	LSM_HOOK_INIT(msg_queue_alloc_security, smack_ipc_alloc_security),
> +	LSM_HOOK_INIT(msg_queue_free_security, smack_ipc_free_security),
>  	LSM_HOOK_INIT(msg_queue_associate, smack_msg_queue_associate),
>  	LSM_HOOK_INIT(msg_queue_msgctl, smack_msg_queue_msgctl),
>  	LSM_HOOK_INIT(msg_queue_msgsnd, smack_msg_queue_msgsnd),
>  	LSM_HOOK_INIT(msg_queue_msgrcv, smack_msg_queue_msgrcv),
>  
> -	LSM_HOOK_INIT(shm_alloc_security, smack_shm_alloc_security),
> -	LSM_HOOK_INIT(shm_free_security, smack_shm_free_security),
> +	LSM_HOOK_INIT(shm_alloc_security, smack_ipc_alloc_security),
> +	LSM_HOOK_INIT(shm_free_security, smack_ipc_free_security),
>  	LSM_HOOK_INIT(shm_associate, smack_shm_associate),
>  	LSM_HOOK_INIT(shm_shmctl, smack_shm_shmctl),
>  	LSM_HOOK_INIT(shm_shmat, smack_shm_shmat),
>  
> -	LSM_HOOK_INIT(sem_alloc_security, smack_sem_alloc_security),
> -	LSM_HOOK_INIT(sem_free_security, smack_sem_free_security),
> +	LSM_HOOK_INIT(sem_alloc_security, smack_ipc_alloc_security),
> +	LSM_HOOK_INIT(sem_free_security, smack_ipc_free_security),
>  	LSM_HOOK_INIT(sem_associate, smack_sem_associate),
>  	LSM_HOOK_INIT(sem_semctl, smack_sem_semctl),
>  	LSM_HOOK_INIT(sem_semop, smack_sem_semop),

