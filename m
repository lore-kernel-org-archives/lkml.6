Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18EFC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5B320844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uELLepg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBKHXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:23:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38439 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKHXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:23:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id h58so686679edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 23:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CaqWqsLs9EomuSLT8M1ERzqjllVxsqYYGyTiilGwlrU=;
        b=uELLepg3hqmPGqNuatK88S73cqcmMCHbRo8pmi5wbA/nj2NCVYPEgM0dwKE6woD/lF
         Y+uIioFSReB0qx4175TwM8dPXGcAj1oo3UYSjHHZhoKRRZS2PnhBww1FMv00FMfVUTX5
         4CVAjzDDUHxD/G5v0TX5CTqspfygn79fwWXT4tXyglOwVDLomC8B6afBIA3gTmwZk63K
         PLVXnuyBi637WNnxalRde2yXRCiVFmfkHvNJTQZXq2eBlKaYy3drK7upRVEKsnl8vOvY
         ZmpWtUw9z8p/a3BMC+8ZyVuXlBTWR83w5nF2j147XhOAJb0Bh1cCPF7bilbmcF1Uvcjs
         u3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CaqWqsLs9EomuSLT8M1ERzqjllVxsqYYGyTiilGwlrU=;
        b=o3y0RggWGegawJOTh2MK/sTDggnVO3IxP+LyqfmPXsd1yi+PkrwN71bQ1VAR0vFhAx
         ELJTktmVhEuVz1FfecZCm/8noxe3lucnpG9bUdaA3l47//DMdnyVDxYPrZZwGgT56Xe4
         7UGBFOpZOPuz8VIALR5RhosUcs7tKLxvRYibUF5mL4rbxX4AHxm8eZHmnKElp5sF2c8B
         hudpNb6PiQWt3Ul0tpnwI+8srIs3Kg4r1FNGDzdxvH7es7iY0fcjoy5KBLfSl//xxa3q
         1hKwkUNX9646quH+JkSUpv69nLeG3uW7yFyDQYdY3oNEMoiphi/5Bbs74Al7Z3CgnDaY
         J26g==
X-Gm-Message-State: AHQUAuaAje96p57T5IPjaJHuLWlzT+8lOZvUbrUy3k8cgBEOO27wlZ4y
        jievPbZ+IdLoVZpnidUbUcQ6r6Rl8S+cPw==
X-Google-Smtp-Source: AHgI3IZfNPAGNT3NE/KQG1ri2pEMV8WZK+u8YbK6TS+E+QUpWlaBsIKnTWDJ4HciSVmGg/kOIDN18Q==
X-Received: by 2002:a50:86cf:: with SMTP id 15mr552302edu.239.1549869782296;
        Sun, 10 Feb 2019 23:23:02 -0800 (PST)
Received: from nouveau (ip4da2e549.direct-adsl.nl. [77.162.229.73])
        by smtp.gmail.com with ESMTPSA id a5sm85451edt.41.2019.02.10.23.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 23:23:01 -0800 (PST)
Date:   Mon, 11 Feb 2019 08:22:59 +0100
From:   Domenico Andreoli <cavok@debian.org>
To:     Kristian Fiskerstrand <k_f@gentoo.org>
Cc:     Ben Finney <bignose@debian.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        919356@bugs.debian.org, debian-legal@lists.debian.org,
        linux-kernel@vger.kernel.org,
        Martin Steigerwald <martin.steigerwald@proact.de>,
        Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Licensing of include/linux/hash.h
Message-ID: <20190211072259.GA19224@nouveau>
References: <20190115170017.5gxarqxzfezgr5ld@dumbo>
 <20190123085000.fp7lhtjxcyzw3m4x@dumbo>
 <c3aa1b37-60bb-aceb-10ba-9768157a2a5a@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <c3aa1b37-60bb-aceb-10ba-9768157a2a5a@gentoo.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 12:08:32AM +0100, Kristian Fiskerstrand wrote:
> On 1/23/19 9:50 AM, Domenico Andreoli wrote:
> > Ben Finney <bignose@debian.org> writes:
> >> Domenico Andreoli <cavok@debian.org> writes:

[...]

> >>> the only knot left is now the license of hash.h
> >>>
> >>> This file is also present in the kernel [0] with an updated copyright
> >>> but still without license.

[...]

> >> To know that work (that file) is free software, we need a clear grant =
of
> >> some specific license, for that work.
> >>
> >> If the work is not free, it would be incorrect to have the work in Deb=
ian.
> >=20
> > Is it possible that for the kernel it is instead correct because it is,
> > as whole, covered by its COPYING?
> >=20
> >> Alternatives, for complying with the Debian Free Software Guidelines w=
ith
> >> this package, include:
> >>
> >> * Find a credible grant of license under some GPL-compatible free
> >>   license to that exact file. Document that explicit grant in the Debi=
an
> >>   package. This demonstrates the work is DFSG-free.
> >>
> >> * Convince ???dwarves-dfsg??? upstream to replace that file with a dif=
ferent
> >>   implementation (I don't know whether such an implementation exists)
> >>   under a license compatible with the same version of GNU GPL. Document
> >>   that explicit grant in the Debian package. This demonstrates the
> >>   modified work is DFSG-free.
> >>
> >> * Replace that file in Debian only, with a different implementation as
> >>   above. Document that explicit grant in the Debian package. This
> >>   demonstrates the modified Debian package is DFSG-free.
> >>
> >> * Move the work to the ???non-free??? area.
> >>
> >> * Remove the work altogether.
> >>
> >> Those are in descending order of (my recommended) preference.

[...]

> It was [pointed out] by one of our license group that [hash.h]  is the
> same that has a GPL-2+ in [fio] which has a signed-off-by.
>=20
> References:
> [pointed out]
> https://bugs.gentoo.org/677586#c1
>=20
> [hash.h]
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/fio.git/commit/hash=
=2Eh?id=3Dbdc7211e190482f0c17c109a0d90834a6611be1c

Yes, the Signed-off-by is from Jens Axboe (in CC) but he's not the
original author, I guess he just copied the file as Arnaldo did. The
file he committed has not any reference to the license.

> [fio]
> https://metadata.ftp-master.debian.org/changelogs/main/f/fio/fio_3.12-2_c=
opyright

I'm afraid that this entry in wrong. I'll seek confirmation with Martin Ste=
igerwald.

Regards,
Domenico

--=20
3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iLMEAAEKAB0WIQT3MNZB0x8uuvIYPAfQqOu9Y5cS/AUCXGEi0wAKCRDQqOu9Y5cS
/AJoBADW7jeMKSKDCh94jLW7cNHGMbgBio0cdpyxlpOY0hoDdqCqsi7HINRwGoAO
FblEExhynQxalzc/rmeWRaKBKNN0pXxFm4/V2VPoFVmUGzMaRNG67axgMaqnOyb4
cvIZCdpNDCB3WH7HqPxL6N95Wo7NmovoEMaahtY3gJofkn4NNw==
=SD6I
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
