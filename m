Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE719C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1B82089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cDWvniUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1B82089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389447AbeKPWQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:16:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeKPWQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3QoVtlWysrcVjkPwzjGwK6V8dtsbjZccaEf0tEmc7Lw=; b=cDWvniUWvERZyqxrgGbZdEnjJ
        nq1w9QPuvSbyEJDyPc59gi5UsF5zXGVCpdlVydpJduohO64AAhAjtuMEa3oBCHRkQXfo7VYCRVxUx
        L1/IHOvrSzpdcGR6fEoYeaO1jEdXECE1tFMCRDZNy3IJ7qNHZFaRy7h5F/6xB1avd9pO5rJxl8kNy
        QcmxfkcwbygnNxumY9VD2Rb6aVqQIJGuapHgiqXQRpyyXMLTTbJO3sv/N3ReQfmXDWIvDEa90e4K/
        LNgzhLIGrvW/BJJVlJZiBojdOTVMaJs229eJjgpt+FV7NFymAcnfilpYsv4lt9/oPEDAnoQqx/xX5
        tvIWxU1ug==;
Received: from [64.114.255.114] (helo=silica.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNcrd-00017c-Lz; Fri, 16 Nov 2018 12:04:45 +0000
Date:   Fri, 16 Nov 2018 04:04:42 -0800
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org, vishal.l.verma@intel.com,
        Steve French <stfrench@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
Message-ID: <20181116040442.3a5ee3b9@silica.lan>
In-Reply-To: <9f6aece0-da64-78b5-0eda-fe039fc1ad09@gmail.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
        <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
        <9f6aece0-da64-78b5-0eda-fe039fc1ad09@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 15 Nov 2018 16:11:59 -0800
Frank Rowand <frowand.list@gmail.com> escreveu:

> On 11/14/18 8:53 PM, Dan Williams wrote:
> > As presented at the 2018 Linux Plumbers conference [1], the Subsystem
> > Profile is proposed as a way to reduce friction between committers and
> > maintainers and perhaps encourage conversations amongst maintainers
> > about best practice policies. =20
>=20
> Thanks for working on this.
>=20
>=20
> > The profile contains short answers to some of the common policy
> > questions a contributor might have, or that a maintainer might consider
> > formalizing. The current list of maintenance policies is:
> >=20
> > Overview: General introduction to maintaining the subsystem
> > Core: List of source files considered core
> > Leaf: List of source files that consume core functionality
> > Patches or Pull requests: Simple statement of expected submission format
> > Last -rc for new feature submissions: Expected lead time for submissions
> > Last -rc to merge features: Deadline for merge decisions
> > Non-author Ack / Review Tags Required: Patch review economics
> > Test Suite: Pass this suite before requesting inclusion
> > Resubmit Cadence: When to ping the maintainer
> > Trusted Reviewers: Help for triaging patches
> > Time Zone / Office Hours: When might a maintainer be available
> > Checkpatch / Style Cleanups: Policy on pure cleanup patches
> > Off-list review: Request for review gates
> > TODO: Potential development tasks up for grabs, or active focus areas
> >=20
> > The goal of the Subsystem Profile is to set expectations for
> > contributors and interim or replacement maintainers for a subsystem.
> >=20
> > See Documentation/maintainer/subsystem-profile.rst for more details, and
> > a follow-on example profile for the libnvdimm subsystem.
> >=20
> > [1]: https://linuxplumbersconf.org/event/2/contributions/59/
> >=20
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: Steve French <stfrench@microsoft.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Tobin C. Harding <me@tobin.cc>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Martin K. Petersen <martin.petersen@oracle.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  Documentation/maintainer/index.rst             |    1=20
> >  Documentation/maintainer/subsystem-profile.rst |  145 ++++++++++++++++=
++++++++
> >  MAINTAINERS                                    |    4 +
> >  3 files changed, 150 insertions(+)
> >  create mode 100644 Documentation/maintainer/subsystem-profile.rst
> >=20
> > diff --git a/Documentation/maintainer/index.rst b/Documentation/maintai=
ner/index.rst
> > index 2a14916930cb..1e6b1aaa6024 100644
> > --- a/Documentation/maintainer/index.rst
> > +++ b/Documentation/maintainer/index.rst
> > @@ -11,4 +11,5 @@ additions to this manual.
> > =20
> >     configure-git
> >     pull-requests
> > +   subsystem-profile
> > =20
> > diff --git a/Documentation/maintainer/subsystem-profile.rst b/Documenta=
tion/maintainer/subsystem-profile.rst
> > new file mode 100644
> > index 000000000000..a74b624e0972
> > --- /dev/null
> > +++ b/Documentation/maintainer/subsystem-profile.rst
> > @@ -0,0 +1,145 @@
> > +.. _subsystemprofile:
> > +
> > +Subsystem Profile
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The Subsystem Profile is a collection of policy positions that a
> > +maintainer or maintainer team establishes for the their subsystem. Whi=
le
> > +there is a wide range of technical nuance on maintaining disparate
> > +sections of the kernel, the Subsystem Profile documents a known set of
> > +major process policies that vary between subsystems.  What follows is a
> > +list of policy questions a maintainer can answer and include a document
> > +in the kernel, or on an external website. It advertises to other
> > +maintainers and contributors the local policy of the subsystem. Some
> > +sections are optional like "Overview", "Off-list review", and "TODO".
> > +The others are recommended for all subsystems to address, but no secti=
on
> > +is mandatory. In addition there are no wrong answers, just document how
> > +a subsystem typically operates. Note that the profile follows the
> > +subsystem not the maintainer, i.e. there is no expectation that a
> > +maintainer of multiple subsystems deploys the same policy across those
> > +subsystems.
> > +
> > +
> > +Overview
> > +--------
> > +In this optional section of the profile provide a free form overview of
> > +the subsystem written as a hand-off document. In other words write a
> > +note to someone that would receive the =E2=80=9Ckeys to the castle=E2=
=80=9D in the event
> > +of extended or unexpected absence. =E2=80=9CSo, you have recently beco=
me the
> > +maintainer of the XYZ subsystem, condolences, it is a thankless job,
> > +here is the lay of the land.=E2=80=9D Details to consider are the exte=
nded
> > +details that are not included in MAINTAINERS, and not addressed by the
> > +other profile questions below. For example details like, who has access
> > +to the git tree, branches that are pulled into -next, relevant
> > +specifications, issue trackers, and sensitive code areas. If available
> > +the Overview should link to other subsystem documentation that may
> > +clarify, re-iterate, emphasize / de-emphasize portions of the global
> > +process documentation for contributors (CodingStyle, SubmittingPatches,
> > +etc...).
> > +
> > +
> > +Core
> > +----
> > +A list of F: tags (as described by MAINTAINERS) listing what the
> > +maintainer considers to be core files. The review and lead time
> > +constraints for 'core' code may be stricter given the increased
> > +sensitivity and risk of change.
> > +
> > +
> > +Patches or Pull requests
> > +------------------------
> > +Some subsystems allow contributors to send pull requests, most require
> > +mailed patches. State =E2=80=9CPatches only=E2=80=9D, or =E2=80=9CPull=
 requests accepted=E2=80=9D. =20
>=20
> This may create some confusion if only "Pull requests accepted" is the
> contents of this section.  My understanding has been that all changes
> should be available on a mail list for review before being accepted
> by the maintainer, even if eventually the final version of the series
> that is accepted is applied by the maintainer as a pull instead of
> via applying patches.
>=20
> Is my "must appear on a mail list" understanding correct?

I guess this is true on almost all subsystems that accept pull requests.

It could not be true if some subsystem moves to Github/Gitlab.

> > +
> > +
> > +Last -rc for new feature submissions
> > +------------------------------------
> > +New feature submissions targeting the next merge window should have
> > +their first posting for consideration before this point. Patches that
> > +are submitted after this point should be clear that they are targeting
> > +the NEXT+1 merge window, or should come with sufficient justification
> > +why they should be considered on an expedited schedule. A general
> > +guideline is to set expectation with contributors that new feature
> > +submissions should appear before -rc5. The answer may be different for
> > +'Core:' files, include a second entry prefixed with 'Core:' if so. =20
>=20
> I would expect the -rc to vary based on the patch series size, complexity,
> risk, number of revisions that will occur, how controversial, number of
> -rc releases before Linus chooses to release, etc.  You would need a
> crystal ball to predict much of this.  I could see being able to provide
> a good estimate of this value for a relatively simple patch.

That's only partially true. I mean, the usual flux is to go up to -rc7.
After that, the final version is usually merged (except when something
goes wrong).

Anyway, I guess nobody would complain if the maintainers do an exception
here and accept more patches when they know that the last rc version
won't be -rc7, but, instead, -rc8 or -rc9.

This is a general ruleset that describes the usual behavior, telling the
developers the expected behavior. If the maintainers can do more on some
particular development cycle, it should be fine.

>=20
> > +
> > +
> > +Last -rc to merge features
> > +--------------------------
> > +Indicate to contributors the point at which an as yet un-applied patch
> > +set will need to wait for the NEXT+1 merge window. Of course there is =
no
> > +obligation to ever except any given patchset, but if the review has not
> > +concluded by this point the expectation the contributor should wait and
> > +resubmit for the following merge window. The answer may be different f=
or
> > +'Core:' files, include a second entry prefixed with 'Core:' if so. =20
>=20
> Same comment as for the previous section, with the additional complexity
> that each unique patch series should bake in -next.
>=20
>=20
> > +
> > +
> > +Non-author Ack / Review Tags Required
> > +------------------------------------- =20
>=20
> The title of this section seems a bit different than the description
> below.  A more aligned title would be something like "Maintainer
> self-commit review requirements".
>=20
>=20
> > +Let contributors and other maintainers know whether they can expect to
> > +see the maintainer self-commit patches without 3rd-party review. Some
> > +subsystem developer communities are so small as to make this requireme=
nt
> > +impractical. Others may have been bootstrapped by a submission of
> > +self-reviewed code at the outset, but have since moved to a
> > +non-author review-required stance. This section sets expectations on t=
he
> > +code-review economics in the subsystem. For example, can a contributor
> > +trade review of a maintainer's, or other contributor's patches in
> > +exchange for consideration of their own. =20
>=20
> Then another section (which is the one I expected when I slightly
> mis-read the section title) would be: Review Tags Requirements",
> which would discuss what type of review is expected, encouraged,
> or required.
>=20
>=20
> > +
> > +
> > +Test Suite
> > +----------
> > +Indicate the test suite all patches are expected to pass before being
> > +submitted for inclusion consideration.
> > +
> > +
> > +Resubmit Cadence
> > +----------------
> > +Define a rate at which a contributor should wait to resubmit a patchset
> > +that has not yet received comments. A general guideline is to try to
> > +meet a deadline of 1 - 2 weeks to acknowledge starting consideration f=
or
> > +a patch set. =20
>=20
> Or ping instead of resubmitting?  If you resubmit the same series with
> an unchanged version then comments could be split across multiple
> email threads.  If you resubmit the same series with a new version
> number, the same comment split can occur plus it can be confusing
> that two versions have the same contents.  I suspect that there may be
> some maintainers who do prefer a resubmit, but that is just wild
> conjecture on my part.

That depends on how maintainers handle patches. Those subsystems that
use patchwork (like media) don't really require anyone to resubmit
patches. They're all stored there at patchwork database.

My workflow is that, if I receive two patches from the same person with
the same subject, I simply mark the first one as obsoleted, as usually=20
the second one is a new version, and reviewers should need some
time to handle it.=20

In other words, re-sending a patch may actually delay its handling, as
the second version will be later on my input queue, and I'll grant
additional time for people to review the second version at the community.

>=20
>=20
> > +
> > +
> > +Trusted Reviewers
> > +-----------------
> > +While a maintainer / maintainer-team is expected to be reviewer of last
> > +resort the review load is less onerous when distributed amongst
> > +contributors and or a trusted set of individuals.  This section is
> > +distinct from the R: tag (Designated Reviewer). Whereas R: identifies
> > +reviewers that should always be copied on a patch submission, the
> > +trusted reviewers here are individuals contributors can reach out to if
> > +a few 'Resubmit Cadence' intervals have gone by without maintainer
> > +action, or to otherwise consult for advice. =20
>=20
> This seems redundant with the MAINTAINERS reviewers list.  It seems like
> the role specified in this section is more of an ombudsman or developer
> advocate who can assist with the review and/or accept flow if the
> maintainer is being slow to respond.

Well, on subsystems that have sub-maintainers, there's no way to point to
it at MAINTAINERS file.

Also, not sure about others, but I usually avoid touching at existing
MAINTAINERS file entries. This is a file that everyone touches, so it
has higher chances of conflicts.

Also, at least on media, we have 5 different API sets (digital TV, V4L2, CE=
C,
media controller, remote controller). Yet, all drivers are stored at the
same place (as a single driver may use multiple APIs).

The reviewers for each API set are different. There isn't a good way
to explain that inside a MAINTANERS file.

>=20
>=20
> > +
> > +
> > +Time Zone / Office Hours
> > +------------------------
> > +Let contributors know the time of day when one or more maintainers are
> > +usually actively monitoring the mailing list. =20
>=20
> I would strike "actively monitoring the mailing list".  To me, it should
> be what are the hours of the day that the maintainer might happen to poll
> (or might receive an interrupt) from the appropriate communications
> channels (could be IRC, could be email, etc).
>=20
> For my area, I would want to say something like: I tend to be active
> between 17:00 UTC (18:00 UTC when daylight savings) and 25:00 (26:00),
> but often will check for urgent or brief items up until 07:00 (08:00).
> I interact with email via a poll model.  I interact with IRC via a
> pull model and often overlook IRC activity for multiple days).

Frankly, for media, I don't think that working hours makes sense. Media=20
(sub-)maintainers are spread around the globe, on different time zones
(in US, Brazil and Europe). We also have several active developers in
Japan, so we may end by having some day reviewers/sub-maintainers from
there.

At max, we can say that we won't warrant to patches on weekends or holidays.

Cheers,
Mauro
