Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeEDKk5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:40:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40174 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEDKkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:40:55 -0400
X-Google-Smtp-Source: AB8JxZrJ6uvjmpUJ7TehVr0dgyY8QuzlGWV1GGEUCN0edgdeUuR8nISTEHbWnQ/ZrTLvkkM4HCENaA==
Date: Fri, 4 May 2018 12:40:51 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcel Ziswiler <marcel@ziswiler.com>, Marc Dietrich <marvin24@gmx.de>,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ARM: dts: tegra20: Revert "Fix ULPI regression on
 Tegra20"
Message-ID: <20180504104051.GL13459@ulmo>
References: <20180503225537.20748-1-digetx@gmail.com>
 <20180503225537.20748-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7l042bGvurpep9Wg"
Content-Disposition: inline
In-Reply-To: <20180503225537.20748-6-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7l042bGvurpep9Wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 01:55:37AM +0300, Dmitry Osipenko wrote:
> Commit 4c9a27a6c66d ("ARM: tegra: Fix ULPI regression on Tegra20") changed
> "ulpi-link" clock from CDEV2 to PLL_P_OUT4. Turned out that PLL_P_OUT4 is
> the parent of CDEV2 clock and original clock setup of "ulpi-link" was
> correct. The reverted patch was fixing USB for one board and broke the
> other, now Tegra's clk driver correctly sets parent for the CDEV2 clock
> and hence patch could be reverted safely, restoring USB for all of the
> boards.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Marcel Ziswiler <marcel@ziswiler.com>
> Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
> Tested-by: Marc Dietrich <marvin24@gmx.de>
> ---
>  arch/arm/boot/dts/tegra20.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Is it still true that this patch alone fixes the known regression? I'm
just asking because the remainder of the series, even though it sounds
to be the right thing to do, is fairly big for a fix against v4.17.

So if this alone fixes the regression I think it'd be best to queue it
up for v4.17 and get the rest of the patches into v4.18.

Thierry

--7l042bGvurpep9Wg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrsOLEACgkQ3SOs138+
s6EGSA//eqg+XTznoksvEILxLT2d1DeiOijjzlYVUPKMTriI8Ss7hdg4Sc1HHjVW
uCBgY+csl//d1RQ2kB+HgrCb8iJ2t/j7KdgLCScI9tlZQZrlciP/SIpxGoSeGa7u
Xd46KKucNtuE5MEZLWHA6NpVx+b5EBIRCudTWCy5y31oGMGqqAMnQp9NHGL6/p8N
5C3bRUPZA5w385aPjngGUoZrvKV8GPuLEPi1OHh5wp7rNax8aC75boNK8U3b1I0S
LIgxJATJdEvSOvBOETfzQz/jXFHH2Q6rJuteu9TF1vzcnaBqRFKv1YTwcmxQM8Lk
2Ie4rPwvFfd6yY9a7LVvBf/4TGJ01cqhsgFysnKW+4mKWlCKT2VACFFwYaTlYhDb
M+9guQA6BsocY1ID1MaEiP5+0hCma/qA0n4vlKJwslFAKTUOlTJ4iwlwP/xilCsc
hIcA671e0N2YYFGRSKFISOWTzEbGB2BD1uGRghwxXRN116+6skwqF9ES44OuoyYD
s9/8byqPo2m0umKYtGz/KkVM1AvAAWyrmBdpAqtCHLQjk+zJDNloJ3eF1iWikBfm
9GIDxf2ojxEp6rtA5x3JN+JXBNJQwiZuwB25HBBI8u5/afuFkM/fP59jrtJOQLI8
3nqNWlQqxgKiP1PPCu2zg34DJwd+R/+7ginkV08T7xyvDrJNRuM=
=KvsY
-----END PGP SIGNATURE-----

--7l042bGvurpep9Wg--
