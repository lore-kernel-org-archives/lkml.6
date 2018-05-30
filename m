Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753734AbeE3Psz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:48:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56206 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753180AbeE3Psx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:48:53 -0400
Date: Wed, 30 May 2018 16:48:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
Message-ID: <20180530154849.GQ6920@sirena.org.uk>
References: <20180523082908.GB4828@sirena.org.uk>
 <CAD=FV=XfPkpGD32MfTfcw02wQ+QetpUhY=P299uhpX6pY_iEvg@mail.gmail.com>
 <20180523154057.GL4828@sirena.org.uk>
 <CAD=FV=XWVOdJ8rWJnBTwoNqnYqYRYjknkZtUvT86+skbrTdwig@mail.gmail.com>
 <20180523155617.GN4828@sirena.org.uk>
 <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
 <20180530093701.GD6920@sirena.org.uk>
 <CAD=FV=W-MLU9c-SvfLgKAKGP1eHN5xO-013f2M09XUa+QeHzrA@mail.gmail.com>
 <20180530150241.GO6920@sirena.org.uk>
 <CAD=FV=XJd-udEE6az0xP7i6x0oGsnd=BSCyZ0Og_+RjNCMXnCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vIXBmblrD40XNCy4"
Content-Disposition: inline
In-Reply-To: <CAD=FV=XJd-udEE6az0xP7i6x0oGsnd=BSCyZ0Og_+RjNCMXnCQ@mail.gmail.com>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vIXBmblrD40XNCy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 08:34:50AM -0700, Doug Anderson wrote:
> On Wed, May 30, 2018 at 8:02 AM, Mark Brown <broonie@kernel.org> wrote:

> > What you're describing sounds like what we should be doing normally, if
> > we're not doing that we should probably be fixing the core.

> I'm not convinced that this behavior makes sense to move to the core.
> On most regulators I'd expect that when the regulator driver says to
> turn them off that they will output no voltage.  The reason RPMh is

Oh, you mean while the regulator is off...  TBH I don't see a huge
problem doing that anyway and just reverting to the bottom of the
constraints when everything gets turned off since we have to see if we
need to adjust the voltage every time we enabled anyway.

> In any other system when Linux disabled the regulator it wouldn't
> matter that you left it set at 1.4V.  Thus RPMh is special and IMO the
> workaround belongs there.

Without the core doing something the regulator isn't going to get told
that anything updated voltages anyway...

--vIXBmblrD40XNCy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOx+AACgkQJNaLcl1U
h9DtYAf/d42wzL/BwC0ZoU87rcBj1tg5JnI3JXmEjk0TAEr8Mr9X26kTgvNDN4he
sfj0TCQnt106iCytS9vuq13r0vc0N8a73zACI9rBL4AFN2r8/KqyjfG5iuD1IYUf
eEAlJeBHT5jL8EJOiBgq2z+8n4jIPNnZdK/A8kanILTb2D0yU9LmqXJaLCquSBef
d3otBG5MHDZNmBvemCG07/dvdvwHHmOZu/QAEsxkqP6cuqw+phTpVrIc2+40lHJk
QfVj28IYFDxNf3viq4W606P0LE0BtP3pwjhFyKUj6CdLFzFli+EI7lXBuvp1q3UB
eEWC9xQb5Fw2b4Hj5h+RS6hFhej0mw==
=hSKi
-----END PGP SIGNATURE-----

--vIXBmblrD40XNCy4--
