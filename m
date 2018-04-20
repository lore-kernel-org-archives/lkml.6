Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-276252-1524185310-2-476013438994757235
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
    1524185309; b=brohPF1YnUv3ou8MMB+ep4SHvZBIDe3dLLsRdFyMZGQSaY/AhL
    O4aeGgSop/A73u20T5sbYmhiul5ncgQQDlGu55oY+czOFuDZ9nOVQmVK1sC7Mc0b
    h2Zo4Nr6wNV2GpHIYuxPIiGFuUbzD5uL84GJqgcwJStQ5LSkX8yKgVJhTpbgpVTF
    l6qg23vPJV5qEoRqLHHINgX0GJhEtA+AsCiifVqi6XcBHaxPS020hu/mFBKCxzyV
    76ji7B45F6F0ZyuyrhXaQ5s72e7v975bKS/70RGy9CintghHD2AC8rlo/5wf0e10
    f1RVi160XTie7uTvRONVw+VaaRCdaTs5rStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524185309; bh=bPuXsCH9vvoUe2cPiL63NqUpvNpq+1
    IUWyhBZuqRy4c=; b=aOfb2+5yC0GLYeKLQ8tqRR3IwI9GbALPxI+bh3d70lmCnM
    27zOQ7/mQ+d2N5tXb9dsVw/e/DuqqnDwJ594VTGvnbDjBeL4c0yUA1sl3Hlytwvh
    EYL/XrsmDxuCIV1ly8LMGpi1UkCt2wAHWebkGsstt0sEUbl206gEeOZ6GgR3niq3
    +hqY2oXUuChBRQ/G6cnPYr4xVrUIGphaV2LcFwRNievlLvaG+odnGIx6gCqI6aIU
    zSzfSre3iAmWaLlMGV3YnwL3K0fKLDWg4xn2yeJRKfG4EkhJCKw8bgbQycRWPxDk
    +j0dBxKpb8a6ySc9p1vAAaWkNE8gYUcMzwcP5bVQ==
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
X-CM-Envelope: MS4wfJ2Xm8qWi6TWjIk/NGJbjmSIALf/25y3bGGqHgnkPFy7Fk//NRqMF3VXiX1dw5OfFLg8vK/UpbOW7gvsIi2HdGVnXxrbCEi20MsLhc+yg/DR5x/E+O5D
    81J5eeIhmgxR1/7ltkHUyAwWxy1rttehCsYHOiFHUrlRaV2UR1W6QHU77nUa/m8eO/u3Q8ojq9VPi4XKKpvuWsKj6zXU2Ga14PU9gk4lrDUEjYds42ivHxtn
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8 a=ndJeeUOnzHKxravztLIA:9
    a=CjuIK1q_8ugA:10 a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754033AbeDTAs2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 20:48:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754029AbeDTAsZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Apr 2018 20:48:25 -0400
Date: Thu, 19 Apr 2018 20:42:18 -0400
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
Subject: Re: [RFC PATCH ghak32 V2 10/13] audit: add containerid support for
 seccomp and anom_abend records
Message-ID: <20180420004218.tgndd474wgueyjzk@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <11174597083f89352f1d6491ec94e27f882625d9.1521179281.git.rgb@redhat.com>
 <CAHC9VhS6MKoLkzpfcmYBSNnvrtbL2FOF5PX9uOfivSVEWykkQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhS6MKoLkzpfcmYBSNnvrtbL2FOF5PX9uOfivSVEWykkQg@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-18 21:31, Paul Moore wrote:
> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Add container ID auxiliary records to secure computing and abnormal end
> > standalone records.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/auditsc.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 7103d23..2f02ed9 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2571,6 +2571,7 @@ static void audit_log_task(struct audit_buffer *ab)
> >  void audit_core_dumps(long signr)
> >  {
> >         struct audit_buffer *ab;
> > +       struct audit_context *context = audit_alloc_local();
> 
> Looking quickly at do_coredump() I *believe* we can use current here.
> 
> >         if (!audit_enabled)
> >                 return;
> > @@ -2578,19 +2579,22 @@ void audit_core_dumps(long signr)
> >         if (signr == SIGQUIT)   /* don't care for those */
> >                 return;
> >
> > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_ANOM_ABEND);
> > +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_ANOM_ABEND);
> >         if (unlikely(!ab))
> >                 return;
> >         audit_log_task(ab);
> >         audit_log_format(ab, " sig=%ld res=1", signr);
> >         audit_log_end(ab);
> > +       audit_log_container_info(context, "abend", audit_get_containerid(current));
> > +       audit_free_context(context);
> >  }
> >
> >  void __audit_seccomp(unsigned long syscall, long signr, int code)
> >  {
> >         struct audit_buffer *ab;
> > +       struct audit_context *context = audit_alloc_local();
> 
> We can definitely use current here.

Ok, so both syscall aux records.  That elimintes this patch from the
set, can go in independently.

> > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_SECCOMP);
> > +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_SECCOMP);
> >         if (unlikely(!ab))
> >                 return;
> >         audit_log_task(ab);
> > @@ -2598,6 +2602,8 @@ void __audit_seccomp(unsigned long syscall, long signr, int code)
> >                          signr, syscall_get_arch(), syscall,
> >                          in_compat_syscall(), KSTK_EIP(current), code);
> >         audit_log_end(ab);
> > +       audit_log_container_info(context, "seccomp", audit_get_containerid(current));
> > +       audit_free_context(context);
> >  }
> >
> >  struct list_head *audit_killed_trees(void)
> 
> -- 
> paul moore
> www.paul-moore.com
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
