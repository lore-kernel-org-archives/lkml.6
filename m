Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3081306-1524141057-2-2357793268817082036
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524141056; b=GybOZHpbzxru1OPD0cC8c3ygZbBTzDTDsib+j1sFHrfHtFj+Zs
    kFfSiWf/8Z2fWqkBzdwoNA8a9bBfYEOnz/v5odMKrD10xkeH7BFE3Kae5jUDEB7r
    hDPYo66oHuYOYpH9FGcBXZC1xrxWirSp617fJxKnWy/TinNl01Z5wY0eB8/23Vag
    5aofeq3Y8V9M2CmfM46CUDnarY/cdGRqKzxYETlRJFikMdlPPMwI3MSFvb/y9GwL
    Th0yyn2bSIEbMGEEintgUpDHgQeEdPfhAeAYk7dFBPMu8+17Y3gJ8GjseL6D/o4p
    mFdolBqyPBuMLef2kyw2uGQSu5j5Dj0Enz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524141056; bh=+zxuDhML6I6T8M/H1LMvGNzq6SnkUq
    cMzTRA+PJ7wnc=; b=pVNa5fDvbT536HTac10l1d/ZAQK1Go/iEGCXeR1aLN4KWB
    hl5iRauCRd+ztSrX+P3aA6qQZu4NLZINKBecvdgHT1rBjADcpN/bTFv/n3zzYvuI
    KNNpjCGQjRePPHuJfxhzWz3EWtvWuzSjrelhvCCJa3+5sS+Q3mKROmqLk0EGwICO
    ebbdCndunE6DNwAZPQ4Vd/zysSz6pht97HLxlhpvfRaOp+ZCuJzVpGiNryCRtcUh
    cNNqVwwOOigUxx4C1jnsuUUklPoUYGKMv5vXJG+kQCy2ql86fYzDUuB+GGwXSGD3
    l6O6z3ipeDtcoCkO2vHqsSmYTJWLlFnpUxVVCK/g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfDiv6LX2m8VuO8Mh9Hf43II/xL3e8E0g6fF8av33nhVj6JAYTyQZPGNVTdAxOix1HAg5+TBywhGiz+eU5SegOV7CNmJCqSlQLB5Aydjy1kKsdqPgV1be
    T0PFkZrkoxR9ryaWmGPJPXvtU6/ECUPS3Vz2jdzUuMOf9LIJnz7rj9Qu9V/JnsJ2MpBHrbRpJwUsIYk7dh3q/Au3rIllKzNynNzx7KQwit1ZJu2rqfrTjRqF
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8 a=aei1pZjj80BV82fncPwA:9
    a=CjuIK1q_8ugA:10 a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbeDSMap (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 08:30:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752028AbeDSMan (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Apr 2018 08:30:43 -0400
Date: Thu, 19 Apr 2018 08:24:45 -0400
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
Subject: Re: [RFC PATCH ghak32 V2 07/13] audit: add container aux record to
 watch/tree/mark
Message-ID: <20180419122445.7dkmk5qh7ak3ona6@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <737f914a88d048b9985984c0ce1f946c30ca374c.1521179281.git.rgb@redhat.com>
 <CAHC9VhTzp-r2TFytt1zTEpeGK=O5dEnLPFw-CdsM1ttpY0a30g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTzp-r2TFytt1zTEpeGK=O5dEnLPFw-CdsM1ttpY0a30g@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-18 20:42, Paul Moore wrote:
> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Add container ID auxiliary record to mark, watch and tree rule
> > configuration standalone records.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/audit_fsnotify.c |  5 ++++-
> >  kernel/audit_tree.c     |  5 ++++-
> >  kernel/audit_watch.c    | 33 +++++++++++++++++++--------------
> >  3 files changed, 27 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> > index 52f368b..18c110d 100644
> > --- a/kernel/audit_fsnotify.c
> > +++ b/kernel/audit_fsnotify.c
> > @@ -124,10 +124,11 @@ static void audit_mark_log_rule_change(struct audit_fsnotify_mark *audit_mark, c
> >  {
> >         struct audit_buffer *ab;
> >         struct audit_krule *rule = audit_mark->rule;
> > +       struct audit_context *context = audit_alloc_local();
> >
> >         if (!audit_enabled)
> >                 return;
> 
> Move the audit_alloc_local() after the audit_enabled check.

Already fixed in V3 as previously warned, by making all
AUDIT_CONFIG_CHANGE records SYSCALL auxiliary records.

> > -       ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
> > +       ab = audit_log_start(context, GFP_NOFS, AUDIT_CONFIG_CHANGE);
> >         if (unlikely(!ab))
> >                 return;
> >         audit_log_format(ab, "auid=%u ses=%u op=%s",
> > @@ -138,6 +139,8 @@ static void audit_mark_log_rule_change(struct audit_fsnotify_mark *audit_mark, c
> >         audit_log_key(ab, rule->filterkey);
> >         audit_log_format(ab, " list=%d res=1", rule->listnr);
> >         audit_log_end(ab);
> > +       audit_log_container_info(context, "config", audit_get_containerid(current));
> > +       audit_free_context(context);
> >  }
> >
> >  void audit_remove_mark(struct audit_fsnotify_mark *audit_mark)
> > diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> > index 67e6956..7c085be 100644
> > --- a/kernel/audit_tree.c
> > +++ b/kernel/audit_tree.c
> > @@ -496,8 +496,9 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
> >  static void audit_tree_log_remove_rule(struct audit_krule *rule)
> >  {
> >         struct audit_buffer *ab;
> > +       struct audit_context *context = audit_alloc_local();
> 
> Sort of independent of the audit container ID work, but shouldn't we
> have an audit_enabled check here?

Same.

> > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> > +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> >         if (unlikely(!ab))
> >                 return;
> >         audit_log_format(ab, "op=remove_rule");
> > @@ -506,6 +507,8 @@ static void audit_tree_log_remove_rule(struct audit_krule *rule)
> >         audit_log_key(ab, rule->filterkey);
> >         audit_log_format(ab, " list=%d res=1", rule->listnr);
> >         audit_log_end(ab);
> > +       audit_log_container_info(context, "config", audit_get_containerid(current));
> > +       audit_free_context(context);
> >  }
> >
> >  static void kill_rules(struct audit_tree *tree)
> > diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> > index 9eb8b35..60d75a2 100644
> > --- a/kernel/audit_watch.c
> > +++ b/kernel/audit_watch.c
> > @@ -238,20 +238,25 @@ static struct audit_watch *audit_dupe_watch(struct audit_watch *old)
> >
> >  static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watch *w, char *op)
> >  {
> > -       if (audit_enabled) {
> > -               struct audit_buffer *ab;
> > -               ab = audit_log_start(NULL, GFP_NOFS, AUDIT_CONFIG_CHANGE);
> > -               if (unlikely(!ab))
> > -                       return;
> > -               audit_log_format(ab, "auid=%u ses=%u op=%s",
> > -                                from_kuid(&init_user_ns, audit_get_loginuid(current)),
> > -                                audit_get_sessionid(current), op);
> > -               audit_log_format(ab, " path=");
> > -               audit_log_untrustedstring(ab, w->path);
> > -               audit_log_key(ab, r->filterkey);
> > -               audit_log_format(ab, " list=%d res=1", r->listnr);
> > -               audit_log_end(ab);
> > -       }
> > +       struct audit_buffer *ab;
> > +       struct audit_context *context = audit_alloc_local();
> > +
> > +       if (!audit_enabled)
> > +               return;
> 
> Same as above, do the allocation after the audit_enabled check.

Same.

> > +       ab = audit_log_start(context, GFP_NOFS, AUDIT_CONFIG_CHANGE);
> > +       if (unlikely(!ab))
> > +               return;
> > +       audit_log_format(ab, "auid=%u ses=%u op=%s",
> > +                        from_kuid(&init_user_ns, audit_get_loginuid(current)),
> > +                        audit_get_sessionid(current), op);
> > +       audit_log_format(ab, " path=");
> > +       audit_log_untrustedstring(ab, w->path);
> > +       audit_log_key(ab, r->filterkey);
> > +       audit_log_format(ab, " list=%d res=1", r->listnr);
> > +       audit_log_end(ab);
> > +       audit_log_container_info(context, "config", audit_get_containerid(current));
> > +       audit_free_context(context);
> >  }
> 
> -- 
> paul moore
> www.paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
