Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBB0ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD0C2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HL2yqyRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD0C2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbeKETFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:05:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37463 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeKETFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:05:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so7311585wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 01:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=W+jU3ISQdjTakmeCbYjMZy9WEccEjRzxGZFCCng+FrM=;
        b=HL2yqyROLgAi8GWc4bdvjyXr67fLc6gwr6WCISMjDvWL5gZG6KFUVIAlfGabWJb9MK
         RT41MZC8YSu4oPbaQGBg5ZUE7Mzsw35pbO0d8kTvUHrxFdhw9xpfMelp8E/WzU6sY0mP
         l5rORIw80VEUd8QqEjehmrv0VZ+gEwAcLpcxQRvRform6+rEyisOFTXxhR9XQTAzKrLk
         KSOSkGHY3bSm1nEKViyEjaZR8ITsBJXhK6MvPOE6c5HBBQGesX0evbdbcbmeaYjN48TL
         IdHNhHkE+cF3IQwadtzzhXWbfF/nTC8Znm9Wkb7ArycqOLWXniyBFeK1BA63tRSM+PNt
         DY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=W+jU3ISQdjTakmeCbYjMZy9WEccEjRzxGZFCCng+FrM=;
        b=To4SUAo4JakBGiIMn6nyR1v6MeTx8HH0O3TKdXvkqBl1vy4x9IMX7mvbD9wZEakrR2
         QTGjFLLbLx709mdx2BzLB0Y0/90kOOrwm94/6VcwQxqnEzUbg0MqBfdpgi7XvwSF8j3U
         sJk6Euum9BekNvSr0pnh3X61nLMvm8jQU8stdnzG+BJW+ibz5rqY5COk3g0peeptHYVA
         N45wVROpTlj9oph08JmSuu4AZUtTy5USPw+CtOFTgbFVdFDF2jGD++fYXYKvQeuADMmv
         o7tkgvfqKG38BX1sjsOU8wRcodq3fPGeRSSR+CQ7U5IGv1moDfpM6mRtiB3+vux4QB9z
         K3MQ==
X-Gm-Message-State: AGRZ1gLJvWSEfH5o3tMGn50mE33qgtxDwPLZBVxxbd2P8OkNy3k4/Pmt
        Ao5sr133PVMzRjkGLY0G8usoOA==
X-Google-Smtp-Source: AJdET5e20DVRXOakNh7GhbuvsqONCkmnVh5y/BcPK59TkD2mCE3WS+ZUzVdlMu/TJkrHmRUjrE3FKg==
X-Received: by 2002:a1c:3e84:: with SMTP id l126-v6mr5396890wma.91.1541411198397;
        Mon, 05 Nov 2018 01:46:38 -0800 (PST)
Received: from boomer.baylibre.com (uluru.liltaz.com. [163.172.81.188])
        by smtp.gmail.com with ESMTPSA id s206-v6sm4117053wms.29.2018.11.05.01.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 01:46:37 -0800 (PST)
Message-ID: <bba47660e7d48c391caad8214570e81527624662.camel@baylibre.com>
Subject: Re: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
From:   jbrunet@baylibre.com
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, yixun.lan@amlogic.com,
        khilman@baylibre.com, carlo@caione.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh@kernel.org, miquel.raynal@bootlin.com,
        boris.brezillon@bootlin.com, liang.yang@amlogic.com,
        jian.hu@amlogic.com, qiufang.dai@amlogic.com,
        hanjie.lin@amlogic.com, victor.wan@amlogic.com,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 05 Nov 2018 10:46:36 +0100
In-Reply-To: <66c2915a-4ecd-8a6e-6493-4318ae7bb620@amlogic.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
         <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
         <a8d359208edfdc75cb5c6de378796f76e0572a0f.camel@baylibre.com>
         <eda2faf2-cf06-902d-36ff-48ceafcb4a4b@amlogic.com>
         <f4d239df2f1333b005680f9bfdd2eba93e7f86e5.camel@baylibre.com>
         <CAFBinCCuqUmVNdwUm7WbkHy1eWvOA5oQ5FcOuytbYNbgGcXnRQ@mail.gmail.com>
         <3723695d951e0d30e8a0117d336d8f268269a030.camel@baylibre.com>
         <66c2915a-4ecd-8a6e-6493-4318ae7bb620@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-04 at 02:01 +0800, Jianxin Pan wrote:
> Hi Jerome,
> 
> Thanks for the review, we really appreciate your time.
> 
> I'm very sorry maybe I don't catch all your meaning very well. 
> 
> Please see my comments below.
> 
> On 2018/10/29 3:16, Jerome Brunet wrote:
> > On Thu, 2018-10-25 at 22:58 +0200, Martin Blumenstingl wrote:
> > > Hi Jerome,
> > > 
> > > On Thu, Oct 25, 2018 at 2:54 PM Jerome Brunet <jbrunet@baylibre.com>
> > > wrote:
> > > [snip]
> > > > > > > +static void clk_regmap_div_init(struct clk_hw *hw)
> > > > > > > +{
> > > > > > > + struct clk_regmap *clk = to_clk_regmap(hw);
> > > > > > > + struct clk_regmap_div_data *div =
> > > > > > > clk_get_regmap_div_data(clk);
> > > > > > > + unsigned int val;
> > > > > > > + int ret;
> > > > > > > +
> > > > > > > + ret = regmap_read(clk->map, div->offset, &val);
> > > > > > > + if (ret)
> > > > > > > +         return;
> > > > > > > 
> > > > > > > + val &= (clk_div_mask(div->width) << div->shift);
> > > > > > > + if (!val)
> > > > > > > +         regmap_update_bits(clk->map, div->offset,
> > > > > > > +                            clk_div_mask(div->width) << div-
> > > > > > > >shift,
> > > > > > > +                            clk_div_mask(div->width));
> > > > > > 
> > > > > > This is wrong for several reasons:
> > > > > > * You should hard code the initial value in the driver.
> > > > > > * If shift is not 0, I doubt this will give the expected result.
> > > > > 
> > > > > The value 0x00 of divider means nand clock off then read/write nand
> > > > > register is forbidden.
> > > > 
> > > > That is not entirely true, you can access the clock register or you'd
> > > > be in a
> > > > chicken and egg situation.
> > > > 
> > > > > Should we set the initial value in nand driver, or in sub emmc clk
> > > > > driver?
> > > > 
> > > > In the nand driver, which is the consumer of the clock. see my
> > > > previous comments
> > > > about it.
> > > 
> > > an old version of this series had the code still in the NAND driver
> > > (by writing to the registers directly instead of using the clk API).
> > > this looks pretty much like a "sclk-div" to me (as I commented in v3
> > > of this series: [0]):
> > > - value 0 means disabled
> > > - positive divider values
> > > - (probably no duty control, but that's optional as far as I
> > > understand sclk-div)
> > > - uses max divider value when enabling the clock
> > > 
> > > if switching to sclk-div works then we can get rid of some duplicate
> > > code
> > 
> > It is possible:
> > There is a couple of things to note though:
> > 
> > * sclk does not 'uses max divider value when enabling the clock': Since
> > this
> > divider can gate, it needs to save the divider value when disabling, since
> > the
> > divider value is no longer stored in the register,
> > On init, this cached value is  saved as it is. If the divider is initially
> > disabled, we have to set the cached value to something that makes sense,
> > in case
> > the clock is enabled without a prior call to clk_set_rate().
> > > So in sclk, the clock setting is not changed nor hard coded in init, and
> > > this is
> > a very important difference.
> > 
> I think It's ok for the latest sub mmc clock and nand driver now:
> 1. in mmc_clkc_register_clk_with_parent("div", ...) from mmc_clkc_probe():
>    cached_div is set to div_max durning clk register，but is not set to div
> hw register.
> 
> 2. In meson nand driver v6: 	
> https://lore.kernel.org/lkml/1541090542-19618-3-git-send-email-jianxin.pan@amlogic.com
> 1) In meson_nfc_clk_init() from probe:   get clock handle, then
> prepare_enable and set default rate.
>    nfc->device_clk = devm_clk_get(nfc->dev, "device");
>    ret = clk_prepare_enable(nfc->device_clk);			//Here div hw
> register changed from 0 -> cached_div.
>    default_clk_rate = clk_round_rate(nfc->device_clk, 24000000);
>    ret = clk_set_rate(nfc->device_clk, default_clk_rate);	//Then
> register and cached_div are both updated to the default 24M.
> 2) In meson_nfc_select_chip(), set the actual frequency
>   ret = clk_set_rate(nfc->device_clk, meson_chip->clk_rate);	//Here
> register and cached_div are changed again.
> 3) if clk_disable() is called, set div hw register to zero, and
> cached_div  keep unchagned.
>    if clk_disable() is called again,  cached_div is restored to div hw
> register.

You don't need to do all this in your NAND driver: enable - round - set_rate -
disable is a waste of time. 

Directly calling set_rate(24000000), with the clock still off, will have the
same result. Then if your HW needs this clock to be ON to access registers
(like you told us) you should probably turn it on.

> 
> When enabling the clock, divider register does not need to be div_max.  
> Any value is OK except ZERO, the cached_div from init or set_rate is ok
> >  
> > * Even if sclk zero value means gated, it is still a zero based divider,
> > while
> > eMMC/Nand divider is one based. It this controller was to sclk, then
> > something
> > needs to be done for this.
> Could I add another patch to this patchset for sclk to support
> CLK_DIVIDER_ONE_BASED ?

Yes, you should otherwise the calculation are just wrong for your clock.

> > * Since sclk caches a value in its data, and there can multiple instance
> > of eMMC
> > /NAND clock controller, some care must be taken when registering the data.
> OK, I will fix it and alloc mmc_clkc_div_data danymicly durning probe.
> Thank you. 
> > Both the generic divider and sclk could work here ... it's up to you
> > Jianxin.
> > 
> == Why use meson_sclk_div_ops instead of clk_regmap_divider_ops?
> The default divider hw register vaule is 0 when system power on.
> Then there is a WARNING in divider_recalc_rate() durning clk_hw_register():
> [    0.918238] ffe05000.clock-controller#div: Zero divisor and
> CLK_DIVIDER_ALLOW_ZERO not set
> [    0.925581] WARNING: CPU: 3 PID: 1 at drivers/clk/clk-divider.c:127
> divider_recalc_rate+0x88/0x90
> Then I still need to hard code the initual value to nand driver without
> CLK_DIVIDER_ALLOW_ZERO flags.
> > > 
> > > Regards
> > > Martin
> > > 
> > > 
> > > [0] https://patchwork.kernel.org/patch/10607157/#22238243
> > 
> > .
> > 
> 
> 


