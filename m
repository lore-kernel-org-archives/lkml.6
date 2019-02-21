Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F214C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264AE2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfBUNcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:32:23 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:53573 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725920AbfBUNcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:32:23 -0500
X-UUID: 46b41c7d59e8457f8dce94b5b87c8662-20190221
X-UUID: 46b41c7d59e8457f8dce94b5b87c8662-20190221
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 176447282; Thu, 21 Feb 2019 21:32:12 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 21:32:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 21:32:09 +0800
Message-ID: <1550755929.30363.26.camel@mhfsdcap03>
Subject: Re: [PATCH v4 2/3] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
From:   Qii Wang <qii.wang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsa@the-dreams.de>, <devicetree@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <robh@kernel.org>,
        <leilk.liu@mediatek.com>, <xinping.qian@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <liguo.zhang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 21 Feb 2019 21:32:09 +0800
In-Reply-To: <e9d544c8-576d-f52c-d805-90d695b7ed46@gmail.com>
References: <1550666030-30211-1-git-send-email-qii.wang@mediatek.com>
         <1550666030-30211-3-git-send-email-qii.wang@mediatek.com>
         <e9d544c8-576d-f52c-d805-90d695b7ed46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-20 at 16:25 +0100, Matthias Brugger wrote:
> 
> On 20/02/2019 13:33, Qii Wang wrote:
> > Add MT8183 i2c binding to binding file. Compare to MT2712 i2c
> > controller, MT8183 has different registers, offsets, and clock.
> > 
> > Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > index ee4c324..da2fa60 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > @@ -12,14 +12,15 @@ Required properties:
> >        "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
> >        "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek MT7629
> >        "mediatek,mt8173-i2c": for MediaTek MT8173
> > +      "mediatek,mt8183-i2c": for MediaTek MT8183
> >    - reg: physical base address of the controller and dma base, length of memory
> >      mapped region.
> >    - interrupts: interrupt number to the cpu.
> >    - clock-div: the fixed value for frequency divider of clock source in i2c
> >      module. Each IC may be different.
> >    - clocks: clock name from clock manager
> > -  - clock-names: Must include "main" and "dma", if enable have-pmic need include
> > -    "pmic" extra.
> > +  - clock-names: Must include "main" and "dma", "arb" is optional, if enable
> > +    have-pmic need include "pmic" extra.
> 
> You have to mention that the arb clock is only necessary for mt8183.
> 

Arb clock is not only necessary for mt8183. When two i2c controllers are
internally connected to the same GPIO pins, the arb clock is needed to
ensure that the waveforms do not interfere with each other.
Maybe ""arb" is for multi-master" is better. Not all i2c controller have
multi-master.

> >  
> >  Optional properties:
> >    - clock-frequency: Frequency in Hz of the bus when transfer, the default value
> > 


