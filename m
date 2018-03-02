Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425576AbeCBJNI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:13:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59260 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425259AbeCBJMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:12:55 -0500
Date: Fri, 2 Mar 2018 10:12:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        arvind.yadav.cs@gmail.com, b.zolnierkie@samsung.com
Subject: Re: v4.16-rc0: missing includes in framebuffers break N900
 compilation
Message-ID: <20180302091253.GB15948@amd>
References: <20180226130007.GA5634@amd>
 <46d9fddf-7e6d-b157-0745-6366ccd57a41@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <46d9fddf-7e6d-b157-0745-6366ccd57a41@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-02-26 16:05:53, Tomi Valkeinen wrote:
> v4.16-rc1 has a fix (b9058afcd6c7).

Yep, thanks. I was bisecting sound problem on N900, so this hit me...

     	       	   	     	   	      	       	    Pavel

> On 26/02/18 15:00, Pavel Machek wrote:
> > I needed this to get -rc0 to compile.
> >=20
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >=20
> >=20
> > diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video=
/fbdev/omap2/omapfb/dss/dss.c
> > index 48c6500..990f1c9 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/regmap.h>
> >  #include <linux/of.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/pinctrl/consumer.h>
> >  #include <linux/suspend.h>
> >  #include <linux/component.h>
> > =20
> > diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/=
video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> > index 9a13c35..4862b12 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/seq_file.h>
> >  #include <linux/slab.h>
> >  #include <video/omapfb_dss.h>
> > =20
> > diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c b/drivers/=
video/fbdev/omap2/omapfb/dss/hdmi_pll.c
> > index eac3665..39014e2 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/seq_file.h>
> >  #include <linux/clk.h>
> > =20
> >  #include <video/omapfb_dss.h>
> > diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c b/drivers/v=
ideo/fbdev/omap2/omapfb/dss/hdmi_wp.c
> > index 705373e..e93e7a7 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/io.h>
> >  #include <linux/platform_device.h>
> >  #include <video/omapfb_dss.h>
> > +#include <linux/seq_file.h>
> > =20
> >  #include "dss.h"
> >  #include "hdmi.h"
> >=20
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqZFZUACgkQMOfwapXb+vIl3QCgjv4HqbyIYsPPmA4EmFd3V7uu
rgQAniOOVBBExlQO/oerf0yTkr14DbeV
=yUiQ
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
