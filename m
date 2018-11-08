Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5326ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964CB20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964CB20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeKHXpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:45:16 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39511 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbeKHXpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:45:16 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EC7002080C; Thu,  8 Nov 2018 15:09:34 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id C0F4E206A1;
        Thu,  8 Nov 2018 15:09:34 +0100 (CET)
Date:   Thu, 8 Nov 2018 15:09:35 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/7] clocksource: rework Atmel TCB timer driver
Message-ID: <20181108140935.GI21694@piout.net>
References: <20180913113024.3571-1-alexandre.belloni@bootlin.com>
 <5f19043a-3be3-e25a-849f-6ca610ed6da2@linaro.org>
 <20180925201456.GD3112@piout.net>
 <20181108124327.iqdiif6atfrxdkef@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181108124327.iqdiif6atfrxdkef@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2018 13:43:27+0100, Sebastian Andrzej Siewior wrote:
> On 2018-09-25 22:14:56 [+0200], Alexandre Belloni wrote:
> > On 22/09/2018 13:29:48+0200, Daniel Lezcano wrote:
> > > You say for rt the PIT is not suitable because of the shared irq but in
> > > the driver, the interrupt is flagged as shared.
> > > 
> > 
> > Well, it is not simply sharing the interrupt that is an issue, it is the
> > mismatch between the PIT and the UART interrupt flags and that only
> > happens when using preempt-rt.
> 
> This should also happen on !RT with the threadedirq command line switch.
> The UART will be threaded and the PIT will not, and this is the problem.
> So we need to split those or disable the UART. The other important thing
> for RT is the higher resolution of the clocksource/clockevents device (I
> don't know if this is part of the series or not…).
> 

It is not part of that series as I prefer to keep the discussion of how
to configure that for later. This has been raised previously without any
conclusion and I'd really like to see this rework enter upstream soon.

> I'm currently replacing the v6 with this v7 in my RT tree. What is the
> status of this series upstream wise?
> 

I'll send v8 sometimes next week.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
