Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeEQHPI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:15:08 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:54481 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeEQHPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:15:06 -0400
Date: Thu, 17 May 2018 09:14:56 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com, horms@verge.net.au, geert@glider.be,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: renesas: draak: Describe HDMI input
Message-ID: <20180517071456.GT5956@w540>
References: <1526478129-16465-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526478129-16465-4-git-send-email-jacopo+renesas@jmondi.org>
 <20180516222318.GI17948@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XDqeUMnLaDfDQgU1"
Content-Disposition: inline
In-Reply-To: <20180516222318.GI17948@bigcity.dyn.berto.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XDqeUMnLaDfDQgU1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

On Thu, May 17, 2018 at 12:23:18AM +0200, Niklas S=C3=B6derlund wrote:
> Hi Jacopo,
>
> Thanks for your patch.
>
> On 2018-05-16 15:42:09 +0200, Jacopo Mondi wrote:
> > Describe HDMI input connector and ADV7612 HDMI decoder installed on
> > R-Car Gen3 Draak board.
> >
> > The video signal routing to the HDMI decoder to the video input interfa=
ce
> > VIN4 is multiplexed with CVBS input path, and enabled/disabled through
> > on-board switches SW-49, SW-50, SW-51 and SW-52.
> >
> > As the default board switches configuration connects CVBS input to VIN4,
> > leave the HDMI decoder unconnected in DTS.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>
> I'm not sure we have a policy about describing hardware which can't be
> used without flipping switches. I have no opinion on if we should do
> that or not I leave that to others, but for the change itself.
>
> Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
>

Thanks

> I think it's good we describe it as it's part of the Draak board itself
> and not an expansion board which we have seen a lot of :-) Maybe even
> add a commented out line in the adv7612 port@2 which hints which VIN
> this is connected to if the switches are flipped?

The only VIN instance that's on Draak, VIN4.

I can add a comment that describes the switch settings that enables
the HDMI video capture path.

Thanks
   j


>
> > ---
> >  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 38 ++++++++++++++++++=
++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm6=
4/boot/dts/renesas/r8a77995-draak.dts
> > index 9aba28f..ea99dc9 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > @@ -59,6 +59,17 @@
> >  		};
> >  	};
> >
> > +	hdmi-in {
> > +		compatible =3D "hdmi-connector";
> > +		type =3D "a";
> > +
> > +		port {
> > +			hdmi_con_in: endpoint {
> > +				remote-endpoint =3D <&adv7612_in>;
> > +			};
> > +		};
> > +	};
> > +
> >  	memory@48000000 {
> >  		device_type =3D "memory";
> >  		/* first 128MB is reserved for secure area. */
> > @@ -170,6 +181,33 @@
> >  			};
> >  		};
> >  	};
> > +
> > +	hdmi-decoder@4c {
> > +		compatible =3D "adi,adv7612";
> > +		reg =3D <0x4c>;
> > +		default-input =3D <0>;
> > +
> > +		ports {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			port@0 {
> > +				reg =3D <0>;
> > +				adv7612_in: endpoint {
> > +					remote-endpoint =3D <&hdmi_con_in>;
> > +				};
> > +			};
> > +
> > +			port@2 {
> > +				reg =3D <2>;
> > +				adv7612_out: endpoint {
> > +					pclk-sample =3D <0>;
> > +					hsync-active =3D <0>;
> > +					vsync-active =3D <0>;
> > +				};
> > +			};
> > +		};
> > +	};
> >  };
> >
> >  &i2c1 {
> > --
> > 2.7.4
> >
>
> --
> Regards,
> Niklas S=C3=B6derlund

--XDqeUMnLaDfDQgU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa/SvvAAoJEHI0Bo8WoVY85gMQALtxzdM7R7Pdz9zNE52kDjDX
ANTFqlqU2MQZdW+tUpO4B7vu/V2QN3V0c1JzAZr7Y9rxd+6XdfsU30mCwadSiDah
gwvV6pWqmgZ4qODTD8Zdj5pkFmGj/8FOc1XMcHTI1jGD7eZDKQCweN/ofHTVMwTU
ulRk7xvIkcUpNy1wzzhGm+uZC0YtJlXy0yR4O02jNjS4JuE+GQBOBkvgfv5GdWi2
bKDtiQ1I4LfIgUDbY2MPojPPIs0BFebC+thqoXeGZtowYiI9SOAIWozYOITeOYV8
b4WqN/ucwS1pHaUoeprKDGBgoun1FsVxD9gdvYKfGYt2R/C+n7l+Sq6dUhRIiYt9
EHpNfZEBLm19bZP9payOCWkXRV4egJINsmPwz0l11lU/BsapxgpAZTY58SgMfQgk
ldlGU3aMD+diH4FWXkmItzDohIHRsUThJsyoI2qC97x3Q1d8DBYO3xMTNiMmBEfc
SM0k3KKKuHCSjgSjYcMvZlj9kaxOE/MUpw4B2lCfKnB9V7g9TuG6r2lArr8rfgek
SUWyREOAdiJmHUyMPlS/DrFW+uJVCMr/RPvbvp+++RcQWdR5Mcr63TBLPvD5Px9v
Rl09bS6JMZjnLLJLYw+pvIXJMaAjvyHjI0RXJny/h6ofyNgpCcRxRp/biT8fDWov
cngYJfC+yzTfGOmla1Aw
=NMVH
-----END PGP SIGNATURE-----

--XDqeUMnLaDfDQgU1--
