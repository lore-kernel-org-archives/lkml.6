Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A429ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B021A2084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B021A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeGUIUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 04:20:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59683 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727251AbeGUIUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 04:20:51 -0400
X-UUID: f410e4f938cc42fd82930e08245d58cd-20180721
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1567957997; Sat, 21 Jul 2018 15:28:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 21 Jul 2018 15:28:54 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 21 Jul 2018 15:28:54 +0800
Message-ID: <1532158134.16009.10.camel@mtksdaap41>
Subject: Re: [PATCH v3 0/4] Add basic support for Mediatek MT8183 SoC
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        "Jason Cooper" <jason@lakedaemon.net>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <mars.cheng@mediatek.com>, <linux-serial@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sat, 21 Jul 2018 15:28:54 +0800
In-Reply-To: <2ca76468-198b-b764-c974-374e567e0c93@gmail.com>
References: <1526538126-51497-1-git-send-email-erin.lo@mediatek.com>
         <9ba45353-a6e1-9a6e-f05b-4b1679ae9e52@gmail.com>
         <1532074769.19148.2.camel@mtksdaap41>
         <2ca76468-198b-b764-c974-374e567e0c93@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-20 at 12:44 +0200, Matthias Brugger wrote:
> 
> On 20/07/18 10:19, Erin Lo wrote:
> > On Mon, 2018-07-16 at 11:28 +0200, Matthias Brugger wrote:
> >> Hi Erin,
> >>
> >> On 17/05/18 08:22, Erin Lo wrote:
> >>> MT8183 is a SoC based on 64bit ARMv8 architecture.
> >>> It contains 4 CA53 and 4 CA73 cores.
> >>> MT8183 share many HW IP with MT65xx series.
> >>> This patchset was tested on MT8183 evaluation board, and boot to shell ok.
> >>>
> >>> This series contains document bindings, device tree including interrupt, uart.
> >>>
> >>> Change in v3:
> >>> 1. Fill out GICC, GICH, GICV regions
> >>> 2. Update Copyright to 2018
> >>>
> >>> Change in v2:
> >>> 1. Split dt-bindings into different patches
> >>> 2. Correct bindings for supported SoCs (mtk-uart.txt)
> >>>
> >>> Ben Ho (1):
> >>>   arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and
> >>>     Makefile
> >>>
> >>> Erin Lo (3):
> >>>   dt-bindings: arm: Add bindings for Mediatek MT8183 SoC Platform
> >>>   dt-bindings: mtk-sysirq: Add compatible for Mediatek MT8183
> >>>   dt-bindings: serial: Add compatible for Mediatek MT8183
> >>>
> >>
> >> I'm a bit reluctant to take this series, as it will only enable the EVB board to
> >> boot into a serial console. Are you planning to add support for other devices of
> >> this SoC?
> >>
> >> Apart please take into account that there is an issue with the dts file, as you
> >> were told by the kbuild test robot.
> >>
> >> Regards,
> >> Matthias
> >>
> > 
> > Hi, Matthias
> > Sorry for missing this letter...since mail proxy server.
> > We plan to add support all the devices of MT8183 in serious.
> > We have implemented the clock and pinctrl driver for upstream and they
> > are in internal review right now.
> > 
> 
> Nice to hear that :)
> 
> > About the dts issue... do you suggest me to send new patch right now or
> > wait for clock and pinctrl driver ready then send them together?
> > 
> 
> I would prefer that you send at least the clock controller together, so that we
> don't have any dummy clocks in the basic device tree.
> 
> Regards,
> Matthias
> 

Got it! Next patch, we will send them with clock controller without
dummy clocks in the basic device tree.
By the way, the clock controller driver of MT8183 is a little bit
different from former ICs, so we need more time to prepare them.
We will send them to public as soon as possible.

Best Regards,
Erin

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


