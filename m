Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056B4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6B920838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6B920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeJaT7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:59:44 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:41917 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbeJaT7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:59:44 -0400
To:     LKML <linux-kernel@vger.kernel.org>
From:   Meelis Roos <mroos@linux.ee>
Subject: insecure W+X mappings on HP DL365 G5
Message-ID: <ff711e00-e5cd-6276-3915-32dd61d55112@linux.ee>
Date:   Wed, 31 Oct 2018 13:02:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This HP DL365 G5 is the second old server where I see massive W+X mapped pages.

Is it some BIOS defect?

[    0.714956] x86/mm: Found insecure W+X mapping at address 0xffff8ed980000000
[    0.715101] WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:266 note_page+0x4c7/0x780
[    0.715298] Modules linked in:
[    0.715421] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-11807-g310c7585e830 #9
[    0.715612] Hardware name: HP ProLiant DL365 G5   , BIOS A10 05/02/2011
[    0.715741] RIP: 0010:note_page+0x4c7/0x780
[    0.715864] Code: fd 01 0f 87 1a 09 00 00 41 83 e5 01 0f 85 3f fc ff ff 49 8b 74 24 18 48 c7 c7 20 72 f2 bc c6 05 13 7f e9 00 01 e8 8a bf 00 00 <0f> 0b e9 20 fc ff ff 45 84 ed 0f 85 2b 08 00 00 4d 85 ff 0f 85 91
[    0.716141] RSP: 0018:ffffb262c0c5be10 EFLAGS: 00010282
[    0.716265] RAX: 0000000000000000 RBX: 0000000000000161 RCX: ffffffffbd06b778
[    0.716393] RDX: 0000000000000001 RSI: 0000000000000082 RDI: ffffffffbd4a972c
[    0.716511] RBP: 0000000000000000 R08: 00000000000002bb R09: 00000000bd4eb701
[    0.716638] R10: ffff8ed9800bc240 R11: 0000000000032084 R12: ffffb262c0c5bec0
[    0.716775] R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000
[    0.716903] FS:  0000000000000000(0000) GS:ffff8edaaba00000(0000) knlGS:0000000000000000
[    0.717085] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.717208] CR2: ffffb262c0e24000 CR3: 000000009e60a000 CR4: 00000000000006f0
[    0.717343] Call Trace:
[    0.717470]  ? vprintk_emit+0x18a/0x1e0
[    0.717592]  ptdump_walk_pgd_level_core+0x352/0x410
[    0.717720]  ? rest_init+0x1/0xcc
[    0.717839]  kernel_init+0x39/0x114
[    0.717960]  ? rest_init+0xcc/0xcc
[    0.718085]  ret_from_fork+0x22/0x40
[    0.718207] ---[ end trace 34c16f2bb7a914e2 ]---
[    0.744838] x86/mm: Checked W+X mappings: FAILED, 2182367 W+X pages found.

-- 
Meelis Roos <mroos@linux.ee>
