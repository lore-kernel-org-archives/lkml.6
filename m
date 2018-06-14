Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A9715C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698C3208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698C3208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936020AbeFNTpT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:45:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42002 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755430AbeFNTpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:45:18 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A5B7380482; Thu, 14 Jun 2018 21:45:16 +0200 (CEST)
Date:   Thu, 14 Jun 2018 21:45:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Anchal Agarwal <anchalag@amazon.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com, netdev@vger.kernel.org, jgross@suse.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        kamatam@amazon.com, fllinden@amazon.com, vallish@amazon.com,
        guruanb@amazon.com, eduval@amazon.com, rjw@rjwysocki.net,
        len.brown@intel.com, linux-pm@vger.kernel.org, cyberax@amazon.com
Subject: Re: [RFC PATCH 12/12] PM / hibernate: update the resume offset on
 SNAPSHOT_SET_SWAP_AREA
Message-ID: <20180614194515.GE17808@amd>
References: <20180612205619.28156-1-anchalag@amazon.com>
 <20180612205619.28156-13-anchalag@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Content-Disposition: inline
In-Reply-To: <20180612205619.28156-13-anchalag@amazon.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Aleksei Besogonov <cyberax@amazon.com>
>=20
> The SNAPSHOT_SET_SWAP_AREA is supposed to be used to set the hibernation
> offset on a running kernel to enable hibernating to a swap file.
> However, it doesn't actually update the swsusp_resume_block variable. As
> a result, the hibernation fails at the last step (after all the data is
> written out) in the validation of the swap signature in
> mark_swapfiles().
>=20
> Before this patch, the command line processing was the only place where
> swsusp_resume_block was set.

Are you saying that suspend-to-file was broken, even on
non-virtualized systems?

If so, we may this to go in first...
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsixcsACgkQMOfwapXb+vLC3wCfX4tTCT4FWhC5Eamk0GflW7HU
XwQAoJSlWbWAf4T9Kkoe+rMuMl+uDnkz
=yswn
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
