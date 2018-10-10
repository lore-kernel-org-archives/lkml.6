Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51EDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5927F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3Q4uC3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5927F2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeJJVAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:00:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34477 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeJJVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:00:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id f18-v6so2577870plr.1;
        Wed, 10 Oct 2018 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+edI+ASG1NVs5ALqGgP0sn7bFvyecODrCWQKookEsPA=;
        b=h3Q4uC3i9y3TULiBrXdKZX0RgfNjEXktGZj38+XNrDyw2LsEZIjQDh02qInKkeHDZG
         zZRWIy1D69cqvTWv8BW0Vc4gSDTRMWMazzjmnV+AFsMaP6Q8GsszgRSHs3M/9taqsrOz
         UQCJnm2/r9JzmwUuXHsh5f7Wm3OFpvUqzjSGK85fgRgem6gOaB2lcMrUnFGfVhyP5ENM
         UhobQzmfJQsqDBXmu9GMlh79t/SfEXI/XbD6rdVBKN4/BGMQOzpNSuA+5AITB+gGWolS
         s73EEaYRhkq5A2z4daUpWeqlGJYivj1+kVlImHtnn/JzmtIGwzkEo/ZqY8eO3M6jjHtH
         3M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+edI+ASG1NVs5ALqGgP0sn7bFvyecODrCWQKookEsPA=;
        b=PemnHMNtOyNQDK3t/5oyEsIxTAMt5SgRcYJdHCFpBsNJZWDcsF5NqylUnjEMufAwCR
         tcnMLWbv3ZOvZSQaPwH/yYVmYH7mZ5uEWyeWF8FS+akuof+zZJRR+zK6BR9suwY4EYWe
         siHlKha2kU7a2h4NQASKcenolhY4kmj+3Qv42oFgPPfo1yDEa+PMuMFlcwsWX/XCT65e
         SR02pGywlf6NqsLeBr0/2Rjh6siUdjkPnTveLWWM/9l+BOgDWdGjI6uZVDPfCN0/r8oK
         v3nT2vxrf99YByHcH8fsY6ceu5sP5/3ZWwfWKitHIUMGf/QMDOcpfUuMruGTuo2aQwuh
         om5A==
X-Gm-Message-State: ABuFfoiJ+2/2/1lf3rBBt0NlwpB04nvBaEubwtYHEMOsxn6YiQ3dzhQe
        v08WeEn6F4hvnGtrzxlZrBBLq6MT
X-Google-Smtp-Source: ACcGV638UwjOHIy14YBM3v6Mi++GRhxCA45NLKnsaGptOLm4TLqmNwSn4gxBWsxSGIW+jS/RswRkUQ==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37-v6mr21581974plb.318.1539178688584;
        Wed, 10 Oct 2018 06:38:08 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t4-v6sm27937277pfh.45.2018.10.10.06.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 06:38:08 -0700 (PDT)
Date:   Wed, 10 Oct 2018 06:38:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Oct 10
Message-ID: <20181010133801.GA5304@roeck-us.net>
References: <20181010164627.36ba566b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010164627.36ba566b@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 04:46:27PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181009:
> 
> The ext4 tree lost its build failure.
> 
> The kvm-ppc tree gained a conflict against the kvm-arm tree.
> 
> Non-merge commits (relative to Linus' tree): 9423
>  8942 files changed, 420582 insertions(+), 194157 deletions(-)
> 
> ----------------------------------------------------------------------------

Another day, another (different) set of failures.

Build results:
	total: 135 pass: 122 fail: 13
Failed builds: 
	alpha:allmodconfig 
	arm64:allmodconfig 
	m68k:defconfig 
	m68k:allmodconfig 
	mips:allmodconfig 
	parisc:allmodconfig 
	powerpc:allmodconfig 
	powerpc:ppc6xx_defconfig 
	riscv:defconfig 
	s390:allmodconfig 
	s390:allnoconfig 
	sparc64:allmodconfig 
	xtensa:allmodconfig 
Qemu test results:
	total: 318 pass: 280 fail: 38
Failed tests: 
	riscv:virt:defconfig:initrd 
	riscv:virt:defconfig:virtio-blk:rootfs 
	sparc32:SPARCClassic:nosmp:sparc32_defconfig 
	sparc32:SPARCbook:nosmp:sparc32_defconfig 
	sparc32:SS-4:nosmp:sparc32_defconfig 
	sparc32:SS-5:nosmp:sparc32_defconfig 
	sparc32:SS-10:nosmp:sparc32_defconfig 
	sparc32:SS-20:nosmp:sparc32_defconfig 
	sparc32:SS-600MP:nosmp:sparc32_defconfig 
	sparc32:LX:nosmp:sparc32_defconfig 
	sparc32:Voyager:nosmp:sparc32_defconfig 
	sparc32:SPARCClassic:smp:sparc32_defconfig 
	sparc32:SPARCbook:smp:sparc32_defconfig 
	sparc32:SS-4:smp:sparc32_defconfig 
	sparc32:SS-5:smp:sparc32_defconfig 
	sparc32:SS-10:smp:sparc32_defconfig 
	sparc32:SS-20:smp:sparc32_defconfig 
	sparc32:SS-600MP:smp:sparc32_defconfig 
	sparc32:LX:smp:sparc32_defconfig 
	sparc32:Voyager:smp:sparc32_defconfig 
	sparc64:sun4u:smp:initrd 
	sparc64:sun4u:smp:ata:rootfs 
	sparc64:sun4u:smp:mmc:rootfs 
	sparc64:sun4u:smp:nvme:rootfs 
	sparc64:sun4u:smp:scsi[DC395]:rootfs 
	sparc64:sun4u:smp:scsi[MEGASAS]:rootfs 
	sparc64:sun4u:smp:scsi[AM53C974]:rootfs 
	sparc64:sun4u:smp:usb-xhci:rootfs 
	sparc64:sun4u:smp:usb-uas-xhci:rootfs 
	sparc64:sun4u:smp:virtio-pci:rootfs 
	sparc64:sun4v:smp:ata:rootfs 
	sparc64:sun4v:smp:nvme:rootfs 
	sparc64:sun4u:nosmp:ata:rootfs 
	sparc64:sun4v:nosmp:ata:rootfs 
	i386:pc:Penryn:defconfig:pae:smp:initrd 
	i386:pc:Westmere:defconfig:pae:smp:efi32:usb:rootfs 
	i386:q35:pentium3:defconfig:pae:nosmp:nvme:rootfs 
	i386:q35:coreduo:defconfig:pae:nosmp:efi32:mmc:rootfs

Details are available at https://kerneltests.org/builders/.

Guenter

---
Compile errors:

alpha, arm64, parisc, powerpc, s390, sparc64, xtensa:

drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c: In function 'cxgb4_thermal_get_trip_type':
drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c:48:11: error: 'struct adapter' has no member named 'ch_thermal'

mips:

net/sunrpc/auth_gss/gss_krb5_seal.c: In function 'gss_seq_send64_fetch_and_inc':
net/sunrpc/auth_gss/gss_krb5_seal.c:144:3: error: implicit declaration of function 'cmpxchg64'

riscv:

Building riscv:defconfig ... failed
--------------
Error log:
cc1: error: -march=c: ISA string must begin with rv32 or rv64
cc1: error: ABI requires -march=rv64

====
Crashes:

sparc32, sparc64:

(log is from sparc32)

Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
swapper(0): Oops [#1]
CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc7-next-20181009 #1
PSR: 41801fc2 PC: f03aee08 NPC: f03aee0c Y: 00000000    Not tainted
PC: <strrchr+0x1c/0x48>
%G: f04d2968 f03b23a4  00000000 00000000  00000001 00000066  f0480000 f0481b40
RPC: <device_node_string+0x150/0x4a8>
%L: f044c0a8 0000ffff  00000000 00000020  f0459000 f03afd8c  f0444928 f0481d08
%I: f0481d08 f0481d48  f04f5ba0 f0481ba8  f044e72c f0481b28  f0481b48 f03b3e58
Disabling lock debugging due to kernel taint
Caller[f03b3e58]: pointer+0x338/0x5f8
Caller[f03b4338]: vsnprintf+0x220/0x5d0
Caller[f03b4764]: snprintf+0x20/0x30
Caller[f04abddc]: build_path_component+0x1e8/0x214
Caller[f04bbeb8]: of_pdt_build_tree+0x54/0x138
Caller[f04bc020]: of_pdt_build_devicetree+0x84/0x98
Caller[f04abb40]: prom_build_devicetree+0x10/0x30
Caller[f04ad61c]: paging_init+0xc/0x24
Caller[f04ab570]: setup_arch+0x45c/0x494
Caller[f04a7b40]: start_kernel+0x48/0x458
Caller[f04a743c]: continue_boot+0x324/0x334
Caller[00000000]:   (null)

x86:

[    6.632088] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: pgd_alloc+0x2be/0x2c0
[    6.632088] 
[    6.632712] CPU: 0 PID: 717 Comm: kworker/u2:3 Not tainted 4.19.0-rc7-next-20181009 #1
[    6.632712] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
[    6.632712] Call Trace:
[    6.632712]  dump_stack+0x60/0x96
[    6.632712]  panic+0x8f/0x1c6
[    6.632712]  __stack_chk_fail+0x10/0x10
[    6.632712]  ? pgd_alloc+0x2be/0x2c0
[    6.632712]  pgd_alloc+0x2be/0x2c0
[    6.632712]  mm_init.isra.53+0x20c/0x230
[    6.632712]  mm_alloc+0x2b/0x40
[    6.632712]  __do_execve_file+0x289/0x900
[    6.632712]  ? rcu_read_lock_sched_held+0x47/0x90
[    6.632712]  do_execve+0x16/0x20
[    6.632712]  call_usermodehelper_exec_async+0x127/0x140
[    6.632712]  ? umh_complete+0x40/0x40
[    6.632712]  ret_from_fork+0x2e/0x38
[    6.632712] Kernel Offset: 0x7000000 from 0xc1000000 (relocation range: 0xc0000000-0xd07dffff)

