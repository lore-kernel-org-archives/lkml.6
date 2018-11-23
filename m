Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD90DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 01:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B9E206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 01:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B9E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439264AbeKWMcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 07:32:22 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:7604 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733028AbeKWMcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 07:32:22 -0500
X-UUID: ea271d782f1d4c2ab600bc0bf359fdbf-20181123
X-UUID: ea271d782f1d4c2ab600bc0bf359fdbf-20181123
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1413869912; Fri, 23 Nov 2018 09:50:02 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n1.mediatek.inc
 (172.21.101.55) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 23 Nov
 2018 09:50:01 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 23 Nov 2018 09:50:00 +0800
Message-ID: <1542937800.27607.27.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] spi: mediatek: Add bindings for mediatek MT7629 soc
 platform
From:   lei liu <leilk.liu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <ryder.lee@mediatek.com>
Date:   Fri, 23 Nov 2018 09:50:00 +0800
In-Reply-To: <7bc1777c-fb24-d150-c13f-658c2a33cd71@gmail.com>
References: <1542703268-17285-1-git-send-email-leilk.liu@mediatek.com>
         <1542703268-17285-2-git-send-email-leilk.liu@mediatek.com>
         <7bc1777c-fb24-d150-c13f-658c2a33cd71@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-20 at 11:28 +0100, Matthias Brugger wrote:
> 
> On 20/11/2018 09:41, Leilk Liu wrote:
> > This patch adds a DT binding documentation for the MT7629 soc.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >  .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > index 7940940..6cc4e87 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> > @@ -6,6 +6,7 @@ Required properties:
> >      - mediatek,mt2712-spi: for mt2712 platforms
> >      - mediatek,mt6589-spi: for mt6589 platforms
> >      - mediatek,mt7622-spi: for mt7622 platforms
> > +    - mediatek,mt7629-spi: for mt7629 platforms
> 
> That's ok, as you add support in the driver. As it actually doesn't change
> anything in the driver itself you could just describe the binding as something like:
> " mediatek,mt7629-spi", "mediatek,mt7622-spi": for mt7629 platforms
> 
> This way the driver will just probe the driver using the fallback (mt7622)
> compatible, but if you realize in the future that you will need to distinguish
> between the two SoCs, you can add a mt7629 compatible.
> 
> Just as information for the future :)
> 

Got it, thanks for your advice and information :)

> Regards,
> Matthias


