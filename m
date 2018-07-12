Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63878C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C5C20BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C5C20BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391061AbeGLAOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:14:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:16909 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390905AbeGLANL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:13:11 -0400
X-UUID: 8bc6e935f67b4c5b9cb90b84b212f988-20180712
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1555433993; Thu, 12 Jul 2018 08:06:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 12 Jul 2018 08:06:18 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 12 Jul 2018 08:06:17 +0800
Message-ID: <1531353977.25499.9.camel@mtkswgap22>
Subject: Re: [PATCH v4 1/1] arm64: dts: mediatek: add mt6765 support
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 12 Jul 2018 08:06:17 +0800
In-Reply-To: <7a3becb3-510b-5763-5b66-5e14ebf7c974@gmail.com>
References: <1531116302-29921-1-git-send-email-mars.cheng@mediatek.com>
         <1531116302-29921-2-git-send-email-mars.cheng@mediatek.com>
         <7fb13f45-4e33-6efc-467b-c7256a40cbc9@gmail.com>
         <d439eb7d-6365-7a0a-2969-1ddecc51defc@arm.com>
         <1531177443.7777.18.camel@mtkswgap22>
         <7a3becb3-510b-5763-5b66-5e14ebf7c974@gmail.com>
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

On Tue, 2018-07-10 at 12:52 +0200, Matthias Brugger wrote:
> 
> On 10/07/18 01:04, Mars Cheng wrote:
[...]

> > pmic/pwrap/i2c/rtc/kpd/spi/wdt/cqdma/auxadc/pwm/cmdq/disp. We have
> > dedicated owners to handle them and will cowork tightly with members to
> > make sure things happen in the following weeks.
> > 
> 
> Ok, so let's wait until pinctrl driver is submitted. I'd prefer if you could add
> the clk driver to this series. This way we can get rid of the dummy clocks in
> the device tree.
> 

Got it, I will submit this series with clk support in v5. and pinctrl
after that.

> > For previous chips, we did have no enough support after shell. It is due
> > to fast pace of smartphone SoC and other resource issues. We also know
> > that is no excuse so that we already confirmed owners and their
> > schedules for mt6765.
> > 
> > If there is any suggestion, please let us know.
> > 
> 
> I know that smartphone SoC is a fast paced business. Never the less I'm
> convinced that the basic building blocks won't change much from one version to
> another. And that mainline support for the previous version of your SoC will
> help you to get your new drivers faster upstream.
> 
> For me the best example is the mt7622 which got to a reasonable upstream support
> quite fast, thanks to a good foundation of mt7623 in mainline. I'd love to see
> that happen on the smartphone SoCs as well.
> 
> Not to mention that upstream support will help you internally when you have to
> rebase your BSP code-base to a new kernel version.
> 
> That said I think it is good news that you have already defined owner for the
> different devices and hope to see submissions for them in the near future :)
> As a suggestion I would say that upstream submission takes time and effort and
> it will help your engineers if they can allocate some time to do so. But that's
> most probably a management decision and all engineers know that management bases
> it's decision on some hard-to-understandable abbreviations like EBITDA etc. ;)
> 
> Best regards,
> Matthias

Thanks for your suggestions. We will try to catch up on this mission :-)


