Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeDSMeF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:34:05 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40311 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeDSMeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:34:04 -0400
X-Originating-IP: 2.224.242.101
Date: Thu, 19 Apr 2018 14:33:55 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, horms@verge.net.au, magnus.damm@gmail.com,
        geert@linux-m68k.org, niklas.soderlund@ragnatech.se,
        sergei.shtylyov@cogentembedded.com, robh+dt@kernel.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] drm: bridge: Add thc63lvd1024 LVDS decoder driver
Message-ID: <20180419123355.GB4235@w540>
References: <1523357590-3841-1-git-send-email-jacopo+renesas@jmondi.org>
 <1523357590-3841-3-git-send-email-jacopo+renesas@jmondi.org>
 <241462f3-0396-c763-6fb4-aff8fc5d29bd@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <241462f3-0396-c763-6fb4-aff8fc5d29bd@mentor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

On Thu, Apr 19, 2018 at 02:18:30PM +0300, Vladimir Zapolskiy wrote:
> Hi Jacopo,
>
> On 04/10/2018 01:53 PM, Jacopo Mondi wrote:
> > Add DRM bridge driver for Thine THC63LVD1024 LVDS to digital parallel
> > output converter.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> > Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
>
> Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>

Thanks. FYI I sent v9 yesterday with a minimal change compared to v8.

> Generally I have only one pretty ignorable comment.
>
> > +
> > +enum thc63_ports {
> > +	THC63_LVDS_IN0,
> > +	THC63_LVDS_IN1,
> > +	THC63_RGB_OUT0,
> > +	THC63_RGB_OUT1,
> > +};
> > +
>
> The driver uses only THC63_RGB_OUT0 value, or port@2, and MODE{0,1,2} IC
> configuration is ignored.
>
> I don't know if right from the beginning it would be better to support
> dual-out modes, preferably both single-in and dual-in ones. Will it
> impact port enumeration?

The bindings have been designed to support dual in/out modes, as you
can see there are 4 possible ports described there:

Required video port nodes:
- port@0: First LVDS input port
- port@2: First digital CMOS/TTL parallel output

Optional video port nodes:
- port@1: Second LVDS input port
- port@3: Second digital CMOS/TTL parallel output

Future extension should not require changing the port enumeration,
just add a property to specify the selected mode.

>
> I do understand that the extension is possible, and likely only hardware
> accessibility postpones it.

Yes, hardware on one side, but also what I think is a shortcoming of
DRM (which exists in other sub-systems, say v4l2) that matches devices
on their OF device nodes and makes cumbersome handling drivers wanting
to register on 'port' nodes instead, as it would happen if you have 2
input endpoints.

See my [1] note here: https://lkml.org/lkml/2018/3/9/422
And this reply to Archit's comment which has been left floating as it
is not a real issue (yet): https://lkml.org/lkml/2018/3/10/214

Thanks
   j

>
> --
> With best wishes,
> Vladimir

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa2IyzAAoJEHI0Bo8WoVY8zPUQAMKMTJb0ltO5D6MbN6eE+ybr
pRJifFB6zTMJ1QYu/LrKgiMye9n4IcOBQSXf3To07HlPnAAMNUiNNvqF6lV7Wx9N
Wm6Dgd8DRgbR7IJMvEg7HZQeawoGaxXuLmvtmcv++bTCIuoj5l0GwvHHagFuScNz
yPaFcrRKoGznymL03EI1YSmZ/KDbieuZ1P3DYVxappYmk9mmTW0v8PJXsALTQgON
H0Zv80Xs9pqGFQCAiL6H9hosBR4TKsoiqrMOoaMTnGPBRwhXJFBWsSfylXpe/1pQ
zzDbFEa4FVY2L3vcKxkRLc7aGKnmHDNc32PevIiX/iPYDefUnzHLnookPiSmTiFS
jiwW+3L//CKZaPuuOIjkWcqWCDjC7wH/MF9MoQNWahFE4CvOODEYaWZ6EwcoKKOY
aXyr0Sf3E8vo+54IeoRIkwuO2tq8FdfnoKvGGhgCbeKXu3osF0a0XHM79DFri73P
Siye0VyH+cMjD9EJ+/waQI2wInL0CDkRwapsfZB00XoKt3GP+ap30rssb9RiMwJz
w3940WeCHjD35U4EgF7tjCyFKW5VDHICY3trn1HrqkdV7x6cQZvRwlkAzXaJSuXi
vpcsX5T25LRx3BKblBuX6M9ksAKTAwzSUX0wpT/UyDXm5AfpfmwDfJqbGhhRLAzq
uR40QogrduP0JTstz4mD
=AYcB
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
