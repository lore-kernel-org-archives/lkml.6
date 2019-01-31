Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0829EC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E036E2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbfAaIeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:34:07 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54503 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725855AbfAaIeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:34:07 -0500
X-UUID: eee3f772c72d419aaf49d938c26b3e55-20190131
X-UUID: eee3f772c72d419aaf49d938c26b3e55-20190131
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 803466532; Thu, 31 Jan 2019 16:33:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 16:33:55 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 16:33:55 +0800
Message-ID: <1548923635.25380.4.camel@mtksdaap41>
Subject: Re: [PATCH 4/6] mfd: Add support for the MediaTek MT6358 PMIC
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Pi-Hsun Shih <pihsun@chromium.org>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Thu, 31 Jan 2019 16:33:55 +0800
In-Reply-To: <CANdKZ0csqmTFj7+03yRAM25z4jGEQYQvOuSWggDY81spGqhgfA@mail.gmail.com>
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1548839891-20932-5-git-send-email-hsin-hsiung.wang@mediatek.com>
         <CANdKZ0csqmTFj7+03yRAM25z4jGEQYQvOuSWggDY81spGqhgfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pi-Hsun,

On Thu, 2019-01-31 at 11:56 +0800, Pi-Hsun Shih wrote:
> On Wed, Jan 30, 2019 at 5:19 PM Hsin-Hsiung Wang
> <hsin-hsiung.wang@mediatek.com> wrote:
> >
> > This adds support for the MediaTek MT6358 PMIC. This is a
> > multifunction device with the following sub modules:
> >
> > - Regulator
> > - RTC
> > - Codec
> > - Interrupt
...
> > +static const struct mfd_cell mt6358_devs[] = {
> > +       {
> > +               .name = "mt6358-regulator",
> > +               .of_compatible = "mediatek,mt6358-regulator"
> > +       }, {
> > +               .name = "mt6397-rtc",
> 
> Should this be "mt6358-rtc"?

Because MT6358 rtc uses the same rtc driver as MT6397, the name should
be "mt6397-rtc" for rtc driver probe.

Thanks a lot.
> > +               .num_resources = ARRAY_SIZE(mt6358_rtc_resources),
> > +               .resources = mt6358_rtc_resources,
> > +               .of_compatible = "mediatek,mt6358-rtc",
> > +       }, {
> > +               .name = "mt6358-sound",
> > +               .of_compatible = "mediatek,mt6358-sound"
> > +       },
> > +};
...
> > --
> > 1.9.1
> >


