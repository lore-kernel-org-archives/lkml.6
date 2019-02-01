Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAC7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B37320863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfBANOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:14:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfBANOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:14:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 914927EBD8;
        Fri,  1 Feb 2019 13:14:46 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-22.phx2.redhat.com [10.3.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AA515D9D6;
        Fri,  1 Feb 2019 13:14:38 +0000 (UTC)
Date:   Fri, 1 Feb 2019 08:14:35 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ghak107 V1] audit: remove unused actx param from
 audit_rule_match
Message-ID: <20190201131435.cwwa3yiui2kk6x34@madcap2.tricolour.ca>
References: <c3bc9d90ed20f1b1cce916636a28f1e85af1afdc.1548953334.git.rgb@redhat.com>
 <CAHC9VhRqeeuVZdARyCSJBumrQtTf7053qMAsfJXJfDrzDOYXrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRqeeuVZdARyCSJBumrQtTf7053qMAsfJXJfDrzDOYXrg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 01 Feb 2019 13:14:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-31 23:15, Paul Moore wrote:
> On Thu, Jan 31, 2019 at 11:52 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > The audit_rule_match() struct audit_context *actx parameter is not used
> > by any in-tree consumers (selinux, apparmour, integrity, smack).
> >
> > The audit context is an internal audit structure that should only be
> > accessed by audit accessor functions.
> >
> > It was part of commit 03d37d25e0f9 ("LSM/Audit: Introduce > generic
> > Audit LSM hooks") but appears to have never been used.
> 
> Merged into audit/next, but a heads-up that you added a ">" into the
> referenced commit title.  I'm not sure if that was a cut-n-paste
> problem, or something else, but just a note to be a bit more careful
> in the future about those things.

Ok, yes, that must have been a cut/paste error.  Pardon.

> > Remove it.
> >
> > Please see the github issue
> > https://github.com/linux-audit/audit-kernel/issues/107
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> > Passes audit-testsuite.
> >
> >  include/linux/lsm_hooks.h           |  4 +---
> >  include/linux/security.h            |  5 ++---
> >  kernel/auditfilter.c                |  2 +-
> >  kernel/auditsc.c                    | 21 ++++++++++++---------
> >  security/apparmor/audit.c           |  3 +--
> >  security/apparmor/include/audit.h   |  3 +--
> >  security/integrity/ima/ima.h        |  3 +--
> >  security/integrity/ima/ima_policy.c |  6 ++----
> >  security/security.c                 |  6 ++----
> >  security/selinux/include/audit.h    |  4 +---
> >  security/selinux/ss/services.c      |  3 +--
> >  security/smack/smack_lsm.c          |  4 +---
> >  12 files changed, 26 insertions(+), 38 deletions(-)
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
