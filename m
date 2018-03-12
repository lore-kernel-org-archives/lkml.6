Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932720AbeCLQBL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:01:11 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:45097 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932510AbeCLQBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:01:09 -0400
X-Originating-IP: 2.224.242.101
Date: Mon, 12 Mar 2018 15:11:01 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm: Add LVDS decoder bridge
Message-ID: <20180312141101.GC12967@w540>
References: <CGME20180309135207epcas3p32a7d3a0e9c9dae5af8fc855ff3c0e03b@epcas3p3.samsung.com>
 <1520603500-15218-1-git-send-email-jacopo+renesas@jmondi.org>
 <81b25fde-63fa-aacc-1bf4-f2a7b60b19ef@samsung.com>
 <20180312123042.GA12967@w540>
 <915d4251-8162-b97f-5449-b4ea42c2202e@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <915d4251-8162-b97f-5449-b4ea42c2202e@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Andrzej,
    thanks for the detailed reply, much appreciated :)

On Mon, Mar 12, 2018 at 02:47:20PM +0100, Andrzej Hajda wrote:
> On 12.03.2018 13:30, jacopo mondi wrote:
> > Hi Andrzej,
> >
> > On Mon, Mar 12, 2018 at 10:07:27AM +0100, Andrzej Hajda wrote:
> >>

[snip]

> > I understand. The "transparent bridge" is of no actual use, but I don't see
> > how the "double bridge" thing is not an issue if I were to develop
> > support for the actual Thine chip.
>
> What is exactly your configuration: single/dual input, single/dual output?
> Current bindings suggests single/single, am I right? In such case you do
> not need to implement dual link functionality in the driver - since you
> even do not have possibility to test it.

Correct, I'm running in single/single mode.

> But the bindings should support all modes of operation, or at least
> should be easy to extend them in the future with backward compatibility.
>

And here is where I always get lost. For sake of being compatible with
future extensions, bindings shall describe hardware, not what is currently
supported in driver. One day I'll get this right!

> >
> > Please see my reply from yesterday to Archit. I still think having two
> > bridges is somehow an issue...
>
> Yes, I agree. But do we have such case? If no - no problem ATM :), if
> yes - lets try to implement it and see where is the problem, as Archit
> already suggested it would be just a matter of assigning bridge to port
> node, instead of device node.
>

Again, I've been fooled by the idea that if bindings describe
something, the driver should implement it (but I'm still not sure that
"just assign the port node to the bridge" is the right thing to do
here, but let's leave this out for now :)

> >
> > While we clarify that, would it be fine an initial driver version for
> > the actualt Thine chip with a single input support[1]? I would ditch this
> > transparent bridge and resume working on a THC63LVD1024 driver from
> > comments received on v1.
>
> I think, yes: driver with only single input, and full or extend-able
> bindings.
>
> >
> > Thanks
> >   j
> >
> > [1] Single input support implies a single input port in DT bindings
> > even if the chip supports two, and my understanding was that you
> > didn't like this.
>
> I am sorry if I was not clear enough, only thing I wanted was complete
> or at least consistent/extend-able binding.
> So when I saw word "multiple LVDS streams" in bindings I was looking
> further to see how these multiple LVDS bindings are defined, and found
> nothing :)

No worries, you're right here, again it's me confused by bindings
description vs driver features...

> Btw I think it may be better to use "Dual Link" instead of "Multiple
> streams", it is more precise and quite well established in docs.

Ack, I will follow up with a v3 where I'll get rid of generic LVDS
decoder and target the actual chip.

Thanks
   j
>
> Regards
> Andrzej
>
> >
> >
> >> Regards
> >> Andrzej
> >>
> >>> Jacopo Mondi (3):
> >>>   dt-bindings: display: bridge: Document LVDS to parallel decoder
> >>>   drm: bridge: Add LVDS decoder driver
> >>>   arm64: dts: renesas: Add LVDS decoder to R-Car V3M Eagle
> >>>
> >>>  .../bindings/display/bridge/lvds-decoder.txt       |  42 ++++++
> >>>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  31 +++-
> >>>  drivers/gpu/drm/bridge/Kconfig                     |   8 ++
> >>>  drivers/gpu/drm/bridge/Makefile                    |   1 +
> >>>  drivers/gpu/drm/bridge/lvds-decoder.c              | 157 +++++++++++++++++++++
> >>>  5 files changed, 237 insertions(+), 2 deletions(-)
> >>>  create mode 100644 Documentation/devicetree/bindings/display/bridge/lvds-decoder.txt
> >>>  create mode 100644 drivers/gpu/drm/bridge/lvds-decoder.c
> >>>
> >>> --
> >>> 2.7.4
> >>>
> >>>
> >>>
> >>>
>

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJapop1AAoJEHI0Bo8WoVY8mBsQAJmc3NpqjJIj75faFeGqaq9s
/TuNfz5oohyGeFYXsQSmAg3ZwO3zmeLS+Xhb/hRMmDFVoC1RuVCU606cCtdtbHcr
Dm2XDWtt+jHm/v08gMTG1W7u9Urz21W9b37sA/QMTIUOngsBPhUWgS44kcefPFwx
WEH0KJ79RKVFF5PR3vSGa7jzrEkdK3aR66uf0wzlJKWA1GyPMP7rH7M8o3Wc56/B
VF3nhpY7we+nqhDlN7MnpmIDRt7SZggHGi4/j9gEsn5vw/47XHbkDgQbipESPJDP
DNDnZwlzL+47I9EVcfXz3wFvTPFn1Tlx82axfUd2MMx122oKON/HYc4kh9r55awM
Y/f3FSbNlrTQ8P40v8+B7re0JSHpZ4NH1P7zTk7kKJRQ/04vfcL2QEg1e1PExtox
6m2DDVBybGU4OQUnpDuwqDxtIdEhHFGePzDVOPNW2+hYKb2/8rc69WUuddPPgoMF
uQ0ry4PXOLOt9iQ1uV9veq1ugnLi9RjDZv0sIclDDL5AiNyxplJv5VyvltCdT/6z
UCPW/UZ4sUfIYlZ1L1KW2HGolK7BSgCq5JOFD0QMtdsM7cSwcf4cMzvydStOpTmb
IOk/GZB/Nlhirer9zsNcyrC7pUioHt4GMrVPV12AejyEzgRESubG+c165p6wZL/1
o5fxZD4gy2DJh/pJfISt
=QIzb
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
