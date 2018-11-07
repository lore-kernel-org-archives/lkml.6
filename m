Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A72C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773402086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773402086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeKGTEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:04:49 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:50233 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeKGTEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:04:49 -0500
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id BA1EC200010;
        Wed,  7 Nov 2018 09:35:12 +0000 (UTC)
Date:   Wed, 7 Nov 2018 10:35:11 +0100
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
Message-ID: <20181107093511.GX15991@w540>
References: <1540836824-4636-1-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUWP=zBfn8ff1PZ-f7WegQiYU7omGkAM-Fh1uNUxF2XNQ@mail.gmail.com>
 <20181106090756.GP20885@w540>
 <CAMuHMdWbrA1hgh3kw+fvL0x3ciNKHV52uhDX0FNJzU_Grb_+qQ@mail.gmail.com>
 <20181106093121.GA24024@w540>
 <CAMuHMdUd=bYrKu4v0OssWPA=ZAYuiUANahy8x8xNGUoUoXmLCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7QsOHKuLbhbLTwLB"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUd=bYrKu4v0OssWPA=ZAYuiUANahy8x8xNGUoUoXmLCA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7QsOHKuLbhbLTwLB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Geert,

On Wed, Nov 07, 2018 at 09:39:35AM +0100, Geert Uytterhoeven wrote:
> Hi Jacopo,
>
> (sorry, seems I prepared a reply, but forgot to press "Send")
>
> On Tue, Nov 6, 2018 at 10:31 AM jacopo mondi <jacopo@jmondi.org> wrote:
> > On Tue, Nov 06, 2018 at 10:24:30AM +0100, Geert Uytterhoeven wrote:
> > > On Tue, Nov 6, 2018 at 10:08 AM jacopo mondi <jacopo@jmondi.org> wrote:
> > > > On Mon, Nov 05, 2018 at 06:19:22PM +0100, Geert Uytterhoeven wrote:
> > > > > On Mon, Oct 29, 2018 at 7:14 PM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > > > > >    this two patches add supports for VIN4 and VIN5 interfaces to R-Car M3-N.
> > > > > >
> > > > > > On this SoC (and in the forthcoming support for E3 R8A77990) the VIN groups
> > > > > > could appear on different sets of pins, usually the 'a' and 'b' one.
> > > > > >
> > > > > > With the existing VIN_DATA_PIN_GROUP macro we have to specify group names as:
> > > > > >
> > > > > > VIN_DATA_PIN_GROUP(vin4_data_a, 8)
> > > > > >
> > > > > > which results in the group being named as "vin4_data_a_8" which is
> > > > > > un-consistent with the canonical group names (eg. "vin4_data8_a").
> > > > > >
> > > > > > This series adds a macro that allows to specify the group 'version' along with
> > > > > > the pin and mux numbers in patch [1/1]. I haven't been able to find a better
> > > > > > term than 'version' as 'group' was already taken. Suggestions welcome.
> > > > >
> > > > > Yeah, the datasheet also calls these groups :-(
> > > > > A possible alternative is to use "variant"?
> > > > >
> > > > > Or, what about avoiding the name issue by making the VIN_DATA_PIN_GROUP()
> > > > > macro varargs, and passing the "variant" as the (optional) third parameter?
> > > > > That way existing users work as a before, while you can also write e.g.
> > > > >
> > > > >     VIN_DATA_PIN_GROUP_VER(vin4_data, 8, _a),
> > > >
> > > > Indeed.
> > > >
> > > > Would something along the following lines fly for you?
> > > >
> > > > #define VIN_DATA_PIN_GROUP(n, s, ...)                                   \
> > > >         {                                                               \
> > > >                 .name = #n#s#__VA_ARGS__,                               \
> > > >                 .pins = n##__VA_ARGS__##_pins.data##s,                  \
> > > >                 .mux = n##__VA_ARGS__##_mux.data##s,                    \
> > > >                 .nr_pins = ARRAY_SIZE(n##__VA_ARGS__##_pins.data##s),   \
> > > >         }
> > > >
> > > > It can be used as:
> > > > VIN_DATA_PIN_GROUP(vin4_data, 8, _a),
> > > > VIN_DATA_PIN_GROUP(vin5_data, 8),
> > > >
> > > > With your ack on this, I'll send v2.
> > >
> > > Thank you, that is exactly what I had in mind.
> > >
> > > > > > As I cannot test VIN4 nor VIN5 on Salvator-XS as the parallel pins are not
> > > > > > wired, I made sure the macro creates correct names and fields not only by
> > > > > > compile testing it, but with a small C program [1] that replicates the VIN data
> > > > > > layout defined in the PFC module and access fields (and has helped me testing
> > > > > > more easily the preprocessor stringification/concatenation process).
> > > > > >
> > > > > > Final note: Simon, you took the E3 patches in your tree, and I expect them to
> > > > > > land on v4.20-rc1. They use the old macros, are follow up patches ok?)
> > > > >
> > > > > Which patches are using these macro names, and are in v4.20-rc1?
> > > > >
> > > > > BTW, "grep vin._data_[a-z][0-9] drivers/pinctrl/sh-pfc/*o" tells me we already
> > > > > have broken groups names on r8a7792, r8a7795, and r8a7796.
> > > > > Fortunately we have no known users of them, so they can be fixed.
> > > > >
> > > >
> > > > On v4.20-rc1 the grep returns none for me :/
> > > > git grep v4.20-rc1 "vin._data_[a-z][0-9]" drivers/pinctrl/sh-pfc/
> > >
> > > I grepped the .o files, to make sure it would see the final strings, which
> > > obviously works in the build tree only ;-)
> >
> > Ah yes, stupid me.
> >
> > >
> > > For the source tree, please try:
> > >
> > >     git grep -w VIN_DATA_PIN_GROUP.*_[a-z] v4.20-rc1
> >
> > Argh, there are quite a few of them, but fortunately no users so far.
> >
> > Is it ok fixing them in v2 of this series with follow-up patches, or
> > would you like a single patch that introduces the variadic macro and
> > replaces all the occurrences in the per-SoC PFC modules in one go?
>
> Given the r8a7795 and r8a7796 issues were introduced in v4.17:
>
>     a5c2949ff7bd9e04 ("pinctrl: sh-pfc: r8a7796: Deduplicate VIN4 pin
> definitions")
>     9942a5b52990b8d5 ("pinctrl: sh-pfc: r8a7795: Deduplicate VIN4 pin
> definitions")
>
> while the r8a7792 issue date back to v4.9:
>
>     7dd74bb1f058786e ("pinctrl: sh-pfc: r8a7792: Add VIN pin groups")
>
> I think separate patches are easier for backporting.

Fine, I've sent yesterday:
"[PATCH v4 0/4] sh-pfc: Variadic VIN_DATA_PIN_GROUP macro + updates"
which includes: "pinctrl: sh-pfc: Fix VIN versioned groups name" that
changes all users of VIN_DATA_PIN_GROUP in one go.

I'll split that and re-send.

Before resending, if there are comments on:
"pinctrl: sh-pfc: r8a77965: Add VIN[4|5] groups/functions" and
"pinctrl: sh-pfc: r8a77990: Add VIN[4|5] groups/functions"

which are included in that very same series, I'll like to address
them before sending v5 out.

Thanks
   j

>
> Thanks!
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

--7QsOHKuLbhbLTwLB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJb4rHPAAoJEHI0Bo8WoVY8wbYQAItgqo/XX6/F+CJTGDE4niMI
NIFh74/yDTk/d/awdckf9aRo6zkUUPMZuzAAgei68Pu89Q06uS3qiNe1tIwj6Q8f
vAUQjRTLrj7Hc0Q2JHk/HSwPbnkQNxVV1Lr9FMN6AM5RRso9o39tz1Lc3zucUjek
KSPuPa6VwbmcYxDrxV/1/xAD7jRkWex8jQi3OnlqOgt/j06eQpqWWt5c7ImK+SUC
w4OAtm/anvjYkOGkantRgsL+AqFKZt8HMrJ5nVzGiapo8CmP5vlehmdprE0elWvI
Ezt7c+QcabbpZUdnMicJq+pi+RKGKh38d53hed2Jqbg65xvFa/S3E3C2oVP5CWkF
3FZvDEHQvHwS/Arxt98QP3a8bAYTEUEJAvYPjIHX2lMVaRifYljFqE3cBnMl4Ny9
2cNZj5YRrezJEMP9ld7SBWENUw3BSN+MI9M1MpRApwuE0FxOSRwEmcA0JmflNTEP
VKucouh4pcNsYzoHG4/D3mltJRbM0y4B2bWv++31PiQfHIFZD9CN2YHudWiUUDTg
58tyXcUQN96uP0wCIbA5fedjT4fbC83GkP9Du/UI/a+XHjXBbT//qx8J1XbrS7zd
o3tdVp70xAqqLXwvg7SFSuGPLKNYF2ViBf9wabiTAxsxhdNtNEw0gFHviSQ+5T78
UbnT5FX0d115RMMgS5SU
=E+36
-----END PGP SIGNATURE-----

--7QsOHKuLbhbLTwLB--
