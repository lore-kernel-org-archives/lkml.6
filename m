Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E12AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B3D20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B3D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeKFSzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:55:51 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:50769 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbeKFSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:55:51 -0500
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 6DDD41C0008;
        Tue,  6 Nov 2018 09:31:27 +0000 (UTC)
Date:   Tue, 6 Nov 2018 10:31:21 +0100
From:   jacopo mondi <jacopo@jmondi.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] pinctrl: sh-pfc: r8a77965: Add VIN4 and VIN5
Message-ID: <20181106093121.GA24024@w540>
References: <1540836824-4636-1-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUWP=zBfn8ff1PZ-f7WegQiYU7omGkAM-Fh1uNUxF2XNQ@mail.gmail.com>
 <20181106090756.GP20885@w540>
 <CAMuHMdWbrA1hgh3kw+fvL0x3ciNKHV52uhDX0FNJzU_Grb_+qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWbrA1hgh3kw+fvL0x3ciNKHV52uhDX0FNJzU_Grb_+qQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Geert,

On Tue, Nov 06, 2018 at 10:24:30AM +0100, Geert Uytterhoeven wrote:
> Hi Jacopo,
>
> On Tue, Nov 6, 2018 at 10:08 AM jacopo mondi <jacopo@jmondi.org> wrote:
> > On Mon, Nov 05, 2018 at 06:19:22PM +0100, Geert Uytterhoeven wrote:
> > > On Mon, Oct 29, 2018 at 7:14 PM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > > >    this two patches add supports for VIN4 and VIN5 interfaces to R-Car M3-N.
> > > >
> > > > On this SoC (and in the forthcoming support for E3 R8A77990) the VIN groups
> > > > could appear on different sets of pins, usually the 'a' and 'b' one.
> > > >
> > > > With the existing VIN_DATA_PIN_GROUP macro we have to specify group names as:
> > > >
> > > > VIN_DATA_PIN_GROUP(vin4_data_a, 8)
> > > >
> > > > which results in the group being named as "vin4_data_a_8" which is
> > > > un-consistent with the canonical group names (eg. "vin4_data8_a").
> > > >
> > > > This series adds a macro that allows to specify the group 'version' along with
> > > > the pin and mux numbers in patch [1/1]. I haven't been able to find a better
> > > > term than 'version' as 'group' was already taken. Suggestions welcome.
> > >
> > > Yeah, the datasheet also calls these groups :-(
> > > A possible alternative is to use "variant"?
> > >
> > > Or, what about avoiding the name issue by making the VIN_DATA_PIN_GROUP()
> > > macro varargs, and passing the "variant" as the (optional) third parameter?
> > > That way existing users work as a before, while you can also write e.g.
> > >
> > >     VIN_DATA_PIN_GROUP_VER(vin4_data, 8, _a),
> >
> > Indeed.
> >
> > Would something along the following lines fly for you?
> >
> > #define VIN_DATA_PIN_GROUP(n, s, ...)                                   \
> >         {                                                               \
> >                 .name = #n#s#__VA_ARGS__,                               \
> >                 .pins = n##__VA_ARGS__##_pins.data##s,                  \
> >                 .mux = n##__VA_ARGS__##_mux.data##s,                    \
> >                 .nr_pins = ARRAY_SIZE(n##__VA_ARGS__##_pins.data##s),   \
> >         }
> >
> > It can be used as:
> > VIN_DATA_PIN_GROUP(vin4_data, 8, _a),
> > VIN_DATA_PIN_GROUP(vin5_data, 8),
> >
> > With your ack on this, I'll send v2.
>
> Thank you, that is exactly what I had in mind.
>
> > > > As I cannot test VIN4 nor VIN5 on Salvator-XS as the parallel pins are not
> > > > wired, I made sure the macro creates correct names and fields not only by
> > > > compile testing it, but with a small C program [1] that replicates the VIN data
> > > > layout defined in the PFC module and access fields (and has helped me testing
> > > > more easily the preprocessor stringification/concatenation process).
> > > >
> > > > Final note: Simon, you took the E3 patches in your tree, and I expect them to
> > > > land on v4.20-rc1. They use the old macros, are follow up patches ok?)
> > >
> > > Which patches are using these macro names, and are in v4.20-rc1?
> > >
> > > BTW, "grep vin._data_[a-z][0-9] drivers/pinctrl/sh-pfc/*o" tells me we already
> > > have broken groups names on r8a7792, r8a7795, and r8a7796.
> > > Fortunately we have no known users of them, so they can be fixed.
> > >
> >
> > On v4.20-rc1 the grep returns none for me :/
> > git grep v4.20-rc1 "vin._data_[a-z][0-9]" drivers/pinctrl/sh-pfc/
>
> I grepped the .o files, to make sure it would see the final strings, which
> obviously works in the build tree only ;-)

Ah yes, stupid me.

>
> For the source tree, please try:
>
>     git grep -w VIN_DATA_PIN_GROUP.*_[a-z] v4.20-rc1

Argh, there are quite a few of them, but fortunately no users so far.

Is it ok fixing them in v2 of this series with follow-up patches, or
would you like a single patch that introduces the variadic macro and
replaces all the occurrences in the per-SoC PFC modules in one go?

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJb4V9pAAoJEHI0Bo8WoVY8BmIP/3px3dVMrdv/TYIeGwJTQvh5
sKUbiJzWVwhaRgZ1aunDpqHi7cUCPjOV17YswbrcLDZJkew8Ilyri284sbOd/JSq
v5ejpa0Cl7fFnfxEisDNyNKV9+D4bySupaZhtyCXbiJrH2zeOdiIoyD8I3V13Evu
nOGQilirFoPO7VtGq2/kmm+vpS+rIamYCM7AE6V7p/0fT1li3zP0uHKJFGDK21C+
ut4T0bJVGvmAIAwvMlTZ1imCphPCOuAFAIQCDfbj1JxMvtCMwOtp/yMDqSvDfIUm
t/r7RDv7SAcVwGyss13fHovatxOqXiGmZPaB/nzl7ZLxeYdUl25Bl+YN9sHAwIMU
H9fYthkBL+qi48MDjLOmiUP0j+3lo9/Nw6u+zFjQUAmjLFJIkYlgwaBJLDFvZBzF
gLZLVAc3JaO0kYKN/AqZbhXitZh6mjTbIXz0ic3Rjr3lZpvsDJ2Rb6kK3Az4zeal
SP3/JM/ahxac3hlGcB2Irfl68FC5d39HOQdJRRCdBHWvPU3dmy4dLWiGDG9iCzdO
xddGgv7MPdvhl7xT8x+GQDe6A4NacQZUd63rMmftCKhGQ2iwlxulqodlT0+62KVG
6kSDug+A91artQHbWYjFqdCEC+U4T0MZ8U/8Nuv8+c7QbzCh3/xAzrL+IG4tLx60
TWici8Mxg2b7spTyrnVl
=H2RS
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
