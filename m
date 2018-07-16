Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36C7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8785E208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8785E208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeGPRNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:13:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38974 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeGPRNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:13:12 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D49C1A73;
        Mon, 16 Jul 2018 16:44:57 +0000 (UTC)
Date:   Mon, 16 Jul 2018 18:44:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/67] 4.17.7-stable review
Message-ID: <20180716164455.GA17550@kroah.com>
References: <20180716073443.294323458@linuxfoundation.org>
 <20180716163338.GD12065@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716163338.GD12065@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:33:38AM -0700, Guenter Roeck wrote:
> On Mon, Jul 16, 2018 at 09:34:29AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.17.7 release.
> > There are 67 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Jul 18 07:34:11 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 134 pass: 134 fail: 0
> Qemu test results:
> 	total: 171 pass: 159 fail: 12
> Failed tests: 
> 	i386:Broadwell:q35:defconfig:smp:rootfs 
> 	i386:Skylake-Client:q35:defconfig:smp:rootfs 
> 	i386:SandyBridge:q35:defconfig:smp:rootfs
> 	i386:Haswell:pc:defconfig:smp:rootfs 
> 	i386:Nehalem:q35:defconfig:smp:rootfs 
> 	i386:phenom:pc:defconfig:smp:rootfs 
> 	i386:Opteron_G5:q35:defconfig:smp:initrd 
> 	i386:Westmere:q35:defconfig:smp:initrd 
> 	i386:core2duo:q35:defconfig:nosmp:rootfs 
> 	i386:Conroe:pc:defconfig:nosmp:rootfs 
> 	i386:Opteron_G1:pc:defconfig:nosmp:initrd
> 	i386:n270:q35:defconfig:nosmp:rootfs
> 
> All 32-bit i386 boot tests crash.
> 
> [    0.000000] BUG: unable to handle kernel NULL pointer dereference at 00000000
> [    0.000000] *pde = 00000000 
> [    0.000000] Oops: 0002 [#1] SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.7-rc1+ #1
> [    0.000000] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/24
> [    0.000000] EIP: zero_resv_unavail+0x9b/0x103
> [    0.000000] EFLAGS: 00200002 CPU: 0
> [    0.000000] EAX: 00000000 EBX: 00000000 ECX: 00000008 EDX: 00000000
> [    0.000000] ESI: c6bc5e90 EDI: 00000000 EBP: c6bc5eac ESP: c6bc5e80
> [    0.000000]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> [    0.000000] CR0: 80050033 CR2: 00000000 CR3: 06d67000 CR4: 00040690
> [    0.000000] Call Trace:
> [    0.000000]  free_area_init_nodes+0x407/0x44c
> [    0.000000]  zone_sizes_init+0x45/0x5c
> [    0.000000]  paging_init+0xac/0xaf
> [    0.000000]  native_pagetable_init+0xc6/0xce
> [    0.000000]  setup_arch+0x9c6/0xb18
> [    0.000000]  start_kernel+0x4f/0x3d2
> [    0.000000]  ? idt_setup_early_handler+0x2b/0x3e
> [    0.000000]  i386_start_kernel+0x95/0x99
> [    0.000000]  startup_32_smp+0x164/0x168

Yeah, Linus's tree also crashes from this same reason :(

A patch was just posted to hopefully fix this...

greg k-h
