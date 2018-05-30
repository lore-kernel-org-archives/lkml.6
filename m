Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbeE3Q7u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:59:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33920 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753553AbeE3Q7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:59:43 -0400
Date: Wed, 30 May 2018 17:59:37 +0100
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
Message-ID: <20180530165937.GX6920@sirena.org.uk>
References: <20180530150241.GO6920@sirena.org.uk>
 <CAD=FV=XJd-udEE6az0xP7i6x0oGsnd=BSCyZ0Og_+RjNCMXnCQ@mail.gmail.com>
 <20180530154849.GQ6920@sirena.org.uk>
 <CAD=FV=X2u=hMyWinSDtim-PmFwAy5mXcwg3HeYojAHcsUFhV3g@mail.gmail.com>
 <20180530160744.GS6920@sirena.org.uk>
 <CAD=FV=WVGu0f+=q-C9kiEmaLEUJqGY+Jbns83h72uF-9iasrUw@mail.gmail.com>
 <20180530161311.GT6920@sirena.org.uk>
 <CAD=FV=UpWEMSPUYOHmLQ0g_mF990kwn4_zm=ZCNttLKZiz7i=Q@mail.gmail.com>
 <20180530163644.GW6920@sirena.org.uk>
 <CAD=FV=V1gGccKr1mHM0zx_-FFdLU1vrzUChwx6KTUyTGzj39Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1RhGCd1AsoFHGRHc"
Content-Disposition: inline
In-Reply-To: <CAD=FV=V1gGccKr1mHM0zx_-FFdLU1vrzUChwx6KTUyTGzj39Tw@mail.gmail.com>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1RhGCd1AsoFHGRHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 09:41:55AM -0700, Doug Anderson wrote:
> On Wed, May 30, 2018 at 9:36 AM, Mark Brown <broonie@kernel.org> wrote:

> > Yeah, and I don't think that's unreasonable for the core to do - just
> > drop the voltage to the constraint minimum after it has turned off the
> > regulator, then recheck and raise if needed before it enables again.

> Would it do this for all regulators, though?  Most regulators are
> hooked up over a slow i2c bus, so that means that every regulator
> disable would now do an extra i2c transfer even though for all
> regulators (other than RPMh) the voltage of a regulator doesn't matter
> when it's been "disabled' (from Linux's point of view).

It'd only affect regulators that can vary in voltage and actually get
disabled which is a pretty small subset.  Most regulators are either
fixed voltage or always on.

> Hrmmm, I suppose maybe it'd be OK though because for most regulators
> we'd use "regcache" and most regulators that we enabled/disable a lot
> are not expected to change voltage in Linux (so the regcache write
> would hopefully be a noop), so maybe it wouldn't be _that_
> inefficient...

Even if the regulator lacks a cache we'd at least skip out on the write
when we're not changing voltage as we'd do a read/modify/update cycle
and stop at the modify.

--1RhGCd1AsoFHGRHc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsO2HkACgkQJNaLcl1U
h9DTXQf/VgwB1seFzCThTskB5IXfv81dOdpaoeVGDg7V4Y/r6nAbB5uNeRkQojgl
aMDgpQFnVqVBsZXktBllwQ7foPOGg8WSd0Q4IlVuQwNNf5nAFqSFy+huw0o47LJ8
x7aWjVFpLTA4XuNezN6XXwNcP2QO6ZY7lKQmXko66py8oQ7KKrktaTaG6mRXAkwf
Jb/i+lr13F6TFcb71Ky4gMEx6rClG12dMIs8a7Ud/USTmibRTQZ7uEX+mG1hRfHC
nsiHZ9YV+OCpIuSePcDwSzRL2CxU//EK4CLx3+Ztp2BCd7XQLk3hsO+arIuOHthH
A/Zc69LtGG1ZIhBnZtGW4XjsKCOr2g==
=ZaJS
-----END PGP SIGNATURE-----

--1RhGCd1AsoFHGRHc--
