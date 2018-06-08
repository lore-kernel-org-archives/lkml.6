Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id y2VnE6oRGlusUgAAmS7hNA
	; Fri, 08 Jun 2018 05:18:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 79A546089E; Fri,  8 Jun 2018 05:18:50 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF6u1Hjf"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 62D95601C3;
	Fri,  8 Jun 2018 05:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62D95601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeFHFSr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:18:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34769 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeFHFSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:18:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id l15-v6so977378wmc.1;
        Thu, 07 Jun 2018 22:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6gJPkbUIwJqgY/rce5MV+JC/Cy2Y8miuEz7PUmwnkFU=;
        b=GF6u1HjfXaFnRd4V9Pg1yAF8eCq8/5mgUZA9fM8t2C2zPiyCy522JI5OtXpzo4IrSq
         v3wQhEA3Njdve0tTLBpa/OW9oQIwR5HtYQeo4p+2eIoFlJ7t81aQGw5yc3HbdoReI6Ze
         ZWQ93kKkg85IfFD4HnbGZR1z7JCo6fJqSz98K9Ysb88QHk8QqRZEFrh37op6Y20RzYMa
         SklAkIrok6C+wWKJX5heXlrXjSDJ4c+tKfJrnoAVKCpgUIM3/blPMXGoUzqyq/BSJ/lF
         qiB7tVpsG2BTwz97I9PloAkKXSoEbZnARgcfC2uI30SIz/h+e5HLcjTLeeuUl8wPYROL
         vJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6gJPkbUIwJqgY/rce5MV+JC/Cy2Y8miuEz7PUmwnkFU=;
        b=mVA0XvuSQWhPWdAeRnwIY5vmYIsnyRXRuDiJzlH1iuFx6VbDS4UdYGzuJ5+CttpCw6
         KiJgbEPhiIITBQJoRu99RHQ2+tkxwyqE1b5EU+HPhyw2V5E5PlB0uGQ4L/ytYzw3a8b8
         NKQWk42HbpmQ2u3zMtZxUuKxvBd+BCa6Ev7F0/SUVltrizFUJXs2pISfuUU6dYKDOdzL
         9qc790sS6XhCcV6p5+TA/mYeYZ1gaUjUI/tOSPlU843rwfhUGmH3h4io7HDNE0Vc9Rgs
         nKDSOp9rD34L+czflTqsuuEnjiDpt3C7Oz3YdX+9MpCmBrhMDvdFMMXUuXQVVkio4E6M
         ysEA==
X-Gm-Message-State: APt69E2irOZNbzeFLZuupevj26lX/6SvSgYQLqTUBfrsDmKqpsY8C40w
        zuflTFiViOss5XYk7LuqQx3obg==
X-Google-Smtp-Source: ADUXVKKbhMzFOvPcRDXxQ7glpKaFCSdwFRApBtmlut8jTZHlDWYxmZtncRxd4KGdwDDQYIVb04k/xg==
X-Received: by 2002:a1c:6d2:: with SMTP id 201-v6mr394616wmg.47.1528435123941;
        Thu, 07 Jun 2018 22:18:43 -0700 (PDT)
Received: from jernej-laptop.localnet ([194.152.15.144])
        by smtp.gmail.com with ESMTPSA id p5-v6sm42157155wre.83.2018.06.07.22.18.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 22:18:43 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-sunxi@googlegroups.com
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [linux-sunxi] Re: [PATCH 06/15] drm/sun4i: tcon: Add support for tcon-top
Date: Fri, 08 Jun 2018 07:17:45 +0200
Message-ID: <1672957.FObGO1ODKN@jernej-laptop>
In-Reply-To: <1557047.0h10P8OJYS@jernej-laptop>
References: <20180519183127.2718-1-jernej.skrabec@siol.net> <20180604162357.rige4rcsiowdl725@flea> <1557047.0h10P8OJYS@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 07. junij 2018 ob 00:30:24 CEST je Jernej =C5=A0krabec na=
pisal(a):
> Dne ponedeljek, 04. junij 2018 ob 18:23:57 CEST je Maxime Ripard napisal(=
a):
> > On Mon, Jun 04, 2018 at 05:09:56PM +0200, Jernej =C5=A0krabec wrote:
> > > Dne ponedeljek, 04. junij 2018 ob 13:50:34 CEST je Maxime Ripard
>=20
> napisal(a):
> > > > On Fri, Jun 01, 2018 at 09:19:43AM -0700, Chen-Yu Tsai wrote:
> > > > > On Fri, Jun 1, 2018 at 8:29 AM, Maxime Ripard
> > > > > <maxime.ripard@bootlin.com>
> > >=20
> > > wrote:
> > > > > > On Thu, May 31, 2018 at 07:54:08PM +0200, Jernej =C5=A0krabec w=
rote:
> > > > > >> Dne =C4=8Detrtek, 31. maj 2018 ob 11:21:33 CEST je Maxime Ripa=
rd
>=20
> napisal(a):
> > > > > >> > On Thu, May 24, 2018 at 03:01:09PM -0700, Chen-Yu Tsai wrote:
> > > > > >> > > >> > > + if (tcon->quirks->needs_tcon_top) {
> > > > > >> > > >> > > +         struct device_node *np;
> > > > > >> > > >> > > +
> > > > > >> > > >> > > +         np =3D of_parse_phandle(dev->of_node,
> > > > > >> > > >> > > "allwinner,tcon-top",
> > > > > >> > > >> > > 0);
> > > > > >> > > >> > > +         if (np) {
> > > > > >> > > >> > > +                 struct platform_device *pdev;
> > > > > >> > > >> > > +
> > > > > >> > > >> > > +                 pdev =3D of_find_device_by_node(n=
p);
> > > > > >> > > >> > > +                 if (pdev)
> > > > > >> > > >> > > +                         tcon->tcon_top =3D
> > > > > >> > > >> > > platform_get_drvdata(pdev);
> > > > > >> > > >> > > +                 of_node_put(np);
> > > > > >> > > >> > > +
> > > > > >> > > >> > > +                 if (!tcon->tcon_top)
> > > > > >> > > >> > > +                         return -EPROBE_DEFER;
> > > > > >> > > >> > > +         }
> > > > > >> > > >> > > + }
> > > > > >> > > >> > > +
> > > > > >> > > >> >=20
> > > > > >> > > >> > I might have missed it, but I've not seen the bindings
> > > > > >> > > >> > additions for
> > > > > >> > > >> > that property. This shouldn't really be done that way
> > > > > >> > > >> > anyway,
> > > > > >> > > >> > instead
> > > > > >> > > >> > of using a direct phandle, you should be using the
> > > > > >> > > >> > of-graph,
> > > > > >> > > >> > with the
> > > > > >> > > >> > TCON-top sitting where it belongs in the flow of data.
> > > > > >> > > >>=20
> > > > > >> > > >> Just to answer to the first question, it did describe it
> > > > > >> > > >> in
> > > > > >> > > >> "[PATCH
> > > > > >> > > >> 07/15] dt- bindings: display: sun4i-drm: Add R40 HDMI
> > > > > >> > > >> pipeline".
> > > > > >> > > >>=20
> > > > > >> > > >> As why I designed it that way - HW representation could=
 be
> > > > > >> > > >> described
> > > > > >> > > >> that way> >>
> > > > > >> > > >>=20
> > > > > >> > > >> (ASCII art makes sense when fixed width font is used to
> > > > > >> > > >> view
> > >=20
> > > it):
> > > > > >> > > >>                             / LCD0/LVDS0
> > > > > >> > > >>                =20
> > > > > >> > > >>                 / TCON-LCD0
> > > > > >> > > >>                =20
> > > > > >> > > >>                 |           \ MIPI DSI
> > > > > >> > > >>=20
> > > > > >> > > >> mixer0          |
> > > > > >> > > >>=20
> > > > > >> > > >>        \        / TCON-LCD1 - LCD1/LVDS1
> > > > > >> > > >>       =20
> > > > > >> > > >>         TCON-TOP
> > > > > >> > > >>       =20
> > > > > >> > > >>        /        \ TCON-TV0 - TVE0/RGB
> > > > > >> > > >>=20
> > > > > >> > > >> mixer1          |          \
> > > > > >> > > >>=20
> > > > > >> > > >>                 |           TCON-TOP - HDMI
> > > > > >> > > >>                 |         =20
> > > > > >> > > >>                 |          /
> > > > > >> > > >>                =20
> > > > > >> > > >>                 \ TCON-TV1 - TVE1/RGB
> > > > > >> > > >>=20
> > > > > >> > > >> This is a bit simplified, since there is also TVE-TOP,
> > > > > >> > > >> which
> > > > > >> > > >> is
> > > > > >> > > >> responsible
> > > > > >> > > >> for sharing 4 DACs between both TVE encoders. You can h=
ave
> > > > > >> > > >> two
> > > > > >> > > >> TV outs
> > > > > >> > > >> (PAL/ NTSC) or TVE0 as TV out and TVE1 as RGB or vice
> > > > > >> > > >> versa.
> > > > > >> > > >> It
> > > > > >> > > >> even
> > > > > >> > > >> seems that you can arbitrarly choose which DAC is
> > > > > >> > > >> responsible
> > > > > >> > > >> for
> > > > > >> > > >> which signal, so there is a ton of possible end
> > > > > >> > > >> combinations,
> > > > > >> > > >> but I'm
> > > > > >> > > >> not 100% sure.
> > > > > >> > > >>=20
> > > > > >> > > >> Even though I wrote TCON-TOP twice, this is same unit in
> > > > > >> > > >> HW.
> > > > > >> > > >> R40
> > > > > >> > > >> manual
> > > > > >> > > >> suggest more possibilities, although some of them seem
> > > > > >> > > >> wrong,
> > > > > >> > > >> like RGB
> > > > > >> > > >> feeding from LCD TCON. That is confirmed to be wrong wh=
en
> > > > > >> > > >> checking BSP
> > > > > >> > > >> code.
> > > > > >> > > >>=20
> > > > > >> > > >> Additionally, TCON-TOP comes in the middle of TVE0 and
> > > > > >> > > >> LCD0,
> > > > > >> > > >> TVE1 and
> > > > > >> > > >> LCD1 for pin muxing, although I'm not sure why is that
> > > > > >> > > >> needed at
> > > > > >> > > >> all,
> > > > > >> > > >> since according to R40 datasheet, TVE0 and TVE1 pins are
> > > > > >> > > >> dedicated and
> > > > > >> > > >> not on PORT D and PORT H, respectively, as TCON-TOP
> > > > > >> > > >> documentation
> > > > > >> > > >> suggest. However, HSYNC and PSYNC lines might be shared
> > > > > >> > > >> between
> > > > > >> > > >> TVE
> > > > > >> > > >> (when it works in RGB mode) and LCD. But that is just my
> > > > > >> > > >> guess
> > > > > >> > > >> since
> > > > > >> > > >> I'm not really familiar with RGB and LCD interfaces.
> > > > > >> > > >>=20
> > > > > >> > > >> I'm really not sure what would be the best representati=
on
> > > > > >> > > >> in
> > > > > >> > > >> OF-graph.
> > > > > >> > > >> Can you suggest one?
> > > > > >> > > >=20
> > > > > >> > > > Rob might disagree on this one, but I don't see anything
> > > > > >> > > > wrong
> > > > > >> > > > with
> > > > > >> > > > having loops in the graph. If the TCON-TOP can be both t=
he
> > > > > >> > > > input
> > > > > >> > > > and
> > > > > >> > > > output of the TCONs, then so be it, and have it described
> > > > > >> > > > that
> > > > > >> > > > way in
> > > > > >> > > > the graph.
> > > > > >> > > >=20
> > > > > >> > > > The code is already able to filter out nodes that have
> > > > > >> > > > already
> > > > > >> > > > been
> > > > > >> > > > added to the list of devices we need to wait for in the
> > > > > >> > > > component
> > > > > >> > > > framework, so that should work as well.
> > > > > >> > > >=20
> > > > > >> > > > And we'd need to describe TVE-TOP as well, even though we
> > > > > >> > > > don't
> > > > > >> > > > have a
> > > > > >> > > > driver for it yet. That will simplify the backward
> > > > > >> > > > compatibility
> > > > > >> > > > later
> > > > > >> > > > on.
> > > > > >> > >=20
> > > > > >> > > I'm getting the feeling that TCON-TOP / TVE-TOP is the glue
> > > > > >> > > layer
> > > > > >> > > that
> > > > > >> > > binds everything together, and provides signal routing, ki=
nd
> > > > > >> > > of
> > > > > >> > > like
> > > > > >> > > DE-TOP on A64. So the signal mux controls that were
> > > > > >> > > originally
> > > > > >> > > found
> > > > > >> > > in TCON0 and TVE0 were moved out.
> > > > > >> > >=20
> > > > > >> > > The driver needs to know about that, but the graph about
> > > > > >> > > doesn't
> > > > > >> > > make
> > > > > >> > > much sense directly. Without looking at the manual, I
> > > > > >> > > understand it
> > > > > >> > > to
> > > > > >> > > likely be one mux between the mixers and TCONs, and one
> > > > > >> > > between
> > > > > >> > > the
> > > > > >> > > TCON-TVs and HDMI. Would it make more sense to just have t=
he
> > > > > >> > > graph
> > > > > >> > > connections between the muxed components, and remove TCON-=
TOP
> > > > > >> > > from
> > > > > >> > > it, like we had in the past? A phandle could be used to
> > > > > >> > > reference
> > > > > >> > > the TCON-TOP for mux controls, in addition to the clocks a=
nd
> > > > > >> > > resets.
> > > > > >> > >=20
> > > > > >> > > For TVE, we would need something to represent each of the
> > > > > >> > > output
> > > > > >> > > pins,
> > > > > >> > > so the device tree can actually describe what kind of sign=
al,
> > > > > >> > > be it
> > > > > >> > > each component of RGB/YUV or composite video, is wanted on
> > > > > >> > > each
> > > > > >> > > pin,
> > > > > >> > > if any. This is also needed on the A20 for the Cubietruck,=
 so
> > > > > >> > > we
> > > > > >> > > can
> > > > > >> > > describe which pins are tied to the VGA connector, and whi=
ch
> > > > > >> > > one
> > > > > >> > > does
> > > > > >> > > R, G, or B.
> > > > > >> >=20
> > > > > >> > I guess we'll see how the DT maintainers feel about this, but
> > > > > >> > my
> > > > > >> > impression is that the OF graph should model the flow of data
> > > > > >> > between
> > > > > >> > the devices. If there's a mux somewhere, then the data is
> > > > > >> > definitely
> > > > > >> > going through it, and as such it should be part of the graph.
> > > > > >>=20
> > > > > >> I concur, but I spent few days thinking how to represent this
> > > > > >> sanely in
> > > > > >> graph, but I didn't find any good solution. I'll represent here
> > > > > >> my
> > > > > >> idea and please tell your opinion before I start implementing =
it.
> > > > > >>=20
> > > > > >> First, let me be clear that mixer0 and mixer1 don't have same
> > > > > >> capabilities
> > > > > >> (different number of planes, mixer0 supports writeback, mixer1
> > > > > >> does
> > > > > >> not,
> > > > > >> etc.). Thus, it does matter which mixer is connected to which
> > > > > >> TCON/encoder.
> > > > > >> mixer0 is meant to be connected to main display and mixer1 to
> > > > > >> auxiliary. That obviously depends on end system.
> > > > > >>=20
> > > > > >> So, TCON TOP has 3 muxes, which have to be represented in grap=
h.
> > > > > >> Two of
> > > > > >> them are for mixer/TCON relationship (each of them 1 input and=
 4
> > > > > >> possible outputs) and one for TV TCON/HDMI pair selection (2
> > > > > >> possible
> > > > > >> inputs, 1 output).
> > > > > >>=20
> > > > > >> According to current practice in sun4i-drm driver, graph has to
> > > > > >> have
> > > > > >> port 0, representing input and port 1, representing output. Th=
is
> > > > > >> would
> > > > > >> mean that graph looks something like that:
> > > > > >>=20
> > > > > >> tcon_top: tcon-top@1c70000 {
> > > > > >>=20
> > > > > >>       compatible =3D "allwinner,sun8i-r40-tcon-top";
> > > > > >>       ...
> > > > > >>       ports {
> > > > > >>      =20
> > > > > >>               #address-cells =3D <1>;
> > > > > >>               #size-cells =3D <0>;
> > > > > >>              =20
> > > > > >>               tcon_top_in: port@0 {
> > > > > >>              =20
> > > > > >>                       #address-cells =3D <1>;
> > > > > >>                       #size-cells =3D <0>;
> > > > > >>                       reg =3D <0>;
> > > > > >>                      =20
> > > > > >>                       tcon_top_in_mixer0: endpoint@0 {
> > > > > >>                      =20
> > > > > >>                               reg =3D <0>;
> > > > > >>                               remote-endpoint =3D
> > > > > >>                               <&mixer0_out_tcon_top>;
> > > > > >>                      =20
> > > > > >>                       };
> > > > > >>                      =20
> > > > > >>                       tcon_top_in_mixer1: endpoint@1 {
> > > > > >>                      =20
> > > > > >>                               reg =3D <1>;
> > > > > >>                               remote-endpoint =3D
> > > > > >>                               <&mixer1_out_tcon_top>;
> > > > > >>                      =20
> > > > > >>                       };
> > > > > >>                      =20
> > > > > >>                       tcon_top_in_tcon_tv: endpoint@2 {
> > > > > >>                      =20
> > > > > >>                               reg =3D <2>;
> > > > > >>                               // here is HDMI input connection,
> > > > > >>                               part of
> > > > > >>                               board DTS
> > > > > >>                               remote-endpoint =3D <board speci=
fic
> > > > > >>                               phandle
> > > > > >>                               to TV TCON output>;
> > > > > >>                      =20
> > > > > >>                       };
> > > > > >>              =20
> > > > > >>               };
> > > > > >>              =20
> > > > > >>               tcon_top_out: port@1 {
> > > > > >>              =20
> > > > > >>                       #address-cells =3D <1>;
> > > > > >>                       #size-cells =3D <0>;
> > > > > >>                       reg =3D <1>;
> > > > > >>                      =20
> > > > > >>                       tcon_top_out_tcon0: endpoint@0 {
> > > > > >>                      =20
> > > > > >>                               reg =3D <0>;
> > > > > >>                               // here is mixer0 output
> > > > > >>                               connection,
> > > > > >>                               part
> > > > > >>                               of board DTS
> > > > > >>                               remote-endpoint =3D <board speci=
fic
> > > > > >>                               phandle
> > > > > >>                               to TCON>;
> > > > > >>                      =20
> > > > > >>                       };
> > > > > >>                      =20
> > > > > >>                       tcon_top_out_tcon1: endpoint@1 {
> > > > > >>                      =20
> > > > > >>                               reg =3D <1>;
> > > > > >>                               // here is mixer1 output
> > > > > >>                               connection,
> > > > > >>                               part
> > > > > >>                               of board DTS
> > > > > >>                               remote-endpoint =3D <board speci=
fic
> > > > > >>                               phandle
> > > > > >>                               to TCON>;
> > > > > >>                      =20
> > > > > >>                       };
> > > > > >>                      =20
> > > > > >>                       tcon_top_out_hdmi: endpoint@2 {
> > > > > >>                      =20
> > > > > >>                               reg =3D <2>;
> > > > > >>                               remote-endpoint =3D
> > > > > >>                               <&hdmi_in_tcon_top>;
> > > > > >>                      =20
> > > > > >>                       };
> > > > > >>              =20
> > > > > >>               };
> > > > > >>      =20
> > > > > >>       };
> > > > > >>=20
> > > > > >> };
> > > > > >=20
> > > > > > IIRC, each port is supposed to be one route for the data, so we
> > > > > > would
> > > > > > have multiple ports, one for the mixers in input and for the tc=
on
> > > > > > in
> > > > > > output, and one for the TCON in input and for the HDMI/TV in
> > > > > > output. Rob might correct me here.
> > >=20
> > > Ok, that seems more clean approach. I'll have to extend graph travers=
ing
> > > algorithm in sun4i_drv.c, but that's no problem.
> > >=20
> > > Just to be clear, you have in mind 3 pairs of ports (0/1 for mixer0 m=
ux,
> > > 2/3 for mixer1 and 4/5 for HDMI input), right? That way each mux is
> > > represented with one pair of ports, even numbered for input and odd
> > > numbered for output.
> >=20
> > Yep, unless Rob feels otherwise.
>=20
> I found an issue with this concept.
>=20
> HDMI driver (sun8i_dw_hdmi.c) uses drm_of_find_possible_crtcs() to find
> connected crtcs (TCONs) to HDMI. This function assumes that crtc and enco=
der
> are directly connected through of_graph, but that is not the case with TC=
ON
> TOP HDMI mux anymore.
> I could give TCON TOP node as an input to this function, but that won't
> work, since TCON TOP can have connections to other crtcs, not only that of
> HDMI and they will also be picked up by drm_of_find_possible_crtcs().
>=20
> Any suggestion how to solve this nicely? I think creating my own version =
of
> drm_of_find_possible_crtcs() which considers that case is one way, but not
> very nice solution. Alternatively, we can fix possible_crtcs to BIT(0),

This doesn't seem like a good solution, since it doesn't work in dual head=
=20
system. I'll take first approach.

Best regards,
Jernej

> since it always has only one input. This is done in meson_dw_hdmi.c for
> example.
