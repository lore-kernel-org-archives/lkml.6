Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeD3JmL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:42:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36232 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeD3JmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:42:08 -0400
X-Google-Smtp-Source: AB8JxZpggUiHvwF14AScoTjySnIUsGi9J4J8qidLTgm9Fo9/50oL0J0U3fjq/cmSqPuGpOaajWZdSA==
Date: Mon, 30 Apr 2018 11:42:05 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Wesley W. Terpstra" <wesley@sifive.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: added new pwm-sifive driver
 documentation
Message-ID: <20180430094205.GB2476@ulmo>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-2-git-send-email-wesley@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <1524869998-2805-2-git-send-email-wesley@sifive.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2018 at 03:59:56PM -0700, Wesley W. Terpstra wrote:
> Document new PWM device tree bindings for SiFive SoCs.
>=20
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sifive.txt         | 28 ++++++++++++++++=
++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Docum=
entation/devicetree/bindings/pwm/pwm-sifive.txt
> new file mode 100644
> index 0000000..7cea20d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> @@ -0,0 +1,28 @@
> +SiFive PWM controller
> +
> +Unlike most other PWM controllers, the SiFive PWM controller currently o=
nly
> +supports one period for all channels in the PWM. This is set globally in=
 DTS.
> +The period also has significant restrictions on the values it can achiev=
e,
> +which the driver rounds to the nearest achievable frequency.
> +
> +Required properties:
> +- compatible: should be "sifive,pwm0"
> +- reg: physical base address and length of the controller's registers
> +- clocks: The frequency the controller runs at

That's not quite correct. According to the example below, this is a
phandle to the clock that drives the PWM at a given frequency.

> +- #pwm-cells: Should be 2.
> +  The first cell is the PWM channel number
> +  The second cell is the PWM polarity
> +- sifive,approx-period: the driver will get as close to this period as i=
t can
> +- interrupts: one interrupt per PWM channel (currently unused in the dri=
ver)

Those parentheses provide information that doesn't belong in tha DT
bindings. What you this binding is used in a different operating system
that does use the interrupts?

Thierry

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm5O0ACgkQ3SOs138+
s6FyGg//SX9MDuJif7abi9OkZBNe2kKW0wG9ntRgxAIKzfedO89Gn6gpFD1QnaA/
xaFKn0WecfU2D6xqMk4Np91woUEjgdYmlkPwE43+owy+cA6wbkhhfoWMJYKF/1/a
50j1aCgesMlCah6r44ByAee/eFW7D6oldmIgrXq3RDG76eCU4/xpaXsC3bn1aE0x
cmCD20+DSAGsvAuJVTa+ZGK4kGjQdMBcuyyYjoygW3zR9s+foJmX+ppcug/AgBhz
gaYRypGynVgn4kxqCZsgN+tiYSTziRAEdbxsRJgGiHpA4IoAM0VoaBRqnt7xM/Dj
G7DaBi6Y19UVlorahX5rHCo4V7G1CurPATaFxybIECeiDTM1sDGCV8sc1nnvvJLS
RPPzsayWHm5ldYTvk7BK7cH2jJU/T3wnmUvqXrGWfndX6RvkQ6sghcqpAc04iVYQ
xTdbXbdiEfs8CIg4M+KJ2hvWQHCBGbZ8OOX+1mbynm/X+X8Y3zZeQDP9fnbjnB4Q
Uw/TLXN5ifGD180UjyZZlaSfww9UQ9VbSSiRe1BlaqW2//TW2Cr/p99JerrYp3W6
DMGo9eSBQtXnZ9bWFDz8o/Pc16UjV7vUvq02y6VgNzBckeXdH+CUHMu1j4Oj83Mr
yyxEQMIsoafArrlvF4ZzG5z0zj8IFGtvmYJtpoInBawzLN5lEjc=
=F978
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
