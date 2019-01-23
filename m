Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C54C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2950E2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfAWRDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:03:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:60320 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfAWRDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:03:25 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 09:03:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,512,1539673200"; 
   d="asc'?scan'208";a="127983244"
Received: from jtkirshe-desk1.jf.intel.com ([134.134.177.96])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jan 2019 09:03:24 -0800
Message-ID: <e356e64d3267bbca1cfa0373b7ce965edaf159bd.camel@intel.com>
Subject: Re: [PATCH net-next] intel: Mark expected switch fall-throughs
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 23 Jan 2019 09:04:27 -0800
In-Reply-To: <20190123074849.GA24230@embeddedor>
References: <20190123074849.GA24230@embeddedor>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-fmWOuIELA7d+LWq9+mS2"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fmWOuIELA7d+LWq9+mS2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-01-23 at 01:48 -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> This patch fixes the following warnings:
>=20
> drivers/net/ethernet/intel/igb/e1000_82575.c:636:6: warning: this
> statement may fall through [-Wimplicit-fallthrough=3D]
> drivers/net/ethernet/intel/igb/igb_main.c:6710:6: warning: this
> statement may fall through [-Wimplicit-fallthrough=3D]
> drivers/net/ethernet/intel/i40e/i40e_xsk.c:237:3: warning: this
> statement may fall through [-Wimplicit-fallthrough=3D]
>=20
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>=20
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c   | 3 ++-
>  drivers/net/ethernet/intel/igb/e1000_82575.c | 2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c    | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)

NAK on the igb changes.  There is already a "fall through" code comment
which is fine, adding a hyphen does not make the comment any more
readable.

The i40e changes are acceptable, if you want to re-submit with only
those changes.

--=-fmWOuIELA7d+LWq9+mS2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlxInpsACgkQ5W/vlVpL
7c5dSg/8CkHC/FnDPRQFndMUXy+bxnBPLCgwaztmIav8Yn0ANDuGyghT8p099Z2E
/kI8pKitjJ9QewKL3MCwOPEIT8isHFHvQovgSVA0DaHVVimFyfc8qdOcTgWeCGv9
9ZQ6RIBC9sdkSpiWxG56sSODBd+d88Nl6JrPR/nRrePmRG+vpvHsv4Z7hKq5qX4F
RnOe2Zmnwiplhdt6asI8VatllvRJRIx7aBf50nNEGzbw6m7KStbiIB5KBuAAubGN
oTp3v8m0SiyCf54gIua9NwaHINcYDZD3fHUKgsUkldCekdoYZHkFi8W0JMYtN5/H
fPo4R2u7UvIuJmLTmVfSezUe3LKZOXDgbJysSy/KIAfJkf/ylf3i7j24InQJ2SwW
Re5VzGBMH2iII/elSvBieRBGebVZbnxpo7nXFV8xyONh9CTKNizkZgoISDlGNX4k
Q7yHJtwfwdVoDNzDCvlAn56MoH/Re7974uTqdIxSwBsp6qgWV9oVDXa9gDOD93Ie
n3bKjGG13d6NKmS2MVC45P9A6LuYoeiXf0AFoBrkRxWHfNyslNJcRSLHskuCUqmu
ygcYUMQcFQvCFTHeR83riNn2bVC9ANXOc6e7GOi5/u2TMFgsUXd5dMBob811XUhS
TfqTpTkDlsN26jqyeeYkypwwWruQ1mHiDs3yJsDAf5y73JEbrbk=
=Kxlk
-----END PGP SIGNATURE-----

--=-fmWOuIELA7d+LWq9+mS2--

