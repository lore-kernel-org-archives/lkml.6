Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EFFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 01:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC87C2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 01:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OuZpx4H4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC87C2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbeHVEYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 00:24:18 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41474 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeHVEYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 00:24:18 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so433044oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 18:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pc+VHTGnOxGT9AzLaa7nepsBfaIoc2vGshQIe0EkXS4=;
        b=OuZpx4H4/iyUYrlBum1tF/JFPdE2CeDKax/XHeP/s2oPWjIwR+zj66hjxKKgKdG6Uz
         TWF1F2htFhhb6MtaMgx6J7ecMUBOwiS4hjdfFHuqEkTwZUVMHG0HjusYRLSXtegcSl+C
         MKNt9Y6/DjiZEnW5/l5OIQqKj5/KBYvx6dfLdpX5chUnkhrYg4cMTauq0Kjcg+/Kftc1
         70UxruMm8t+4vN05uiW1YksCH3loGsHIuMFj1PW7zAXnrkYa/nfAGBbWKQSY7I6w0kP/
         iPE4C3TF6YVxZiqaJ7uDWIIOddr7UaGrkgaKPMa0zNOubl0DGRDGlH3oHspJDrrz6fpu
         EIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pc+VHTGnOxGT9AzLaa7nepsBfaIoc2vGshQIe0EkXS4=;
        b=ZpG0ppuDna0Zz8QwmoS7pV8rZT4leB8vx+yVZs3Bv5KPMI3TjItz+SeGpHHM1wine3
         ldUZTScW3RrryPB5dcfrxKKdEM+pZG2EWC6wjLB6OB4nmqRwpzAVSaiankgu5kaG4l77
         oqiZ6CRI7wA7QSwfwRwEy4lXMwQwlhgqubaSXjpi5/kT2udCGnrYOOwBbzDuLrmbAbIt
         ne2V92AqeeJE8mYjtoOai2U0TFiTd7C0uIEULW3m72ZDvW/yxILdFpxEY9BFtUv1t5lD
         agFGOB0uoSfS95uwMlF/TwtPJs20hAb5FOeTjudntRvXzR9N+ZECpaMuLX8nf6f1bGd3
         5iYQ==
X-Gm-Message-State: APzg51AEVZJ9+PWweiNw/wrGtAVx+x47cUxBS9jzRj8x0IaWLy+BeP6G
        kZQGCC9l1C42Rng8oRyfXbWtqTZ9qopJNFsxJHhS3g==
X-Google-Smtp-Source: ANB0Vda/juzpmsgrs3TYu4kgKuA8GcxtPMvAUCHxCdI/uO7TgBYmJH055j/SO2u2OOFdhRQGVcTK/qkOCO0Jl2J+2hk=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr1755389oia.229.1534899707660;
 Tue, 21 Aug 2018 18:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180821000444.7004-1-casey.schaufler@intel.com>
 <20180821000444.7004-4-casey.schaufler@intel.com> <CAG48ez1D-DPBP8ACA1W5=XZLNKUeVj7ZOGUG8uJ2nL1xOSR_9Q@mail.gmail.com>
 <99FC4B6EFCEFD44486C35F4C281DC673214402D3@ORSMSX107.amr.corp.intel.com>
In-Reply-To: <99FC4B6EFCEFD44486C35F4C281DC673214402D3@ORSMSX107.amr.corp.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 22 Aug 2018 03:01:20 +0200
Message-ID: <CAG48ez3bh5cFgZ5ZY63pszTV+KX+KC4utRCm7E8en+uF5w6vKw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] LSM: Security module checking for side-channel dangers
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

On Wed, Aug 22, 2018 at 1:44 AM Schaufler, Casey
<casey.schaufler@intel.com> wrote:
>
> > -----Original Message-----
> > From: Jann Horn [mailto:jannh@google.com]
> > Sent: Tuesday, August 21, 2018 10:24 AM
> > To: Schaufler, Casey <casey.schaufler@intel.com>
> > Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>; kernel list
> > <linux-kernel@vger.kernel.org>; linux-security-module <linux-security-
> > module@vger.kernel.org>; selinux@tycho.nsa.gov; Hansen, Dave
> > <dave.hansen@intel.com>; Dock, Deneen T <deneen.t.dock@intel.com>;
> > kristen@linux.intel.com; Arjan van de Ven <arjan@linux.intel.com>
> > Subject: Re: [PATCH v3 3/5] LSM: Security module checking for side-channel
> > dangers
> >
> > On Tue, Aug 21, 2018 at 2:05 AM Casey Schaufler
> > <casey.schaufler@intel.com> wrote:
> > >
> > > The sidechannel LSM checks for cases where a side-channel
> > > attack may be dangerous based on security attributes of tasks.
> > > This includes:
> > >         Effective UID of the tasks is different
> > >         Capablity sets are different
> > >         Tasks are in different namespaces
> > > An option is also provided to assert that task are never
> > > to be considered safe. This is high paranoia, and expensive
> > > as well.
> > >
> > > Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> > > ---
> > [...]
> > > diff --git a/security/sidechannel/Kconfig b/security/sidechannel/Kconfig
> > > new file mode 100644
> > > index 000000000000..af9396534128
> > > --- /dev/null
> > > +++ b/security/sidechannel/Kconfig
> > [...]
> > > +config SECURITY_SIDECHANNEL_CAPABILITIES
> > > +       bool "Sidechannel check on capability sets"
> > > +       depends on SECURITY_SIDECHANNEL
> > > +       default n
> > > +       help
> > > +         Assume that tasks with different sets of privilege may be
> > > +         subject to side-channel attacks. Potential interactions
> > > +         where the attacker lacks capabilities the attacked has
> > > +         are blocked.
> > > +
> > > +          If you are unsure how to answer this question, answer N.
> > > +
> > > +config SECURITY_SIDECHANNEL_NAMESPACES
> > > +       bool "Sidechannel check on namespaces"
> > > +       depends on SECURITY_SIDECHANNEL
> > > +       depends on NAMESPACES
> > > +       default n
> > > +       help
> > > +         Assume that tasks in different namespaces may be
> > > +         subject to side-channel attacks. User, PID and cgroup
> > > +         namespaces are checked.
> > > +
> > > +          If you are unsure how to answer this question, answer N.
> > [...]
> > > diff --git a/security/sidechannel/sidechannel.c
> > b/security/sidechannel/sidechannel.c
> > > new file mode 100644
> > > index 000000000000..4da7d6dafdc5
> > > --- /dev/null
> > > +++ b/security/sidechannel/sidechannel.c
> > [...]
> > > +/*
> > > + * safe_by_capability - Are task and current sidechannel safe?
> > > + * @p: task to check on
> > > + *
> > > + * Returns 0 if the tasks are sidechannel safe, -EACCES otherwise.
> > > + */
> > > +#ifdef CONFIG_SECURITY_SIDECHANNEL_CAPABILITIES
> > > +static int safe_by_capability(struct task_struct *p)
> > > +{
> > > +       const struct cred *ccred = current_real_cred();
> > > +       const struct cred *pcred = rcu_dereference_protected(p->real_cred, 1);
> > > +
> > > +       /*
> > > +        * Capabilities checks. Considered safe if:
> > > +        *      current has all the capabilities p does
> > > +        */
> > > +       if (ccred != pcred &&
> > > +           !cap_issubset(pcred->cap_effective, ccred->cap_effective))
> > > +               return -EACCES;
> > > +       return 0;
> > > +}
> >
> > On its own (without safe_by_namespace()), this check makes no sense, I
> > think. You're performing a test on the namespaced capability sets
> > without looking at which user namespaces they are relative to. Maybe
> > either introduce a configuration dependency or add an extra namespace
> > check here?
>
> If you don't have namespaces the check is correct. If you do, and use
> safe_by_namespace() you're also correct. If you use namespaces and
> care about side-channel attacks you should enable the namespace checks.

By "use namespaces", you mean "have CONFIG_USER_NS=y set in the kernel
config", right?
It doesn't matter much whether processes on your system are
intentionally using namespaces; what matters is whether some random
process can just use unshare(CLONE_NEWUSER) to increase its apparent
capabilities and bypass the checks performed by this LSM.
My expectation is that unshare(CLONE_NEWUSER) should not increase the
caller's abilities. Your patch seems to violate that expectation.

> I don't see real value in adding namespace checks in the capability checks
> for the event where someone has said they don't want namespace checks.

Capabilities are meaningless if you don't consider the namespaces
relative to which they are effective. Anyone can get CAP_SYS_ADMIN or
whatever other capabilities they want, by design - just not relative
to objects they don't own. Look:

$ grep ^Cap /proc/self/status
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000
CapBnd: 0000003fffffffff
CapAmb: 0000000000000000
$ unshare -Ur grep ^Cap /proc/self/status
CapInh: 0000000000000000
CapPrm: 0000003fffffffff
CapEff: 0000003fffffffff
CapBnd: 0000003fffffffff
CapAmb: 0000000000000000

Ta-daa! Full capability set.

> I got early feedback that configurability was considered important.
> This is the correct behavior if you want namespace checks to be
> separately configurable from capability checks. You could ask for
> distinct configuration options for each kind of namespace, but, well, yuck.
>
> > > +static int safe_by_namespace(struct task_struct *p)
> > > +{
> > > +       struct cgroup_namespace *ccgn = NULL;
> > > +       struct cgroup_namespace *pcgn = NULL;
> > > +       const struct cred *ccred;
> > > +       const struct cred *pcred;
> > > +
> > > +       /*
> > > +        * Namespace checks. Considered safe if:
> > > +        *      cgroup namespace is the same
> > > +        *      User namespace is the same
> > > +        *      PID namespace is the same
> > > +        */
> > > +       if (current->nsproxy)
> > > +               ccgn = current->nsproxy->cgroup_ns;
> > > +       if (p->nsproxy)
> > > +               pcgn = p->nsproxy->cgroup_ns;
> > > +       if (ccgn != pcgn)
> > > +               return -EACCES;
> > > +
> > > +       ccred = current_real_cred();
> > > +       pcred = rcu_dereference_protected(p->real_cred, 1);
> > > +
> > > +       if (ccred->user_ns != pcred->user_ns)
> > > +               return -EACCES;
> > > +       if (task_active_pid_ns(current) != task_active_pid_ns(p))
> > > +               return -EACCES;
> > > +       return 0;
> > > +}
