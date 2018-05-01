Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeEAVDK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 17:03:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40242 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeEAVDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 17:03:08 -0400
Date: Wed, 2 May 2018 06:02:58 +0900
From: Mark Brown <broonie@kernel.org>
To: David Collins <collinsd@codeaurora.org>
Cc: Doug Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2 2/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180501210258.GG2714@sirena.org.uk>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com>
 <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
 <CAD=FV=W28_exRv+H0MJvPnHWGEeUG=SMKr=UqEKpBzkH44Fzmg@mail.gmail.com>
 <132ab845-52d6-6192-4d8c-5a9c95410688@codeaurora.org>
 <20180424174507.GI22073@sirena.org.uk>
 <20a8f736-2687-f14f-eaa1-2b2c06eed629@codeaurora.org>
 <20180425103136.GB24769@sirena.org.uk>
 <f98416ac-230c-0362-ed50-a7f92ff283d7@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iAL9S67WQOXgEPD9"
Content-Disposition: inline
In-Reply-To: <f98416ac-230c-0362-ed50-a7f92ff283d7@codeaurora.org>
X-Cookie: Rubber bands have snappy endings!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iAL9S67WQOXgEPD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2018 at 02:04:56PM -0700, David Collins wrote:

> > Using -EAGAIN for "I can't ever read the configuration from this
> > regulator" doesn't seem right - it's not like any number of retries
> > will ever manage to read the value back.

> In this case, the _regulator_get_voltage() call can succeed, but only
> after a voltage is explicitly requested from the framework side.  The

...

> Do you still have reservations about using -EAGAIN for this purpose?  If
> so, which error code would you suggest using?

Yes, that's clearly a problem - -EAGAIN is more for situations where you
can just immediately retry like signal interruptions.  If the caller
repetedly sits and tries to read the voltage it'll never succeed unless
something else comes along and sets something.

--iAL9S67WQOXgEPD9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlro1gEACgkQJNaLcl1U
h9BGTQf8D2BYeALtbrEIcuMc/85tjolOzrgVsLBNiv0aNRFbRasEaxXKT8H/rLrs
s4tWN/IWo6XGvvyuOum/AdBrQZQj8ds+bIjY/RqSwnrZo2ao/zB4aOmpcJUeNl5I
mivV6GJCDiAVmyCnmadAs4Rw2pCtPwIx00lYwxE/Gs34OT6gMBo+PZsMIO3aiUwi
QyH7vAgdAL9rphGa7QL6AYI01/SKZDzE6UvVYJYtX/6vrtPZG315N4PiMT+/wcqs
XrQ1Yka8uyErp/wPOW30zlJc1O4rPw1CiktxDqnNlI2BLdpsdoLDNDfim31lNw7i
PyAoFSHGC/7OAJ8sSl8TwFAAhYg47g==
=KPy2
-----END PGP SIGNATURE-----

--iAL9S67WQOXgEPD9--
