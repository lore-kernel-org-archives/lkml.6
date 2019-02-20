Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18A2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C544821841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550691432;
	bh=ls9Kb/WUZC2EEQcYIXRlGgc5kXAjNg6isxqpbbiI54c=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=NW/TwQiBSCy4OAj9trnmZSm9vAVL3B/Pj3mj8A09f0oEGwhr7StEIbO9MQ0ahNtl6
	 2+HN6sy153M/++Fe7123B4hkPsq4+5VqEDRjKwOYLUzzmRXD7z7EG7cwgLfGhAmCug
	 QdFIZU6u4i4WFqjxhMN8Gs/UvEibscZaBdmt32tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfBTThL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:37:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfBTThK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:37:10 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F01872147A;
        Wed, 20 Feb 2019 19:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550691430;
        bh=ls9Kb/WUZC2EEQcYIXRlGgc5kXAjNg6isxqpbbiI54c=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=ky5RQCttZLD9W7GPElvHfb73aS1HjSxHPKu1hxFx290GUDtGun6k+iQ6Xy8MFBpAq
         g9BED9OpfiZbWRT3FqIwJyuQ9q61CecNsr9bhvUAenG7SXoFLfAdjTOR1EcFznnIAi
         IRYq3jdv1SCPRKSXAX1M+8OhJI5VlU/M1N53q8Uc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V5 5/8] clk: mediatek: add MUX_GATE_FLAGS_2
Message-ID: <155069142918.77512.15726787055211591362@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190220025357.7354-1-wangyan.wang@mediatek.com> <20190220025357.7354-6-wangyan.wang@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190220025357.7354-6-wangyan.wang@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        wangyan wang <wangyan.wang@mediatek.com>
Cc:     wangyan wang <wangyan.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, srv_heupstream@mediatek.com
Date:   Wed, 20 Feb 2019 11:37:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting wangyan wang (2019-02-19 18:53:54)
> From: chunhui dai <chunhui.dai@mediatek.com>
>=20
> Add MUX_GATE_FLAGS_2 for the clock which needs to set two falgs.

s/falgs/flags/

> Such as some mux need to set the flags of "CLK_MUX_ROUND_CLOSEST".
>=20
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c |  2 +-
>  drivers/clk/mediatek/clk-mtk.h | 20 ++++++++++++++------
>  2 files changed, 15 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mt=
k.c
> index 9c0ae4278a94..2ed996404804 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -167,7 +167,7 @@ struct clk *mtk_clk_register_composite(const struct m=
tk_composite *mc,
>                 mux->mask =3D BIT(mc->mux_width) - 1;
>                 mux->shift =3D mc->mux_shift;
>                 mux->lock =3D lock;
> -
> +               mux->flags =3D mc->mux_flags;
>                 mux_hw =3D &mux->hw;
>                 mux_ops =3D &clk_mux_ops;
> =20
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mt=
k.h
> index f83c2bbb677e..4b88d196d52f 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -81,15 +81,13 @@ struct mtk_composite {
>         signed char divider_shift;
>         signed char divider_width;
> =20
> +       unsigned char mux_flags;

Why isn't it an unsigned long? Isn't this supposed to match the
frameworks version of the clk flags?

