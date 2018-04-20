Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-276252-1524187812-2-1223003454809377834
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
    1524187811; b=kDFVWrDxFiLWAqH9hv4lHsWDc+zwMv92DbU75p1YnL4tMw9FZw
    QQIHvnxFNEpRTrQyK1aLch7LAwahSxiba1SzHoNqhraienIDuaFh2fR/6sLbv5Et
    xj/rQ83+r+Zayv+YcX5K1mgwreqdVVS8oNRFN/xGHfz/7VfkvyrzjuOnZ8CiDhlY
    mBlt+fd0o7FhuwJVAeAIag2hHYJjLnXOJIPmMCKROYz9gla5blReXPpkbYesIsg4
    Xtel+WHznICt+Gf9XWJ0TcuyQwkX/DBI4V42gm++vuliGmOgaVx9YNkMZTGFEPPv
    6b1iXDmER8v+WN5idu7s2vEjwWOU7q6I0qYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524187811; bh=DI9uzHv4l9+c4DwWt0tiUBcGETscmc
    +evKxSpFCNKoI=; b=wESI87ZnkgzaRFyQtaDJP4yl1Mp6dFlZJdug4AliNWlc7q
    in05v/GhHra8kq1skiILRt+xVbM1ewGWntD2z7FL2IK827O7EGMxS7bsWAIpLsyp
    Nki5nUkZyvFnIcOnHzRX05AEPezaI3SLiaR6F0NNf7i7kL1DVrZPehz+OIf7Fi0J
    /l0JNahvs4dvEzYnfztvhbGpXhe/Z5q9olhHG7XUwRsHyEKVDin77UtzHpP/hWT0
    zEZE+JVyQtEqL7UPql4UF7Gx/uzLwK3azkLmm6mW/wrrBcot2TVHlqoB0mbTPP7Q
    4jJAnXNVENPp1XkfToQ1LeGRIvEdZnvoOG0tBjPQ==
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
X-CM-Envelope: MS4wfLOr1OW9R0XQSX8vm1hc8/omF/trcQbdSHTkXRbSi3/EULgQL2b+bj/cOnXZVjr00k9ds3xU/xMks8OPcdTAtS9Pl+J+clCmcwogMZM3QmjQDdGm9gMm
    YxTJQdaMuVUYrMcGdFgwQKS0dn5fqUQxT7NWsd32TpSuCnLOCxMDm7R5WKf1iOzohFE+eoQ/w2eHBTHeGD3sTzTH8iABcjsQxIP3pOmWrp2cV7p6W5wtSXd4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=ratnzP8P1aEtoeiXtWsA:9 a=CjuIK1q_8ugA:10
    a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753888AbeDTB37 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:29:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753761AbeDTB36 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Apr 2018 21:29:58 -0400
Date: Thu, 19 Apr 2018 21:23:46 -0400
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
Subject: Re: [RFC PATCH ghak32 V2 06/13] audit: add support for non-syscall
 auxiliary records
Message-ID: <20180420012346.udnga5pfdjoazcfc@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <ee2a945fb09a939b3c214f45e49dab6a770d83e6.1521179281.git.rgb@redhat.com>
 <CAHC9VhQbPbnrbxCD1fyTSxWgrXXXYnZw_=nbOhfMCO5Q5eSsWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQbPbnrbxCD1fyTSxWgrXXXYnZw_=nbOhfMCO5Q5eSsWQ@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-18 20:39, Paul Moore wrote:
> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Standalone audit records have the timestamp and serial number generated
> > on the fly and as such are unique, making them standalone.  This new
> > function audit_alloc_local() generates a local audit context that will
> > be used only for a standalone record and its auxiliary record(s).  The
> > context is discarded immediately after the local associated records are
> > produced.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  include/linux/audit.h |  8 ++++++++
> >  kernel/auditsc.c      | 20 +++++++++++++++++++-
> >  2 files changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index ed16bb6..c0b83cb 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -227,7 +227,9 @@ static inline int audit_log_container_info(struct audit_context *context,
> >  /* These are defined in auditsc.c */
> >                                 /* Public API */
> >  extern int  audit_alloc(struct task_struct *task);
> > +extern struct audit_context *audit_alloc_local(void);
> >  extern void __audit_free(struct task_struct *task);
> > +extern void audit_free_context(struct audit_context *context);
> >  extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
> >                                   unsigned long a2, unsigned long a3);
> >  extern void __audit_syscall_exit(int ret_success, long ret_value);
> > @@ -472,6 +474,12 @@ static inline int audit_alloc(struct task_struct *task)
> >  {
> >         return 0;
> >  }
> > +static inline struct audit_context *audit_alloc_local(void)
> > +{
> > +       return NULL;
> > +}
> > +static inline void audit_free_context(struct audit_context *context)
> > +{ }
> >  static inline void audit_free(struct task_struct *task)
> >  { }
> >  static inline void audit_syscall_entry(int major, unsigned long a0,
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 2932ef1..7103d23 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -959,8 +959,26 @@ int audit_alloc(struct task_struct *tsk)
> >         return 0;
> >  }
> >
> > -static inline void audit_free_context(struct audit_context *context)
> > +struct audit_context *audit_alloc_local(void)
> >  {
> > +       struct audit_context *context;
> > +
> > +       if (!audit_ever_enabled)
> > +               return NULL; /* Return if not auditing. */
> > +
> > +       context = audit_alloc_context(AUDIT_RECORD_CONTEXT);
> > +       if (!context)
> > +               return NULL;
> > +       context->serial = audit_serial();
> > +       context->ctime = current_kernel_time64();
> > +       context->in_syscall = 1;
> > +       return context;
> > +}
> > +
> > +inline void audit_free_context(struct audit_context *context)
> > +{
> > +       if (!context)
> > +               return;
> >         audit_free_names(context);
> >         unroll_tree_refs(context, NULL, 0);
> >         free_tree_refs(context);
> 
> I'm reserving the option to comment on this idea further as I make my
> way through the patchset, but audit_free_context() definitely
> shouldn't be declared as an inline function.

Ok, I think I follow.  When it wasn't exported, inline was fine, but now
that it has been exported, it should no longer be inlined, or should use
an intermediate function name to export so that local uses of it can
remain inline.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
