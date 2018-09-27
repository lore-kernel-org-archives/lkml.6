Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ABCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02D221531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02D221531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeI0H2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:28:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12279 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726453AbeI0H2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:28:15 -0400
X-UUID: 376c4ff9cd22407285c90421c02925a5-20180927
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1479363521; Thu, 27 Sep 2018 09:12:25 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs01n2.mediatek.inc
 (172.21.101.79) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Sep
 2018 09:12:13 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Sep 2018 09:12:12 +0800
Message-ID: <1538010732.27607.25.camel@mhfsdcap03>
Subject: Re: [PATCH v3 1/3] spis: mediatek: add bindings for Mediatek MT2712
 soc platform
From:   lei liu <leilk.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <yt.shen@mediatek.com>
Date:   Thu, 27 Sep 2018 09:12:12 +0800
In-Reply-To: <20180926223318.GA18703@bogus>
References: <1537150762-7072-1-git-send-email-leilk.liu@mediatek.com>
         <1537150762-7072-2-git-send-email-leilk.liu@mediatek.com>
         <20180926223318.GA18703@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6E47E54D0FB39F0A6DB5DE98BB1ADE0D35771B34CD872C5C4C659E792213D2912000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-26 at 17:33 -0500, Rob Herring wrote:
> On Mon, Sep 17, 2018 at 10:19:20AM +0800, Leilk Liu wrote:
> > This patch adds a DT binding documentation for the MT2712 soc.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >  .../devicetree/bindings/spi/spi-slave-mt27xx.txt   |   32 ++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
> > new file mode 100644
> > index 0000000..09cb2c4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
> > @@ -0,0 +1,32 @@
> > +Binding for MTK SPI Slave controller
> > +
> > +Required properties:
> > +- compatible: should be one of the following.
> > +    - mediatek,mt2712-spi-slave: for mt2712 platforms
> > +- reg: Address and length of the register set for the device.
> > +- interrupts: Should contain spi interrupt.
> > +- clocks: phandles to input clocks.
> > +  It's clock gate, and should be <&infracfg CLK_INFRA_AO_SPI1>.
> > +- clock-names: should be "spi" for the clock gate.
> > +
> > +Optional properties:
> > +- assigned-clocks: it's mux clock, should be <&topckgen CLK_TOP_SPISLV_SEL>.
> > +- assigned-clock-parents: parent of mux clock.
> > +  It's PLL, and should be on of the following.
> 
> s/on/one/
> 
> With that fixed,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Yes, it's a mistake, I'll fix it, thanks


