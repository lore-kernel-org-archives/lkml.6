Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753439AbeCPJkS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:40:18 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43719 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPJkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:40:02 -0400
X-Originating-IP: 2.224.242.101
Date: Fri, 16 Mar 2018 10:39:53 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, horms@verge.net.au, magnus.damm@gmail.com,
        geert@linux-m68k.org, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: renesas: Add LVDS decoder to R-Car
 V3M Eagle
Message-ID: <20180316093953.GC31710@w540>
References: <1521130316-1221-1-git-send-email-jacopo+renesas@jmondi.org>
 <1521130316-1221-4-git-send-email-jacopo+renesas@jmondi.org>
 <20180316000004.GC3432@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
In-Reply-To: <20180316000004.GC3432@bigcity.dyn.berto.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Niklas,
   thanks for review,

On Fri, Mar 16, 2018 at 01:00:04AM +0100, Niklas S=C3=B6derlund wrote:
> Hi Jacopo,
>
> Thanks for your patch.
>
> This one must depend on '[PATCH v2 0/5] arm64: dts: renesas: r8a77970:
> enable HDMI output' or something similar not yet in renesas-drivers
> repository correct?

Yes, I have listed dependencies of this series in my v1 cover letter:

---------------------------------------------------------------------------
The series is based on Laurent's drm/next/du branch with patches on top for:
- Sergei: Enable PFC, I2c, GPIOs for r8a77970
- Sergei: Add support for r8a77970 in DU and add display device nodes in
  r8a77970 DTSI
- Niklas: Connect DU LVDS output to HDMI bridge adv7511w in Eagle DTS
- Sergei: fix video output on R8A77970

A base branch with these patches applied is available at
git://jmondi.org/linux v3m/v4.16-rc3/base
---------------------------------------------------------------------------

My bad I have not reported this in all cover letters (and I have not
reported the full name of the series)

PFC, GPIO and I2c support I have listed as dependencies seems to have
landed in renesas-drivers, while I don't see yet:

Sergei:
[PATCH v2 0/5] Add R8A77970/V3MSK LVDS/HDMI support

whose patches for r8a77970 dtsi are included in yours:
[PATCH v2 0/5] arm64: dts: renesas: r8a77970: enable HDMI output

On top I also have Sergei's/Laurent's:
[PATCH v4] v4l: vsp1: Fix video output on R8A77970

>
> In the next version would you care to include the LVDS commit from the
> dependency  series and squash this change into that one or in some other
> good manger stack to two? Laurent told me he did not like 5/5 in that
> patch-set as it did not yet have the LVDS decoder node due to no driver
> existed at that time when I posted that even if it's not strictly needed
> to get the display working :-)


I'll let Simon suggest how he preferes to handle this, if he wants me
to re-submit your series with this patch squashed on top or he prefers
to deal with this himself.
>
> I also think you should split this last patch out to a separate series
> as it should go in Simon's tree while the driver and documentation is
> going in earlier in a different tree right?

I assume bindings and driver go through DRM and Simon is to pick up
the Eagle changes.

>
> On a side note, do you plan to update the Gen2 boards DTS files which
> also have a decoder which are not yet described in DT?

Actually I'm not aware of Gen2 boards with this chip and similar
display pipelines. Can you point me to which one needs to have its
DTS brushed?

Thanks
   j

>
> On 2018-03-15 17:11:56 +0100, Jacopo Mondi wrote:
> > The R-Car V3M Eagle board includes a transparent THC63LVD1024 LVDS
> > decoder, connected to the on-chip LVDS encoder output on one side
> > and to HDMI encoder ADV7511w on the other one.
> >
> > As the decoder does not need any configuration it has been so-far
> > omitted from DTS. Now that a driver is available, describe it in DT
> > as well.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> > ---
> >  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 33 ++++++++++++++++++=
+++++---
> >  1 file changed, 30 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts b/arch/arm6=
4/boot/dts/renesas/r8a77970-eagle.dts
> > index c0fd144..69f43b8 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> > @@ -42,6 +42,33 @@
> >  			};
> >  		};
> >  	};
> > +
> > +	thc63lvd1024: lvds-decoder {
> > +		compatible =3D "thine,thc63lvd1024";
> > +
> > +		ports {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			port@0 {
> > +				reg =3D <0>;
> > +
> > +				thc63lvd1024_in_0: endpoint {
> > +					remote-endpoint =3D <&lvds0_out>;
> > +				};
> > +			};
> > +
> > +			port@2{
> > +				reg =3D <2>;
> > +
> > +				thc63lvd1024_out_2: endpoint {
> > +					remote-endpoint =3D <&adv7511_in>;
> > +				};
> > +
> > +			};
> > +
> > +		};
> > +	};
> >  };
> >
> >  &avb {
> > @@ -98,7 +125,7 @@
> >  			port@0 {
> >  				reg =3D <0>;
> >  				adv7511_in: endpoint {
> > -					remote-endpoint =3D <&lvds0_out>;
> > +					remote-endpoint =3D <&thc63lvd1024_out_2>;
> >  				};
> >  			};
> >
> > @@ -152,8 +179,8 @@
> >
> >  	ports {
> >  		port@1 {
> > -			endpoint {
> > -				remote-endpoint =3D <&adv7511_in>;
> > +			lvds0_out: endpoint {
> > +				remote-endpoint =3D <&thc63lvd1024_in_0>;
> >  			};
> >  		};
> >  	};
> > --
> > 2.7.4
> >
>
> --
> Regards,
> Niklas S=C3=B6derlund

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaq5DpAAoJEHI0Bo8WoVY8jXIQAI/LCqBAyacbszZzrLPD/oZm
4lGPffK6PfzPyx0QFwQ1xFprF5RfPdkSW/hCfn2gc8RHWuJIE3k8KQQYFXIyyNO4
zXS3zQ+d24Bg6p3qI8aeMklqmxxL1KEyHSQBSRkuK8q5gSrUuo2n3Mny3CFURGOE
XyQC8zGkz4NTy2tso5bfg9PXmSZWoFW572zkJ2G8uWkeFJ5qeasJiFql/wc7RtuE
+V6rMvMuMhfVnhKXBPXFE2xhkwU8BcZF5imyldGD8x6jWe1/r9IOPqrGX5Ca0iQp
e+XlKABiHnk48uirTNK7JLfsXBtJhBcDvDt6N12rL1Xf/COg2dLRuaMKCgO/Bv4Z
pVuEs5wCs411kF2GC2Nn0OXQay/Y01F5FrJfLOmDikuea2/llU3p6MBPQyM6PvWh
wWd7kvqZsf5La4mTD5j32dHKtdlQ0rPf9REG8dUnlg0IGlK5R7B0K0sRfAorz/qW
GziH4X54DpVdxP1R/fcRaVgrx9mmlaROjynNUguFgn+J2xcHtkWsDQfmZHMb/Xnn
067Rq4R2iK64O1SGZetOK3i7tNFeudHBQPlCU4fqqcAJAcBTK2MBNW1Vmlu/pmvw
TSQeWg6qORgHNDTrUuqr0Z+rxxMq+GgguCTYlV7shWoY8ixZR+BXj1S6Ik7WPCyC
ql6WM9NSeEwyOFv1RqpJ
=JQpo
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
