Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-276252-1524186592-2-14720791078557429856
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
    1524186592; b=Sd+PWaLcbpjQTxiSqhr+65Bci4Jb8Q0ZRAP58glGceNsci0QhO
    DB8arHLwXUYJZ6eoOBYfJqrwy1zfoyyunkUvlp1QvSR/L/7k+lflJIQr+ZHYIjdd
    yhnbKnwcccS9E42yqQo+Gc2cTj2lC5ztEyphf3SZ6MSD3h4jIDipJXOD8SAecrOG
    aapMXofPkgMIhCOVz6NQCzBbrtMOYd+OkNW7+KKO1vZOJ3ZZfSa4uINwNwheGtD8
    uKAu7HyedncqXFtbL1tdmqoddhtRBrzXBdVxUk6ykGpzfNgoaac5VrRWm3J8v/s4
    cqS4RER6WEJBtXz7ccLX45AXYs4UsrMJFc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524186592; bh=k9gJ4101s60joxx0Y6XMm+5QVNf1W6
    x2p049+/Cp4c4=; b=UhAOBdjywXsM2xNIcEIENUs/DT6fEk7TlXIKwF0nNA//i0
    hQO0fgKzFRCA3NI42mcTIrzD9ibuHdozlqBOtAz3tSuLA+bfLWDL156wOvG4+JSj
    9caZB7eKlt2lYRCM6OU0bOcZVcrddfeuwmQ/RGOi0QEheXnX1H+KX1gtiMSrzgZz
    DWHmM9gnicOowhtErPfA+BPCJEPvqS9djqkfJlc8pFeTLR3eMPSD55gwtRTsnSJ4
    lKPL6C3ohS6ZKMmn3Gw9hq7cPzdKXWjf207tYDhIlZ2S90xsXNOhYT91/R9mjVtr
    IyJ2BpDc/twOC9IrM7H/Nh2rcFsyO5wN8y6Z/g2A==
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
X-CM-Envelope: MS4wfK5VoUBkb82A9aoVGFr8mMm7nvRrZA2FjX68wDNJVzIn4eM5ns1qS/+DyRXa9LeJ7COetsYAER0qTj9AsJFMtmPBoxkCaAIUl2dc4/08t2t1D6NpYvTT
    yJCFBwzwACEV9Vd4inV9QboqotQyGgDEP/xvy3lbiRcF+hl54C4b8R0807NUOVXZALio/ssZQax+vBD4gaDRlZMR0rrBRhC4grLVpof9P95StdAOkI5HNBBZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8 a=0FOuHb0FKfGLd5_SaI0A:9
    a=CjuIK1q_8ugA:10 a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbeDTBJ2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:09:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754002AbeDTBJ0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Apr 2018 21:09:26 -0400
Date: Thu, 19 Apr 2018 21:03:20 -0400
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
Subject: Re: [RFC PATCH ghak32 V2 05/13] audit: add containerid support for
 ptrace and signals
Message-ID: <20180420010320.panie6mtdafxl65y@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <8c7ff567377f4a83edac48e962c1b5b824b523c8.1521179281.git.rgb@redhat.com>
 <CAHC9VhTy4fX1hYfD5tppbP-fRaVRMXOfeJ=Et96J_rc7Jw12Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTy4fX1hYfD5tppbP-fRaVRMXOfeJ=Et96J_rc7Jw12Bw@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-18 20:32, Paul Moore wrote:
> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Add container ID support to ptrace and signals.  In particular, the "op"
> > field provides a way to label the auxiliary record to which it is
> > associated.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  include/linux/audit.h | 16 +++++++++++-----
> >  kernel/audit.c        | 12 ++++++++----
> >  kernel/audit.h        |  2 ++
> >  kernel/auditsc.c      | 19 +++++++++++++++----
> >  4 files changed, 36 insertions(+), 13 deletions(-)
> 
> ...
> 
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index a12f21f..b238be5 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -142,6 +142,7 @@ struct audit_net {
> >  kuid_t         audit_sig_uid = INVALID_UID;
> >  pid_t          audit_sig_pid = -1;
> >  u32            audit_sig_sid = 0;
> > +u64            audit_sig_cid = INVALID_CID;
> >
> >  /* Records can be lost in several ways:
> >     0) [suppressed in audit_alloc]
> > @@ -1438,6 +1439,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
> >                         memcpy(sig_data->ctx, ctx, len);
> >                         security_release_secctx(ctx, len);
> >                 }
> > +               sig_data->cid = audit_sig_cid;
> >                 audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
> >                                  sig_data, sizeof(*sig_data) + len);
> >                 kfree(sig_data);
> > @@ -2051,20 +2053,22 @@ void audit_log_session_info(struct audit_buffer *ab)
> >
> >  /*
> >   * audit_log_container_info - report container info
> > - * @tsk: task to be recorded
> >   * @context: task or local context for record
> > + * @op: containerid string description
> > + * @containerid: container ID to report
> >   */
> > -int audit_log_container_info(struct task_struct *tsk, struct audit_context *context)
> > +int audit_log_container_info(struct audit_context *context,
> > +                             char *op, u64 containerid)
> >  {
> >         struct audit_buffer *ab;
> >
> > -       if (!audit_containerid_set(tsk))
> > +       if (!cid_valid(containerid))
> >                 return 0;
> >         /* Generate AUDIT_CONTAINER_INFO with container ID */
> >         ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONTAINER_INFO);
> >         if (!ab)
> >                 return -ENOMEM;
> > -       audit_log_format(ab, "contid=%llu", audit_get_containerid(tsk));
> > +       audit_log_format(ab, "op=%s contid=%llu", op, containerid);
> >         audit_log_end(ab);
> >         return 0;
> >  }
> 
> Let's get these changes into the first patch where
> audit_log_container_info() is defined.  Why?  This inserts a new field
> into the record which is a no-no.  Yes, it is one single patchset, but
> they are still separate patches and who knows which patches a given
> distribution and/or tree may decide to backport.

Fair enough.  That first thought went through my mind...  Would it be
sufficient to move that field addition to the first patch and leave the
rest here to support trace and signals?

> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 2bba324..2932ef1 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -113,6 +113,7 @@ struct audit_aux_data_pids {
> >         kuid_t                  target_uid[AUDIT_AUX_PIDS];
> >         unsigned int            target_sessionid[AUDIT_AUX_PIDS];
> >         u32                     target_sid[AUDIT_AUX_PIDS];
> > +       u64                     target_cid[AUDIT_AUX_PIDS];
> >         char                    target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
> >         int                     pid_count;
> >  };
> > @@ -1422,21 +1423,27 @@ static void audit_log_exit(struct audit_context *context, struct task_struct *ts
> >         for (aux = context->aux_pids; aux; aux = aux->next) {
> >                 struct audit_aux_data_pids *axs = (void *)aux;
> >
> > -               for (i = 0; i < axs->pid_count; i++)
> > +               for (i = 0; i < axs->pid_count; i++) {
> > +                       char axsn[sizeof("aux0xN ")];
> > +
> > +                       sprintf(axsn, "aux0x%x", i);
> >                         if (audit_log_pid_context(context, axs->target_pid[i],
> >                                                   axs->target_auid[i],
> >                                                   axs->target_uid[i],
> >                                                   axs->target_sessionid[i],
> >                                                   axs->target_sid[i],
> > -                                                 axs->target_comm[i]))
> > +                                                 axs->target_comm[i])
> > +                           && audit_log_container_info(context, axsn, axs->target_cid[i]))
> 
> Shouldn't this be an OR instead of an AND?

Yes.  Bash-brain...

> >                                 call_panic = 1;
> > +               }
> >         }
> >
> >         if (context->target_pid &&
> >             audit_log_pid_context(context, context->target_pid,
> >                                   context->target_auid, context->target_uid,
> >                                   context->target_sessionid,
> > -                                 context->target_sid, context->target_comm))
> > +                                 context->target_sid, context->target_comm)
> > +           && audit_log_container_info(context, "target", context->target_cid))
> 
> Same question.

Yes.

> >                         call_panic = 1;
> >
> >         if (context->pwd.dentry && context->pwd.mnt) {
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
