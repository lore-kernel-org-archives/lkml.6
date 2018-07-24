Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047CDC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04D620875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="b60gD1He"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04D620875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388789AbeGXVmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:42:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41451 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388639AbeGXVmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:42:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so4741686ljy.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5oesWHlMUEb4TtjNapPWjZXL1XsJL2Ptex9hElqQw4=;
        b=b60gD1He2SjEQ9TNqm5yTjX3I37153yd8MOsUEZlVX1qV/KFAV4UuLrzdcvBYkpWLx
         Mo1NBjg7bX0f33CCui88m3xCDL7AFRNCWtvNfRzcHCg/pybQGGKAEipA+L/lrRheFFAv
         S7uMMia4s86RtTjDEMq9hadTCM3TZDoqc/NZglrZCEtFxPD5+0EaouWo2fkmxa07iPxG
         IBQ1NCbqdvM7IaDpLlkje62E8tazK2EoRhI15NfsipT2lY7WPS6hElJlKB5LX20vrY+m
         qQwd8gUjHLI/E4n8mkO23bqGDwiZ0FyUcAyXNcCSaXiXQ9pRR9BCt/PUT10dWcXSNxmV
         LCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5oesWHlMUEb4TtjNapPWjZXL1XsJL2Ptex9hElqQw4=;
        b=dN2jAv8mHOaPv7/GUNMnePlJwx9ZSF+jVvzKv8MlCsiZou9g5my9GQGFu8fEkFSQyc
         IR9aDIm0ALvEjHPSI07Och1ybhESzC9JbRTYZB7RK6R/UobCK5F4EH8xn8Z0nP6DZN1r
         Azp5fy8a9WWIGqwBEVsc1OiQIEOk8bajB+fl+V2dL/we5ZhEY1Ccm9hKzLAMTBw+T1NF
         bXPZ9kdQwcLwspsNJcY/SFtXt65SuELrE7LSb2e0zaWWSFYPhOThCQdYDtHqprh1RV0a
         mb9y+gKaxASil2VqAuIPtj1Mv871d7kQ+ngoH3wa3oQ/cE3SWUhGBA2F0+8GIYNmZFAL
         HSeQ==
X-Gm-Message-State: AOUpUlGDPNS+p0IV81FHreLPI43tDM8iDPqsRHMpN92xtfNhhys9Th/+
        UBCKWBoxhtJOUwF657CNnO1VHN7N7l8+L7HUdte4
X-Google-Smtp-Source: AAOMgpeWbY0yr3UiYnkHKbPfHXHa668K+0Li+LcYiR/rsX7pKGcUZfMNymqjZDM4rKZy0PVWEoZn/ujfh/UA19W5t4E=
X-Received: by 2002:a2e:291c:: with SMTP id u28-v6mr12755784lje.70.1532464437079;
 Tue, 24 Jul 2018 13:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528304203.git.rgb@redhat.com> <562cfaf7629b64252aac7cf3cecdd70b471af5b5.1528304204.git.rgb@redhat.com>
 <CAHC9VhStmCOS=o2aM7zHLGUYyfuCu_d1so4Cp4T-qetGnJpUUg@mail.gmail.com> <20180724140309.i6o2yjdoif5krxtw@madcap2.tricolour.ca>
In-Reply-To: <20180724140309.i6o2yjdoif5krxtw@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Jul 2018 16:33:45 -0400
Message-ID: <CAHC9VhSuczaFi49-3SrVM9vND=vT=U1Aj0G6kOyJ3rAFnvi6VA@mail.gmail.com>
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 07/10] audit: add support for
 containerid to network namespaces
To:     rgb@redhat.com
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:06 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-07-20 18:14, Paul Moore wrote:
> > On Wed, Jun 6, 2018 at 1:03 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Audit events could happen in a network namespace outside of a task
> > > context due to packets received from the net that trigger an auditing
> > > rule prior to being associated with a running task.  The network
> > > namespace could in use by multiple containers by association to the
> > > tasks in that network namespace.  We still want a way to attribute
> > > these events to any potential containers.  Keep a list per network
> > > namespace to track these audit container identifiiers.
> > >
> > > Add/increment the audit container identifier on:
> > > - initial setting of the audit container identifier via /proc
> > > - clone/fork call that inherits an audit container identifier
> > > - unshare call that inherits an audit container identifier
> > > - setns call that inherits an audit container identifier
> > > Delete/decrement the audit container identifier on:
> > > - an inherited audit container identifier dropped when child set
> > > - process exit
> > > - unshare call that drops a net namespace
> > > - setns call that drops a net namespace
> > >
> > > See: https://github.com/linux-audit/audit-kernel/issues/92
> > > See: https://github.com/linux-audit/audit-testsuite/issues/64
> > > See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  include/linux/audit.h | 23 ++++++++++++++++
> > >  kernel/audit.c        | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  kernel/auditsc.c      |  5 ++++
> > >  kernel/nsproxy.c      |  4 +++
> > >  4 files changed, 104 insertions(+)

...

> > > +                       }
> > > +       if (!found)
> > > +               return;
> > > +       list_del(&cont->list);
> > > +       if (refcount_dec_and_test(&cont->refcount))
> > > +               kfree(cont);
> >
> > Don't you want to dec_and_test first and only remove it from the list
> > if there are no other references?
>
> I don't think so.  Let me try to describe it in prose to see if I
> understood this properly and see if this makes more sense: I want to
> remove this audit_contid list member from this net's audit_contid list
> and decrement unconditionally this member's refcount so it knows there
> is one less thing pointing at it and when there is no longer anything
> pointing at it, free it.

Yep, sorry, my mistake, I was thinking the other way around (netns
going away) ... which actually, this patchset doesn't handle that does
it (I don't see any new code in audit_net_exit())?  Is is in a later
patch?  If so, it really should be in the same patch as this code to
prevent bisect nasties.

-- 
paul moore
www.paul-moore.com
