Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E97FC64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E0120666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nl6b4mFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E0120666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeJCCZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:25:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35340 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJCCZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:25:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so439353pgb.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7suzKwatlHr9M7xGO4UQp1KUv/TEhtWrQAPSE+rrWZo=;
        b=nl6b4mFHsmqjSB4PwRcBn9itnYvHC/2M35mVZYfBwax5a+F23wBYnUZVzTV8xnXN62
         BxhZwaj/9+FhD3jH0nh9mC3hhwXkeezBz0B25TONHu7xKHcohvuvLddtMRZxbOC+gbYC
         DAUKkQgEQtydcQvzeSMRz6ZuxYNSf9Q/7PBCMqrQC0wt8nwa148rIWOc8TgBvqB+n/Lm
         PPSIgkZwTl1Kl+SrVUZDZbk5ZEGIT0EDKQPK2/t7Z/RaaIBJHKVNRMlzfykDe616uAIY
         QIUmvhIEpDqXK88iOParrKaGHvDaJ7eeGf5VpMhigfyS8fRQezdldXeu/pY+cexYvnXY
         my5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7suzKwatlHr9M7xGO4UQp1KUv/TEhtWrQAPSE+rrWZo=;
        b=Wqo+sA3LcaeUnlt19JNagUs+a9RiMM6G4rhuE7DnmYGkWJNO6Ilt+TW23jB1po4yZS
         dQ+8gmSjL8h6jjM7X0S4fcX/v/UBGy5lvBtDKbkyIOC1Vi4+DncSv0uMGxOl64sLWBfJ
         emsTRrCfB7QrCciF2jbXKcEeX7nMsMTXXcoRLnam22KQZ9EqJpccNdUSJYKl2VF86qoJ
         jTxiWtnrBzXHgDtR0TB7UUwN3zzLWjtG0y3heC2mnE8OdbsAhu4VXNCcAEw3USZkCDrm
         sacvxUur+78NE3t5NY/INOHsbPUSmexcnuiAlxHSJxjXfzr8NwR3p/f3S0+WxgmL1fw9
         EGyw==
X-Gm-Message-State: ABuFfojUIbtCRt7XNDmRckLxzk1u6OISVhWiMMCizAMCBs6CUW89mgFF
        7/cJXOQw1B6DA0cAvOLTbCky0QilldM=
X-Google-Smtp-Source: ACcGV60DG3p4q1e9+vHezqEx8qPhpkDsWN13OR3K/n8Etiis/upaZdwzs7trGQy0AeThkICwCwg9DQ==
X-Received: by 2002:a65:4849:: with SMTP id i9-v6mr15341070pgs.350.1538509209554;
        Tue, 02 Oct 2018 12:40:09 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 64-v6sm7681043pfq.10.2018.10.02.12.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 12:40:08 -0700 (PDT)
Date:   Tue, 02 Oct 2018 12:40:08 -0700 (PDT)
X-Google-Original-Date: Tue, 02 Oct 2018 12:39:57 PDT (-0700)
Subject:     Re: [PATCH v6 00/14] SMP cleanup and new features
In-Reply-To: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
CC:     linux-riscv@lists.infradead.org, anup@brainfault.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-d52d60ae-732e-4252-9258-21ea6bed8a31@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Oct 2018 12:14:53 PDT (-0700), atish.patra@wdc.com wrote:
> This patch series now has evolved to contain several related changes.
>
> 1. Updated the assorted cleanup series by palmer.
> The original cleanup patch series can be found here.
> http://lists.infradead.org/pipermail/linux-riscv/2018-August/001232.html
>
> 2. Implemented decoupling linux logical CPU ids from hart id.
> Some of the work has been inspired from ARM64.
> Tested on QEMU & HighFive Unleashed board with/without SMP enabled.
>
> 3. Included Anup's cleanup and IPI stat patch.
>
> All the patch series have been combined to avoid conflicts as a lot
> of common code is changed different patch sets. I have mostly addressed
> review comments and fixed checkpatch errors from palmer's and anup's series.
>
> v1->v2:
>
> 1. Dropped cpu_ops patch.
> 2. Moved back IRQ cause definitions to irq.h
> 3. Keep boot CPU hart id and assign zero as the CPU id for boot CPU.
> 4. Renamed CPU id and hart id correctly.
>
> v2-v3:
>
> 1. Added cleanup patches from palmer.
> 2. Moved the hotplug related functions to it's own file.
> 3. Updated stub functions as per coding guidelines.
> 4. Renamed __cpu_logical_map to a more coherent name.
>
> v3-v4:
>
> 1. Addressed minor typos in commit text and code.
> 2. Included Anup's do_IRQ patch.
> 3. Dropped CPU hotplug patch. As there are some concerns
>    about approach, I will submit it separately.
>
> v4->v5:
>
> 1. Minor typo fixes in commit text.
>
> v5->v6:
> 1. Included Anup's IPI stat and cpuinfo patch.
> 2. Fixed a typo cpuid_to_hardid_map->cpuid_to_hartid_map
>
>
> Anup Patel (3):
>   RISC-V: No need to pass scause as arg to do_IRQ()
>   RISC-V: Show CPU ID and Hart ID separately in /proc/cpuinfo
>   RISC-V: Show IPI stats
>
> Atish Patra (4):
>   RISC-V: Disable preemption before enabling interrupts
>   RISC-V: Use WRITE_ONCE instead of direct access
>   RISC-V: Add logical CPU indexing for RISC-V
>   RISC-V: Use Linux logical CPU number instead of hartid
>
> Palmer Dabbelt (7):
>   RISC-V: Don't set cacheinfo.{physical_line_partition,attributes}
>   RISC-V: Filter ISA and MMU values in cpuinfo
>   RISC-V: Comment on the TLB flush in smp_callin()
>   RISC-V: Provide a cleaner raw_smp_processor_id()
>   RISC-V: Rename riscv_of_processor_hart to riscv_of_processor_hartid
>   RISC-V: Rename im_okay_therefore_i_am to found_boot_cpu
>   RISC-V: Use mmgrab()
>
>  arch/riscv/include/asm/processor.h |  2 +-
>  arch/riscv/include/asm/smp.h       | 47 +++++++++++++++-----
>  arch/riscv/include/asm/tlbflush.h  | 16 +++++--
>  arch/riscv/kernel/cacheinfo.c      |  7 ---
>  arch/riscv/kernel/cpu.c            | 87 ++++++++++++++++++++++++++++++++------
>  arch/riscv/kernel/entry.S          |  1 -
>  arch/riscv/kernel/head.S           |  4 +-
>  arch/riscv/kernel/irq.c            | 12 +++++-
>  arch/riscv/kernel/setup.c          | 10 +++++
>  arch/riscv/kernel/smp.c            | 82 ++++++++++++++++++++++++++++-------
>  arch/riscv/kernel/smpboot.c        | 46 ++++++++++++++------
>  drivers/clocksource/riscv_timer.c  | 12 ++++--
>  drivers/irqchip/irq-sifive-plic.c  | 10 +++--
>  13 files changed, 259 insertions(+), 77 deletions(-)

These are on my "next-smp" branch, and will land in for-next as soon as it's 
done regenerating.  I've replaced the "next-cleanups" branch.

Thanks!
