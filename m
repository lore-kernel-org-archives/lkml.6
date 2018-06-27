Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50883C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03D626785
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cCtXKgWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03D626785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeF0DJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 23:09:54 -0400
Received: from ozlabs.org ([203.11.71.1]:56097 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752208AbeF0DJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 23:09:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Fnvf40sTz9s0n;
        Wed, 27 Jun 2018 13:09:50 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530068990;
        bh=R6EPGeECVoHsQZEuyV/PtbRfPDrk9X2CP5hmR0eHAJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cCtXKgWyKia92wYQzepn+ZaGCDXaNt3k9AL9AuQozEWZhc/qA+yBUFsLRh/HaJdiJ
         CLHCuJnS2Zzkb60dFts3GSLwoCXo3A2+UnNs4CzkHgoLRfWVfUEO6gLHiX4ZYBLd88
         p2GEVTBz0S8JQt+rW6sNUr5yCXGFShugqMNkZ6OcWQcNYrWG2le7XToX7BL5NYtumm
         OKjvhLqRtEoG0d+SWKKU6wUnT6SINW3vDyjXq2Y35m97pv16m/JP8r7UNeRb/IY+B5
         +eZgIVY/HhdZar2xMxZMrp2j0955m4oDbtL/itxvq/tJwtXxUC8lAOWh+sdnZXaMHS
         a0/r5WcfLWsYw==
Date:   Wed, 27 Jun 2018 13:09:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Message-ID: <20180627130950.43922340@canb.auug.org.au>
In-Reply-To: <20180618170920.GC28748@bombadil.infradead.org>
References: <20180618132712.4b4eddc9@canb.auug.org.au>
        <CAPcyv4idNE8ErxNm5bb3rG4jUeZU9HJRmO03omMJxSN-8FYN+w@mail.gmail.com>
        <20180618170920.GC28748@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Hgc937KfImDIgoXlsGBE6Hd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Hgc937KfImDIgoXlsGBE6Hd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 18 Jun 2018 10:09:20 -0700 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> On Mon, Jun 18, 2018 at 09:50:33AM -0700, Dan Williams wrote:
> > On Sun, Jun 17, 2018 at 8:27 PM, Stephen Rothwell <sfr@canb.auug.org.au=
> wrote: =20
> > > Hi all,
> > >
> > > After merging the xarray tree, today's linux-next build (powerpc
> > > ppc64_defconfig) failed like this: =20
> [...]
> > > from the nvdimm tree.
> > >
> > > Willy thanks for the heads up about this.
> > >
> > > I have applied the following merge fix patch (taken from the diff bet=
ween
> > > the -next tree at this point and the xarray-20180615 branch from the
> > > xarray tree) for today. =20
> >=20
> > I was hoping that dax_lock_page() and the memory_failure() handling
> > could go in before the xarray rework. This helps -stable and distros
> > that need to backport this error handling support. Willy, would you be
> > amenable to rebasing on top of the next rev of the
> > dax+memory_failure() work?
> >=20
> > Apologies for the thrash. =20
>=20
> I am absolutely amenable to rebasing.  The only problem is that I'm
> in Tokyo for the next two weeks.  I can put some work in on this, but
> coordination may be a little off.  If somebody else wants to do the work,
> the only (serious) difference between the xarray-20180615 and xarray
> branches in my repo is that the former is based on the dax_lock_page()
> changes having gone in.
>=20
> The differences sum up to:
>=20
> +@@ -414,8 +413,7 @@ struct page *dax_lock_page(unsigned long pfn)
> +=20
> +               entry =3D __radix_tree_lookup(&mapping->i_pages, index, N=
ULL,
> +                               &slot);
> +-              if (!entry ||
> +-                  WARN_ON_ONCE(!radix_tree_exceptional_entry(entry))) {
> ++              if (!entry || WARN_ON_ONCE(!xa_is_value(entry))) {
> +                       xa_unlock_irq(&mapping->i_pages);
> +                       break;
> +               } else if (!slot_locked(mapping, slot)) {
>=20
> (in "xarray: Replace exceptional entries")
>=20
> then dax_entry_waitqueue() changing its argument in "dax: Hash on XArray =
instead of mapping".
>=20
> and finally the patch converting dax_lock_page() and dax_unlock_page().
>=20
> I really wanted to keep the thrash here to a minimum, but this is the
> best I could come up with in terms of minimising conflicts :-(

This has all gone away today as the conflicting commits have been
removed from the nvdimm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Hgc937KfImDIgoXlsGBE6Hd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsy//4ACgkQAVBC80lX
0GxlwQf/VJ9c2xUlU1cAdGS5FsKxVc7cz8esTDMQdbjCXPspyL9mAr1iBSCuqc2+
Fdq5rfTWqxln+qcnOTu5p99s2d9ACpS0bq2OOYWUUnpHOAhxbgONjoDB79M82uab
lX5vyH0ItNmRjaNOPLc+3IX0zvmIavdRIcD6xCVCZ8s+dy5H4ewhRdXwXpHZQlG9
VlR0ntmZRsgrf4y96c8IIsYllDAa9eB3zD3TIBnCDzqYfoJaT6Ypr3ifEVgRPxAz
ECRmA3eAQKoUOvJ/14xZhyia4acxZXCQ0KDHhaYM9UgkFSNzrn6lEqas+h2seyWX
B4w4ZnAAqYrpOG5XATOKs7wnM9BeJg==
=ddow
-----END PGP SIGNATURE-----

--Sig_/Hgc937KfImDIgoXlsGBE6Hd--
