Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80AAC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A9320852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GH9hW4lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A9320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbeGZBS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:18:28 -0400
Received: from ozlabs.org ([203.11.71.1]:40991 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbeGZBS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:18:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41bXQD20JCz9s1R;
        Thu, 26 Jul 2018 10:04:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532563460;
        bh=higIhvpf2axbsWJyUwDuHaUvrK1VzCHgrNSW9McOPS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GH9hW4lwfLjMRx4L0zlXUQIWCk3c+91iR177UmYLAwikb/9eEPx+b/RIgdggmPu9U
         rYsVWcTvNbeBbAhLs+n92lCfOL+8+XSGu4yna5DNomCr9UcGdIFzJAlKMO/oVAwzvb
         HFRcw/oaDB6A3r09k3JpSUwykxh54HyMbWhRrip4qIqDu5Zu5XDC6gsRXUMDd2HLly
         5puqeVvzFV033Cc6s3SwE8tHrrsUtZJSblJUJxyPPKt1p/1c5gGoNAaoBI84sbC7rv
         BSvxYFEahp97dZbq9SWPryAEKY1Q181AObLImZj4SgtDavQus84xC8chopGThitDEH
         rQU51tL69uhKA==
Date:   Thu, 26 Jul 2018 10:03:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the xarray tree
Message-ID: <20180726100352.2d7c9c21@canb.auug.org.au>
In-Reply-To: <20180725233621.GA20272@bombadil.infradead.org>
References: <20180726072814.6c93b595@canb.auug.org.au>
        <20180725233621.GA20272@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SVpBEgyhG6eN5FgH7xs5lSx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SVpBEgyhG6eN5FgH7xs5lSx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Wed, 25 Jul 2018 16:36:21 -0700 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> On Thu, Jul 26, 2018 at 07:28:14AM +1000, Stephen Rothwell wrote:
> >=20
> > Commits
> >=20
> >   890e537e2b42 ("filesystem-dax: Introduce dax_lock_mapping_entry()")
> >   aaf149902c79 ("filesystem-dax: Set page->index")
> >=20
> > are missing a Signed-off-by from their committers. =20
>=20
> Oh, hah.  I assume this is an automated email?

Well, semi-automatic :-)

> These two commits I cherry-picked from the nvdimm tree so that XArray can
> be rebased on top of it.  Is there some other way I should be doing this,
> like rebasing on top of the nvdimm tree?

Ideally, the nvdimm tree would have just those two commits in a branch
that you could merge (so that you both have the same commits (as
opposed to patches)) that way these changes cannot cause conflicts when
the files are further modifed in either tree.  Alternatively, if you do
have to cherry-pick them, then you need to add your Signed-off-by to
the copy that you commit.

As things are now, you could merge commit

  c2a7d2a11552 ("filesystem-dax: Introduce dax_lock_mapping_entry()")

from the nvdimm tree into your tree before the conflicting commits in
your tree (or just rebase your tree on top of that commit).  You need
to make sure that Dan and/or Dave (cc'd) will never rebase that part of
their tree.  Also, you will pick up some other commits (which may not
be a problem for you).
--=20
Cheers,
Stephen Rothwell

--Sig_/SVpBEgyhG6eN5FgH7xs5lSx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltZD+gACgkQAVBC80lX
0Gxv5Qf+OCqn81Iw9tHqUcywVWSKZYQHrfz6r96elRGsRmQzf5+ISrtqxh1MFIn2
uX0kJxXf6/ZD/4Xt6TWH/BDEECJ4Gw4sc7zM2QrigcANWPSZskZt25iVJzn9FEQa
n27uGdFsaOd1yCVAiyCPGUKsca/wTlqrhYZe6lbBlCqdmjDFhQHZqD4sA9chruY3
yhez20dCkNik+jUloZqBjZcI8SedNXsGA7vQpS84WxskIwwTzbNK+0y6PFt3hhOF
pjAo5JuEofOsUqVkvj2jojTcD3Gbx7oztxBWLHn9TFT+MChIUgr++3O/iUzgD9cF
LHrQ6qchM7sG00JQ2f2IF2DbYtMavg==
=2c05
-----END PGP SIGNATURE-----

--Sig_/SVpBEgyhG6eN5FgH7xs5lSx--
