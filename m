Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C78BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CB120B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CB120B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeGPWBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:01:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53566 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeGPWBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:01:21 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ffB6A-0004xv-HS; Mon, 16 Jul 2018 23:32:02 +0200
Date:   Mon, 16 Jul 2018 23:32:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/ioapic: Do not unmask io_apic when interrupt is in
 progress
In-Reply-To: <CAHp75VfPa0sWRvEs9Gt9u9AP0xzE50qmx6i=fOBN016Geg-BTA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1807162331020.1693@nanos.tec.linutronix.de>
References: <20180302130436.uxv7hjruung6m5x7@linutronix.de> <alpine.DEB.2.21.1807161829090.1693@nanos.tec.linutronix.de> <CAHp75VfPa0sWRvEs9Gt9u9AP0xzE50qmx6i=fOBN016Geg-BTA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018, Andy Shevchenko wrote:
> On Mon, Jul 16, 2018 at 7:41 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > +static inline bool ioapic_prepare_move(struct irq_data *data)
> 
> > +static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
> 
> > +static inline bool ioapic_move_prepare(struct irq_data *data)
> 
> > +static inline void ioapic_move_irq(struct irq_data *data, bool masked)
> 
> Verb or noun?

Bah. prepare/finish_move() for both places ....
