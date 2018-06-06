Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C254601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932551AbeFFJes (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:34:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49226 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932381AbeFFJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:34:47 -0400
Date: Wed, 6 Jun 2018 11:34:43 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Pingfan Liu <kernelfans@gmail.com>
cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: question about the limited interrupt vector resource on a single
 cpu
In-Reply-To: <CAFgQCTsqbv2nwAwcvv6hW9mbaWRE251jroMSLM5891VYsr=bMw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806061133450.1579@nanos.tec.linutronix.de>
References: <CAFgQCTudugoNc26P22V+G_awzj2srKHhWBJubFoa7-K=cDtQyw@mail.gmail.com> <alpine.DEB.2.21.1806061114290.1584@nanos.tec.linutronix.de> <CAFgQCTsqbv2nwAwcvv6hW9mbaWRE251jroMSLM5891VYsr=bMw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018, Pingfan Liu wrote:

> On Wed, Jun 6, 2018 at 5:15 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Wed, 6 Jun 2018, Pingfan Liu wrote:
> >
> >> For x86, there is around 200 vectors left for external device on a
> >> single logic cpu.
> >>
> >> Is there any case that we exhaust them in real world, and is it worth to fix?
> >
> > Exhaustion is unlikely, but how would you fix it? The vector space per CPU
> > is limited by hardware not software.
> >
> Playing some trick on iommu, we can use it to identify the irq requester.

But what's the point? If you have more than 200 device interrupts on a
single CPU, then you surely have other problems than that.

What kind of problem are you trying to solve?

Thanks,

	tglx
