Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83209C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C8E22EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C8E22EBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964770AbeF0Ju0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:50:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49191 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753449AbeF0JuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:50:25 -0400
X-UUID: abdc6476b1c04e1a8430cae8c7d158e4-20180627
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1679511433; Wed, 27 Jun 2018 17:50:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 27 Jun 2018 17:50:16 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 27 Jun 2018 17:50:16 +0800
Message-ID: <1530093016.17448.35.camel@mtkswgap22>
Subject: Re: [PATCH v2 2/2] clocksource/drivers/mtk_systimer: Add support
 for Mediatek SoCs
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Wed, 27 Jun 2018 17:50:16 +0800
In-Reply-To: <2a40ec95-7352-f0c4-b394-d7b689de98ec@linaro.org>
References: <1530086039-3763-1-git-send-email-stanley.chu@mediatek.com>
         <1530086039-3763-3-git-send-email-stanley.chu@mediatek.com>
         <2a40ec95-7352-f0c4-b394-d7b689de98ec@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 11:39 +0200, Daniel Lezcano wrote:
> On 27/06/2018 09:53, Stanley Chu wrote:
> > This patch adds a new clock event for the timer
> > found on the Mediatek SoCs.
> > 
> > The Mediatek System Timer has several 32-bit timers.
> > Only one timer is used by this driver as a clock event
> > supporting oneshot events.
> > 
> > The System Timer can be run with two clocks. A 13 MHz system
> > clock and the RTC clock running at 32 KHz. This implementation
> > uses the system clock with no clock source divider.
> 
> Recent platforms have the arch_arm_timer and it will be always selected.
> 
> What is the benefit of adding this timer ?
> 
> 
Hi Daniel,

To save power as much as possible, our platform enables
"arch_timer_c3stop" in arch_arm_timer, and thus another always-on timer
is required for tick-broadcasting. System Timer is introduced for above
purpose.

Thanks.
Stanley Chu


