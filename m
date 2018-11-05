Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94686ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AC520854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AC520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbeKEWCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:02:20 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38904 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728798AbeKEWCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:02:19 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0C21E20790; Mon,  5 Nov 2018 13:42:43 +0100 (CET)
Received: from localhost (unknown [185.94.189.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id C09B8206FF;
        Mon,  5 Nov 2018 13:42:42 +0100 (CET)
Date:   Mon, 5 Nov 2018 13:42:42 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 12/15] clk: sunxi-ng: a64: Add min and max rate for
 PLL_MIPI
Message-ID: <20181105124242.f3oyvee4hoexbijz@flea>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-13-jagan@amarulasolutions.com>
 <20181024181334.lul7ta7ijluwfb7v@flea>
 <CAMty3ZBJcH1fz5FyhT1rk9qiJ-aWoQYiH7P1ZyQPLKmVWOCkdA@mail.gmail.com>
 <20181029090856.yyjnvaruyasgnzyz@flea>
 <CAMty3ZBcTsoJsCZa=sM9vjWgHjCjEjY2cDordTQcNySQpzyR=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6i5pemjbntmetmni"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBcTsoJsCZa=sM9vjWgHjCjEjY2cDordTQcNySQpzyR=Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6i5pemjbntmetmni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2018 at 08:38:14PM +0530, Jagan Teki wrote:
> On Mon, Oct 29, 2018 at 2:39 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Thu, Oct 25, 2018 at 09:21:31PM +0530, Jagan Teki wrote:
> > > On Wed, Oct 24, 2018 at 11:43 PM Maxime Ripard
> > > <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > On Tue, Oct 23, 2018 at 09:20:32PM +0530, Jagan Teki wrote:
> > > > > A64 manual say PLL_MIPI rates are 500MHz to 1.4GHz, but
> > > > > using minimum 500MHz can't release the clock and which
> > > > > is not working.
> > > > >
> > > > > So use working minimum rate as 300MHz which is tested on
> > > > > Bananapi DSI panel.
> > > >
> > > > I'm not quite sure what you mean by that. What do you mean by "500M=
Hz
> > > > can't release the clock"? Why would 300MHz work better then? Should=
 be
> > > > avoid reaching 500MHz if it's a frequency in the valid range?
> > >
> > > PLL_MIPI can't be work with existing nkm where rate set to 270MHz
> > > (from PLL_VIDEO)
> > > /*** round rate call in ccu_nkm.c */
> > > [    2.408356] round: rate =3D 118800000
> > > [    2.408359] round: parent_rate =3D 158740688
> > > [    2.408417] round: rate =3D 148500000
> > > [    2.408420] round: parent_rate =3D 158740688
> > > [    2.408439] round: rate =3D 178200000
> > > [    2.408441] round: parent_rate =3D 158740688
> > > [    2.408460] round: rate =3D 205615384
> > > [    2.408462] round: parent_rate =3D 158740688
> > > [    2.408481] round: rate =3D 237600000
> > > [    2.408483] round: parent_rate =3D 158740688
> > > [    2.408502] round: rate =3D 270000000
> > > [    2.408504] round: parent_rate =3D 158740688
> > > [    2.408523] round: rate =3D 118800000
> > > [    2.408525] round: parent_rate =3D 158740560
> > > [    2.408544] round: rate =3D 148500000
> > > [    2.408546] round: parent_rate =3D 158740560
> > > [    2.408565] round: rate =3D 178200000
> > > [    2.408567] round: parent_rate =3D 158740560
> > > [    2.408586] round: rate =3D 205615384
> > > [    2.408588] round: parent_rate =3D 158740560
> > > [    2.408607] round: rate =3D 237600000
> > > [    2.408609] round: parent_rate =3D 158740560
> > > [    2.408627] round: rate =3D 270000000
> > > [    2.408630] round: parent_rate =3D 158740560
> > > [    2.408648] round: rate =3D 270000000
> > > [    2.408651] round: parent_rate =3D 158740640
> > > [    2.408670] round: rate =3D 270000000
> > > [    2.408672] round: parent_rate =3D 158740704
> > >
> > > /** set rate call in ccu_nkm **/
> > > [    2.408685] set: rate =3D 270000000
> > > [    2.408688] set: parent_rate =3D 297000000
> > >
> > > By using min and max rate as per A64 manual page 94 range of PLL can
> > > be 500MHz~1.4GHz getting 1,2,1 nkm dividers which can't be work.
> > > [    2.423589] sun4i_dclk_round_rate: min_div =3D 4 max_div =3D 127, =
rate =3D 55000000
> > > [    2.423643] ideal =3D 220000000, rounded =3D 0
> > > [    2.423647] ideal =3D 275000000, rounded =3D 0
> > > [    2.423651] ideal =3D 330000000, rounded =3D 0
> > > [    2.423692] ideal =3D 385000000, rounded =3D 384000000
> > > [    2.423732] ideal =3D 440000000, rounded =3D 440000000
> > > [    2.423736] sun4i_dclk_round_rate: div =3D 8 rate =3D 55000000
> > > [    2.423740] sun4i_dclk_round_rate: min_div =3D 4 max_div =3D 127, =
rate =3D 55000000
> > > [    2.423744] ideal =3D 220000000, rounded =3D 0
> > > [    2.423748] ideal =3D 275000000, rounded =3D 0
> > > [    2.423751] ideal =3D 330000000, rounded =3D 0
> > > [    2.423791] ideal =3D 385000000, rounded =3D 384000000
> > > [    2.423831] ideal =3D 440000000, rounded =3D 440000000
> > > [    2.423834] sun4i_dclk_round_rate: div =3D 8 rate =3D 55000000
> > > [    2.423957] sun4i_dclk_recalc_rate: val =3D 1, rate =3D 440000000
> > > [    2.423961] sun4i_dclk_recalc_rate: val =3D 1, rate =3D 440000000
> > > [    2.424378] ccu_nkm_set_rate: rate =3D 440000000, parent_rate =3D =
220000000
> > > [    2.424381] ccu_nkm_set_rate: _nkm.n =3D 1
> > > [    2.424383] ccu_nkm_set_rate: _nkm.k =3D 2
> > > [    2.424385] ccu_nkm_set_rate: _nkm.m =3D 1
> > > [    2.424725] sun4i_dclk_set_rate div 8
> > > [    2.424732] sun4i_dclk_recalc_rate: val =3D 8, rate =3D 55000000
> > > [    2.561271] usb 3-1: new high-speed USB device number 2 using ehci=
-platform
> > > [    2.718486] hub 3-1:1.0: USB hub found
> > > [    2.718606] hub 3-1:1.0: 4 ports detected
> > > [    3.437263] ------------[ cut here ]------------
> > > [    3.437270] [CRTC:36:crtc-0] vblank wait timed out
> > >
> > > So, lowering the min rate by 300MHz seems working with bounded nkm
> > > dividers 5, 2, 9. Tested on two different panels.
> > >
> > > [    2.415773] [drm] No driver support for vblank timestamp query.
> > > [    2.424116] sun4i_dclk_round_rate: min_div =3D 4 max_div =3D 127, =
rate =3D 55000000
> > > [    2.424172] ideal =3D 220000000, rounded =3D 0
> > > [    2.424176] ideal =3D 275000000, rounded =3D 0
> > > [    2.424194] ccu_nkm_round_rate: rate =3D 330000000
> > > [    2.424197] ideal =3D 330000000, rounded =3D 330000000
> > > [    2.424201] sun4i_dclk_round_rate: div =3D 6 rate =3D 55000000
> > > [    2.424205] sun4i_dclk_round_rate: min_div =3D 4 max_div =3D 127, =
rate =3D 55000000
> > > [    2.424209] ideal =3D 220000000, rounded =3D 0
> > > [    2.424213] ideal =3D 275000000, rounded =3D 0
> > > [    2.424230] ccu_nkm_round_rate: rate =3D 330000000
> > > [    2.424233] ideal =3D 330000000, rounded =3D 330000000
> > > [    2.424236] sun4i_dclk_round_rate: div =3D 6 rate =3D 55000000
> > > [    2.424253] ccu_nkm_round_rate: rate =3D 330000000
> > > [    2.424270] ccu_nkm_round_rate: rate =3D 330000000
> > > [    2.424278] sun4i_dclk_recalc_rate: val =3D 1, rate =3D 330000000
> > > [    2.424281] sun4i_dclk_recalc_rate: val =3D 1, rate =3D 330000000
> > > [    2.424306] ccu_nkm_set_rate: rate =3D 330000000, parent_rate =3D =
297000000
> > > [    2.424309] ccu_nkm_set_rate: _nkm.n =3D 5
> > > [    2.424311] ccu_nkm_set_rate: _nkm.k =3D 2
> > > [    2.424313] ccu_nkm_set_rate: _nkm.m =3D 9
> > > [    2.424661] sun4i_dclk_set_rate div 6
> > > [    2.424668] sun4i_dclk_recalc_rate: val =3D 6, rate =3D 55000000
> > >
> > > Note: BPI-M64-bsp is setting the rate directly to 180MHz with 297MHz
> > > parent with resulting dividers as 1, 2, 5. ans we can't produce this
> > > 180MHz rate with dclk_round_rate and ccu_nkm.
> >
> > I'm still not quite sure what you mean by "500MHz can't release the
> > clock".
> >
> > From what you're saying, this seems to be related to the boundaries of
> > the dividers rather than the rate itself.
>=20
> Yes, with 500MHz rate the boundaries of the dividers never release
> hence it hangs during set_rate and finally after sometime it trigger
> vblank timeout. can't release here means the same, may be I would
> confused, sorry for that.

I'm sorry, but I still don't get what you mean by release here.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6i5pemjbntmetmni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+A6wgAKCRDj7w1vZxhR
xctnAP9jHz1Mc2nViNq84KUEUbGOgPAxywj2UKb0Xiyimw5m1gEAyhtIf5VVLddf
/APmFMXvud1+zbC+kGmnrH4+pCe25gU=
=B27C
-----END PGP SIGNATURE-----

--6i5pemjbntmetmni--
