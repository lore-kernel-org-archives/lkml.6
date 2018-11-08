Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6D9C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8CC2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8CC2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeKHWSw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:18:52 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43688 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeKHWSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:18:52 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKjeh-0006zL-Ph; Thu, 08 Nov 2018 13:43:27 +0100
Date:   Thu, 8 Nov 2018 13:43:27 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/7] clocksource: rework Atmel TCB timer driver
Message-ID: <20181108124327.iqdiif6atfrxdkef@linutronix.de>
References: <20180913113024.3571-1-alexandre.belloni@bootlin.com>
 <5f19043a-3be3-e25a-849f-6ca610ed6da2@linaro.org>
 <20180925201456.GD3112@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180925201456.GD3112@piout.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-25 22:14:56 [+0200], Alexandre Belloni wrote:
> On 22/09/2018 13:29:48+0200, Daniel Lezcano wrote:
> > You say for rt the PIT is not suitable because of the shared irq but in
> > the driver, the interrupt is flagged as shared.
> > 
> 
> Well, it is not simply sharing the interrupt that is an issue, it is the
> mismatch between the PIT and the UART interrupt flags and that only
> happens when using preempt-rt.

This should also happen on !RT with the threadedirq command line switch.
The UART will be threaded and the PIT will not, and this is the problem.
So we need to split those or disable the UART. The other important thing
for RT is the higher resolution of the clocksource/clockevents device (I
don't know if this is part of the series or not…).

I'm currently replacing the v6 with this v7 in my RT tree. What is the
status of this series upstream wise?

Sebastian
