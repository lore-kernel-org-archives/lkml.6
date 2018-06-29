Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E69C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2851827A7F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2851827A7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967503AbeF2AKk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:10:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22429 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S966977AbeF2AKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:10:39 -0400
X-UUID: 538c32ceadf54d879038a322f41a56f2-20180629
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 151838566; Fri, 29 Jun 2018 08:10:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 29 Jun 2018 08:10:27 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 29 Jun 2018 08:10:27 +0800
Message-ID: <1530231027.17448.46.camel@mtkswgap22>
Subject: Re: [PATCH v3 4/5] clocksource/drivers/timer-mediatek: Convert the
 driver to timer-of
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Fri, 29 Jun 2018 08:10:27 +0800
In-Reply-To: <5cdfbfdf-4d6e-de18-0f20-2f3b50129b87@linaro.org>
References: <1530182744-10731-1-git-send-email-stanley.chu@mediatek.com>
         <1530182744-10731-5-git-send-email-stanley.chu@mediatek.com>
         <5cdfbfdf-4d6e-de18-0f20-2f3b50129b87@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 16:03 +0200, Daniel Lezcano wrote:
> >  
> > -struct mtk_clock_event_device {
> > -	void __iomem *gpt_base;
> > -	u32 ticks_per_jiffy;
> > -	struct clock_event_device dev;
> > +struct mtk_timer_private {
> > +	unsigned long ticks_per_jiffy;
> >  };
> 
> This private structure is not needed. There is timer_of_clk->period
> 
> cf.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/timer-of.c#n144
> 
> 
Hi Daniel,

Thanks for remind:)
Will fix it in v4.

Thanks.
Stanley Chu



