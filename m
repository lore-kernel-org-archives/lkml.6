Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D560C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2958218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2958218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeHEX55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 19:57:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43088 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeHEX55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 19:57:57 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D7FC08063C; Sun,  5 Aug 2018 23:51:50 +0200 (CEST)
Date:   Sun, 5 Aug 2018 23:51:50 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Andrew Pinski <pinskia@gmail.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        ard.biesheuvel@linaro.org,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Florian Weimer <fweimer@redhat.com>,
        thomas.petazzoni@free-electrons.com,
        GNU C Library <libc-alpha@sourceware.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
Message-ID: <20180805215150.GB1862@amd>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com>
 <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Can you run the test program on x86 using the similar framebuffer
> > setup?  Does doing two writes (one aligned and one unaligned but
> > overlapping with previous one) cause the same issue?  I suspect it
> > does, then using memcpy for frame buffers is wrong.

I'm pretty sure it will work ok on x86.

> Overlapping unaligned writes work on x86 - they have to, because of=20
> backward compatibility.

It is not that easy. 8086s (and similar) did not have MTRRs and PATs
either. Overlapping unaligned writes _on main memory_, _with normal
MTRR settings_ certainly work ok on x86.

Chances is memory type can be configured to work similar way on your
ARM/PCIe case?

> 8086, 80286 and 80386 didn't have any cache at all.

386s had cache (but not on die).
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltncXYACgkQMOfwapXb+vLjnACgviHS0QA96XvspC2s/b9nRkCR
K4cAoKc484UBeHoiMMGsNdgqoeaO8ADS
=xTyZ
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
