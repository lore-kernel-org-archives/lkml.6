Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71093C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A87208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q2tVQsHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A87208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeH1BVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:21:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41608 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH1BVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:21:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id s15-v6so169301pgv.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bIzipIE5aIiTkEvgW3InEsab5Jt7cMK+R9IG+MkJe8k=;
        b=Q2tVQsHpubWFkKqsatTLyzwwNXuM4qzkmH1QGwQTc4H9LZs9sQHwU4n9eCBdiHsO53
         0UOVS+Q6lNf+kIrN7QR8fB95nIFXumbAoBUgwV0qLs5evftYbJeM9Mp7EKQiqIWHM/nl
         2HqkSO3mDDaPAhGg+K+P99desy4tqrpCILZyfprhSBd/Ri/W9v3Tx4FcA60WBFFOD4/Z
         VfbcwMsHl9W9LFXHKsEWyRRqJ+mWw8iK2skSX9jTo7Sokh5M3RTjIgFy+3zG5S11dMSM
         JdXbdJ49i9iIMAf9xlI17jjQvtLDiFQF29mwKbI2e4HLoW3EednXSF+C5B76TXrK8b5+
         eAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bIzipIE5aIiTkEvgW3InEsab5Jt7cMK+R9IG+MkJe8k=;
        b=qF1sPZPUpv86JO9N3f7lp9SO8cTk/tZi9/3ynMTHDmWV8NkEBmPafvUJMzGLZIxFOI
         hcY4JNEgLRkzzrZ+R16Bjn4b1Up5ZYUiLgcEyGHa57Q/VtqMvRf9eW5XmYmKX9H6jYU4
         bvZ/VIpQLLLezbo6BD2PksNLIpgr+q1AGbKVFcvOVmJj3JeNR7D8gm0RrjLC2W4nEhuS
         puFIsF3TlMIQ9Xlfx4gIgRKHj6OX3V7mjEflpofislg+NkUlWOM3qY0K5g5Ao2Py8t6v
         oQrXZlYjs3xAEPoODjyZsNgzsELhTywAr60+JPiGfitM0reoWIOaYq0T8FmbtsmJhXpl
         OiQg==
X-Gm-Message-State: APzg51C12IMBDk3/bHSuepF+EEViYBy1/Tf0J4HVD8BV/DEHbVECYxkA
        wC2yIfd5BzvlBcZ24+LE6pUvieLPVFQ=
X-Google-Smtp-Source: ANB0VdZlGOjKAnMqwdSa3KDX8kYEKg75skju8qhFbCHLsEuGfRf5ggWRut1LcO7Vfnhb6p4n7QB7yw==
X-Received: by 2002:a63:c00b:: with SMTP id h11-v6mr13670966pgg.279.1535405558122;
        Mon, 27 Aug 2018 14:32:38 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id o21-v6sm234505pfi.165.2018.08.27.14.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 14:32:37 -0700 (PDT)
Date:   Mon, 27 Aug 2018 14:32:37 -0700 (PDT)
X-Google-Original-Date: Mon, 27 Aug 2018 14:31:31 PDT (-0700)
Subject:     Re: Linux 4.19-rc1
In-Reply-To: <20180827134459.GA16094@roeck-us.net>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux@roeck-us.net
Message-ID: <mhng-e4120cac-c7ab-4244-a565-805892fad85c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 06:44:59 PDT (-0700), linux@roeck-us.net wrote:
> On Sun, Aug 26, 2018 at 02:49:14PM -0700, Linus Torvalds wrote:
>> So two weeks have passed, and the merge window for 4.19 is over.
>>
> [ ... ]
>>
>> Anyway, go forth and test,
>>
>
> Build results:
> 	total: 132 pass: 129 fail: 3
> Failed builds:
> 	riscv:defconfig
> 	riscv:allnoconfig
> 	sparc32:allmodconfig
> Qemu test results:
> 	total: 299 pass: 297 fail: 2
> Failed tests:
> 	riscv:virt:defconfig:initrd
> 	riscv:virt:defconfig:virtio-blk:rootfs
>
> ---
> riscv:
>
> In file included from arch/riscv/include/asm/tlb.h:17:0,
>                  from arch/riscv/include/asm/pgalloc.h:19,
> 		 from arch/riscv/mm/fault.c:30:
> include/asm-generic/tlb.h: In function 'tlb_flush_mmu_tlbonly':
> include/asm-generic/tlb.h:147:2: error: implicit declaration of function 'tlb_flush'
>
> Known problem, patch submitted.

Thanks for the patch (as well as running the build farm)!  It should be in the 
PR I submit today, assuming I can get through my email...

>
> ---
> sparc32:allmodconfig:
>
> arch/sparc/kernel/head_32.o: In function `current_pc':
> arch/sparc/kernel/.tmp_head_32.o:(.head.text+0x5040): relocation truncated to fit: R_SPARC_WDISP22 against `.init.text'
> arch/sparc/kernel/head_32.o: In function `halt_notsup':
> arch/sparc/kernel/.tmp_head_32.o:(.head.text+0x5100): relocation truncated to fit: R_SPARC_WDISP22 against `.init.text'
> arch/sparc/kernel/head_32.o: In function `leon_init':
> arch/sparc/kernel/.tmp_head_32.o:(.init.text+0xa4): relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section
> in arch/sparc/kernel/trampoline_32.o
> arch/sparc/kernel/process_32.o:(.fixup+0x4): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
> arch/sparc/kernel/process_32.o:(.fixup+0xc): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
> arch/sparc/kernel/signal_32.o:(.fixup+0x0): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
> arch/sparc/kernel/signal_32.o:(.fixup+0x8): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
> arch/sparc/kernel/signal_32.o:(.fixup+0x10): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
> arch/sparc/kernel/signal_32.o:(.fixup+0x18): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
> arch/sparc/kernel/signal_32.o:(.fixup+0x20): relocation truncated to fit: R_SPARC_WDISP22 against `.text'
> arch/sparc/kernel/signal_32.o:(.fixup+0x28): additional relocation overflows omitted from the output
>
> For the most part this is due to calls / short jumps between .head.text,
> .text, and .init.text.  Probably old, now seen because the image is now
> too large.
>
> ---
> On top of that, there are various runtime warnings.
>
> sh:
>
> WARNING: CPU: 0 PID: 932 at mm/slab.c:2666 cache_alloc_refill+0x8a/0x594
>
> Known problem. Fix was under discussion. I don't know if it was accepted.
>
> https://marc.info/?t=153301426900002&r=1&w=2
> https://www.spinics.net/lists/linux-sh/msg53298.html
>
> ---
> sparc:
>
> WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 esp_sbus_probe+0x408/0x6e8
> WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 sparc_lance_probe_one+0x428/0x4f
>
> Missing initialization of coherent_dma_mask in the respective drivers.
>
> ---
> Each platform driver instantiated through a devicetree node now generates
> the following warning:
>
> esp ffd38e00: DMA mask not set
>
> It isn't a traceback so it may fly under the radar. There is nothing the
> drivers can do about it; the message is generated by the core before the
> driver probe function is called. No idea what a correct fix might be.
>
> Guenter
