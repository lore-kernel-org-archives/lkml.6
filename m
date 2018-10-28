Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E3ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B90120664
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="w1gculpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B90120664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbeJ2EBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 00:01:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35234 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeJ2EBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 00:01:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id q12-v6so3201468wmq.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 12:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yqYxbWBntZOiBQ4wMXmHg9CfUSgdZlXVBTKCEUkgpB4=;
        b=w1gculpIKqxO+26u1nUQSp4Xno4hTI5Pa9iSVfbR06GSfEJxk39RnhTfELSRfPsabS
         rMS5EBARzHGVH5g1LjlABDAo/Ynr2okiXYKYZfR0z66SD2fP0AIf75oisaLFutGLaD/p
         ciDlG9Gytz8EBWafYRrVslGFP72ZgvmZK63JKEM1MEIuh/Cx8yGe7dLo7j1G91lp2ugQ
         1ilc572DtB29sM0CMgemyUhA3NiomS41G1C0N/pWYAXoC6zsmRbvrJRoRGW2NwTH/dUj
         nkTc8YPsqg3P5Vd53J5QzQOAPPfTOhGqUCA+9M/c5JC5FfNYuBN/diswg5WuMxZrQs2I
         1HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqYxbWBntZOiBQ4wMXmHg9CfUSgdZlXVBTKCEUkgpB4=;
        b=O4u4F0wZmVbYuDUP+LNLE02ch6XwHFoU4RAie+tHQWsAvaCezIlGkJheBHiZ/t0/CM
         279IvG7ZSOa1AtRioYsW3daYH67+mZcPRAKDF6jNF5YA+UhGoFkI1BUTmJIjKhEre1Bx
         1I2bZqHIjgckxgoIVYM5hErmUMWdwHOvuYbHT7worZmknOrkFx3IFAlHYdN3OSsPOXOl
         Xmx4yJnI7+g4B0o249cwQSvsRB0JU0gyqAqFFIW6ECHVWT9uMrAVrS0cBzA6AKL1cgSq
         sgzskt03QQrochCfSIsIfmnLVVGSJLKpNZo2C8hISypYE2JvmE6VaPcgVYfB1dvSAoMI
         jKkQ==
X-Gm-Message-State: AGRZ1gIL/9RxUhckXtzkivUBqtw//QXDJ4zTytiaDjG4S+3nq2XX2OCw
        8KrJYRY+5JU7g+I+LQCuwQOli8mf3bBtzg==
X-Google-Smtp-Source: AJdET5d/BFKDvSjCLTdQKX4m1vkH/W8Xt3LF2u84la379hn4j3aESJNeVWu1HZaEbY7rmO2gebY87A==
X-Received: by 2002:a1c:6382:: with SMTP id x124-v6mr3754701wmb.145.1540754175356;
        Sun, 28 Oct 2018 12:16:15 -0700 (PDT)
Received: from boomer (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id l70-v6sm30506219wma.0.2018.10.28.12.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 12:16:14 -0700 (PDT)
Message-ID: <3723695d951e0d30e8a0117d336d8f268269a030.camel@baylibre.com>
Subject: Re: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     jianxin.pan@amlogic.com, Neil Armstrong <narmstrong@baylibre.com>,
        yixun.lan@amlogic.com, khilman@baylibre.com, carlo@caione.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        liang.yang@amlogic.com, jian.hu@amlogic.com,
        qiufang.dai@amlogic.com, hanjie.lin@amlogic.com,
        victor.wan@amlogic.com, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sun, 28 Oct 2018 20:16:12 +0100
In-Reply-To: <CAFBinCCuqUmVNdwUm7WbkHy1eWvOA5oQ5FcOuytbYNbgGcXnRQ@mail.gmail.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
         <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
         <a8d359208edfdc75cb5c6de378796f76e0572a0f.camel@baylibre.com>
         <eda2faf2-cf06-902d-36ff-48ceafcb4a4b@amlogic.com>
         <f4d239df2f1333b005680f9bfdd2eba93e7f86e5.camel@baylibre.com>
         <CAFBinCCuqUmVNdwUm7WbkHy1eWvOA5oQ5FcOuytbYNbgGcXnRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 22:58 +0200, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Thu, Oct 25, 2018 at 2:54 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> [snip]
> > > > > +static void clk_regmap_div_init(struct clk_hw *hw)
> > > > > +{
> > > > > + struct clk_regmap *clk = to_clk_regmap(hw);
> > > > > + struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> > > > > + unsigned int val;
> > > > > + int ret;
> > > > > +
> > > > > + ret = regmap_read(clk->map, div->offset, &val);
> > > > > + if (ret)
> > > > > +         return;
> > > > > 
> > > > > + val &= (clk_div_mask(div->width) << div->shift);
> > > > > + if (!val)
> > > > > +         regmap_update_bits(clk->map, div->offset,
> > > > > +                            clk_div_mask(div->width) << div->shift,
> > > > > +                            clk_div_mask(div->width));
> > > > 
> > > > This is wrong for several reasons:
> > > > * You should hard code the initial value in the driver.
> > > > * If shift is not 0, I doubt this will give the expected result.
> > > 
> > > The value 0x00 of divider means nand clock off then read/write nand register is forbidden.
> > 
> > That is not entirely true, you can access the clock register or you'd be in a
> > chicken and egg situation.
> > 
> > > Should we set the initial value in nand driver, or in sub emmc clk driver?
> > 
> > In the nand driver, which is the consumer of the clock. see my previous comments
> > about it.
> 
> an old version of this series had the code still in the NAND driver
> (by writing to the registers directly instead of using the clk API).
> this looks pretty much like a "sclk-div" to me (as I commented in v3
> of this series: [0]):
> - value 0 means disabled
> - positive divider values
> - (probably no duty control, but that's optional as far as I
> understand sclk-div)
> - uses max divider value when enabling the clock
> 
> if switching to sclk-div works then we can get rid of some duplicate code

It is possible:
There is a couple of things to note though:

* sclk does not 'uses max divider value when enabling the clock': Since this
divider can gate, it needs to save the divider value when disabling, since the
divider value is no longer stored in the register,
On init, this cached value is  saved as it is. If the divider is initially
disabled, we have to set the cached value to something that makes sense, in case
the clock is enabled without a prior call to clk_set_rate().

So in sclk, the clock setting is not changed nor hard coded in init, and this is
a very important difference.
 
* Even if sclk zero value means gated, it is still a zero based divider, while
eMMC/Nand divider is one based. It this controller was to sclk, then something
needs to be done for this.

* Since sclk caches a value in its data, and there can multiple instance of eMMC
/NAND clock controller, some care must be taken when registering the data.

Both the generic divider and sclk could work here ... it's up to you Jianxin.

> 
> 
> Regards
> Martin
> 
> 
> [0] https://patchwork.kernel.org/patch/10607157/#22238243


