Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03F3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5400F2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aJRnsABt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5400F2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeH3SpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:45:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbeH3SpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IqLpQ6BRYOHst/lCyDEto1NNx22FE80yPGavbSvHkGg=; b=aJRnsABtQsqOSsCJFeKvT7pYb
        DMtgzA/TVflGgOuQPp5Q4pH9Uh+g3LLNZKf/3FUMMVaUHgzyU7k3Trmy7w1kOjjGqdspClVclMhF2
        906gzdDRTVVEwm0CxUKIoMUfnOq0J/KeBX0FXH4ZowST5C4SCmUD+K6OqS3XUH99v728U16qoCYz4
        BeajD1Zbk1HKV6umW2em4g6jWdBHuHy4dp4P3X8A6Z5ycMSdsezIMN+m7qlaMOXBzy+7T5h0ju8Td
        dp2fr+43Idrx4hdB/zdnokSRqREVt3yWQ1aFdqzQDxauNpgGvDqAYLknu+A2p/gAphH8JDVIhrZtK
        8iGzVbSeA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvO9Z-0007ad-TE; Thu, 30 Aug 2018 14:42:33 +0000
Date:   Thu, 30 Aug 2018 07:42:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        dmitriy@oss-tech.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        aou@eecs.berkeley.edu, Greg KH <gregkh@linuxfoundation.org>,
        tglx@linutronix.de
Subject: Re: [PATCH 7/8] RISC-V: Comment on the TLB flush in smp_callin()
Message-ID: <20180830144233.GC27233@infradead.org>
References: <20180827184243.25344-1-palmer@sifive.com>
 <20180827184243.25344-8-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827184243.25344-8-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  	notify_cpu_starting(smp_processor_id());
>  	set_cpu_online(smp_processor_id(), 1);
> +	/* Remote TLB flushes are ignored while the CPU is offline, so emit a local
> +	 * TLB flush right now just in case. */

Please use the normal kernel comment style and break the line after 80
characters.
