Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AF9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B056E2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BCjAUAE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B056E2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbeI1GIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 02:08:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33689 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeI1GIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 02:08:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id m23-v6so4358243otf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 16:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZthzNMGJzXPWrh3q4JbA1otK2sBWap9CYwk3FTi2D8=;
        b=BCjAUAE7buk+SgyamvxrNRtFEldwbG+SnkeAD1llNn/CKTGtxDfJFwbLFEbyvuIkxd
         4QT3Ew8JJ7hi6Hp++TbSGPtRNC9sr7D8GCDaE7OmVZNFmSQZfS0TC3Pk0qIUBE2uxkvQ
         z8liqCJIeLaBfiEWmBmEK+FvfnGPDMI3u6n6Zuq+FtjvnF2p4BIC+o71QQVAJ4L2T+2S
         IL/0fr3ray6sJ9x+CtBHv9jSsM2DjMdsucSaX0fGPDtdoch25sqdOcMXV7c69NIw6fiM
         rU/yKW1rToDvyEKRnVwmE2X54bshYT9Cy9VpusmXYKn57Jh7E6SMqnMFhUw4Qka6HejW
         RQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZthzNMGJzXPWrh3q4JbA1otK2sBWap9CYwk3FTi2D8=;
        b=VAMVs8wc/T1uFrgIElAs8MizMsU+ZVkOE4+yIzsZfwcyIw+jx5FxsDPfdwlBaZ9R6Q
         58RanbgUWX0EiWcJaqB4oY4o8c/G+TO7RNtnVKiE7vvV/iyGkazSB+QqV5ON9Mt5AYXF
         2QfI/gG9MEZoCtnp3t/DZmLY+9yI6rLmbHm11pGtCYQeJaDQmQ1GMozgYi6JUpSnk4rE
         zD4HP+ED1qH7IHfRqCcQSF5aqgLKIY0vkuGZNkFiEJqnwDbbxv97cwJM614pepNswVf3
         W1gxldfWbYLRLaaFij9r1ySpsinvr3fSMwkBGpf5VETNx5xqsybHZHsK+rypCDWwqsZo
         9CfA==
X-Gm-Message-State: ABuFfohRWDrdGBPELLkgB+YaSU3Yt1f3+Ath+h5+MNVEd/vpyLRtulNq
        qswzxFpgXkL9Uem5TwMGlo7k4hHCbPMMNfYkqvT+bw==
X-Google-Smtp-Source: ACcGV62yydfPh+JdthGcbxa8YoU2l1kasroVvzuQhGKrQqH3Da+3xJfMqtb5CS08PXaKMr6Tks4RSglfls43ynp6I1Q=
X-Received: by 2002:a9d:2843:: with SMTP id h3-v6mr8861996otd.230.1538092085510;
 Thu, 27 Sep 2018 16:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-6-casey.schaufler@intel.com> <alpine.LRH.2.21.1809280744560.8410@namei.org>
 <025d4742-5947-545e-f603-502a0c5ee03f@schaufler-ca.com> <alpine.LRH.2.21.1809280846280.8410@namei.org>
 <99FC4B6EFCEFD44486C35F4C281DC67321463CE3@ORSMSX107.amr.corp.intel.com> <alpine.LRH.2.21.1809280936290.13517@namei.org>
In-Reply-To: <alpine.LRH.2.21.1809280936290.13517@namei.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 28 Sep 2018 01:47:39 +0200
Message-ID: <CAG48ez3Jnao-5z3O8s=RdoAx8=b68C_1pfKNKJSm+6R_HyU_fg@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] sidechannel: Linux Security Module for sidechannel
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey.schaufler@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        kristen@linux.intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        deneen.t.dock@intel.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 1:43 AM James Morris <jmorris@namei.org> wrote:
> On Thu, 27 Sep 2018, Schaufler, Casey wrote:
> > > > On 9/27/2018 2:45 PM, James Morris wrote:
> > > > > On Wed, 26 Sep 2018, Casey Schaufler wrote:
> > > > >
> > > > >> +      /*
> > > > >> +       * Namespace checks. Considered safe if:
> > > > >> +       *      cgroup namespace is the same
> > > > >> +       *      User namespace is the same
> > > > >> +       *      PID namespace is the same
> > > > >> +       */
> > > > >> +      if (current->nsproxy)
> > > > >> +              ccgn = current->nsproxy->cgroup_ns;
> > > > >> +      if (p->nsproxy)
> > > > >> +              pcgn = p->nsproxy->cgroup_ns;
> > > > >> +      if (ccgn != pcgn)
> > > > >> +              return -EACCES;
> > > > >> +      if (current->cred->user_ns != p->cred->user_ns)
> > > > >> +              return -EACCES;
> > > > >> +      if (task_active_pid_ns(current) != task_active_pid_ns(p))
> > > > >> +              return -EACCES;
> > > > >> +      return 0;
> > > > > I really don't like the idea of hard-coding namespace security semantics
> > > > > in an LSM.  Also, I'm not sure if these semantics make any sense.
> > > >
> > > > Checks on namespaces where explicitly requested.
> > >
> > > By whom and what is the rationale?
> >
> > The rationale is to protect containers. Since those closest thing
> > there is to a definition of containers is "uses namespaces" that
> > becomes the focus. Separating them out does not make too much
> > sense as I would expect someone concerned with one to be concerned
> > with all.
>
> A lot of people will not be using user namespaces due to security
> concerns,

Ugh.

> so with this hard-coded logic, you are saying this case is
> 'safe' in a sidechannel context.
>
> Which hints at the deeper issue that containers are a userland
> abstraction.  Protection of containers needs to be defined by userland
> policy.

Or just compare mount namespaces additionally/instead. I think that
containers will always use those, because AFAIK nobody uses chroot()
for containers, given that the kernel makes absolutely no security
guarantees about chroot().
