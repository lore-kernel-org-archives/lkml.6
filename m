Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529BFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F8C208D4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="DyuufjS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbeLNWCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:02:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42510 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbeLNWCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:02:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so6147133lja.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 14:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5H3HTrdDiiwxWDM4UTLsEfC7q8O6iq0Pw20X0/RLSc=;
        b=DyuufjS22A4ARpDIUMLmoD90MnO09HVq5wcn1CmD8ObCClBbVjxHKqYS7CJ2lMsfa1
         cE0uCe84BuzCLA03Pa6ZkKxmYwD5wGFaB9GmOag2Tl19brHcXqclf9xDmcS1v8KhiHE0
         kZ6ZfDBj6oZTTIYVrj9RRFn5OzWLW+kU0G7HzvBb1zwX3m1/DKoUcA0aZMIZ+q5Nt/fx
         0ReQGEl7a55BYLCVyXutMnesXHm7Y5iHpiOJRuyINBKV8VtVLBXtWaft9GubzEYFsvYI
         R3nrvEJrVTgOZ7CFOxN1EHQ87rJhQ1ohAzJhZkydyXtfAKk4mbuQfSubTJ4q17I+CDQk
         PzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5H3HTrdDiiwxWDM4UTLsEfC7q8O6iq0Pw20X0/RLSc=;
        b=cfBefG8u8E85Fs+V26UCEPlhfyd5mHE3P1QeGzTLMk13rmOe+7JPQd5y7GQ1i3WJbk
         tLCawfc+c4vQH/EFA7Q7LPNDaqKQ8ahWC3W3nYRDnuFOujkHQFIpCIGLU7ZA/+sbpfIz
         /8kcYgnSEebKUk7WCIaaQrGqsIN14GLdZrvI1uT0uA5dJjNttb5Z212ckypXbdDeIt7F
         cXfySsAiOOT+2iQbz3uGIkav6bdQ4H5PioYE/2C+mFnCBsh9KhxzSXAucFA8G3CLCTXz
         gHvTIbJHS4ZjRWEcDcbWjk3KO+3sYleT/l2DCpTBwYggCwSXh7EKSa814TpcsYL68sBw
         6x6Q==
X-Gm-Message-State: AA+aEWY1pVbBJx5DesR5VGWhq65h9K94PfDQ+pHAgYc+EQb4NQX2xC6v
        3G9Lyt8pLjKpqItG1y/9n22ueaX8JzM5WjKFMFx/
X-Google-Smtp-Source: AFSGD/UGhx2SJ/4Ih1oaB4LJ5mX3E5/hRD/HlYBAkCrtpcpq1KV5hR7BrFcKEvP6PzDYMOF/IpbnUa0E2cfMJPS//8s=
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr2812659ljk.55.1544824933917;
 Fri, 14 Dec 2018 14:02:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542149969.git.rgb@redhat.com> <CAHC9VhT8iFLSXJBvocg_aPeveBy0hZ4bxZ547ufbUsTnkONpZg@mail.gmail.com>
 <20181214162744.23sbfyl3rnwkgoie@madcap2.tricolour.ca>
In-Reply-To: <20181214162744.23sbfyl3rnwkgoie@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 14 Dec 2018 17:02:02 -0500
Message-ID: <CAHC9VhQa5-CvFJkdY=XUkXc4Q1qVNy+3mcqrgzu8RosX-jP0iw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak100 V1 0/2] audit: avoid umount hangs on missing mount
To:     rgb@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>, sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:27 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-12-12 08:03, Paul Moore wrote:
> > On Fri, Nov 16, 2018 at 12:34 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On user and remote filesystems, a forced umount can still hang due to
> > > attemting to fetch the fcaps of a mounted filesystem that is no longer
> > > available.
> > >
> > > These two patches take different approaches to address this, one by
> > > avoiding the lookup when the MNT_FORCE flag is included, the other by
> > > providing a method to filter out auditing specified types of filesystems.
> > >
> > > This can happen on ceph, cifs, 9p, lustre, fuse (gluster) or NFS.
> > >
> > > Arguably the better way to address this issue is to disable auditing
> > > processes that touch removable filesystems.
> > > Please see the github issue tracker
> > > https://github.com/linux-audit/audit-kernel/issues/100
> > >
> > > Richard Guy Briggs (2):
> > >   audit: avoid fcaps on MNT_FORCE
> > >   audit: moar filter PATH records keyed on filesystem magic
> > >
> > >  fs/namei.c            |  2 +-
> > >  fs/namespace.c        |  3 +++
> > >  include/linux/audit.h |  8 ++++++--
> > >  kernel/audit.c        |  5 +++--
> > >  kernel/audit.h        |  2 +-
> > >  kernel/auditsc.c      | 29 ++++++++++++++++++++++++++---
> > >  6 files changed, 40 insertions(+), 9 deletions(-)
> >
> > Just to get this out of the way, don't use "moar", spell it properly.
> >
> > Beyond that, it's not clear to me from your cover letter if you are
> > proposing these patches as an "or" or as an "and"; assuming the
> > patch(es) are reasonable, do you want us to merge both of these
> > patches, or only the one we like the most?
>
> I would like each one to be considered on its own merits.
>
> The second was discussed back when the logs were flooded with "(null)"
> PATH records due to debugfs and tracefs noise.  Do you agree with the
> general concept or not?

I believe I was in favor of this back then, and I think it is still a
reasonable feature to add independent of the umount hang problem.

One possible enhancement might be to also support filesystem names and
not just magic numbers.  This could either be done in userspace or the
kernel via AUDIT_FSNAME, or similar.  If you do take the _FSNAME
approach you should have the kernel convert that to a magic number
when it translates the rule (performance reasons).

> The first is being picked apart (rightfully) due to assumptions and
> choices made long ago in the audit system.  So while it is still in far
> more flux than the second patch, I think it has the potential to fix the
> problem more correctly and permanently but in the process may challenge
> our rules about the format and invariability of audit records.  The
> basic premise is to prevent audit from trying to get information (fcaps)
> from a filesystem that is likely to be far more ephemeral than local
> on-disk kernel filesystems or to fail to do so more gracefully.

There is one minor nit: use "flags" instead of "lflags" in the
audit_inode parameter list, the local "flags" variable can be changed
to something else; the parameters are what callers see, make them
simple and familiar.

However, beyond that I think the general approach of not recording
fcaps is reasonable if we can't reliably do it.  What do the fcaps
entries look like in this particular case, are they "0" or "?"?  I
would suggest "?" is the correct answer here.

-- 
paul moore
www.paul-moore.com
