Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932347AbeDWSy4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:54:56 -0400
Received: from anholt.net ([50.246.234.109]:60472 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932172AbeDWSyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:54:53 -0400
From: Eric Anholt <eric@anholt.net>
To: Stefan Schake <stschake@gmail.com>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Stefan Schake <stschake@gmail.com>
Subject: Re: [PATCH v4 1/2] drm/vc4: Add CTM support
In-Reply-To: <20180420122545.40014-1-stschake@gmail.com>
References: <20180420122545.40014-1-stschake@gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Mon, 23 Apr 2018 11:54:49 -0700
Message-ID: <87fu3l4uti.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Stefan Schake <stschake@gmail.com> writes:

> The hardware has a single block for applying a CTM prior to gamma lut.
> It can be fed with pixels from one of our CRTC at a time and uses a
> matrix with S0.9 scalars. Use private atomic state to reject attempts
> from userland to apply CTM for more than one CRTC at a time and reject
> matrices with scalars that we can't approximate without integer bits.

Looks good!  I think you got all the transition cases we were concerned
about before.

Reviewed and applied these two to drm-misc-next.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlreK/kACgkQtdYpNtH8
nuivrg/3QWOHIW2f3/aubiNWNFtlU7tMi41uWUWsnTpgYPd/zuiW3Waf+atMl9XX
/VsiQqmJrUQAFtb2O1KAQ+CTPvi/Up9zuPDOfRc9eX1ORD/XIXoD7DfcoesfysV4
U4Oad6BjSIrxWAfkSz9h5bSo9aGktxbiQr4t2n8j349xmfrfpxLH5JtgDyuaQkZ3
KEwzjHthpnVlKrppFoLVfZtdvtX33WLj2GqAzQ21P2BewLBMWhElcqvbmZ4CW532
aGeQ/zIPzfxwl5udRJbp4yiIQ8xSv5V2kHqfZbTJUmG132Z3abPlbAGJxmF6XXOx
nemnYmGP967c1yw7BUcTTUoWlWOvpdj38ZBxMAnuK5J0rtKwy0K+wTh+3dOexsGG
g/HTZWEVY8Bl/AW53ZyY2Pylls7q+HCM7cP9aBJq9uqJMUU9GsQF6PryimsAVIgt
dB/2lXKSL0QE4wVzTpR8L1359933ZgC1lCaLXKTmcFkevwmMzWf3pkaxeG+GPvEv
imC2IUz1ayczTZm6pogr/ER/wKxqZm96JSGcKw7rnCIBTBU/7ijTUkTE4mke3Gqw
HwPaculiksZLBMtQUxgDaMy7UcOQXvicw+THUpM5XaQwNbfGFYlBpDFdc1fBIpI9
0bctdpejB68pV2v8mKEDSGTrG7xPNqXbTeNAP5t0CrRGuQ6+pA==
=4WJI
-----END PGP SIGNATURE-----
--=-=-=--
