Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6950FC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED995208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAnigWFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED995208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJPCNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:13:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37904 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeJPCND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:13:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so9556558pgq.5;
        Mon, 15 Oct 2018 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xq7R/zUaDazkHxGL8UsDfCmqNRW54vCOWIz8f0uJpGY=;
        b=NAnigWFnSjJfW56KIX7Ta4s76SeDzEo0ozJW6qmh4Bc5TqSEpwln4S8hHduTtUm1WT
         kqdVY1JuTjqCkvYOyMe8cUCPb/oaeuzlNxP+EyErJbe0y9Z1fOAJUj0G4ssfXL7CIC2S
         Hw/MdaoObfmnAf40vr7wJAw1T+6IRjLPhDLJb+Lny2HuWEm9nyFi5rmcp5c+Cm/lGMbJ
         0XHPsD/5zNDiHJi/M9QxskiomPJVzpxNQ1IEGnHaxMpWaMaInnuJFjFAyT3qK4WaIQDo
         Nf9SFKZVmg81SKbyKKOur90avLLH796V1VDGg4nQXbEqjE8dHENSNRGDez/IdX23HCuq
         xePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xq7R/zUaDazkHxGL8UsDfCmqNRW54vCOWIz8f0uJpGY=;
        b=qWFho75kGzTmpEo3rJm53OlrVd1ACaucoPVyGAXFDlgTk7XMJud6ilnmCRyyXXNq5d
         iYqZ0VqFhSWcZUj35Q0GjmTwhdqpTR5u7UDDLsn8egTuVLUT1tNSD43ej2jVg2QbKSiG
         W3E2tPjVVei6Lv9PPSHk7HMK8v6y3c7WrS3nqLMFZZjaZ9Mj8G+2XlYz9fim1akvVZrf
         Br3Kl0krDInIITe7qwdEb/II6Z/kGfI8qd8xptOIDTDbW+Rd/54c/A3aYdlNV/pKUoa7
         zueya3+fD7Xh0utWjQO+GktUuxnBPnGtetVN6Eit3kW2pFzgLC2cU7DkuiV0ZE0YjuEX
         D5ZA==
X-Gm-Message-State: ABuFfogx2DxnQj1ITHDVoI1dgQ8uG9sXfwrxq4WTXfr8UDMEZhmRzrCi
        DHW/KBg7N9QlqN9gYzWjJIYvw2Ry
X-Google-Smtp-Source: ACcGV62HGGxVaGUzucTTe+Oz06we+n4X4bA2xnkCdySVO784zYrmAZZnn+lctl95Q8xUtgMEHmCPrw==
X-Received: by 2002:a63:4281:: with SMTP id p123-v6mr16609829pga.91.1539627999839;
        Mon, 15 Oct 2018 11:26:39 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c2-v6sm13764888pfn.95.2018.10.15.11.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 11:26:38 -0700 (PDT)
Date:   Mon, 15 Oct 2018 11:26:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Oct 15
Message-ID: <20181015182637.GA16445@roeck-us.net>
References: <20181015192546.15faf3a1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015192546.15faf3a1@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 07:25:46PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181012:
> 
> My qemu boots of a powerpc pseries_le_defconfig kernel failed today.
> 

Same here. Interestingly, this only affects little endian pseries
boots; big endian works fine. I'll try to bisect later.

ALl ppc qemu tests (including big endian pseries) also generate a warning.

WARNING: CPU: 0 PID: 0 at mm/memblock.c:1301 .memblock_alloc_range_nid+0x20/0x68
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc7-next-20181015 #1
NIP:  c000000000f99198 LR: c000000000f99490 CTR: c000000000bb8364
REGS: c000000001217a78 TRAP: 0700   Not tainted  (4.19.0-rc7-next-20181015)
MSR:  0000000080021000 <CE,ME>  CR: 24000422  XER: 20000000
IRQMASK: 1 
GPR00: c000000000f99490 c000000001217d00 c00000000121a500 00000000000000c0 
GPR04: 0000000000000000 0000000000000000 0000000000000000 ffffffffffffffff 
GPR08: 0000000000000000 00000000000000c0 0000000000000018 00000000000000b7 
GPR12: 0000000000000040 c000000000fe7840 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR28: c000000000000304 c000000001262088 00000000000000c0 c000000000fea500 
NIP [c000000000f99198] .memblock_alloc_range_nid+0x20/0x68
LR [c000000000f99490] .memblock_alloc_base+0x18/0x48
Call Trace:
[c000000001217d00] [c000000002a00000] 0xc000000002a00000 (unreliable)
[c000000001217d80] [c000000000f99490] .memblock_alloc_base+0x18/0x48
[c000000001217df0] [c000000000f7a274] .allocate_paca_ptrs+0x3c/0x74
[c000000001217e70] [c000000000f78bf0] .early_init_devtree+0x288/0x320
[c000000001217f10] [c000000000f79b6c] .early_setup+0x80/0x130
[c000000001217f90] [c000000000000528] start_here_multiplatform+0x68/0x80


sparc images crash, starting with next-20181009. Bisect with
next-201810112 points to the merge of devicetree/for-next, though
devicetree/for-next itself does not have the problem (bisect log
attached below). The crash is in devicetree code.

Crash logs:
https://kerneltests.org/builders/qemu-sparc64-next/builds/981/steps/qemubuildcommand_1/logs/stdio
https://kerneltests.org/builders/qemu-sparc-next/builds/975/steps/qemubuildcommand_1/logs/stdio

Guenter

---
# bad: [774ea0551a2966c8fc29a6f675c3e28c5c6fa586] Add linux-next specific files for 20181012
# good: [0238df646e6224016a45505d2c111a24669ebe21] Linux 4.19-rc7
git bisect start 'HEAD' 'v4.19-rc7'
# good: [dfbf78faefa3c26d94208398e62bf25ea798e7f2] Merge remote-tracking branch 'spi-nor/spi-nor/next'
git bisect good dfbf78faefa3c26d94208398e62bf25ea798e7f2
# bad: [3f296bb430327676912966c56d2f078f74e6b4ab] Merge remote-tracking branch 'tip/auto-latest'
git bisect bad 3f296bb430327676912966c56d2f078f74e6b4ab
# good: [efad9cbc89fbef3c4b3905e1c01a8191eae4c772] Merge remote-tracking branch 'sound/for-next'
git bisect good efad9cbc89fbef3c4b3905e1c01a8191eae4c772
# good: [7d12a265b24001fbff1ff260c2f6bd802224a7c0] Merge remote-tracking branch 'iommu/next'
git bisect good 7d12a265b24001fbff1ff260c2f6bd802224a7c0
# good: [4fc72c0ef3c1e792caf06d25ef68c7c871730e31] Merge branch 'ras/core'
git bisect good 4fc72c0ef3c1e792caf06d25ef68c7c871730e31
# good: [d74865bd3996c7a6f3e8ce6e626c1fe474e39494] Merge branch 'x86/mm'
git bisect good d74865bd3996c7a6f3e8ce6e626c1fe474e39494
# bad: [1b1ab6a98adab8a0436024b369305a978e365a13] Merge remote-tracking branch 'mailbox/mailbox-for-next'
git bisect bad 1b1ab6a98adab8a0436024b369305a978e365a13
# good: [389d0a8a7af8ff8bb6301382333c7e8f748d7cd6] Merge branch 'dt/cpu-type-rework' into dt/next
git bisect good 389d0a8a7af8ff8bb6301382333c7e8f748d7cd6
# good: [4355151de47c2b4bc72c026ee743bd9ed7f71ba3] Merge branch 'all-dtbs' into dt/next
git bisect good 4355151de47c2b4bc72c026ee743bd9ed7f71ba3
# good: [60d744213fd9433b10b23afafb694a44c8e96cb8] Merge remote-tracking branch 'vfio/next'
git bisect good 60d744213fd9433b10b23afafb694a44c8e96cb8
# good: [9f0a0a381c5db56e7922dbeea6831f27db58372f] mailbox: mediatek: Add check for possible failure of kzalloc
git bisect good 9f0a0a381c5db56e7922dbeea6831f27db58372f
# good: [157b4129ded8ba756ef17c058192e734889673e4] dt-bindings: arm: fsl: Move DCFG and SCFG bindings to their own docs
git bisect good 157b4129ded8ba756ef17c058192e734889673e4
# bad: [bed61948ea6c57bc73fb3ded9421c1bdd8cbe4d9] Merge remote-tracking branch 'devicetree/for-next'
git bisect bad bed61948ea6c57bc73fb3ded9421c1bdd8cbe4d9
# good: [d81cc4a8e47219fbe60d49446f04ed3e9c1657d9] dt-bindings: arm: zte: Move sysctrl bindings to their own doc
git bisect good d81cc4a8e47219fbe60d49446f04ed3e9c1657d9
# first bad commit: [bed61948ea6c57bc73fb3ded9421c1bdd8cbe4d9] Merge remote-tracking branch 'devicetree/for-next'

