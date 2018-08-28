Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D05C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CFF2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GfbzSslY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CFF2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeH2ADg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:03:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35362 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeH2ADf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:03:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9-v6so1208606plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=rvChJWP4unRCLbY7spu4ZAfy9XwoJJc3+7HQGB31KEU=;
        b=GfbzSslY1jfYYQR5b7MZWhjkvNl9d8R/ASuj8JrNxLXlDDOeeVC3JYI6Gklu7eY/RW
         IpMKgHmPKIz+pwjvPaesaHMzJgAUr5JjJoX5tbPd4gcEmNhGPJHEy2ZvEx8S7bDZduvf
         s6RgvlLPNDe+LALuv60LyABOBZrb769S1+dlgZAEFylNJES3zJokVSCuTNhkVRxS3VCl
         tXO14BQLgTP9NAqmKLfUEAm5jkS0ckhL2M5N0Tyq/smZG8N8nKAAY+Rr6ZtfRZwj9Dh9
         YHOcICDoyjdO7B86ZuMVymCv3qMKyiFpXGxuBpC8YevEgO+6987lYGc3WlmnZ5zsu1Hq
         mQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=rvChJWP4unRCLbY7spu4ZAfy9XwoJJc3+7HQGB31KEU=;
        b=LedxVMv1wRItkfkRQFRoGqlvocB09THv59PdG2MwgimjVa1GGlvVQNe2Bn0+PE7UK/
         OyRPo75Ti/dmKFHwmUT6LDv5VCiBbztgJPCYNGgrZxPDh5WNgkwr245OPH1VDa3FnCwl
         R9fKjBPryVOkh2+qU05AGTlEPzlGCBgk8UmmEEOctSb0uJ32rMSqceTTj/ZTMXKWWlQa
         0Dy5ekYLC2SIh1K4+9YoPPZuAkYqgNo21Z+xEeWSoL++fYDJgWwxan4kNF2LEP6qAMuz
         142LkO6qfrZeDJGcW73f078e9SqduI130RqeM+Dmug3x1UxM4vufgIcaIrPcJj0b/5cG
         GDmg==
X-Gm-Message-State: APzg51DswDzVTlhrWfdH1t7fPeS2rnsGEBxgC7OvYdBxMJ/SkbVVSzF/
        814Ea5vXAdlRFu5FVZlSuJTeog==
X-Google-Smtp-Source: ANB0VdZC7j+0FVh8Ct0riv2LEaGW41b6jdPw0m+4CddNIsnCdvBIbKXuuARBGht7wO1UgKpFJ6tnFw==
X-Received: by 2002:a17:902:4403:: with SMTP id k3-v6mr2842383pld.243.1535487022012;
        Tue, 28 Aug 2018 13:10:22 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id v140-v6sm4174308pgb.45.2018.08.28.13.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 13:10:20 -0700 (PDT)
Date:   Tue, 28 Aug 2018 13:10:20 -0700 (PDT)
X-Google-Original-Date: Tue, 28 Aug 2018 13:10:15 PDT (-0700)
Subject:     Re: [PATCH] riscv: Drop setup_initrd
In-Reply-To: <1533874300-17656-1-git-send-email-linux@roeck-us.net>
CC:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux@roeck-us.net
Message-ID: <mhng-7faee2bb-ee3e-48d1-a016-782ebbbb903d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Aug 2018 21:11:40 PDT (-0700), linux@roeck-us.net wrote:
> setup_initrd() does not appear to serve a practical purpose other than
> preventing qemu boots with "-initrd" parameter, so let's drop it.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/riscv/kernel/setup.c | 39 ---------------------------------------
>  1 file changed, 39 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 2e56af3281f8..579f58a42974 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -82,41 +82,6 @@ EXPORT_SYMBOL(empty_zero_page);
>  /* The lucky hart to first increment this variable will boot the other cores */
>  atomic_t hart_lottery;
>
> -#ifdef CONFIG_BLK_DEV_INITRD
> -static void __init setup_initrd(void)
> -{
> -	extern char __initramfs_start[];
> -	extern unsigned long __initramfs_size;
> -	unsigned long size;
> -
> -	if (__initramfs_size > 0) {
> -		initrd_start = (unsigned long)(&__initramfs_start);
> -		initrd_end = initrd_start + __initramfs_size;
> -	}
> -
> -	if (initrd_start >= initrd_end) {
> -		printk(KERN_INFO "initrd not found or empty");
> -		goto disable;
> -	}
> -	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
> -		printk(KERN_ERR "initrd extends beyond end of memory");
> -		goto disable;
> -	}
> -
> -	size =  initrd_end - initrd_start;
> -	memblock_reserve(__pa(initrd_start), size);
> -	initrd_below_start_ok = 1;
> -
> -	printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
> -		(void *)(initrd_start), size);
> -	return;
> -disable:
> -	pr_cont(" - disabling initrd\n");
> -	initrd_start = 0;
> -	initrd_end = 0;
> -}
> -#endif /* CONFIG_BLK_DEV_INITRD */
> -
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>
> @@ -195,10 +160,6 @@ static void __init setup_bootmem(void)
>  	set_max_mapnr(PFN_DOWN(mem_size));
>  	max_low_pfn = pfn_base + PFN_DOWN(mem_size);
>
> -#ifdef CONFIG_BLK_DEV_INITRD
> -	setup_initrd();
> -#endif /* CONFIG_BLK_DEV_INITRD */
> -
>  	early_init_fdt_reserve_self();
>  	early_init_fdt_scan_reserved_mem();
>  	memblock_allow_resize();

With this patch I can't boot in QEMU.  It might be something with my setup, 
though.  I'm testing with a unified BBL+vmlinux, and using QEMU 3.0.0-rc3 (I 
should probably update that one, but I don't remember anything going by).  Do 
you have time to take a look?  Here's my QEMU commandline

./riscv64-softmmu/qemu-system-riscv64    -nographic    -machine virt    -smp 4    -m 2G    -kernel /home/palmer/work/riscv/riscv-pk/build/bbl -object rng-random,filename=/dev/urandom,id=rng0    -device virtio-rng-device,rng=rng0    -append "console=ttyS0 ro root=/dev/vda"    -device virtio-blk-device,drive=hd0    -drive file=stage4-disk.img,format=raw,id=hd0    -device virtio-net-device,netdev=usernet    -netdev user,id=usernet,hostfwd=tcp::10000-:22

I just tagged the PR I plan to submit for RC2 tomorrow, so at least it should 
be easy for everyone to get on the same page.
