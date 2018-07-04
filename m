Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66BEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5F8246F6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5F8246F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933826AbeGDHsD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:48:03 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57742 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932322AbeGDHsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:48:00 -0400
X-UUID: 945e0421d35c4f349949281f0c3d831f-20180704
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1263528952; Wed, 04 Jul 2018 15:47:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 4 Jul 2018 15:47:53 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 4 Jul 2018 15:47:53 +0800
Message-ID: <1530690473.16183.3.camel@mtkswgap22>
Subject: Re: [PATCH v3 4/4] arm64: dts: mediatek: add mt6765 support
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "CC Hwang" <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 4 Jul 2018 15:47:53 +0800
In-Reply-To: <f482708c-ea5e-5d81-a176-d69be9ccdf63@arm.com>
References: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
         <1530669174-17623-5-git-send-email-mars.cheng@mediatek.com>
         <f482708c-ea5e-5d81-a176-d69be9ccdf63@arm.com>
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

On Wed, 2018-07-04 at 08:35 +0100, Marc Zyngier wrote:
> On 04/07/18 02:52, Mars Cheng wrote:
> > This adds basic chip support for MT6765 SoC.
> > 
> > Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
> >  arch/arm64/boot/dts/mediatek/mt6765-evb.dts |   33 ++++++
> >  arch/arm64/boot/dts/mediatek/mt6765.dtsi    |  155 +++++++++++++++++++++++++++
> >  3 files changed, 189 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
> > 
> 
> [...]
> 
> > +
> > +		gic: interrupt-controller@c000000 {
> > +			compatible = "arm,gic-v3";
> > +			#interrupt-cells = <3>;
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			#redistributor-regions = <1>;
> > +			interrupt-parent = <&gic>;
> > +			interrupt-controller;
> > +			reg = <0 0x0c000000 0 0x40000>, // distributor
> > +			      <0 0x0c100000 0 0x200000>, // redistributor
> > +			      <0 0x0c400000 0 0x40000>; // gicc
> 
> For the second time: please add *all* the GIC CPU interface regions,
> described in the Cortex-A53 TRM[1] (GICC, GICH, and GICV).
> 

MT6765 has no GICH/GICV/ITS in mediatek design. Have confirmed with our
designer.  

MT6797 had similar question from you. Sorry for not mentioned it first.

http://lists.infradead.org/pipermail/linux-mediatek/2017-February/008074.html

Thanks.
> Thanks,
> 
> 	M.
> 
> [1]
> https://urldefense.proofpoint.com/v2/url?u=http-3A__infocenter.arm.com_help_topic_com.arm.doc.ddi0500g_ch09s02s01.html&d=DwICaQ&c=X9NHckmGz7LNQmqtvpDCYVnn6eFXNivfZeknqiAo-n0&r=Ph_SbcClVGRWmGxVhfr-5CZF9ffiUOE7TZ47ns4ROh4&m=9L01qJc7apuzwLobX_nhN0ik8IFdu_X7hJ139x5dNNw&s=0zeZXtWPeITLj01RSxAQ6NfNkTUu9Il0Dddgk07-6QA&e= 


