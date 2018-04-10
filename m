Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523399725-2-2645554911996031048
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523399724; b=n2W24hSHhIgEEGmGAVb/d8kGhm/eL1qkUKw/yLANJvBREnxvD7
    xS1LlQ6kHDDzRCaJbdnfAT4U+/YJKhxK8wnPvGicLTygpM5btfINHiu/o+t2TgWm
    7eOnUTIz/mjL2yPC1rDsakZ/SmeKdF27NyBCQDmGIhWijIiD0XxFTTDr6YpPQLEJ
    EueLoJStw0Q/Ksxt1uvHS5V5qkVhLAjIJO36+hv39mH20hwk//ZXBkU1LWKp5SsU
    K5LMc4/o4V8zcv24W68SsOQTfc4jxnpuTO4g16561tinf8g4ZFR5UZyQC8p/E1mN
    AF7daJBqBzAi286p8N8IPOlaXa4LsiyY7h1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523399724; bh=Mf+0XFRHy/zmbjzzMzHr4CIhfcPQSA
    2dbvQyFsmy/RM=; b=glrd3S1I1DqAP7TmWZ7NU2crWkHDQshXRau8Pk8ka9I4Ek
    5tPwz0Ktb9JTSXQypdbAYhccsQJ5tw068uy20AwyP/ggt3oxE4QEjc0CvsyrvDK+
    cBCB6EmPQ6O4jrca/zFn0wzFKdMhiKIzC5g6QvVXUJup41p/fxXNzcnJaTNswiu7
    jx9a2ZGjxcbPXScchJHLuNvAsWZgSFvDw80KqThMeZXV8HMsBepbhKbXp5+UAzmn
    /nyvarr15VGa2VD3uan4oVga5ssjzKDOqSleyjgNvHYGoQnhVu25hO5RCsy+/JCy
    anjwWNJGIofJtgqzlsDWAnKBYacIS57gU+/KxKQA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKpEHrufsNj5ukQdvJ7tj3BLQdJG2B3q015R72wwiebFyT286wW4tLnr1XkWECZtuk2wa0Pdm9g0Q/TBICLI/wvkGs8dzduUz226nm08ZynnhPjHc/E+
    c5kj1NU67FVDVIvEe/grV8vzvXtwAp2bswkiEPRbRDmZZ/+B76CdK1dBanPD12eddio0HFROrksN0PHBRpI4rwmRbnUR4o5gVJXrpGV+zLfE8k+rEcq+/vdA
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=TNwcPIo-YEKEsAazHMoA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeDJWfV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:35:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42062 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755523AbeDJWfS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:35:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 039/138] blk-mq: avoid to map CPU into stale hw queue
Date: Wed, 11 Apr 2018 00:23:49 +0200
Message-Id: <20180410212906.625290098@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>


[ Upstream commit 7d4901a90d02500c8011472a060f9b2e60e6e605 ]

blk_mq_pci_map_queues() may not map one CPU into any hw queue, but its
previous map isn't cleared yet, and may point to one stale hw queue
index.

This patch fixes the following issue by clearing the mapping table before
setting it up in blk_mq_pci_map_queues().

This patches fixes this following issue reported by Zhang Yi:

[  101.202734] BUG: unable to handle kernel NULL pointer dereference at 0000000094d3013f
[  101.211487] IP: blk_mq_map_swqueue+0xbc/0x200
[  101.216346] PGD 0 P4D 0
[  101.219171] Oops: 0000 [#1] SMP
[  101.222674] Modules linked in: sunrpc ipmi_ssif vfat fat intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore mxm_wmi intel_rapl_perf iTCO_wdt ipmi_si ipmi_devintf pcspkr iTCO_vendor_support sg dcdbas ipmi_msghandler wmi mei_me lpc_ich shpchp mei acpi_power_meter dm_multipath ip_tables xfs libcrc32c sd_mod mgag200 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm ahci libahci crc32c_intel libata tg3 nvme nvme_core megaraid_sas ptp i2c_core pps_core dm_mirror dm_region_hash dm_log dm_mod
[  101.284881] CPU: 0 PID: 504 Comm: kworker/u25:5 Not tainted 4.15.0-rc2 #1
[  101.292455] Hardware name: Dell Inc. PowerEdge R730xd/072T6D, BIOS 2.5.5 08/16/2017
[  101.301001] Workqueue: nvme-wq nvme_reset_work [nvme]
[  101.306636] task: 00000000f2c53190 task.stack: 000000002da874f9
[  101.313241] RIP: 0010:blk_mq_map_swqueue+0xbc/0x200
[  101.318681] RSP: 0018:ffffc9000234fd70 EFLAGS: 00010282
[  101.324511] RAX: ffff88047ffc9480 RBX: ffff88047e130850 RCX: 0000000000000000
[  101.332471] RDX: ffffe8ffffd40580 RSI: ffff88047e509b40 RDI: ffff88046f37a008
[  101.340432] RBP: 000000000000000b R08: ffff88046f37a008 R09: 0000000011f94280
[  101.348392] R10: ffff88047ffd4d00 R11: 0000000000000000 R12: ffff88046f37a008
[  101.356353] R13: ffff88047e130f38 R14: 000000000000000b R15: ffff88046f37a558
[  101.364314] FS:  0000000000000000(0000) GS:ffff880277c00000(0000) knlGS:0000000000000000
[  101.373342] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.379753] CR2: 0000000000000098 CR3: 000000047f409004 CR4: 00000000001606f0
[  101.387714] Call Trace:
[  101.390445]  blk_mq_update_nr_hw_queues+0xbf/0x130
[  101.395791]  nvme_reset_work+0x6f4/0xc06 [nvme]
[  101.400848]  ? pick_next_task_fair+0x290/0x5f0
[  101.405807]  ? __switch_to+0x1f5/0x430
[  101.409988]  ? put_prev_entity+0x2f/0xd0
[  101.414365]  process_one_work+0x141/0x340
[  101.418836]  worker_thread+0x47/0x3e0
[  101.422921]  kthread+0xf5/0x130
[  101.426424]  ? rescuer_thread+0x380/0x380
[  101.430896]  ? kthread_associate_blkcg+0x90/0x90
[  101.436048]  ret_from_fork+0x1f/0x30
[  101.440034] Code: 48 83 3c ca 00 0f 84 2b 01 00 00 48 63 cd 48 8b 93 10 01 00 00 8b 0c 88 48 8b 83 20 01 00 00 4a 03 14 f5 60 04 af 81 48 8b 0c c8 <48> 8b 81 98 00 00 00 f0 4c 0f ab 30 8b 81 f8 00 00 00 89 42 44
[  101.461116] RIP: blk_mq_map_swqueue+0xbc/0x200 RSP: ffffc9000234fd70
[  101.468205] CR2: 0000000000000098
[  101.471907] ---[ end trace 5fe710f98228a3ca ]---
[  101.482489] Kernel panic - not syncing: Fatal exception
[  101.488505] Kernel Offset: disabled
[  101.497752] ---[ end Kernel panic - not syncing: Fatal exception

Reviewed-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Christoph Hellwig <hch@lst.de>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2528,9 +2528,27 @@ static int blk_mq_alloc_rq_maps(struct b
 
 static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 {
-	if (set->ops->map_queues)
+	if (set->ops->map_queues) {
+		int cpu;
+		/*
+		 * transport .map_queues is usually done in the following
+		 * way:
+		 *
+		 * for (queue = 0; queue < set->nr_hw_queues; queue++) {
+		 * 	mask = get_cpu_mask(queue)
+		 * 	for_each_cpu(cpu, mask)
+		 * 		set->mq_map[cpu] = queue;
+		 * }
+		 *
+		 * When we need to remap, the table has to be cleared for
+		 * killing stale mapping since one CPU may not be mapped
+		 * to any hw queue.
+		 */
+		for_each_possible_cpu(cpu)
+			set->mq_map[cpu] = 0;
+
 		return set->ops->map_queues(set);
-	else
+	} else
 		return blk_mq_map_queues(set);
 }
 
