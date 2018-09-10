Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2167EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7D020881
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C9ZbEHsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7D020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeIJVIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:08:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbeIJVIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YP+cQTdRCyu7Z5q8SLU9kLg4ZY4ThJMQ0EgCZBOA+50=; b=C9ZbEHsGbjhTJXkBpAsKWVCbS
        X1CGWqBterp+q1fL5JWgoreTravR1hY9cuk0S3nR6YWtrMhA5gGfE4qxqFRtdTG7kHwZGKtQSA5Qt
        OsFOO5i5UtCp4W0JIwfvH93BXbNkMGwnJ5GAmANuaPOAgJDFTX2bHL8nESsf3Yuwl4ei86TVkvG+J
        94roAFYyHEuO4aEsqcOXgTUEwgtVdzv+6nZqc3Iy+PeDlWJ/+2JBwLVUMq4+rXSD/dQFukv4kqqXQ
        /VFbE4para4xIXoz0T/BB+x+d7a6XiqqzezI/laFwCgWKpCl104oaH2a9pi5Ey79aiu1sxTsJiC0P
        T6ZzvwT+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzOoa-0003oX-D5; Mon, 10 Sep 2018 16:13:28 +0000
Date:   Mon, 10 Sep 2018 09:13:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
Message-ID: <20180910161328.GA13171@infradead.org>
References: <20180906123651.28500-4-anup@brainfault.org>
 <20180906140628.GA10580@infradead.org>
 <alpine.DEB.2.21.1809081241310.1402@nanos.tec.linutronix.de>
 <20180910132924.GA6987@infradead.org>
 <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de>
 <20180910133902.GB21593@infradead.org>
 <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de>
 <20180910134915.GB30774@infradead.org>
 <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 07:59:15PM +0530, Anup Patel wrote:
> > Yes.  external is chained and IPI is still handled explicitly.
> 
> On riscv64, there are 64 local interrupts (i.e. per-CPU interrupts).

There aren't.  There are 9 right now, which are your three below:

> Three of these local interrupts have clearly defined use:
> 1. Software interrupt (inter-processor interrupt)
> 2. External interrupt (interrupt from PLIC)
> 3. Timer interrupt (interrupt from per-CPU timer)

multiplied by 3 for machine, supervisor, user.

> Other local interrupts are available for future use.

The others aren't even defined as other interrupts, but just reserved
fields.  And only one bit per privilege level would even fit into the
encoding scheme used right now.
