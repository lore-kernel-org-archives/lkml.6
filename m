Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88BFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F3220857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F3220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbeGaLay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:30:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47975 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729784AbeGaLax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:30:53 -0400
X-UUID: 0d6b2ce08f8f4b6baf6ec83b2c2a6b41-20180731
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1010374874; Tue, 31 Jul 2018 17:51:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 31 Jul 2018 17:51:14 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 31 Jul 2018 17:51:14 +0800
Message-ID: <1533030674.13386.7.camel@mtkswgap22>
Subject: RE: Re: [PATCH v1 1/2] arm64: dts: mt7622: add some misc device
 nodes
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 31 Jul 2018 17:51:14 +0800
In-Reply-To: <1533026633.10540.20.camel@mtkswgap22>
References: <2ff39c40ef6bc3054667e63c785a1d28527b5ddf.1531753039.git.ryder.lee@mediatek.com>
         <864955d5-26c4-a5f3-ec1a-420acba50880@gmail.com>
         <2839886f07dc47afb9a05d06fb1acc84@mtkmbs08n1.mediatek.inc>
         <1533026633.10540.20.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-31 at 16:43 +0800, Ryder Lee wrote:
> Hi Matthias,
> 
> Sorry for the late reply.
> 
> On Tue, 2018-07-31 at 16:17 +0800, Ryder Lee (李庚諺) wrote:
> > Hi Ryder,
> > 
> > On 16/07/18 16:59, Ryder Lee wrote:
> > > Add some misc nodes support - timer and ARM CCI-400.
> > > 
> > > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > > ---
> > >  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 36 
> > > ++++++++++++++++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi 
> > > b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > > index 9213c96..8cdec52 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > > @@ -217,6 +217,16 @@
> > >  		#reset-cells = <1>;
> > >  	};
> > >  
> > > +	timer: timer@10004000 {
> > > +		compatible = "mediatek,mt7622-timer",
> > > +			     "mediatek,mt6577-timer";
> > > +		reg = <0 0x10004000 0 0x80>;
> > > +		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
> > > +		clocks = <&infracfg CLK_INFRA_APXGPT_PD>,
> > > +			 <&topckgen CLK_TOP_RTC>;
> > > +		clock-names = "system-clk", "rtc-clk";
> > > +	};
> > > +
> > >  	scpsys: scpsys@10006000 {
> > >  		compatible = "mediatek,mt7622-scpsys",
> > >  			     "syscon";
> > > @@ -317,6 +327,32 @@
> > >  		      <0 0x10360000 0 0x2000>;
> > >  	};
> > >  
> > > +	cci: cci@10390000 {
> > > +		compatible = "arm,cci-400";
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +		reg = <0 0x10390000 0 0x1000>;
> > > +		ranges = <0 0 0x10390000 0x10000>;
> > 
> > From my understanding of the binding description ranges should hold child address, parent address and size of the region in the child address space. I can see in arch/arm64 two different variants using 4 ranges values (like here) and using three values.
> > 
> > @Rob + Will what is the preferred way to describe this?
> 
> Hmmm... it's just a copy-paste (I take zynqmp.dtsi as an example).
> > > +
> > > +		cci_control0: slave-if@1000 {
> > > +			compatible = "arm,cci-400-ctrl-if";
> > > +			interface-type = "ace-lite";
> > > +			reg = <0x1000 0x1000>;
> > > +		};
> > 
> > Don't we need to add phandles to the cci-control-port property in the cpu nodes?

I forgot to answer this question in previous mail.

Yes, we need it. I will add the cci-control-port property in the cpu
nodes and add the child node PMU in cci-400 - somehow I forgot to add
them.

Thanks for your reminder.

> > Regards,
> > Matthias
> 
> MT7622 use cci-400 to improve performance (DMA IO coherence) for
> high-speed IPs. (i.e., ETH/WIFI/SATA/...)
> 
> I added it early but actually the related features have not supported in
> mainline yet.
> 
> Ryder


