Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1180209-1524081463-2-7497790850814199563
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
    1524081462; b=juW3OQZVi0mNWHgnGRIGDDtLNi5Oz4ikMGMrMvjkir3N31LbBu
    iND8c2MqTzuQV4d2j45RkRGTZlFQYgl57W1671/5rgxlceHhj6WWqd6qVJpcuiI+
    a12Y0l/V3L29N4bt50PM3Wf9meT017CfvP/6UJg37n+v8UBxOLQMgzFGr64wIki2
    zSWjQLhyzEn3KL6QwwYMRuKtSqoUxqGmbtGi34nM0PTPCrlG3O00QYUG3OF1VJGQ
    OWAqZA+CJ06Z5csrUBtPHha+5uiFRej+lLX+JftsHWkIVMkApMwFeO57DUl+S21T
    1HrIc4j3dXD6+D2NhMHxHt+FdxWvtcH9xD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524081462; bh=DzCB1nPszzq+G0L3QNGkEakElVxBCQ
    KyWZ9RKfRN3NI=; b=Va9ieZHBgCNohprK/6pbVe4Bjwcmy4gzVhRdtHp1GZc3lg
    O0opLXZ0i79HPsGcxWXpPITiabylLSvwfbN8PaBA2y5+la9yO3+nSHwsznzi1jd+
    zMiJSYCPYQL1x8JV4rHOHju+dZKKiLQvWH2dCYnCtN5745ffxQDyXYl34Sz1ahb7
    e00hA0lz2l1EGBlthEMio3986yXXfqVEBUsgzpPz0+/wZ25gPqCJvWnqb9mXMUaz
    b79uMDtvsmYF1jhZc5WQ68W92vcyGkKngA3TGwMJPJA5X1Nn29C55KMQC2b05hJY
    yacucLFkfKn8pLJXsfYdMKIt1rbky+LVyqVASy8A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfJR7AbThsdTa6BIAbypSLRYPXQvq6t1uYJu1V/0a6+v/MMdbjwekde8DKGZKx4Le9V2kPLCHFRYkJ15L/JB7lVtIkD/l+T60CpiyaP7MIfQQqpl8DjRJ
    XURs/I2hfB/OikIxXbfNDcwmQC6b92i4ay46N3hqJ2MKWbcrLolTVSOodflD+1+shbDxMNPvu/Orv2ArEel50pJUpt7gVdZa527g9eqmiCOM8Ym8KDHTUCvB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=5Y2O060LqHfJIrrwvAcA:9
    a=CjuIK1q_8ugA:10 a=jDz1Lg8WPqQA:10 a=P8DiOWeu0RwA:10 a=uSJDGqdCSd8A:10
    a=x8gzFH9gYPwA:10 a=rcqGhh1FAl0A:10 a=85vV7UR2iKEA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeDRT5l (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 15:57:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751256AbeDRT5k (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 18 Apr 2018 15:57:40 -0400
Date: Wed, 18 Apr 2018 15:51:36 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: mszeredi@redhat.com, ebiederm@xmission.com, simo@redhat.com,
        jlayton@redhat.com, carlos@redhat.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, eparis@parisplace.org,
        dhowells@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        viro@zeniv.linux.org.uk, luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        serge@hallyn.com, trondmy@primarydata.com
Subject: Re: [RFC PATCH V1 01/12] audit: add container id
Message-ID: <20180418195136.sbogbumlputhbvfx@madcap2.tricolour.ca>
References: <cover.1519930146.git.rgb@redhat.com>
 <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
 <216d1ab1-531b-9185-2e31-34f162f08aad@linux.vnet.ibm.com>
 <20180316035837.ddnqvbyrbp3fdk7e@madcap2.tricolour.ca>
 <f966fa52-da4b-3d74-0848-1f0b08e57fd9@linux.vnet.ibm.com>
 <20180418192359.n4q53bvsdhrjftjg@madcap2.tricolour.ca>
 <c1ec93a2-b398-373c-55da-b2be8e60c6b6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1ec93a2-b398-373c-55da-b2be8e60c6b6@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-18 15:39, Stefan Berger wrote:
> On 04/18/2018 03:23 PM, Richard Guy Briggs wrote:
> > On 2018-04-18 14:45, Stefan Berger wrote:
> > > On 03/15/2018 11:58 PM, Richard Guy Briggs wrote:
> > > > On 2018-03-15 16:27, Stefan Berger wrote:
> > > > > On 03/01/2018 02:41 PM, Richard Guy Briggs wrote:
> > > > > > Implement the proc fs write to set the audit container ID of a process,
> > > > > > emitting an AUDIT_CONTAINER record to document the event.
> > > > > > 
> > > > > > This is a write from the container orchestrator task to a proc entry of
> > > > > > the form /proc/PID/containerid where PID is the process ID of the newly
> > > > > > created task that is to become the first task in a container, or an
> > > > > > additional task added to a container.
> > > > > > 
> > > > > > The write expects up to a u64 value (unset: 18446744073709551615).
> > > > > > 
> > > > > > This will produce a record such as this:
> > > > > > type=UNKNOWN[1333] msg=audit(1519903238.968:261): op=set pid=596 uid=0 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 auid=0 tty=pts0 ses=1 opid=596 old-contid=18446744073709551615 contid=123455 res=0
> > > > > > 
> > > > > > The "op" field indicates an initial set.  The "pid" to "ses" fields are
> > > > > > the orchestrator while the "opid" field is the object's PID, the process
> > > > > > being "contained".  Old and new container ID values are given in the
> > > > > > "contid" fields, while res indicates its success.
> > > > > > 
> > > > > > It is not permitted to self-set, unset or re-set the container ID.  A
> > > > > > child inherits its parent's container ID, but then can be set only once
> > > > > > after.
> > > > > > 
> > > > > > See: https://github.com/linux-audit/audit-kernel/issues/32
> > > > > > 
> > > > > > 
> > > > > >     /* audit_rule_data supports filter rules with both integer and string
> > > > > >      * fields.  It corresponds with AUDIT_ADD_RULE, AUDIT_DEL_RULE and
> > > > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > > > index 4e0a4ac..0ee1e59 100644
> > > > > > --- a/kernel/auditsc.c
> > > > > > +++ b/kernel/auditsc.c
> > > > > > @@ -2073,6 +2073,92 @@ int audit_set_loginuid(kuid_t loginuid)
> > > > > >     	return rc;
> > > > > >     }
> > > > > > 
> > > > > > +static int audit_set_containerid_perm(struct task_struct *task, u64 containerid)
> > > > > > +{
> > > > > > +	struct task_struct *parent;
> > > > > > +	u64 pcontainerid, ccontainerid;
> > > > > > +	pid_t ppid;
> > > > > > +
> > > > > > +	/* Don't allow to set our own containerid */
> > > > > > +	if (current == task)
> > > > > > +		return -EPERM;
> > > > > > +	/* Don't allow the containerid to be unset */
> > > > > > +	if (!cid_valid(containerid))
> > > > > > +		return -EINVAL;
> > > > > > +	/* if we don't have caps, reject */
> > > > > > +	if (!capable(CAP_AUDIT_CONTROL))
> > > > > > +		return -EPERM;
> > > > > > +	/* if containerid is unset, allow */
> > > > > > +	if (!audit_containerid_set(task))
> > > > > > +		return 0;
> > > > > I am wondering whether there should be a check for the target process that
> > > > > will receive the containerid to not have CAP_SYS_ADMIN that would otherwise
> > > > > allow it to arbitrarily unshare()/clone() and leave the set of namespaces
> > > > > that may make up the container whose containerid we assign here?
> > > > This is a reasonable question.  This has been debated and I understood
> > > > the conclusion was that without a clear definition of a "container", the
> > > > task still remains in that container that just now has more
> > > > sub-namespaces (in the case of hierarchical namespaces), we don't want
> > > > to restrict it in such a way and that allows it to create nested
> > > > containers.  I see setns being more problematic if it could switch to
> > > > another existing namespace that was set up by the orchestrator for a
> > > > different container.  The coming v2 patchset acknowledges this situation
> > > > with the network namespace being potentially shared by multiple
> > > > containers.
> > > Are you going to post v2 soon? We would like to build on top of it for IMA
> > > namespacing and auditing inside of IMA namespaces.
> > I don't know if it addresses your specific needs, but V2 was posted on
> > March 16th along with userspace patches:
> > 	https://www.redhat.com/archives/linux-audit/2018-March/msg00110.html
> > 	https://www.redhat.com/archives/linux-audit/2018-March/msg00124.html
> > 
> > V3 is pending.
> Thanks. I hadn't actually looked at primarily due to the ghak and ghau in
> the title. Whatever these may mean.

They are Github issue numbers:
GHAK: GitHub Audit Kernel
GHAU: GitHub Audit Userspace
GHAD: GitHub Audit Documentation
GHAT: GitHub Audit Testsuite

> Does V2 or will V3 prevent a privileged process to setns() to a whole
> different set of namespaces and still be audited with that initial container
> id ?

No, not significantly different from V1 in that respect.

It does not prevent setns(), but will maintain its containerid.

It will prevent games by blocking a child and parent from setting each
other's containerids.

It does check that the task being conainered does not yet have any
children or peer threads.

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
