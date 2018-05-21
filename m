Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeEUMdz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:33:55 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:41421 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeEUMdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:33:51 -0400
Date: Mon, 21 May 2018 14:33:40 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        niklas.soderlund@ragnatech.se, horms@verge.net.au, geert@glider.be,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] arm64: dts: renesas: draak: Describe CVBS input
Message-ID: <20180521123340.GA15035@w540>
References: <1526654878-11143-1-git-send-email-jacopo+renesas@jmondi.org>
 <1569661.saMqNra8vc@avalon>
 <20180521095705.GC4432@w540>
 <6943843.2osudLfTFd@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <6943843.2osudLfTFd@avalon>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Mon, May 21, 2018 at 01:54:55PM +0300, Laurent Pinchart wrote:
> Hi Jacopo,
>
> On Monday, 21 May 2018 12:57:05 EEST jacopo mondi wrote:
> > On Fri, May 18, 2018 at 06:12:15PM +0300, Laurent Pinchart wrote:
> > > On Friday, 18 May 2018 17:47:57 EEST Jacopo Mondi wrote:
> > >> Describe CVBS video input through analog video decoder ADV7180
> > >> connected to video input interface VIN4.
> > >>
> > >> The video input signal path is shared with HDMI video input, and
> > >> selected by on-board switches SW-53 and SW-54 with CVBS input select=
ed
> > >> by the default switches configuration.
> > >>
> > >> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > >> Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnate=
ch.se>
> > >>
> > >> ---
> > >> v2 -> v3:
> > >> - Add comment to describe the shared input video path
> > >> - Add my SoB and Niklas' R-b tags
> > >> ---
> > >>
> > >>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 42 +++++++++++++++=
++++
> > >>  1 file changed, 42 insertions(+)
> > >>
> > >> diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > >> b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts index 9d73de8..9574=
5fc
> > >> 100644
> > >> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > >> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > >> @@ -142,6 +142,11 @@
> > >>  		groups =3D "usb0";
> > >>  		function =3D "usb0";
> > >>  	};
> > >> +
> > >> +	vin4_pins_cvbs: vin4 {
> > >> +		groups =3D "vin4_data8", "vin4_sync", "vin4_clk";
> > >> +		function =3D "vin4";
> > >> +	};
> > >>  };
> > >>
> > >>  &i2c0 {
> > >> @@ -154,6 +159,23 @@
> > >>  		reg =3D <0x50>;
> > >>  		pagesize =3D <8>;
> > >>  	};
> > >> +
> > >> +	analog-video@20 {
> > >> +		compatible =3D "adi,adv7180";
> > >> +		reg =3D <0x20>;
> > >> +
> > >> +		port {
> > >
> > > The adv7180 DT bindings document the output port as 3 or 6 (respectiv=
ely
> > > for the CP and ST versions of the chip). You should thus number the p=
ort.
> > > Apart from that the patch looks good.
> >
> > I admit I have barely copied this from Gen-2 boards DTS, but reading
> > the driver code and binding description again, I think this is
> > correct, as the output port numbering and mandatory input port (which
> > is missing here) only apply to adv7180cp/st chip versions.
> >
> > Here we describe plain adv7180, no need to number output ports afaict.
>
> Indeed, my bad.
>
> Shouldn't you however use "adi,adv7180cp" as that's the chip we are using=
 ?
> The "adi,adv7180" has no port documented in its DT bindings, so it should=
n't
> have any port node at all.

I'm a bit confused here.

The only Gen-2 board using the "adi,adv7180cp" compatible string is
Gose, which is also the only one I can get schematics for. That board
indeed feature an ADV7180WBCP32Z, as the Draak does. I cannot get
schematics for any other Gen-2 board, to compare the ADV7180 variant
installed there. If anyone can confirm that all other Gen-2 board uses
a different version (or that all other Gen-2 board DTS file use a
wrong compatible string value), I'll re-send this with a different
compatible value and proper port nodes numbering.

Thanks
  j
>
> > >> +			/*
> > >> +			 * The VIN4 video input path is shared between
> > >> +			 * CVBS and HDMI inputs through SW[49-54] switches.
> > >> +			 *
> > >> +			 * CVBS is the default selection, link it to VIN4 here.
> > >> +			 */
> > >> +			adv7180_out: endpoint {
> > >> +				remote-endpoint =3D <&vin4_in>;
> > >> +			};
> > >> +		};
> > >> +	};
> > >>  };
> > >>
> > >>  &i2c1 {
> > >> @@ -246,3 +268,23 @@
> > >>  	timeout-sec =3D <60>;
> > >>  	status =3D "okay";
> > >>  };
> > >> +
> > >> +&vin4 {
> > >> +	pinctrl-0 =3D <&vin4_pins_cvbs>;
> > >> +	pinctrl-names =3D "default";
> > >> +
> > >> +	status =3D "okay";
> > >> +
> > >> +	ports {
> > >> +		#address-cells =3D <1>;
> > >> +		#size-cells =3D <0>;
> > >> +
> > >> +		port@0 {
> > >> +			reg =3D <0>;
> > >> +
> > >> +			vin4_in: endpoint {
> > >> +				remote-endpoint =3D <&adv7180_out>;
> > >> +			};
> > >> +		};
> > >> +	};
> > >> +};
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbArykAAoJEHI0Bo8WoVY83+YP/AqIqF4MGp80/0OSIim7E9FW
sI8D+Qc5KbjxERzRa29kqzmdo0jmdaSoX/eMgLW61vKdjfX5Md6Y0LlYlSF9lAeN
GRiIDwZs7YUd2w8/BoH6aiAszDCw0FvPaEtm/uTBkBvmS46/s++MgTxux1In6bwI
/MBqgD5rt1DeGz4tAidBCSW4fWHMltkKaLoaV+S55SIsaX6+omCrVqDqrw0cngS9
zTTF4BO4TAGHvXrjkmhbBGO7f0vqDWApCgyAAjtU4rgIiqsfi3Z06ByEw64VzhqR
6B52vMc6m+lE5O8TITZ4JNX05wxwrsFEtBCVuULOfse8Ng7SUvA02+gAzSRgQEDO
RhnpcKD7SagahBnUsaaCc4V7zEVrxzDYDXrFqSd6kr8EgZKyS6CTx9A8cJWxTVYO
IFHctJ1JGeDnYQMmnCxJP+ROOt3BOA1iWQVe+QiQTtWySlIcZHb8MwD1ZgZK7l8v
N1RUOWaaiB9xXbGcSZeF2/ByLTKwgsB07F4sB4Ba9B2OaScXh627+71nRdbfMixU
uWhsYsneGXe07NXl0BlMaLR2mwS47UMhNuugrO94CtJI4DpWAaa9KtRcuWX8u3dY
OT415hcZiUNwq31j2/UQYVNHPtr+jwqcHuvF05UGsb2Jz0OfQmZk1q/598W4l3DK
R/rE7gZlIOcwNnv8pSkK
=A84N
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
