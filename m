Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9BAECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C5A214D5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ytrcf99P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C5A214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeJTCKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeJTCKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:10:39 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C6B21470;
        Fri, 19 Oct 2018 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539972210;
        bh=nxD2AjDWzz8u9Kit+miopZ6TDj4oSNsKu2M+cah50rI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ytrcf99PA2XhsazV0CHJdYqMdVE0szbNaiBni00/r+aRxVBz1wO+L3EtB1uRqk7/C
         ysEx0ehP3p1CBpKky+KGFV+Fk4yLZIog7Vm7+s2mKgT5cP1Ke8PRkcNkc7xkGwE+xQ
         zLFPu9LALgaCmx20US1SGexk9OAkijBg7S5MtftE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <01d07c83-b17e-70b5-6e9b-8150ee3aedf2@amlogic.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
 <153988282130.5275.17528969137837015544@swboyd.mtv.corp.google.com>
 <01d07c83-b17e-70b5-6e9b-8150ee3aedf2@amlogic.com>
Message-ID: <153997220960.53599.2059896905852359614@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
Date:   Fri, 19 Oct 2018 11:03:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jianxin Pan (2018-10-19 09:12:53)
> On 2018/10/19 1:13, Stephen Boyd wrote:
> > Quoting Jianxin Pan (2018-10-17 22:07:25)
> >> diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-re=
gmap.c
> >> index 305ee30..f96314d 100644
> >> --- a/drivers/clk/meson/clk-regmap.c
> >> +++ b/drivers/clk/meson/clk-regmap.c
> >> @@ -113,8 +113,25 @@ static int clk_regmap_div_set_rate(struct clk_hw =
*hw, unsigned long rate,
> >>                                   clk_div_mask(div->width) << div->shi=
ft, val);
> >>  };
> >>  =

> >> -/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
> >> +static void clk_regmap_div_init(struct clk_hw *hw)
> >> +{
> >> +       struct clk_regmap *clk =3D to_clk_regmap(hw);
> >> +       struct clk_regmap_div_data *div =3D clk_get_regmap_div_data(cl=
k);
> >> +       unsigned int val;
> >> +       int ret;
> >> +
> >> +       ret =3D regmap_read(clk->map, div->offset, &val);
> >> +       if (ret)
> >> +               return;
> >>  =

> >> +       val &=3D (clk_div_mask(div->width) << div->shift);
> >> +       if (!val)
> >> +               regmap_update_bits(clk->map, div->offset,
> >> +                                  clk_div_mask(div->width) << div->sh=
ift,
> >> +                                  clk_div_mask(div->width));
> >> +}
> >> +
> >> +/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
> > =

> > We should add a patch to rename the symbol for qcom, i.e.
> > qcom_clk_regmap_div_ro_ops, and then any symbols in this directory
> > should be meson_clk_regmap_div_ro_ops.
> "/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */"
> This comment is not introduced in this patch.
> I followed the naming style in this file and add clk_regmap_divider_with_=
init_ops.
> =

> @Jerome=EF=BC=8C What's your suggestion about this=EF=BC=9F

Yes you don't need to fix anything in this series. Just saying that in
the future we should work on cleaning this up.

