Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFDAC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 00:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2E220C51
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 00:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dLrnsvol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2E220C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeHSDiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 23:38:12 -0400
Received: from ozlabs.org ([203.11.71.1]:40905 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeHSDiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 23:38:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41tHq51hB8z9s4V;
        Sun, 19 Aug 2018 10:28:32 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534638518;
        bh=gRjmzN8HUGDpSgslbw6WLO0dbA6On7Mjf72TVja7Emg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dLrnsvolcz2+kSDHG6AapdC06dDEXuAU3tOgEhYoQhp7LXVec5uPoLXZsSOAih/YT
         rHcNVyBDFqsX+4qGvaAliLRGKMcMgQS0lQTQXrKanYVYcY2bDzoerX/Z6XQJOz+LIB
         mzqdYLG5IRXUSXF3HbRqQ9r3oQUgdxqOwW84CQ/UHEpq58ksagTHie9/mIS0BwBgJ4
         2Cv5sAvwVd3sM1va6vjAcuoqwrl9dAky2ypd1nT0fSnBHUJcQGW6xZAvABG79Z7UUq
         br+GxD2li4hFEcwQMAjEEQF56KhbUHFmAYtWf3O0y/+jiKw1JMkOf0l8CFdFwjAUh6
         KTbnTQVoEJufg==
Date:   Sun, 19 Aug 2018 10:28:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Greg KH <greg@kroah.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Magnus Damm <damm+renesas@opensource.se>
Subject: Re: linux-next: manual merge of the driver-core tree with the iommu
 tree
Message-ID: <20180819102827.17365759@canb.auug.org.au>
In-Reply-To: <20180711131445.7e1e211b@canb.auug.org.au>
References: <20180711131445.7e1e211b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/n4misSL5e_TOxGNTvVAYa/t"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n4misSL5e_TOxGNTvVAYa/t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 11 Jul 2018 13:14:45 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the driver-core tree got a conflict in:
>=20
>   drivers/iommu/ipmmu-vmsa.c
>=20
> between commits:
>=20
>   0b8ac1409641 ("iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code")
>   3701c123e1c1 ("iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code=
")
>   98dbffd39a65 ("iommu/ipmmu-vmsa: Hook up R8A77965 DT matching code")
>=20
> from the iommu tree and commit:
>=20
>   ac6bbf0cdf42 ("iommu: Remove IOMMU_OF_DECLARE")
>=20
> from the driver-core tree.
>=20
> I fixed it up (I removed the new IOMMU_OF_DECLARE() lines) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.

This is now a conflict between Linus' tree and the iommu tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/n4misSL5e_TOxGNTvVAYa/t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt4uasACgkQAVBC80lX
0Gw7jAf/cTkUZ9lWZduk2tT4O3K+bdBwo9Rw+NDkwC8kcK30GOOJRMiwn+i2+vK/
YDG59dTH/jU+dIuKs/qn6VKjGsIOG9oj1vempMzDSm2I5t2ahOmOYAoLX7hGvXH/
Qb7B2MeVy9AzeLg+eE9qUNC/8Bn/XDA7MXmJQsYZdFsJON7DSW8bCvlWVUiIGwCO
pRzdJVR1aF/50GMVnlPSx+8HVQ/c5IPnt4A/tSHeHR+J4ZrbMe1VYpejx4SgxzZk
IUMYYjS5JQwRn1U9Hkl82Hpu/hNf8ttW13k5sSLAmJX0F0U1ezdeGNTbtD6YejoF
j00+S7ObkMFZPl9dCX8YfV8NWwe+zA==
=nsZy
-----END PGP SIGNATURE-----

--Sig_/n4misSL5e_TOxGNTvVAYa/t--
