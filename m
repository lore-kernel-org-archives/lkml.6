Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D45C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902252086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550822104;
	bh=JEz0bcg046WywF68HABvhfGgl3vqU0KxKynTcb5gqmo=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=BiGcv6YfDzSRduWh+KKqhXDAelCxmhddtpXJMl/jyNMCT60zglS6zO0lWvirbnJOz
	 LLLXPI5gjbQig61z/UYKNoCL2NHuWv/qXXr6JpapUZsasCk5vBsoeXX8KBO1Gl/3sd
	 ZymbXtUob6Iz+S65uuJ18r+5UAupCgy/Shs07Tug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfBVHzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:55:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfBVHzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:55:02 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C70B9207E0;
        Fri, 22 Feb 2019 07:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550822101;
        bh=JEz0bcg046WywF68HABvhfGgl3vqU0KxKynTcb5gqmo=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=llM7pLVq68TADgySgHWtB0kdPJ/TgXNZlpTLdQBkrYaP4JmTNaWDmKkN6qkRt4apg
         s5ZL6Elew86NCzobE28xLKzID7bpahrV67GfVNEd+ji9+Ns+9px7vP4mToKLo6NzZV
         NbexmdYxMaxjmwnEqup+4tfPjZytfFRyv8CehGKw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V5 5/8] clk: mediatek: add MUX_GATE_FLAGS_2
Message-ID: <155082210099.77512.4042430864962937771@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190220025357.7354-1-wangyan.wang@mediatek.com> <20190220025357.7354-6-wangyan.wang@mediatek.com> <155069142918.77512.15726787055211591362@swboyd.mtv.corp.google.com> <1550716451.23876.5.camel@mszsdaap41>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550716451.23876.5.camel@mszsdaap41>
To:     mtk14994 <wangyan.wang@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        srv_heupstream@mediatek.com,
        chunhui dai <chunhui.dai@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Thu, 21 Feb 2019 23:55:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting mtk14994 (2019-02-20 18:34:11)
> Dear Stephen,
> > +       unsigned char mux_flags;
> >=20
> > Why isn't it an unsigned long? Isn't this supposed to match the
> > frameworks version of the clk flags?
>=20
> ---->   it is unsigned char mux_flags ,becasuse struct clk_mux {
>=20
> ....
> ....
> u8 flags;
> ....
> }
>=20
> it is matched when use " mux->flags =3D mc->mux_flags;"
>=20

Please try to not top-post.

Ok I thought it was the generic clk flags, not the mux specific flag
bits. Sounds fine then, but I would sort of expect it to match the type
in clk_mux then, i.e. be a u8 instead of an unsigned char (yes it's the
same in the end but it looks different at a glance).
