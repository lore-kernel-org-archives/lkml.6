Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ACAC64E79
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 03:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B3021773
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 03:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbeLYDkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 22:40:45 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:31214 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725806AbeLYDkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 22:40:45 -0500
X-UUID: a667d26d997f4fc5a6d8be18d49074c8-20181225
X-UUID: a667d26d997f4fc5a6d8be18d49074c8-20181225
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1806135897; Tue, 25 Dec 2018 11:40:36 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Dec
 2018 11:40:35 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Dec 2018 11:40:34 +0800
Message-ID: <1545709234.17628.1.camel@mhfsdcap03>
Subject: Re: [PATCH v2] pinctrl:mediatek:add judgment conditions
From:   Chuanjia Liu <Chuanjia.Liu@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhiyong Tao =?UTF-8?Q?=28=E9=99=B6=E5=BF=97=E5=8B=87=29?=" 
        <Zhiyong.Tao@mediatek.com>,
        "Eddie Huang =?UTF-8?Q?=28=E9=BB=83=E6=99=BA=E5=82=91=29?=" 
        <eddie.huang@mediatek.com>,
        "Hailong Fan =?UTF-8?Q?=28=E8=8C=83=E6=B5=B7=E9=BE=99=29?=" 
        <Hailong.Fan@mediatek.com>,
        "Youlin Pei =?UTF-8?Q?=28=E8=A3=B4=E5=8F=8B=E6=9E=97=29?=" 
        <youlin.pei@mediatek.com>
Date:   Tue, 25 Dec 2018 11:40:34 +0800
In-Reply-To: <CAGp9Lzoo6bw-3Hr56rgbL6EhrRvXX2y5pajaOo13c5MV9FsO7Q@mail.gmail.com>
References: <1545100282-15756-1-git-send-email-chuanjia.liu@mediatek.com>
         <CAGp9Lzoo6bw-3Hr56rgbL6EhrRvXX2y5pajaOo13c5MV9FsO7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-23 at 02:50 +0800, Sean Wang wrote:
> On Mon, Dec 17, 2018 at 6:32 PM <chuanjia.liu@mediatek.com> wrote:
> >
> 
> I thought the subject still is much general, it should be further
> improved with something like "add EINT support to virtual GPIOs" and
> should say more about what virtual GPIOs means by MTKers in the patch
> description because "virtual" is a usual term used throughout the
> kernel and that would easily cause others to fail to interpret
> correctly.
> 
Thank you for your advice,I will modify subject and description.
> > From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> >
> > This patch avoid return err when virtual gpio set SMT.
> >
> > Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> > ---
> > change note:
> > v2 : 1. delete virtual gpio number
> >      2. add judgment conditions
> > ---
> >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > index 4a9e0d4c2bbc..a576e417744a 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > @@ -290,7 +290,11 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
> >                 return err;
> >
> >         err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> > -       if (err)
> > +
> > +       /* SMT doesn't support virtual GPIO, add err != -ENOTSUPP is used for
> > +        * avoid return err when virtual gpio set SMT.
> > +        */
> 
> I'd prefer to the comments as the below
> 
> /*
> SMT is supposed to be supported by every real GPIO and doesn't support
> virtual GPIOs, so the extra condition err != -ENOTSUPP is just for
> adding EINT support to these virtual GPIOs. It should add an extra
> flag in the pin descriptor when more pins with distinctive
> characteristic come out.
> */
> 
Thank you for your advice,I will modify comments.
> > +       if (err && err != -ENOTSUPP)
> >                 return err;
> >
> >         return 0;
> > --
> > 2.19.1
> >


