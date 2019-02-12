Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F791C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826AE218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfBLJai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:30:38 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:41165 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfBLJah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:30:37 -0500
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3254D240005;
        Tue, 12 Feb 2019 09:30:28 +0000 (UTC)
Date:   Tue, 12 Feb 2019 10:30:28 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v6 11/22] clk: sunxi-ng: a64: Add minimum rate for
 PLL_MIPI
Message-ID: <20190212093028.kulsqiai7dsnmbu2@flea>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-12-jagan@amarulasolutions.com>
 <20190125212433.ni2jg3wvpyjazlxf@flea>
 <CAMty3ZAsH2iZ+JEqTE3D58aXfGuhMSg9YoO56ZhhOeE4c4yQHQ@mail.gmail.com>
 <20190129151348.mh27btttsqcmeban@flea>
 <CAMty3ZAjAoti8Zu80c=OyCA+u-jtQnkidsKSNz_c2OaRswqc3w@mail.gmail.com>
 <20190201143102.rcvrxstc365mezvx@flea>
 <CAMty3ZAgJMy+qOW0eO5U_MDUPw0Zaq7tLDi8zwUxw=B6UiFS9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n5t2jrkvjgtlny2z"
Content-Disposition: inline
In-Reply-To: <CAMty3ZAgJMy+qOW0eO5U_MDUPw0Zaq7tLDi8zwUxw=B6UiFS9w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n5t2jrkvjgtlny2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 07:37:57PM +0530, Jagan Teki wrote:
> Hi Maxime,
>=20
> On Fri, Feb 1, 2019 at 8:01 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Tue, Jan 29, 2019 at 11:01:31PM +0530, Jagan Teki wrote:
> > > On Tue, Jan 29, 2019 at 8:43 PM Maxime Ripard <maxime.ripard@bootlin.=
com> wrote:
> > > >
> > > > On Mon, Jan 28, 2019 at 03:06:10PM +0530, Jagan Teki wrote:
> > > > > On Sat, Jan 26, 2019 at 2:54 AM Maxime Ripard <maxime.ripard@boot=
lin.com> wrote:
> > > > > >
> > > > > > On Fri, Jan 25, 2019 at 01:28:49AM +0530, Jagan Teki wrote:
> > > > > > > Minimum PLL used for MIPI is 500MHz, as per manual, but
> > > > > > > lowering the min rate by 300MHz can result proper working
> > > > > > > nkms divider with the help of desired dclock rate from
> > > > > > > panel driver.
> > > > > > >
> > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > > > > >
> > > > > > Going 200MHz below the minimum doesn't seem really reasonable. =
What
> > > > > > is the issue that you are trying to fix here?
> > > > > >
> > > > > > It looks like it's picking bad dividers, but if that's the case=
, this
> > > > > > isn't the proper fix.
> > > > >
> > > > > As I stated in earlier patches, the whole idea is pick the desired
> > > > > dclk divider based dclk rate. So the dotclock, sun4i_dclk_round_r=
ate
> > > > > is unable to get the proper dclk divider at the end, so it eventu=
ally
> > > > > picking up wrong divider value and fired vblank timeout.
> > > > >
> > > > > So, we come-up with optimal and working min_rate 300MHz in pll-mi=
pi to
> > > > > get the desired clock something like below.
> > > > > [    2.415773] [drm] No driver support for vblank timestamp query.
> > > > > [    2.424116] sun4i_dclk_round_rate: min_div =3D 4 max_div =3D 1=
27, rate =3D 55000000
> > > > > [    2.424172] ideal =3D 220000000, rounded =3D 0
> > > > > [    2.424176] ideal =3D 275000000, rounded =3D 0
> > > > > [    2.424194] ccu_nkm_round_rate: rate =3D 330000000
> > > > > [    2.424197] ideal =3D 330000000, rounded =3D 330000000
> > > > > [    2.424201] sun4i_dclk_round_rate: div =3D 6 rate =3D 55000000
> > > > > [    2.424205] sun4i_dclk_round_rate: min_div =3D 4 max_div =3D 1=
27, rate =3D 55000000
> > > > > [    2.424209] ideal =3D 220000000, rounded =3D 0
> > > > > [    2.424213] ideal =3D 275000000, rounded =3D 0
> > > > > [    2.424230] ccu_nkm_round_rate: rate =3D 330000000
> > > > > [    2.424233] ideal =3D 330000000, rounded =3D 330000000
> > > > > [    2.424236] sun4i_dclk_round_rate: div =3D 6 rate =3D 55000000
> > > > > [    2.424253] ccu_nkm_round_rate: rate =3D 330000000
> > > > > [    2.424270] ccu_nkm_round_rate: rate =3D 330000000
> > > > > [    2.424278] sun4i_dclk_recalc_rate: val =3D 1, rate =3D 330000=
000
> > > > > [    2.424281] sun4i_dclk_recalc_rate: val =3D 1, rate =3D 330000=
000
> > > > > [    2.424306] ccu_nkm_set_rate: rate =3D 330000000, parent_rate =
=3D 297000000
> > > > > [    2.424309] ccu_nkm_set_rate: _nkm.n =3D 5
> > > > > [    2.424311] ccu_nkm_set_rate: _nkm.k =3D 2
> > > > > [    2.424313] ccu_nkm_set_rate: _nkm.m =3D 9
> > > > > [    2.424661] sun4i_dclk_set_rate div 6
> > > > > [    2.424668] sun4i_dclk_recalc_rate: val =3D 6, rate =3D 550000=
00
> > > > >
> > > > > But look like this wouldn't valid for all other dclock rates, say=
 BPI
> > > > > panel has 30MHz clock that would failed with this logic.
> > > > >
> > > > > On the other side Allwinner BSP calculating dclk divider based on=
 the
> > > > > SoC's. for A33 [1] it is fixed dclk divider of 4 and for A64 is is
> > > > > calculated based on the bpp/lanes.
> > > >
> > > > It looks like the A64 has the same divider of 4:
> > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi=
/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L12
> > > >
> > > > I think you're confusing it with the ratio between the pixel clock =
and
> > > > the dotclock, called dsi_div:
> > > > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi=
/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L198
> > >
> > > Ahh.. I thought this initially but as far as DSI clock computation is
> > > concern, the L12 tcon_div is local variable which is used for edge0
> > > computation in burst mode and not for the dsi clock computation. Since
> > > the BSP is unable to get the tcon_div during edge0 computation, they
> > > defined it locally I think.
> > >
> > > You can see the lcd_clk_config() code [2], where we can see DSI clock
> > > computation using dsi_div value.
> > >
> > > Here is dump after the in Line 792 which is after computation[3]
> > > [   10.800737] lcd_clk_config: dsi_div =3D 6, tcon_div =3D 4, lcd_div=
 =3D 1
> > > [   10.800743] lcd_clk_config: lcd_dclk_freq =3D 55, dclk_rate =3D 55=
000000
> > > [   10.800749] lcd_clk_config: lcd_rate =3D 330000000, pll_rate =3D 3=
30000000
> > >
> > > The above dump the lcd_rate 330MHz is computed with panel clock, 55MHz
> > > into dsi_div 6. So this can be our actual divider values dclk_min_div,
> > > dclk_max_div in sun4i_dclk_round_rate (from
> > > drivers/gpu/drm/sun4i/sun4i_dotclock.c)
> >
> > I wish it was in your commit log in the first place, instead of having
> > to exchange multiple mails over this.
> >
> > However, I don't think that's quite true, and it might be a bug in
> > Allwinner's implementation (or rather something quite confusing).
> >
> > You're right that the lcd_rate and pll_rate seem to be generated from
> > the pixel clock, and it indeed looks like the ratio between the pixel
> > clock and the TCON dotclock is defined through the number of bits per
> > lanes.
> >
> > However, in this case, dsi_rate is actually the same than lcd_rate,
> > since pll_rate is going to be divided by dsi_div:
> > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/dri=
vers/video/sunxi/disp2/disp/de/disp_lcd.c#L791
> >
> > Since lcd_div is 1, it also means that in this case, dsi_rate =3D=3D
> > dclk_rate.
> >
> > The DSI module clock however, is always set to 148.5 MHz. Indeed, if
> > we look at:
> > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/dri=
vers/video/sunxi/disp2/disp/de/disp_lcd.c#L804
> >
> > We can see that the rate in clk_info is used if it's different than
> > 0. This is filled by disp_al_lcd_get_clk_info, which, in the case of a
> > DSI panel, will hardcode it to 148.5 MHz:
> > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/dri=
vers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L164
> >
> > So, the DSI clock is set to this here:
> > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/dri=
vers/video/sunxi/disp2/disp/de/disp_lcd.c#L805
> >
> > The TCON *module* clock (the one in the clock controller) has been set
> > to lcd_rate (so the pixel clock times the number of bits per lane) here:
> > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/dri=
vers/video/sunxi/disp2/disp/de/disp_lcd.c#L800
> >
> > And the PLL has been set to the same rate here:
> > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/dri=
vers/video/sunxi/disp2/disp/de/disp_lcd.c#L794
> >
> > Let's take a step back now: that function we were looking at,
> > lcd_clk_config, is called by lcd_clk_enable, which is in turn called
> > by disp_lcd_enable here:
> > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/dri=
vers/video/sunxi/disp2/disp/de/disp_lcd.c#L1328
> >
> > The next function being called is disp_al_lcd_cfg, and that function
> > will hardcode the TCON dotclock divider to 4, here:
> > https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/dri=
vers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L240
> >
> > So, in the end, the dotclock divider is always 4, the DSI module clock
> > is set to 148.5 MHz, and the TCON module clock is set to 330MHz. Since
> > the TCON module clock doesn't have a divider, the PLL is set at that
> > same value but this is redundant.
> >
> > I'll experiment with this and try to see how it works on the A33.
>=20
> How is it with A33?

The conclusions are the one I sent in my last series

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--n5t2jrkvjgtlny2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGKSNAAKCRDj7w1vZxhR
xRxYAP4xmunOwBvYcScOPgVobuKMkNSJzx3mvNxKdi432WxeuAD+N2EV4mjALPnX
4iYnaop8lMZTvTNWIY3ne26cSPFqMAU=
=mWJM
-----END PGP SIGNATURE-----

--n5t2jrkvjgtlny2z--
