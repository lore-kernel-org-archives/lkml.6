Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1923083-1521173043-2-5928503525095802827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521173042; b=NDRd2ArEyDb1HkMD4e/gPgxlBR5uyzWSxy3dFHqnN3IthPa
    AvGCgf8bM/2UkOEjR0qgrP8HDqTG+0v3R1xsrZNNIbtw94SOfrppWMKphbS4ZqoC
    4p3JqlHeg1LN2qWdTlLiHgg7aejB7r6hiAZhnhztwJpYZg4nLFk/PxjleFfbkUqH
    cv6nSHf93uKs5iZmtz7h9Do7bDbyzw2bY1lNm8H1TVwRN5GPxoqFOJpIilACa28A
    kLD9XDvrVkweJDsA7ryrgP5WMy//TtAp+irHGeNndDRv6SvMtzUai42HClBVrk5b
    TH7vnhIQm6mVUedVBgeYUEzHP//WciiuPAJJVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521173042; bh=3KT03PbwGp/apNyfgug8xSE5RH
    QWLfi+aGILjRaRGZ0=; b=X9Qe79A0TBbUaTJ3mFm+QWor04NWCHo9Y1hJhQcXKL
    nKbDfiyOEvNvr5DDI4BQVgRs5U3f+f+GRnlIax65QozBDm4dtNyeFWVp+KMnhgOG
    OeiAqUDOQgsdF7brGycRyWsVY43SB0/iyZx4xCeWTjduIcBmAmdTtZ7pA9+rqHj3
    TO0k1bnjidKkMa6rMD6/rFaiRgHPx7c6GRmWnNPNgKD2t1tza6vPn0rrin17ucbW
    li+LDFoK1SRzL3Xm15+VipDFx1/pTuwHnbpI1sF286ATpBMCvTJuTd84GE0D1xwE
    aZj5Y2mgyjfOg6flZSc37mSUY553H1tq/BS1m6reCUrA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeCPEDj (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 00:03:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751064AbeCPEDh (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Mar 2018 00:03:37 -0400
Date: Thu, 15 Mar 2018 23:58:37 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, mszeredi@redhat.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, viro@zeniv.linux.org.uk,
        dhowells@redhat.com, simo@redhat.com, trondmy@primarydata.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        madzcar@gmail.com
Subject: Re: [RFC PATCH V1 01/12] audit: add container id
Message-ID: <20180316035837.ddnqvbyrbp3fdk7e@madcap2.tricolour.ca>
References: <cover.1519930146.git.rgb@redhat.com>
 <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
 <216d1ab1-531b-9185-2e31-34f162f08aad@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216d1ab1-531b-9185-2e31-34f162f08aad@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-15 16:27, Stefan Berger wrote:
> On 03/01/2018 02:41 PM, Richard Guy Briggs wrote:
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
> > type=UNKNOWN[1333] msg=audit(1519903238.968:261): op=set pid=596 uid=0 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 auid=0 tty=pts0 ses=1 opid=596 old-contid=18446744073709551615 contid=123455 res=0
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
> > 
> >   /* audit_rule_data supports filter rules with both integer and string
> >    * fields.  It corresponds with AUDIT_ADD_RULE, AUDIT_DEL_RULE and
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 4e0a4ac..0ee1e59 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2073,6 +2073,92 @@ int audit_set_loginuid(kuid_t loginuid)
> >   	return rc;
> >   }
> > 
> > +static int audit_set_containerid_perm(struct task_struct *task, u64 containerid)
> > +{
> > +	struct task_struct *parent;
> > +	u64 pcontainerid, ccontainerid;
> > +	pid_t ppid;
> > +
> > +	/* Don't allow to set our own containerid */
> > +	if (current == task)
> > +		return -EPERM;
> > +	/* Don't allow the containerid to be unset */
> > +	if (!cid_valid(containerid))
> > +		return -EINVAL;
> > +	/* if we don't have caps, reject */
> > +	if (!capable(CAP_AUDIT_CONTROL))
> > +		return -EPERM;
> > +	/* if containerid is unset, allow */
> > +	if (!audit_containerid_set(task))
> > +		return 0;
> 
> I am wondering whether there should be a check for the target process that
> will receive the containerid to not have CAP_SYS_ADMIN that would otherwise
> allow it to arbitrarily unshare()/clone() and leave the set of namespaces
> that may make up the container whose containerid we assign here?

This is a reasonable question.  This has been debated and I understood
the conclusion was that without a clear definition of a "container", the
task still remains in that container that just now has more
sub-namespaces (in the case of hierarchical namespaces), we don't want
to restrict it in such a way and that allows it to create nested
containers.  I see setns being more problematic if it could switch to
another existing namespace that was set up by the orchestrator for a
different container.  The coming v2 patchset acknowledges this situation
with the network namespace being potentially shared by multiple
containers.

This is the motivation for the code below that allows to set the
containerid even if it is already inherited from its parent.

> > +	/* it is already set, and not inherited from the parent, reject */
> > +	ccontainerid = audit_get_containerid(task);
> > +	rcu_read_lock();
> > +	parent = rcu_dereference(task->real_parent);
> > +	rcu_read_unlock();
> > +	task_lock(parent);
> > +	pcontainerid = audit_get_containerid(parent);
> > +	ppid = task_tgid_nr(parent);
>
> ppid not needed...

Thanks for catching this.  It was the vestige of a failed devel
experiment that didn't flush that useless appendage.  :-)

> > +	task_unlock(parent);
> > +	if (ccontainerid != pcontainerid)
> > +		return -EPERM;
> > +	return 0;
> > +}
> > +
> > +static void audit_log_set_containerid(struct task_struct *task, u64 oldcontainerid,
> > +				      u64 containerid, int rc)
> > +{
> > +	struct audit_buffer *ab;
> > +	uid_t uid;
> > +	struct tty_struct *tty;
> > +
> > +	if (!audit_enabled)
> > +		return;
> > +
> > +	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONTAINER);
> > +	if (!ab)
> > +		return;
> > +
> > +	uid = from_kuid(&init_user_ns, task_uid(current));
> > +	tty = audit_get_tty(current);
> > +
> > +	audit_log_format(ab, "op=set pid=%d uid=%u", task_tgid_nr(current), uid);
> > +	audit_log_task_context(ab);
> > +	audit_log_format(ab, " auid=%u tty=%s ses=%u opid=%d old-contid=%llu contid=%llu res=%d",
> > +			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
> > +			 tty ? tty_name(tty) : "(none)", audit_get_sessionid(current),
> > +			 task_tgid_nr(task), oldcontainerid, containerid, !rc);
> > +
> > +	audit_put_tty(tty);
> > +	audit_log_end(ab);
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
> > +	u64 oldcontainerid;
> > +	int rc;
> > +
> > +	oldcontainerid = audit_get_containerid(task);
> > +
> > +	rc = audit_set_containerid_perm(task, containerid);
> > +	if (!rc) {
> > +		task_lock(task);
> > +		task->containerid = containerid;
> > +		task_unlock(task);
> > +	}
> > +
> > +	audit_log_set_containerid(task, oldcontainerid, containerid, rc);
> > +	return rc;
> > +}
> > +
> >   /**
> >    * __audit_mq_open - record audit data for a POSIX MQ open
> >    * @oflag: open flag
> 
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
