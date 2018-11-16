Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B429C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CC62084A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="yL4hXR0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CC62084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbeKQFLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:11:03 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37215 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeKQFLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 00:11:02 -0500
Received: by mail-ot1-f46.google.com with SMTP id 40so22265260oth.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 10:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n0EUp9MEmGzxlUFBghsC7PbkPhdmCqmMv6qAVBqlM6Y=;
        b=yL4hXR0T+FPLYkPbklp97Jli61OM8/AOFpfIai4Pr3YMYHBbv/E8/TanWREoUdZyXZ
         gCIT/um9XkXcs27iLpQkLTn2jxji+SgGvleakQjjsONXWk//RsF0I1Pw6xx/VjljioZH
         WI5I8A0TZui3BSDIYUcUBBtusTHLDrjz22fOFYDINrvSGv5G3/NYoo8sZqzInUIW8O60
         0C9UiPMlrfdrO7iW6glH8UXT/fq2ltWJQhCa9A8McCpkbrR/6UGGDJ7/LXFuFg4NrCPc
         sJ9Cv30cDrOhhLueFP1x01SkEZu+hycSCqFQHodL7m9mrdRAvJgNiH1MKmreEF0j33CV
         fpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n0EUp9MEmGzxlUFBghsC7PbkPhdmCqmMv6qAVBqlM6Y=;
        b=msbp5COhdoCc/Fn822cDkfioIiceN+yMk7SEee/XcF23b7CuRNfiS6nygROt46vPMK
         9FYBT7GH6m5f7ONsTn240MkyPMEamfmoDjD6NmOFBxmdOXV75gzgHEv0aLe7CAciOrw7
         WLs+ttEDdReXB3lX3xkV2I9VrhXWpAU1+Jk2hAN7wAQFSCuLQGHQT4i9gVWXZvszu/Nk
         78cs+3XSbt/f5AOWNSqsPr5H3gzqgah1A8+oziqi1WunISUO+tLstekd1qWFvQOehPq1
         d9Mpc10fZmdEXKcaLmFea2NVRjIZrEqWxUe+rOi9Q6bbeAdwAGmHQ7T2yc6kJeurWVWO
         D1UA==
X-Gm-Message-State: AA+aEWZ9FLc8mR7HaX+BEWeG4Xn15AfBM8UgP0tzHoqF1TRWjeuWH9Ck
        vf80cYiUJOTctlZVyGdfpuF9COMZRNc9IweWAZ7+lQ==
X-Google-Smtp-Source: AFSGD/XDFmgGhcwYq8UaLYBshRMbcw/hjrMQWJRrLJqpc1I30H2f90rmxlNt5oi4HzdMEObsWUhZmlcZtxYI6TGvRGM=
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr1289009otn.214.1542394646703;
 Fri, 16 Nov 2018 10:57:26 -0800 (PST)
MIME-Version: 1.0
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
 <9f6aece0-da64-78b5-0eda-fe039fc1ad09@gmail.com> <20181116040442.3a5ee3b9@silica.lan>
In-Reply-To: <20181116040442.3a5ee3b9@silica.lan>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Nov 2018 10:57:14 -0800
Message-ID: <CAPcyv4iw78jzLQmX6foUMpVUB4ZSE2ExYhjTd87X2xraaZrkPA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        stfrench@microsoft.com, Greg KH <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 4:04 AM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> Em Thu, 15 Nov 2018 16:11:59 -0800
> Frank Rowand <frowand.list@gmail.com> escreveu:
[..]
> > > +Patches or Pull requests
> > > +------------------------
> > > +Some subsystems allow contributors to send pull requests, most requi=
re
> > > +mailed patches. State =E2=80=9CPatches only=E2=80=9D, or =E2=80=9CPu=
ll requests accepted=E2=80=9D.
> >
> > This may create some confusion if only "Pull requests accepted" is the
> > contents of this section.  My understanding has been that all changes
> > should be available on a mail list for review before being accepted
> > by the maintainer, even if eventually the final version of the series
> > that is accepted is applied by the maintainer as a pull instead of
> > via applying patches.
> >
> > Is my "must appear on a mail list" understanding correct?
>
> I guess this is true on almost all subsystems that accept pull requests.
>
> It could not be true if some subsystem moves to Github/Gitlab.

Yes. Maybe a "Review Forum" section for subsystems that have
transitioned from email to a web-based tool? There's also the
exception of security disclosures, but the expectations for those
patches are already documented.

> > > +Last -rc for new feature submissions
> > > +------------------------------------
> > > +New feature submissions targeting the next merge window should have
> > > +their first posting for consideration before this point. Patches tha=
t
> > > +are submitted after this point should be clear that they are targeti=
ng
> > > +the NEXT+1 merge window, or should come with sufficient justificatio=
n
> > > +why they should be considered on an expedited schedule. A general
> > > +guideline is to set expectation with contributors that new feature
> > > +submissions should appear before -rc5. The answer may be different f=
or
> > > +'Core:' files, include a second entry prefixed with 'Core:' if so.
> >
> > I would expect the -rc to vary based on the patch series size, complexi=
ty,
> > risk, number of revisions that will occur, how controversial, number of
> > -rc releases before Linus chooses to release, etc.  You would need a
> > crystal ball to predict much of this.  I could see being able to provid=
e
> > a good estimate of this value for a relatively simple patch.
>
> That's only partially true. I mean, the usual flux is to go up to -rc7.
> After that, the final version is usually merged (except when something
> goes wrong).
>
> Anyway, I guess nobody would complain if the maintainers do an exception
> here and accept more patches when they know that the last rc version
> won't be -rc7, but, instead, -rc8 or -rc9.
>
> This is a general ruleset that describes the usual behavior, telling the
> developers the expected behavior. If the maintainers can do more on some
> particular development cycle, it should be fine.

Yes, and perhaps I should clarify that this is the point at which a
maintainer will start to push back in the typical case, and indicate
to a contributor that they are standing in exceptional territory.
Similar to how later in the -rc series patches get increasing
scrutiny.

> > > +Last -rc to merge features
> > > +--------------------------
> > > +Indicate to contributors the point at which an as yet un-applied pat=
ch
> > > +set will need to wait for the NEXT+1 merge window. Of course there i=
s no
> > > +obligation to ever except any given patchset, but if the review has =
not
> > > +concluded by this point the expectation the contributor should wait =
and
> > > +resubmit for the following merge window. The answer may be different=
 for
> > > +'Core:' files, include a second entry prefixed with 'Core:' if so.
> >
> > Same comment as for the previous section, with the additional complexit=
y
> > that each unique patch series should bake in -next.

The intent is to try to leave all "should" or prescriptive statements
out of the profile. I'm looking to target other parts of the handbook
to carry advice for integrating with -next and suggested soak times.

> > > +Non-author Ack / Review Tags Required
> > > +-------------------------------------
> >
> > The title of this section seems a bit different than the description
> > below.  A more aligned title would be something like "Maintainer
> > self-commit review requirements".

This is intended to go beyond maintainer self-commits. Consider a pull
request that contains commits without non-author tags.

> > > +Let contributors and other maintainers know whether they can expect =
to
> > > +see the maintainer self-commit patches without 3rd-party review. Som=
e
> > > +subsystem developer communities are so small as to make this require=
ment
> > > +impractical. Others may have been bootstrapped by a submission of
> > > +self-reviewed code at the outset, but have since moved to a
> > > +non-author review-required stance. This section sets expectations on=
 the
> > > +code-review economics in the subsystem. For example, can a contribut=
or
> > > +trade review of a maintainer's, or other contributor's patches in
> > > +exchange for consideration of their own.
> >
> > Then another section (which is the one I expected when I slightly
> > mis-read the section title) would be: Review Tags Requirements",
> > which would discuss what type of review is expected, encouraged,
> > or required.

Per the clarification above, I think the whole thing should be called
"Review Tags Requirement".

> > > +Test Suite
> > > +----------
> > > +Indicate the test suite all patches are expected to pass before bein=
g
> > > +submitted for inclusion consideration.
> > > +
> > > +
> > > +Resubmit Cadence
> > > +----------------
> > > +Define a rate at which a contributor should wait to resubmit a patch=
set
> > > +that has not yet received comments. A general guideline is to try to
> > > +meet a deadline of 1 - 2 weeks to acknowledge starting consideration=
 for
> > > +a patch set.
> >
> > Or ping instead of resubmitting?  If you resubmit the same series with
> > an unchanged version then comments could be split across multiple
> > email threads.  If you resubmit the same series with a new version
> > number, the same comment split can occur plus it can be confusing
> > that two versions have the same contents.  I suspect that there may be
> > some maintainers who do prefer a resubmit, but that is just wild
> > conjecture on my part.
>
> That depends on how maintainers handle patches. Those subsystems that
> use patchwork (like media) don't really require anyone to resubmit
> patches. They're all stored there at patchwork database.
>
> My workflow is that, if I receive two patches from the same person with
> the same subject, I simply mark the first one as obsoleted, as usually
> the second one is a new version, and reviewers should need some
> time to handle it.
>
> In other words, re-sending a patch may actually delay its handling, as
> the second version will be later on my input queue, and I'll grant
> additional time for people to review the second version at the community.

Ok, this sounds like a separate policy. How often to follow-up
separated from resend the full series vs send a ping mail.

> > > +Trusted Reviewers
> > > +-----------------
> > > +While a maintainer / maintainer-team is expected to be reviewer of l=
ast
> > > +resort the review load is less onerous when distributed amongst
> > > +contributors and or a trusted set of individuals.  This section is
> > > +distinct from the R: tag (Designated Reviewer). Whereas R: identifie=
s
> > > +reviewers that should always be copied on a patch submission, the
> > > +trusted reviewers here are individuals contributors can reach out to=
 if
> > > +a few 'Resubmit Cadence' intervals have gone by without maintainer
> > > +action, or to otherwise consult for advice.
> >
> > This seems redundant with the MAINTAINERS reviewers list.  It seems lik=
e
> > the role specified in this section is more of an ombudsman or developer
> > advocate who can assist with the review and/or accept flow if the
> > maintainer is being slow to respond.
>
> Well, on subsystems that have sub-maintainers, there's no way to point to
> it at MAINTAINERS file.
>
> Also, not sure about others, but I usually avoid touching at existing
> MAINTAINERS file entries. This is a file that everyone touches, so it
> has higher chances of conflicts.
>
> Also, at least on media, we have 5 different API sets (digital TV, V4L2, =
CEC,
> media controller, remote controller). Yet, all drivers are stored at the
> same place (as a single driver may use multiple APIs).
>
> The reviewers for each API set are different. There isn't a good way
> to explain that inside a MAINTANERS file.

Would it be worthwhile to have separate Subsystem Profiles for those
API reviewers? If they end up merging patches and sending them
upstream might we need a hierarchy of profiles for each hop along the
upstream merge path?

> > > +Time Zone / Office Hours
> > > +------------------------
> > > +Let contributors know the time of day when one or more maintainers a=
re
> > > +usually actively monitoring the mailing list.
> >
> > I would strike "actively monitoring the mailing list".  To me, it shoul=
d
> > be what are the hours of the day that the maintainer might happen to po=
ll
> > (or might receive an interrupt) from the appropriate communications
> > channels (could be IRC, could be email, etc).

Yes, makes sense.

> > For my area, I would want to say something like: I tend to be active
> > between 17:00 UTC (18:00 UTC when daylight savings) and 25:00 (26:00),
> > but often will check for urgent or brief items up until 07:00 (08:00).
> > I interact with email via a poll model.  I interact with IRC via a
> > pull model and often overlook IRC activity for multiple days).
>
> Frankly, for media, I don't think that working hours makes sense. Media
> (sub-)maintainers are spread around the globe, on different time zones
> (in US, Brazil and Europe). We also have several active developers in
> Japan, so we may end by having some day reviewers/sub-maintainers from
> there.

For that case just say:

"the sun never sets on the media subsystem" ;-)

> At max, we can say that we won't warrant to patches on weekends or holida=
ys.

Yeah, maybe:

"outside of weekends or holidays there's usually a maintainer or
reviewer monitoring the mailing list"
