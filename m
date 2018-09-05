Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276AAC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C920B2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JcjZ3tvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C920B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeIEX25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:28:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeIEX25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PGaimZxywD57RYrOy6eBDgC0DslmDh+Iz7/7RHqK5uc=; b=JcjZ3tvJsCqo9YAkxd0iCHb2n
        sekaexN6RspUQJTTECHdbVtU1Q4cFKKTK1FC/4xNE92FIbCkZ/iIdRABNhb9hgSV3vToj7jGJHRpH
        J1T4hxWVLXtVKiA19hdyYc79WD1+2RvrNrbgX6Z+rC2bCfXPSoTI+yqcXAFQ0VirHORCoj1IMJmJe
        WlTDmGqUqvvrqGoJ3qEsNurKcA1JIDtvU3WT/TjRyuyopZQOB5MDoNo/wV4f2PCNMX7DdVp6ROW5z
        s6Twm/orPJe0oY15Vla/Eudtso/ZprqIEneOW9MbAF0u1hO12kJ2qGPAYtW+5++tKBeGOzAgP6BVa
        50yLpXQVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxczV-0005mq-1r; Wed, 05 Sep 2018 18:57:25 +0000
Date:   Wed, 5 Sep 2018 11:57:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/5] RISC-V: Select useful GENERIC_IRQ kconfig options
Message-ID: <20180905185724.GB15741@infradead.org>
References: <20180904124514.6290-1-anup@brainfault.org>
 <20180904124514.6290-4-anup@brainfault.org>
 <20180904185629.GC25119@infradead.org>
 <CAAhSdy3qUkDmV5deoy9x3sqdv8xTq37od6SzgF0hmN1JPThGgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy3qUkDmV5deoy9x3sqdv8xTq37od6SzgF0hmN1JPThGgw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:22:27AM +0530, Anup Patel wrote:
> I am sure we will see both Level and Edge triggered interrupts
> in RISC-V system. The MMIO device interrupts will be mostly
> Level triggered and PCI MSIs will be mapped as Edge triggered
> by MSI controller.
> 
> We should definitely select GENERIC_IRQ_SHOW_LEVEL
> so that nature of IRQ interrupt line is evident in /proc/interrupts.

Please settle the argument with Thomas and Marc on what the default
for this option should be - in the end it just shows another line
in procfs, and I see no reason for RISC-V to ever deviated from the
global Linux default here, whatever that default is.

> >> HANDLE_DOMAIN_IRQ
> >
> > We aren't using handle_domain_irq anywhere in RISC-V, no need to
> > build this.
> 
> The new RISC-V local interrupt controller driver introduced by
> this patchset uses handle_domain_irq().

So select it in the patch that needs it, not anywhere else.
