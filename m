Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5957AC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2FB20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m8McbfYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2FB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbeIJSdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:33:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeIJSdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VZOQvIcR/kpoQ140TuVz/eQ+jw10+47lv+lJD9wJO/Y=; b=m8McbfYFH/jtufN1KjUC8LAAt
        ihvbCH2gsFIM21t7I398/PMiq8R1hetfy/R8dMDdn0Wvw38+SqTTNTPNWxkHIJZT8wY0DlkLQjnSi
        R1NirZdFj2tadaO6bM2fKjbph5yQxyjyQ9fxah3ACTk4qtXEhaOYwlCbnt5x4teSotemyonvBrl+q
        YHrV7wFwh2GDe9qqxeBsAkLBCwSAX38p9v5kWWWeH5soW5DcWLfGyNFEAsPwqU9Xnn/3KOWtxbeub
        6KXl/C7Eftx3r7cXlT7aZOExZJCkoVJD0AaA/5jcTFVgcoTMfVBR5Oo1TnpwDGWG12osOjf8thHat
        yFBpKBdAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzMP9-0006Ol-3r; Mon, 10 Sep 2018 13:39:03 +0000
Date:   Mon, 10 Sep 2018 06:39:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
Message-ID: <20180910133902.GB21593@infradead.org>
References: <20180906123651.28500-1-anup@brainfault.org>
 <20180906123651.28500-4-anup@brainfault.org>
 <20180906140628.GA10580@infradead.org>
 <alpine.DEB.2.21.1809081241310.1402@nanos.tec.linutronix.de>
 <20180910132924.GA6987@infradead.org>
 <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 03:37:31PM +0200, Thomas Gleixner wrote:
> > > Just a few weeks ago you said the contrary:
> > > 
> > > http://lists.infradead.org/pipermail/linux-riscv/2018-August/000943.html
> > 
> > Sigh. Yes. Now that you remind me. 
> 
> Just for clarification. I had the impression that Anup was trying to wire
> up more than just the timer interrupt, but that doesn't seem to be the
> case.

He has an irqchip that is called from the RISC-V exception handler
when the interrupt flag is set in scause and then dispatches to one
of:  IPI, timer, actual irqchip.
