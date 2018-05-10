Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2792679-1525987305-2-10413172661795191927
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525987305; b=Ww//JXqeZ2Vs50zWJB9UgXzjn2IOpAPAzUzY6Sd2jgZ4UrnEw7
    uQ026eNA9Onbkj26jqPMoTkOMsKprSlOXKVRr5l/qR9+srcihySNVYR09/+7m6UF
    AobYFE4B1+zroUwMuy0gU1Uzq4fX4xBwwWLIJzN2g2SOBaZSrzc2zKqzZzAF/Ivm
    mXlSo3cdh1+obtWndqGxM/KIBFJBJ/U7j7+cIJxyN/aaeMNZg7WAT00g7j3HNDuY
    Skkp5uLLxEeRVi9z7eKHXz5QZSoRog/nhRwZ9NdFwG0y6EPJtlhUM91sdKp8MD/p
    XgYpdx4M5+0SFs+eRbZeCyjuxg/wBBj/cEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525987305; bh=jK989pIiquV1nsjZn7nuUKKQt6zu+J
    /Qpp7WcyyJG5U=; b=YtvsLnvvWCkUE/V+PNv7qZqVlD1ElbIbEqT3YFNKNLAI9F
    v3vg4csQParyYBRMuJP5jQ9ioN2Zu1cg5EFQKXvzdJYSP6XpsJujoTuUdhJ+zNok
    dFnrY1KMgD7SJ7mFoOf1hKSbxhiOnJKL2NfGY6W+Kb8eu1M7D7q2FDOhD5Ax28+O
    enW9raCpvBvCDxIACU9Hand+ofUX8Od56dTTA1iLHZOZ3jPvZ30Q/HwJTPMrWkk+
    YJiRAs2GDUf7aFRDAno+jwXCJeMY5ho+5Noo96kVbkTf2BnJH+bxrrwbQNN7LLAJ
    jNLSGkZT2mFAXtvhQLXN/VoH0Idc+sTFc8BhM0GQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJs6samUGO0x/lGQJv8KZEFuoJlcZtcs6mBSLka3fTJ4miody6ywJROrIWgue3qmfInxw8syQH41xUiH9V35ghmDXUh0aM66GQIhrt10tDF/AzaPpxvq
    FV0PPOYv0hVueTEdGvy1iJAbT8I7vzxPN/GCffMvqyp8p8Y6AKikDFYf4SgpiRVT5omJOUJPEjeVC20FzUm4QlLdO2+IYslhL2wTUNKOr92JkTloynMJZq+M
    mgtRgL41uZt0ts29J4GByA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=625ZKIQiMGEUUv5cNE8A:9 a=CjuIK1q_8ugA:10
    a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbeEJVVm (ORCPT <rfc822;linux@kroah.com>);
        Thu, 10 May 2018 17:21:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752188AbeEJVVl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 May 2018 17:21:41 -0400
Date: Thu, 10 May 2018 17:21:14 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
        Netfilter Devel List <netfilter-devel@vger.kernel.org>,
        Linux Security Module list
        <linux-security-module@vger.kernel.org>,
        Integrity Measurement Architecture
        <linux-integrity@vger.kernel.org>,
        SElinux list <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH ghak81 RFC V1 1/5] audit: normalize loginuid read access
Message-ID: <20180510212114.pefeyw5cuqlmjewp@madcap2.tricolour.ca>
References: <cover.1525466167.git.rgb@redhat.com>
 <611e9c85fca8bcdb24e6fb6da412773663c007b3.1525466167.git.rgb@redhat.com>
 <CAHC9VhQKYt0PC0L65pwFRte1D98R=2tUDGxMVpc8bbJsMncGpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQKYt0PC0L65pwFRte1D98R=2tUDGxMVpc8bbJsMncGpw@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-05-09 11:13, Paul Moore wrote:
> On Fri, May 4, 2018 at 4:54 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Recognizing that the loginuid is an internal audit value, use an access
> > function to retrieve the audit loginuid value for the task rather than
> > reaching directly into the task struct to get it.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/auditsc.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 479c031..f3817d0 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -374,7 +374,7 @@ static int audit_field_compare(struct task_struct *tsk,
> >         case AUDIT_COMPARE_EGID_TO_OBJ_GID:
> >                 return audit_compare_gid(cred->egid, name, f, ctx);
> >         case AUDIT_COMPARE_AUID_TO_OBJ_UID:
> > -               return audit_compare_uid(tsk->loginuid, name, f, ctx);
> > +               return audit_compare_uid(audit_get_loginuid(tsk), name, f, ctx);
> >         case AUDIT_COMPARE_SUID_TO_OBJ_UID:
> >                 return audit_compare_uid(cred->suid, name, f, ctx);
> >         case AUDIT_COMPARE_SGID_TO_OBJ_GID:
> > @@ -385,7 +385,7 @@ static int audit_field_compare(struct task_struct *tsk,
> >                 return audit_compare_gid(cred->fsgid, name, f, ctx);
> >         /* uid comparisons */
> >         case AUDIT_COMPARE_UID_TO_AUID:
> > -               return audit_uid_comparator(cred->uid, f->op, tsk->loginuid);
> > +               return audit_uid_comparator(cred->uid, f->op, audit_get_loginuid(tsk));
> >         case AUDIT_COMPARE_UID_TO_EUID:
> >                 return audit_uid_comparator(cred->uid, f->op, cred->euid);
> >         case AUDIT_COMPARE_UID_TO_SUID:
> > @@ -394,11 +394,11 @@ static int audit_field_compare(struct task_struct *tsk,
> >                 return audit_uid_comparator(cred->uid, f->op, cred->fsuid);
> >         /* auid comparisons */
> >         case AUDIT_COMPARE_AUID_TO_EUID:
> > -               return audit_uid_comparator(tsk->loginuid, f->op, cred->euid);
> > +               return audit_uid_comparator(audit_get_loginuid(tsk), f->op, cred->euid);
> >         case AUDIT_COMPARE_AUID_TO_SUID:
> > -               return audit_uid_comparator(tsk->loginuid, f->op, cred->suid);
> > +               return audit_uid_comparator(audit_get_loginuid(tsk), f->op, cred->suid);
> >         case AUDIT_COMPARE_AUID_TO_FSUID:
> > -               return audit_uid_comparator(tsk->loginuid, f->op, cred->fsuid);
> > +               return audit_uid_comparator(audit_get_loginuid(tsk), f->op, cred->fsuid);
> >         /* euid comparisons */
> >         case AUDIT_COMPARE_EUID_TO_SUID:
> >                 return audit_uid_comparator(cred->euid, f->op, cred->suid);
> > @@ -611,7 +611,7 @@ static int audit_filter_rules(struct task_struct *tsk,
> >                                 result = match_tree_refs(ctx, rule->tree);
> >                         break;
> >                 case AUDIT_LOGINUID:
> > -                       result = audit_uid_comparator(tsk->loginuid, f->op, f->uid);
> > +                       result = audit_uid_comparator(audit_get_loginuid(tsk), f->op, f->uid);
> >                         break;
> >                 case AUDIT_LOGINUID_SET:
> >                         result = audit_comparator(audit_loginuid_set(tsk), f->op, f->val);
> > @@ -2287,8 +2287,8 @@ int audit_signal_info(int sig, struct task_struct *t)
> >             (sig == SIGTERM || sig == SIGHUP ||
> >              sig == SIGUSR1 || sig == SIGUSR2)) {
> >                 audit_sig_pid = task_tgid_nr(tsk);
> > -               if (uid_valid(tsk->loginuid))
> > -                       audit_sig_uid = tsk->loginuid;
> > +               if (uid_valid(audit_get_loginuid(tsk)))
> > +                       audit_sig_uid = audit_get_loginuid(tsk);
> 
> I realize this comment is a little silly given the nature of loginuid,
> but if we are going to abstract away loginuid accesses (which I think
> is good), we should probably access it once, store it in a local
> variable, perform the validity check on the local variable, then
> commit the local variable to audit_sig_uid.  I realize a TOCTOU
> problem is unlikely here, but with this new layer of abstraction it
> seems that some additional safety might be a good thing.

Ok, I'll just assign it to where it is going and check it there, holding
the audit_ctl_lock the whole time, since it should have been done
anyways for all of audit_sig_{pid,uid,sid} anyways to get a consistent
view from the AUDIT_SIGNAL_INFO fetch.

> >                 else
> >                         audit_sig_uid = uid;
> >                 security_task_getsecid(tsk, &audit_sig_sid);

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
