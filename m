Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756284AbeDFOQm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:16:42 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33275 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752711AbeDFOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:16:39 -0400
X-Originating-IP: 2.224.242.101
Date: Fri, 6 Apr 2018 16:16:32 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas =?utf-8?Q?S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH 7/7] arm64: dts: renesas: eagle: Add ADV7511W and HDMI
 output
Message-ID: <20180406141632.GO20945@w540>
References: <1523020092-25540-1-git-send-email-jacopo+renesas@jmondi.org>
 <1523020092-25540-8-git-send-email-jacopo+renesas@jmondi.org>
 <2235860.8H9ojNphtF@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R0KbGFzrRdaLlFh/"
Content-Disposition: inline
In-Reply-To: <2235860.8H9ojNphtF@avalon>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R0KbGFzrRdaLlFh/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Fri, Apr 06, 2018 at 04:51:11PM +0300, Laurent Pinchart wrote:
> Hi Jacopo,
>
> Thank you for the patch.
>
> On Friday, 6 April 2018 16:08:12 EEST Jacopo Mondi wrote:
> > From: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
> >
> > Enable HDMI output adding the HDMI connector and the ADV7511W, connected
> > to THC63LVD1024 LVDS decoder output.
> >
> > Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> >  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 51 ++++++++++++++++++=
++++-
> >  1 file changed, 50 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> > b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts index 9d0e65d..e9f7b83
> > 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> > @@ -32,6 +32,17 @@
> >  		reg =3D <0x0 0x48000000 0x0 0x38000000>;
> >  	};
> >
> > +	hdmi-out {
> > +		compatible =3D "hdmi-connector";
> > +		type =3D "a";
> > +
> > +		port {
> > +			hdmi_con_out: endpoint {
> > +				remote-endpoint =3D <&adv7511_out>;
> > +			};
> > +		};
> > +	};
> > +
> >  	thc63lvd1024: lvds-decoder {
> >  		compatible =3D "thine,thc63lvd1024";
> >
> > @@ -41,11 +52,17 @@
> >
> >  			port@0 {
> >  				reg =3D <0>;
> > -
>
> This is unrelated, if you don't want a blank line here remove it from pat=
ch
> 6/7 :-)

No, you're right, this is a leftover from me splitting a single a
patch in 3. According to your comments on other patches in the series
I shouldn't have done that to begin with :)

Thanks
  j

>
> >  				thc63lvd1024_in: endpoint {
> >  					remote-endpoint =3D <&lvds0_out>;
> >  				};
> >  			};
> > +
> > +			port@2 {
> > +				reg =3D <2>;
> > +				thc63lvd1024_out: endpoint {
> > +					remote-endpoint =3D <&adv7511_in>;
> > +				};
> > +			};
> >  		};
> >  	};
> >  };
> > @@ -85,6 +102,38 @@
> >  		gpio-controller;
> >  		#gpio-cells =3D <2>;
> >  	};
> > +
> > +	hdmi@39 {
> > +		compatible =3D "adi,adv7511w";
> > +		reg =3D <0x39>;
> > +		interrupt-parent =3D <&gpio1>;
> > +		interrupts =3D <20 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +		adi,input-depth =3D <8>;
> > +		adi,input-colorspace =3D "rgb";
> > +		adi,input-clock =3D "1x";
> > +		adi,input-style =3D <1>;
> > +		adi,input-justification =3D "evenly";
> > +
> > +		ports {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			port@0 {
> > +				reg =3D <0>;
> > +				adv7511_in: endpoint {
> > +					remote-endpoint =3D <&thc63lvd1024_out>;
> > +				};
> > +			};
> > +
> > +			port@1 {
> > +				reg =3D <1>;
> > +				adv7511_out: endpoint {
> > +					remote-endpoint =3D <&hdmi_con_out>;
> > +				};
> > +			};
> > +		};
> > +	};
> >  };
> >
> >  &pfc {
>
> With patches 5/7, 6/7 and 7/7 merged together and the pinmux removed,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>

--R0KbGFzrRdaLlFh/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJax4FAAAoJEHI0Bo8WoVY8yBIP/0LBBYLyRQhzgOQ6hD31wVZs
EmbPi+Yj+chIKUl1acF6klnPCO4dV46Ilz96yDS6CzeyPH/MUkmy2LJxEnj9Kim2
FE+8C61WSA9+8wMbAWvGToEdQNlnnLbY5GwypZqZXuZ+/2i3yiq4zWUza1aP3Dzu
NEGCU98eGD0uHs9+9yuT1OOr3CyVY8oTCe7TgtJ+w8roH3ldx+0fdBkw3Mh859CV
AGDPV+WwMxUQMRRRVqWtyIuWSg9mxT/fuuM9wzOUntY8ib17hKjVUugg+BIjx/bP
RbUCfQHf/dydLXg8iBBXmebiJJUQH89dpAVQ7aGlzQac98yKr0rYP6LV72Q/sikn
jiQnnoGgT+XauerEvbOBkE1wx3ha/2YPkpznzNpRXyqKdMQAwxZ8WgizgaPnGw9D
BHeG055XsIuTcV9n26q39xs8Yb79qawkCtK2cWdrUcHBLLIV3EBOldayNtsRus9X
H3S1pD2AnrFk+oCxu13xmmDoGNHDdjphHdlZdCQih/SV4jTw0sTvxWi/MksgVSqM
l9dEEz0GAnkRUWrAKi3OhXNhTsDyRbpDG4YnJwytTD2/poWok6XgqfIWLzaN9Qm/
6CHjfFbSCjuTylIHZTFMy13cQlHOtswjNUFdgsVbMtXYDk4TtrDhdSY0GKPj/R6M
sGs0PBnZKrd15wGKoZBX
=ydXF
-----END PGP SIGNATURE-----

--R0KbGFzrRdaLlFh/--
