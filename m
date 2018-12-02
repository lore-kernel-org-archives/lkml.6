Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A4AC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 12:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22222081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 12:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22222081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbeLBM3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 07:29:10 -0500
Received: from foss.arm.com ([217.140.101.70]:51386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbeLBM3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 07:29:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3347980D;
        Sun,  2 Dec 2018 04:29:06 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 899533F5A0;
        Sun,  2 Dec 2018 04:29:04 -0800 (PST)
Date:   Sun, 2 Dec 2018 12:29:00 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
Message-ID: <20181202122900.79922c91@why.wild-wind.fr.eu.org>
In-Reply-To: <CACRpkdY9-umyz=T8v0ZmfOx8tFapvDguS3B=BYAVkY73BrkxqQ@mail.gmail.com>
References: <20181120134032.31645-1-brgl@bgdev.pl>
        <20181120134032.31645-2-brgl@bgdev.pl>
        <20181120171742.gkwb4s4qbcqvnefj@pengutronix.de>
        <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
        <20181121191509.ia2vcklvx4q2rh56@pengutronix.de>
        <CAMRc=Mef_O9ANUekZaz7vP7M2PpQFjZxJBoG8EPbXt6enRPL7g@mail.gmail.com>
        <20181125211854.idnqxz4pco3r7ydr@pengutronix.de>
        <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
        <CACRpkdY9-umyz=T8v0ZmfOx8tFapvDguS3B=BYAVkY73BrkxqQ@mail.gmail.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 23:26:25 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Nov 29, 2018 at 7:14 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> > Thomas, Linus: after commit fa38869b0161 ("gpiolib: Don't support irq
> > sharing for userspace") some libgpiod tests are failing because we can
> > no longer depend on reading the value of a dummy GPIO after detecting
> > an interrupt to know the edge of the interrupt. While these interrupts
> > are triggered from debugfs and debugfs is not required to maintain
> > compatibility, I thing having a working test suite for the GPIO
> > subsystem and uAPI is worth applying these two patches and also the
> > previous one[1].
> >
> > Can we have them applied for 4.20 or are there any objections?  
> 
> I'm fine with applying them if I can just get an ACK from one of the IRQ
> maintainers (Thomas, Marc).

I'm fine with that patch, with the provision that (nitpick) the edge
field is turned into a bool instead of an int.

With that,

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
