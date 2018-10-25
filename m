Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DADECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CEB2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tDJxRyk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CEB2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbeJZFc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:32:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40743 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeJZFc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:32:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id m15so9094958otl.7;
        Thu, 25 Oct 2018 13:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMib3xz+/sI/w+YLQARiFuEuZ58V0av7KTOzoyfVeWQ=;
        b=tDJxRyk9KbFTIBfzNUZPAffyVahK2Ck8niFSkGoMKyoB6VIx7bctpllx1+WnnUr1Q6
         2vQf++rPtz5rrudRiJmwsfhbs90KIaLbnNI8N27ggPMMznBXcvJ1Q73z8aRIXo/dj6Bk
         p02OrcGqVWjAjEIivceR8Mcu4xO5AEGBddd7vOvfv9jv+6YFUWFAuf42+iYsWvx9qcYr
         bL5X/TqAzo9MyDdDMCPe5zW5rGXWKRetjxLJz7XMfGWEr9sc1txRF6dvCok+rDyanvnE
         L8s/f/Jf6eRi5sW1VUkmlbKQr4vHm/PJYc7w9iYvluVTZRkcpWOvLr9ecSP+edMMdLsZ
         7xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMib3xz+/sI/w+YLQARiFuEuZ58V0av7KTOzoyfVeWQ=;
        b=THqB3omIrVNNNzDk9PmjN7A1RGgsONp94WnWRypI6bGVZKELc3SaiSsCmmmcLMzI2d
         iKW5cpcM3OiFUKX0//rgdGp0KxSs2VPUaJDNysi2qZWiio1ff323SBWJmhGOevBF6Sfl
         lP5whPbb/tB0duw5hcLftcZRaAJcS31nC7KrYW0temEXNcTCwLLd63Ik9rfeMsGfzlVC
         fnCRuQntHR0dCRaHZsWeiWBOHSYwA2DTMgTh5lke47taxTcRD6PT/wITP+VDHed3bQBU
         IE2C9rNdoj0FvtQxxhQwCv/izhqs8OOB8LlSQLKQIxlrF/VFiBnjtyusAYIsAcRX/2nP
         ctsw==
X-Gm-Message-State: AGRZ1gLaBGC7A6PhBAawcS8d1IDbUcB3urf7vpfP1iy3rJhtOnTEw1Wp
        ZG7rJkoDNWhWrpj0Hw4IEyrhxo9OcfPUbdBA4Wo=
X-Google-Smtp-Source: AJdET5dTLpXyEl5ZTBs6xjFGk27z5DU8oHk7mKPECqbKLvXVSQeQpV9q1FTGHahdBP11E7eo1lwX904rBRJDEn4RLfE=
X-Received: by 2002:a9d:624b:: with SMTP id i11mr504052otk.232.1540501121162;
 Thu, 25 Oct 2018 13:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
 <a8d359208edfdc75cb5c6de378796f76e0572a0f.camel@baylibre.com>
 <eda2faf2-cf06-902d-36ff-48ceafcb4a4b@amlogic.com> <f4d239df2f1333b005680f9bfdd2eba93e7f86e5.camel@baylibre.com>
In-Reply-To: <f4d239df2f1333b005680f9bfdd2eba93e7f86e5.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 25 Oct 2018 22:58:30 +0200
Message-ID: <CAFBinCCuqUmVNdwUm7WbkHy1eWvOA5oQ5FcOuytbYNbgGcXnRQ@mail.gmail.com>
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

On Thu, Oct 25, 2018 at 2:54 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
[snip]
> > > > +static void clk_regmap_div_init(struct clk_hw *hw)
> > > > +{
> > > > + struct clk_regmap *clk = to_clk_regmap(hw);
> > > > + struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> > > > + unsigned int val;
> > > > + int ret;
> > > > +
> > > > + ret = regmap_read(clk->map, div->offset, &val);
> > > > + if (ret)
> > > > +         return;
> > > >
> > > > + val &= (clk_div_mask(div->width) << div->shift);
> > > > + if (!val)
> > > > +         regmap_update_bits(clk->map, div->offset,
> > > > +                            clk_div_mask(div->width) << div->shift,
> > > > +                            clk_div_mask(div->width));
> > >
> > > This is wrong for several reasons:
> > > * You should hard code the initial value in the driver.
> > > * If shift is not 0, I doubt this will give the expected result.
> >
> > The value 0x00 of divider means nand clock off then read/write nand register is forbidden.
>
> That is not entirely true, you can access the clock register or you'd be in a
> chicken and egg situation.
>
> > Should we set the initial value in nand driver, or in sub emmc clk driver?
>
> In the nand driver, which is the consumer of the clock. see my previous comments
> about it.
an old version of this series had the code still in the NAND driver
(by writing to the registers directly instead of using the clk API).
this looks pretty much like a "sclk-div" to me (as I commented in v3
of this series: [0]):
- value 0 means disabled
- positive divider values
- (probably no duty control, but that's optional as far as I
understand sclk-div)
- uses max divider value when enabling the clock

if switching to sclk-div works then we can get rid of some duplicate code


Regards
Martin


[0] https://patchwork.kernel.org/patch/10607157/#22238243
