Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6252C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F7B2086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F7B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeKZJwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 04:52:22 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51542 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeKZJwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 04:52:22 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 327D080702; Mon, 26 Nov 2018 00:00:05 +0100 (CET)
Date:   Mon, 26 Nov 2018 00:00:07 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Kevin Easton' <kevin@guarana.org>,
        Daniel Colascione <dancol@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "timmurray@google.com" <timmurray@google.com>,
        "primiano@google.com" <primiano@google.com>,
        "joelaf@google.com" <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        "MatthewWilcox@ip-172-31-15-78" 
        <MatthewWilcox@ip-172-31-15-78.karlin.mff.cuni.cz>
Subject: Re: [PATCH] Add /proc/pid_generation
Message-ID: <20181125230007.GC30242@amd>
References: <20181121201452.77173-1-dancol@google.com>
 <20181122111930.GA7164@ip-172-31-15-78>
 <f00df51af0a4491fa7d86f9dc0c07bf6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <f00df51af0a4491fa7d86f9dc0c07bf6@AcuMS.aculab.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-11-23 11:14:17, David Laight wrote:
> From: Kevin Easton
> > Sent: 22 November 2018 11:20
> >=20
> > On Wed, Nov 21, 2018 at 12:14:44PM -0800, Daniel Colascione wrote:
> > > This change adds a per-pid-namespace 64-bit generation number,
> > > incremented on PID rollover, and exposes it via a new proc file
> > > /proc/pid_generation. By examining this file before and after /proc
> > > enumeration, user code can detect the potential reuse of a PID and
> > > restart the task enumeration process, repeating until it gets a
> > > coherent snapshot.
> >=20
> > I see downthread this patch has been withdrawn, but nonetheless I'm
> > still curious - does this actually solve the problem?
> >=20
> > It seems to me that a PID could be reused within a scan even if the
> > generation number remains the same at the beginning and end of a scan:
>=20
> Why not allocate a 48bit generation number to each 16bit pid?
> Then you have a 64bit 'extended-pid' that can be assumed to never be reus=
ed.
> Provided enough interfaces are enhanced to support 'extended-pid' values
> you'll never get reused values.

For the record, I really like this proposal.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv7KXcACgkQMOfwapXb+vK6RACgmLicuJiRUJEhrPkeYFDTX9Xl
KvgAn3/bVsytzLaQKjZ0CMUlekDSLmbP
=Xat+
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
