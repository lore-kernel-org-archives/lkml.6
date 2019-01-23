Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE099C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9CC21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfAWRnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:43:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:39835 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfAWRns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:43:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 09:43:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,512,1539673200"; 
   d="asc'?scan'208";a="140689614"
Received: from jtkirshe-desk1.jf.intel.com ([134.134.177.96])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2019 09:43:45 -0800
Message-ID: <87311718008d10cf7f59578fce13c0beddbe1cf4.camel@intel.com>
Subject: Re: [PATCH net-next] intel: Mark expected switch fall-throughs
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 23 Jan 2019 09:44:48 -0800
In-Reply-To: <368769c1-bb6c-b137-14c4-ef0ade488c2e@embeddedor.com>
References: <20190123074849.GA24230@embeddedor>
         <e356e64d3267bbca1cfa0373b7ce965edaf159bd.camel@intel.com>
         <368769c1-bb6c-b137-14c4-ef0ade488c2e@embeddedor.com>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-AW4GVWXbmwK0iZzgBynC"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AW4GVWXbmwK0iZzgBynC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-01-23 at 11:11 -0600, Gustavo A. R. Silva wrote:
> Hi Jeffrey,
>=20
> On 1/23/19 11:04 AM, Jeff Kirsher wrote:
> > On Wed, 2019-01-23 at 01:48 -0600, Gustavo A. R. Silva wrote:
> > > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > > cases
> > > where we are expecting to fall through.
> > >=20
> > > This patch fixes the following warnings:
> > >=20
> > > drivers/net/ethernet/intel/igb/e1000_82575.c:636:6: warning: this
> > > statement may fall through [-Wimplicit-fallthrough=3D]
> > > drivers/net/ethernet/intel/igb/igb_main.c:6710:6: warning: this
> > > statement may fall through [-Wimplicit-fallthrough=3D]
> > > drivers/net/ethernet/intel/i40e/i40e_xsk.c:237:3: warning: this
> > > statement may fall through [-Wimplicit-fallthrough=3D]
> > >=20
> > > Warning level 3 was used: -Wimplicit-fallthrough=3D3
> > >=20
> > > This patch is part of the ongoing efforts to enabling
> > > -Wimplicit-fallthrough.
> > >=20
> > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > ---
> > >   drivers/net/ethernet/intel/i40e/i40e_xsk.c   | 3 ++-
> > >   drivers/net/ethernet/intel/igb/e1000_82575.c | 2 +-
> > >   drivers/net/ethernet/intel/igb/igb_main.c    | 2 +-
> > >   3 files changed, 4 insertions(+), 3 deletions(-)
> >=20
> > NAK on the igb changes.  There is already a "fall through" code
> > comment
> > which is fine, adding a hyphen does not make the comment any more
> > readable.
> >=20
>=20
> Those comments are not fine. They trigger the warnings I mention in
> the
> commit log. With this patch such warnings are fixed.
>=20
> Notice that warning level 3 was used: -Wimplicit-fallthrough=3D3

This is a "false positive" based on the compiler option definition:

-Wimplicit-fallthrough=3D3 case sensitively matches a wide range of
regular expressions, listed in the GCC manual. E.g., all of these are
accepted:
/* Falls through. */
/* fall-thru */
/* Else falls through. */
/* FALLTHRU */
/* =E2=80=A6 falls through =E2=80=A6 */
etc.

You should be looking to fix the problem with the compiler option,
which is reporting "acceptable" code comments.

--=-AW4GVWXbmwK0iZzgBynC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlxIqBAACgkQ5W/vlVpL
7c7Sig//d2+hLz+tDxU6zuMrRxxR76nFpQeez5JQO4H+I2m8tmEH1y8RjafXvt8p
MGZSZiIRQbJHrUZGuczJXvTnM7x7PXLOMNhU0D9jmSX/+YfmiTnTMMc6y9HTGqhd
gmHCMSx4iJzDI4ZgRddBU9+MYidHrlCcJ5sWzFasJ2chxnWtUQ8l2wRrEuSF9NNt
POncEcVU1ynA2UJI9EhWVWYz7xIkrBnWDEKNkT1rxUCvhTvNmBvnmuJ7d0NPWSi6
Lf6N5ki8TfieoU7L59CUtVntSQp0P9v5BCSRFu9Cop13mQ4aTVYSrryUXIJBDR6J
4WWTz3csPatCDttHmOhBIRntKMogvUrLvkXg5NCVeW31q5PmYfj5fW/XF8e6lhoL
X+ed7FcmfCYwKSxVvu1Syfhq3hjhVEkG38i6+j0gZfgvjNtX3tWkoP1kjXiMAtMu
dazQSrDTx3iQal8+pjZ2F1Qi0jusbDedDtaX2x5NNQbiydysLo5qh5BMHwY/1+Fd
+wtmmhr1E3b0W3VDR2p5955a5MPnncoV8fWZrVlbqbGiD9RyJtREc2HKa+wGATy4
zz6i2QhAfmpqkXoHmGehv4rrdkFFp+2vv9As6o/dmIqv8apuziaoYgDP/DRJCiTV
PeBN8IGAMsblu6ZWcwgnm1T6Jf4UsbYgqw4/BNZ6nGjJUWTE17M=
=O3i2
-----END PGP SIGNATURE-----

--=-AW4GVWXbmwK0iZzgBynC--

