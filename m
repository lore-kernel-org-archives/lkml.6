Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2F0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9888B2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZR0WGkzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9888B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeJ3Ef4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:35:56 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37121 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeJ3Ef4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:35:56 -0400
Received: by mail-oi1-f193.google.com with SMTP id w66-v6so3929914oiw.4;
        Mon, 29 Oct 2018 12:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+P+YyHQN4mbzIEI8gj6PxHxuqBpIjDzGExY1dBY+9d4=;
        b=ZR0WGkzWU75PY8YKcHoqeSHCE2QzOKCRQphzI2WtlaVsXOUKtRKMGlJI/OLbzhfTmV
         6bulfiIJHwh0zHl3SDZmIiAIQ6V/Ak6Pm6hWWykhdf6NLPY3LH3dLDmcnWwnFDTXrxjb
         q+n3+O7YTlqLoEKYc+NIZxXl281uTlPMs5eciFPfY+isNqRV1xX60OiqqEZTpirSyv6z
         cuqEhBqLJr0NQfvekoLk462AbnZI2DuJYo7AYkS66sX06Uo/UuSy5C9SjkxH+bGUqwut
         pjj4wXp+m5BGrCIGTr7RqTR4cyYPUHBenklsNifS0ho+oKQh2JzShCH929m/YzSJUOce
         Q6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+P+YyHQN4mbzIEI8gj6PxHxuqBpIjDzGExY1dBY+9d4=;
        b=at1r8Zn0SH373L8PwllmBTBTlDr6qozrYXGEYj2Q5h3+s5bGpdiJPr/2mB6chSrKNu
         td3mktyZsWWr2RDjkhrmtuD9TWFLNmAfTRuhILNzPXPz6KFVsGjaJWE/6NLZbfvfb1KN
         QfpFmH5UuN1DNSXxASnAzricq4guFnxzx6zG6tUqruEdFhDJDKZUdvctjj8/Ue1B8BbT
         zKNlPabHSAcE/RPKkCO2vxy76GozgpAPztoD3u8Hm/fmFo1Zjz3nqUPDr4SHuwg4a6Gf
         n0DPsAgbyS9NzYwe+8uGoh8fZOvYK7ZcsXft3l469nbXZO3zjdQHtmkSoepoM5i8JAbC
         PBww==
X-Gm-Message-State: AGRZ1gL5OibHEN09T8be7JhV3HWQBWGypFadfkWH861ZW4lEitPs9xUa
        VRZMk0hx2+yZ884sIdw3tCA0nfIGYJlSfLM3Bj8=
X-Google-Smtp-Source: AJdET5f148hjpSoY5MEOJi9uus5q8o/KGxeQasLdb4cWdTXBeo7UlegKeKdZOXdGewwGlp8WMRhkx69t/NJmeQev4vM=
X-Received: by 2002:aca:e804:: with SMTP id f4-v6mr8705120oih.38.1540842348082;
 Mon, 29 Oct 2018 12:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
 <a8d359208edfdc75cb5c6de378796f76e0572a0f.camel@baylibre.com>
 <eda2faf2-cf06-902d-36ff-48ceafcb4a4b@amlogic.com> <f4d239df2f1333b005680f9bfdd2eba93e7f86e5.camel@baylibre.com>
 <CAFBinCCuqUmVNdwUm7WbkHy1eWvOA5oQ5FcOuytbYNbgGcXnRQ@mail.gmail.com> <3723695d951e0d30e8a0117d336d8f268269a030.camel@baylibre.com>
In-Reply-To: <3723695d951e0d30e8a0117d336d8f268269a030.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 29 Oct 2018 20:45:36 +0100
Message-ID: <CAFBinCDyoK0G5FoyqZq6zPZLXH+YHy+-7GBCrjuH4=LN+MpSDQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
To:     jbrunet@baylibre.com
Cc:     jianxin.pan@amlogic.com, Neil Armstrong <narmstrong@baylibre.com>,
        yixun.lan@amlogic.com, khilman@baylibre.com, carlo@caione.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        liang.yang@amlogic.com, jian.hu@amlogic.com,
        qiufang.dai@amlogic.com, hanjie.lin@amlogic.com,
        victor.wan@amlogic.com, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

many thanks for the whole explanation!

On Sun, Oct 28, 2018 at 8:16 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Thu, 2018-10-25 at 22:58 +0200, Martin Blumenstingl wrote:
> > Hi Jerome,
> >
> > On Thu, Oct 25, 2018 at 2:54 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > [snip]
> > > > > > +static void clk_regmap_div_init(struct clk_hw *hw)
> > > > > > +{
> > > > > > + struct clk_regmap *clk = to_clk_regmap(hw);
> > > > > > + struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> > > > > > + unsigned int val;
> > > > > > + int ret;
> > > > > > +
> > > > > > + ret = regmap_read(clk->map, div->offset, &val);
> > > > > > + if (ret)
> > > > > > +         return;
> > > > > >
> > > > > > + val &= (clk_div_mask(div->width) << div->shift);
> > > > > > + if (!val)
> > > > > > +         regmap_update_bits(clk->map, div->offset,
> > > > > > +                            clk_div_mask(div->width) << div->shift,
> > > > > > +                            clk_div_mask(div->width));
> > > > >
> > > > > This is wrong for several reasons:
> > > > > * You should hard code the initial value in the driver.
> > > > > * If shift is not 0, I doubt this will give the expected result.
> > > >
> > > > The value 0x00 of divider means nand clock off then read/write nand register is forbidden.
> > >
> > > That is not entirely true, you can access the clock register or you'd be in a
> > > chicken and egg situation.
> > >
> > > > Should we set the initial value in nand driver, or in sub emmc clk driver?
> > >
> > > In the nand driver, which is the consumer of the clock. see my previous comments
> > > about it.
> >
> > an old version of this series had the code still in the NAND driver
> > (by writing to the registers directly instead of using the clk API).
> > this looks pretty much like a "sclk-div" to me (as I commented in v3
> > of this series: [0]):
> > - value 0 means disabled
> > - positive divider values
> > - (probably no duty control, but that's optional as far as I
> > understand sclk-div)
> > - uses max divider value when enabling the clock
> >
> > if switching to sclk-div works then we can get rid of some duplicate code
>
> It is possible:
> There is a couple of things to note though:
>
> * sclk does not 'uses max divider value when enabling the clock': Since this
> divider can gate, it needs to save the divider value when disabling, since the
> divider value is no longer stored in the register,
> On init, this cached value is  saved as it is. If the divider is initially
> disabled, we have to set the cached value to something that makes sense, in case
> the clock is enabled without a prior call to clk_set_rate().
>
> So in sclk, the clock setting is not changed nor hard coded in init, and this is
> a very important difference.
>
> * Even if sclk zero value means gated, it is still a zero based divider, while
> eMMC/Nand divider is one based. It this controller was to sclk, then something
> needs to be done for this.
>
> * Since sclk caches a value in its data, and there can multiple instance of eMMC
> /NAND clock controller, some care must be taken when registering the data.
>
> Both the generic divider and sclk could work here ... it's up to you Jianxin.
to give even more options:
the generic divider will (probably) get a CLK_DIVIDER_ZERO_GATE flag
in the next development cycle, see [0] (this may require a small
change to clk-regmap on top)


Regards
Martin


[0] https://patchwork.kernel.org/patch/10650797/
