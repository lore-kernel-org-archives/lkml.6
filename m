Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520825048-2-14760159294232782496
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825048; b=j+cjbs4kpOT89YYhKa31nJPDeM+al8HOaMseKCEIgi0UHW5
    uevxncc+XkLJPIFlp8ULTvffh31OGeDeeNp7FAu+c1uaPHPZuYEszmK+Du9GbvF5
    Zhmgv1AN/XuG7NiJGoEWuv2hKGxXoG1ajI5o4/zYKvrrHqcbb5EVJgqTv1HLivnQ
    Jiz8XtwHRriVk57DH9yHk/S0Bq/2ojI+8UAFqnsa7q6sZLABTTlWnQctkYRLrvlL
    04G4DkOjxlu6xdaJnKPn08Ri2LZP4LQDg1lEW2mCJvl0dZjtLTtkT5FRd06iN3qz
    QsZNdVnw81+R1Ev/pR1q7V9oXUuby7SCg0Quf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825048; bh=XFZ9/smGeyCOs1LA+j7
    TjQB3sqcBhnEH7W+ZMzP37cY=; b=k9A39ZJyWZtE+uBHzvCVA9fLc/nWP11JRj9
    CvOYPcFm5EXkrZygOqrofzk4EPP06w7Fh0wb6y/pvrK+OzFOzEofi/baCRmBzI25
    75SYpR1aBZ6tOoVrKQkcF+Q2CmdWkbJw3NR06JOVn2u6RdAKbu9nG6MdiGh2LHnt
    QSez9slMzIWf41WrNDqjeJWjVkFoBslWmfYDRY4vAMdMPmpMo8YKUwUuxyrHe8Rt
    ec7kgmUuMe/BXXH+uPA1neCkQJ6a4n3BshhVOSSuwy0FVwWt4oSIcRZt9w3H0Czb
    ByQEE5L2brD4LYmqXfxXRbKoJ9MpH85bP0a6xpgnBerHnKtPTdg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeCLDXv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:23:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41243 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932689AbeCLDHo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:44 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Kalle Valo" <kvalo@qca.qualcomm.com>,
        "Jason Liu" <r64343@freescale.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.197939003@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 019/104] ath6kl: fix struct hif_scatter_req list handling
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kalle Valo <kvalo@qca.qualcomm.com>

commit 31b9cc9a873dcab161999622314f98a75d838975 upstream.

Jason noticed that with Yocto GCC 4.8.1 ath6kl crashes with this iperf command:

iperf -c $TARGET_IP -i 5 -t 50 -w 1M

The crash was:

Unable to handle kernel paging request at virtual address 1a480000
pgd = 80004000
[1a480000] *pgd=00000000
Internal error: Oops: 805 [#1] SMP ARM
Modules linked in: ath6kl_sdio ath6kl_core [last unloaded: ath6kl_core]
CPU: 0 PID: 1953 Comm: kworker/u4:0 Not tainted 3.10.9-1.0.0_alpha+dbf364b #1
Workqueue: ath6kl ath6kl_sdio_write_async_work [ath6kl_sdio]
task: dcc9a680 ti: dc9ae000 task.ti: dc9ae000
PC is at v7_dma_clean_range+0x20/0x38
LR is at dma_cache_maint_page+0x50/0x54
pc : [<8001a6f8>]    lr : [<800170fc>]    psr: 20000093
sp : dc9afcf8  ip : 8001a748  fp : 00000004
r10: 00000000  r9 : 00000001  r8 : 00000000
r7 : 00000001  r6 : 00000000  r5 : 80cb7000  r4 : 03f9a480
r3 : 0000001f  r2 : 00000020  r1 : 1a480000  r0 : 1a480000
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 6cc5004a  DAC: 00000015
Process kworker/u4:0 (pid: 1953, stack limit = 0xdc9ae238)
Stack: (0xdc9afcf8 to 0xdc9b0000)
fce0:                                                       80c9b29c 00000000
fd00: 00000000 80017134 8001a748 dc302ac0 00000000 00000000 dc454a00 80c12ed8
fd20: dc115410 80017238 00000000 dc454a10 00000001 80017588 00000001 00000000
fd40: 00000000 dc302ac0 dc9afe38 dc9afe68 00000004 80c12ed8 00000000 dc454a00
fd60: 00000004 80436f88 00000000 00000000 00000600 0000ffff 0000000c 80c113c4
fd80: 80c9b29c 00000001 00000004 dc115470 60000013 dc302ac0 dc46e000 dc302800
fda0: dc9afe10 dc302b78 60000013 dc302ac0 dc46e000 00000035 dc46e5b0 80438c90
fdc0: dc9afe10 dc302800 dc302800 dc9afe68 dc9afe38 80424cb4 00000005 dc9afe10
fde0: dc9afe20 80424de8 dc9afe10 dc302800 dc46e910 80424e90 dc473c00 dc454f00
fe00: 000001b5 7f619d64 dcc7c830 00000000 00000000 dc9afe38 dc9afe68 00000000
fe20: 00000000 00000000 dc9afe28 dc9afe28 80424d80 00000000 00000035 9cac0034
fe40: 00000000 00000000 00000000 00000000 000001b5 00000000 00000000 00000000
fe60: dc9afe68 dc9afe10 3b9aca00 00000000 00000080 00000034 00000000 00000100
fe80: 00000000 00000000 dc9afe10 00000004 dc454a00 00000000 dc46e010 dc46e96c
fea0: dc46e000 dc46e964 00200200 00100100 dc46e910 7f619ec0 00000600 80c0e770
fec0: dc15a900 dcc7c838 00000000 dc46e954 8042d434 dcc44680 dc46e954 dc004400
fee0: dc454500 00000000 00000000 dc9ae038 dc004400 8003c450 dcc44680 dc004414
ff00: dc46e954 dc454500 00000001 dcc44680 dc004414 dcc44698 dc9ae000 dc9ae030
ff20: 00000001 dc9ae000 dc004400 8003d158 8003d020 00000000 00000000 80c53941
ff40: dc9aff64 dcb71ea0 00000000 dcc44680 8003d020 00000000 00000000 00000000
ff60: 00000000 80042480 00000000 00000000 000000f8 dcc44680 00000000 00000000
ff80: dc9aff80 dc9aff80 00000000 00000000 dc9aff90 dc9aff90 dc9affac dcb71ea0
ffa0: 800423cc 00000000 00000000 8000e018 00000000 00000000 00000000 00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<8001a6f8>] (v7_dma_clean_range+0x20/0x38) from [<800170fc>] (dma_cache_maint_page+0x50/0x54)
[<800170fc>] (dma_cache_maint_page+0x50/0x54) from [<80017134>] (__dma_page_cpu_to_dev+0x34/0x9c)
[<80017134>] (__dma_page_cpu_to_dev+0x34/0x9c) from [<80017238>] (arm_dma_map_page+0x64/0x68)
[<80017238>] (arm_dma_map_page+0x64/0x68) from [<80017588>] (arm_dma_map_sg+0x7c/0xf4)
[<80017588>] (arm_dma_map_sg+0x7c/0xf4) from [<80436f88>] (sdhci_send_command+0x894/0xe00)
[<80436f88>] (sdhci_send_command+0x894/0xe00) from [<80438c90>] (sdhci_request+0xc0/0x1ec)
[<80438c90>] (sdhci_request+0xc0/0x1ec) from [<80424cb4>] (mmc_start_request+0xb8/0xd4)
[<80424cb4>] (mmc_start_request+0xb8/0xd4) from [<80424de8>] (__mmc_start_req+0x60/0x84)
[<80424de8>] (__mmc_start_req+0x60/0x84) from [<80424e90>] (mmc_wait_for_req+0x10/0x20)
[<80424e90>] (mmc_wait_for_req+0x10/0x20) from [<7f619d64>] (ath6kl_sdio_scat_rw.isra.10+0x1dc/0x240 [ath6kl_sdio])
[<7f619d64>] (ath6kl_sdio_scat_rw.isra.10+0x1dc/0x240 [ath6kl_sdio]) from [<7f619ec0>] (ath6kl_sdio_write_async_work+0x5c/0x104 [ath6kl_sdio])
[<7f619ec0>] (ath6kl_sdio_write_async_work+0x5c/0x104 [ath6kl_sdio]) from [<8003c450>] (process_one_work+0x10c/0x370)
[<8003c450>] (process_one_work+0x10c/0x370) from [<8003d158>] (worker_thread+0x138/0x3fc)
[<8003d158>] (worker_thread+0x138/0x3fc) from [<80042480>] (kthread+0xb4/0xb8)
[<80042480>] (kthread+0xb4/0xb8) from [<8000e018>] (ret_from_fork+0x14/0x3c)
Code: e1a02312 e2423001 e1c00003 f57ff04f (ee070f3a)
---[ end trace 0c038f0b8e0b67a3 ]---
Kernel panic - not syncing: Fatal exception

Jason's analysis:

  "The GCC 4.8.1 compiler will not do the for-loop till scat_entries, instead,
   it only run one round loop. This may be caused by that the GCC 4.8.1 thought
   that the scat_list only have one item and then no need to do full iteration,
   but this is simply wrong by looking at the assebly code. This will cause the sg
   buffer not get set when scat_entries > 1 and thus lead to kernel panic.

   Note: This issue not observed with GCC 4.7.2, only found on the GCC 4.8.1)"

Fix this by using the normal [0] style for defining unknown number of list
entries following the struct. This also fixes corruption with scat_q_depth, which
was mistankely added to the end of struct and overwritten if there were more
than item in the scat list.

Reported-by: Jason Liu <r64343@freescale.com>
Tested-by: Jason Liu <r64343@freescale.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
[bwh: Backported to 3.2: There's no scat_q_depth field]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/wireless/ath/ath6kl/hif.h
+++ b/drivers/net/wireless/ath/ath6kl/hif.h
@@ -183,7 +183,7 @@ struct hif_scatter_req {
 	/* bounce buffer for upper layers to copy to/from */
 	u8 *virt_dma_buf;
 
-	struct hif_scatter_item scat_list[1];
+	struct hif_scatter_item scat_list[0];
 };
 
 struct ath6kl_hif_ops {
--- a/drivers/net/wireless/ath/ath6kl/sdio.c
+++ b/drivers/net/wireless/ath/ath6kl/sdio.c
@@ -319,7 +319,7 @@ static int ath6kl_sdio_alloc_prep_scat_r
 	int i, scat_req_sz, scat_list_sz, sg_sz, buf_sz;
 	u8 *virt_buf;
 
-	scat_list_sz = (n_scat_entry - 1) * sizeof(struct hif_scatter_item);
+	scat_list_sz = n_scat_entry * sizeof(struct hif_scatter_item);
 	scat_req_sz = sizeof(*s_req) + scat_list_sz;
 
 	if (!virt_scat)
