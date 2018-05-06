Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3524759-1525625510-2-2666948658600417368
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
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
    1525625510; b=CawPFGehcjw/RNHUpJiWfAFyPvZ2bXMAKqVdcqeMkphNVlcV/D
    PYmzJrFBEyEwn0UTT9eRAHzj6dN1up2EeCY3e8APeHbqQySZJWg1cBX3qv6KVyg/
    Fm4yX/PD2Ko39wAzIfTqQqcBu3bTG35qk+1azwI5xdBvzlNqPKNunHcYbJU8K/E7
    HPrE/LkeNHDq/9HYH8LkceIyWOfTIHyU0uNTYZrIrSLrJU4eXDiVQHJl3BBqU7KQ
    mtPpsClfNFHZFMympy1cVGE0rK/xehxe9lm8DaYzJAam8qfV/zhsdlKR33t8Qzsl
    rw/zcUhgsPZNwglxV2zxkZxtBpNImiOMkfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525625510; bh=6n2RU3lcTAtI9ZU+ZucSotoW41CerA
    B64t7WfuPopBU=; b=ZbL8ZIgMycuxSjb6sKb7veS5TgMxNksSoLfLh8yBOTfP/K
    fRsbHHZ3b5iw1W8L/PDUK+UOJvw+6940/Bn5YBR64MQxOthL6DRZlffOZpQyV4Fp
    A3JBvq4bHIhI608oIvWjKAKB1ouxSCd5bCbV945/XN6ltNOn/eQaRCbxZqUWLvsu
    CXUAj1WSIZ/3uEGEbNsmRDrT3ius9fWss599M8dJ9+J3Pcbu+jwhL7YH1zycDHSq
    Ghzz9xRhUMWcwSu+W7sh1ZD/DdH64HMQljw286vevu3BbzEcKzRSfwAKUgHAOa0C
    mt+reqJRLUiRn1syzMrxASBZxIyckI++8gAtkTuA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLSAalT5cw0WSS4w3cMKeH+k0B+AqOEKkQoIr9JN7AU/lA+5X59PRHmZgVFlRsND6V85+4BhZYYSIqu8Ls9UfIBUiipNPu6+XcufA3VZiyBaXn4EWCfd
    nr24wQ2Ob70BTCENHuSKfCKiq7/QN/dDGmjbJ+pqHa7X7FMTeKdkogt6uB93UOB+YCo8ICGSSq6qCEoK7cyN7FUr3hAxlyXdfSfnM4g64G5XOa7qSaX+BeHn
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=-YjhucrHHom5xkzLdWoA:9
    a=CjuIK1q_8ugA:10 a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeEFQvr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 6 May 2018 12:51:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751625AbeEFQvq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 6 May 2018 12:51:46 -0400
Date: Sun, 6 May 2018 12:51:30 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: simo@redhat.com, jlayton@redhat.com, carlos@redhat.com,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>, dhowells@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        ebiederm@xmission.com, luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        serge@hallyn.com, viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH ghak32 V2 01/13] audit: add container id
Message-ID: <20180506165130.w23hrxonnpebof5n@madcap2.tricolour.ca>
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

...

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
> 
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
> 
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
> 
> Actually, we might even want to consider storing audit_context in
> audit_task_info (no pointer), or making it a zero length array
> (ctx[0]) and going with a variable sized allocation of audit_task_info
> ... but all that could be done as a follow up optimization once we get
> the basic idea sorted.

I tried statically allocating struct audit_task_info (with a pointer to
struct audit_context) in addition to dynamically allocating struct
audit_task_info due to a bug I'd introduced while dynamically allocating
audit_task_info, so I now have proof-of-concepts for working static and
almost working dynamic allocated struct audit_task_info.

Statically allocating it required a new header file, so I'm not that
crazy about it, but it proved it works.

Dynamically allocating it isn't quite as clean as was hoped since
init/init_task.c still needs initializaiton values for loginuid and
sessionid which could be supplied by a statically allocated struct
audit_task_info and still needs to know the internals of that struct to
do so.  Dynamic allocation is also more disruptive initially, but in the
long run will be more stable to the rest of the kernel.

I'm not crazy about the idea of dynamically (or even statically)
allocating struct audit_task_info which includes allocated space for
struct audit_context since the latter is far larger than the former.

> [1] If for some reason allocating audit_task_info becomes too much
> overhead to bear (somewhat doubtful since we would only do it at task
> creation), we could do some ugly tricks to directly include an
> audit_task_struct chunk in task_struct but I'd like to avoid that if
> possible (and I think we can).

On allocation, I don't see too much of a problem.  When calling
audit_free() if there is no audit context it is pretty lightweight, but
gets heavier if we eliminate the inline audit_free() and rename
__audit_free() back to audit_free().  Having struct audit_task_info
directly in struct task_struct would be faster and also allow defaults
to be set in init/init_task.c (which has recently been populated from
include/linux/init_task.h).  I'm not sure this is enough of a reason to
avoid a pointer from task_struct.

(As an aside, converting allocation of audit_context could also benefit
from kmem_cache... and maybe even struct audit_names)

> >  #endif
> >         struct seccomp                  seccomp;
> 
> ...

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
