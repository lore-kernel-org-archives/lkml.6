Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782B2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4770B20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJeTUcaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbfAOP5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:57:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbfAOP5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=opK8COkigmz0NFnchVnzN0WwfNsAGHZZ5MfSbVwO76c=; b=XJeTUcaDv53vxbK6/XI/K53aj
        rPa/x0fxDelXpyj8dYNzMiiYetpN3e27R5ycDbJytRkCC4I/WMHdjrL7ca25BRro7lBuRQ+mOPaT0
        +RzHc6TIaiQWQxOFUwH6yYwb2EVtdzJxbxLOki4zttTkAo/SjyiOPsGEEjsI5tnh2R8MYfWqkRYZm
        Ft/BIhfUNaOXMne64m4/JWO5LlmiQyIFzB3D4cMQdBGFulXw8h/sqhARvk+Tt/eCkFx+ruDyBUSm+
        LygjWzg2qSx5zeLPSR5RCNOABMZrclSKFe+rKhQa3/l2YEb9sbNq/Qn6p+FbFYItr/m7j5UHU9e4M
        YlCsJ1z/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjR5j-0005dc-Gb; Tue, 15 Jan 2019 15:57:27 +0000
Date:   Tue, 15 Jan 2019 07:57:27 -0800
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
Subject: Re: [PATCH v4 5/5] irqchip: sifive-plic: Implement
 irq_set_affinity() for SMP host
Message-ID: <20190115155727.GD13095@infradead.org>
References: <20181227111821.80908-1-anup@brainfault.org>
 <20181227111821.80908-6-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227111821.80908-6-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (!force)
> +		cpu = cpumask_any_and(mask_val, cpu_online_mask);
> +	else
> +		cpu = cpumask_first(mask_val);

Any reason for the inverted test?

Otherwise this looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
