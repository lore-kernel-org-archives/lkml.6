Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE2DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12402087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcV3oQ3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12402087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeH2Aw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:52:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33155 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeH2Aw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:52:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3-v6so72354pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zP2vhvRRIF+Jwtn96Bpqg/PAKCrVD0T0OpGUAOgw1d8=;
        b=LcV3oQ3uv0S1HwObooCraRrrINmmKOnbvjBd2LokajHGfF8pnIms7AGXULHgkrfMiI
         MEl0UzL3ac8CnICsgMjviex0Shab54xRaMFN4SZmsX13e25dx1mayopJ8ewJ3RmfdnSB
         +QNQzvNVrmNCjJbRkoLK5LfdZVTdGb1t5HbZ/c2qTZenWBb7nzLK0jfmEDgyloMzUwVn
         ugNc9I+At/bVVeLRo5GxwVVE4A4cTTqHUFS8//WWqEHP8YPds7NkI5MUSB/2HY0xSCWW
         avDpilV0tMv0ngAaWm7ImLUS3JFqkKkfEj2a0jjmJckJKj4y20fbjF8SAojA4fy4dKK6
         fYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zP2vhvRRIF+Jwtn96Bpqg/PAKCrVD0T0OpGUAOgw1d8=;
        b=lEa0g2+W9YBJfPYsrqcZ3qUgqqXP8anKLi6amMPKBG0EDRS9S57u/XMvlgl1pqzx7M
         1qwkCswedUiiPZRfRZzswOstAnOOzTMuhc0F++VtpwKoL6XTMwR1HXIJsRBsZggmqpXa
         c1O5gqMRxj3MzAL88rpQ3tQO80kmGSoiHhlAUepME8qbga5yFIVFJhMTwTWGlP/VV8sZ
         ggtjJ5+1uELnDrii2VGXTr7CQpp+G3XLDEfhRYgZ+kNKLjm8xZsD/L53IDMD7gKzRDKp
         8Pg/XB8CVc6wgbSJWNCLK3bWXx0G4zv8OSspQCbZc44Wa3UEb1kYMDQoAxEst/iwCexE
         XEGg==
X-Gm-Message-State: APzg51A8ycrVxuM9YSD+55Ct+naMlnktaEr3ZByDzYLEtsbjgcWhwQbl
        O0eHe6sKN1sSWSMmotlgc40=
X-Google-Smtp-Source: ANB0VdZDYE2XzVmF4atOKPsYef2EYlqbAergua9oammI7UBAQukkGAnCDKw3CugG1P1fBoyfFVI/Jw==
X-Received: by 2002:a62:6f87:: with SMTP id k129-v6mr3055875pfc.26.1535489944003;
        Tue, 28 Aug 2018 13:59:04 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u13-v6sm2577061pfn.59.2018.08.28.13.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 13:59:03 -0700 (PDT)
Date:   Tue, 28 Aug 2018 13:59:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Drop setup_initrd
Message-ID: <20180828205902.GB31691@roeck-us.net>
References: <1533874300-17656-1-git-send-email-linux@roeck-us.net>
 <mhng-7faee2bb-ee3e-48d1-a016-782ebbbb903d@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-7faee2bb-ee3e-48d1-a016-782ebbbb903d@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 01:10:20PM -0700, Palmer Dabbelt wrote:
> On Thu, 09 Aug 2018 21:11:40 PDT (-0700), linux@roeck-us.net wrote:
> >setup_initrd() does not appear to serve a practical purpose other than
> >preventing qemu boots with "-initrd" parameter, so let's drop it.
> >
> >Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >---
> > arch/riscv/kernel/setup.c | 39 ---------------------------------------
> > 1 file changed, 39 deletions(-)
> >
> >diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> >index 2e56af3281f8..579f58a42974 100644
> >--- a/arch/riscv/kernel/setup.c
> >+++ b/arch/riscv/kernel/setup.c
> >@@ -82,41 +82,6 @@ EXPORT_SYMBOL(empty_zero_page);
> > /* The lucky hart to first increment this variable will boot the other cores */
> > atomic_t hart_lottery;
> >
> >-#ifdef CONFIG_BLK_DEV_INITRD
> >-static void __init setup_initrd(void)
> >-{
> >-	extern char __initramfs_start[];
> >-	extern unsigned long __initramfs_size;
> >-	unsigned long size;
> >-
> >-	if (__initramfs_size > 0) {
> >-		initrd_start = (unsigned long)(&__initramfs_start);
> >-		initrd_end = initrd_start + __initramfs_size;
> >-	}
> >-
> >-	if (initrd_start >= initrd_end) {
> >-		printk(KERN_INFO "initrd not found or empty");
> >-		goto disable;
> >-	}
> >-	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
> >-		printk(KERN_ERR "initrd extends beyond end of memory");
> >-		goto disable;
> >-	}
> >-
> >-	size =  initrd_end - initrd_start;
> >-	memblock_reserve(__pa(initrd_start), size);
> >-	initrd_below_start_ok = 1;
> >-
> >-	printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
> >-		(void *)(initrd_start), size);
> >-	return;
> >-disable:
> >-	pr_cont(" - disabling initrd\n");
> >-	initrd_start = 0;
> >-	initrd_end = 0;
> >-}
> >-#endif /* CONFIG_BLK_DEV_INITRD */
> >-
> > pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> > pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
> >
> >@@ -195,10 +160,6 @@ static void __init setup_bootmem(void)
> > 	set_max_mapnr(PFN_DOWN(mem_size));
> > 	max_low_pfn = pfn_base + PFN_DOWN(mem_size);
> >
> >-#ifdef CONFIG_BLK_DEV_INITRD
> >-	setup_initrd();
> >-#endif /* CONFIG_BLK_DEV_INITRD */
> >-
> > 	early_init_fdt_reserve_self();
> > 	early_init_fdt_scan_reserved_mem();
> > 	memblock_allow_resize();
> 
> With this patch I can't boot in QEMU.  It might be something with my setup,
> though.  I'm testing with a unified BBL+vmlinux, and using QEMU 3.0.0-rc3 (I
> should probably update that one, but I don't remember anything going by).
> Do you have time to take a look?  Here's my QEMU commandline
> 

Odd. Maybe 'RISC-V: Support separate firmware and kernel payload' creates
incompatibilities, or you have an embedded initrd in your kernel image
and that somehow doesn't work (I thought I tested that but maybe I didn't).

Unfortunately, I have no means to generate a unified bbl+vmlinux,
I would have to set it up, and I won't have time anytime soon to do that.
Guess we'll have to live with broken initrd for non-unified builds.
I'll just drop the initrd boot tests from my setup.

Guenter

> ./riscv64-softmmu/qemu-system-riscv64    -nographic    -machine virt    -smp 4    -m 2G    -kernel /home/palmer/work/riscv/riscv-pk/build/bbl -object rng-random,filename=/dev/urandom,id=rng0    -device virtio-rng-device,rng=rng0    -append "console=ttyS0 ro root=/dev/vda"    -device virtio-blk-device,drive=hd0    -drive file=stage4-disk.img,format=raw,id=hd0    -device virtio-net-device,netdev=usernet    -netdev user,id=usernet,hostfwd=tcp::10000-:22
> 
> I just tagged the PR I plan to submit for RC2 tomorrow, so at least it
> should be easy for everyone to get on the same page.
