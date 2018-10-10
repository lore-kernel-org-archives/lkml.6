Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DF8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B4221568
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+rTiA1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B4221568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJJIKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 04:10:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47017 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeJJIKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 04:10:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id a5-v6so1633572pgv.13;
        Tue, 09 Oct 2018 17:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NPmzsq6DjD5wzpqArBNTQzqgijPn3V3TT/phIKVsNx4=;
        b=e+rTiA1eqpO3265B+fiBD6qzDjdqIREVbNwdXd/BmML2FrqAKYUs/N8sF+D+JrzhWF
         kvhHn3xXErkxsLDRjbPN2hYc4kmLSYKL0fbKt1SGAKa57d0te/dJPUlY5Cbpkrl+mtK4
         RJE/tzDy814vhjrCYOAPtjEa6A9gIXcvlMkLgJT0pbSuvI01yNrUArtWjuQAQCM/zb83
         bC/22sqKQ3C6gtVI5LV5+feylPftMIbeOx810aGLa1Gu9s7o/bKnYwS6PiwXnoWKQLU1
         l7aent8Jj5etJqRjH9K0HQtkfU7Pxxdv1y/tnQ8WpkVJiyI7E7wtAFAF7Tvd9SuKsq3t
         F12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NPmzsq6DjD5wzpqArBNTQzqgijPn3V3TT/phIKVsNx4=;
        b=rIrGdJFFuKcPyxoeiRKxh7+FcY9icf6Vc4EJsW2NLdTBoXL1xMyt16h9DlAam9M0T9
         4aHMK6/4sYgP5QTd8flLXS/7Vq/cgOmxysdjNC8TzNb64TLqPjG+uE4OBRhh9EkfNHEN
         4c603l0bHWx6eVfSACvBD7mT8bwWT72OJ4NUmYMAnh50u1tnYk/TVN+Ofv1N8sDycQJd
         5jxbih4vsuRDjEzfjpVwIJWXovn8S+AYdp133ohNlNXe1uhj/qWegypmiqc1pyw4agOj
         FYMOPbklb0MyjGeOyJtq8obxUkhK1g7RA/Skr7GaFMrbYTAUvJ24CQ87s92lOu9Qdsyo
         M9vg==
X-Gm-Message-State: ABuFfojxjqwkSLDhMRskizA34SkkhSUbL6C0DHTrjQF4eJ0gmke58RY/
        H6rXwWB5Ejl6WI5vZ1eF7LoxWy+d
X-Google-Smtp-Source: ACcGV60ylYujo7Poq0E3KfRJovqoUuI2BSeRUPiAir21X9atUdeNMzST9hqw7JRhXsjcjAk2ptztVg==
X-Received: by 2002:a62:215b:: with SMTP id h88-v6mr32175847pfh.233.1539132656072;
        Tue, 09 Oct 2018 17:50:56 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m27-v6sm32639683pff.187.2018.10.09.17.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 17:50:55 -0700 (PDT)
Date:   Tue, 9 Oct 2018 17:50:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Oct 9
Message-ID: <20181010005054.GA22348@roeck-us.net>
References: <20181009190234.7ee02dc0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009190234.7ee02dc0@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 07:02:34PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181008:
> 
> The s390 tree gained a conflict against the compiler-attributes tree.
> 
> The ext4 tree gained a build failure for which I reverted a commit.
> 
> The nfsd tree lost its build failure.
> 
> The crypto tree lost its build failure.
> 
> The net-next tree gained a conflict against the net tree.
> 
> The drm-msm tree lost its build failure.
> 
> The tip tree gained a conflict against the s290 tree.
> 
> The irqchip tree lost its build failure.
> 
> The staging tree gained a conflict against the vfs tree.
> 
> The akpm tree gained conflicts against the s390 tree.
> 
> Non-merge commits (relative to Linus' tree): 9232
>  8813 files changed, 408912 insertions(+), 188393 deletions(-)
> 

Build results:
	total: 135 pass: 125 fail: 10
Failed builds: 
	arm:allmodconfig 
	arm64:defconfig 
	ia64:defconfig 
	ia64:allnoconfig 
	m68k:defconfig 
	m68k:allmodconfig 
	mips:allmodconfig 
	powerpc:ppc6xx_defconfig 
	riscv:defconfig 
	s390:allnoconfig 
Qemu test results:
	total: 318 pass: 287 fail: 31
Failed tests: 
	arm64:virt:defconfig:smp:mem512:initrd 
	arm64:virt:defconfig:smp2:mem512:usb-xhci:rootfs 
	arm64:virt:defconfig:smp4:mem512:usb-uas-xhci:rootfs 
	arm64:virt:defconfig:smp6:mem512:virtio:rootfs 
	arm64:virt:defconfig:smp8:mem512:virtio-pci:rootfs 
	arm64:virt:defconfig:smp:mem512:virtio-blk:rootfs 
	arm64:virt:defconfig:smp2:mem512:nvme:rootfs 
	arm64:virt:defconfig:smp4:mem512:mmc:rootfs 
	arm64:virt:defconfig:smp6:mem512:scsi[DC395]:rootfs 
	arm64:virt:defconfig:smp8:mem512:scsi[AM53C974]:rootfs 
	arm64:virt:defconfig:smp2:mem512:scsi[MEGASAS]:rootfs 
	arm64:virt:defconfig:smp4:mem512:scsi[MEGASAS2]:rootfs 
	arm64:virt:defconfig:smp6:mem512:scsi[53C810]:rootfs 
	arm64:virt:defconfig:smp8:mem512:scsi[53C895A]:rootfs 
	arm64:virt:defconfig:smp:mem512:scsi[FUSION]:rootfs 
	arm64:virt:defconfig:smp2:mem512:scsi[virtio]:rootfs 
	arm64:xlnx-zcu102:defconfig:smp:mem2G:initrd:xilinx/zynqmp-zcu102-rev1.0 
	arm64:xlnx-zcu102:defconfig:smp2:mem2G:sd1:rootfs:xilinx/zynqmp-zcu102-rev1.0 
	arm64:xlnx-zcu102:defconfig:smp4:mem2G:sata:rootfs:xilinx/zynqmp-zcu102-rev1.0 
	arm64:raspi3:defconfig:smp:mem1G:initrd:broadcom/bcm2837-rpi-3-b 
	arm64:raspi3:defconfig:smp4:mem1G:sd:rootfs:broadcom/bcm2837-rpi-3-b 
	arm64:virt:defconfig:nosmp:mem512:initrd 
	arm64:xlnx-zcu102:defconfig:nosmp:mem2G:initrd:xilinx/zynqmp-zcu102-rev1.0 
	arm64:xlnx-zcu102:defconfig:nosmp:mem2G:sd1:rootfs:xilinx/zynqmp-zcu102-rev1.0 
	riscv:virt:defconfig:initrd 
	riscv:virt:defconfig:virtio-blk:rootfs 
	i386:q35:Conroe:defconfig:smp4:scsi[DC395]:rootfs 
	i386:pc:Penryn:defconfig:pae:smp:initrd 
	i386:pc:Westmere:defconfig:pae:smp:efi32:usb:rootfs 
	i386:q35:pentium3:defconfig:pae:nosmp:nvme:rootfs 
	i386:q35:coreduo:defconfig:pae:nosmp:efi32:mmc:rootfs

Details are available at https://kerneltests.org/builders/.

Guenter
---

Build failures:

arm:

drivers/pci/pcie/aer_inject.c: In function 'aer_inject_ftrace_thunk':
drivers/pci/pcie/aer_inject.c:444:6: error: 'struct pt_regs' has no member named 'ip'

arm64, ia64:

drivers/acpi/numa.c:34:10: fatal error: asm/kaslr.h

m68k:

drivers/tty/amiserial.c:1076:3: error: 'retval' undeclared

mips, powerpc:

net/sunrpc/auth_gss/gss_krb5_seal.c:144:3: error:
	implicit declaration of function 'cmpxchg64'

riscv:

Building riscv:defconfig ... failed
--------------
Error log:
cc1: error: -march=c: ISA string must begin with rv32 or rv64
cc1: error: ABI requires -march=rv64

s390:

arch/s390/boot/mem_detect.c:122:12: error: 'EFAULT' undeclared 

Crash:

x86:

[    3.760333] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: pgd_alloc+0x2be/0x2c0
[    3.760333] 
[    3.761002] CPU: 0 PID: 717 Comm: kworker/u2:3 Not tainted 4.19.0-rc7-next-20181008 #1
[    3.761002] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
[    3.761002] Call Trace:
[    3.761002]  dump_stack+0x60/0x96
[    3.761002]  panic+0x8f/0x1c6
[    3.761002]  __stack_chk_fail+0x10/0x10
[    3.761002]  ? pgd_alloc+0x2be/0x2c0
[    3.761002]  pgd_alloc+0x2be/0x2c0
[    3.761002]  mm_init.isra.53+0x20c/0x230
[    3.761002]  mm_alloc+0x2b/0x40
[    3.761002]  __do_execve_file+0x289/0x900
[    3.761002]  ? rcu_read_lock_sched_held+0x47/0x90
[    3.761002]  ? azx_pcm_open+0x3b9/0x3c0
[    3.761002]  do_execve+0x16/0x20
[    3.761002]  call_usermodehelper_exec_async+0x127/0x140
[    3.761002]  ? umh_complete+0x40/0x40
[    3.761002]  ret_from_fork+0x2e/0x38
[    3.761002] Kernel Offset: 0xb800000 from 0xc1000000 (relocation range: 0xc0000000-0xd07dffff)

