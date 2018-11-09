Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E62C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE4120883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jCpowe2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE4120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeKISXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:23:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeKISXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kkr6ZrSbQXRZSNIpT06/R9orFOQu9HwkkGSW1b0j+XA=; b=jCpowe2/FlWESLJCIt16jVz6C
        oP/B8OqU8O7mC+rkWrNbYLHsgxP3ypioia7PCl6K1HP25TRHOYpP7TWntQaGoqVMGCzX3FdJ2SI9u
        gnnUSMwMxEDaPzXniioh+a4FQJeYnAOR6bvugOSAxRDiqj3ZvOBuiRBOF4CsX+SDs0MhaEBW8VOEI
        CTfXqhT/nvJNXPFKXXHSfI5je5u1Dj4Z/XoELj/9tapb01DvixqtJNEfEqFssF5E4SYhY5c2fIAOH
        0NGjT/zCAXbRwrqPQUNcmq6YfzmvHjDmKVNUKYMgENanXQZl1fhnx0+A17CZuP4Jd/HS8jB8J6O6R
        swTu5aK2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gL2OA-0004zv-Sx; Fri, 09 Nov 2018 08:43:38 +0000
Date:   Fri, 9 Nov 2018 00:43:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] irqchip: sifive-plic: More flexible plic_irq_toggle()
Message-ID: <20181109084338.GB6508@infradead.org>
References: <20181022114517.22748-1-anup@brainfault.org>
 <20181022114517.22748-3-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022114517.22748-3-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -
>  struct plic_handler {
>  	bool			present;
> -	int			ctxid;
>  	void __iomem		*hart_base;
>  	raw_spinlock_t		enable_lock;
>  	void __iomem		*enable_base;
>  };
> -static DEFINE_PER_CPU(struct plic_handler, plic_handlers);

This does not match the changelog at all.
