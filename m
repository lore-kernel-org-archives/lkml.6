Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D852C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1AD21929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545425080;
	bh=g942pk09EJ1iGKMMOHXnbS57mF70xjkbIi8RYZsDTkg=;
	h=Subject:Cc:To:From:In-Reply-To:References:Date:List-ID:From;
	b=UOyiMUfpDAjom6X0q+i+YlpNysAVzrbbkS8bN6WUz3f7yLCcFql+dflc/E7pSQRJ3
	 SfJcaw6UOa7+T06Ys621Qhiy7sejLqPWXTfYf86czumW+ABPZYMBFbvOdwkZ8F692B
	 8P2KpsqamPDwD4fayXSsFqVWu9dFwWznHnVQk6bM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390517AbeLUUoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:44:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388218AbeLUUoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:44:39 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3934A21906;
        Fri, 21 Dec 2018 20:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545425078;
        bh=g942pk09EJ1iGKMMOHXnbS57mF70xjkbIi8RYZsDTkg=;
        h=Subject:Cc:To:From:In-Reply-To:References:Date:From;
        b=g1DjJ/A5I04U20IDH4yJq3T9oeyTabOOdqCXVrQhp54B/Lk+DwOM7o/sO/LJptBKL
         yxOQatou3sWXHP43kD03f+8B3+kEXPnEZVim8BMvKvjHGiXV/n33OahD6GJ7jxNBVP
         9vZ8B8tPVy+b3yhTf1AAiUUNYoBA0MZWsyxkrdfM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 7/8] clk: lochnagar: Add support for the Cirrus Logic Lochnagar
Cc:     broonie@kernel.org, lee.jones@linaro.org, linus.walleij@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181221135037.GH16508@imbe.wolfsonmicro.main>
User-Agent: alot/0.8
References: <20181120141631.18949-1-ckeepax@opensource.cirrus.com> <20181120141631.18949-7-ckeepax@opensource.cirrus.com> <154356443157.88331.15749597863624143993@swboyd.mtv.corp.google.com> <20181221135037.GH16508@imbe.wolfsonmicro.main>
Message-ID: <154542507738.13075.5210584076841559233@swboyd.mtv.corp.google.com>
Date:   Fri, 21 Dec 2018 12:44:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Charles Keepax (2018-12-21 05:50:37)
> On Thu, Nov 29, 2018 at 11:53:51PM -0800, Stephen Boyd wrote:
> > Quoting Charles Keepax (2018-11-20 06:16:30)
>=20
> > > +               break;
> > > +       default:
> > > +               dev_err(priv->dev, "Unknown Lochnagar type: %d\n", pr=
iv->type);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       if (!priv->parents)
> > > +               return -ENOMEM;
> > > +
> > > +       for (i =3D 0; i < priv->nparents; i++) {
> > > +               j =3D of_property_match_string(np, "clock-names",
> > > +                                            priv->parents[i]);
> > > +               if (j >=3D 0)
> > > +                       priv->parents[i] =3D of_clk_get_parent_name(n=
p, j);
> >=20
> > Isn't this of_clk_parent_fill()? But there are holes or something?
> >=20
>=20
> I guess rather than a fill, this is perhaps more of a name and
> replace. I could make this a core function if you prefer? I think
> there are a couple of other drivers that could also use it,
> although might be worth doing that as a separate series rather
> than holding this one up.

No worries. I'm actively changing the parent_names design anyway so this
is fine.

>=20
>=20
> > > +static struct platform_driver lochnagar_clk_driver =3D {
> > > +       .driver =3D {
> > > +               .name =3D "lochnagar-clk",
> > > +               .of_match_table =3D of_match_ptr(lochnagar_of_match),
> >=20
> > I suspect of_match_ptr() makes the build complain about unused match
> > table when CONFIG_OF=3DN. Can you try building it that way?
> >=20
>=20
> The driver depends on the MFD which in turn depends on CONFIG_OF
> so that shouldn't be a problem.

Ok. Then it's really not needed and it's better to drop the usage of
of_match_ptr() then.

>=20
