Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFCDC04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23856213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23856213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeKTTSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:18:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47914 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbeKTTSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:18:31 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 56C4580976; Tue, 20 Nov 2018 09:50:27 +0100 (CET)
Date:   Tue, 20 Nov 2018 09:50:29 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
Message-ID: <20181120085029.GA10051@amd>
References: <20181031150625.147369-1-dancol@google.com>
 <20181105132205.138695-1-dancol@google.com>
 <20181119105426.GD28607@amd>
 <CAKOZueu3RQF4hOSg-0LCNVzJsJ=D_yfXg_uun2tqXW8aSkKykw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <CAKOZueu3RQF4hOSg-0LCNVzJsJ=D_yfXg_uun2tqXW8aSkKykw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-11-19 08:24:02, Daniel Colascione wrote:
> On Mon, Nov 19, 2018 at 2:54 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Mon 2018-11-05 13:22:05, Daniel Colascione wrote:
> >> State explicitly that holding a /proc/pid file descriptor open does
> >> not reserve the PID. Also note that in the event of PID reuse, these
> >> open file descriptors refer to the old, now-dead process, and not the
> >> new one that happens to be named the same numeric PID.
> >>
> >> Signed-off-by: Daniel Colascione <dancol@google.com>
> >> ---
> >>  Documentation/filesystems/proc.txt | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> Moved paragraphed to start of /proc/pid section; added signed-off-by.
> >>
> >> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesy=
stems/proc.txt
> >> index 12a5e6e693b6..0b14460f721d 100644
> >> --- a/Documentation/filesystems/proc.txt
> >> +++ b/Documentation/filesystems/proc.txt
> >> @@ -125,6 +125,13 @@ process running on the system, which is named aft=
er the process ID (PID).
> >>  The link  self  points  to  the  process reading the file system. Eac=
h process
> >>  subdirectory has the entries listed in Table 1-1.
> >>
> >> +Note that an open a file descriptor to /proc/<pid> or to any of its
> >> +contained files or subdirectories does not prevent <pid> being reused
> >> +for some other process in the event that <pid> exits. Operations on
> >
> > "does not" -> "may not"?
> >
> > We want to leave this unspecified, so that we can change it in future.
>=20
> No. "Does not". I'm sick and tired of procfs behavior being vague and
> unspecified to the point where even kernel developers have an

You being sick and tired does not mean this is good idea.

> incorrect mental model of how it all works. With Christian Brauner's
> good work in place and hopefully my own work to follow, we're moving
> firmly in the direction of procfs handles being struct pid references.
> Instead of waffling further, let's just buy into this model and do the
> best job we can of making it work well.

So basically decision is being made now, without seeing Christian's
and your good work. That's not same thing as documentation...

Please don't do this.

NAK.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvzytQACgkQMOfwapXb+vLvuwCgtUWzJEcpROuQ0FLuPRo7zP3d
LF0AnREGUrREPKdmydTmPkbyef6sSBLH
=30oN
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
