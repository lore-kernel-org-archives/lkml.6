Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B43C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A732B20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X7HRtyy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbfAOP4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:56:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbfAOP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rP94Pp1ZMFPy7h3gy3CC8PZWAJD8fQQaMhu0Bz75bT4=; b=X7HRtyy95AGclhwpKx7KnR+yF
        ejeAihpxR91vjve/s9jVnTl+fqiqdIMJVoqU4YHKL7kWMjyp7XbIdEf60KtHPPOpKYy9q35N4OsLA
        diRv5RyIoUoj+bLQS/0jt5OPPEKbfDXXwi+ubElXzBT35waAaLncJqgnJclDQ0/siPSEBUuBpxnXi
        14WAz9EqJW+m/id1T4JJCiqB8eD/83RFiVKohVA90a25gb4MseGp4zvtodobrTk5T62PzAyBznDLH
        Z8+8bDmOq06C9VGjfXTlFENObtOGctHHXO+JnB5+4RwYKm3oHrV9ENx2i4dUl184NwGNCUvZcAdE3
        7h5p1ui9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjR4K-00059h-9C; Tue, 15 Jan 2019 15:56:00 +0000
Date:   Tue, 15 Jan 2019 07:56:00 -0800
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
Subject: Re: [PATCH v4 4/5] irqchip: sifive-plic: Differentiate between PLIC
 handler and context
Message-ID: <20190115155600.GC13095@infradead.org>
References: <20181227111821.80908-1-anup@brainfault.org>
 <20181227111821.80908-5-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227111821.80908-5-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 04:48:20PM +0530, Anup Patel wrote:
> We explicitly differentiate between PLIC handler and context because
> PLIC context is for given mode of HART whereas PLIC handler is per-CPU
> software construct meant for handling interrupts from a particular
> PLIC context.
> 
> To achieve this differentiation, we rename "nr_handlers" to "nr_contexts"
> and "nr_mapped" to "nr_handlers" in plic_init().

Not sure what this differenciates that we previously didn't.  As far
as I can tell it just is a slight naming cleanup.
