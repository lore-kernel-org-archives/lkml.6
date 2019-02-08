Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C566DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9537D2147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o2Ij0N3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfBHJLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:11:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfBHJLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ldCfc9dRaWsxnP0vOYr76kRxp7n4sEQKZlneoESVqVo=; b=o2Ij0N3hHKX2gfSHOsKl86MqG
        IdavrBX6cD7eeSlvMN4QcCKqB9oyPfqHJaGcW2Ug2bqOw0cdceuUe7+RFGAH98FBTQrVIChiE+PAZ
        V3Xpmp8sg12fEQ2suvOqh4oUUiwEFHypM84Ng8t1tpLEj1L6mJEgGm1o0uNhWQIK8uYxN7BcbB6rk
        rT7BfUaGg8f1gQwVq1TVg3M5Q5XbKl/nyZomoQa2tXbuu5DHrEOBPdJtcbc2COTQpulSSlmCoHzDg
        FwJ1AVTSg12fTPRemwHqJBmxnxcYT2afqSYmCNR+2jvt6IUyfHvuwIR0BAMNaJCVZ67gqgVcNFfTo
        TARBA/CvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gs2C5-0008A5-9d; Fri, 08 Feb 2019 09:11:33 +0000
Date:   Fri, 8 Feb 2019 01:11:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org,
        Patrick =?iso-8859-1?Q?St=E4hlin?= <me@packi.ch>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Zong Li <zongbox@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v3 PATCH 8/8] RISC-V: Assign hwcap only according to boot cpu.
Message-ID: <20190208091133.GD16932@infradead.org>
References: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
 <1549590681-24125-9-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549590681-24125-9-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	 * We don't support running Linux on hertergenous ISA systems.
> +	 * But first "okay" processor might not be the boot cpu.
> +	 * Check the ISA of boot cpu.

Please use up your available 80 characters per line in comments.

> +		/*
> +		 * All "okay" hart should have same isa. We don't know how to
> +		 * handle if they don't. Throw a warning for now.
> +		 */
> +		if (elf_hwcap && temp_hwcap != elf_hwcap)
> +			pr_warn("isa mismatch: 0x%lx != 0x%lx\n",
> +				elf_hwcap, temp_hwcap);
> +
> +		if (hartid == boot_cpu_hartid)
> +			boot_hwcap = temp_hwcap;
> +		elf_hwcap = temp_hwcap;

So we always set elf_hwcap to the capabilities of the previous cpu.

> +		temp_hwcap = 0;

I think tmp_hwcap should be declared and initialized inside the outer loop
instead having to manually reset it like this.

> +	}
>  
> +	elf_hwcap = boot_hwcap;

And then reset it here to the boot cpu.

Shoudn't we only report the features supported by all cores?  Otherwise
we'll still have problems if the boot cpu supports a feature, but not
others.

Something like:

	for () {
		unsigned long this_hwcap = 0;

		for (i = 0; i < strlen(isa); i++)
			this_hwcap |= isa2hwcap[(unsigned char)(isa[i])];

		if (elf_hwcap)
			elf_hwcap &= this_hwcap;
		else
			elf_hwcap = this_hwcap;
	}

