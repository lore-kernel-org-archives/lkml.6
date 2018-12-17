Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188DFC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D8520675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejJ6cQLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388853AbeLQSYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:24:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387696AbeLQSYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9uKih18xxBxoVrJ97uTPhA2eumFqjVsrn7XJLu5sWWc=; b=ejJ6cQLbQWo/2Rungg0f/l71S
        v/uJjchECvIrjxqJc6I29s2S/MEs6GQHGFwvjKN7g94GA1Lz1oGLqZtVQO6pBdswRe38ppsuCRLPS
        pHPkZYhn/DCjp6mmPimYpEWcdw9N0zL7XBZyYVe3kr3B/UFM2UyplXZ3rh9p+M5zivjgJFkekVw0H
        o12Vw5EfkHTvtlmgMDlMqv65HZK2hHGUd1xkh4ckcLBZtQ4a39964HqqHSULxEDVdBpR3RXWiOi+B
        86BCEFE4rl7TsZLnDN29diRVNILfgLnZjuHbIKpd+ICFuWJTr4ViLdd1eiQDxTkm0zn+vo9Fk5HAD
        hb/IuJdxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYxYt-00022m-Qp; Mon, 17 Dec 2018 18:24:15 +0000
Date:   Mon, 17 Dec 2018 10:24:15 -0800
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
Subject: Re: [PATCH v3 2/6] irqchip: sifive-plic: Add struct plic_hw for
 global PLIC HW details
Message-ID: <20181217182415.GA7086@infradead.org>
References: <20181130080207.20505-1-anup@brainfault.org>
 <20181130080207.20505-3-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130080207.20505-3-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct plic_hw {
> +	u32			nr_irqs;
> +	u32			nr_handlers;
> +	u32			nr_mapped;
> +	void __iomem		*regs;
> +	struct irq_domain	*irqdomain;
> +};
> +
> +static struct plic_hw plic;

Please use local variables instead of a single instance struct.
And only add these variables in the patches where you actually need
them.
