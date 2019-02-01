Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD2BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00E02086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="uzzyW3Gp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBAWYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:24:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45707 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfBAWYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:24:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so6187039lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 14:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOINUbbiclqAkC+J0vrdsW9LL2jNcHlLbX8mrUyPMmc=;
        b=uzzyW3GpomhR0qdTAG+k1iUW/hGvvE+a46myX7YmJbLcBPFiWP64Evd9C1WICqCRlu
         Teemv8ZN1ZhiZSK5QrdM0PQYq4/ivRPocP/TGE4PB4DK69KULHqVrDoLW/ZAJdtmtg3H
         CLuVBK0rX/iWASd6NSmFjbT7JzarYRhaydSSQ0ob9JV3KaIKmke0XWR2FspqC+9PXTMl
         ATm8aI/ICZyBDoOLf/hZFyrrrowgwBhCttBwfe/sXOoSQXwymzp/dqkkBSQ/6HvVkCuK
         VuxUShUrBhKGVhH7mZV0OKJumxTAS8+yb+1iskbs7FQvng0/2eXAsS6BQytyYedl7mXO
         Xu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOINUbbiclqAkC+J0vrdsW9LL2jNcHlLbX8mrUyPMmc=;
        b=LA1i4rp4EK/73jAJ1TizbR3OhiOZyQBoiYnhWFnlozmaf3mqGj7tGy8zvzeGw9kQQW
         UScco/25++ung2QxVzcKmKC/260oSUj/C5Zi6Td/eNHEEJHQ4mnxc7bHbvaCUwVMZCiX
         bnVsK0DTxHGqw17MZ5pxg+DSMKM7ZfrD6cX51MqtwNCO7AQuxOkoGstDOGj2+1eaOkDd
         QVhRqBNbxpVTxQVx1Vf5ov2UGWO/qvA+5R/2QasoT/tb9PJoSnZ30axyX3ryxF4vQJxz
         r4EIMfMrAOOGZkBJwAdUNYr9EaL9Rwe0ZIy3n/9tZqj4kO6IS9ATh5G12fUlkOmK8JTj
         3yLg==
X-Gm-Message-State: AHQUAuaDb3H6HJsF+7W4Ffa2Rf7pKU7jxmk7vcrkkrMzLlOZe36xIDyg
        7M4u/p5o9JVOeZzjtZmHVui7XN+IvCI8k1f3UoNqZKk=
X-Google-Smtp-Source: AHgI3IavuSa8US40xIbQL6iIxeXHCaOmgv5OYkyLrHlQ1IFp/u/DWhbJaq7BEP5vQd/32LW/rU4KUdtMYjMbW/p4TM8=
X-Received: by 2002:ac2:43ad:: with SMTP id t13mr1815893lfl.105.1549059890966;
 Fri, 01 Feb 2019 14:24:50 -0800 (PST)
MIME-Version: 1.0
References: <6378bddc2ca871615ebbdaffe17ee0b4482c44a0.1548700115.git.rgb@redhat.com>
 <CAHC9VhQkLAgEUf6Rc6ovDyiJuNvm6PaKp0gGzDus6nkKDekWww@mail.gmail.com>
 <20190129231750.i3yxoqv3jb352dwk@madcap2.tricolour.ca> <CAHC9VhRoTkXgiD8vRtHZFERL+pdDhobuAh9yb_0pFXe__pQmzg@mail.gmail.com>
 <20190130025443.ccby2yjwsdeofxrq@madcap2.tricolour.ca> <CAHC9VhTGu6ZJekAyOp+HtH04kXCx7v+Jnyk=91VCVEXp-5hsYw@mail.gmail.com>
In-Reply-To: <CAHC9VhTGu6ZJekAyOp+HtH04kXCx7v+Jnyk=91VCVEXp-5hsYw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 Feb 2019 17:24:39 -0500
Message-ID: <CAHC9VhTah-d99tS5B7HU7tvy7NN-4BFdyjHeChg9-0y7S+gbzQ@mail.gmail.com>
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

On Thu, Jan 31, 2019 at 10:53 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jan 29, 2019 at 9:54 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2019-01-29 18:26, Paul Moore wrote:
> > > On Tue, Jan 29, 2019 at 6:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > On 2019-01-29 18:07, Paul Moore wrote:
> > > > > On Mon, Jan 28, 2019 at 1:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > Remove audit_context from struct task_struct and struct audit_buffer
> > > > > > when CONFIG_AUDIT is enabled but CONFIG_AUDITSYSCALL is not.
> > > > > >
> > > > > > Also, audit_log_name() (and supporting inode and fcaps functions) should
> > > > > > have been put back in auditsc.c when soft and hard link logging was
> > > > > > normalized since it is only used by syscall auditing.
> > > > > >
> > > > > > See github issue https://github.com/linux-audit/audit-kernel/issues/105
> > > > > >
> > > > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > > > ---
> > > > > > Changelog:
> > > > > > v2:
> > > > > > - resolve merge conflicts from rebase on upstreamed ghak103 patch
> > > > > > - wrap task_struct audit_context in CONFIG_AUDITSYSCALL
> > > > > >
> > > > > >  include/linux/sched.h |   4 +-
> > > > > >  kernel/audit.c        | 157 +++-----------------------------------------------
> > > > > >  kernel/audit.h        |   9 ---
> > > > > >  kernel/auditsc.c      | 150 +++++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  4 files changed, 161 insertions(+), 159 deletions(-)
> > > > >
> > > > > ...
> > > > >
> > > > > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > > > > index 3f3f1888cac7..15e41603fd34 100644
> > > > > > --- a/kernel/audit.c
> > > > > > +++ b/kernel/audit.c
> > > > > > @@ -205,7 +205,9 @@ struct audit_net {
> > > > > >   * use simultaneously. */
> > > > > >  struct audit_buffer {
> > > > > >         struct sk_buff       *skb;      /* formatted skb ready to send */
> > > > > > +#ifdef CONFIG_AUDITSYSCALL
> > > > > >         struct audit_context *ctx;      /* NULL or associated context */
> > > > > > +#endif
> > > > > >         gfp_t                gfp_mask;
> > > > > >  };
> > > > > >
> > > > > > @@ -1696,7 +1698,9 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
> > > > > >         if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
> > > > > >                 goto err;
> > > > > >
> > > > > > +#ifdef CONFIG_AUDITSYSCALL
> > > > > >         ab->ctx = ctx;
> > > > > > +#endif
> > > > >
> > > > > I vaguely remember reading/hearing something in the past about
> > > > > kmem_cache_alloc() not returning a zero'd out buffer in all cases, can
> > > > > you say for certain that "ab" in this case is always going to be
> > > > > zero'd out?  This is an honest question.
> > > >
> > > > Ok, then maybe we should be using kmem_cache_zalloc() instead of
> > > > kmem_cache_alloc() in audit_buffer_alloc()?  (as I've done in
> > > > the last patch of ghak81/first patch of ghak90)
> > > >
> > > > If this is too much overhead, then we can initialize ctx = NULL;
> > >
> > > We don't need zalloc() since we're setting all the fields, although
> > > more on this below ...
> >
> > Ok...
> >
> > > > > If we can't guarantee that "ab" is zero'd out, we should manually set
> > > > > ab->ctx to NULL when !CONFIG_AUDITSYSCALL.
> > > >
> > > > But ctx isn't part of struct audit_buffer when !CONFIG_AUDITSYSCALL.  It
> > > > is #ifdef-ed out.  What am I missing?
> > >
> > > You're not, I am.  I saw the obvious bit where you removed it from the
> > > task_struct, but completely glossed over the bit where you also
> > > removed it from the audit_buffer struct.  My mistake.
> > >
> > > Once the audit container ID stuff lands we are going to need to have
> > > the audit_context pointer in the audit_buffer regardless of the
> > > CONFIG_AUDITSYSCALL setting, right?  Assuming the answer is yes, I
> > > think I'd just assume leave the pointer in the audit_buffer (setting
> > > it to NULL when !CONFIG_AUDITSYSCALL) so we don't have to have those
> > > #ifdef's in the middle of the functions (I generally like to avoid
> > > those if possible).  I think it's still worth making the changes to
> > > task_struct, as that is the right thing to do and doesn't have the
> > > same level of impact.
> >
> > I like to avoid #ifdef compiler directives out when I can too, creating
> > stubs in the header file to do the job.
> >
> > Why do we need an audit_context pointer in struct audit_buffer?  I'll
> > take a stab at answering this...  I was thinking it wasn't necessary,
> > but now I think I see what I was missing.  I think the only reason is to
> > connect records to one event through the timestamp and serial number
> > when syscall is disabled.  Up until now it wasn't needed unless full
> > syscall functionality was present, but once we have an audit container
> > identifier aux record we will need to join them, at minimum with a local
> > context for user and netfilter_pkt records.
>
> I also expect us the significance to grow over time as we start to
> deal with the event routing problem; one solution would be to track
> the audit container ID as a field in the audit_context.
>
> Basically I see the audit_context as the audit "event" data structure
> where the audit_buffer is the audit "record" data structure.  Their
> use doesn't always line up perfectly with those definitions at
> present, but I tend to think of the deviations as problems to correct
> over time.
>
> > So I have to ask, does it make sense to restructure things so that the
> > struct audit_buffer has a serial and ctime field so that it isn't needed
> > in the struct audit_context?  I'm not sure if this is possible.  I'll
> > have to go back and look at the code to see if this is the case...
>
> I would say "no" if for no other reason than what I said about about
> the audit_context being the "event" data structure.

Based on your comments in another thread I realize you think I've
queued this for acceptance; I haven't.

I'll be a bit more clear: leave the audit_context pointer in the audit_buffer.

-- 
paul moore
www.paul-moore.com
