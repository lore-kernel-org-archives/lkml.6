Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-438920-1522314439-2-5059376717382130607
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522314438; b=koKFst/S7TkjxZZsGjVg8zphrot34/I0oq7tTJM1AhsGfoH8cv
    prU8zzELR3oU02/jomfUJqXhLT5+gy9EPmXD1uzSOVe/GhTGlkRepfqRydXgvhUs
    xxqMSq+Psw/DZCrntg76+Lb/tMbfDkfwyWHzHnrJtgLBsa+DluzqS20lt3HRZGyK
    5hQs6Lsyt+eQtQEdQON4I4vY+aYeE4J4mq/UUU24jr7+Pu8eS/aGCuj91vXSa1ep
    XmKsFps+QkzkZHVwOFu6aS1ToRVxfeaBjbRdf3sC2UePjU0awHjm9N67s+szJKz0
    YLPqsKoxNNw5OSDz+YRS7xn7BTtO5apLEi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522314438; bh=MLRY8nIkvAU/enJkDsi4CLOeFrwzkb
    CgZa/eWd/9CFs=; b=HLTqgacSOmxSvlB7dMD1lXnFgJv6hs7EF17/cQWLJ5tLHy
    DU6XrPHG+y7TM/jiXuqCxFmnLiOaylQgSReP9VtoiMb6xFYSfzZnbfYkbE+Vur/O
    KZsHX6f5dASc+eJ+dUNHDMfMY1wz+wzwMAImyCHSnE9jT9fRZ435ccJE08jMXqpV
    iP9kmd4QaTIhBkfFHRyN0IECCQ/gw9Wd+TxhVovDd/ZkhYgkifh43yxBIVrlfa3s
    zf3eveVPoK9cjo37jti30Pdkh1MToU0O6N00IWc1BmzyAK0psEvHmhIbaNylreu0
    ycjNkdqzeNr1aNVacw6CjxsLHBATlPo0KO4AUQig==
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
X-CM-Envelope: MS4wfHaJUySFMttCvcihjl9+iGZV8X4ETgHK5C1AXydZ9WtsVtTVrrqPUlQiVBues5B1F4tE30+D91fp8YCgkFbssqQn+jYr2aza9OntCvOlpsIN4UYKDRj/
    CyJvMlOEZvXvjMJxkFSXGzX/IWfuOCsMHcKwfwo0Mo38Nd0C8hR1O8DmD7pxV+7NSpYUfHwvau1rEIV2m+a9F35W7Oq1M+yhVIx8LIavj/+y0vSPj7goiFvj
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=3OwhkpyS_PUlM6aN0osA:9 a=CjuIK1q_8ugA:10
    a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeC2JG7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 05:06:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750946AbeC2JG6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Mar 2018 05:06:58 -0400
Date: Thu, 29 Mar 2018 05:01:32 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, luto@kernel.org, jlayton@redhat.com,
        carlos@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        simo@redhat.com, eparis@parisplace.org, serge@hallyn.com,
        ebiederm@xmission.com, madzcar@gmail.com
Subject: Re: [RFC PATCH ghak32 V2 01/13] audit: add container id
Message-ID: <20180329090132.r3qfomigkw3hbwbw@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <e284617ad667ad8f17958dd8babb87fe1b4d7205.1521179281.git.rgb@redhat.com>
 <20180328123912.49b11c98@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328123912.49b11c98@lwn.net>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-28 12:39, Jonathan Corbet wrote:
> On Fri, 16 Mar 2018 05:00:28 -0400
> Richard Guy Briggs <rgb@redhat.com> wrote:
> > Implement the proc fs write to set the audit container ID of a process,
> > emitting an AUDIT_CONTAINER record to document the event.
> 
> A little detail, but still...

I am understanding that you would prefer more context (as opposed to
operational detail) in the description, laying out the use case for this
patch(set)?

> > +static int audit_set_containerid_perm(struct task_struct *task, u64 containerid)
> > +{
> > +	struct task_struct *parent;
> > +	u64 pcontainerid, ccontainerid;
> > +
> > +	/* Don't allow to set our own containerid */
> > +	if (current == task)
> > +		return -EPERM;
> > +	/* Don't allow the containerid to be unset */
> > +	if (!cid_valid(containerid))
> > +		return -EINVAL;
> 
> I went looking for cid_valid(), but it turns out you don't add it until
> patch 5.  That, I expect, will not be good for bisectability (or patch
> review).

Nice catch, thanks Jon.  That is very likely another victim of a git
rebase to re-order afterthoughts in the right place.  I'll need to be
more careful of that class of bug, rethink my workflow, or script builds
to verify each commit is compilable.

> Thanks,
> 
> jon

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
