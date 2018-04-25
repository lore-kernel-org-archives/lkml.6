Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbeDYWIk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752313AbeDYWIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:08:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6AF21745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 25 Apr 2018 23:08:34 +0100
From: James Hogan <jhogan@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: c-r4k: fix data corruption related to cache
 coherence.
Message-ID: <20180425220834.GC25917@saruman>
References: <87sh7klyhc.fsf@notabene.neil.brown.name>
 <20180425214650.GA25917@saruman>
 <87h8nzlzf1.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <87h8nzlzf1.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 08:00:18AM +1000, NeilBrown wrote:
> On Wed, Apr 25 2018, James Hogan wrote:
> > So I'm thinking "!mips_cm_present()" should probably be replaced with
> > "!r4k_op_needs_ipi(R4K_INDEX)" (and the comment updated to mention that
> > IPI calls aren't implemented here).
>=20
> That makes sense.  I tried ipi calls at one stage.  Synchronous ones
> cannot be used because this code is called with interrupts disabled, and
> async ones cannot provide the required guarantees.

Okay. I thought something like that might be the case.

>=20
> I'll update the patch, test that it still works, and resend, in the next
> day or so.

Thanks. It wouldn't hurt to also mention why IPIs can't be used in the
code comments, if its fresh in your mind, just for the benefit of next
person to attempt it.

Cheers
James

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuD8YQAKCRA1zuSGKxAj
8qhiAQDy4PgqTJQrBqDyhppFRJRq1oCRGDz9EGtqFs51hCP9TgEArA/K9cg3Wszh
ckssoKrrkL4uvnpylKDNzb9aP+4GAQM=
=9Wdc
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
