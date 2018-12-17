Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB58C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81962133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbeLQLYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:24:44 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:54408 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726657AbeLQLYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:24:44 -0500
X-UUID: af6f1ed9a8024aada057c7fcdc1fc64a-20181217
X-UUID: af6f1ed9a8024aada057c7fcdc1fc64a-20181217
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1131579166; Mon, 17 Dec 2018 19:24:39 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 17 Dec
 2018 19:24:37 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Dec 2018 19:24:37 +0800
Message-ID: <1545045877.15380.8.camel@mhfsdcap03>
Subject: Re: [PATCH] eint: add gpio vritual number select
From:   Chuanjia Liu <Chuanjia.Liu@mediatek.com>
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>
CC:     Sean Wang <sean.wang@kernel.org>, <youlin.pei@mediatek.com>,
        <hongkun.cao@mediatek.com>, <zhiyong.tao@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <hailong.fan@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <eddie.huang@mediatek.com>, <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 17 Dec 2018 19:24:37 +0800
In-Reply-To: <1545019482.27863.8.camel@mtksdaap41>
References: <1544693783-25079-1-git-send-email-chuanjia.liu@mediatek.com>
         <CAGp9LzpcRCMWSn-u6K6+eRT=Zr8PR22Vd381miyhVYbF87N02g@mail.gmail.com>
         <1545016504.29293.10.camel@mhfsdcap03>
         <1545019482.27863.8.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-17 at 12:04 +0800, Yingjoe Chen wrote:
> On Mon, 2018-12-17 at 11:15 +0800, Chuanjia Liu wrote:
> > On Thu, 2018-12-13 at 11:33 -0800, Sean Wang wrote:
> > > On Thu, Dec 13, 2018 at 1:36 AM <chuanjia.liu@mediatek.com> wrote:
> > > >
> > > > From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> > > >
> > > > This patch add gpio vritual number select,avoid virtual gpio set SMT.
> > > 
> > > s/gpio/GPIO/
> > > s/vritual/virtual/
> > > 
> > > Virtual GPIOs you said here that means these pins only used inside SoC
> > > and not being exported to outside SoC, right? It seems this kind of
> > > pins doesn't need SMT.
> > > 
> > Yes,virtual gpio only used inside SOC and these pins doesn't need set
> > SMT
> 
> Hi,
> 
> I don't see full patch in linux-mediatek archive. Maybe you are not
> subscribed so it is rejected?
Some groups failed to send because of permission issues,I will update
new patch.
> 
> Please add this description to commit message and/or code comment.
> I think 'internal GPIO' might be a better name for this. Does the name
> 'virtual GPIO' come from datasheet?
MTKer call it virtyal gpio When some pins only used inside soc.
> 
> 
> > > >
> > > > Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> > > > ---
> > > >  drivers/pinctrl/mediatek/mtk-eint.h              |    1 +
> > > >  drivers/pinctrl/mediatek/pinctrl-mt8183.c        |    1 +
> > > >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |    9 ++++++---
> > > >  3 files changed, 8 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
> > > > index 48468d0..c16beaf 100644
> > > > --- a/drivers/pinctrl/mediatek/mtk-eint.h
> > > > +++ b/drivers/pinctrl/mediatek/mtk-eint.h
> > > > @@ -37,6 +37,7 @@ struct mtk_eint_hw {
> > > >         u8              ports;
> > > >         unsigned int    ap_num;
> > > >         unsigned int    db_cnt;
> > > > +       unsigned int    vir_start;

> Since it is about GPIO and SMT, maybe it should be added to mtk_pin_soc
> instead of mtk_eint_hw ?
> 
> Joe.C

I will delete this change,thanks
> > > >  };
> > > >
> > > >  struct mtk_eint;
> > > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > > index 6262fd3..bbeafd3 100644
> > > > --- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > > +++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > > > @@ -497,6 +497,7 @@
> > > >         .ports     = 6,
> > > >         .ap_num    = 212,
> > > >         .db_cnt    = 13,
> > > > +       .vir_start = 180,
> > > >  };
> > > >
> > > >  static const struct mtk_pin_soc mt8183_data = {
> > > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > > index 4a9e0d4..ca3bae1 100644
> > > > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > > @@ -289,9 +289,12 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
> > > >         if (err)
> > > >                 return err;
> > > >
> > > > -       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> > > > -       if (err)
> > > > -               return err;
> > > > +       if (gpio_n < hw->eint->hw->vir_start) {
> > > > +               err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> > > > +                                      MTK_ENABLE);
> > > > +               if (err)
> > > > +                       return err;
> > > > +       }
> > > 
> > > The changes will break these SoCs without a properly configured vir_start.
> > > 
> > > If SMT seems unnecessary for these kinds of virtual GPIOs pin in the
> > > path, we can do it as
> > > 
> > > err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> > >                                         MTK_ENABLE);
> > > /* please add comments for the exclusion condition */
> > > if (err && err != -ENOTSUPP)
> > >         return err;
> > > 
> > > If there is getting much special on certain pins between SoCs, and
> > > then we can consider creating a desc->flag to split logic.
> > 
> > Yes,SMT unnecessary for these kinds of virtual GPIOS pin in the path,if
> > do it as
> > 	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> >                                         MTK_ENABLE);
> > 	if (err && err != -ENOTSUPP)
> >       		  return err;
> > I wonder if system will lose -ENOTSUPP information when smt was not
> > successfully set by real gpio?
> > > 
> > > >
> > > >         return 0;
> > > >  }
> > > > --
> > > > 1.7.9.5
> > 
> > 
> > 
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
> 


