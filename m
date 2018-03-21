Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbeCUVrf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:47:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:8740 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753730AbeCUVre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:47:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,341,1517904000";
   d="asc'?scan'208";a="35757601"
Message-ID: <1521668888.12746.32.camel@intel.com>
Subject: Re: [PATCH REPOST v4 5/7] ixgbevf: keep writel() closer to wmb()
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To: Sinan Kaya <okaya@codeaurora.org>
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Mar 2018 14:48:08 -0700
In-Reply-To: <1521658572-26354-6-git-send-email-okaya@codeaurora.org>
References: <1521658572-26354-1-git-send-email-okaya@codeaurora.org>
         <1521658572-26354-6-git-send-email-okaya@codeaurora.org>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3IEBpCqmepFDyHB6VJLB"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3IEBpCqmepFDyHB6VJLB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-03-21 at 14:56 -0400, Sinan Kaya wrote:
> Remove ixgbevf_write_tail() in favor of moving writel() close to
> wmb().
>=20
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 5 -----
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++--
>  2 files changed, 2 insertions(+), 7 deletions(-)

This patch fails to compile because there is a call to
ixgbevf_write_tail() which you missed cleaning up.
--=-3IEBpCqmepFDyHB6VJLB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlqy0xgACgkQ5W/vlVpL
7c44GQ/+KOddeX1YUHmWUdmqpHpeWETTLjQ/eXJd51wNVcsq4oXusMcQnX77O+Lh
/UYth8+BG/jhG6g9fJ9XyDuqqrlj/42UqpEYbfpISAVO0r6tCmXSrq2immxn80yo
s/MtPta6F5n6oeTM8Qn0DboEah2xj4+fwVxrZT5jkgpymGIqWO3vcrJArZ7WvNo8
EZfNP5fGiTQeSHCobkZSgJhmf+3/onLx+p0L0UnAas7sFgZCgXq3hipMtQ3fADPE
pe0EPlSqb2pA21uCP7Fe/ZE7Vi9PexgDsLJNlVzcDvkSSAN7pn7cS6uwghIW/gf2
mcOtkLCwL2h7fPD56YkLAj6q3iY0pqAofrv4uBsnrUf8B8uRPgq5uyrWp0kcOXV1
FEn2mpJU31wm3xwkf5lTcPkreYaR+H/f+UndNuqvdi+cHyMpUMxNs3QXagRLbcuP
oBdrTHti/vyB/aQ5XkVFPBv3PcDh7/o0YZ8nOl/S2NJbyZ9nlK9Tv7T4kP4syFjZ
8k8OEpjws6+DQpVuXSjR7V0LZhLpD012Xgp5QjdWAVo54T4+JeVkseL4LMDF2QHU
kHurW13e5sfjxi9tOlwb/PTWSHS3DAgSr9RfvCnVFGXvICdh50gwnc6c5W9+WQnk
m9jtLSBVTIZNZfjhVWxtlTqbM4JnaLSF5iSFjE5Txnt0ygvvZ6Y=
=+wNq
-----END PGP SIGNATURE-----

--=-3IEBpCqmepFDyHB6VJLB--
