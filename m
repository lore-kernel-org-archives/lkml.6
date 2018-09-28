Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9180DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E58920666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RLZm1uWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E58920666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeI1Wfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:35:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbeI1Wfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ytZnOBM/lsdAxj9dqYtHmBwq2inMxi8ebmT4SPsd+Is=; b=RLZm1uWeInA5W33xIOLg6yZ9i
        EW8+Rf800cLeKq7N7nSEEdgCtb0Ht9F6klhIVSljj8o11RJTWQQkXMoPeemUY4FMOCt5u/ENtrgyL
        NAY7VigWpb6UVpD39ugKacZrP/5JZdIFYyZDGDuQgTcEEkjM+JHOf8A1XOK6Qo3bt+32P8wyTUISb
        dWH7PmYHbNK2L9rl13Hvmpan/2ZZ8TW6CgkA3xmGbFhx/RyPMr5/gFQU9kjMbHd6c9EqNaHZYED9X
        vD+oGVHXpge3ZBMZEGOhmy2oscjix6wUHSFApmI/Nry9jTu+E702fu8LL5oH6MhiniCdlSmIZWNdJ
        el/2uBRIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5vME-0006mD-Le; Fri, 28 Sep 2018 16:11:10 +0000
Date:   Fri, 28 Sep 2018 09:11:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com
Subject: Re: [PATCH V6 01/33] csky: Build infrastructure
Message-ID: <20180928161110.GA19827@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <dbd9228bb886c672ba75ad9e479f870957d6bcfa.1538058840.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd9228bb886c672ba75ad9e479f870957d6bcfa.1538058840.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- /dev/null
> +++ b/arch/csky/kernel/Makefile
> @@ -0,0 +1,8 @@
> +extra-y := head.o vmlinux.lds
> +
> +obj-y += entry.o atomic.o signal.o traps.o irq.o time.o vdso.o \
> +	 power.o syscall.o platform.o syscall_table.o setup.o \
> +	 process.o cpu-probe.o ptrace.o dumpstack.o
> +
> +obj-$(CONFIG_MODULES)			+= module.o

You can't just wire up the build infrastructure before th code.

Please add the objects to the Makefiles when they are actually added.
