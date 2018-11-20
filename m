Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46428C46463
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5A2208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5A2208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbeKUC33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:29:29 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34120 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbeKUC33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:29:29 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0B91120F6A; Tue, 20 Nov 2018 16:59:38 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id AEEC22074F;
        Tue, 20 Nov 2018 16:58:26 +0100 (CET)
Date:   Tue, 20 Nov 2018 16:58:26 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 01/12] drm/sun4i: sun6i_mipi_dsi: Compute burst mode
 loop N1 instruction delay
Message-ID: <20181120155826.j5rja22jnxpkmjrs@flea>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-2-jagan@amarulasolutions.com>
 <20181119082707.kbsw2gyntxxbh6no@flea>
 <CAMty3ZBDa2wjjCh8NtrbKNYz=mr1xhZKv9JfnmDPDBQRO+CkYw@mail.gmail.com>
 <20181120132357.xge6gkurjjjvwi2i@flea>
 <CAMty3ZDex+UQcZdp2nr3Bd=_PVZH-pAU=GBmLL6sdrfA-dZoVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q3rnoerzhd6vdmpz"
Content-Disposition: inline
In-Reply-To: <CAMty3ZDex+UQcZdp2nr3Bd=_PVZH-pAU=GBmLL6sdrfA-dZoVQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q3rnoerzhd6vdmpz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2018 at 07:06:30PM +0530, Jagan Teki wrote:
> On Tue, Nov 20, 2018 at 6:53 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Mon, Nov 19, 2018 at 04:28:29PM +0530, Jagan Teki wrote:
> > > On Mon, Nov 19, 2018 at 1:57 PM Maxime Ripard <maxime.ripard@bootlin.=
com> wrote:
> > > >
> > > > On Fri, Nov 16, 2018 at 10:09:05PM +0530, Jagan Teki wrote:
> > > > > Loop N1 instruction delay for burst mode lcd panel are
> > > > > computed as per BSP code.
> > > > >
> > > > > Reference code is available in BSP (from linux-sunxi
> > > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > > >
> > > > > dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=3D
> > > > > (panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
> > > > > =3D> (((mode->htotal - mode->hdisplay) * 150) /
> > > > >      ((mode->clock / 1000) * 8)) - 50;
> > > > >
> > > > > So use the similar computation for loop N1 delay.
> > > > >
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > >
> > > > *why* are you doing this? What is it fixing? on which devices?
> > >
> > > You mentioned the separate function to compute the delay for all modes
> > > [1], ie what I did. did I missing anything?
> >
> > You're missing that you are never explaining why that patch is needed
> > in the first place. Or answering the question I asked a couple of
> > lines above.
>=20
> OK.
>=20
> The instruction delay varies between video and burst mode. for burst
> mode panels it is computed based on the panel clock along with
> horizontal sync+porch timings.

You're still stating a fact. What issue, that you experienced, are you
trying to solve here?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--q3rnoerzhd6vdmpz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/QvIgAKCRDj7w1vZxhR
xVcbAP91u8+w6CxdeLDg4ulsZO2ZcgCv2OC6SrSqwgCbQOQlEgEAkG7TECuILdzs
+mmSQdEY9isiOqwywp1g4uMStDC5QwM=
=5kdW
-----END PGP SIGNATURE-----

--q3rnoerzhd6vdmpz--
