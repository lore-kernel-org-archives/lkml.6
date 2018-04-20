Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbeDTQ70 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:59:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39378 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753284AbeDTQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:59:24 -0400
Date: Fri, 20 Apr 2018 17:59:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        linux-kernel@vger.kernel.org, grant.likely@arm.com,
        frowand.list@gmail.com, mark.rutland@arm.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>, shawnguo@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
Message-ID: <20180420165921.GD22369@sirena.org.uk>
References: <20180418222905.10414-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <20180418222905.10414-1-robh@kernel.org>
X-Cookie: Smear the road with a runner!!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2018 at 05:29:05PM -0500, Rob Herring wrote:
> The current DT binding documentation format of freeform text is painful
> to write, review, validate and maintain.
>=20
> This is just an example of what a binding in the schema format looks
> like. It's using jsonschema vocabulary in a YAML encoded document. Using
> jsonschema gives us access to existing tooling. A YAML encoding gives us
> something easy to edit.

It'd be useful to see some examples of how things like including by
reference other schema work.  It feels like something we should be able
to use more in a schema based thing but perhaps that's not viable with
realistic tooling.  In general this looks OK, especially with all the
meta comments about the language stripped out.

> +    description: |
> +      A variable number of interrupts warrants a description of what con=
ditions

Like Stephen said the | looks odd.

> +  interrupt-names:
> +    # minItems must be specified here because the default would be 2
> +    minItems: 1
> +    items:
> +      - const: "tx irq"
> +      - const: "rx irq"

Any way to relate this to the interrupts property in the schema
language (eg, must have the less or equal number of elements)?

> +  # Property names starting with '#' must be quoted

That's awkward :/  Perhaps just by convention quote all property names
for simplicity?

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlraHGgACgkQJNaLcl1U
h9Cwcwf+OPT6H3e4dIpc3TXlGFnRUlq6lOCoKrFgghQKJGb++VRCZ5En6R3KgC9/
GwuGMxXL8DofYs6bmSlsfHBXFfIgixvNcWeoVMtXxZI2YiXZ2560F0i4ccL0pZgc
WkZsv2QDD+6k9to98mrX7pJG95+5mziDnbSmSFaemLSYGnPCM2JH+VsxuX1sblg+
BFu0PbSjuht7QVqiI6BraLT/YuoSkX35Il/oL8GVkpMn0mtLXoPhd6zzhSt+qNZV
BHc7CIacO/FejCygpY+4TlBqk7S53grNwvcxEQNeTGLT2QJZdJZOOHmzeaPqD2Ee
V/oXJpbYRoeXiBwC3F4PfMJO7j2K7g==
=Dqz+
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
