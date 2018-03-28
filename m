Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeC1K3m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:29:42 -0400
Received: from mail.thorsis.com ([92.198.35.195]:35286 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbeC1K32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:29:28 -0400
From: Alexander Dahl <ada@thorsis.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
Date: Wed, 28 Mar 2018 12:29:20 +0200
Message-ID: <4073350.0MmxRoANOi@ada>
In-Reply-To: <989df8a3-462a-c645-87f1-9f956e1b22c9@linaro.org>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com> <9761072.pX2B0LJlSJ@ada> <989df8a3-462a-c645-87f1-9f956e1b22c9@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2SATkwb006423

Hello Daniel,

Am Dienstag, 27. März 2018, 13:30:22 CEST schrieb Daniel Lezcano:
> Can you can give a rough amount for the irq rate on the timer ?

I used itop [1] now to get a rough estimate. First with kernel v4.14.29-rt25 
(fully preempt RT):

INT                NAME          RATE             MAX
 19 [ vel     tc_clkevt]   397 Ints/s     (max:   432)
 26 [      vel     eth0]     4 Ints/s     (max:    38)

Next test with kernel v4.15.13 gives (slightly slower, but non-RT):

INT                NAME          RATE             MAX
 19 [ vel     tc_clkevt]   248 Ints/s     (max:   273)
 26 [      vel     eth0]     4 Ints/s     (max:    11)

With kernel v4.16-rc7 plus this patch series and tcb as clocksource:

INT                NAME          RATE             MAX
 17 [vel     timer@fffa]  2164 Ints/s     (max:  2183)
 26 [      vel     eth0]     5 Ints/s     (max:    10)

Is this the information you wanted? If not, could you point me on how to get 
the requested irq rate?

Greets
Alex

[1] https://packages.debian.org/stretch/itop
