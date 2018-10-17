Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838A2ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4DF21486
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4DF21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeJRCjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:39:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:60469 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbeJRCjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:39:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 11:42:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="asc'?scan'208";a="83418271"
Received: from jtkirshe-desk1.jf.intel.com ([134.134.177.96])
  by orsmga006.jf.intel.com with ESMTP; 17 Oct 2018 11:42:53 -0700
Message-ID: <540496d168b9fa0d799fdc88990f569b615e5847.camel@intel.com>
Subject: Re: [PATCH net-next] ixgbe: fix XFRM_ALGO dependency
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     shannon.nelson@oracle.com, David Miller <davem@davemloft.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Oct 2018 11:46:20 -0700
In-Reply-To: <CAK8P3a3RiMHVkoA+Wp_abPJ5Fzwk5UdhoOaxt++q4_YnzDRwfA@mail.gmail.com>
References: <20181016100848.1329843-1-arnd@arndb.de>
         <07e372cb-06da-bf95-bc53-64ee09fc8e76@oracle.com>
         <3f8e7a6e9532abcd772927432d5f00cebeba08b8.camel@intel.com>
         <CAK8P3a3RiMHVkoA+Wp_abPJ5Fzwk5UdhoOaxt++q4_YnzDRwfA@mail.gmail.com>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HRpEtTPxq8VgKuRp6Ztb"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HRpEtTPxq8VgKuRp6Ztb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-10-17 at 18:04 +0200, Arnd Bergmann wrote:
> On Wed, Oct 17, 2018 at 5:53 PM Jeff Kirsher
> <jeffrey.t.kirsher@intel.com> wrote:
> > On Tue, 2018-10-16 at 09:35 -0700, Shannon Nelson wrote:
> > > On 10/16/2018 3:03 AM, Arnd Bergmann wrote:
> > > > A separate Kconfig symbol now controls whether we include the
> > > > ipsec
> > > > offload code. To keep the old behavior, this is left as
> > > > 'default
> > > > y'. The
> > > > dependency in XFRM_OFFLOAD still causes a circular dependency
> > > > but
> > > > is
> > > > not actually needed because this symbol is not user visible, so
> > > > removing
> > > > that dependency on top makes it all work.
> > > >=20
> > > > Fixes: eda0333ac293 ("ixgbe: add VF IPsec management")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >=20
> > I agree with Shannon's suggested changes.  Arnd, are you working on
> > v2?
> > Or would you like me to take care of it?
>=20
> I was planning to respin it, but didn't get around to it yet, and
> will
> be travelling for the next week, so I'd welcome if you can take over
> from here. Shannon's comments all make sense to me as well.

Ok, I will run with it and make a v2 for you.

>=20
> > > > +config IXGBE_IPSEC
> > > > +   bool "IPSec XFRM cryptography-offload accelaration"
> > > > +   default n
> > >=20
> > > remove this "default n" line?
>=20
> I meant for this to say "default y", as I said in the changelog,
> but feel free to pick whichever default makes sense to you
> make make the description match ;-)


--=-HRpEtTPxq8VgKuRp6Ztb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlvHg3wACgkQ5W/vlVpL
7c6bPA//TaEREo7cqHg6pzP4THZhqErcX7RUY32RvIXfik9/t2ns3o7FIdC59rSt
1Lz4Ptu2pHCB2gX97SasXTlYqFvpRFMlbtaoyAlDC77k+Kc2mHsoh+KmXSSsCnVf
TIrYMwKjyNm1dB35kEmEx+ddCmnFnIcG2uROcgW1XaJv3rLufufgGKGbHnUC3/Kg
rEQ/QZSVHXhZtfcZq09PUP6FKtO8aR4XND+JGW3e4r06FudNrkpwDoIOE9pHspqC
gJq6PGEp+hBxijiR2acn8FX7YQvLaVEze+LIq34IenJ+t718CM5bq0GdO6qviPUs
xYlsFUbJ/Uefv8u5H6QpEOoKbgtZT4zmPRs4t0OgiSnm/rE9enr+gEOOeLhrgnV7
fbN2evxpZAPWo3biEsGfMjjIPeONajH2+Wjt4DBtls2nXymx40oFLplbMDO2pP4s
6fjRmBYcPnfseas+mAW/VMWZaH6/X/1BbN88rUaWOh23laHgds5CpbqpaRKg1+4a
nicrSZ2qHYymLdUZti5H7Axzf2cnuie+2GrIZUTmYeoPwQ+RaAkR7Hf05kkg01M0
oh4h+eW/ul/iIoNlJOBYNm+4cgYFskZVb2if6SqOiy6njCxgt60ro5mUPSD2zPHC
tGlp+fJvrbG+cvsaeXj12JLHkYOhjielXMjuxPJqZDJguLB7dh4=
=pi1S
-----END PGP SIGNATURE-----

--=-HRpEtTPxq8VgKuRp6Ztb--

