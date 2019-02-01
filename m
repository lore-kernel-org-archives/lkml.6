Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913C1C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481CC20870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="SJsow6CE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfBADx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 22:53:58 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42420 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfBADx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 22:53:57 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so3985186lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 19:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bA/ClkmS25Hm9r7WIIaI0TjU8T/JfqQDUeslxZ+jgKg=;
        b=SJsow6CEBN74MaMxDsN/957HWSI4xOhdElId2P345JGe+0Fv4tqMy+w90Y0B1IrOqQ
         saicyng/pVio0iFX0uY8V9cUFu8GLyhKn4EDkQ631ss/iPvdqDBTRLMjDpILjr/67urY
         Et4tPF6X8DZVbvAm+eR+v7oQrXWSX3pII7JnSMJP1HEj9LjhaVrP+N21rM2j0Us39i0I
         zXnET83V+Q+PjrGoQw9GdWxprtr/4omx6V4UZktYo2Fo+MwVW66R1qFctxPw1dVvn9/a
         S46OlFJcK/rLy+FlJQN8GN81ipmpqKnUBijIrsIeEPxcMMwxSdDrg2g9257On2wECQvm
         ykmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bA/ClkmS25Hm9r7WIIaI0TjU8T/JfqQDUeslxZ+jgKg=;
        b=f6bbzAVLm82KN7kgp7GKL4z/hRt35EHscAWGTDBwk4vw+VZxltt4ZvH9b82UG5Mmty
         KiUKLo6vfOwEHJR2ubtarX5zgF8dImCN9CcNAvomc2VW1sq4XU9PKaurBhS9i7IfoGvV
         q7S6m/JDjta5gjgRYGh5kbR9gxLs5nvrkNX7W3YDYnB/rJ5cW47qtR1rL4qu92hVC9hy
         eJFIGmsHIFZj/e5nX2HaMdf4bwTiesnENmkd2U2cv+lx6XQszeWRXogKVCLY3sSjPHDq
         jDOV5rFaz97S+cBSfJvB+z+ldJ8T9ReC0GWsmdXuthhvo7yW8ecY8tg9u+LRrUohGp1c
         WeuA==
X-Gm-Message-State: AJcUukfjKHfa63EBh7ojT3+FNtnd5294/Ntd7zQ3sHwLmpuAzlAN/Xz6
        r1sZHb5NV55T0uS+FHEtuefw77LAsZzZKO+Y2v/t
X-Google-Smtp-Source: ALg8bN7Tw1emPMIU4+6+2yeDssUqdE4qi2alRiDCRpsedWvWB5NsArAM0fsvDNcnIpzUE4HNMKx4J0WWwvZEixIxqhY=
X-Received: by 2002:a19:4287:: with SMTP id p129mr30093100lfa.135.1548993234245;
 Thu, 31 Jan 2019 19:53:54 -0800 (PST)
MIME-Version: 1.0
References: <6378bddc2ca871615ebbdaffe17ee0b4482c44a0.1548700115.git.rgb@redhat.com>
 <CAHC9VhQkLAgEUf6Rc6ovDyiJuNvm6PaKp0gGzDus6nkKDekWww@mail.gmail.com>
 <20190129231750.i3yxoqv3jb352dwk@madcap2.tricolour.ca> <CAHC9VhRoTkXgiD8vRtHZFERL+pdDhobuAh9yb_0pFXe__pQmzg@mail.gmail.com>
 <20190130025443.ccby2yjwsdeofxrq@madcap2.tricolour.ca>
In-Reply-To: <20190130025443.ccby2yjwsdeofxrq@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 31 Jan 2019 22:53:43 -0500
Message-ID: <CAHC9VhTGu6ZJekAyOp+HtH04kXCx7v+Jnyk=91VCVEXp-5hsYw@mail.gmail.com>
Subject: Re: [PATCH ghak105 V2] audit: remove audit_context when CONFIG_ AUDIT
 and not AUDITSYSCALL
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 9:54 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-01-29 18:26, Paul Moore wrote:
> > On Tue, Jan 29, 2019 at 6:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2019-01-29 18:07, Paul Moore wrote:
> > > > On Mon, Jan 28, 2019 at 1:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > Remove audit_context from struct task_struct and struct audit_buffer
> > > > > when CONFIG_AUDIT is enabled but CONFIG_AUDITSYSCALL is not.
> > > > >
> > > > > Also, audit_log_name() (and supporting inode and fcaps functions) should
> > > > > have been put back in auditsc.c when soft and hard link logging was
> > > > > normalized since it is only used by syscall auditing.
> > > > >
> > > > > See github issue https://github.com/linux-audit/audit-kernel/issues/105
> > > > >
> > > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > > ---
> > > > > Changelog:
> > > > > v2:
> > > > > - resolve merge conflicts from rebase on upstreamed ghak103 patch
> > > > > - wrap task_struct audit_context in CONFIG_AUDITSYSCALL
> > > > >
> > > > >  include/linux/sched.h |   4 +-
> > > > >  kernel/audit.c        | 157 +++-----------------------------------------------
> > > > >  kernel/audit.h        |   9 ---
> > > > >  kernel/auditsc.c      | 150 +++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  4 files changed, 161 insertions(+), 159 deletions(-)
> > > >
> > > > ...
> > > >
> > > > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > > > index 3f3f1888cac7..15e41603fd34 100644
> > > > > --- a/kernel/audit.c
> > > > > +++ b/kernel/audit.c
> > > > > @@ -205,7 +205,9 @@ struct audit_net {
> > > > >   * use simultaneously. */
> > > > >  struct audit_buffer {
> > > > >         struct sk_buff       *skb;      /* formatted skb ready to send */
> > > > > +#ifdef CONFIG_AUDITSYSCALL
> > > > >         struct audit_context *ctx;      /* NULL or associated context */
> > > > > +#endif
> > > > >         gfp_t                gfp_mask;
> > > > >  };
> > > > >
> > > > > @@ -1696,7 +1698,9 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
> > > > >         if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
> > > > >                 goto err;
> > > > >
> > > > > +#ifdef CONFIG_AUDITSYSCALL
> > > > >         ab->ctx = ctx;
> > > > > +#endif
> > > >
> > > > I vaguely remember reading/hearing something in the past about
> > > > kmem_cache_alloc() not returning a zero'd out buffer in all cases, can
> > > > you say for certain that "ab" in this case is always going to be
> > > > zero'd out?  This is an honest question.
> > >
> > > Ok, then maybe we should be using kmem_cache_zalloc() instead of
> > > kmem_cache_alloc() in audit_buffer_alloc()?  (as I've done in
> > > the last patch of ghak81/first patch of ghak90)
> > >
> > > If this is too much overhead, then we can initialize ctx = NULL;
> >
> > We don't need zalloc() since we're setting all the fields, although
> > more on this below ...
>
> Ok...
>
> > > > If we can't guarantee that "ab" is zero'd out, we should manually set
> > > > ab->ctx to NULL when !CONFIG_AUDITSYSCALL.
> > >
> > > But ctx isn't part of struct audit_buffer when !CONFIG_AUDITSYSCALL.  It
> > > is #ifdef-ed out.  What am I missing?
> >
> > You're not, I am.  I saw the obvious bit where you removed it from the
> > task_struct, but completely glossed over the bit where you also
> > removed it from the audit_buffer struct.  My mistake.
> >
> > Once the audit container ID stuff lands we are going to need to have
> > the audit_context pointer in the audit_buffer regardless of the
> > CONFIG_AUDITSYSCALL setting, right?  Assuming the answer is yes, I
> > think I'd just assume leave the pointer in the audit_buffer (setting
> > it to NULL when !CONFIG_AUDITSYSCALL) so we don't have to have those
> > #ifdef's in the middle of the functions (I generally like to avoid
> > those if possible).  I think it's still worth making the changes to
> > task_struct, as that is the right thing to do and doesn't have the
> > same level of impact.
>
> I like to avoid #ifdef compiler directives out when I can too, creating
> stubs in the header file to do the job.
>
> Why do we need an audit_context pointer in struct audit_buffer?  I'll
> take a stab at answering this...  I was thinking it wasn't necessary,
> but now I think I see what I was missing.  I think the only reason is to
> connect records to one event through the timestamp and serial number
> when syscall is disabled.  Up until now it wasn't needed unless full
> syscall functionality was present, but once we have an audit container
> identifier aux record we will need to join them, at minimum with a local
> context for user and netfilter_pkt records.

I also expect us the significance to grow over time as we start to
deal with the event routing problem; one solution would be to track
the audit container ID as a field in the audit_context.

Basically I see the audit_context as the audit "event" data structure
where the audit_buffer is the audit "record" data structure.  Their
use doesn't always line up perfectly with those definitions at
present, but I tend to think of the deviations as problems to correct
over time.

> So I have to ask, does it make sense to restructure things so that the
> struct audit_buffer has a serial and ctime field so that it isn't needed
> in the struct audit_context?  I'm not sure if this is possible.  I'll
> have to go back and look at the code to see if this is the case...

I would say "no" if for no other reason than what I said about about
the audit_context being the "event" data structure.

-- 
paul moore
www.paul-moore.com
