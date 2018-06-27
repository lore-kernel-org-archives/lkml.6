Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C2C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F018B266AB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F018B266AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933754AbeF0IxB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:53:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:17907 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933373AbeF0Iw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:52:58 -0400
X-UUID: 9e4ed661ae574183a8ee44091e535a75-20180627
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2112527978; Wed, 27 Jun 2018 16:52:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Wed, 27 Jun
 2018 16:52:45 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 27 Jun 2018 16:52:45 +0800
Message-ID: <1530089565.29697.35.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/6] dt-bindings: gpu: mali-utgard: add
 mediatek,mt7623-mali compatible
From:   Sean Wang <sean.wang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <sboyd@codeaurora.org>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <p.zabel@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Jun 2018 16:52:45 +0800
In-Reply-To: <3bd6e509-f99a-1f2d-1b66-65c414bacdbd@gmail.com>
References: <cover.1524816502.git.sean.wang@mediatek.com>
         <7ab060c2e9ef2b220fc62913b8936b706dfaf202.1524816502.git.sean.wang@mediatek.com>
         <3bd6e509-f99a-1f2d-1b66-65c414bacdbd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 17:14 +0200, Matthias Brugger wrote:
> 
> On 27/04/18 10:14, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > The MediaTek MT7623 SoC contains a Mali-450, so add a compatible for it
> > and define its own vendor-specific properties.
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> 
> Hi Rob,
> 
> Any comments regarding this patch?
> 
> Regards,
> Matthias
> 

Hi, Matthias

I've already got a Reviewed-by tag from Rob.

Is it possible that this patch go through your tree ?

	Sean

> >  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > index 99d1c0a..656068f 100644
> > --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > @@ -19,6 +19,7 @@ Required properties:
> >        + rockchip,rk3228-mali
> >        + rockchip,rk3328-mali
> >        + stericsson,db8500-mali
> > +      + mediatek,mt7623-mali
> >  
> >    - reg: Physical base address and length of the GPU registers
> >  
> > @@ -89,6 +90,14 @@ to specify one more vendor-specific compatible, among:
> >        * interrupt-names and interrupts:
> >          + combined: combined interrupt of all of the above lines
> >  
> > +  - mediatek,mt7623-mali
> > +     Required properties:
> > +      * resets: phandle to the reset line for the GPU
> > +      * mediatek,larb: phandle pointed to the local arbiter used to control the
> > +	access to external memory on the SoC.
> > +	see Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> > +	for details
> > +
> >  Example:
> >  
> >  mali: gpu@1c40000 {
> > 


