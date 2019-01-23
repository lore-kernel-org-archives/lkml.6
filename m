Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A8AC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DBE20663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cY0J5UCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfAWQFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:05:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37839 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAWQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:05:22 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so1392009plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 08:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FLOTyyNnTJl7k3b7DE3t2hksrHJJG2IB4jPoHovPpdU=;
        b=cY0J5UCxZ7/zKwlRcY+dX4UiAtb38skUI+AVChN/fCt4lS/uWLqKnr/90/vjMM1z/h
         hzLZZDhMBTiKI+DQuc5GA2AzOtWH7kpKXcToUiXvC1bm/gtyBET9/svSow33lfy9/Mbz
         N6vzr3Lmf9ksEj4nTHjBkQnjkx1NaFKDFb1kMHLFU2Ix2rvMsoSlF5YH3X/HSq/533fg
         E5EAxPdPCwFgzpp7trv1TKun6vF2fYL+Cktlt3fg5aaA/qh7po9jcm6fVMG276N7pyNx
         k7+z28KOr20f8/7QQ7rqI+IBIx7bIpgC++cyqXBbpEHouzv0Oh03piw3TjsZi2Tx2Px6
         OYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FLOTyyNnTJl7k3b7DE3t2hksrHJJG2IB4jPoHovPpdU=;
        b=cKMuuXIs6jXskBjufSNZKFfKmBduJdP/Um7+HYxhDhfv6I65qD6jCL/L6oWDvk1QZy
         aPlglq6bCyzDoxZdjMyJszuF4VdLRi5hK/Jp8CniP6kFu15nkfJ/HIjphrF92ySrflCj
         obe6xxMc8NUC+wnwCTrcoQ9Wyc6OjrKPPytKLz5KaRHWEPkEX5O7tNDlFr5NKIysBaLJ
         32QMigmVY4jHC5lFJNO7RiVNLmDRmpJDkEJKHA1leCC+kfsAZxyuOVdzxKe/SD+aLMkQ
         64aG0uLqdaMXX2dQfYgquBQPh8Z2ggl1iNS4/k9GCKca43f7wVzL8CrFmFgewuB7Ed8r
         JO6w==
X-Gm-Message-State: AJcUukfl5qLh1LIspXml79ka0VJXy5dMka/IbTepeHxJZKGdSMHMBlXK
        XtojT8+il1ojWhlCE/XURRzB4yxUZ0AElQ==
X-Google-Smtp-Source: ALg8bN5VZgPbhiVg580Ur7v7Vqd2LPJUefrYkvwC7hDyliRNSRRqeX/UejyldDnJlMlIWno3NQA8iQ==
X-Received: by 2002:a17:902:42e4:: with SMTP id h91mr2808817pld.18.1548259520812;
        Wed, 23 Jan 2019 08:05:20 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m9sm46715215pgd.32.2019.01.23.08.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 08:05:19 -0800 (PST)
Subject: Re: LTP case read_all_proc fails on qemux86-64 since 5.0-rc1
From:   Jens Axboe <axboe@kernel.dk>
To:     He Zhe <zhe.he@windriver.com>
Cc:     davem@davemloft.net, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <316b80da-0811-f9e6-dd42-41ddbb7eb8a0@windriver.com>
 <C1903094-A3C8-4273-9869-72D400180E51@kernel.dk>
Message-ID: <11b1b3ee-a94b-dd5e-3ba6-df3efa239c7f@kernel.dk>
Date:   Wed, 23 Jan 2019 09:05:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <C1903094-A3C8-4273-9869-72D400180E51@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 8:39 PM, Jens Axboe wrote:
> On Jan 22, 2019, at 8:13 PM, He Zhe <zhe.he@windriver.com> wrote:
>>
>>
>> LTP case read_all_proc(read_all -d /proc -q -r 10) often, but not every time, fails with the following call traces, since 600335205b8d "ide: convert to blk-mq"(5.0-rc1) till now(5.0-rc3).
>>
>> qemu-system-x86_64 -drive file=rootfs.ext4,if=virtio,format=raw -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci,rng=rng0 -nographic -m 16192 -smp cpus=12 -cpu core2duo -enable-kvm -serial mon:stdio -serial null -kernel bzImage -append 'root=/dev/vda rw highres=off console=ttyS0 mem=16192M'
>>
>> tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
>> [   47.080156] Warning: /proc/ide/hd?/settings interface is obsolete, and will be removed soon!
>> [   47.085330] ------------[ cut here ]------------
>> [   47.085810] kernel BUG at block/blk-mq.c:767!
>> [   47.086498] invalid opcode: 0000 [#1] PREEMPT SMP PTI
>> [   47.087022] CPU: 5 PID: 146 Comm: kworker/5:1H Not tainted 5.0.0-rc3 #1
>> [   47.087858] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
>> [   47.088992] Workqueue: kblockd blk_mq_run_work_fn
>> [   47.089469] RIP: 0010:blk_mq_add_to_requeue_list+0xc1/0xd0
>> [   47.090035] Code: 48 8d 53 48 49 8b 8c 24 b8 04 00 00 48 89 51 08 48 89 4b 48 49 8d 8c 24 b8 04 00 00 48 89 4b 50 49 89 94 24 b8 04 00 008
>> [   47.091930] RSP: 0018:ffff9e1ea4b43e40 EFLAGS: 00010002
>> [   47.092458] RAX: ffff9e1ea13c0048 RBX: ffff9e1ea13c0000 RCX: 0000000000000006
>> [   47.093181] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9e1ea13c0000
>> [   47.093906] RBP: ffff9e1ea4b43e68 R08: ffffeb5bcf630680 R09: 0000000000000000
>> [   47.094626] R10: 0000000000000001 R11: 0000000000000012 R12: ffff9e1ea1033a40
>> [   47.095347] R13: ffff9e1ea13a8d00 R14: ffff9e1ea13a9000 R15: 0000000000000046
>> [   47.096071] FS:  0000000000000000(0000) GS:ffff9e1ea4b40000(0000) knlGS:0000000000000000
>> [   47.096898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   47.097477] CR2: 0000003fda41fda0 CR3: 00000003d8e6a000 CR4: 00000000000006e0
>> [   47.098203] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   47.098929] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [   47.099650] Call Trace:
>> [   47.099910]  <IRQ>
>> [   47.100128]  blk_mq_requeue_request+0x58/0x60
>> [   47.100576]  ide_requeue_and_plug+0x20/0x50
>> [   47.101014]  ide_intr+0x21a/0x230
>> [   47.101362]  ? idecd_open+0xc0/0xc0
>> [   47.101735]  __handle_irq_event_percpu+0x43/0x1e0
>> [   47.102214]  handle_irq_event_percpu+0x32/0x80
>> [   47.102668]  handle_irq_event+0x39/0x60
>> [   47.103074]  handle_edge_irq+0xe8/0x1c0
>> [   47.103470]  handle_irq+0x20/0x30
>> [   47.103819]  do_IRQ+0x46/0xe0
>> [   47.104128]  common_interrupt+0xf/0xf
>> [   47.104505]  </IRQ>
>> [   47.104731] RIP: 0010:ide_output_data+0xbc/0x100
>> [   47.105201] Code: 74 22 8d 41 ff 85 c9 74 24 49 8d 54 40 02 41 0f b7 00 66 41 89 01 49 83 c0 02 49 39 d0 75 ef 5b 41 5c 5d c3 4c 89 c6 445
>> [   47.107092] RSP: 0018:ffffbd508059bb18 EFLAGS: 00010246 ORIG_RAX: ffffffffffffffdd
>> [   47.107862] RAX: ffff9e1ea13a8800 RBX: ffff9e1ea13a9000 RCX: 0000000000000000
>> [   47.108581] RDX: 0000000000000170 RSI: ffff9e1ea13c012c RDI: 0000000000000000
>> [   47.109293] RBP: ffffbd508059bb28 R08: ffff9e1ea13c0120 R09: 0000000000000170
>> [   47.110016] R10: 000000000000000d R11: 000000000000000c R12: ffff9e1ea13a8800
>> [   47.110731] R13: 000000000000000c R14: ffff9e1ea13c0000 R15: 0000000000007530
>> [   47.111446]  ide_transfer_pc+0x216/0x310
>> [   47.111848]  ? __const_udelay+0x3d/0x40
>> [   47.112236]  ? ide_execute_command+0x85/0xb0
>> [   47.112668]  ? ide_pc_intr+0x3f0/0x3f0
>> [   47.113051]  ? ide_check_atapi_device+0x110/0x110
>> [   47.113524]  ide_issue_pc+0x178/0x240
>> [   47.113901]  ide_cd_do_request+0x15c/0x350
>> [   47.114314]  ide_queue_rq+0x180/0x6b0
>> [   47.114686]  ? blk_mq_get_driver_tag+0xa1/0x110
>> [   47.115153]  blk_mq_dispatch_rq_list+0x90/0x550
>> [   47.115606]  ? __queue_delayed_work+0x63/0x90
>> [   47.116054]  ? deadline_fifo_request+0x41/0x90
>> [   47.116506]  blk_mq_do_dispatch_sched+0x80/0x100
>> [   47.116976]  blk_mq_sched_dispatch_requests+0xfc/0x170
>> [   47.117491]  __blk_mq_run_hw_queue+0x6f/0xd0
>> [   47.117941]  blk_mq_run_work_fn+0x1b/0x20
>> [   47.118342]  process_one_work+0x14c/0x450
>> [   47.118747]  worker_thread+0x4a/0x440
>> [   47.119125]  kthread+0x105/0x140
>> [   47.119456]  ? process_one_work+0x450/0x450
>> [   47.119880]  ? kthread_park+0x90/0x90
>> [   47.120251]  ret_from_fork+0x35/0x40
>> [   47.120619] Modules linked in:
>> [   47.120952] ---[ end trace 4562f716e88fdefe ]---
>> [   47.121423] RIP: 0010:blk_mq_add_to_requeue_list+0xc1/0xd0
>> [   47.121981] Code: 48 8d 53 48 49 8b 8c 24 b8 04 00 00 48 89 51 08 48 89 4b 48 49 8d 8c 24 b8 04 00 00 48 89 4b 50 49 89 94 24 b8 04 00 008
>> [   47.123851] RSP: 0018:ffff9e1ea4b43e40 EFLAGS: 00010002
>> [   47.124393] RAX: ffff9e1ea13c0048 RBX: ffff9e1ea13c0000 RCX: 0000000000000006
>> [   47.125108] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9e1ea13c0000
>> [   47.125819] RBP: ffff9e1ea4b43e68 R08: ffffeb5bcf630680 R09: 0000000000000000
>> [   47.126539] R10: 0000000000000001 R11: 0000000000000012 R12: ffff9e1ea1033a40
>> [   47.127262] R13: ffff9e1ea13a8d00 R14: ffff9e1ea13a9000 R15: 0000000000000046
>> [   47.127988] FS:  0000000000000000(0000) GS:ffff9e1ea4b40000(0000) knlGS:0000000000000000
>> [   47.128793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   47.129385] CR2: 0000003fda41fda0 CR3: 00000003d8e6a000 CR4: 00000000000006e0
>> [   47.130104] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   47.130823] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [   47.131547] Kernel panic - not syncing: Fatal exception in interrupt
>> [   47.132609] Kernel Offset: 0x7c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> [   47.133679] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>> [   47.134432] ------------[ cut here ]-----------
> 
> I’ll take a look at this, thanks for the report.

I can't reproduce this, unfortunately. But I'm guessing it might be related
to a race with the requeue and request handling in IDE. Can you try with
the below patch?


diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 8445b484ae69..a10347a6505a 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -439,7 +439,7 @@ static inline void ide_unlock_host(struct ide_host *host)
 	}
 }
 
-void ide_requeue_and_plug(ide_drive_t *drive, struct request *rq)
+static void __ide_requeue_and_plug(ide_drive_t *drive, struct request *rq)
 {
 	struct request_queue *q = drive->queue;
 
@@ -451,6 +451,16 @@ void ide_requeue_and_plug(ide_drive_t *drive, struct request *rq)
 		blk_mq_delay_run_hw_queue(q->queue_hw_ctx[0], 3);
 }
 
+void ide_requeue_and_plug(ide_drive_t *drive, struct request *rq)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hwif->lock, flags);
+	__ide_requeue_and_plug(drive, rq);
+	spin_unlock_irqrestore(&hwif->lock, flags);
+}
+
 /*
  * Issue a new request to a device.
  */
@@ -560,9 +570,9 @@ blk_status_t ide_queue_rq(struct blk_mq_hw_ctx *hctx,
 		}
 	} else {
 plug_device:
+		__ide_requeue_and_plug(drive, rq);
 		spin_unlock_irq(&hwif->lock);
 		ide_unlock_host(host);
-		ide_requeue_and_plug(drive, rq);
 		return BLK_STS_OK;
 	}
 
@@ -687,12 +697,14 @@ void ide_timer_expiry (struct timer_list *t)
 			plug_device = 1;
 		}
 	}
+
+	if (plug_device)
+		__ide_requeue_and_plug(drive, rq_in_flight);
+
 	spin_unlock_irqrestore(&hwif->lock, flags);
 
-	if (plug_device) {
+	if (plug_device)
 		ide_unlock_host(hwif->host);
-		ide_requeue_and_plug(drive, rq_in_flight);
-	}
 }
 
 /**

-- 
Jens Axboe

