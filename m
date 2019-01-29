Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC54C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF53D20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lfKr6r/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfA2X0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:26:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46236 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfA2X0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:26:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so19027116ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 15:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qulM/OEaSA7GfdG31SAGjhbGa+wIBHLbr8qhD/zOQTc=;
        b=lfKr6r/QB3FUa4ZXDpUnhLplrzJhwFgPrV2Xwvxd0plZ74RZIulNt+NUbr4jgdCtoM
         Alz2XJk5pUDX4mZ5Oj5k888dphlTrr3W8EtrHBEvBMV2zX9updh7HejaYDPVbB+Q1aKC
         ARaA9h/tX4OLZ9p58lfg/d2aJZztV6WE/VBJ5CoJChl8REE3uzO/l1CD5MDphm6DCuhz
         BDbaK5SqOOcUrBpLkbI3IVxY2JVniDhTQQyfy1HRNg52YfAQt99hJCsR//TLEe7tlE+0
         q5aMIM28cbWB8SsC1buFrEnabAhxm/OCpTCkbJnl/t2jm0FcmTPjDcNBE8scOH7EPhbG
         EjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qulM/OEaSA7GfdG31SAGjhbGa+wIBHLbr8qhD/zOQTc=;
        b=pGKmFutCHhW/PXbyrZfWMTub5GzwQnq+Vr6aTNAyPaHwakP47bXxEnRitA2ieDhksy
         nXy1A05FzX1itzUBLJQpM08PCz6uWtMFUPFYpha+HO+FJGNccuuHWdvAwjP2yZj9aigG
         vf8DNedMuAPVOJ9YtSYGfdfHNQqkj4t0DJglU8jutA1frDkcDNfmNL1OKVHBd9RN5G7i
         SJleZ5MzbQBg6Adl4bzCHYQs4wChXmj3qcEJeK7qt9rLGylpyRgj7CSUmkrUzwbd0Fv2
         3DVv/owdmrCK3LqLPARCl8eYHtfbImo+ByRiouxxCb3a2j/IFfcQ/Di1L0j4suCS+JHt
         B6TQ==
X-Gm-Message-State: AJcUukftCnDkwDwUFg+5A04kFvYLBqpA6eak/+NYFgDFOMQxbva7S917
        uYy+KheOaxHERyjCEAWeowH2p/ySpYPFt6KIIXMW
X-Google-Smtp-Source: ALg8bN7VEwp3dUZbF60kg47q50qe1iINN2C2lF1QHbTmPbpq/0I7ENqUjIQj34HKxF3knkOnvTe8CDt9ukpVjxY5K0w=
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr22499995ljj.161.1548804392427;
 Tue, 29 Jan 2019 15:26:32 -0800 (PST)
MIME-Version: 1.0
References: <6378bddc2ca871615ebbdaffe17ee0b4482c44a0.1548700115.git.rgb@redhat.com>
 <CAHC9VhQkLAgEUf6Rc6ovDyiJuNvm6PaKp0gGzDus6nkKDekWww@mail.gmail.com> <20190129231750.i3yxoqv3jb352dwk@madcap2.tricolour.ca>
In-Reply-To: <20190129231750.i3yxoqv3jb352dwk@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Jan 2019 18:26:21 -0500
Message-ID: <CAHC9VhRoTkXgiD8vRtHZFERL+pdDhobuAh9yb_0pFXe__pQmzg@mail.gmail.com>
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

On Tue, Jan 29, 2019 at 6:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-01-29 18:07, Paul Moore wrote:
> > On Mon, Jan 28, 2019 at 1:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Remove audit_context from struct task_struct and struct audit_buffer
> > > when CONFIG_AUDIT is enabled but CONFIG_AUDITSYSCALL is not.
> > >
> > > Also, audit_log_name() (and supporting inode and fcaps functions) should
> > > have been put back in auditsc.c when soft and hard link logging was
> > > normalized since it is only used by syscall auditing.
> > >
> > > See github issue https://github.com/linux-audit/audit-kernel/issues/105
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > > Changelog:
> > > v2:
> > > - resolve merge conflicts from rebase on upstreamed ghak103 patch
> > > - wrap task_struct audit_context in CONFIG_AUDITSYSCALL
> > >
> > >  include/linux/sched.h |   4 +-
> > >  kernel/audit.c        | 157 +++-----------------------------------------------
> > >  kernel/audit.h        |   9 ---
> > >  kernel/auditsc.c      | 150 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 161 insertions(+), 159 deletions(-)
> >
> > ...
> >
> > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > index 3f3f1888cac7..15e41603fd34 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -205,7 +205,9 @@ struct audit_net {
> > >   * use simultaneously. */
> > >  struct audit_buffer {
> > >         struct sk_buff       *skb;      /* formatted skb ready to send */
> > > +#ifdef CONFIG_AUDITSYSCALL
> > >         struct audit_context *ctx;      /* NULL or associated context */
> > > +#endif
> > >         gfp_t                gfp_mask;
> > >  };
> > >
> > > @@ -1696,7 +1698,9 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
> > >         if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
> > >                 goto err;
> > >
> > > +#ifdef CONFIG_AUDITSYSCALL
> > >         ab->ctx = ctx;
> > > +#endif
> >
> > I vaguely remember reading/hearing something in the past about
> > kmem_cache_alloc() not returning a zero'd out buffer in all cases, can
> > you say for certain that "ab" in this case is always going to be
> > zero'd out?  This is an honest question.
>
> Ok, then maybe we should be using kmem_cache_zalloc() instead of
> kmem_cache_alloc() in audit_buffer_alloc()?  (as I've done in
> the last patch of ghak81/first patch of ghak90)
>
> If this is too much overhead, then we can initialize ctx = NULL;

We don't need zalloc() since we're setting all the fields, although
more on this below ...

> > If we can't guarantee that "ab" is zero'd out, we should manually set
> > ab->ctx to NULL when !CONFIG_AUDITSYSCALL.
>
> But ctx isn't part of struct audit_buffer when !CONFIG_AUDITSYSCALL.  It
> is #ifdef-ed out.  What am I missing?

You're not, I am.  I saw the obvious bit where you removed it from the
task_struct, but completely glossed over the bit where you also
removed it from the audit_buffer struct.  My mistake.

Once the audit container ID stuff lands we are going to need to have
the audit_context pointer in the audit_buffer regardless of the
CONFIG_AUDITSYSCALL setting, right?  Assuming the answer is yes, I
think I'd just assume leave the pointer in the audit_buffer (setting
it to NULL when !CONFIG_AUDITSYSCALL) so we don't have to have those
#ifdef's in the middle of the functions (I generally like to avoid
those if possible).  I think it's still worth making the changes to
task_struct, as that is the right thing to do and doesn't have the
same level of impact.

-- 
paul moore
www.paul-moore.com
