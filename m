Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A49C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AD920652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U2gFypul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AD920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeJWC5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:57:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40340 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbeJWC5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 22:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aM/fuq/0MDzfQKIaVviCng8QeMKEDWkom4BVH+Nc010=; b=U2gFypul/524BQfbrZPxm9Nn0k
        hp3Zh6+DccGnuQnOMraGlXIDPrRlM00KHcVjc4W687hDeIpjQS0PuNWbXDXJKhyx9D5B87v6aeSdF
        f80vPcEKHb80v2ic7vNKP5HdCwmBaUMrknp9D40C2gE/1uvhYblh3tTQuTbvSv/9YG3vlFtRC4w4Z
        StJ8ptUCfLAkb3UKrQv/EzOEsqLZMO5+q3Orp2bPFAwrO/6ZDB3usBkOjCQBjW0A+VqZVcGQ9P1Ji
        cEalhkrGJrHRe5rDFDbPUejOQVTy0yJwxJCf8ot4YzL0q7M38C3v/LGP4M3BoE29bvHcRyQGlQeVu
        OyJTxzkg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEf50-0005sL-Ef; Mon, 22 Oct 2018 18:37:30 +0000
Subject: Re: 4.18: early boot crash in thermal_cooling_device_destroy_sysfs
From:   Randy Dunlap <rdunlap@infradead.org>
To:     ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <c1e0c7c7-2ed9-39fd-b3e0-aebf4d5839a3@infradead.org>
Message-ID: <4a200a32-7d7f-1248-2ecd-74600083b1c1@infradead.org>
Date:   Mon, 22 Oct 2018 11:37:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c1e0c7c7-2ed9-39fd-b3e0-aebf4d5839a3@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/16/18 2:33 PM, Randy Dunlap wrote:
> Hi,
> 
> Sorry for the photo.  That's all I have available so far.
> 
> https://www.infradead.org/~rdunlap/doc/IMG_20180816_133254743_HDR.jpg
> 
> 
> Does anyone recognize this?
> 
> This is an (older) Toshiba laptop.  The kernel .config is mostly an
> allmodconfig with some DEBUG options disabled and other options enabled
> so that it can boot without using an initramfs.  (and with COMPILE_TEST
> disabled :)
> 
> 
> The full kernel .config file is attached.
> 
> Thanks,
> 

This is a result of CONFIG_DEBUG_TEST_DRIVER_REMOVE=y.
[switch from 64-bit to 32-bit machine]


When using CONFIG_DEBUG_VM=y, it BUGs at:
[    5.553603] ------------[ cut here ]------------
[    5.553733] kernel BUG at arch/x86/mm/physaddr.c:75!
[    5.557788] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
[    5.558738] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7 #4
[    5.558738] Hardware name: Dell Inc. Inspiron 1318                   /0C236D, BIOS A04 01/15/2009
[    5.558738] EIP: __phys_addr+0x40/0x90
[    5.558738] Code: 00 40 75 2e 8b 15 00 57 23 d5 85 d2 74 12 89 d9 c1 e9 0c 39 ca 72 5b e8 2e ca ff ff 39 d8 75 4a 89 d8 5b 5d c3 8d 74 26 00 90 <0f> 0b 8d b6 00 00 00 00 8b 0d 80 56 23 d5 8d 91 00 00 80 00 39 d0
[    5.558738] EAX: 6b6b6b6b EBX: 6b6b6b6b ECX: 00140011 EDX: 00000000
[    5.558738] ESI: f4890000 EDI: d4a58d60 EBP: f40c1e0c ESP: f40c1e08
[    5.558738] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210a97
[    5.558738] CR0: 80050033 CR2: 00000000 CR3: 14cad000 CR4: 000406d0
[    5.558738] Call Trace:
[    5.558738]  kfree+0x1f/0x160
[    5.558738]  thermal_cooling_device_destroy_sysfs+0x11/0x20
[    5.558738]  thermal_cooling_device_unregister+0x168/0x180
[    5.558738]  acpi_pss_perf_exit.isra.4+0x32/0x50
[    5.558738]  acpi_processor_stop+0x4d/0x60
[    5.558738]  really_probe+0xa3/0x3e0
[    5.558738]  driver_probe_device+0x5b/0x120
[    5.558738]  __driver_attach+0xd9/0x100
[    5.558738]  ? driver_probe_device+0x120/0x120
[    5.558738]  bus_for_each_dev+0x56/0x90
[    5.558738]  driver_attach+0x14/0x20
[    5.558738]  ? driver_probe_device+0x120/0x120
[    5.558738]  bus_add_driver+0x117/0x210
[    5.558738]  driver_register+0x61/0xb0
[    5.558738]  acpi_processor_driver_init+0x19/0x88
[    5.558738]  ? acpi_pci_slot_init+0xf/0xf
[    5.558738]  do_one_initcall+0x3e/0x15a
[    5.558738]  ? do_early_param+0x75/0x75
[    5.558738]  kernel_init_freeable+0x170/0x1f3
[    5.558738]  ? rest_init+0xcd/0xcd
[    5.558738]  kernel_init+0x8/0xdb
[    5.558738]  ret_from_fork+0x2e/0x38
[    5.558738] Modules linked in:
[    5.625269] _warn_unseeded_randomness: 1 callbacks suppressed
[    5.625272] random: get_random_bytes called from init_oops_id+0x3a/0x40 with crng_init=0
[    5.629758] ---[ end trace 65b17bf4d18e7692 ]---
[    5.631573] EIP: __phys_addr+0x40/0x90
[    5.633242] Code: 00 40 75 2e 8b 15 00 57 23 d5 85 d2 74 12 89 d9 c1 e9 0c 39 ca 72 5b e8 2e ca ff ff 39 d8 75 4a 89 d8 5b 5d c3 8d 74 26 00 90 <0f> 0b 8d b6 00 00 00 00 8b 0d 80 56 23 d5 8d 91 00 00 80 00 39 d0
[    5.638618] EAX: 6b6b6b6b EBX: 6b6b6b6b ECX: 00140011 EDX: 00000000
[    5.640703] ESI: f4890000 EDI: d4a58d60 EBP: f40c1e0c ESP: d4cb13dc
[    5.642801] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210a97
[    5.645053] CR0: 80050033 CR2: 00000000 CR3: 14cad000 CR4: 000406d0
[    5.647179] Kernel panic - not syncing: Fatal exception
[    5.648172] Kernel Offset: 0x13000000 from 0xc1000000 (relocation range: 0xc0000000-0xf77fdfff)
[    5.648172] ---[ end Kernel panic - not syncing: Fatal exception ]---


When not using CONFIG_DEBUG_VM, it BUGs in kfree:
[    5.497864] ------------[ cut here ]------------
[    5.498215] kernel BUG at mm/slub.c:3901!
[    5.501739] invalid opcode: 0000 [#1] PREEMPT SMP
[    5.502720] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7 #3
[    5.502720] Hardware name: Dell Inc. Inspiron 1318                   /0C236D, BIOS A04 01/15/2009
[    5.502720] EIP: kfree+0x117/0x150
[    5.502720] Code: 74 21 8b 06 31 d2 f6 c4 80 74 04 0f b6 56 31 89 f0 e8 7d e0 fa ff e9 7b ff ff ff 8d b4 26 00 00 00 00 90 8b 46 04 a8 01 75 d8 <0f> 0b 8d b4 26 00 00 00 00 8b 75 f0 ff 75 ec 89 d9 89 f8 6a 01 53
[    5.502720] EAX: 00000100 EBX: 6b6b6b6b ECX: 00140011 EDX: 00000000
[    5.502720] ESI: f67dac70 EDI: ccc4aca0 EBP: f4083e28 ESP: f4083e10
[    5.502720] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210246
[    5.502720] CR0: 80050033 CR2: ffd14000 CR3: 0ce94000 CR4: 000406d0
[    5.502720] Call Trace:
[    5.502720]  thermal_cooling_device_destroy_sysfs+0x11/0x20
[    5.502720]  thermal_cooling_device_unregister+0x168/0x180
[    5.502720]  acpi_pss_perf_exit.isra.4+0x32/0x50
[    5.502720]  acpi_processor_stop+0x4d/0x60
[    5.502720]  really_probe+0xa3/0x3e0
[    5.502720]  driver_probe_device+0x5b/0x120
[    5.502720]  __driver_attach+0xd9/0x100
[    5.502720]  ? driver_probe_device+0x120/0x120
[    5.502720]  bus_for_each_dev+0x56/0x90
[    5.502720]  driver_attach+0x14/0x20
[    5.502720]  ? driver_probe_device+0x120/0x120
[    5.502720]  bus_add_driver+0x117/0x210
[    5.502720]  driver_register+0x61/0xb0
[    5.502720]  acpi_processor_driver_init+0x19/0x88
[    5.502720]  ? acpi_pci_slot_init+0xf/0xf
[    5.502720]  do_one_initcall+0x3e/0x15a
[    5.502720]  ? do_early_param+0x75/0x75
[    5.502720]  kernel_init_freeable+0x170/0x1f3
[    5.502720]  ? rest_init+0xcd/0xcd
[    5.502720]  kernel_init+0x8/0xdb
[    5.502720]  ret_from_fork+0x2e/0x38
[    5.502720] Modules linked in:
[    5.567678] _warn_unseeded_randomness: 1 callbacks suppressed
[    5.567682] random: get_random_bytes called from init_oops_id+0x3a/0x40 with crng_init=0
[    5.572237] ---[ end trace 1b6e88c03e412db2 ]---
[    5.574099] EIP: kfree+0x117/0x150
[    5.575673] Code: 74 21 8b 06 31 d2 f6 c4 80 74 04 0f b6 56 31 89 f0 e8 7d e0 fa ff e9 7b ff ff ff 8d b4 26 00 00 00 00 90 8b 46 04 a8 01 75 d8 <0f> 0b 8d b4 26 00 00 00 00 8b 75 f0 ff 75 ec 89 d9 89 f8 6a 01 53
[    5.581124] EAX: 00000100 EBX: 6b6b6b6b ECX: 00140011 EDX: 00000000
[    5.583243] ESI: f67dac70 EDI: ccc4aca0 EBP: f4083e28 ESP: cce983dc
[    5.585347] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210246
[    5.587600] CR0: 80050033 CR2: ffd14000 CR3: 0ce94000 CR4: 000406d0
[    5.589747] Kernel panic - not syncing: Fatal exception
[    5.590740] Kernel Offset: 0xb200000 from 0xc1000000 (relocation range: 0xc0000000-0xf77fdfff)
[    5.590740] ---[ end Kernel panic - not syncing: Fatal exception ]---



-- 
~Randy
