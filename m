Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2204151-1521842129-2-16208591564984890279
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
    t=1521842128; b=D4b0+y5BKPSwzKfNefo41nNbQYif8QWrPIBFeiiqwl1SFb/
    bfDkG0DvEjSYlP/WXHtY3M0Khq51J50HjACW7lfzYr6NhAgMvZ3HGgdHbjKkYv4r
    c0CIGcTBQ65ic0sKaVLLyltUPAMTrvCNh+dUNnQsw4dy01TPqpRhDceoghqUilbI
    H2Od7tV4Y8tx329HulcjY/VcVTefBy02XMwr6u8g+x0IO1TzXmRfHdlQMxUu9P6u
    VzrhYq0+oxFnJc8+dIPfUIOkP2TK/xeGOeG5ldfWWkL74EMfs6KRwfBUl2o2asoO
    +jKBEs8yFIhcnbBcu1BJKqgp9JAMN0Q/xpM7UEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521842128; bh=E8OQgNKXrZnKKgY7Yb/Hz5+DJrj+KdSp5UOKbBqjQ+4=; b=A
    Ix3HZN8LrsunZPkbCqJapr2fL2desyjfOfmPaX7rjVncfNbFruBaq4Ugg2zPHEAY
    KSMJ9su+2yTtP186gnkTZZ8Vl8qFPLOC0S/PJLXFso7wal+VztfEAQaaUIAN48E9
    7343GyrlQItwNoA9B2aCPXw2sZxT+Vcd1FfCDSBppbk44UsIfjqPX6Uq+0hEYFHx
    LEb8mvp94a0vLu1Cn9HXRg6iiQLIfpx5zOCxCACYRUZKqQTcgcV50Y//tQlDhArh
    Mxso8pnFzdb9fIGfQMzDloOSJuj/H3uMkfZ5y6woYotW8IAQ2/dTZOBUjpmQKDM4
    Hd16Rdik1lahAkGv1Edrg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=QbFPO5Iq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=schaufler-ca.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=QbFPO5Iq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=schaufler-ca.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeCWVzP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 17:55:15 -0400
Received: from sonic309-20.consmr.mail.bf2.yahoo.com ([74.6.129.194]:44882
        "EHLO sonic309-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752213AbeCWVzO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 17:55:14 -0400
X-YMail-OSG: tAQmYmgVM1ml6U084fP26pvU9afXsDVnpm4mD4F_4ozB5C.YAPMBR1Wv1qNtLWx
 6wjcZ5XmT9GpbkUiFZuEGVy6i_AYDj9zhkajCA21DCt6Iqt1UDuu3qcXu2HcMM80iIKUQk1pFcq7
 edqwzXJ6YQejv8PUBqQR0.OMuEmK0vqDaGmHG9fNLyMM0Nda2x01jCPJeFtFpklCdXr9tFyWYDt0
 l7zFXGsBCSnY938Ee2un1bUSopbOPmjxMlPhNyMITnuoaiN8EWXj7D6RYAuZSJviFpVB8Y3RVpGX
 uOkqUgKd7S4ZTWAtV6ITW7MIM5Og5shy5afFNgmq.z9YM6WRzicXBtTxzZtaXtTJD0JgmSjHejh1
 eS9mwiNRBsXHKEzli_EvLvZyn7pn5B_HE4eTXu6SHBj8PuzPDgyN2gvamVXQe.rA2ERxPa0Duz19
 OvrtT_VsdMrJJ4waReMalIG.xc4SW81VlCzDoKbP_7H9mKSjpIqVDwFBFHR1o6PIbGVdXzN440hS
 .5rgm6J4bKJZgUVxHSzna9EpG
Subject: Re: [REVIEW][PATCH 03/11] msg/security: Pass kern_ipc_perm not
 msg_queue into the msg_queue security hooks
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
 <20180323191614.32489-3-ebiederm@xmission.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <bb73b0ea-bcda-a996-8f14-48d9dd1b0940@schaufler-ca.com>
Date: Fri, 23 Mar 2018 14:55:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323191614.32489-3-ebiederm@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/23/2018 12:16 PM, Eric W. Biederman wrote:
> All of the implementations of security hooks that take msg_queue only
> access q_perm the struct kern_ipc_perm member.  This means the
> dependencies of the msg_queue security hooks can be simplified by
> passing the kern_ipc_perm member of msg_queue.
>
> Making this change will allow struct msg_queue to become private to
> ipc/msg.c.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  include/linux/lsm_hooks.h  | 12 ++++++------
>  include/linux/security.h   | 25 ++++++++++++-------------
>  ipc/msg.c                  | 18 ++++++++----------
>  security/security.c        | 12 ++++++------
>  security/selinux/hooks.c   | 36 ++++++++++++++++++------------------
>  security/smack/smack_lsm.c | 24 ++++++++++++------------

Can I reference the comments I made in PATCH 01 of this set
regarding the Smack changes? The problem in all of your changes
is the same. You aren't preserving the naming conventions, and
you've left in some code that is just silly.



>  6 files changed, 62 insertions(+), 65 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index cac7a8082c43..bde167fa2c51 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1575,13 +1575,13 @@ union security_list_options {
>  	int (*msg_msg_alloc_security)(struct msg_msg *msg);
>  	void (*msg_msg_free_security)(struct msg_msg *msg);
>  
> -	int (*msg_queue_alloc_security)(struct msg_queue *msq);
> -	void (*msg_queue_free_security)(struct msg_queue *msq);
> -	int (*msg_queue_associate)(struct msg_queue *msq, int msqflg);
> -	int (*msg_queue_msgctl)(struct msg_queue *msq, int cmd);
> -	int (*msg_queue_msgsnd)(struct msg_queue *msq, struct msg_msg *msg,
> +	int (*msg_queue_alloc_security)(struct kern_ipc_perm *msq);
> +	void (*msg_queue_free_security)(struct kern_ipc_perm *msq);
> +	int (*msg_queue_associate)(struct kern_ipc_perm *msq, int msqflg);
> +	int (*msg_queue_msgctl)(struct kern_ipc_perm *msq, int cmd);
> +	int (*msg_queue_msgsnd)(struct kern_ipc_perm *msq, struct msg_msg *msg,
>  				int msqflg);
> -	int (*msg_queue_msgrcv)(struct msg_queue *msq, struct msg_msg *msg,
> +	int (*msg_queue_msgrcv)(struct kern_ipc_perm *msq, struct msg_msg *msg,
>  				struct task_struct *target, long type,
>  				int mode);
>  
> diff --git a/include/linux/security.h b/include/linux/security.h
> index f390755808ea..128e1e4a5346 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -50,7 +50,6 @@ struct iattr;
>  struct fown_struct;
>  struct file_operations;
>  struct msg_msg;
> -struct msg_queue;
>  struct xattr;
>  struct xfrm_sec_ctx;
>  struct mm_struct;
> @@ -353,13 +352,13 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
>  void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
>  int security_msg_msg_alloc(struct msg_msg *msg);
>  void security_msg_msg_free(struct msg_msg *msg);
> -int security_msg_queue_alloc(struct msg_queue *msq);
> -void security_msg_queue_free(struct msg_queue *msq);
> -int security_msg_queue_associate(struct msg_queue *msq, int msqflg);
> -int security_msg_queue_msgctl(struct msg_queue *msq, int cmd);
> -int security_msg_queue_msgsnd(struct msg_queue *msq,
> +int security_msg_queue_alloc(struct kern_ipc_perm *msq);
> +void security_msg_queue_free(struct kern_ipc_perm *msq);
> +int security_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg);
> +int security_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd);
> +int security_msg_queue_msgsnd(struct kern_ipc_perm *msq,
>  			      struct msg_msg *msg, int msqflg);
> -int security_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
> +int security_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
>  			      struct task_struct *target, long type, int mode);
>  int security_shm_alloc(struct kern_ipc_perm *shp);
>  void security_shm_free(struct kern_ipc_perm *shp);
> @@ -1043,32 +1042,32 @@ static inline int security_msg_msg_alloc(struct msg_msg *msg)
>  static inline void security_msg_msg_free(struct msg_msg *msg)
>  { }
>  
> -static inline int security_msg_queue_alloc(struct msg_queue *msq)
> +static inline int security_msg_queue_alloc(struct kern_ipc_perm *msq)
>  {
>  	return 0;
>  }
>  
> -static inline void security_msg_queue_free(struct msg_queue *msq)
> +static inline void security_msg_queue_free(struct kern_ipc_perm *msq)
>  { }
>  
> -static inline int security_msg_queue_associate(struct msg_queue *msq,
> +static inline int security_msg_queue_associate(struct kern_ipc_perm *msq,
>  					       int msqflg)
>  {
>  	return 0;
>  }
>  
> -static inline int security_msg_queue_msgctl(struct msg_queue *msq, int cmd)
> +static inline int security_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
>  {
>  	return 0;
>  }
>  
> -static inline int security_msg_queue_msgsnd(struct msg_queue *msq,
> +static inline int security_msg_queue_msgsnd(struct kern_ipc_perm *msq,
>  					    struct msg_msg *msg, int msqflg)
>  {
>  	return 0;
>  }
>  
> -static inline int security_msg_queue_msgrcv(struct msg_queue *msq,
> +static inline int security_msg_queue_msgrcv(struct kern_ipc_perm *msq,
>  					    struct msg_msg *msg,
>  					    struct task_struct *target,
>  					    long type, int mode)
> diff --git a/ipc/msg.c b/ipc/msg.c
> index 0dcc6699dc53..cdfab0825fce 100644
> --- a/ipc/msg.c
> +++ b/ipc/msg.c
> @@ -101,7 +101,7 @@ static void msg_rcu_free(struct rcu_head *head)
>  	struct kern_ipc_perm *p = container_of(head, struct kern_ipc_perm, rcu);
>  	struct msg_queue *msq = container_of(p, struct msg_queue, q_perm);
>  
> -	security_msg_queue_free(msq);
> +	security_msg_queue_free(&msq->q_perm);
>  	kvfree(msq);
>  }
>  
> @@ -127,7 +127,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
>  	msq->q_perm.key = key;
>  
>  	msq->q_perm.security = NULL;
> -	retval = security_msg_queue_alloc(msq);
> +	retval = security_msg_queue_alloc(&msq->q_perm);
>  	if (retval) {
>  		kvfree(msq);
>  		return retval;
> @@ -258,9 +258,7 @@ static void freeque(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
>   */
>  static inline int msg_security(struct kern_ipc_perm *ipcp, int msgflg)
>  {
> -	struct msg_queue *msq = container_of(ipcp, struct msg_queue, q_perm);
> -
> -	return security_msg_queue_associate(msq, msgflg);
> +	return security_msg_queue_associate(ipcp, msgflg);
>  }
>  
>  SYSCALL_DEFINE2(msgget, key_t, key, int, msgflg)
> @@ -380,7 +378,7 @@ static int msgctl_down(struct ipc_namespace *ns, int msqid, int cmd,
>  
>  	msq = container_of(ipcp, struct msg_queue, q_perm);
>  
> -	err = security_msg_queue_msgctl(msq, cmd);
> +	err = security_msg_queue_msgctl(&msq->q_perm, cmd);
>  	if (err)
>  		goto out_unlock1;
>  
> @@ -502,7 +500,7 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
>  	if (ipcperms(ns, &msq->q_perm, S_IRUGO))
>  		goto out_unlock;
>  
> -	err = security_msg_queue_msgctl(msq, cmd);
> +	err = security_msg_queue_msgctl(&msq->q_perm, cmd);
>  	if (err)
>  		goto out_unlock;
>  
> @@ -718,7 +716,7 @@ static inline int pipelined_send(struct msg_queue *msq, struct msg_msg *msg,
>  
>  	list_for_each_entry_safe(msr, t, &msq->q_receivers, r_list) {
>  		if (testmsg(msg, msr->r_msgtype, msr->r_mode) &&
> -		    !security_msg_queue_msgrcv(msq, msg, msr->r_tsk,
> +		    !security_msg_queue_msgrcv(&msq->q_perm, msg, msr->r_tsk,
>  					       msr->r_msgtype, msr->r_mode)) {
>  
>  			list_del(&msr->r_list);
> @@ -784,7 +782,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
>  			goto out_unlock0;
>  		}
>  
> -		err = security_msg_queue_msgsnd(msq, msg, msgflg);
> +		err = security_msg_queue_msgsnd(&msq->q_perm, msg, msgflg);
>  		if (err)
>  			goto out_unlock0;
>  
> @@ -960,7 +958,7 @@ static struct msg_msg *find_msg(struct msg_queue *msq, long *msgtyp, int mode)
>  
>  	list_for_each_entry(msg, &msq->q_messages, m_list) {
>  		if (testmsg(msg, *msgtyp, mode) &&
> -		    !security_msg_queue_msgrcv(msq, msg, current,
> +		    !security_msg_queue_msgrcv(&msq->q_perm, msg, current,
>  					       *msgtyp, mode)) {
>  			if (mode == SEARCH_LESSEQUAL && msg->m_type != 1) {
>  				*msgtyp = msg->m_type - 1;
> diff --git a/security/security.c b/security/security.c
> index 77b69bd6f234..02d734e69955 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1163,33 +1163,33 @@ void security_msg_msg_free(struct msg_msg *msg)
>  	call_void_hook(msg_msg_free_security, msg);
>  }
>  
> -int security_msg_queue_alloc(struct msg_queue *msq)
> +int security_msg_queue_alloc(struct kern_ipc_perm *msq)
>  {
>  	return call_int_hook(msg_queue_alloc_security, 0, msq);
>  }
>  
> -void security_msg_queue_free(struct msg_queue *msq)
> +void security_msg_queue_free(struct kern_ipc_perm *msq)
>  {
>  	call_void_hook(msg_queue_free_security, msq);
>  }
>  
> -int security_msg_queue_associate(struct msg_queue *msq, int msqflg)
> +int security_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
>  {
>  	return call_int_hook(msg_queue_associate, 0, msq, msqflg);
>  }
>  
> -int security_msg_queue_msgctl(struct msg_queue *msq, int cmd)
> +int security_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
>  {
>  	return call_int_hook(msg_queue_msgctl, 0, msq, cmd);
>  }
>  
> -int security_msg_queue_msgsnd(struct msg_queue *msq,
> +int security_msg_queue_msgsnd(struct kern_ipc_perm *msq,
>  			       struct msg_msg *msg, int msqflg)
>  {
>  	return call_int_hook(msg_queue_msgsnd, 0, msq, msg, msqflg);
>  }
>  
> -int security_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
> +int security_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
>  			       struct task_struct *target, long type, int mode)
>  {
>  	return call_int_hook(msg_queue_msgrcv, 0, msq, msg, target, type, mode);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 14f9e6c08273..925e546b5a87 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5532,52 +5532,52 @@ static void selinux_msg_msg_free_security(struct msg_msg *msg)
>  }
>  
>  /* message queue security operations */
> -static int selinux_msg_queue_alloc_security(struct msg_queue *msq)
> +static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
>  	u32 sid = current_sid();
>  	int rc;
>  
> -	rc = ipc_alloc_security(&msq->q_perm, SECCLASS_MSGQ);
> +	rc = ipc_alloc_security(msq, SECCLASS_MSGQ);
>  	if (rc)
>  		return rc;
>  
> -	isec = msq->q_perm.security;
> +	isec = msq->security;
>  
>  	ad.type = LSM_AUDIT_DATA_IPC;
> -	ad.u.ipc_id = msq->q_perm.key;
> +	ad.u.ipc_id = msq->key;
>  
>  	rc = avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
>  			  MSGQ__CREATE, &ad);
>  	if (rc) {
> -		ipc_free_security(&msq->q_perm);
> +		ipc_free_security(msq);
>  		return rc;
>  	}
>  	return 0;
>  }
>  
> -static void selinux_msg_queue_free_security(struct msg_queue *msq)
> +static void selinux_msg_queue_free_security(struct kern_ipc_perm *msq)
>  {
> -	ipc_free_security(&msq->q_perm);
> +	ipc_free_security(msq);
>  }
>  
> -static int selinux_msg_queue_associate(struct msg_queue *msq, int msqflg)
> +static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
>  	u32 sid = current_sid();
>  
> -	isec = msq->q_perm.security;
> +	isec = msq->security;
>  
>  	ad.type = LSM_AUDIT_DATA_IPC;
> -	ad.u.ipc_id = msq->q_perm.key;
> +	ad.u.ipc_id = msq->key;
>  
>  	return avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
>  			    MSGQ__ASSOCIATE, &ad);
>  }
>  
> -static int selinux_msg_queue_msgctl(struct msg_queue *msq, int cmd)
> +static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
>  {
>  	int err;
>  	int perms;
> @@ -5602,11 +5602,11 @@ static int selinux_msg_queue_msgctl(struct msg_queue *msq, int cmd)
>  		return 0;
>  	}
>  
> -	err = ipc_has_perm(&msq->q_perm, perms);
> +	err = ipc_has_perm(msq, perms);
>  	return err;
>  }
>  
> -static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg, int msqflg)
> +static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *msg, int msqflg)
>  {
>  	struct ipc_security_struct *isec;
>  	struct msg_security_struct *msec;
> @@ -5614,7 +5614,7 @@ static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
>  	u32 sid = current_sid();
>  	int rc;
>  
> -	isec = msq->q_perm.security;
> +	isec = msq->security;
>  	msec = msg->security;
>  
>  	/*
> @@ -5632,7 +5632,7 @@ static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
>  	}
>  
>  	ad.type = LSM_AUDIT_DATA_IPC;
> -	ad.u.ipc_id = msq->q_perm.key;
> +	ad.u.ipc_id = msq->key;
>  
>  	/* Can this process write to the queue? */
>  	rc = avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
> @@ -5649,7 +5649,7 @@ static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
>  	return rc;
>  }
>  
> -static int selinux_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
> +static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
>  				    struct task_struct *target,
>  				    long type, int mode)
>  {
> @@ -5659,11 +5659,11 @@ static int selinux_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
>  	u32 sid = task_sid(target);
>  	int rc;
>  
> -	isec = msq->q_perm.security;
> +	isec = msq->security;
>  	msec = msg->security;
>  
>  	ad.type = LSM_AUDIT_DATA_IPC;
> -	ad.u.ipc_id = msq->q_perm.key;
> +	ad.u.ipc_id = msq->key;
>  
>  	rc = avc_has_perm(sid, isec->sid,
>  			  SECCLASS_MSGQ, MSGQ__READ, &ad);
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index a3398c7f32c9..d960c2ea8d79 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3210,9 +3210,9 @@ static int smack_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
>   *
>   * Returns 0
>   */
> -static int smack_msg_queue_alloc_security(struct msg_queue *msq)
> +static int smack_msg_queue_alloc_security(struct kern_ipc_perm *msq)
>  {
> -	struct kern_ipc_perm *kisp = &msq->q_perm;
> +	struct kern_ipc_perm *kisp = msq;
>  	struct smack_known *skp = smk_of_current();
>  
>  	kisp->security = skp;
> @@ -3225,9 +3225,9 @@ static int smack_msg_queue_alloc_security(struct msg_queue *msq)
>   *
>   * Clears the blob pointer
>   */
> -static void smack_msg_queue_free_security(struct msg_queue *msq)
> +static void smack_msg_queue_free_security(struct kern_ipc_perm *msq)
>  {
> -	struct kern_ipc_perm *kisp = &msq->q_perm;
> +	struct kern_ipc_perm *kisp = msq;
>  
>  	kisp->security = NULL;
>  }
> @@ -3238,9 +3238,9 @@ static void smack_msg_queue_free_security(struct msg_queue *msq)
>   *
>   * Returns a pointer to the smack label entry
>   */
> -static struct smack_known *smack_of_msq(struct msg_queue *msq)
> +static struct smack_known *smack_of_msq(struct kern_ipc_perm *msq)
>  {
> -	return (struct smack_known *)msq->q_perm.security;
> +	return (struct smack_known *)msq->security;
>  }
>  
>  /**
> @@ -3250,7 +3250,7 @@ static struct smack_known *smack_of_msq(struct msg_queue *msq)
>   *
>   * return 0 if current has access, error otherwise
>   */
> -static int smk_curacc_msq(struct msg_queue *msq, int access)
> +static int smk_curacc_msq(struct kern_ipc_perm *msq, int access)
>  {
>  	struct smack_known *msp = smack_of_msq(msq);
>  	struct smk_audit_info ad;
> @@ -3258,7 +3258,7 @@ static int smk_curacc_msq(struct msg_queue *msq, int access)
>  
>  #ifdef CONFIG_AUDIT
>  	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_IPC);
> -	ad.a.u.ipc_id = msq->q_perm.id;
> +	ad.a.u.ipc_id = msq->id;
>  #endif
>  	rc = smk_curacc(msp, access, &ad);
>  	rc = smk_bu_current("msq", msp, access, rc);
> @@ -3272,7 +3272,7 @@ static int smk_curacc_msq(struct msg_queue *msq, int access)
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smack_msg_queue_associate(struct msg_queue *msq, int msqflg)
> +static int smack_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
>  {
>  	int may;
>  
> @@ -3287,7 +3287,7 @@ static int smack_msg_queue_associate(struct msg_queue *msq, int msqflg)
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smack_msg_queue_msgctl(struct msg_queue *msq, int cmd)
> +static int smack_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
>  {
>  	int may;
>  
> @@ -3321,7 +3321,7 @@ static int smack_msg_queue_msgctl(struct msg_queue *msq, int cmd)
>   *
>   * Returns 0 if current has the requested access, error code otherwise
>   */
> -static int smack_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
> +static int smack_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *msg,
>  				  int msqflg)
>  {
>  	int may;
> @@ -3340,7 +3340,7 @@ static int smack_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
>   *
>   * Returns 0 if current has read and write access, error code otherwise
>   */
> -static int smack_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
> +static int smack_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
>  			struct task_struct *target, long type, int mode)
>  {
>  	return smk_curacc_msq(msq, MAY_READWRITE);

