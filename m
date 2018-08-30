Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0054BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26852082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M1qlHok9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26852082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeH3Smo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:42:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbeH3Smn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N2WT06nTLXjUgrrQPL0epRfYYIxFtUIvOdsGAW7vPUE=; b=M1qlHok9sG7GcLgaj1KIy8Dpx
        Xt+EruCd8MmRz+Ml6jKYsb8wwm/bsk4kwDqsxuFlDvvCKubXCDTSQEpE9xGeokMKInopU4Z3BX8QD
        wG54mYtRtyu4i5RVCiRLwhilNq1RAZFG2fjb4QaEabKJxBtpFmTgbzdMNQuM6C3q/N+5ZKdPPkts5
        97AXpdFN9XOV3zkbFdQsBOb96FZNfoxRn3t5zlx7n2qdhKJvibACzy8wFUPJ2fOSFW9plCeBIGq7S
        UCogrw/UwnrQguIVwnjiLW0honBWXJ/U+aTL8EBCAfa0PzPGyiRFgFjXogw+cSU1E4Htb1RACkGqx
        ByhgiYRtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvO7H-0006B2-4k; Thu, 30 Aug 2018 14:40:11 +0000
Date:   Thu, 30 Aug 2018 07:40:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        dmitriy@oss-tech.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        aou@eecs.berkeley.edu, Greg KH <gregkh@linuxfoundation.org>,
        tglx@linutronix.de
Subject: Re: [PATCH 3/8] RISC-V: Rename riscv_of_processor_hart to
 riscv_of_processor_hartid
Message-ID: <20180830144010.GE11544@infradead.org>
References: <20180827184243.25344-1-palmer@sifive.com>
 <20180827184243.25344-4-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827184243.25344-4-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* Returns the hart ID of the given device tree node, or -1 if the device tree
> + * node isn't a RISC-V hart. */

In addition to the comment formatting: we usually keep the description
near the implementation, not the header.  It could also become a
kerneldoc comment for added clarity.

> +extern int riscv_of_processor_hartid(struct device_node *node);

No need to declare function prototypes in headers with the extern
attribute, btw.
