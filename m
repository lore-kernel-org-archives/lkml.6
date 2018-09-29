Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23721C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C467C2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VUZawglJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C467C2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeI2Gjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:39:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42501 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeI2Gjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:39:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so5311290pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 17:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=V3PPVFuAw7d7GVOffOjIMLdLtbHfHXr85pTfXyiWsJg=;
        b=VUZawglJ9Gj9AWTj0MEcBfL4+GMk6ytyB2MixqEGPbO9t9Nxm93A44jNaMxkF8bp9L
         TsMcqN0qZAJO4Iwdl30YWMTVk2J7dCRZjW8cyRMfPshGQ0ozxf/vUOXp+005H/vMByNh
         KJItA7yuH2NvBUnYVhxpEM3quwzNlwg+qLQHyBvUpKKzGJpybcGq4bQQbxdTImU8n5BC
         x7C34AnT7YTF2CPfdxXn/nsIZ1++8ivl/V0/gND4+KCBRV56OYT6Qp4IVcn+jyYvGcwi
         okITfOEs9ExVx/cthmvWKlWpi9A7ymPDbSr9R0ubvieButxLdPZl3xaFUF0LHPghLmXI
         XNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=V3PPVFuAw7d7GVOffOjIMLdLtbHfHXr85pTfXyiWsJg=;
        b=QDwkGqdVdSlCbRPauhoVHVtOfYjdFekFeI/uV0vflCU9NJPU/dX15B2TyEq+4Es0aO
         rTDLXFkNZiNdJlFzymzZyEvzk8VNWW8uUOuA09j4rIh1MhDlyw1BlefqGCpe1hyKvqKu
         4xlmd5oJqDBwL7WoOYJFUIOIu3GbB5qXFwR9wuUjp66TkVXeGXLZJD1rHKe9fUqIvBje
         2QpaEymPT8lKDx7mRv7XtF/LIvH1hWHEuvyg+jtJ+LhBRwlNg/Z8lHDerRYI41Z+ILcV
         3lNP21Dzhbrqol+DETu6tFnNr+A/2e4taS2F87ylU8/pNfdu5wHcJ5/GF6c2sY2reDLR
         LV0Q==
X-Gm-Message-State: ABuFfognBSx1769ZDaCeYKIr8iBEWZyHAx/ql0kJtGpgyEwG0kRn5+sJ
        InF6kSgZWDVzEwJ3fDBui5zyWw==
X-Google-Smtp-Source: ACcGV63NVV+yR4S4LDI1GihzPGBOsTwQ4RXn4GpF0EqVOM6I+J9wlsLXCj5WlzJar6sTzy/srx08zA==
X-Received: by 2002:a62:11cb:: with SMTP id 72-v6mr900671pfr.120.1538180016459;
        Fri, 28 Sep 2018 17:13:36 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id q26-v6sm9309503pfj.127.2018.09.28.17.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 17:13:34 -0700 (PDT)
Date:   Fri, 28 Sep 2018 17:13:34 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Sep 2018 17:13:19 PDT (-0700)
Subject:     Re: [PATCH v5 00/12] SMP cleanup and new features
In-Reply-To: <1536863825-66808-1-git-send-email-atish.patra@wdc.com>
CC:     linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>, anup@brainfault.org,
        mark.rutland@arm.com, atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        Greg KH <gregkh@linuxfoundation.org>, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org, schwab@linux-m68k.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-206c9841-0e02-4d09-8860-160c0d917c94@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 11:36:53 PDT (-0700), atish.patra@wdc.com wrote:
> This patch series has updated the assorted cleanup series by palmer.
> The original cleanup patch series can be found here.
> http://lists.infradead.org/pipermail/linux-riscv/2018-August/001232.html
>
> It also implemented decoupling linux logical CPU ids from hart id.
> Some of the work has been inspired from ARM64.
> Tested on QEMU & HighFive Unleashed board with/without SMP enabled.
>
> Both the patch series have been combined to avoid conflicts as a lot
> of common code is changed in both the series. I have mostly addressed
> review comments and fixed checkpatch errors from palmer's series.
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
> Anup Patel (1):
>   RISC-V: No need to pass scause as arg to do_IRQ()
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
>  arch/riscv/include/asm/smp.h       | 38 ++++++++++++-----
>  arch/riscv/include/asm/tlbflush.h  | 16 ++++++--
>  arch/riscv/kernel/cacheinfo.c      |  7 ----
>  arch/riscv/kernel/cpu.c            | 83 ++++++++++++++++++++++++++++++++------
>  arch/riscv/kernel/entry.S          |  1 -
>  arch/riscv/kernel/head.S           |  4 +-
>  arch/riscv/kernel/irq.c            |  4 +-
>  arch/riscv/kernel/setup.c          | 10 +++++
>  arch/riscv/kernel/smp.c            | 43 +++++++++++++++-----
>  arch/riscv/kernel/smpboot.c        | 46 ++++++++++++++-------
>  drivers/clocksource/riscv_timer.c  | 12 ++++--
>  drivers/irqchip/irq-sifive-plic.c  | 10 +++--
>  13 files changed, 207 insertions(+), 69 deletions(-)

I didn't look closely because I assume your cleanups are better than mine, and 
than you at least gave this a boot test to ensure I didn't do anything too 
stupid :)

I'm preparing our first meaningful for-next now, I'll drop this one in.

Thanks for taking this over!
