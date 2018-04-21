Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-218941-1524321675-2-17868846595277850831
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524321674; b=BCvDVDQvHD8ytp6bWv1e8kmzHUHzOpNyyvPdRmByfyYyjy6GxK
    72h1W6OXPTDsojbv+PcA6l/JBOG6iB/dOoOqS4uvZMoeypEXCvE0fz8GhAcA6eBP
    nZcAd5WOPPepZLx8AIiNtftwXHgGcsEIjtUJDjPjWrs7QDxn68cPFTFOiNwDq4lz
    9nF094ZfN4yxVhHJiBE+AFZwRn7h9dpTbVFH8eNHwEWJZgITP8iJYv8TVHmtVmac
    b1Yb5luXqRCq3CVnGHs+e8LVT/WGWl55RtIo//b9QRzEvBJ+lZ0IVwoBbB6/gfKX
    iFn8OKrV5NRESmFOCGxBzci9DCUPYW4tQYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524321674; bh=CUtAKzw3hSECoDZDie5TiFBGLkbkVz
    2kGssagG+fwsc=; b=pzA1MX9G76ieIbzw3S4qZw//F/Kc3CoTaxCw4SiY3Ji+7J
    ynzicXAoLP+KdbeSBgXouklUQYhCJyzcTPPKgokPz0GiRLKtDUvTVI/C7MMOF7N/
    63KILlJhulRiRWYHro5OsoFZAIdJf94u1dL65tbNk0oOX9G8zPspUJIS95ejMKCD
    iC8+ypF2+8NTUmLa+pfDfsgZxLzILlF9GP3IRaPzX2HySFHU3C+aOsGa2QNZCkX+
    zCikZSlN+3mmj0kHcas1ssgHDAJ+eK6lhf6eOrBb3PoHQItNnfOmhXwjEq7EbjCe
    2epFKXueGmdmGWfVgoyYK9VRMCsXSHKg2anyESng==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGEw6wqkOOCPocdiXMH3bA+bbPtDitdKE7w2wQetWTCHja/PBIkwtBp/UU/RXeDWNNTfpvOnd1CRBZWrJZhR/B4C1rfFh9LU4GokoPBRt5nX8pWu8xba
    w4bPx38K9ocinqlkkYaeMC0CCcXOmulheQuB+BlB9c1b2O2O9/o1jbCj2B+yEpp1yfkoejeV42CPFRiq40KLKz96sd1PgMhE3Va7YIIYzmsaOO5cuYfjSG6P
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=0es_vKt9Hiq8L1ZEeagA:9
    a=SDc9FnCuInPoOz8X:21 a=Hn2ueIsG4AoBEpMH:21 a=CjuIK1q_8ugA:10
    a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbeDUOk4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 21 Apr 2018 10:40:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752887AbeDUOkx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 21 Apr 2018 10:40:53 -0400
Date: Sat, 21 Apr 2018 10:34:43 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Subject: Re: [RFC PATCH ghak32 V2 01/13] audit: add container id
Message-ID: <20180421143443.faaput5g2rn6ul7p@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <e284617ad667ad8f17958dd8babb87fe1b4d7205.1521179281.git.rgb@redhat.com>
 <CAHC9VhTyvxxj2e2Gn+iyW6iLLeYB7hp8a+JvfeMmJ2nUPqtEaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTyvxxj2e2Gn+iyW6iLLeYB7hp8a+JvfeMmJ2nUPqtEaw@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-18 19:47, Paul Moore wrote:
> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Implement the proc fs write to set the audit container ID of a process,
> > emitting an AUDIT_CONTAINER record to document the event.
> >
> > This is a write from the container orchestrator task to a proc entry of
> > the form /proc/PID/containerid where PID is the process ID of the newly
> > created task that is to become the first task in a container, or an
> > additional task added to a container.
> >
> > The write expects up to a u64 value (unset: 18446744073709551615).
> >
> > This will produce a record such as this:
> > type=CONTAINER msg=audit(1519903238.968:261): op=set pid=596 uid=0 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 auid=0 tty=pts0 ses=1 opid=596 old-contid=18446744073709551615 contid=123455 res=0
> >
> > The "op" field indicates an initial set.  The "pid" to "ses" fields are
> > the orchestrator while the "opid" field is the object's PID, the process
> > being "contained".  Old and new container ID values are given in the
> > "contid" fields, while res indicates its success.
> >
> > It is not permitted to self-set, unset or re-set the container ID.  A
> > child inherits its parent's container ID, but then can be set only once
> > after.
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/32
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  fs/proc/base.c             | 37 ++++++++++++++++++++
> >  include/linux/audit.h      | 16 +++++++++
> >  include/linux/init_task.h  |  4 ++-
> >  include/linux/sched.h      |  1 +
> >  include/uapi/linux/audit.h |  2 ++
> >  kernel/auditsc.c           | 84 ++++++++++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 143 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 60316b5..6ce4fbe 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -1299,6 +1299,41 @@ static ssize_t proc_sessionid_read(struct file * file, char __user * buf,
> >         .read           = proc_sessionid_read,
> >         .llseek         = generic_file_llseek,
> >  };
> > +
> > +static ssize_t proc_containerid_write(struct file *file, const char __user *buf,
> > +                                  size_t count, loff_t *ppos)
> > +{
> > +       struct inode *inode = file_inode(file);
> > +       u64 containerid;
> > +       int rv;
> > +       struct task_struct *task = get_proc_task(inode);
> > +
> > +       if (!task)
> > +               return -ESRCH;
> > +       if (*ppos != 0) {
> > +               /* No partial writes. */
> > +               put_task_struct(task);
> > +               return -EINVAL;
> > +       }
> > +
> > +       rv = kstrtou64_from_user(buf, count, 10, &containerid);
> > +       if (rv < 0) {
> > +               put_task_struct(task);
> > +               return rv;
> > +       }
> > +
> > +       rv = audit_set_containerid(task, containerid);
> > +       put_task_struct(task);
> > +       if (rv < 0)
> > +               return rv;
> > +       return count;
> > +}
> > +
> > +static const struct file_operations proc_containerid_operations = {
> > +       .write          = proc_containerid_write,
> > +       .llseek         = generic_file_llseek,
> > +};
> > +
> >  #endif
> >
> >  #ifdef CONFIG_FAULT_INJECTION
> > @@ -2961,6 +2996,7 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
> >  #ifdef CONFIG_AUDITSYSCALL
> >         REG("loginuid",   S_IWUSR|S_IRUGO, proc_loginuid_operations),
> >         REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> > +       REG("containerid", S_IWUSR, proc_containerid_operations),
> >  #endif
> >  #ifdef CONFIG_FAULT_INJECTION
> >         REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
> > @@ -3355,6 +3391,7 @@ static int proc_tid_comm_permission(struct inode *inode, int mask)
> >  #ifdef CONFIG_AUDITSYSCALL
> >         REG("loginuid",  S_IWUSR|S_IRUGO, proc_loginuid_operations),
> >         REG("sessionid",  S_IRUGO, proc_sessionid_operations),
> > +       REG("containerid", S_IWUSR, proc_containerid_operations),
> >  #endif
> >  #ifdef CONFIG_FAULT_INJECTION
> >         REG("make-it-fail", S_IRUGO|S_IWUSR, proc_fault_inject_operations),
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index af410d9..fe4ba3f 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -29,6 +29,7 @@
> >
> >  #define AUDIT_INO_UNSET ((unsigned long)-1)
> >  #define AUDIT_DEV_UNSET ((dev_t)-1)
> > +#define INVALID_CID AUDIT_CID_UNSET
> 
> Why can't we just use AUDIT_CID_UNSET?  Is there an important
> distinction?  If so, they shouldn't they have different values?

One was intended as user-facing and the other was intended for kernel
internal.  As you point out, this does not appear to be necessary since
they are both the same type.  This was to mirror loginuid due to UID
namespace practice to seperate the two to make things very clear that a
userspace view of a UID needed to be translated from the user's user
namespace to the kernel's absolute view of UIDs from the init user
namespace.  Since container ID meanings do not depend on any namespace
context, I agree we can use just one and I'd go with AUDIT_CID_UNSET.

> If we do need to keep INVALID_CID, let's rename it to
> AUDIT_CID_INVALID so we have some consistency to the naming patterns
> and we stress that it is an *audit* container ID.
> 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index d258826..1b82191 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -796,6 +796,7 @@ struct task_struct {
> >  #ifdef CONFIG_AUDITSYSCALL
> >         kuid_t                          loginuid;
> >         unsigned int                    sessionid;
> > +       u64                             containerid;
> 
> This one line addition to the task_struct scares me the most of
> anything in this patchset.  Why?  It's a field named "containerid" in
> a perhaps one of the most widely used core kernel structures; the
> possibilities for abuse are endless, and it's foolish to think we
> would ever be able to adequately police this.

Fair enough.

> Unfortunately, we can't add the field to audit_context as things
> currently stand because we don't always allocate an audit_context,
> it's dependent on the system's configuration, and we need to track the
> audit container ID for a given process, regardless of the audit
> configuration.  Pretty much the same reason why loginuid and sessionid
> are located directly in task_struct now.  As I stressed during the
> design phase, I really want to keep this as an *audit* container ID
> and not a general purpose kernel wide container ID.  If the kernel
> ever grows a general purpose container ID token, I'll be the first in
> line to convert the audit code, but I don't want audit to be that
> general purpose mechanism ... audit is hated enough as-is ;)

When would we need an audit container ID when audit is not enabled
enough to have an audit_context?

If it is only used for audit, and audit is the only consumer, and audit
can only use it when it is enabled, then we can just return success to
any write to the proc filehandle, or not even present it.  Nothing will
be able to know that value wasn't used.

When are loginuid and sessionid used now when audit is not enabled (or
should I say, explicitly disabled)?

> I think the right solution to this is to create another new struct,
> audit_task_info (or similar, the name really isn't that important),
> which would be stored as a pointer in task_struct and would replace
> the audit_context pointer, loginuid, sessionid, and the newly proposed
> containerid.  The new audit_task_info would always be allocated in the
> audit_alloc() function (please use kmem_cache), and the audit_context
> pointer included inside would continue to be allocated based on the
> existing conditions.  By keeping audit_task_info as a pointer inside
> task_struct we could hide the structure definition inside
> kernel/audit*.c and make it much more difficult for other subsystems
> to abuse it.[1]
> 
>   struct audit_task_info {
>     kuid_t loginuid;
>     unsigned int sessionid;
>     u64 containerid;
>     struct audit_context *ctx;
>   }

I agree this looks like a good change.

> Actually, we might even want to consider storing audit_context in
> audit_task_info (no pointer), or making it a zero length array
> (ctx[0]) and going with a variable sized allocation of audit_task_info
> ... but all that could be done as a follow up optimization once we get
> the basic idea sorted.
> 
> [1] If for some reason allocating audit_task_info becomes too much
> overhead to bear (somewhat doubtful since we would only do it at task
> creation), we could do some ugly tricks to directly include an
> audit_task_struct chunk in task_struct but I'd like to avoid that if
> possible (and I think we can).
> 
> >  #endif
> >         struct seccomp                  seccomp;
> 
> ...
> 
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 4e61a9e..921a71f 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -71,6 +71,7 @@
> >  #define AUDIT_TTY_SET          1017    /* Set TTY auditing status */
> >  #define AUDIT_SET_FEATURE      1018    /* Turn an audit feature on or off */
> >  #define AUDIT_GET_FEATURE      1019    /* Get which features are enabled */
> > +#define AUDIT_CONTAINER                1020    /* Define the container id and information */
> >
> >  #define AUDIT_FIRST_USER_MSG   1100    /* Userspace messages mostly uninteresting to kernel */
> >  #define AUDIT_USER_AVC         1107    /* We filter this differently */
> > @@ -465,6 +466,7 @@ struct audit_tty_status {
> >  };
> >
> >  #define AUDIT_UID_UNSET (unsigned int)-1
> > +#define AUDIT_CID_UNSET ((u64)-1)
> 
> I think we need to decide if we want to distinguish between the "host"
> (e.g. init ns) and "unset".  Looking at this patch (I've only quickly
> skimmed the others so far) it would appear that you don't think we
> need to worry about this distinction; that's fine, but let's make it
> explicit with a comment in the code that AUDIT_CID_UNSET means "unset"
> as well as "host".

I don't see any reason to distinguish between "host" and "unset".  Since
a container doesn't have a concrete definition based in namespaces, the
initial namespace set is meaningless here.

Is there value in having a container orchestrator process have a
reserved container ID that has a policy distinct from any other
container?  If so, then I could see the value in making the distinction.
For example, I've heard of interest in systemd acting as a container
orchestrator, so if it took on that role as PID 1, then every process in
the system would inherit that ID and none would be unset.

I can't picture how having seperate "host" and "unset" values helps us.

> If we do need to make a distinction, let's add a constant/macro for "host".

Currently "unset" is -1 which fits the convention used for sessionid and
loginuid and a number of others, so I think it makes sense to stick with
that.  If we decide we need a "host" flag, would it make sense to use 0
or (u64)-2?

> >  /* audit_rule_data supports filter rules with both integer and string
> >   * fields.  It corresponds with AUDIT_ADD_RULE, AUDIT_DEL_RULE and
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 4e0a4ac..29c8482 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2073,6 +2073,90 @@ int audit_set_loginuid(kuid_t loginuid)
> >         return rc;
> >  }
> >
> > +static int audit_set_containerid_perm(struct task_struct *task, u64 containerid)
> > +{
> > +       struct task_struct *parent;
> > +       u64 pcontainerid, ccontainerid;
> > +
> > +       /* Don't allow to set our own containerid */
> > +       if (current == task)
> > +               return -EPERM;
> 
> Why not?  Is there some obvious security concern that I missing?

We then lose the distinction in the AUDIT_CONTAINER record between the
initiating PID and the target PID.  This was outlined in the proposal.

Having said that, I'm still not sure we have protected sufficiently from
a child turning around and setting it's parent's as yet unset or
inherited audit container ID.

> I ask because I suppose it might be possible for some container
> runtime to do a fork, setup some of the environment and them exec the
> container (before you answer the obvious "namespaces!" please remember
> we're not trying to define containers).

I don't think namespaces have any bearing on this concern since none are
required.

> > +       /* Don't allow the containerid to be unset */
> > +       if (!cid_valid(containerid))
> > +               return -EINVAL;
> > +       /* if we don't have caps, reject */
> > +       if (!capable(CAP_AUDIT_CONTROL))
> > +               return -EPERM;
> > +       /* if containerid is unset, allow */
> > +       if (!audit_containerid_set(task))
> > +               return 0;
> > +       /* it is already set, and not inherited from the parent, reject */
> > +       ccontainerid = audit_get_containerid(task);
> > +       rcu_read_lock();
> > +       parent = rcu_dereference(task->real_parent);
> > +       rcu_read_unlock();
> > +       task_lock(parent);
> > +       pcontainerid = audit_get_containerid(parent);
> > +       task_unlock(parent);
> > +       if (ccontainerid != pcontainerid)
> > +               return -EPERM;
> > +       return 0;
> > +}
> > +
> > +static void audit_log_set_containerid(struct task_struct *task, u64 oldcontainerid,
> > +                                     u64 containerid, int rc)
> > +{
> > +       struct audit_buffer *ab;
> > +       uid_t uid;
> > +       struct tty_struct *tty;
> > +
> > +       if (!audit_enabled)
> > +               return;
> > +
> > +       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONTAINER);
> > +       if (!ab)
> > +               return;
> > +
> > +       uid = from_kuid(&init_user_ns, task_uid(current));
> > +       tty = audit_get_tty(current);
> > +
> > +       audit_log_format(ab, "op=set pid=%d uid=%u", task_tgid_nr(current), uid);
> > +       audit_log_task_context(ab);
> > +       audit_log_format(ab, " auid=%u tty=%s ses=%u opid=%d old-contid=%llu contid=%llu res=%d",
> > +                        from_kuid(&init_user_ns, audit_get_loginuid(current)),
> > +                        tty ? tty_name(tty) : "(none)", audit_get_sessionid(current),
> > +                        task_tgid_nr(task), oldcontainerid, containerid, !rc);
> > +
> > +       audit_put_tty(tty);
> > +       audit_log_end(ab);
> > +}
> > +
> > +/**
> > + * audit_set_containerid - set current task's audit_context containerid
> > + * @containerid: containerid value
> > + *
> > + * Returns 0 on success, -EPERM on permission failure.
> > + *
> > + * Called (set) from fs/proc/base.c::proc_containerid_write().
> > + */
> > +int audit_set_containerid(struct task_struct *task, u64 containerid)
> > +{
> > +       u64 oldcontainerid;
> > +       int rc;
> > +
> > +       oldcontainerid = audit_get_containerid(task);
> > +
> > +       rc = audit_set_containerid_perm(task, containerid);
> > +       if (!rc) {
> > +               task_lock(task);
> > +               task->containerid = containerid;
> > +               task_unlock(task);
> > +       }
> > +
> > +       audit_log_set_containerid(task, oldcontainerid, containerid, rc);
> > +       return rc;
> 
> Why are audit_set_containerid_perm() and audit_log_containerid()
> separate functions?

(I assume you mean audit_log_set_containerid()?)
It seemed clearer that all the permission checking was in one function
and its return code could be used to report the outcome when logging the
(attempted) action.  This is the same structure as audit_set_loginuid()
and it made sense.

This would be the time to connect it to a syscall if that seems like a
good idea and remove pid, uid, auid, tty, ses fields.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
