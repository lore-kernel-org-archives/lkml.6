Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389F8C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A4526974
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A4526974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934306AbeFZLXy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:23:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56450 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932544AbeFZLXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:23:51 -0400
X-UUID: 9b3cccbf2e804714a49edc6ef6d7e1df-20180626
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1558188118; Tue, 26 Jun 2018 19:23:46 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 26 Jun 2018 19:23:43 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 26 Jun 2018 19:23:43 +0800
Message-ID: <1530012223.17380.2.camel@mtkswgap22>
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: add mt6765 support
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Jades Shih <jades.shih@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        "My Chuang" <my.chuang@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 26 Jun 2018 19:23:43 +0800
In-Reply-To: <86h8lq6l1r.wl-marc.zyngier@arm.com>
References: <1529978646-28976-1-git-send-email-mars.cheng@mediatek.com>
         <1529978646-28976-3-git-send-email-mars.cheng@mediatek.com>
         <86h8lq6l1r.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

On Tue, 2018-06-26 at 08:53 +0100, Marc Zyngier wrote:
> On Tue, 26 Jun 2018 03:04:06 +0100,
> Mars Cheng <mars.cheng@mediatek.com> wrote:
> > 
> > This adds basic chip support for MT6765 SoC.
> > 
> > Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
> >  arch/arm64/boot/dts/mediatek/mt6765-evb.dts |   33 ++++++
> >  arch/arm64/boot/dts/mediatek/mt6765.dtsi    |  158 +++++++++++++++++++++++++++
> >  3 files changed, 192 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt6765.dtsi b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
> > new file mode 100644
> > index 0000000..ab34c0f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
> 
> [...]
> 
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <GIC_PPI 13
> > +			     (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 14
> > +			     (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 11
> > +			     (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 10
> > +			     (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> 
> GICv3 doesn't encode the PPI affinity in its interrupt specifiers (or
> at least not this way). Please drop it.

Got it, will fix it.

> 
> > +	};
> > +
> > +	soc {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		compatible = "simple-bus";
> > +		ranges;
> > +
> > +		sysirq: intpol-controller@10200a80 {
> > +			compatible = "mediatek,mt6765-sysirq",
> > +				     "mediatek,mt6577-sysirq";
> > +			interrupt-controller;
> > +			#interrupt-cells = <3>;
> > +			interrupt-parent = <&gic>;
> > +			reg = <0 0x10200a80 0 0x50>;
> > +		};
> > +
> > +		gic: interrupt-controller@0c000000 {
> > +			compatible = "arm,gic-v3";
> > +			#interrupt-cells = <3>;
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			#redistributor-regions = <1>;
> 
> A single redistributor is the default, and you don't need to specify
> it in the DT.
> 

sure, it's really unnecessary. will remove it.

> > +			interrupt-parent = <&gic>;
> > +			interrupt-controller;
> > +			reg = <0 0x0c000000 0 0x40000>, // distributor
> > +			      <0 0x0c100000 0 0x200000>; // redistributor
> 
> How about the GICv2 compatibility regions, which are provided by the
> CPUs at a fixed offset from PERIPHBASE? See the Cortex-A53 TRM for
> detail, and please add the missing regions.
> 

Thanks. will add it soon.

> > +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +		};
> 
> Thanks,
> 
> 	M.
> 


