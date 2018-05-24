Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161261AbeEXT7z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:59:55 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49061 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161267AbeEXT7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:59:50 -0400
X-Originating-IP: 2.224.242.101
Date: Thu, 24 May 2018 21:59:43 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        niklas.soderlund@ragnatech.se, horms@verge.net.au, geert@glider.be,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] arm64: dts: renesas: draak: Describe CVBS input
Message-ID: <20180524195943.GC18369@w540>
References: <1526654878-11143-1-git-send-email-jacopo+renesas@jmondi.org>
 <6943843.2osudLfTFd@avalon>
 <20180521123340.GA15035@w540>
 <1728709.thk7gXDxlo@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <1728709.thk7gXDxlo@avalon>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI Laurent,

On Mon, May 21, 2018 at 04:10:34PM +0300, Laurent Pinchart wrote:
> Hi Jacopo,
>
> On Monday, 21 May 2018 15:33:40 EEST jacopo mondi wrote:
> > On Mon, May 21, 2018 at 01:54:55PM +0300, Laurent Pinchart wrote:
> > > On Monday, 21 May 2018 12:57:05 EEST jacopo mondi wrote:
> > >> On Fri, May 18, 2018 at 06:12:15PM +0300, Laurent Pinchart wrote:
> > >>> On Friday, 18 May 2018 17:47:57 EEST Jacopo Mondi wrote:
> > >>>> Describe CVBS video input through analog video decoder ADV7180
> > >>>> connected to video input interface VIN4.
> > >>>>
> > >>>> The video input signal path is shared with HDMI video input, and
> > >>>> selected by on-board switches SW-53 and SW-54 with CVBS input
> > >>>> selected by the default switches configuration.
> > >>>>
> > >>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > >>>> Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragna=
tech.se>
> > >>>>
> > >>>> ---
> > >>>> v2 -> v3:
> > >>>> - Add comment to describe the shared input video path
> > >>>> - Add my SoB and Niklas' R-b tags
> > >>>> ---
> > >>>>
> > >>>>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 42 +++++++++++++=
+++++
> > >>>>  1 file changed, 42 insertions(+)
> > >>>>
> > >>>> diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > >>>> b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts index
> > >>>> 9d73de8..95745fc
> > >>>> 100644
> > >>>> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > >>>> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > >>>> @@ -142,6 +142,11 @@
> > >>>>  		groups =3D "usb0";
> > >>>>  		function =3D "usb0";
> > >>>>  	};
> > >>>> +
> > >>>> +	vin4_pins_cvbs: vin4 {
> > >>>> +		groups =3D "vin4_data8", "vin4_sync", "vin4_clk";
> > >>>> +		function =3D "vin4";
> > >>>> +	};
> > >>>>  };
> > >>>>
> > >>>>  &i2c0 {
> > >>>> @@ -154,6 +159,23 @@
> > >>>>  		reg =3D <0x50>;
> > >>>>  		pagesize =3D <8>;
> > >>>>  	};
> > >>>> +
> > >>>> +	analog-video@20 {
> > >>>> +		compatible =3D "adi,adv7180";
> > >>>> +		reg =3D <0x20>;
> > >>>> +
> > >>>> +		port {
> > >>>
> > >>> The adv7180 DT bindings document the output port as 3 or 6
> > >>> (respectively for the CP and ST versions of the chip). You should t=
hus
> > >>> number the port. Apart from that the patch looks good.
> > >>
> > >> I admit I have barely copied this from Gen-2 boards DTS, but reading
> > >> the driver code and binding description again, I think this is
> > >> correct, as the output port numbering and mandatory input port (which
> > >> is missing here) only apply to adv7180cp/st chip versions.
> > >>
> > >> Here we describe plain adv7180, no need to number output ports afaic=
t.
> > >
> > > Indeed, my bad.
> > >
> > > Shouldn't you however use "adi,adv7180cp" as that's the chip we are u=
sing
> > > ?
> > > The "adi,adv7180" has no port documented in its DT bindings, so it
> > > shouldn't have any port node at all.
> >
> > I'm a bit confused here.
> >
> > The only Gen-2 board using the "adi,adv7180cp" compatible string is
> > Gose, which is also the only one I can get schematics for. That board
> > indeed feature an ADV7180WBCP32Z, as the Draak does. I cannot get
> > schematics for any other Gen-2 board, to compare the ADV7180 variant
> > installed there. If anyone can confirm that all other Gen-2 board uses
> > a different version (or that all other Gen-2 board DTS file use a
> > wrong compatible string value), I'll re-send this with a different
> > compatible value and proper port nodes numbering.
>
> Other Gen2 boards use a ADV7180WBCP32Z as well. The issue here isn't that=
 the
> chip you're trying to support is different. The DT bindings that were
> initially written for the adi,adv7180 didn't have port nodes. When it was=
 time
> to add them, we realized that two variants of the chip existed with diffe=
rent
> connectivity. We have thus added two new compatible strings to differenti=
ate
> them, with different port numbers. The old compatible string should be
> deprecated in favour of the new ones.
>

Ack, thanks for explaining.

I don't have any Gen2 board here, but if someone is willing to test, I
can change the Gen2 bindings to use the new version in a follow-up
series.

Thanks
   j

> > >>>> +			/*
> > >>>> +			 * The VIN4 video input path is shared between
> > >>>> +			 * CVBS and HDMI inputs through SW[49-54] switches.
> > >>>> +			 *
> > >>>> +			 * CVBS is the default selection, link it to VIN4 here.
> > >>>> +			 */
> > >>>> +			adv7180_out: endpoint {
> > >>>> +				remote-endpoint =3D <&vin4_in>;
> > >>>> +			};
> > >>>> +		};
> > >>>> +	};
> > >>>>  };
> > >>>>
> > >>>>  &i2c1 {
> > >>>> @@ -246,3 +268,23 @@
> > >>>>  	timeout-sec =3D <60>;
> > >>>>  	status =3D "okay";
> > >>>>  };
>  >>>> +
> > >>>> +&vin4 {
> > >>>> +	pinctrl-0 =3D <&vin4_pins_cvbs>;
> > >>>> +	pinctrl-names =3D "default";
> > >>>> +
> > >>>> +	status =3D "okay";
> > >>>> +
> > >>>> +	ports {
> > >>>> +		#address-cells =3D <1>;
> > >>>> +		#size-cells =3D <0>;
> > >>>> +
> > >>>> +		port@0 {
> > >>>> +			reg =3D <0>;
> > >>>> +
> > >>>> +			vin4_in: endpoint {
> > >>>> +				remote-endpoint =3D <&adv7180_out>;
> > >>>> +			};
> > >>>> +		};
> > >>>> +	};
> > >>>> +};
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbBxmvAAoJEHI0Bo8WoVY8T4MP/3q1sl9D+YjiLyumyYZW0JC7
aNpreQtnGkaLWUSh0Y2/0rkHnIgUSR+xfSn1aYlWMfs8B4lbx/qbX6PuX58NZHd+
IfUq1lHLQTIE4wMFxyOsB9jfd4tuzylpvYu7tOYj4ovz08qRyHqZkCGNImReAYtx
VHgZSiMJCxeko9MIIpMkHKfvFyKeWEj2km0vfyvcCGNHKoxV0iTPQi5WX+wLQcHx
uv8LVS71m2t9/yqNZr4o/O74xCXfPsz7tj3MdH7v3skCglqIvLo/iKwVBMWkn4aE
/muWnzeeh1GYHD46a6p6tWEU2wbY4H/WZNoHdCQOkBLZ3MzZTevESNE23J4tYq+U
Orc/5xlFR6nu9dTgfpRMapElFBSjyTJmDWnS0gA+xO2ikDgQAnRdX0j2DrZAwCtp
l49Ig/8uvatsBUWTWX6Q1BmKNuKgQzOJAgt73Rj9Xa4GUXxeAHMbeceLDFPWHt4s
PECbnGkES8mhJQVJE6Sw06CbOkswWT9fY10FHjy9QmZI1nIKSsCJIj4MC6ill1/i
2bPuTaKF5bmMalHpfmhL176uq/0JgduURcOIBAKM4AeC8jEvcOG5/NePxaT86O2r
seZC/YYOWJViAs1VgNBcBYeJuuWHXycl/EkiqGg+XSPuzPjmX4Yjo61P0su8yZ1m
5Gd1tkps81NiDgwWR49X
=IxYo
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
