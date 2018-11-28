Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA65DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F962081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F962081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeK2CRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:17:52 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60164 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeK2CRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:17:52 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gS1Z8-0008KJ-EV; Wed, 28 Nov 2018 16:15:50 +0100
Date:   Wed, 28 Nov 2018 16:15:50 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Muchun Song <smuchun@gmail.com>
cc:     John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timers: Make the lower-level timer function first call
 than higher-level
In-Reply-To: <alpine.DEB.2.21.1811212143030.1665@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1811281614220.1532@nanos.tec.linutronix.de>
References: <20181119141003.6470-1-smuchun@gmail.com> <CALAqxLUUpGfDzOoDyPA4LFyzFyVmiT4wKLUWa5Tin8eypJBCDQ@mail.gmail.com> <CAPSr9jFVDaXUZw0LKEX81TrCmeQ+tw1bt0g_tK7J1s9qtOdEwg@mail.gmail.com> <alpine.DEB.2.21.1811212143030.1665@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song,

On Wed, 21 Nov 2018, Thomas Gleixner wrote:
> On Tue, 20 Nov 2018, Muchun Song wrote:
> > Follow the current code logic, the timer0 function is called until the
> > function call of timer1-5 is completed. So the delay of timer0 is the time
> > spent by other timer function calls. If we can call the timer function in
> > the following order, this should be more friendly to lower-level timers.
> > 
> >         timer0->timer1->->timer2->->timer3->->timer4->->timer5
> > 
> > Although not friendly to higher-level timers, higher-level has larger
> > granularity. Therefore the delay has less impact on higher-level.
> 
> Well yes, that's clear. But is it a problem in practice and if so, what is
> the measurable benefit.

Polite reminder. Can you please describe what the practical relevance is of
that and what real world problem you are solving? Ideally with numbers
backing it up.

Thanks,

	tglx
