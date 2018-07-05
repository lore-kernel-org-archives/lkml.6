Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DEEC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C3722535
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C3722535
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeGEWyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:54:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:19463 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753151AbeGEWxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:53:00 -0400
X-UUID: 1c1ac107b3f84c1f8a4fce3befdd1634-20180706
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 186235412; Fri, 06 Jul 2018 06:52:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 6 Jul 2018 06:52:50 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 6 Jul 2018 06:52:50 +0800
Message-ID: <1530831170.17448.82.camel@mtkswgap22>
Subject: Re: [PATCH v7 1/5] clocksource/drivers/timer-mediatek: Add system
 timer bindings
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Fri, 6 Jul 2018 06:52:50 +0800
In-Reply-To: <20180705211552.GA3699@rob-hp-laptop>
References: <1530752972-833-1-git-send-email-stanley.chu@mediatek.com>
         <1530752972-833-2-git-send-email-stanley.chu@mediatek.com>
         <20180705211552.GA3699@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-05 at 15:15 -0600, Rob Herring wrote:
> On Thu, Jul 05, 2018 at 09:09:28AM +0800, Stanley Chu wrote:

Hi Rob,

> > +- reg: Should contain location and length for timer register.
> > +- clocks: Both timers are driven by system clock.
> 
> The binding just needs to say how many clocks, what they are and the 
> order.
> 
> You need to explain in the commit message why you remove the RTC clock.

OK! Will fix binding description and commit message in v8.

RTC clock is not used in both "GPT" and "SYST" driver now so we just
remove it.

> 
> >  
> >  Examples:
> >  
> > @@ -21,5 +27,5 @@ Examples:
> >  		compatible = "mediatek,mt6577-timer";
> >  		reg = <0x10008000 0x80>;
> >  		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
> > -		clocks = <&system_clk>, <&rtc_clk>;
> > -	};
> > +		clocks = <&system_clk>;
> > +	};
> > \ No newline at end of file
> 
> Fix this.

Will fix it in v8.

Thanks.
Stanley Chu

> 
> > -- 
> > 1.7.9.5
> > 


