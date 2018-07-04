Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458BDC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE67824731
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE67824731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932702AbeGDBti (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 21:49:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5738 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932364AbeGDBtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 21:49:36 -0400
X-UUID: 846812f1f7174b4698f8db9db0f95365-20180704
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 478152159; Wed, 04 Jul 2018 09:49:30 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 4 Jul 2018 09:49:27 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 4 Jul 2018 09:49:27 +0800
Message-ID: <1530668967.17448.55.camel@mtkswgap22>
Subject: Re: [PATCH v4 1/5] clocksource/drivers/timer-mediatek: Add system
 timer bindings
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Wed, 4 Jul 2018 09:49:27 +0800
In-Reply-To: <20180703233256.GA27424@rob-hp-laptop>
References: <1530231446-13760-1-git-send-email-stanley.chu@mediatek.com>
         <1530231446-13760-2-git-send-email-stanley.chu@mediatek.com>
         <20180703233256.GA27424@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 17:32 -0600, Rob Herring wrote:

Hi Rob,

> > +- reg: Should contain location and length for GPT register.
> > +- clocks: GPT is drived by system clock.
> 
> s/drived/driven/

Will be fixed in v5.

> 
> >  
> >  Examples:
> >  
> > @@ -21,5 +29,23 @@ Examples:
> >  		compatible = "mediatek,mt6577-timer";
> >  		reg = <0x10008000 0x80>;
> >  		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
> > -		clocks = <&system_clk>, <&rtc_clk>;
> > +		clocks = <&system_clk>;
> > +	};
> > +
> > +
> > +** System Timer (SYST)
> > +
> > +Required properties:
> > +- compatible: Should contain
> > +	* "mediatek,mt6765-timer" for MT6765 compatible timers
> > +- reg: Should contain the location and length for system timer registers.
> > +- clocks: System timer is drived by system clock.
> 
> These look the same. Can't you just add the compatible string and note 
> in the description it is the system timer. Or make the compatible 
> "mediatek,mt6765-systimer"
> 

OK! We will simplify it and just use the same compatible string.

> > +
> > +Examples:
> > +
> > +	systimer@10017000 {
> 
> timer@

As above, will be fixed in v5.

> 
> > +		compatible = "mediatek,mt6765-timer";
> > +		reg = <0 0x10017000 0 0x1000>;
> > +		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&system_clk>;
> >  	};
> > -- 
> > 1.7.9.5
> > 

Thanks.
Stanley Chu


