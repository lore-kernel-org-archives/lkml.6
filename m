Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3E3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CA920658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CA920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeHaP0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:26:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46105 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaP0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:26:39 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 14BA180579; Fri, 31 Aug 2018 13:19:36 +0200 (CEST)
Date:   Fri, 31 Aug 2018 13:19:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Char/Misc driver patches for 4.19-rc1
Message-ID: <20180831111936.GA18291@amd>
References: <20180818155844.GA22720@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20180818155844.GA22720@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> 	- gnss, finally an in-kernel GPS subsystem to try to tame all of
> 	  the crazy out-of-tree drivers that have been floating around
> 	  for years, combined with some really hacky userspace
> 	  implementations.  This is only for GNSS receivers, but you
> 	  have to start somewhere, and this is great to see.

Yes, it  is labeled as a GPS subsystem, but there's nothing GPS
specific in there; it does not understand the data, it just passes
around bytes.

Which would not be a problem, except that it takes /dev/gnssX
namespace, so when we need to introduce hardware abstraction for
GPS, we will not have suitable names available.

I believe this should be fixed before we are stuck with bad ABI
forever.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluJJEgACgkQMOfwapXb+vJq8QCfRm1aGG/gmeGuqVGi4V1s1lVt
NFUAn3LA6jc26b0pCw1Pa8PyARePbUhP
=g++d
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
