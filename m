Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-229752-1519955159-2-10813705605608010978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrofr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519955158; b=XT5PK4A6L1wgF1epWI1CeHQBO2PfFxrKYEfQx2+AUNUQx8M
    dl07ufHMvYylgTI/7bIaEWSNiKjgvDgYA1URJ6h1vFQkAnZYwlZKuDoyGA3evzD9
    oqeIHN565wC/FMATQJDarlLVMZynqAdJ/9SRDM+zp0NJNcaRDTqYVk/NwgjypPJk
    6PNiTVwtZL6/lFhy6sO9bdYthZI79t2ww/hoq7w2zp7CC1GDhFEfkoaCqXCD99Et
    op9CsR+LZkhkoLxcZRJ/HNsaLEhiW3RZaUdHczyYlnM12EjsO1JMjFXubVgHveB1
    Jd/9MQc30IlLhLtzoPCODBgMQNDwDpOte2RBzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519955158; bh=BCj3NOwFBsJfeVbm3XPcrYVpux
    qWWykWXk0G0q1wbzE=; b=ZLVYXX/0e8PEgejsxS/jiksQ2lJvnE73O/g/DMrtjQ
    LM+oGTt5iGywIyV1h3BjPI8YUn5ikNozLa+gHojVi9vl6Zef2dOIGjCwioKqm/gx
    y9iHjP/5KAFfCqyGkDGnrAj9+tlA8A8aVEQv3Amf2i31wp48FYItKQfWBeJ/tXYs
    b47cI+U4J5SAe9Y8jyz7dvbgfsM2hIpw5qtrCr8hYJwt2GNSQ2Ne80cND2vPOBT9
    QKtYsAGpg0nh/MwsD/hE9a9enoHoQTLPiQxrRmt99GtwGNEbqPq2xSTZ6HDELeMp
    Z7lPnrRrwat4cV98tIJfXI1npKKUUIiEgXGkOKe/41Fw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163759AbeCBBp0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 20:45:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163100AbeCBBpY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 20:45:24 -0500
Date: Thu, 1 Mar 2018 20:41:01 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: mszeredi@redhat.com, luto@kernel.org, jlayton@redhat.com,
        carlos@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        simo@redhat.com, trondmy@primarydata.com, eparis@parisplace.org,
        serge@hallyn.com, ebiederm@xmission.com, madzcar@gmail.com
Subject: Re: [RFC PATCH V1 01/12] audit: add container id
Message-ID: <20180302014101.jtfd2eeyxmvxcjpf@madcap2.tricolour.ca>
References: <cover.1519930146.git.rgb@redhat.com>
 <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-01 14:41, Richard Guy Briggs wrote:
> Implement the proc fs write to set the audit container ID of a process,
> emitting an AUDIT_CONTAINER record to document the event.
> 
> This is a write from the container orchestrator task to a proc entry of
> the form /proc/PID/containerid where PID is the process ID of the newly
> created task that is to become the first task in a container, or an
> additional task added to a container.
> 
> The write expects up to a u64 value (unset: 18446744073709551615).
> 
> This will produce a record such as this:
> type=UNKNOWN[1333] msg=audit(1519903238.968:261): op=set pid=596 uid=0 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 auid=0 tty=pts0 ses=1 opid=596 old-contid=18446744073709551615 contid=123455 res=0
> 
> The "op" field indicates an initial set.  The "pid" to "ses" fields are
> the orchestrator while the "opid" field is the object's PID, the process
> being "contained".  Old and new container ID values are given in the
> "contid" fields, while res indicates its success.
> 
> It is not permitted to self-set, unset or re-set the container ID.  A
> child inherits its parent's container ID, but then can be set only once
> after.

There are more restrictions coming later:
- check that the child being set has no children or threads yet, or
  forcibly set them all to the same container ID (assuming they all pass
  the same tests).  This will also prevent an orch from setting its
  parent and other tit-for-tat games to circumvent the basic checks.

> See: https://github.com/linux-audit/audit-kernel/issues/32
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/proc/base.c             | 37 ++++++++++++++++++++
>  include/linux/audit.h      | 16 +++++++++
>  include/linux/init_task.h  |  4 ++-
>  include/linux/sched.h      |  1 +
>  include/uapi/linux/audit.h |  2 ++
>  kernel/auditsc.c           | 86 ++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 145 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 60316b5..6ce4fbe 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1299,6 +1299,41 @@ static ssize_t proc_sessionid_read(struct file * file, char __user * buf,
>  	.read		= proc_sessionid_read,
>  	.llseek		= generic_file_llseek,
>  };
> +
> +static ssize_t proc_containerid_write(struct file *file, const char __user *buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct inode *inode = file_inode(file);
> +	u64 containerid;
> +	int rv;
> +	struct task_struct *task = get_proc_task(inode);
> +
> +	if (!task)
> +		return -ESRCH;
> +	if (*ppos != 0) {
> +		/* No partial writes. */
> +		put_task_struct(task);
> +		return -EINVAL;
> +	}
> +
> +	rv = kstrtou64_from_user(buf, count, 10, &containerid);
> +	if (rv < 0) {
> +		put_task_struct(task);
> +		return rv;
> +	}
> +
> +	rv = audit_set_containerid(task, containerid);
> +	put_task_struct(task);
> +	if (rv < 0)
> +		return rv;
> +	return count;
> +}
> +
> +static const struct file_operations proc_containerid_operations = {
> +	.write		= proc_containerid_write,
> +	.llseek		= generic_file_llseek,
> +};
> +
>  #endif
>  
>  #ifdef CONFIG_FAULT_INJECTION
> @@ -2961,6 +2996,7 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
>  #ifdef CONFIG_AUDITSYSCALL
>  	REG("loginuid",   S_IWUSR|S_IRUGO, proc_loginuid_operations),
>  	REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> +	REG("containerid", S_IWUSR, proc_containerid_operations),
>  #endif
>  #ifdef CONFIG_FAULT_INJECTION
>  	REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
> @@ -3355,6 +3391,7 @@ static int proc_tid_comm_permission(struct inode *inode, int mask)
>  #ifdef CONFIG_AUDITSYSCALL
>  	REG("loginuid",  S_IWUSR|S_IRUGO, proc_loginuid_operations),
>  	REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> +	REG("containerid", S_IWUSR, proc_containerid_operations),
>  #endif
>  #ifdef CONFIG_FAULT_INJECTION
>  	REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index af410d9..fe4ba3f 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -29,6 +29,7 @@
>  
>  #define AUDIT_INO_UNSET ((unsigned long)-1)
>  #define AUDIT_DEV_UNSET ((dev_t)-1)
> +#define INVALID_CID AUDIT_CID_UNSET
>  
>  struct audit_sig_info {
>  	uid_t		uid;
> @@ -321,6 +322,7 @@ static inline void audit_ptrace(struct task_struct *t)
>  extern int auditsc_get_stamp(struct audit_context *ctx,
>  			      struct timespec64 *t, unsigned int *serial);
>  extern int audit_set_loginuid(kuid_t loginuid);
> +extern int audit_set_containerid(struct task_struct *tsk, u64 containerid);
>  
>  static inline kuid_t audit_get_loginuid(struct task_struct *tsk)
>  {
> @@ -332,6 +334,11 @@ static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
>  	return tsk->sessionid;
>  }
>  
> +static inline u64 audit_get_containerid(struct task_struct *tsk)
> +{
> +	return tsk->containerid;
> +}
> +
>  extern void __audit_ipc_obj(struct kern_ipc_perm *ipcp);
>  extern void __audit_ipc_set_perm(unsigned long qbytes, uid_t uid, gid_t gid, umode_t mode);
>  extern void __audit_bprm(struct linux_binprm *bprm);
> @@ -517,6 +524,10 @@ static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
>  {
>  	return -1;
>  }
> +static inline kuid_t audit_get_containerid(struct task_struct *tsk)
> +{
> +	return INVALID_CID;
> +}
>  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  { }
>  static inline void audit_ipc_set_perm(unsigned long qbytes, uid_t uid,
> @@ -581,6 +592,11 @@ static inline bool audit_loginuid_set(struct task_struct *tsk)
>  	return uid_valid(audit_get_loginuid(tsk));
>  }
>  
> +static inline bool audit_containerid_set(struct task_struct *tsk)
> +{
> +	return audit_get_containerid(tsk) != INVALID_CID;
> +}
> +
>  static inline void audit_log_string(struct audit_buffer *ab, const char *buf)
>  {
>  	audit_log_n_string(ab, buf, strlen(buf));
> diff --git a/include/linux/init_task.h b/include/linux/init_task.h
> index 6a53262..046bd0a 100644
> --- a/include/linux/init_task.h
> +++ b/include/linux/init_task.h
> @@ -18,6 +18,7 @@
>  #include <linux/sched/rt.h>
>  #include <linux/livepatch.h>
>  #include <linux/mm_types.h>
> +#include <linux/audit.h>
>  
>  #include <asm/thread_info.h>
>  
> @@ -120,7 +121,8 @@
>  #ifdef CONFIG_AUDITSYSCALL
>  #define INIT_IDS \
>  	.loginuid = INVALID_UID, \
> -	.sessionid = (unsigned int)-1,
> +	.sessionid = (unsigned int)-1, \
> +	.containerid = INVALID_CID,
>  #else
>  #define INIT_IDS
>  #endif
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d258826..1b82191 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -796,6 +796,7 @@ struct task_struct {
>  #ifdef CONFIG_AUDITSYSCALL
>  	kuid_t				loginuid;
>  	unsigned int			sessionid;
> +	u64				containerid;
>  #endif
>  	struct seccomp			seccomp;
>  
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 4e61a9e..921a71f 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -71,6 +71,7 @@
>  #define AUDIT_TTY_SET		1017	/* Set TTY auditing status */
>  #define AUDIT_SET_FEATURE	1018	/* Turn an audit feature on or off */
>  #define AUDIT_GET_FEATURE	1019	/* Get which features are enabled */
> +#define AUDIT_CONTAINER		1020	/* Define the container id and information */
>  
>  #define AUDIT_FIRST_USER_MSG	1100	/* Userspace messages mostly uninteresting to kernel */
>  #define AUDIT_USER_AVC		1107	/* We filter this differently */
> @@ -465,6 +466,7 @@ struct audit_tty_status {
>  };
>  
>  #define AUDIT_UID_UNSET (unsigned int)-1
> +#define AUDIT_CID_UNSET ((u64)-1)
>  
>  /* audit_rule_data supports filter rules with both integer and string
>   * fields.  It corresponds with AUDIT_ADD_RULE, AUDIT_DEL_RULE and
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 4e0a4ac..0ee1e59 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2073,6 +2073,92 @@ int audit_set_loginuid(kuid_t loginuid)
>  	return rc;
>  }
>  
> +static int audit_set_containerid_perm(struct task_struct *task, u64 containerid)
> +{
> +	struct task_struct *parent;
> +	u64 pcontainerid, ccontainerid;
> +	pid_t ppid;
> +
> +	/* Don't allow to set our own containerid */
> +	if (current == task)
> +		return -EPERM;
> +	/* Don't allow the containerid to be unset */
> +	if (!cid_valid(containerid))
> +		return -EINVAL;
> +	/* if we don't have caps, reject */
> +	if (!capable(CAP_AUDIT_CONTROL))
> +		return -EPERM;
> +	/* if containerid is unset, allow */
> +	if (!audit_containerid_set(task))
> +		return 0;
> +	/* it is already set, and not inherited from the parent, reject */
> +	ccontainerid = audit_get_containerid(task);
> +	rcu_read_lock();
> +	parent = rcu_dereference(task->real_parent);
> +	rcu_read_unlock();
> +	task_lock(parent);
> +	pcontainerid = audit_get_containerid(parent);
> +	ppid = task_tgid_nr(parent);
> +	task_unlock(parent);
> +	if (ccontainerid != pcontainerid)
> +		return -EPERM;
> +	return 0;
> +}
> +
> +static void audit_log_set_containerid(struct task_struct *task, u64 oldcontainerid,
> +				      u64 containerid, int rc)
> +{
> +	struct audit_buffer *ab;
> +	uid_t uid;
> +	struct tty_struct *tty;
> +
> +	if (!audit_enabled)
> +		return;
> +
> +	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONTAINER);
> +	if (!ab)
> +		return;
> +
> +	uid = from_kuid(&init_user_ns, task_uid(current));
> +	tty = audit_get_tty(current);
> +
> +	audit_log_format(ab, "op=set pid=%d uid=%u", task_tgid_nr(current), uid);
> +	audit_log_task_context(ab);
> +	audit_log_format(ab, " auid=%u tty=%s ses=%u opid=%d old-contid=%llu contid=%llu res=%d",
> +			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
> +			 tty ? tty_name(tty) : "(none)", audit_get_sessionid(current),
> +			 task_tgid_nr(task), oldcontainerid, containerid, !rc);
> +
> +	audit_put_tty(tty);
> +	audit_log_end(ab);
> +}
> +
> +/**
> + * audit_set_containerid - set current task's audit_context containerid
> + * @containerid: containerid value
> + *
> + * Returns 0 on success, -EPERM on permission failure.
> + *
> + * Called (set) from fs/proc/base.c::proc_containerid_write().
> + */
> +int audit_set_containerid(struct task_struct *task, u64 containerid)
> +{
> +	u64 oldcontainerid;
> +	int rc;
> +
> +	oldcontainerid = audit_get_containerid(task);
> +
> +	rc = audit_set_containerid_perm(task, containerid);
> +	if (!rc) {
> +		task_lock(task);
> +		task->containerid = containerid;
> +		task_unlock(task);
> +	}
> +
> +	audit_log_set_containerid(task, oldcontainerid, containerid, rc);
> +	return rc;
> +}
> +
>  /**
>   * __audit_mq_open - record audit data for a POSIX MQ open
>   * @oflag: open flag
> -- 
> 1.8.3.1
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
