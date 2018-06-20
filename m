Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC675C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2BE20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2BE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbeFTAST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:18:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53347 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753644AbeFTASP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:18:15 -0400
X-UUID: 905c31c909fa4d269f033ba9d37e0c80-20180620
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 706182493; Wed, 20 Jun 2018 08:18:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 20 Jun 2018 08:18:07 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 20 Jun 2018 08:18:07 +0800
Message-ID: <1529453887.8701.0.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: add mt6765 support
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, CC Hwang <cc.hwang@mediatek.com>,
        "Loda Chou" <loda.chou@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        "Jades Shih" <jades.shih@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Wed, 20 Jun 2018 08:18:07 +0800
In-Reply-To: <80bca2ae-eb08-3d6c-a863-140107286b2d@gmail.com>
References: <1528843243-29782-1-git-send-email-mars.cheng@mediatek.com>
         <1528843243-29782-3-git-send-email-mars.cheng@mediatek.com>
         <80bca2ae-eb08-3d6c-a863-140107286b2d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias

On Fri, 2018-06-15 at 10:54 +0200, Matthias Brugger wrote:
> 
> On 13/06/18 00:40, Mars Cheng wrote:
> > +
> > +	uart0: serial@11002000 {
> > +		compatible = "mediatek,mt6765-uart",
> > +			     "mediatek,mt6577-uart";
> > +		reg = <0 0x11002000 0 0x400>;
> > +		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&uart_clk>;
> > +		status = "disabled";
> > +	};
> 
> You need "baud" and "bus" clock. Also add clock-names please.

Got it, will add them in V2

> 
> > +
> > +	uart1: serial@11003000 {
> > +		compatible = "mediatek,mt6765-uart",
> > +			     "mediatek,mt6577-uart";
> > +		reg = <0 0x11003000 0 0x400>;
> > +		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&uart_clk>;
> > +		status = "disabled";
> 
> Same here obviously.

Will fixed in V2.

Thanks.
> 
> Regards,
> Matthias


