Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8166BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240A72170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9tDhGht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240A72170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeHUNkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:40:23 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41929 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeHUNkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:40:23 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so31074103oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 03:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vA/JCh58R8QCWFOfit0ENKup+HumIfAXgVw9J6ORBpQ=;
        b=Q9tDhGhtbvA+cr9Ju0Lvfp06cSfLvNtfFA+NRIr+mFUslfuI5m4zBq6AeyBKr+FrQE
         zT6z2d0Y7McjxbY/VD1ixYyeYUp7OZ3h37w4gkqKtZuCIONF8iygFUnMRvD2izkUJPoL
         ExH/dt002ZUJ04h9G88RZ7Oi2kWKFTiL9wRyxp5PNk/giE7Te1HevS87y9M5kmNvrOJv
         ySvIr3ll4Gajy05RS6TbnjbIjJJ2n4cD9Q+FvacCPYQOdnAO3znv5RqnomCf5cYiwkg7
         keMn1oU/a38t7ZGQ5/ZvOeJslkQabZs7dIPWk7rBAwGYGoOwcEFZoAgVKN356B5zt+vP
         vXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vA/JCh58R8QCWFOfit0ENKup+HumIfAXgVw9J6ORBpQ=;
        b=fV0bi6vh3YRe8p9KaG0LhGu+B5xSZgSvCf6OtmQigNzaTEX9jo3TgXPS8TR8sfMe/u
         5/V5BmfmzCWnKdeX2ehQ/uKTWJC+vLzb/4RjhDmOG7iRWYjXyhnCwkap6E6pmXFKYmcb
         mHl/Nvcluc1vkpptdmCa1BQWq823lzOmyEcUUQ2rTN5UXWehCcLLGLc8XctqWh5yFuSa
         Yg1SNbEfns3H7azn6FMdFtvKXhQwQdXXNaIXmeRV5xhi0Yx0TsJdPkCqQUP9Uh9VSuO3
         PgED/yGUMeeZDJAOxyciTsuaTNPI88SBSXjBY3M/3EB8P9NvYsqwJjbaqcw67x5/IIvT
         JCbg==
X-Gm-Message-State: APzg51CKp44LPBbRFgwl1EolsBdPuvSVbogEsx8gG/wgJUK+HGarTijU
        p2big4oCB8HZxogNBzmPd3+uIxCEhsXsb9PODncxeQTF4uY=
X-Google-Smtp-Source: AA+uWPyypTAArbYaUNX7sNXNDO041yxEdsbK3HraN60Jj7avjXgi4a1PZOTPAuh6AQLI+OrJVkMLnvO+8GiIl4S4o1A=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr18234488oia.229.1534846848271;
 Tue, 21 Aug 2018 03:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180817221624.10232-1-casey.schaufler@intel.com>
 <20180817221624.10232-3-casey.schaufler@intel.com> <CAG48ez23G+wcnkCMNZV_mxYMS=h+pZkpx1451Wz5GB9_tcDv3Q@mail.gmail.com>
 <99FC4B6EFCEFD44486C35F4C281DC6732143F769@ORSMSX107.amr.corp.intel.com>
In-Reply-To: <99FC4B6EFCEFD44486C35F4C281DC6732143F769@ORSMSX107.amr.corp.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 21 Aug 2018 12:20:21 +0200
Message-ID: <CAG48ez1LHOHvB4ud+8asOjKARVLQJGV4ocdKVDJtvTXTfeMa9w@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/5] X86: Support LSM determination of side-channel vulnerability
To:     Casey Schaufler <casey.schaufler@intel.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Dave Hansen <dave.hansen@intel.com>,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 4:45 PM Schaufler, Casey
<casey.schaufler@intel.com> wrote:
>
> > -----Original Message-----
> > From: Jann Horn [mailto:jannh@google.com]
> > Sent: Friday, August 17, 2018 4:55 PM
> > To: Schaufler, Casey <casey.schaufler@intel.com>
> > Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>; kernel list
> > <linux-kernel@vger.kernel.org>; linux-security-module <linux-security-
> > module@vger.kernel.org>; selinux@tycho.nsa.gov; Hansen, Dave
> > <dave.hansen@intel.com>; Dock, Deneen T <deneen.t.dock@intel.com>;
> > kristen@linux.intel.com; Arjan van de Ven <arjan@linux.intel.com>
> > Subject: Re: [PATCH RFC v2 2/5] X86: Support LSM determination of side-
> > channel vulnerability
> >
> > On Sat, Aug 18, 2018 at 12:17 AM Casey Schaufler
> > <casey.schaufler@intel.com> wrote:
> > >
> > > From: Casey Schaufler <cschaufler@localhost.localdomain>
> > >
> > > When switching between tasks it may be necessary
> > > to set an indirect branch prediction barrier if the
> > > tasks are potentially vulnerable to side-channel
> > > attacks. This adds a call to security_task_safe_sidechannel
> > > so that security modules can weigh in on the decision.
> > >
> > > Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> > > ---
> > >  arch/x86/mm/tlb.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> > > index 6eb1f34c3c85..8714d4af06aa 100644
> > > --- a/arch/x86/mm/tlb.c
> > > +++ b/arch/x86/mm/tlb.c
> > > @@ -7,6 +7,7 @@
> > >  #include <linux/export.h>
> > >  #include <linux/cpu.h>
> > >  #include <linux/debugfs.h>
> > > +#include <linux/security.h>
> > >
> > >  #include <asm/tlbflush.h>
> > >  #include <asm/mmu_context.h>
> > > @@ -270,11 +271,14 @@ void switch_mm_irqs_off(struct mm_struct *prev,
> > struct mm_struct *next,
> > >                  * threads. It will also not flush if we switch to idle
> > >                  * thread and back to the same process. It will flush if we
> > >                  * switch to a different non-dumpable process.
> > > +                * If a security module thinks that the transition
> > > +                * is unsafe do the flush.
> > >                  */
> > > -               if (tsk && tsk->mm &&
> > > -                   tsk->mm->context.ctx_id != last_ctx_id &&
> > > -                   get_dumpable(tsk->mm) != SUID_DUMP_USER)
> > > -                       indirect_branch_prediction_barrier();
> > > +               if (tsk && tsk->mm && tsk->mm->context.ctx_id != last_ctx_id) {
> > > +                       if (get_dumpable(tsk->mm) != SUID_DUMP_USER ||
> > > +                           security_task_safe_sidechannel(tsk) != 0)
> > > +                               indirect_branch_prediction_barrier();
> > > +               }
> >
> > When you posted v1 of this series, I asked:
> >
> > | Does this enforce transitivity? What happens if we first switch from
> > | an attacker task to a task without ->mm, and immediately afterwards
> > | from the task without ->mm to a victim task? In that case, whether a
> > | flush happens between the attacker task and the victim task depends on
> > | whether the LSM thinks that the mm-less task should have access to the
> > | victim task, right?
> >
> > Have you addressed that? I don't see it...
>
> Nope. That's going to require maintaining state about all the
> tasks in the chain that might still have cache involvement.
>
>         A -> B -> C -> D

Really?

From what I can tell, it'd be enough to:

 - ensure that the LSM-based access checks behave approximately transitively
   (which I think they already do, mostly)
 - keep a copy of the metadata of the last non-kernel task on the CPU

> If B and C don't do anything cacheworthy D could conceivably attack A.
> The amount of state required to detect this case would be prohibitive.
> I think that if you're sufficiently concerned about this case you should just
> go ahead and set the barrier. I'm willing to learn something that says I'm
> wrong.

That means that an attacker who can e.g. get a CPU to first switch
from an attacker task to a softirqd (e.g. for network packet
processing or whatever), then switch from the softirqd to a root-owned
victim task would be able to bypass the check, right? That doesn't
sound like a very complicated attack...

I very much dislike the idea of adding a mitigation with a known
bypass technique to the kernel.
