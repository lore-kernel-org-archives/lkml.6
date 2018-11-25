Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F203C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0992084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0992084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbeKZI4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:56:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50320 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeKZI4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:56:53 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A7D438081B; Sun, 25 Nov 2018 23:04:42 +0100 (CET)
Date:   Sun, 25 Nov 2018 23:04:44 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, stable@vger.kernel.org,
        Balbir Singh <bsingharora@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>, torvalds@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 0/7] mm: Merge hmm into devm_memremap_pages, mark
 GPL-only
Message-ID: <20181125220444.GA30242@amd>
References: <154275556908.76910.8966087090637564219.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181121172055.91dc52fc0b985be85e640328@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20181121172055.91dc52fc0b985be85e640328@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Changes since v7 [1]:
> > At Maintainer Summit, Greg brought up a topic I proposed around
> > EXPORT_SYMBOL_GPL usage. The motivation was considerations for when
> > EXPORT_SYMBOL_GPL is warranted and the criteria for taking the
> > exceptional step of reclassifying an existing export. Specifically, I
> > wanted to make the case that although the line is fuzzy and hard to
> > specify in abstract terms, it is nonetheless clear that
> > devm_memremap_pages() and HMM (Heterogeneous Memory Management) have
> > crossed it. The devm_memremap_pages() facility should have been
> > EXPORT_SYMBOL_GPL from the beginning, and HMM as a derivative of that
> > functionality should have naturally picked up that designation as well.
> >=20
> > Contrary to typical rules, the HMM infrastructure was merged upstream
> > with zero in-tree consumers. There was a promise at the time that those
> > users would be merged "soon", but it has been over a year with no drive=
rs
> > arriving. While the Nouveau driver is about to belatedly make good on
> > that promise it is clear that HMM was targeted first and foremost at an
> > out-of-tree consumer.

Ok, so who is this consumer and is he GPLed?

> It should be noted that [7/7] has a cc:stable.

That is pretty evil thing to do, right?

The aim here is not to fix "a real bug that hits people", AFAICT. The
aim is to break existing configurations for users.

Political games are sometimes neccessary, but should not really be
played with stable.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv7HHwACgkQMOfwapXb+vLS2QCdGLrC5x+ES/mY7gi/L7zIzTjd
BYsAn2//n2PuJ6KNErZ6Uy4a0fSjEiOE
=i+UE
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
