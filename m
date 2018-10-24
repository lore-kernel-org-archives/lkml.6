Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAA3C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE5920824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZEnexe6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE5920824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeJXR2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:28:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41845 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeJXR2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:28:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id q7-v6so4663538wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R/ylNOdH39QL43SdexiX2HGNkk4m7fJKVsFO0muMG9s=;
        b=ZEnexe6CW8XqCNNofwruaWMOTFrRy4cd0/faBqeGw1/O5Lf38lCHLewPXiqV8wehhN
         /dL+bm/Lz6/CkMMOPO4v7siHBrUk0GGe42GFfc8Z4AkA2cFdw+YfNJQTgKsdgtT+gGE5
         9KCuvQ1YBifGRvigkWk2PrHR3s7EZc3Xfddakl1q2WtfZe+RVQ+8Fqci6AfB2nWDh5bT
         bp946V3skOdzxQvf2N5Bvx8y+dvZ/B48npKEVo9kt9JDss57Q9c0EvMdBQxWLWdDBpvL
         3gwVo6CRHkrB/azwhY9BJEH1hI7EqUeGaDckD6C0e0Zrgs2HM4trbm5TeqAFiPAJLQ77
         /uIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/ylNOdH39QL43SdexiX2HGNkk4m7fJKVsFO0muMG9s=;
        b=Mrlb2ux9J05P07c51NiIbTrgKiv2vwcVCs5SlmhKSz6k9CJPmtMkcR/zC5JBhyvjKj
         1hZc9dd8WyytnQjkXvM1imMcSGF+txLfSQh9tvNYTi5tuPccPE4JK9OJaI1as87OUUZS
         imV2celYyPyoFdHWBn42a5eis5G+UlJM4iT9tEfHRWIjOW7m6OA8Pse7xEjweU2COtfm
         qePMukXjf54ZSAi1Phi/3BQh7cAnhrM8SbhR3gKN7brtxXFNd3oEnrvCrFpb/Kmz3HOh
         W/AyrcTVtoOWmfFOQgn4H/ubt1/qyM35HtCjs3aR3s2UwBtUS6EaHorY8y3zVzWkYsnc
         QYLw==
X-Gm-Message-State: AGRZ1gJjNfZpOmncspDtCQj4PlFrIbNY9D+i3HOdT7v1j/vrsYjydv9D
        MN0M98U++iRyZ7Wf7EU4vUl9Nw==
X-Google-Smtp-Source: AJdET5ftz1HxpzBHRF+qbPRHR+PeK3YpC+orO5wOj4DgwXaPFskYOmpukCIWiN6VelT3K0wpVHe5cg==
X-Received: by 2002:a5d:4c84:: with SMTP id z4-v6mr1973892wrs.75.1540371652077;
        Wed, 24 Oct 2018 02:00:52 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x185-v6sm3628943wmg.12.2018.10.24.02.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 02:00:51 -0700 (PDT)
Message-ID: <9db735d01a0f9fc3f82be6d45c88c4b98362d062.camel@baylibre.com>
Subject: Re: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
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
Date:   Wed, 24 Oct 2018 11:00:50 +0200
In-Reply-To: <153997220960.53599.2059896905852359614@swboyd.mtv.corp.google.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
         <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
         <153988282130.5275.17528969137837015544@swboyd.mtv.corp.google.com>
         <01d07c83-b17e-70b5-6e9b-8150ee3aedf2@amlogic.com>
         <153997220960.53599.2059896905852359614@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-19 at 11:03 -0700, Stephen Boyd wrote:
> Quoting Jianxin Pan (2018-10-19 09:12:53)
> > On 2018/10/19 1:13, Stephen Boyd wrote:
> > > Quoting Jianxin Pan (2018-10-17 22:07:25)
> > > > diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
> > > > index 305ee30..f96314d 100644
> > > > --- a/drivers/clk/meson/clk-regmap.c
> > > > +++ b/drivers/clk/meson/clk-regmap.c
> > > > @@ -113,8 +113,25 @@ static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
> > > >                                   clk_div_mask(div->width) << div->shift, val);
> > > >  };
> > > >  
> > > > -/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
> > > > +static void clk_regmap_div_init(struct clk_hw *hw)
> > > > +{
> > > > +       struct clk_regmap *clk = to_clk_regmap(hw);
> > > > +       struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> > > > +       unsigned int val;
> > > > +       int ret;
> > > > +
> > > > +       ret = regmap_read(clk->map, div->offset, &val);
> > > > +       if (ret)
> > > > +               return;
> > > >  
> > > > +       val &= (clk_div_mask(div->width) << div->shift);
> > > > +       if (!val)
> > > > +               regmap_update_bits(clk->map, div->offset,
> > > > +                                  clk_div_mask(div->width) << div->shift,
> > > > +                                  clk_div_mask(div->width));
> > > > +}
> > > > +
> > > > +/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
> > > 
> > > We should add a patch to rename the symbol for qcom, i.e.
> > > qcom_clk_regmap_div_ro_ops, and then any symbols in this directory
> > > should be meson_clk_regmap_div_ro_ops.
> > 
> > "/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */"
> > This comment is not introduced in this patch.
> > I followed the naming style in this file and add clk_regmap_divider_with_init_ops.
> > 
> > @Jerome， What's your suggestion about this？
> 
> Yes you don't need to fix anything in this series. Just saying that in
> the future we should work on cleaning this up.


Well, first, I wonder why such a change ends up in a patch that is supposed to
add a controller.

If such a change was really required to implement a generic div (which I doubt)
it would need to be in separate with clear explanation.

Stephen,
I agree at some point we should squash the different regmap implementations and
provide generic (enough) implementation. There is not only qcom and meson, some
other controllers are redefining regmap ops and I bet driver outside of
drivers/clk/* could use a generic implementation as well.



