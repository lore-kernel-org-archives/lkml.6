Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A62C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48040208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDR+HpQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48040208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbeHOU0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:26:21 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43420 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbeHOU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:26:21 -0400
Received: by mail-ua1-f67.google.com with SMTP id f4-v6so2037562uao.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 10:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DAx22+T6JFU1Rm2t1COBFfWz2OdoveH63Y6Fo26Wjzw=;
        b=nDR+HpQf39Tij/CvFe8nnCof/hg6C1FdBhm1qqHUv982UXyT21j+TXwEa5F5Yyb8Ng
         97/EczV5yqmKp+srotyLpyM4vZm325KzsFn78jgOg8HWAlnyVPVv/CW/ojoko45Dradu
         y7cBRhLw4byyZA2gmDRCiJj9GVB87mVBjgezF+y8IXVj1eqIOyDPz8Ml70DvLv54x//x
         jW/Rzy+3fpECGVm6qhssTManhxa+4dBwnVLU+X3qY6BKDFLJK941L7nwZNhNDyN7U0td
         06QXNgJA5PEeB30Dxmqb1RPWuuedktk4SRWfbLMJifZTPP1FZlNQVf84wnBASNrOYsbI
         yBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DAx22+T6JFU1Rm2t1COBFfWz2OdoveH63Y6Fo26Wjzw=;
        b=j4m3M75S83j7HbEkLEUAILisspkwT8ZUG9/tHTD0ndFPGp0LJS8DutdIGblL2ejj5i
         x26J+9Uor3vyjWKKe42HlAqAYabLb0WULjzvu4mjsq5/nJsuSly4XMEYiKENFoRA4YDf
         tqUMpEZ6pwXIyNWPs9hbYOQODWnYYmUSwXHbifDirefW/91rJJO651sS+KLMF3PO0rzZ
         e9q4hOXmQBr3i18XoPHyDyKDoib1t4LehdAv5tUe+QNRreP1TBEDfzlWUcBnSkUsaKqm
         APzSw7IZnrm09drSeR+dvh9nw/aw/KIRr4wrVbIpSizxPAThu0emLQxhtmMsG5vZI63z
         j/1A==
X-Gm-Message-State: AOUpUlEZ1W7AfNnpYQBUIHwnuIpty6i9rikxFTfLu5cbox9eD0jef9Ar
        3144TLDltYHaePx1sE/HcKCKq0Lxkjolg4qI5rn+MAxM
X-Google-Smtp-Source: AA+uWPxUpH0odYR1qDW9pkIP0Df7OIOHJVpwFD1fHs5cHklQ+1MuwZsCA4Ur45ftwbiYc1/ZtOTbdgX5Pg/RN+ycQOA=
X-Received: by 2002:a9f:3ed9:: with SMTP id n25-v6mr17371519uaj.25.1534354395966;
 Wed, 15 Aug 2018 10:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180815003620.15678-1-guro@fb.com> <20180815163923.GA28953@cmpxchg.org>
 <20180815165513.GA26330@castle.DHCP.thefacebook.com> <2393E780-2B97-4BEE-8374-8E9E5249E5AD@amacapital.net>
 <20180815172557.GC26330@castle.DHCP.thefacebook.com>
In-Reply-To: <20180815172557.GC26330@castle.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 15 Aug 2018 10:32:41 -0700
Message-ID: <CALvZod7TDLtr-DgqgW_0tOKei_54U1JHThpgLKr9_ObaqcC3MA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] mm: rework memcg kernel stack accounting
To:     Roman Gushchin <guro@fb.com>
Cc:     luto@amacapital.net, Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Michal Hocko <mhocko@kernel.org>, luto@kernel.org,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 10:26 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Aug 15, 2018 at 10:12:42AM -0700, Andy Lutomirski wrote:
> >
> >
> > > On Aug 15, 2018, at 9:55 AM, Roman Gushchin <guro@fb.com> wrote:
> > >
> > >> On Wed, Aug 15, 2018 at 12:39:23PM -0400, Johannes Weiner wrote:
> > >>> On Tue, Aug 14, 2018 at 05:36:19PM -0700, Roman Gushchin wrote:
> > >>> @@ -224,9 +224,14 @@ static unsigned long *alloc_thread_stack_node(=
struct task_struct *tsk, int node)
> > >>>        return s->addr;
> > >>>    }
> > >>>
> > >>> +    /*
> > >>> +     * Allocated stacks are cached and later reused by new threads=
,
> > >>> +     * so memcg accounting is performed manually on assigning/rele=
asing
> > >>> +     * stacks to tasks. Drop __GFP_ACCOUNT.
> > >>> +     */
> > >>>    stack =3D __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
> > >>>                     VMALLOC_START, VMALLOC_END,
> > >>> -                     THREADINFO_GFP,
> > >>> +                     THREADINFO_GFP & ~__GFP_ACCOUNT,
> > >>>                     PAGE_KERNEL,
> > >>>                     0, node, __builtin_return_address(0));
> > >>>
> > >>> @@ -246,12 +251,41 @@ static unsigned long *alloc_thread_stack_node=
(struct task_struct *tsk, int node)
> > >>> #endif
> > >>> }
> > >>>
> > >>> +static void memcg_charge_kernel_stack(struct task_struct *tsk)
> > >>> +{
> > >>> +#ifdef CONFIG_VMAP_STACK
> > >>> +    struct vm_struct *vm =3D task_stack_vm_area(tsk);
> > >>> +
> > >>> +    if (vm) {
> > >>> +        int i;
> > >>> +
> > >>> +        for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> > >>> +            memcg_kmem_charge(vm->pages[i], __GFP_NOFAIL,
> > >>> +                      compound_order(vm->pages[i]));
> > >>> +
> > >>> +        /* All stack pages belong to the same memcg. */
> > >>> +        mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> > >>> +                     THREAD_SIZE / 1024);
> > >>> +    }
> > >>> +#endif
> > >>> +}
> > >>
> > >> Before this change, the memory limit can fail the fork, but afterwar=
ds
> > >> fork() can grow memory consumption unimpeded by the cgroup settings.
> > >>
> > >> Can we continue to use try_charge() here and fail the fork?
> > >
> > > We can, but I'm not convinced we should.
> > >
> > > Kernel stack is relatively small, and it's already allocated at this =
point.
> > > So IMO exceeding the memcg limit for 1-2 pages isn't worse than
> > > adding complexity and handle this case (e.g. uncharge partially
> > > charged stack). Do you have an example, when it does matter?
> >
> > What bounds it to just a few pages?  Couldn=E2=80=99t there be lots of =
forks in flight that all hit this path?  It=E2=80=99s unlikely, and there a=
re surely easier DoS vectors, but still.
>
> Because any following memcg-aware allocation will fail.
> There is also the pid cgroup controlled which can be used to limit the nu=
mber
> of forks.
>
> Anyway, I'm ok to handle the this case and fail fork,
> if you think it does matter.

Roman, before adding more changes do benchmark this. Maybe disabling
the stack caching for CONFIG_MEMCG is much cleaner.

Shakeel
