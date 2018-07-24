Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA62ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5986420844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd07nWGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5986420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbeGXTDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:03:22 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41181 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388382AbeGXTDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:03:22 -0400
Received: by mail-yb0-f193.google.com with SMTP id s8-v6so1960598ybe.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 10:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xkts1gHcPkkKBxRFUew8fK4lIXHpqts66muTtsf8xDk=;
        b=Wd07nWGzLVhDvRlyvBtY24tQGSK4TJNVzASMpbtYe7Sgf1GAGQcd2j2kqnLVOvRz+4
         bB087BEhvz8H2yYdnLpyzAeaYegON6u4quyJF75/lWui2qrtphrsE9XX3O0HOmxFMNSx
         QCZ5+HaI311ToWj2wpiSLt+rCljnLdDWv8Wp1PSLwQnRPeDYnobEOwvyr3we76h5eDlS
         kE6EWc/wo5rue8IuVg4xxiC5hOW0mO4OwxU63tuxZjLQci60KZahPcODDojCQvucRa6b
         e7FJ1lVCAXPRCUvFqwLihsNsr6EFo1jRIPS01tNqD6cssdDVeuG5qJswcPnBxEKnNgme
         Ii/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=xkts1gHcPkkKBxRFUew8fK4lIXHpqts66muTtsf8xDk=;
        b=lXKYCu2MiuuwEll3iotj2wZXexoOzWLz/N504kviFskxLmqSk/r1gI3Pg8bHP7N+Xa
         Ix8wJf/wu4bUFk8gvZ0srQkrxNF+spDu0yKRFXbSKLlISEVPhEXFarH26vSDTloT7/f5
         VyS6XGyXEelP2CGIz1G18czPhSZO1/pzLKnbnOOJDObC8Kg0lD18DKMO20v9MEs+JJYI
         LtAvi9ysVV+7uH/KADih+JSgXYQ206VmQNsWpHRZlqz2v8AewosCB+YtnQkWRSVmSgj7
         EyCQbbICZJXA0gqDUsPJbE1qabaE+Zg29HZkNJ3moZnp9ZJbC2O7sbXjUt5gG06OW5oX
         a1iA==
X-Gm-Message-State: AOUpUlGazS9HWPwXEPHDqrAptnDPIbIkRUoy7jnGIPd25IMpJJ3rlZny
        Tf4N/AOTT33xCfFL+vcNHvR3p/U+
X-Google-Smtp-Source: AAOMgpdvyuZ8+jxbrL7MUErM8e0CZ8B4NjZgiXKPG/F+w96P6n9JBKC1+BuF7JH9foh8DTanw/FLVg==
X-Received: by 2002:a25:5605:: with SMTP id k5-v6mr9807558ybb.170.1532454944468;
        Tue, 24 Jul 2018 10:55:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:c936])
        by smtp.gmail.com with ESMTPSA id p3-v6sm3754320ywm.82.2018.07.24.10.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 10:55:43 -0700 (PDT)
Date:   Tue, 24 Jul 2018 10:55:42 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com
Subject: [PATCH] delayacct: Fix crash in delayacct_blkio_end() after
 delayacct init failure
Message-ID: <20180724175542.GP1934745@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While forking, if delayacct init fails due to memory shortage, it
continues expecting all delayacct users to check task->delays pointer
against NULL before dereferencing it, which all of them used to do.

c96f5471ce7d ("delayacct: Account blkio completion on the correct
task"), while updating delayacct_blkio_end() to take the target task
instead of always using %current, made the function test NULL on
%current->delays and then continue to operated on @p->delays.  If
%current succeeded init while @p didn't, it leads to the following
crash.

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000004
 IP: __delayacct_blkio_end+0xc/0x40
 PGD 8000001fd07e1067 P4D 8000001fd07e1067 PUD 1fcffbb067 PMD 0 
 Oops: 0000 [#1] SMP PTI
 CPU: 4 PID: 25774 Comm: QIOThread0 Not tainted 4.16.0-9_fbk1_rc2_1180_g6b593215b4d7 #9
 Hardware name: Quanta Leopard ORv2-DDR4/Leopard ORv2-DDR4, BIOS F06_3B12 08/17/2017
 RIP: 0010:__delayacct_blkio_end+0xc/0x40
 RSP: 0000:ffff881fff703bf8 EFLAGS: 00010086
 RAX: ffff881f1ec8b800 RBX: ffff8804f735cd54 RCX: ffff881fff703cb0
 RDX: 0000000000000002 RSI: 0000000000000003 RDI: 0000000000000000
 RBP: 0000000000000000 R08: 0000000000000000 R09: ffff881fff703cc0
 R10: 0000000000001000 R11: ffff881fd3f73d00 R12: ffff8804f735c600
 R13: 0000000000000000 R14: 000000000000001d R15: ffff881fff703cb0
 FS:  00007f5003f7d700(0000) GS:ffff881fff700000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000004 CR3: 0000001f401a6006 CR4: 00000000003606e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <IRQ>
  try_to_wake_up+0x2c0/0x600
  autoremove_wake_function+0xe/0x30
  __wake_up_common+0x74/0x120
  wake_up_page_bit+0x9c/0xe0
  mpage_end_io+0x27/0x70
  blk_update_request+0x78/0x2c0
  scsi_end_request+0x2c/0x1e0
  scsi_io_completion+0x20b/0x5f0
  blk_mq_complete_request+0xa2/0x100
  ata_scsi_qc_complete+0x79/0x400
  ata_qc_complete_multiple+0x86/0xd0
  ahci_handle_port_interrupt+0xc9/0x5c0
  ahci_handle_port_intr+0x54/0xb0
  ahci_single_level_irq_intr+0x3b/0x60
  __handle_irq_event_percpu+0x43/0x190
  handle_irq_event_percpu+0x20/0x50
  handle_irq_event+0x2a/0x50
  handle_edge_irq+0x80/0x1c0
  handle_irq+0xaf/0x120
  do_IRQ+0x41/0xc0
  common_interrupt+0xf/0xf
  </IRQ>

Fix it by updating delayacct_blkio_end() check @p->delays instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-and-debugged-by: Dave Jones <dsj@fb.com>
Cc: Josh Snyder <joshs@netflix.com>
Fixes: c96f5471ce7d ("delayacct: Account blkio completion on the correct task")
Cc: stable@vger.kernel.org # v4.15+
---
 include/linux/delayacct.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index e6c0448ebcc7..31c865d1842e 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -124,7 +124,7 @@ static inline void delayacct_blkio_start(void)
 
 static inline void delayacct_blkio_end(struct task_struct *p)
 {
-	if (current->delays)
+	if (p->delays)
 		__delayacct_blkio_end(p);
 	delayacct_clear_flag(DELAYACCT_PF_BLKIO);
 }
