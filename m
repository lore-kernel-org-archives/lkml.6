Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ABEC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF332146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="gUJYeuxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF332146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeK3X1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:27:01 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:32990 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeK3X1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nn18inWIyXWpyuQb/El/4/4mPT5UZqePsO9l2W0ywEI=; b=gUJYeuxWsmU8yEQfWE47zuEPI
        OtNR9tykHWRVmuLNQ0ARLmBfhJueFLdl3A8aqvKsm7UuVVomTj4FrJ6QUmW+m9JXGal4WioSaWrKH
        314u8tQfiSGBqwxPAutRKPbf56EstxheKiJoFFres5/lagdal0LsvDqyigt1z46nJ5EM0=;
Received: from [2a02:790:ff:919:7ee9:d3ff:fe1f:a246] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gShju-0007LQ-5d; Fri, 30 Nov 2018 13:17:46 +0100
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gShjr-0003G8-GI; Fri, 30 Nov 2018 13:17:43 +0100
Date:   Fri, 30 Nov 2018 13:17:35 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, <bcousson@baylibre.com>,
        <letux-kernel@openphoenux.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <mturquette@baylibre.com>, <paul@pwsan.com>, <tony@atomide.com>
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
Message-ID: <20181130131605.3cfea95d@kemnade.info>
In-Reply-To: <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
References: <20181110203115.13335-1-andreas@kemnade.info>
        <20181110203115.13335-3-andreas@kemnade.info>
        <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
        <20181130071534.0a6cd455@kemnade.info>
        <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
        <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
        <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
        <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JKSN_9Gh0a7D/smCt=_oENr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JKSN_9Gh0a7D/smCt=_oENr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tero,

On Fri, 30 Nov 2018 11:20:49 +0200
Tero Kristo <t-kristo@ti.com> wrote:

> On 30/11/2018 09:57, Stephen Boyd wrote:
> > Quoting Tero Kristo (2018-11-29 23:35:35) =20
> >> On 30/11/2018 09:20, Stephen Boyd wrote: =20
> >>> Quoting Andreas Kemnade (2018-11-29 22:15:34) =20
> >>>> Hi Stephen,
> >>>>
> >>>> On Thu, 29 Nov 2018 16:25:05 -0800
> >>>> Stephen Boyd <sboyd@kernel.org> wrote:
> >>>> =20
> >>>>> Quoting Andreas Kemnade (2018-11-10 12:31:14) =20
> >>>>>> Code might use autoidle api with clocks not being omap2 clocks,
> >>>>>> so check if clock type is not basic
> >>>>>>
> >>>>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >>>>>> ---
> >>>>>> New in v2
> >>>>>> ---
> >>>>>>    drivers/clk/ti/autoidle.c | 12 ++++++++++--
> >>>>>>    1 file changed, 10 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> >>>>>> index 161f67850393..5bdae5552d38 100644
> >>>>>> --- a/drivers/clk/ti/autoidle.c
> >>>>>> +++ b/drivers/clk/ti/autoidle.c
> >>>>>> @@ -54,8 +54,12 @@ static DEFINE_SPINLOCK(autoidle_spinlock);
> >>>>>>    int omap2_clk_deny_idle(struct clk *clk)
> >>>>>>    {
> >>>>>>           struct clk_hw_omap *c;
> >>>>>> +       struct clk_hw *hw =3D __clk_get_hw(clk);
> >>>>>>   =20
> >>>>>> -       c =3D to_clk_hw_omap(__clk_get_hw(clk));
> >>>>>> +       if (clk_hw_get_flags(hw) & CLK_IS_BASIC) =20
> >>>>>
> >>>>> Please try to avoid using CLK_IS_BASIC if at all possible. Can you?
> >>>>> Maybe add some flag in clk_hw_omap() instead?
> >>>>> =20
> >>>> hmm, Tero suggested that.
> >>>> But to check flags in clk_hw_omap I first need to know that there is=
 a
> >>>> clk_hw_omap behind clk_hw. And for that I either need to check flags=
 in
> >>>> clk_hw or do more changes in the omap_hwmod code. =20
> >>>
> >>> Can you do it? The omap code is the only user of CLK_IS_BASIC. All the
> >>> other users are marking clks with this but there is no reason to do s=
o.
> >>> I'll go make another pass over the tree and nuke those ones from orbi=
t. =20
> >>
> >> The reason for using this flag is because OMAP uses two clock types
> >> around, the basic clocks like fixed-factor-clock/fixed-clock, and then
> >> all the omap derivatives, which can be cast to clk_hw_omap. If we want
> >> to avoid usage of CLK_IS_BASIC, we need to copy paste the remaining
> >> basic code under drivers/clk/ti/ and convert them to use clk_hw_omap as
> >> internal datatype. Is this preferred?
> >> =20
> >=20
> > No that is not preferred. Can the omap2_clk_deny_idle() function be
> > integrated closer into the clk framework in some way that allows it to
> > be part of the clk_ops structure? And then have that take a clk_hw
> > structure instead of a struct clk? I haven't looked at this in any
> > detail whatsoever so I may be way off right now. =20
>=20
> It could be added under the main clk_ops struct, however this would=20
> introduce two new func pointers to it which are not used by anything=20
> else but OMAP. Are you aware of any other platforms requiring similar=20
> feature?

The question here is also how we organize the procedure here. One patchset
fixing nasty problems and another mainly reorganize things? Where do we draw
the line between these two? If we have the autoidle code in main clk_ops,
we could also think whether other autoidle code should go into main code.

Regards,
Andreas

--Sig_/JKSN_9Gh0a7D/smCt=_oENr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlwBKmAACgkQfb1qx03i
kyTFZQ/+LYhOeqMel2/sNR00lIM0IYRz/c8g1rgfQUwGXeZ7p1OR88GDdYPlt3Ts
7Uhi3oZvmCLVWrcfTR42Yfao/o/NsKRXm4IwDvi65dZYPn0IsY69OWwAx8BLtSs7
TU4AWmKA6J6ODc4Rsu5KMnmDuLEVE8RxUtwa5jOCZvR0Dbk8Wm0yQBVEUGHhEskq
8h+Vn50lipd9cKZmWNoDFeGNroC7UtRSjS7kodOE0EfzbXlsBb9pBg/wz3Y+WTwl
a2W75OZklZRhKP7Q/wtHyL6cFeIDDzKuMYfgTm123ClfX9DKmx3RqqppzV0MY1VS
I2NkCsHjNu/V2jU1rItuBP0qQeq7T7AQ47Nwn3Xr09EF1L8W2scrjzm/DCuWufdh
xMt5mCyZJLeQfP2vZJzoo3yfLZL6ErP1Nn2aEPpXXgTsXpN7Q0i3YEHISXifi49b
tq0uk3QHdMsslhTX1/zeq5WNoHgTtG9uud5lWFHhP+pu6NYN6kNNeG7Dh06bTBUF
PL196EXXvdva1g6GMD2ButQVP0NfO0cvlkLh70cL33yQnloV8xlR93BjMtzkHsIK
8N5CGu9df9EK6/o97sFlMpZYT9qKvskipS0uvnWXRRvNvIJGlwJWOso6IVsoC3SJ
u6lharSA3uOWKJXDKiRrME/W5Erfa/9hb0GTXy/SQ/KX3Wu3nek=
=2g9z
-----END PGP SIGNATURE-----

--Sig_/JKSN_9Gh0a7D/smCt=_oENr--
