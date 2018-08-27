Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E6AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA30208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNiWrYHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA30208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeH0Rbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:31:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41172 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeH0Rbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:31:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so7462910pgv.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cm94X8UfQmE4K18G/zz7JBXNLeYeVVCBU6//wOm/GCs=;
        b=uNiWrYHgntAjQtCb13gmyrdFw4nuPjYxBnK7c5SCD9SY1WEeH+uzh9jy8FyZiKCHYV
         0MNqAwUiXju+IYyxk0/xZbW5zmeGfwRtQjFkdSa25qLTd2wrGMe00gJvHV7qrGhaS9aJ
         QEWnM9ZjbpzXnhgFZZoKehHjtK4vSumkYQePcgsD4KinY8FU/0DH4a8CbXupEjFpgCJ5
         E5EcNu70Z3ZvX57tR/8t2aWrMixJHLaEDMOgJ+vfxCHJL7j3B3eGeoXGM3lXI6nBU9aq
         +iCvBypDAxmBdFGtm9XVLI3PjPqqtoasvgTqZaazTnUuk06rep68+LOXrf+lv38P/Lpx
         W9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cm94X8UfQmE4K18G/zz7JBXNLeYeVVCBU6//wOm/GCs=;
        b=VQkdlG6OXwFrfWkFehGgGKnBNZ4X1eB7DvYEtdP0zF9aVdwRQYojW8rNuMzZaK4PN7
         KZpHR7fq1v+utWXcX8QcsU4ydHwPA4BojQZVjzrA8H5zDHC3Eh4QT26oNPQsyCQLDNf7
         rAzICtLPBiPseXQEDk2CARBMtUkEupVWZYq58VTKZoramcdrhQ6JCAAhjTYUvyrP+YNC
         HH7oNIQra0RcaZLyK2+ISOIXjN5fgo0CIVO9FtEE3NpqQDd2eI+OiZPZ+Y3uzQs9KxTb
         fVDjuIyJzDiz+NwlX3WEO331pjHY0VS1sVn5Ksz+J6TjGVxHb1KOptbngQprBLkZnY/c
         +FwA==
X-Gm-Message-State: APzg51Ca/NpXZ0y96ZRWZ5gy2jt1MV+sZlzlP7tGhaWVzhm+Psac/W05
        UMbU7+1jOBe6tjxrc8VrmPoe5/J8
X-Google-Smtp-Source: ANB0VdaS0Kh5X0lUrdnr59lU697cANujGWz1UpgSCPvU1dNFhFhiJphtFAbp/SCKElcUd0D8ebirBA==
X-Received: by 2002:a62:8559:: with SMTP id u86-v6mr14585046pfd.32.1535377501707;
        Mon, 27 Aug 2018 06:45:01 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z11-v6sm30062471pfi.4.2018.08.27.06.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 06:45:00 -0700 (PDT)
Date:   Mon, 27 Aug 2018 06:44:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.19-rc1
Message-ID: <20180827134459.GA16094@roeck-us.net>
References: <CA+55aFw9mxNPX6OtOp-aoUMdXSg=gBkQudGGamo__sh_ts_LdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFw9mxNPX6OtOp-aoUMdXSg=gBkQudGGamo__sh_ts_LdQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 02:49:14PM -0700, Linus Torvalds wrote:
> So two weeks have passed, and the merge window for 4.19 is over.
> 
[ ... ]
> 
> Anyway, go forth and test,
> 

Build results:
	total: 132 pass: 129 fail: 3
Failed builds: 
	riscv:defconfig 
	riscv:allnoconfig 
	sparc32:allmodconfig 
Qemu test results:
	total: 299 pass: 297 fail: 2
Failed tests: 
	riscv:virt:defconfig:initrd 
	riscv:virt:defconfig:virtio-blk:rootfs

---
riscv:

In file included from arch/riscv/include/asm/tlb.h:17:0,
                 from arch/riscv/include/asm/pgalloc.h:19,
		 from arch/riscv/mm/fault.c:30:
include/asm-generic/tlb.h: In function 'tlb_flush_mmu_tlbonly':
include/asm-generic/tlb.h:147:2: error: implicit declaration of function 'tlb_flush'

Known problem, patch submitted.

---
sparc32:allmodconfig:

arch/sparc/kernel/head_32.o: In function `current_pc':
arch/sparc/kernel/.tmp_head_32.o:(.head.text+0x5040): relocation truncated to fit: R_SPARC_WDISP22 against `.init.text'
arch/sparc/kernel/head_32.o: In function `halt_notsup':
arch/sparc/kernel/.tmp_head_32.o:(.head.text+0x5100): relocation truncated to fit: R_SPARC_WDISP22 against `.init.text'
arch/sparc/kernel/head_32.o: In function `leon_init':
arch/sparc/kernel/.tmp_head_32.o:(.init.text+0xa4): relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section
in arch/sparc/kernel/trampoline_32.o
arch/sparc/kernel/process_32.o:(.fixup+0x4): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
arch/sparc/kernel/process_32.o:(.fixup+0xc): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
arch/sparc/kernel/signal_32.o:(.fixup+0x0): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
arch/sparc/kernel/signal_32.o:(.fixup+0x8): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
arch/sparc/kernel/signal_32.o:(.fixup+0x10): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
arch/sparc/kernel/signal_32.o:(.fixup+0x18): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
arch/sparc/kernel/signal_32.o:(.fixup+0x20): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
arch/sparc/kernel/signal_32.o:(.fixup+0x28): additional relocation overflows omitted from the output

For the most part this is due to calls / short jumps between .head.text,
.text, and .init.text.  Probably old, now seen because the image is now
too large.

---
On top of that, there are various runtime warnings.

sh:

WARNING: CPU: 0 PID: 932 at mm/slab.c:2666 cache_alloc_refill+0x8a/0x594

Known problem. Fix was under discussion. I don't know if it was accepted.

https://marc.info/?t=153301426900002&r=1&w=2
https://www.spinics.net/lists/linux-sh/msg53298.html

---
sparc:

WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 esp_sbus_probe+0x408/0x6e8
WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 sparc_lance_probe_one+0x428/0x4f

Missing initialization of coherent_dma_mask in the respective drivers.

---
Each platform driver instantiated through a devicetree node now generates
the following warning:

esp ffd38e00: DMA mask not set

It isn't a traceback so it may fly under the radar. There is nothing the
drivers can do about it; the message is generated by the core before the
driver probe function is called. No idea what a correct fix might be.

Guenter
