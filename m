Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A7BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 03:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38A7206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 03:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeLQDTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 22:19:37 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:30235 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726267AbeLQDTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 22:19:37 -0500
X-UUID: d027a9763a93496286e9c67df70b3b12-20181217
X-UUID: d027a9763a93496286e9c67df70b3b12-20181217
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 527681582; Mon, 17 Dec 2018 11:19:30 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 17 Dec
 2018 11:19:29 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Dec 2018 11:19:28 +0800
Message-ID: <1545016768.29293.13.camel@mhfsdcap03>
Subject: Re: [PATCH] eint: add gpio vritual number select
From:   Chuanjia Liu <Chuanjia.Liu@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hongkun Cao =?UTF-8?Q?=28=E6=9B=B9=E6=B4=AA=E5=9D=A4=29?= 
        <Hongkun.Cao@mediatek.com>,
        Youlin Pei =?UTF-8?Q?=28=E8=A3=B4=E5=8F=8B=E6=9E=97=29?= 
        <youlin.pei@mediatek.com>,
        Eddie Huang =?UTF-8?Q?=28=E9=BB=83=E6=99=BA=E5=82=91=29?= 
        <eddie.huang@mediatek.com>,
        Zhiyong Tao =?UTF-8?Q?=28=E9=99=B6=E5=BF=97=E5=8B=87=29?= 
        <Zhiyong.Tao@mediatek.com>,
        Hailong Fan =?UTF-8?Q?=28=E8=8C=83=E6=B5=B7=E9=BE=99=29?= 
        <Hailong.Fan@mediatek.com>
Date:   Mon, 17 Dec 2018 11:19:28 +0800
In-Reply-To: <CAGp9LzrTZjEPLKEB+OwSVbLx=KBQRFVmN41KDqj_xTJ5oyU0KQ@mail.gmail.com>
References: <1544693783-25079-1-git-send-email-chuanjia.liu@mediatek.com>
         <CAGp9LzrTZjEPLKEB+OwSVbLx=KBQRFVmN41KDqj_xTJ5oyU0KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-14 at 03:51 +0800, Sean Wang wrote:
> And the subject should be also corrected with prefix starting with
> "pinctrl: mediatek:", typo fixup, and having a better subject close to
> the content.
I will change it in next patch.
> On Thu, Dec 13, 2018 at 1:36 AM <chuanjia.liu@mediatek.com> wrote:
> >
> > From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> >
> > This patch add gpio vritual number select,avoid virtual gpio set SMT.
> >
> > Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> > ---
> >  drivers/pinctrl/mediatek/mtk-eint.h              |    1 +
> >  drivers/pinctrl/mediatek/pinctrl-mt8183.c        |    1 +
> >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |    9 ++++++---
> >  3 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
> > index 48468d0..c16beaf 100644
> > --- a/drivers/pinctrl/mediatek/mtk-eint.h
> > +++ b/drivers/pinctrl/mediatek/mtk-eint.h
> > @@ -37,6 +37,7 @@ struct mtk_eint_hw {
> >         u8              ports;
> >         unsigned int    ap_num;
> >         unsigned int    db_cnt;
> > +       unsigned int    vir_start;
> >  };
> >
> >  struct mtk_eint;
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > index 6262fd3..bbeafd3 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > +++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> > @@ -497,6 +497,7 @@
> >         .ports     = 6,
> >         .ap_num    = 212,
> >         .db_cnt    = 13,
> > +       .vir_start = 180,
> >  };
> >
> >  static const struct mtk_pin_soc mt8183_data = {
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > index 4a9e0d4..ca3bae1 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > @@ -289,9 +289,12 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
> >         if (err)
> >                 return err;
> >
> > -       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> > -       if (err)
> > -               return err;
> > +       if (gpio_n < hw->eint->hw->vir_start) {
> > +               err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> > +                                      MTK_ENABLE);
> > +               if (err)
> > +                       return err;
> > +       }
> >
> >         return 0;
> >  }
> > --
> > 1.7.9.5


