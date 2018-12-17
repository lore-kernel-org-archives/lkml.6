Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C272DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A70021836
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545033597;
	bh=4E0nw7zHo+hT4FOivCKZFno0wGpLhHdHPlV05qNtUDA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I0Fbm/Dya4RD4rDwsBZ0LW94c6blCzsckoQ/sxHGpzi5qwgrjcHzNKT0pzNaaSmwW
	 d5Hm+kVpkrr36tnyNEUKJVW9ZQjE7qRNzphyWlWQ/1xu2RAnIlyXT9IaTKh2L9lFK8
	 7O2Fb8gOJPiugyD+h29RFGBoibRHBswWEqzhPKIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbeLQH74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:59:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbeLQH74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:59:56 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4114A217F5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545033594;
        bh=4E0nw7zHo+hT4FOivCKZFno0wGpLhHdHPlV05qNtUDA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qeaCyJ47aSLL3TuGQD6QGsXBwltLvX7S94dqSxpSRc0wb7i9V3+iLNB95ccADcGEM
         i0Yujt5arBQvY5vAXAf9HXL0KaV9+lTtruDcTRM1IgVvo1DL35aMUxGrd0GovAVnO5
         buOhzAX3WLNyQx1a0Brrhm4biyYGpwISrb6SSHOU=
Received: by mail-wm1-f45.google.com with SMTP id m1so11324376wml.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 23:59:54 -0800 (PST)
X-Gm-Message-State: AA+aEWYyIawAl3G11sGuzGiKnKRcFh/xhyjWQHeEhMHUpOLWYABC5Qij
        YWpCXJZ99HWb9uYNmQPXFFUFplk5VLIklNkleAg=
X-Google-Smtp-Source: AFSGD/VxGVdQHnMEJ7aVYtT5Dakqrcpg/kf/HWtSnYc5hCuUUuyzbufa39ZvTrmjHF0cZQfTDB+sAz5sT9Szt9en8bc=
X-Received: by 2002:a1c:66c5:: with SMTP id a188mr10215259wmc.129.1545033592704;
 Sun, 16 Dec 2018 23:59:52 -0800 (PST)
MIME-Version: 1.0
References: <1544693783-25079-1-git-send-email-chuanjia.liu@mediatek.com>
 <CAGp9LzpcRCMWSn-u6K6+eRT=Zr8PR22Vd381miyhVYbF87N02g@mail.gmail.com> <1545016504.29293.10.camel@mhfsdcap03>
In-Reply-To: <1545016504.29293.10.camel@mhfsdcap03>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Sun, 16 Dec 2018 23:59:20 -0800
X-Gmail-Original-Message-ID: <CAGp9LzoiVQyWMbBx3X2SscnSrS5OPT2O+NbW+yq6p2qtfsnFag@mail.gmail.com>
Message-ID: <CAGp9LzoiVQyWMbBx3X2SscnSrS5OPT2O+NbW+yq6p2qtfsnFag@mail.gmail.com>
Subject: Re: [PATCH] eint: add gpio vritual number select
To:     Chuanjia.Liu@mediatek.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hongkun.cao@mediatek.com, youlin.pei@mediatek.com,
        eddie.huang@mediatek.com, zhiyong.tao@mediatek.com,
        hailong.fan@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 7:15 PM Chuanjia Liu <Chuanjia.Liu@mediatek.com> wrote:
>
> On Thu, 2018-12-13 at 11:33 -0800, Sean Wang wrote:
> > On Thu, Dec 13, 2018 at 1:36 AM <chuanjia.liu@mediatek.com> wrote:
> > >
> > > From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> > >
> > > This patch add gpio vritual number select,avoid virtual gpio set SMT.
> >
> > s/gpio/GPIO/
> > s/vritual/virtual/
> >
> > Virtual GPIOs you said here that means these pins only used inside SoC
> > and not being exported to outside SoC, right? It seems this kind of
> > pins doesn't need SMT.
> >
> Yes,virtual gpio only used inside SOC and these pins doesn't need set
> SMT
> > >
> > > Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> > > ---
> > >  drivers/pinctrl/mediatek/mtk-eint.h              |    1 +
> > >  drivers/pinctrl/mediatek/pinctrl-mt8183.c        |    1 +
> > >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |    9 ++++++---
> > >  3 files changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
> > > index 48468d0..c16beaf 100644
> > > --- a/drivers/pinctrl/mediatek/mtk-eint.h
> > > +++ b/drivers/pinctrl/mediatek/mtk-eint.h
> > > @@ -37,6 +37,7 @@ struct mtk_eint_hw {
> > >         u8              ports;
> > >         unsigned int    ap_num;
> > >         unsigned int    db_cnt;
> > > +       unsigned int    vir_start;
> > >  };
> > >
> > >  struct mtk_eint;
> > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > index 6262fd3..bbeafd3 100644
> > > --- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > +++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > @@ -497,6 +497,7 @@
> > >         .ports     = 6,
> > >         .ap_num    = 212,
> > >         .db_cnt    = 13,
> > > +       .vir_start = 180,
> > >  };
> > >
> > >  static const struct mtk_pin_soc mt8183_data = {
> > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > index 4a9e0d4..ca3bae1 100644
> > > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > @@ -289,9 +289,12 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
> > >         if (err)
> > >                 return err;
> > >
> > > -       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> > > -       if (err)
> > > -               return err;
> > > +       if (gpio_n < hw->eint->hw->vir_start) {
> > > +               err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> > > +                                      MTK_ENABLE);
> > > +               if (err)
> > > +                       return err;
> > > +       }
> >
> > The changes will break these SoCs without a properly configured vir_start.
> >
> > If SMT seems unnecessary for these kinds of virtual GPIOs pin in the
> > path, we can do it as
> >
> > err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> >                                         MTK_ENABLE);
> > /* please add comments for the exclusion condition */
> > if (err && err != -ENOTSUPP)
> >         return err;
> >
> > If there is getting much special on certain pins between SoCs, and
> > then we can consider creating a desc->flag to split logic.
>
> Yes,SMT unnecessary for these kinds of virtual GPIOS pin in the path,if
> do it as
>         err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
>                                         MTK_ENABLE);
>         if (err && err != -ENOTSUPP)
>                   return err;
> I wonder if system will lose -ENOTSUPP information when smt was not
> successfully set by real gpio?

-ENOTSUPP shouldn't happen in a real pin as SMT is supposed to be
supported by every real pin.

If it is not true or there are more special on certain pins, and then
we consider to add a flag to struct mtk_pin_desc to group these pins
with their characteristics and to split and reuse the common code flow
with the extra flag.

So for now, I thought it's enough to handle your case with adding a
few well self-explained comments for the exclusion condition. These
words help us remember we should add adding an extra flag to pin
description as one of TODO if more needs like you come out.

> >
> > >
> > >         return 0;
> > >  }
> > > --
> > > 1.7.9.5
>
>
