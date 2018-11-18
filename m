Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1421C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 12:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474C22080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 12:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T+gEI7lt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474C22080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeKRXS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 18:18:59 -0500
Received: from casper.infradead.org ([85.118.1.10]:60278 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeKRXS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 18:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VlVx+MvZKI+Ik0/tWsz/u9fPSR9Lu+GE6XXb5UFAk1U=; b=T+gEI7ltOxcvGzWIHU+Qb8K9BU
        H8aZK2gEHp8EIqv58hpPdpVS4bJ54c/WN+hbZm+1rJmLx6SuIOdZlJHlzWVruOXN30PxWVuIA7L3K
        vE//i5mFFgaLx/+8AHaddi1nw9gChoCeJpNfvSDNLNlXc18+Y+ontEQ+cR6g2vC5ijal9ttB0IhuO
        8Tlkk+ZEiytOWkSuB2yeDU7/+RbfWSQRiBXjy24FtnQt1+tw1cvF+m8qD60Q4C/ILBlFoDu0AdtdN
        Wyapor4g4DgEIruDMhaEYeFWWxNUJkJKeoyrYvvhcxW7wBD8l0nuCkYqzuMgHeuysHSmOcQJUwUnO
        Y71kZDvw==;
Received: from 177.17.134.91.dynamic.adsl.gvt.net.br ([177.17.134.91] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOMeq-0001bn-3W; Sun, 18 Nov 2018 12:58:36 +0000
Date:   Sun, 18 Nov 2018 10:58:29 -0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, stfrench@microsoft.com,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
Message-ID: <20181118105829.7388cc7d@coco.lan>
In-Reply-To: <CAPcyv4iw78jzLQmX6foUMpVUB4ZSE2ExYhjTd87X2xraaZrkPA@mail.gmail.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
        <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
        <9f6aece0-da64-78b5-0eda-fe039fc1ad09@gmail.com>
        <20181116040442.3a5ee3b9@silica.lan>
        <CAPcyv4iw78jzLQmX6foUMpVUB4ZSE2ExYhjTd87X2xraaZrkPA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 16 Nov 2018 10:57:14 -0800
Dan Williams <dan.j.williams@intel.com> escreveu:

> On Fri, Nov 16, 2018 at 4:04 AM Mauro Carvalho Chehab
> <mchehab@kernel.org> wrote:
> >
> > Em Thu, 15 Nov 2018 16:11:59 -0800
> > Frank Rowand <frowand.list@gmail.com> escreveu: =20
> [..]
> > > > +Patches or Pull requests
> > > > +------------------------
> > > > +Some subsystems allow contributors to send pull requests, most req=
uire
> > > > +mailed patches. State =E2=80=9CPatches only=E2=80=9D, or =E2=80=9C=
Pull requests accepted=E2=80=9D. =20
> > >
> > > This may create some confusion if only "Pull requests accepted" is the
> > > contents of this section.  My understanding has been that all changes
> > > should be available on a mail list for review before being accepted
> > > by the maintainer, even if eventually the final version of the series
> > > that is accepted is applied by the maintainer as a pull instead of
> > > via applying patches.
> > >
> > > Is my "must appear on a mail list" understanding correct? =20
> >
> > I guess this is true on almost all subsystems that accept pull requests.
> >
> > It could not be true if some subsystem moves to Github/Gitlab. =20
>=20
> Yes. Maybe a "Review Forum" section for subsystems that have
> transitioned from email to a web-based tool? There's also the
> exception of security disclosures, but the expectations for those
> patches are already documented.

Maybe. I would postpone adding a section like that until some
subsystem maintainer that actually changed to Github/Gitlab
would submit his subsystem profile.

>=20
> > > > +Last -rc for new feature submissions
> > > > +------------------------------------
> > > > +New feature submissions targeting the next merge window should have
> > > > +their first posting for consideration before this point. Patches t=
hat
> > > > +are submitted after this point should be clear that they are targe=
ting
> > > > +the NEXT+1 merge window, or should come with sufficient justificat=
ion
> > > > +why they should be considered on an expedited schedule. A general
> > > > +guideline is to set expectation with contributors that new feature
> > > > +submissions should appear before -rc5. The answer may be different=
 for
> > > > +'Core:' files, include a second entry prefixed with 'Core:' if so.=
 =20
> > >
> > > I would expect the -rc to vary based on the patch series size, comple=
xity,
> > > risk, number of revisions that will occur, how controversial, number =
of
> > > -rc releases before Linus chooses to release, etc.  You would need a
> > > crystal ball to predict much of this.  I could see being able to prov=
ide
> > > a good estimate of this value for a relatively simple patch. =20
> >
> > That's only partially true. I mean, the usual flux is to go up to -rc7.
> > After that, the final version is usually merged (except when something
> > goes wrong).
> >
> > Anyway, I guess nobody would complain if the maintainers do an exception
> > here and accept more patches when they know that the last rc version
> > won't be -rc7, but, instead, -rc8 or -rc9.
> >
> > This is a general ruleset that describes the usual behavior, telling the
> > developers the expected behavior. If the maintainers can do more on some
> > particular development cycle, it should be fine. =20
>=20
> Yes, and perhaps I should clarify that this is the point at which a
> maintainer will start to push back in the typical case, and indicate
> to a contributor that they are standing in exceptional territory.
> Similar to how later in the -rc series patches get increasing
> scrutiny.

Makes sense. There's one issue, though.

I don't expect developers to read the profile template, as this is a
material for the maintainer themselves. Developers should likely read=20
just the specific subsystem profile for the patches that will be submitted.

So, either each subsystem profile should have a reference to the
profile template, or need to copy some "invariant" texts (with would be
really painful to maintain).

>=20
> > > > +Last -rc to merge features
> > > > +--------------------------
> > > > +Indicate to contributors the point at which an as yet un-applied p=
atch
> > > > +set will need to wait for the NEXT+1 merge window. Of course there=
 is no
> > > > +obligation to ever except any given patchset, but if the review ha=
s not
> > > > +concluded by this point the expectation the contributor should wai=
t and
> > > > +resubmit for the following merge window. The answer may be differe=
nt for
> > > > +'Core:' files, include a second entry prefixed with 'Core:' if so.=
 =20
> > >
> > > Same comment as for the previous section, with the additional complex=
ity
> > > that each unique patch series should bake in -next. =20
>=20
> The intent is to try to leave all "should" or prescriptive statements
> out of the profile. I'm looking to target other parts of the handbook
> to carry advice for integrating with -next and suggested soak times.

Makes sense. Again, it probably makes sense to have those parts
referenced on each profile.

> > > > +Non-author Ack / Review Tags Required
> > > > +------------------------------------- =20
> > >
> > > The title of this section seems a bit different than the description
> > > below.  A more aligned title would be something like "Maintainer
> > > self-commit review requirements". =20
>=20
> This is intended to go beyond maintainer self-commits. Consider a pull
> request that contains commits without non-author tags.
>=20
> > > > +Let contributors and other maintainers know whether they can expec=
t to
> > > > +see the maintainer self-commit patches without 3rd-party review. S=
ome
> > > > +subsystem developer communities are so small as to make this requi=
rement
> > > > +impractical. Others may have been bootstrapped by a submission of
> > > > +self-reviewed code at the outset, but have since moved to a
> > > > +non-author review-required stance. This section sets expectations =
on the
> > > > +code-review economics in the subsystem. For example, can a contrib=
utor
> > > > +trade review of a maintainer's, or other contributor's patches in
> > > > +exchange for consideration of their own. =20
> > >
> > > Then another section (which is the one I expected when I slightly
> > > mis-read the section title) would be: Review Tags Requirements",
> > > which would discuss what type of review is expected, encouraged,
> > > or required. =20
>=20
> Per the clarification above, I think the whole thing should be called
> "Review Tags Requirement".

Agreed.

> > > > +Test Suite
> > > > +----------
> > > > +Indicate the test suite all patches are expected to pass before be=
ing
> > > > +submitted for inclusion consideration.
> > > > +
> > > > +
> > > > +Resubmit Cadence
> > > > +----------------
> > > > +Define a rate at which a contributor should wait to resubmit a pat=
chset
> > > > +that has not yet received comments. A general guideline is to try =
to
> > > > +meet a deadline of 1 - 2 weeks to acknowledge starting considerati=
on for
> > > > +a patch set. =20
> > >
> > > Or ping instead of resubmitting?  If you resubmit the same series with
> > > an unchanged version then comments could be split across multiple
> > > email threads.  If you resubmit the same series with a new version
> > > number, the same comment split can occur plus it can be confusing
> > > that two versions have the same contents.  I suspect that there may be
> > > some maintainers who do prefer a resubmit, but that is just wild
> > > conjecture on my part. =20
> >
> > That depends on how maintainers handle patches. Those subsystems that
> > use patchwork (like media) don't really require anyone to resubmit
> > patches. They're all stored there at patchwork database.
> >
> > My workflow is that, if I receive two patches from the same person with
> > the same subject, I simply mark the first one as obsoleted, as usually
> > the second one is a new version, and reviewers should need some
> > time to handle it.
> >
> > In other words, re-sending a patch may actually delay its handling, as
> > the second version will be later on my input queue, and I'll grant
> > additional time for people to review the second version at the communit=
y. =20
>=20
> Ok, this sounds like a separate policy. How often to follow-up
> separated from resend the full series vs send a ping mail.
>=20
> > > > +Trusted Reviewers
> > > > +-----------------
> > > > +While a maintainer / maintainer-team is expected to be reviewer of=
 last
> > > > +resort the review load is less onerous when distributed amongst
> > > > +contributors and or a trusted set of individuals.  This section is
> > > > +distinct from the R: tag (Designated Reviewer). Whereas R: identif=
ies
> > > > +reviewers that should always be copied on a patch submission, the
> > > > +trusted reviewers here are individuals contributors can reach out =
to if
> > > > +a few 'Resubmit Cadence' intervals have gone by without maintainer
> > > > +action, or to otherwise consult for advice. =20
> > >
> > > This seems redundant with the MAINTAINERS reviewers list.  It seems l=
ike
> > > the role specified in this section is more of an ombudsman or develop=
er
> > > advocate who can assist with the review and/or accept flow if the
> > > maintainer is being slow to respond. =20
> >
> > Well, on subsystems that have sub-maintainers, there's no way to point =
to
> > it at MAINTAINERS file.
> >
> > Also, not sure about others, but I usually avoid touching at existing
> > MAINTAINERS file entries. This is a file that everyone touches, so it
> > has higher chances of conflicts.
> >
> > Also, at least on media, we have 5 different API sets (digital TV, V4L2=
, CEC,
> > media controller, remote controller). Yet, all drivers are stored at the
> > same place (as a single driver may use multiple APIs).
> >
> > The reviewers for each API set are different. There isn't a good way
> > to explain that inside a MAINTANERS file. =20
>=20
> Would it be worthwhile to have separate Subsystem Profiles for those
> API reviewers? If they end up merging patches and sending them
> upstream might we need a hierarchy of profiles for each hop along the
> upstream merge path?

I guess having hierarchical profiles will make it very confusing.
The point is: inside a subsystem, the same ruleset usually applies to
everything.

In the case of media, it is not uncommon to have patches that require
multiple APIs. Consider, for example, a SoC used on a TV box. The driver
itself should be placed at drivers/media/platform/, but it will end by
being a bunch of sub-drivers that together will add support for V4L,=20
Digital TV, remote controller, CEC and codecs, and need to be controlled
via the media controller API. It may even have camera sensors.

On other words, all media APIs will be used (after having it fully
sent upstream).

In practice, drivers for complex hardware like that is submitted in
parts. For example, one SoC vendor started sending us the remote
controller driver (as it would be the simplest one).

The only part of the policy that changes, depending of what API
is involved, is the one that will do the review.=20

As the driver itself will be at the same place, no matter what APIs
are used, get_maintainers.pl is not capable of identifying who are=20
the reviewers based "F:" tags[1].

[1] It could be possible to teach get_maintainers to better hint it,
by making it look who are the reviewers for the headers that are=20
included.

>=20
> > > > +Time Zone / Office Hours
> > > > +------------------------
> > > > +Let contributors know the time of day when one or more maintainers=
 are
> > > > +usually actively monitoring the mailing list. =20
> > >
> > > I would strike "actively monitoring the mailing list".  To me, it sho=
uld
> > > be what are the hours of the day that the maintainer might happen to =
poll
> > > (or might receive an interrupt) from the appropriate communications
> > > channels (could be IRC, could be email, etc). =20
>=20
> Yes, makes sense.
>=20
> > > For my area, I would want to say something like: I tend to be active
> > > between 17:00 UTC (18:00 UTC when daylight savings) and 25:00 (26:00),
> > > but often will check for urgent or brief items up until 07:00 (08:00).
> > > I interact with email via a poll model.  I interact with IRC via a
> > > pull model and often overlook IRC activity for multiple days). =20
> >
> > Frankly, for media, I don't think that working hours makes sense. Media
> > (sub-)maintainers are spread around the globe, on different time zones
> > (in US, Brazil and Europe). We also have several active developers in
> > Japan, so we may end by having some day reviewers/sub-maintainers from
> > there. =20
>=20
> For that case just say:
>=20
> "the sun never sets on the media subsystem" ;-)

:-)

>=20
> > At max, we can say that we won't warrant to patches on weekends or holi=
days. =20
>=20
> Yeah, maybe:
>=20
> "outside of weekends or holidays there's usually a maintainer or
> reviewer monitoring the mailing list"

Well, 24/7, there is always patchwork monitoring the ML and picking
the patches. When the patch will be handled by someone is a different
question. As it is a high-traffic subsystem with an even higher ML
traffic, each sub-maintainer have its own policy about when they
review patches (usually one or twice per week - as most maintainers
are also active developers, and don't want to mix their development
time with reviewing time).

I'm not quite sure about what you expect with this specific part of
the profile.

I mean: why a submitter should care about office hours?

Also, people may be OOT during some period of time, or working
remotely from some other office.

Except if the idea would be to point to some site that would
dynamically track each maintainer's weekly maintainership
window (with would be a real pain to keep updated), I guess this
is useless.

Thanks,
Mauro
