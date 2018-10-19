Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826E8ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412AE2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412AE2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeJSXdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:33:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39570 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeJSXdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:33:05 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gDWfV-0001Z8-Av; Fri, 19 Oct 2018 17:26:29 +0200
Date:   Fri, 19 Oct 2018 17:26:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Lukas Wunner <lukas@wunner.de>
cc:     linux-kernel@vger.kernel.org,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Akshay Bhat <akshay.bhat@timesys.com>,
        Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
Subject: Re: [PATCH] genirq: Fix race on spurious interrupt detection
In-Reply-To: <20181019152307.62t6al6ney5ofo36@wunner.de>
Message-ID: <alpine.DEB.2.21.1810191725220.6075@nanos.tec.linutronix.de>
References: <1dfd8bbd16163940648045495e3e9698e63b50ad.1539867047.git.lukas@wunner.de> <alpine.DEB.2.21.1810191554030.6075@nanos.tec.linutronix.de> <20181019152307.62t6al6ney5ofo36@wunner.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018, Lukas Wunner wrote:
> On Fri, Oct 19, 2018 at 04:31:30PM +0200, Thomas Gleixner wrote:
> > I doubt that this can happen in reality, so I'd rather reword that
> > paragraph slightly:
> > 
> >   In theory high CPU load and in the presence of higher priority tasks, the
> >   number of incorrectly detected spurious interrupts might increase beyond
> >   the 99,900 threshold and cause disablement of the interrupt.
> > 
> >   In practice it just increments the spurious interrupt count. But that can
> >   cause people to waste time investigating it over and over.
> > 
> > Hmm?
> 
> Sure, fine by me.  Would you prefer me to resend with that change or
> can you fold it in when applying?

I'll fold it. No problem.

> FWIW I did manage to reach the 99,900 threshold once because I had
> added copious amounts of printk() to the hi3110 IRQ thread to debug
> another issue.  But I never experienced that without those printk()'s.

Cute.

Thanks

	tglx
