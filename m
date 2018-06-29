Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F71C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604D127A86
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604D127A86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755054AbeF2APa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:15:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31059 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752515AbeF2AP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:15:28 -0400
X-UUID: 35827945cd0a45238de3ceb4918a84a8-20180629
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2081730761; Fri, 29 Jun 2018 08:15:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 29 Jun 2018 08:15:24 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 29 Jun 2018 08:15:23 +0800
Message-ID: <1530231323.17448.50.camel@mtkswgap22>
Subject: Re: [PATCH v3 1/5] clocksource/drivers/timer-mediatek: Add system
 timer bindings
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Fri, 29 Jun 2018 08:15:24 +0800
In-Reply-To: <93345c88-f880-5e2e-ae36-cf1b57df9bba@linaro.org>
References: <1530182744-10731-1-git-send-email-stanley.chu@mediatek.com>
         <1530182744-10731-2-git-send-email-stanley.chu@mediatek.com>
         <93345c88-f880-5e2e-ae36-cf1b57df9bba@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 16:08 +0200, Daniel Lezcano wrote:
> > +** System Timer (SYST)
> > +
> > +Required properties:
> > +- compatible: Should contain
> > +	* "mediatek,mt6765-systimer" for MT6765 compatible timers
> > +- reg: Should contain the location and length for system timer registers.
> > +- clocks: System timer is drived by system clock.
> > +
> > +Examples:
> > +
> > +	systimer@10017000 {
> > +		compatible = "mediatek,mt6765-systimer";
> 
> why not "mediatek,mt6765-timer" ? for consistency.
> 
Hi Daniel,

The original thought is to remind user to notice that different timer
will be used.

However it looks more clean if we use consistent name.

Will fix it in v4.

> > +		reg = <0 0x10017000 0 0x1000>;
> > +		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&system_clk>;
> >  	};
> > 
> 
> 

Thanks.
Stanley Chu

