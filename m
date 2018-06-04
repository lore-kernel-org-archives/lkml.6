Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1918895-1528143864-2-15808075508070357718
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528143864; b=YDZHvDGNf3dRIcYr8korH3icr2D1LWErMUowKzGOv+QvZ+Etcx
    W6cPeg36eIwXQiRV/Nz5Bvt7pK+B5Zlgeb750cuzyvq/c6vLh4ndrZsfkYHroGjt
    pD6KTqF6FUaTaWlTUSST5ltPy09kSfwLdQtc0xA6ALpZxiYAGfybiaGjxyGafRaM
    Y8Edw9fB/V4HBdk6Ohpy4sjK5knOht9+zrYKzNtiscoIyG8CfTlz/UHt5V4m5WWo
    h+P/MjiBmclxnpF2DM68CeAuYmR4f6eRhHpwEkxEQNFZeNOHY2tvrsrJ3+DJq+sD
    OsOkugrL4MD+GlfsEKbOWfscXnAH6y+MnjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1528143864; bh=2LP8vaS339cxzCQazPA04NewoD9Imz
    PojV7k6opRPDc=; b=iucDdZIXcPV6GyyAfYb+bx42xFNJv3aIrmHWEPzlqsZSNx
    GZFmm3JREzRNf4O037BjyiLjh7m/TkQNpCXobeit/8/7FGX/qzNZVwlwHs48SugS
    WQfmN+3rCfE3uKs6B67ln79HcsCN4m4p9/vhUcrFHns8LJ6QHHI75QeDJeyj+wS2
    /xibxNCcbHyQYD0+amkwVxxBgqY+iLFLeOKQD2DQf39JnutOKuqOCVrRCWtKuc+X
    C/ciXCLv725mvF3QJqXfwJfNLj/6mA7WoH+z0jw/h3+GFPBfXGE5dFN4/BnmL/4H
    FD9C3FWECwc2JLpoVi5seZSuAPb2AWgO6Mi/SRVA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF2aVI+1Nia/NxcNjBOcIt6Nft09VfvwraNMZp6aYY/EzoR78v9AnIXdSTvOsOIydkBKdPfJ7zxw/suBltJ8qJgl9FFoks25aNQQHLdsXW3Y8G1Gs6zN
    /OutU7GyNu88DOZSHyKIVrknSz/vRx+FtnrOE1LVhLb6v+1exD9HG5cf8sJby3Spfub/MKJthR+ksPdfQKsiKSWTyu5xBTK7i1JMpEXM9lL9Bxkls3NWAoGO
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=77d_1CzMAAAA:8
    a=NEAV23lmAAAA:8 a=QkUemeSKcnCK7eqeu2wA:9 a=CjuIK1q_8ugA:10 a=jDz1Lg8WPqQA:10
    a=3x-UEW4IZ8cA:10 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=QN4qkdld4szc5MSp8JWP:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751041AbeFDUYU (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 16:24:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750879AbeFDUYT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:24:19 -0400
Date: Mon, 4 Jun 2018 16:23:01 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, eparis@parisplace.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH ghak32 V2 01/13] audit: add container id
Message-ID: <20180604202301.2id5xpjqqotqq5j4@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <20180517170053.7d4afa87@ivy-bridge>
 <20180601210455.boz3tjqeqcx3kucg@madcap2.tricolour.ca>
 <36399691.WpcOE4jDTJ@x2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36399691.WpcOE4jDTJ@x2>
User-Agent: NeoMutt/20180512
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-06-04 12:09, Steve Grubb wrote:
> On Friday, June 1, 2018 5:04:55 PM EDT Richard Guy Briggs wrote:
> > Re: [RFC PATCH ghak32 V2 01/13] audit: add container id
> > 
> > From:	Richard Guy Briggs <rgb@redhat.com>
> > To:	Me
> > CC:	linux-api@vger.kernel.org, containers@lists.linux-foundation.org, LKML
> > <linux-kernel@vger.kernel.org>, eparis@parisplace.org, ... Date:	6/1/18
> > 5:04 PM
> > 
> > On 2018-05-17 17:00, Steve Grubb wrote:
> > > On Fri, 16 Mar 2018 05:00:28 -0400
> > > 
> > > Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > Implement the proc fs write to set the audit container ID of a
> > > > process, emitting an AUDIT_CONTAINER record to document the event.
> > > > 
> > > > This is a write from the container orchestrator task to a proc entry
> > > > of the form /proc/PID/containerid where PID is the process ID of the
> > > > newly created task that is to become the first task in a container,
> > > > or an additional task added to a container.
> > > > 
> > > > The write expects up to a u64 value (unset: 18446744073709551615).
> > > > 
> > > > This will produce a record such as this:
> > > > type=CONTAINER msg=audit(1519903238.968:261): op=set pid=596 uid=0
> > > > subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 auid=0
> > > > tty=pts0 ses=1 opid=596 old-contid=18446744073709551615 contid=123455
> > > > res=0
> > > 
> > > The was one thing I was wondering about. Currently when we set the
> > > loginuid, the record is AUDIT_LOGINUID. The corollary is that when we
> > > set the container id, the event should be AUDIT_CONTAINERID or
> > > AUDIT_CONTAINER_ID.
> > > 
> > > During syscall events, the path info is returned in a a record simply
> > > called AUDIT_PATH, cwd info is returned in AUDIT_CWD. So, rather than
> > > calling the record that gets attached to everything
> > > AUDIT_CONTAINER_INFO, how about simply AUDIT_CONTAINER.
> > > 
> > > > The "op" field indicates an initial set.  The "pid" to "ses" fields
> > > > are the orchestrator while the "opid" field is the object's PID, the
> > > > process being "contained".  Old and new container ID values are given
> > > > in the "contid" fields, while res indicates its success.
> > > > 
> > > > It is not permitted to self-set, unset or re-set the container ID.  A
> > > > child inherits its parent's container ID, but then can be set only
> > > > once after.
> > > > 
> > > > See: https://github.com/linux-audit/audit-kernel/issues/32
> > > > 
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > ---
> > > > fs/proc/base.c             | 37 ++++++++++++++++++++
> > > > include/linux/audit.h      | 16 +++++++++
> > > > include/linux/init_task.h  |  4 ++-
> > > > include/linux/sched.h      |  1 +
> > > > include/uapi/linux/audit.h |  2 ++
> > > > kernel/auditsc.c           | 84
> > > > ++++++++++++++++++++++++++++++++++++++++++++++ 6 files changed, 143
> > > > insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > > index 60316b5..6ce4fbe 100644
> > > > --- a/fs/proc/base.c
> > > > +++ b/fs/proc/base.c
> > > > @@ -1299,6 +1299,41 @@ static ssize_t proc_sessionid_read(struct file
> > > > * file, char __user * buf, .read                = proc_sessionid_read,
> > > > .llseek         = generic_file_llseek,
> > > > };
> > > > +
> > > > +static ssize_t proc_containerid_write(struct file *file, const char
> > > > __user *buf,
> > > > +                                  size_t count, loff_t *ppos)
> > > > +{
> > > > +       struct inode *inode = file_inode(file);
> > > > +       u64 containerid;
> > > > +       int rv;
> > > > +       struct task_struct *task = get_proc_task(inode);
> > > > +
> > > > +       if (!task)
> > > > +               return -ESRCH;
> > > > +       if (*ppos != 0) {
> > > > +               /* No partial writes. */
> > > > +               put_task_struct(task);
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > > +       rv = kstrtou64_from_user(buf, count, 10, &containerid);
> > > > +       if (rv < 0) {
> > > > +               put_task_struct(task);
> > > > +               return rv;
> > > > +       }
> > > > +
> > > > +       rv = audit_set_containerid(task, containerid);
> > > > +       put_task_struct(task);
> > > > +       if (rv < 0)
> > > > +               return rv;
> > > > +       return count;
> > > > +}
> > > > +
> > > > +static const struct file_operations proc_containerid_operations = {
> > > > +       .write          = proc_containerid_write,
> > > > +       .llseek         = generic_file_llseek,
> > > > +};
> > > > +
> > > > #endif
> > > > 
> > > > #ifdef CONFIG_FAULT_INJECTION
> > > > @@ -2961,6 +2996,7 @@ static int proc_pid_patch_state(struct seq_file
> > > > *m, struct pid_namespace *ns, #ifdef CONFIG_AUDITSYSCALL
> > > > REG("loginuid",   S_IWUSR|S_IRUGO, proc_loginuid_operations),
> > > > REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> > > > +       REG("containerid", S_IWUSR, proc_containerid_operations),
> > > > #endif
> > > > #ifdef CONFIG_FAULT_INJECTION
> > > > REG("make-it-fail", S_IRUGO|S_IWUSR,
> > > > proc_fault_inject_operations), @@ -3355,6 +3391,7 @@ static int
> > > > proc_tid_comm_permission(struct inode *inode, int mask) #ifdef
> > > > CONFIG_AUDITSYSCALL REG("loginuid",  S_IWUSR|S_IRUGO,
> > > > proc_loginuid_operations), REG("sessionid",  S_IRUGO,
> > > > proc_sessionid_operations),
> > > > +       REG("containerid", S_IWUSR, proc_containerid_operations),
> > > > #endif
> > > > #ifdef CONFIG_FAULT_INJECTION
> > > > REG("make-it-fail", S_IRUGO|S_IWUSR,
> > > > proc_fault_inject_operations), diff --git a/include/linux/audit.h
> > > > b/include/linux/audit.h index af410d9..fe4ba3f 100644
> > > > --- a/include/linux/audit.h
> > > > +++ b/include/linux/audit.h
> > > > @@ -29,6 +29,7 @@
> > > > 
> > > > #define AUDIT_INO_UNSET ((unsigned long)-1)
> > > > #define AUDIT_DEV_UNSET ((dev_t)-1)
> > > > +#define INVALID_CID AUDIT_CID_UNSET
> > > > 
> > > > struct audit_sig_info {
> > > > uid_t           uid;
> > > > @@ -321,6 +322,7 @@ static inline void audit_ptrace(struct
> > > > task_struct *t) extern int auditsc_get_stamp(struct audit_context
> > > > *ctx, struct timespec64 *t, unsigned int *serial);
> > > > extern int audit_set_loginuid(kuid_t loginuid);
> > > > +extern int audit_set_containerid(struct task_struct *tsk, u64
> > > > containerid);
> > > > static inline kuid_t audit_get_loginuid(struct task_struct *tsk)
> > > > {
> > > > @@ -332,6 +334,11 @@ static inline unsigned int
> > > > audit_get_sessionid(struct task_struct *tsk) return tsk->sessionid;
> > > > }
> > > > 
> > > > +static inline u64 audit_get_containerid(struct task_struct *tsk)
> > > > +{
> > > > +       return tsk->containerid;
> > > > +}
> > > > +
> > > > extern void __audit_ipc_obj(struct kern_ipc_perm *ipcp);
> > > > extern void __audit_ipc_set_perm(unsigned long qbytes, uid_t uid,
> > > > gid_t gid, umode_t mode); extern void __audit_bprm(struct
> > > > linux_binprm *bprm); @@ -517,6 +524,10 @@ static inline unsigned int
> > > > audit_get_sessionid(struct task_struct *tsk) {
> > > > return -1;
> > > > }
> > > > +static inline kuid_t audit_get_containerid(struct task_struct *tsk)
> > > > +{
> > > > +       return INVALID_CID;
> > > > +}
> > > > static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
> > > > { }
> > > > static inline void audit_ipc_set_perm(unsigned long qbytes, uid_t
> > > > uid, @@ -581,6 +592,11 @@ static inline bool
> > > > audit_loginuid_set(struct task_struct *tsk) return
> > > > uid_valid(audit_get_loginuid(tsk)); }
> > > > 
> > > > +static inline bool audit_containerid_set(struct task_struct *tsk)
> > > > +{
> > > > +       return audit_get_containerid(tsk) != INVALID_CID;
> > > > +}
> > > > +
> > > > static inline void audit_log_string(struct audit_buffer *ab, const
> > > > char *buf) {
> > > > audit_log_n_string(ab, buf, strlen(buf));
> > > > diff --git a/include/linux/init_task.h b/include/linux/init_task.h
> > > > index 6a53262..046bd0a 100644
> > > > --- a/include/linux/init_task.h
> > > > +++ b/include/linux/init_task.h
> > > > @@ -18,6 +18,7 @@
> > > > #include <linux/sched/rt.h>
> > > > #include <linux/livepatch.h>
> > > > #include <linux/mm_types.h>
> > > > +#include <linux/audit.h>
> > > > 
> > > > #include <asm/thread_info.h>
> > > > 
> > > > @@ -120,7 +121,8 @@
> > > > #ifdef CONFIG_AUDITSYSCALL
> > > > #define INIT_IDS \
> > > > .loginuid = INVALID_UID, \
> > > > -       .sessionid = (unsigned int)-1,
> > > > +       .sessionid = (unsigned int)-1, \
> > > > +       .containerid = INVALID_CID,
> > > > #else
> > > > #define INIT_IDS
> > > > #endif
> > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > index d258826..1b82191 100644
> > > > --- a/include/linux/sched.h
> > > > +++ b/include/linux/sched.h
> > > > @@ -796,6 +796,7 @@ struct task_struct {
> > > > #ifdef CONFIG_AUDITSYSCALL
> > > > kuid_t                          loginuid;
> > > > unsigned int                    sessionid;
> > > > +       u64                             containerid;
> > > > #endif
> > > > struct seccomp                  seccomp;
> > > > 
> > > > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > > > index 4e61a9e..921a71f 100644
> > > > --- a/include/uapi/linux/audit.h
> > > > +++ b/include/uapi/linux/audit.h
> > > > @@ -71,6 +71,7 @@
> > > > #define AUDIT_TTY_SET           1017    /* Set TTY auditing
> > > > status */ #define AUDIT_SET_FEATURE     1018    /* Turn an
> > > > audit feature on or off */ #define AUDIT_GET_FEATURE
> > > > 1019    /* Get which features are enabled */ +#define
> > > > AUDIT_CONTAINER         1020    /* Define the container id
> > > > and information */ #define AUDIT_FIRST_USER_MSG 1100    /*
> > > > Userspace messages mostly uninteresting to kernel */ #define
> > > > AUDIT_USER_AVC          1107    /* We filter this
> > > > differently */ @@ -465,6 +466,7 @@ struct audit_tty_status { };
> > > > 
> > > > #define AUDIT_UID_UNSET (unsigned int)-1
> > > > +#define AUDIT_CID_UNSET ((u64)-1)
> > > > 
> > > > /* audit_rule_data supports filter rules with both integer and string
> > > > * fields.  It corresponds with AUDIT_ADD_RULE, AUDIT_DEL_RULE and
> > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > index 4e0a4ac..29c8482 100644
> > > > --- a/kernel/auditsc.c
> > > > +++ b/kernel/auditsc.c
> > > > @@ -2073,6 +2073,90 @@ int audit_set_loginuid(kuid_t loginuid)
> > > > return rc;
> > > > }
> > > > 
> > > > +static int audit_set_containerid_perm(struct task_struct *task, u64
> > > > containerid) +{
> > > > +       struct task_struct *parent;
> > > > +       u64 pcontainerid, ccontainerid;
> > > > +
> > > > +       /* Don't allow to set our own containerid */
> > > > +       if (current == task)
> > > > +               return -EPERM;
> > > > +       /* Don't allow the containerid to be unset */
> > > > +       if (!cid_valid(containerid))
> > > > +               return -EINVAL;
> > > > +       /* if we don't have caps, reject */
> > > > +       if (!capable(CAP_AUDIT_CONTROL))
> > > > +               return -EPERM;
> > > > +       /* if containerid is unset, allow */
> > > > +       if (!audit_containerid_set(task))
> > > > +               return 0;
> > > > +       /* it is already set, and not inherited from the parent,
> > > > reject */
> > > > +       ccontainerid = audit_get_containerid(task);
> > > > +       rcu_read_lock();
> > > > +       parent = rcu_dereference(task->real_parent);
> > > > +       rcu_read_unlock();
> > > > +       task_lock(parent);
> > > > +       pcontainerid = audit_get_containerid(parent);
> > > > +       task_unlock(parent);
> > > > +       if (ccontainerid != pcontainerid)
> > > > +               return -EPERM;
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static void audit_log_set_containerid(struct task_struct *task, u64
> > > > oldcontainerid,
> > > > +                                     u64 containerid, int rc)
> > > > +{
> > > > +       struct audit_buffer *ab;
> > > > +       uid_t uid;
> > > > +       struct tty_struct *tty;
> > > > +
> > > > +       if (!audit_enabled)
> > > > +               return;
> > > > +
> > > > +       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONTAINER);
> > > > +       if (!ab)
> > > > +               return;
> > > > +
> > > > +       uid = from_kuid(&init_user_ns, task_uid(current));
> > > > +       tty = audit_get_tty(current);
> > > > +
> > > > +       audit_log_format(ab, "op=set pid=%d uid=%u",
> > > > task_tgid_nr(current), uid);
> > > > +       audit_log_task_context(ab);
> > > > +       audit_log_format(ab, " auid=%u tty=%s ses=%u opid=%d
> > > > old-contid=%llu contid=%llu res=%d",
> > > 
> > > The preferred ordering would be: op, opid, old-contid, contid, pid, uid,
> > > tty, ses, subj, comm, exe, res. This groups the searchable fields
> > > together using the most common ordering so that parsing is simple.
> > 
> > Where would you like auid?  It appears that just before uid would be the
> > right place, if not in place of uid, but this is just a guess since it
> > isn't consistent.
> 
> 
> Just after the uid is the proper place. The most common sequence is:
> pid, uid, auid, tty, session, subject context, comm, exe.

Not according to:
	http://people.redhat.com/sgrubb/audit/record-fields.html

> -Steve

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
