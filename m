Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1ECC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB5620850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+9aT/he"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB5620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLDDGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:06:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40650 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeLDDGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:06:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so7434766pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 19:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V8AZUaHMn0cHqeZMcXXrYDSL01wORoZ3fn4vXe9m5EI=;
        b=Y+9aT/he+yljvEtgvxESVWllzb51va2kKtitlhdbJJxZNX8t1nDaed7+cQW/BZ4A/+
         P0cJgRuqkKw5XfaaYMoBqPxKn0XbRDkQLBBrhX0ubejSRLNLR3brxw5ANThBzPQLwvJv
         F06OS2zwrlb8mt1JvdWRzcfG7Vf1c4ldfdsltfF2Z2Cpjdjeoob5IXatXnoyMaiXdtNy
         EZru3PyAxNUm9TIerSDZxfr1I94QqCJTnu3p1jiAYQ6z//dulOWE8jdjJzgR+5rXhYnl
         lxbIMj0dusn6f4U4oMiy0UjssPh2eqoDiMgtJWV64eY2T1Ym+qNw6c073FNOAxbizG0o
         PIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V8AZUaHMn0cHqeZMcXXrYDSL01wORoZ3fn4vXe9m5EI=;
        b=XOExCLRQAIZv37atztiMoutMC0ZjgvzlE+OtozX0kBFxSnDndGZBeYdzf4CUBB6NJV
         v4nai8CIi9GyeRDffjBs2d0hlOcJ2IrBupBA3SYRDqSauTh9FMB457YDZ6s+yVq/7Fvs
         9OKa4REwgW0W38/stMy8MGcI1P4LNUEOD/1MRXjbvxTz+bS2JsBZJUEDcKwHaViK3tTE
         i4YiwwdHAFTRDzZhhig3ubNapReOgVUrzXkGdQOeGlA53rbvOS7T0xum8Mn7zv7ZWZ6B
         Zw/4Gf+23e+mDBr307iFh7Iv0/07aH4sTWggT754ABSRvoxvXdCoNyu7HbnnaiM7sAnR
         wTQw==
X-Gm-Message-State: AA+aEWbskMZVvBqZIsGcglZuxZ/XrmfB85M5tI1qoXFZm7d4a0q7yhH0
        lY4zLXO02YUygyuf1BPBaQ==
X-Google-Smtp-Source: AFSGD/X96T4OEvxK72np5BaEqMMqKFzmIL7Mlgy0eTM16ppMUQ/Dm5JQCZxX1NwnkL0JnqYup1D43Q==
X-Received: by 2002:a62:3c1:: with SMTP id 184mr6397667pfd.56.1543892771848;
        Mon, 03 Dec 2018 19:06:11 -0800 (PST)
Received: from mylaptop.pek2.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l185sm11969637pfl.54.2018.12.03.19.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 19:06:10 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] mm/alloc: fallback to first node if the wanted node offline
Date:   Tue,  4 Dec 2018 11:05:57 +0800
Message-Id: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During my test on some AMD machine, with kexec -l nr_cpus=x option, the
kernel failed to bootup, because some node's data struct can not be allocated,
e.g, on x86, initialized by init_cpu_to_node()->init_memory_less_node(). But
device->numa_node info is used as preferred_nid param for
__alloc_pages_nodemask(), which causes NULL reference
  ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
This patch tries to fix the issue by falling back to the first online node,
when encountering such corner case.

Notes about the crashing info:
-1. kexec -l with nr_cpus=4
-2. system info
  NUMA node0 CPU(s):     0,8,16,24
  NUMA node1 CPU(s):     2,10,18,26
  NUMA node2 CPU(s):     4,12,20,28
  NUMA node3 CPU(s):     6,14,22,30
  NUMA node4 CPU(s):     1,9,17,25
  NUMA node5 CPU(s):     3,11,19,27
  NUMA node6 CPU(s):     5,13,21,29
  NUMA node7 CPU(s):     7,15,23,31
-3. panic stack
[...]
[    5.721547] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    5.729187] pcieport 0000:00:01.1: Signaling PME with IRQ 34
[    5.735187] pcieport 0000:00:01.2: Signaling PME with IRQ 35
[    5.741168] pcieport 0000:00:01.3: Signaling PME with IRQ 36
[    5.747189] pcieport 0000:00:07.1: Signaling PME with IRQ 37
[    5.754061] pcieport 0000:00:08.1: Signaling PME with IRQ 39
[    5.760727] pcieport 0000:20:07.1: Signaling PME with IRQ 40
[    5.766955] pcieport 0000:20:08.1: Signaling PME with IRQ 42
[    5.772742] BUG: unable to handle kernel paging request at 0000000000002088
[    5.773618] PGD 0 P4D 0
[    5.773618] Oops: 0000 [#1] SMP NOPTI
[    5.773618] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc1+ #3
[    5.773618] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.4.3 06/29/2018
[    5.773618] RIP: 0010:__alloc_pages_nodemask+0xe2/0x2a0
[    5.773618] Code: 00 00 44 89 ea 80 ca 80 41 83 f8 01 44 0f 44 ea 89 da c1 ea 08 83 e2 01 88 54 24 20 48 8b 54 24 08 48 85 d2 0f 85 46 01 00 00 <3b> 77 08 0f 82 3d 01 00 00 48 89 f8 44 89 ea 48 89
e1 44 89 e6 89
[    5.773618] RSP: 0018:ffffaa600005fb20 EFLAGS: 00010246
[    5.773618] RAX: 0000000000000000 RBX: 00000000006012c0 RCX: 0000000000000000
[    5.773618] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000002080
[    5.773618] RBP: 00000000006012c0 R08: 0000000000000000 R09: 0000000000000002
[    5.773618] R10: 00000000006080c0 R11: 0000000000000002 R12: 0000000000000000
[    5.773618] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000002
[    5.773618] FS:  0000000000000000(0000) GS:ffff8c69afe00000(0000) knlGS:0000000000000000
[    5.773618] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.773618] CR2: 0000000000002088 CR3: 000000087e00a000 CR4: 00000000003406e0
[    5.773618] Call Trace:
[    5.773618]  new_slab+0xa9/0x570
[    5.773618]  ___slab_alloc+0x375/0x540
[    5.773618]  ? pinctrl_bind_pins+0x2b/0x2a0
[    5.773618]  __slab_alloc+0x1c/0x38
[    5.773618]  __kmalloc_node_track_caller+0xc8/0x270
[    5.773618]  ? pinctrl_bind_pins+0x2b/0x2a0
[    5.773618]  devm_kmalloc+0x28/0x60
[    5.773618]  pinctrl_bind_pins+0x2b/0x2a0
[    5.773618]  really_probe+0x73/0x420
[    5.773618]  driver_probe_device+0x115/0x130
[    5.773618]  __driver_attach+0x103/0x110
[    5.773618]  ? driver_probe_device+0x130/0x130
[    5.773618]  bus_for_each_dev+0x67/0xc0
[    5.773618]  ? klist_add_tail+0x3b/0x70
[    5.773618]  bus_add_driver+0x41/0x260
[    5.773618]  ? pcie_port_setup+0x4d/0x4d
[    5.773618]  driver_register+0x5b/0xe0
[    5.773618]  ? pcie_port_setup+0x4d/0x4d
[    5.773618]  do_one_initcall+0x4e/0x1d4
[    5.773618]  ? init_setup+0x25/0x28
[    5.773618]  kernel_init_freeable+0x1c1/0x26e
[    5.773618]  ? loglevel+0x5b/0x5b
[    5.773618]  ? rest_init+0xb0/0xb0
[    5.773618]  kernel_init+0xa/0x110
[    5.773618]  ret_from_fork+0x22/0x40
[    5.773618] Modules linked in:
[    5.773618] CR2: 0000000000002088
[    5.773618] ---[ end trace 1030c9120a03d081 ]---
[...]

Other notes about the reproduction of this bug:
After appling the following patch:
commit 0d76bcc960e6057750fcf556b65da13f8bbdfd2b
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Nov 13 08:38:17 2018 -0600

    Revert "ACPI/PCI: Pay attention to device-specific _PXM node values"

This bug is covered and not triggered on my test AMD machine.
But it should still exist since dev->numa_node info can be set by other
method on other archs when using nr_cpus param

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/gfp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 76f8db0..8324953 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -453,6 +453,8 @@ static inline int gfp_zonelist(gfp_t flags)
  */
 static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 {
+	if (unlikely(!node_online(nid)))
+		nid = first_online_node;
 	return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
 }
 
-- 
2.7.4

