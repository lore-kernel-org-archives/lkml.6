Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98C2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E5D2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QxeuA7PG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E5D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeKOP4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:56:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeKOP4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uIj9L7Z9PP7yDreP7uGF00aHo15PGs45oEWG9RRcus0=; b=QxeuA7PG8foUv65UYR8jrBjhe
        LivM03irRF13ClnST8XlDTi8WAckndUGWU9Py/SzINKBQXjdDSEY++R0XI+v6ZNK9db4se5/IWe4L
        nQQvozEbON+X/sBE8+UmXv5JzijSFiNkBJUlvsxoRJuiB8rrosIN0i4Ub6hijKUhVFNGyGGQKI1ci
        Z0XDn06SyVRhwCX175yKzAdlo5SI/4J6F6/DJGbW2RrugaoVCgEnNu3oodzX1cQcp1YJrON++li1i
        fi04+78KcZKD0fSrN1UqCnfO/lJuPkFacOa9FtraQbxGr0YnBACX8JoZEXf9ipDjMSqkaaHZEnw4w
        z0LofBbjw==;
Received: from 189.27.28.95.dynamic.adsl.gvt.net.br ([189.27.28.95] helo=silica.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNAXH-0003so-5J; Thu, 15 Nov 2018 05:49:52 +0000
Date:   Wed, 14 Nov 2018 21:49:22 -0800
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nvdimm@lists.01.org, Dmitry Vyukov <dvyukov@google.com>,
        Steve French <stfrench@microsoft.com>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
Message-ID: <20181114214922.07d31676@silica.lan>
In-Reply-To: <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
        <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 14 Nov 2018 20:53:25 -0800
Dan Williams <dan.j.williams@intel.com> escreveu:

> As presented at the 2018 Linux Plumbers conference [1], the Subsystem
> Profile is proposed as a way to reduce friction between committers and
> maintainers and perhaps encourage conversations amongst maintainers
> about best practice policies.
>=20
> The profile contains short answers to some of the common policy
> questions a contributor might have, or that a maintainer might consider
> formalizing. The current list of maintenance policies is:
>=20
> Overview: General introduction to maintaining the subsystem
> Core: List of source files considered core
> Leaf: List of source files that consume core functionality
> Patches or Pull requests: Simple statement of expected submission format
> Last -rc for new feature submissions: Expected lead time for submissions
> Last -rc to merge features: Deadline for merge decisions
> Non-author Ack / Review Tags Required: Patch review economics
> Test Suite: Pass this suite before requesting inclusion
> Resubmit Cadence: When to ping the maintainer

> Trusted Reviewers: Help for triaging patches

There is one detail with regards to reviewing process that I'm not sure
how to express. There are some subsystems with co-maintainers, in the
sense that all co-maintainers are equally responsible for the subsystem.

There are other cases where there are sub-maintainers. That's, for example,
the model we use on media. There, we have different sub-maintainers for:

	- V4L2 drivers
	- Camera Sensors
	- Remote Controllers
	- HDMI CEC
	- DVB
	- Media Controller

The usual workflow is that they work as both reviewers and committers.
After they commit a certain amount of patches, they submit for me to
do a final review. This way, most of media patches have at least two
SOBs from non-authors.

On this model, a sub-maintainer is more than a trusted reviewer. Not sure
how to reflect it on this template.

I'll do a better review of the profile when I'll try to write a subsystem
profile for media.

Regards,
Mauro

> Time Zone / Office Hours: When might a maintainer be available
> Checkpatch / Style Cleanups: Policy on pure cleanup patches
> Off-list review: Request for review gates
> TODO: Potential development tasks up for grabs, or active focus areas
>=20
> The goal of the Subsystem Profile is to set expectations for
> contributors and interim or replacement maintainers for a subsystem.
>=20
> See Documentation/maintainer/subsystem-profile.rst for more details, and
> a follow-on example profile for the libnvdimm subsystem.
>=20
> [1]: https://linuxplumbersconf.org/event/2/contributions/59/
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Steve French <stfrench@microsoft.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Tobin C. Harding <me@tobin.cc>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/maintainer/index.rst             |    1=20
>  Documentation/maintainer/subsystem-profile.rst |  145 ++++++++++++++++++=
++++++
>  MAINTAINERS                                    |    4 +
>  3 files changed, 150 insertions(+)
>  create mode 100644 Documentation/maintainer/subsystem-profile.rst
>=20
> diff --git a/Documentation/maintainer/index.rst b/Documentation/maintaine=
r/index.rst
> index 2a14916930cb..1e6b1aaa6024 100644
> --- a/Documentation/maintainer/index.rst
> +++ b/Documentation/maintainer/index.rst
> @@ -11,4 +11,5 @@ additions to this manual.
> =20
>     configure-git
>     pull-requests
> +   subsystem-profile
> =20
> diff --git a/Documentation/maintainer/subsystem-profile.rst b/Documentati=
on/maintainer/subsystem-profile.rst
> new file mode 100644
> index 000000000000..a74b624e0972
> --- /dev/null
> +++ b/Documentation/maintainer/subsystem-profile.rst
> @@ -0,0 +1,145 @@
> +.. _subsystemprofile:
> +
> +Subsystem Profile
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Subsystem Profile is a collection of policy positions that a
> +maintainer or maintainer team establishes for the their subsystem. While
> +there is a wide range of technical nuance on maintaining disparate
> +sections of the kernel, the Subsystem Profile documents a known set of
> +major process policies that vary between subsystems.  What follows is a
> +list of policy questions a maintainer can answer and include a document
> +in the kernel, or on an external website. It advertises to other
> +maintainers and contributors the local policy of the subsystem. Some
> +sections are optional like "Overview", "Off-list review", and "TODO".
> +The others are recommended for all subsystems to address, but no section
> +is mandatory. In addition there are no wrong answers, just document how
> +a subsystem typically operates. Note that the profile follows the
> +subsystem not the maintainer, i.e. there is no expectation that a
> +maintainer of multiple subsystems deploys the same policy across those
> +subsystems.
> +
> +
> +Overview
> +--------
> +In this optional section of the profile provide a free form overview of
> +the subsystem written as a hand-off document. In other words write a
> +note to someone that would receive the =E2=80=9Ckeys to the castle=E2=80=
=9D in the event
> +of extended or unexpected absence. =E2=80=9CSo, you have recently become=
 the
> +maintainer of the XYZ subsystem, condolences, it is a thankless job,
> +here is the lay of the land.=E2=80=9D Details to consider are the extend=
ed
> +details that are not included in MAINTAINERS, and not addressed by the
> +other profile questions below. For example details like, who has access
> +to the git tree, branches that are pulled into -next, relevant
> +specifications, issue trackers, and sensitive code areas. If available
> +the Overview should link to other subsystem documentation that may
> +clarify, re-iterate, emphasize / de-emphasize portions of the global
> +process documentation for contributors (CodingStyle, SubmittingPatches,
> +etc...).
> +
> +
> +Core
> +----
> +A list of F: tags (as described by MAINTAINERS) listing what the
> +maintainer considers to be core files. The review and lead time
> +constraints for 'core' code may be stricter given the increased
> +sensitivity and risk of change.
> +
> +
> +Patches or Pull requests
> +------------------------
> +Some subsystems allow contributors to send pull requests, most require
> +mailed patches. State =E2=80=9CPatches only=E2=80=9D, or =E2=80=9CPull r=
equests accepted=E2=80=9D.
> +
> +
> +Last -rc for new feature submissions
> +------------------------------------
> +New feature submissions targeting the next merge window should have
> +their first posting for consideration before this point. Patches that
> +are submitted after this point should be clear that they are targeting
> +the NEXT+1 merge window, or should come with sufficient justification
> +why they should be considered on an expedited schedule. A general
> +guideline is to set expectation with contributors that new feature
> +submissions should appear before -rc5. The answer may be different for
> +'Core:' files, include a second entry prefixed with 'Core:' if so.
> +
> +
> +Last -rc to merge features
> +--------------------------
> +Indicate to contributors the point at which an as yet un-applied patch
> +set will need to wait for the NEXT+1 merge window. Of course there is no
> +obligation to ever except any given patchset, but if the review has not
> +concluded by this point the expectation the contributor should wait and
> +resubmit for the following merge window. The answer may be different for
> +'Core:' files, include a second entry prefixed with 'Core:' if so.
> +
> +
> +Non-author Ack / Review Tags Required
> +-------------------------------------
> +Let contributors and other maintainers know whether they can expect to
> +see the maintainer self-commit patches without 3rd-party review. Some
> +subsystem developer communities are so small as to make this requirement
> +impractical. Others may have been bootstrapped by a submission of
> +self-reviewed code at the outset, but have since moved to a
> +non-author review-required stance. This section sets expectations on the
> +code-review economics in the subsystem. For example, can a contributor
> +trade review of a maintainer's, or other contributor's patches in
> +exchange for consideration of their own.
> +
> +
> +Test Suite
> +----------
> +Indicate the test suite all patches are expected to pass before being
> +submitted for inclusion consideration.
> +
> +
> +Resubmit Cadence
> +----------------
> +Define a rate at which a contributor should wait to resubmit a patchset
> +that has not yet received comments. A general guideline is to try to
> +meet a deadline of 1 - 2 weeks to acknowledge starting consideration for
> +a patch set.
> +
> +
> +Trusted Reviewers
> +-----------------
> +While a maintainer / maintainer-team is expected to be reviewer of last
> +resort the review load is less onerous when distributed amongst
> +contributors and or a trusted set of individuals.  This section is
> +distinct from the R: tag (Designated Reviewer). Whereas R: identifies
> +reviewers that should always be copied on a patch submission, the
> +trusted reviewers here are individuals contributors can reach out to if
> +a few 'Resubmit Cadence' intervals have gone by without maintainer
> +action, or to otherwise consult for advice.
> +
> +
> +Time Zone / Office Hours
> +------------------------
> +Let contributors know the time of day when one or more maintainers are
> +usually actively monitoring the mailing list.
> +
> +
> +Checkpatch / Style Cleanups
> +---------------------------
> +For subsystems with long standing code bases it is reasonable to decline
> +to accept pure coding-style fixup patches. This is where you can let
> +contributors know =E2=80=9CStandalone style-cleanups are welcome=E2=80=
=9D,
> +=E2=80=9CStyle-cleanups to existing code only welcome with other feature
> +changes=E2=80=9D, or =E2=80=9CStandalone style-cleanups to existing code=
 are not
> +welcome=E2=80=9D.
> +
> +
> +Off-list review
> +---------------
> +A maintainer may optionally require that contributors seek prior review
> +of patches before initial submission for upstream. For example,
> +=E2=80=9CDevelopers from organization X, please seek internal review bef=
ore
> +requesting upstream review=E2=80=9D. This policy identifies occasions wh=
ere a
> +maintainer wants to reflect some of the review load back to an
> +organization.
> +
> +
> +TODO
> +----
> +In this optional section include a list of work items that might be
> +suitable for onboarding a new developer to the subsystem.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 83b7b3943a12..bb4a83a7684d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -99,6 +99,10 @@ Descriptions of section entries:
>  	   Obsolete:	Old code. Something tagged obsolete generally means
>  			it has been replaced by a better system and you
>  			should be using that.
> +	P: Subsystem Profile document for the maintainer entry.  This
> +	   is either an in-tree file or a URI to a document.  The
> +	   contents of a Subsystem Profile are described in
> +	   Documentation/maintainer/subsystem-profile.rst.
>  	F: Files and directories with wildcard patterns.
>  	   A trailing slash includes all files and subdirectory files.
>  	   F:	drivers/net/	all files in and below drivers/net
>=20
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss




Cheers,
Mauro
