Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFE9C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 23:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D855218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 23:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQGZUQX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D855218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeHFBnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 21:43:52 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33499 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeHFBnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 21:43:52 -0400
Received: by mail-pl0-f66.google.com with SMTP id b90-v6so4050749plb.0;
        Sun, 05 Aug 2018 16:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mCnL6EiSaHP2dTWp9kSk771w/qzOCG61FwNdoAECNyY=;
        b=NQGZUQX45sGRT6uUvORh+ELs6OrXSwicavno8e9C2HebjZfkRAptGUFUNAks4bDw3y
         FYM6AQ+NXybSAEZIlhxNGIaQ8Tk9N0sjii2XhJW48DxjPtcx5reyDJJKoq4hO1z19Smq
         o9WvywPBkj/Kyioj8bNh+2LtCCy5sfvwZHghshSghlW1y5gqMz6d52DITDQ0D01PHNCh
         OMhDk9sBK6sk0WKx4oumG79Z0Es0fuowEBxzvrS7OI8WLGm7pDix9WP/nWa0h1fkj15r
         /ZKpmN9PL0FyoTWXu8l70CelweMr/q/mykSG+6KlRPjHrQYB5s9mWyBkHn+lrdL5BCPq
         0rUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=mCnL6EiSaHP2dTWp9kSk771w/qzOCG61FwNdoAECNyY=;
        b=cEffC8zClKdrK+ZgaLNks8uQ8vIjwKirbc30bevR+VuKAYs/dmeYjjLpxnm/pX7PNv
         ZPBQ4OyGYe7ghPPZ3fCV7O+A9WzUubzo8VFd59GiA2aT/28r3hsgmOGCdx2vLHqXn+Ut
         ntgune15aWyF0FdXIHLXxrgRVg61+aP5kBqDf45S+QQn9oUoVrBKukG956wRq0TPdsef
         WY/mduf1aChtMxFyuVobg+PMAJZtkKSs6HD6usltOqblFKRKZDAMr4g5offq9bC6goIJ
         n6DyBOzXUtpGzDTJIMFE2W2MdaxZX+e6EbO+U/Aym/4f3aU5BeS8FrrvAnhvVOMt+Wu5
         CNSg==
X-Gm-Message-State: AOUpUlGsv68XnY/OrVqgiyjtFUA3jVyoC9b4kqunaaNQ2IxZkG4d1Dvg
        E3zTOXM5eY3vVrsx60iXnZg=
X-Google-Smtp-Source: AAOMgpdeGMhEDnygjsoHh2zk13+Ek0PWFD+pNzHFveolN6jNRGZgidX4gu/p+tLwAgM8aFZUsk+kjg==
X-Received: by 2002:a17:902:740b:: with SMTP id g11-v6mr11767866pll.85.1533512250525;
        Sun, 05 Aug 2018 16:37:30 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id h132-v6sm15087190pfc.100.2018.08.05.16.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 16:37:28 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org,
        Tino Lehnig <tino.lehnig@contabo.de>
Subject: [PATCH v2] zram: remove BD_CAP_SYNCHRONOUS_IO with writeback feature
Date:   Mon,  6 Aug 2018 08:37:22 +0900
Message-Id: <20180805233722.217347-1-minchan@kernel.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If zram supports writeback feature, it's no longer a BD_CAP_SYNCHRONOUS_IO
device beause zram does asynchronous IO operations for incompressible pages.

Do not pretend to be synchronous IO device.  It makes the system very
sluggish due to waiting for IO completion from upper layers.

Furthermore, it causes a user-after-free problem because swap thinks the
opearion is done when the IO functions returns so it can free the page
(e.g., lock_page_or_retry and goto out_release in do_swap_page) but in
fact, IO is asynchronous so the driver could access a just freed page
afterward.

This patch fixes the problem.

BUG: Bad page state in process qemu-system-x86  pfn:3dfab21
page:ffffdfb137eac840 count:0 mapcount:0 mapping:0000000000000000 index:0x1
flags: 0x17fffc000000008(uptodate)
raw: 017fffc000000008 dead000000000100 dead000000000200 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag set
bad because of flags: 0x8(uptodate)
Modules linked in: lz4 lz4_compress zram zsmalloc intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel bin
fmt_misc pcbc aesni_intel aes_x86_64 crypto_simd cryptd iTCO_wdt glue_helper iTCO_vendor_support intel_cstate lpc_ich mei_me intel_uncore intel_rapl_perf pcspkr joydev sg mfd_core ioatdma mei wmi evdev ipmi_si ipmi_devintf ipmi_msghandler
acpi_power_meter acpi_pad button ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 fscrypto hid_generic usbhid hid sd_mod xhci_pci ehci_pci ahci libahci xhci_hcd ehci_hcd libata igb i2c_algo_bit crc32c_intel scsi_mod i2c_i8
01 dca usbcore
CPU: 4 PID: 1039 Comm: qemu-system-x86 Tainted: G    B 4.18.0-rc5+ #1
Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0b 05/02/2017
Call Trace:
 dump_stack+0x5c/0x7b
 bad_page+0xba/0x120
 get_page_from_freelist+0x1016/0x1250
 __alloc_pages_nodemask+0xfa/0x250
 alloc_pages_vma+0x7c/0x1c0
 do_swap_page+0x347/0x920
 ? __update_load_avg_se.isra.38+0x1eb/0x1f0
 ? cpumask_next_wrap+0x3d/0x60
 __handle_mm_fault+0x7b4/0x1110
 ? update_load_avg+0x5ea/0x720
 handle_mm_fault+0xfc/0x1f0
 __get_user_pages+0x12f/0x690
 get_user_pages_unlocked+0x148/0x1f0
 __gfn_to_pfn_memslot+0xff/0x3c0 [kvm]
 try_async_pf+0x87/0x230 [kvm]
 tdp_page_fault+0x132/0x290 [kvm]
 ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
 kvm_mmu_page_fault+0x74/0x570 [kvm]
 ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
 ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
 ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
 ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
 ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
 ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
 ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
 ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
 ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
 ? vmexit_fill_RSB+0x18/0x30 [kvm_intel]
 ? vmexit_fill_RSB+0xc/0x30 [kvm_intel]
 ? vmx_vcpu_run+0x375/0x620 [kvm_intel]
 kvm_arch_vcpu_ioctl_run+0x9b3/0x1990 [kvm]
 ? __update_load_avg_se.isra.38+0x1eb/0x1f0
 ? kvm_vcpu_ioctl+0x388/0x5d0 [kvm]
 kvm_vcpu_ioctl+0x388/0x5d0 [kvm]
 ? __switch_to+0x395/0x450
 ? __switch_to+0x395/0x450
 do_vfs_ioctl+0xa2/0x630
 ? __schedule+0x3fd/0x890
 ksys_ioctl+0x70/0x80
 ? exit_to_usermode_loop+0xca/0xf0
 __x64_sys_ioctl+0x16/0x20
 do_syscall_64+0x55/0x100
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fb30361add7
Code: 00 00 00 48 8b 05 c1 80 2b 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 80 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007fb2e97f98b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007fb30361add7
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000015
RBP: 00005652b984e0f0 R08: 00005652b7d513d0 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb308c66000 R14: 0000000000000000 R15: 00005652b984e0f0

* from v1
  - description correction - Andrew
  - add comment about removing BDI_CAP_SYNCHRONOUS_IO

Link: https://lore.kernel.org/lkml/0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de/
Link: http://lkml.kernel.org/r/20180802051112.86174-1-minchan@kernel.org
Signed-off-by: Minchan Kim <minchan@kernel.org>
Reported-by: Tino Lehnig <tino.lehnig@contabo.de>
Tested-by: Tino Lehnig <tino.lehnig@contabo.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: <stable@vger.kernel.org>	[4.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/block/zram/zram_drv.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 7436b2d27fa3..82aa1a1f383a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -298,7 +298,8 @@ static void reset_bdev(struct zram *zram)
 	zram->backing_dev = NULL;
 	zram->old_block_size = 0;
 	zram->bdev = NULL;
-
+	zram->disk->queue->backing_dev_info->capabilities |=
+				BDI_CAP_SYNCHRONOUS_IO;
 	kvfree(zram->bitmap);
 	zram->bitmap = NULL;
 }
@@ -400,6 +401,18 @@ static ssize_t backing_dev_store(struct device *dev,
 	zram->backing_dev = backing_dev;
 	zram->bitmap = bitmap;
 	zram->nr_pages = nr_pages;
+	/*
+ 	 * With writeback feature, zram does asynchronous IO so it's no longer
+ 	 * synchronous device so let's remove synchronous io flag. Othewise,
+	 * upper layer(e.g., swap) could wait IO completion rather than
+	 * (submit and return), which will cause system sluggish.
+ 	 * Furthermore, when the IO function returns(e.g., swap_readpage),
+ 	 * upper layer expects IO was done so it could deallocate the page
+ 	 * freely but in fact, IO is going on so finally could cause
+ 	 * use-after-free when the IO is really done.
+ 	 */
+	zram->disk->queue->backing_dev_info->capabilities &=
+			~BDI_CAP_SYNCHRONOUS_IO;
 	up_write(&zram->init_lock);
 
 	pr_info("setup backing device %s\n", file_name);
-- 
2.18.0.597.ga71716f1ad-goog

