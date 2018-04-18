Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1180209-1524079820-2-11668410538075027146
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
    1524079820; b=uJsMCtS+N85eIWAMb0PSu2Ymk9jCmzV8ld6ZCroWnaVvlFdFY3
    3u9mzvYF4vHQzbxTp9UuC5ubbwKa+0+X7vOMTubEJT+yDd68I326bNVAoe3ZPVod
    5ilMiNwZOkm/N0rEao5Eg9Q4Y08Qt9HA8ZDAqjBrtSwPCiCOIjBabFvmpcV5Pphc
    f1XhpY9DzYSFWHu7CqYTEdwQIFX9PeRuZqBXc7Ve13/dIhWbBL+wnrJO7m5Ulzyq
    osPmR2usOp6qZEwjserQneaQXllYtsmEC2t8gq/ESh3yveogw9BX9OKhOMuNO6Hf
    xHIXv/ULDC64Ajmq4tWXC3p2q6DBvwfKnL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524079820; bh=KMKOc8aDmmKctTYttpHRTTphV8B2/u
    +exA5WNCzpvBA=; b=ZgFaLZyJuKWIVwhqYqL0L8C1InjIF2oxbouxKDBX/gHd+0
    vsImGyb31O1OUHyra7ZcHoqx/WfVoLiDPGZJkUT0MVFBIqYvZSOlqFZdctLIlIQi
    6K1e4gBsh1aVc+ylX1enpdq8/xK3UL7Ao7NLM+NRjbuqM6wTFlECxcci7DffxMgV
    VOnfIrSdj68zgqV+0C5ctA7YBc35yDhQ6YJ1tzRNjF6AFVNuIox/RYerzdGJPo3L
    xO5spkPUORX2pPlALg+4jTpiqR07uqnCbgMfklPNag52326dfoeabztMl0qD1Bzl
    bNHcfjI3dIjHw9V72HwLNZcdDVQBTf2uGCSFeJBQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfI+guCmKffY98Gzzm14YVNriPKeKO4JJQ8POKBSwOFkeCx9mNZ3jsbJamIS4fDN/fQPtcf4j4RwqVJGTU6DNArgx68J9aNGOsFY1s03GyqG5VbcyL+iB
    Oe3nsHg10jkl+E0EOJUGW9H1oiztHNxSCsrUN6J1+1iXVI/SJ2QrBz3d/43m/8cVP9j/7Zqx+QfOgOvMHkVVosGLNadbc6p8PdhWk23a0gdGpqdahVd3Ogyh
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=J4KIL3XuJ7BDaCvK09AA:9
    a=CjuIK1q_8ugA:10 a=jDz1Lg8WPqQA:10 a=P8DiOWeu0RwA:10 a=uSJDGqdCSd8A:10
    a=x8gzFH9gYPwA:10 a=rcqGhh1FAl0A:10 a=85vV7UR2iKEA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbeDRT36 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 15:29:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750872AbeDRT34 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 18 Apr 2018 15:29:56 -0400
Date: Wed, 18 Apr 2018 15:23:59 -0400
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
Message-ID: <20180418192359.n4q53bvsdhrjftjg@madcap2.tricolour.ca>
References: <cover.1519930146.git.rgb@redhat.com>
 <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
 <216d1ab1-531b-9185-2e31-34f162f08aad@linux.vnet.ibm.com>
 <20180316035837.ddnqvbyrbp3fdk7e@madcap2.tricolour.ca>
 <f966fa52-da4b-3d74-0848-1f0b08e57fd9@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f966fa52-da4b-3d74-0848-1f0b08e57fd9@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-18 14:45, Stefan Berger wrote:
> On 03/15/2018 11:58 PM, Richard Guy Briggs wrote:
> > On 2018-03-15 16:27, Stefan Berger wrote:
> > > On 03/01/2018 02:41 PM, Richard Guy Briggs wrote:
> > > > Implement the proc fs write to set the audit container ID of a process,
> > > > emitting an AUDIT_CONTAINER record to document the event.
> > > > 
> > > > This is a write from the container orchestrator task to a proc entry of
> > > > the form /proc/PID/containerid where PID is the process ID of the newly
> > > > created task that is to become the first task in a container, or an
> > > > additional task added to a container.
> > > > 
> > > > The write expects up to a u64 value (unset: 18446744073709551615).
> > > > 
> > > > This will produce a record such as this:
> > > > type=UNKNOWN[1333] msg=audit(1519903238.968:261): op=set pid=596 uid=0 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 auid=0 tty=pts0 ses=1 opid=596 old-contid=18446744073709551615 contid=123455 res=0
> > > > 
> > > > The "op" field indicates an initial set.  The "pid" to "ses" fields are
> > > > the orchestrator while the "opid" field is the object's PID, the process
> > > > being "contained".  Old and new container ID values are given in the
> > > > "contid" fields, while res indicates its success.
> > > > 
> > > > It is not permitted to self-set, unset or re-set the container ID.  A
> > > > child inherits its parent's container ID, but then can be set only once
> > > > after.
> > > > 
> > > > See: https://github.com/linux-audit/audit-kernel/issues/32
> > > > 
> > > > 
> > > >    /* audit_rule_data supports filter rules with both integer and string
> > > >     * fields.  It corresponds with AUDIT_ADD_RULE, AUDIT_DEL_RULE and
> > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > index 4e0a4ac..0ee1e59 100644
> > > > --- a/kernel/auditsc.c
> > > > +++ b/kernel/auditsc.c
> > > > @@ -2073,6 +2073,92 @@ int audit_set_loginuid(kuid_t loginuid)
> > > >    	return rc;
> > > >    }
> > > > 
> > > > +static int audit_set_containerid_perm(struct task_struct *task, u64 containerid)
> > > > +{
> > > > +	struct task_struct *parent;
> > > > +	u64 pcontainerid, ccontainerid;
> > > > +	pid_t ppid;
> > > > +
> > > > +	/* Don't allow to set our own containerid */
> > > > +	if (current == task)
> > > > +		return -EPERM;
> > > > +	/* Don't allow the containerid to be unset */
> > > > +	if (!cid_valid(containerid))
> > > > +		return -EINVAL;
> > > > +	/* if we don't have caps, reject */
> > > > +	if (!capable(CAP_AUDIT_CONTROL))
> > > > +		return -EPERM;
> > > > +	/* if containerid is unset, allow */
> > > > +	if (!audit_containerid_set(task))
> > > > +		return 0;
> > > I am wondering whether there should be a check for the target process that
> > > will receive the containerid to not have CAP_SYS_ADMIN that would otherwise
> > > allow it to arbitrarily unshare()/clone() and leave the set of namespaces
> > > that may make up the container whose containerid we assign here?
> > This is a reasonable question.  This has been debated and I understood
> > the conclusion was that without a clear definition of a "container", the
> > task still remains in that container that just now has more
> > sub-namespaces (in the case of hierarchical namespaces), we don't want
> > to restrict it in such a way and that allows it to create nested
> > containers.  I see setns being more problematic if it could switch to
> > another existing namespace that was set up by the orchestrator for a
> > different container.  The coming v2 patchset acknowledges this situation
> > with the network namespace being potentially shared by multiple
> > containers.
> 
> Are you going to post v2 soon? We would like to build on top of it for IMA
> namespacing and auditing inside of IMA namespaces.

I don't know if it addresses your specific needs, but V2 was posted on
March 16th along with userspace patches:
	https://www.redhat.com/archives/linux-audit/2018-March/msg00110.html
	https://www.redhat.com/archives/linux-audit/2018-March/msg00124.html

V3 is pending.

>    Stefan

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
