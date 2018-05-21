Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeEUJ5O (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:57:14 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:51369 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbeEUJ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:57:11 -0400
X-Originating-IP: 2.224.242.101
Date: Mon, 21 May 2018 11:57:05 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        niklas.soderlund@ragnatech.se, horms@verge.net.au, geert@glider.be,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] arm64: dts: renesas: draak: Describe CVBS input
Message-ID: <20180521095705.GC4432@w540>
References: <1526654878-11143-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526654878-11143-3-git-send-email-jacopo+renesas@jmondi.org>
 <1569661.saMqNra8vc@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <1569661.saMqNra8vc@avalon>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Fri, May 18, 2018 at 06:12:15PM +0300, Laurent Pinchart wrote:
> Hi Jacopo,
>
> Thank you for the patch.
>
> On Friday, 18 May 2018 17:47:57 EEST Jacopo Mondi wrote:
> > Describe CVBS video input through analog video decoder ADV7180
> > connected to video input interface VIN4.
> >
> > The video input signal path is shared with HDMI video input, and
> > selected by on-board switches SW-53 and SW-54 with CVBS input selected
> > by the default switches configuration.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> >
> > ---
> > v2 -> v3:
> > - Add comment to describe the shared input video path
> > - Add my SoB and Niklas' R-b tags
> > ---
> >  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 42 ++++++++++++++++++=
+++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts index 9d73de8..95745fc
> > 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > @@ -142,6 +142,11 @@
> >  		groups =3D "usb0";
> >  		function =3D "usb0";
> >  	};
> > +
> > +	vin4_pins_cvbs: vin4 {
> > +		groups =3D "vin4_data8", "vin4_sync", "vin4_clk";
> > +		function =3D "vin4";
> > +	};
> >  };
> >
> >  &i2c0 {
> > @@ -154,6 +159,23 @@
> >  		reg =3D <0x50>;
> >  		pagesize =3D <8>;
> >  	};
> > +
> > +	analog-video@20 {
> > +		compatible =3D "adi,adv7180";
> > +		reg =3D <0x20>;
> > +
> > +		port {
>
> The adv7180 DT bindings document the output port as 3 or 6 (respectively =
for
> the CP and ST versions of the chip). You should thus number the port. Apa=
rt
> from that the patch looks good.

I admit I have barely copied this from Gen-2 boards DTS, but reading
the driver code and binding description again, I think this is
correct, as the output port numbering and mandatory input port (which
is missing here) only apply to adv7180cp/st chip versions.

Here we describe plain adv7180, no need to number output ports afaict.

Thanks
  j

>
> > +			/*
> > +			 * The VIN4 video input path is shared between
> > +			 * CVBS and HDMI inputs through SW[49-54] switches.
> > +			 *
> > +			 * CVBS is the default selection, link it to VIN4 here.
> > +			 */
> > +			adv7180_out: endpoint {
> > +				remote-endpoint =3D <&vin4_in>;
> > +			};
> > +		};
> > +	};
> >  };
> >
> >  &i2c1 {
> > @@ -246,3 +268,23 @@
> >  	timeout-sec =3D <60>;
> >  	status =3D "okay";
> >  };
> > +
> > +&vin4 {
> > +	pinctrl-0 =3D <&vin4_pins_cvbs>;
> > +	pinctrl-names =3D "default";
> > +
> > +	status =3D "okay";
> > +
> > +	ports {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		port@0 {
> > +			reg =3D <0>;
> > +
> > +			vin4_in: endpoint {
> > +				remote-endpoint =3D <&adv7180_out>;
> > +			};
> > +		};
> > +	};
> > +};
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbApfxAAoJEHI0Bo8WoVY87wkP/1JM+8Y0u/aYqfnTGHn8spY/
T7/DhU1zExN4ha2WCs+mxgSUh1odZ4nqrnsoS5/LXmEDKMB3r3j1D8oAUEDeQp3V
V3Zt59OXFdmbzzflV01U3AgRekwZV4g7bysAhxasTzvh5wuNNVefUEybDZdpmEYg
AtbxbU4FPgqqOrqMuXj1B5DJnDHYeBdh3tzQs1iTvVOHO6l4gH/MsR0tlSXTSM/y
ADRHeG2xwsH42EW8xxcKCHeVMbPMpaRfWUdiL/iL8RWXfs2/c5W4B2NKYglZPfYT
HuH485Ajt5aSoVWEqKCYEahZLQf1hlrGeRGC48jTPxp+GFTIQNgKSlZwE/BIAbfi
vA/PapT2vRLTLEmALi3nzno9xKYXDjk5na4w1vpjqHpB9hT2hWuNm0rtWPhZD8zj
S4Qs2tpUaMhXUeRZvNwOltu+hdTWvyJMuav3MCQSUkBUSAYc2XCi+dUhB6tUyb/d
IQUEdL4rf3d7r+1y1EIa/rbfhILBH92DnBFmMGbg7FtRooMRfXk5Wh4IC9fPzCDc
BZwiNPzMzfwqeuXpnvaQm6vXHrI6xq3f8ObiQYwCFZmqlIQ93pVrh1RwfLcet1hc
cm6sMW06SQo5Ao9/G7lxZQmeipbsOEZ+DCPYwqG16gVfo0nFEb1ebmlxSjrMemJO
4eHRdxnyzzrChJ7GFTv0
=qvzt
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
