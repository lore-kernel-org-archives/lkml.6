Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9826AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5135C208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oI6y2THg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5135C208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeIYVoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:44:00 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32952 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbeIYVn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:43:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id 84-v6so2289984qkf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xP66oGEF+u9f7BSpkmxqbqRaFwS1WpxA5GQ7jYe350c=;
        b=oI6y2THgwRwZfWatTuq71tZoL7JPsb0d8wRg3VmKIJs0PweEHxN6UwDgsQf69CM5mo
         7clALQKSkomrbGRH/nvJU2xRh18/oawDo7AREjUzMbnEeUni5Hbbl9f+frpg0wl2evRK
         J54s4z+Me5J5+heT3vrgk896QPUrAjfkPd4gyXYs+WHRs3T+1Swfu7bgCD5jQaYSWdKh
         RU1i7+pT5+xUJ1HyY5+dLCH8KnWLoUHDYW115dPvFL++dSOToBA766v4G2zFJOS1Xx23
         HNPm/yWVg/u6yZR6V7mkcF9nVfdGMwvH2w+tcVssQjB5WtHlj2levmbUcmDTmkqua9w+
         oMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xP66oGEF+u9f7BSpkmxqbqRaFwS1WpxA5GQ7jYe350c=;
        b=GPAvOTxy9xHtnrCXFJxghEc53t6nhWEi61HpltDVy+awds4CiFGj8wb7mbAZbcNcUD
         uQUBnl90k46PQrCCmvAoFpWs5T7OQcOJVjxKzb2sqxtn1NCGlq8k7Ug0Gwc9/E5wLWWB
         QhvyGTuvZhbMWcGbrCUVxTSubs29F1tnFP8qmc2TWQqtYivKdMbgLE32ySkEBXI77t5t
         1aZjkzEwnCmJgUW2AXVHhT7Y7zCzHR7VNPp3JPceh6hUV+ugPCaL/nZnBSJGOBWSLsmK
         3GH/vK+Aqkm1vbLLF/idMZ/qH8UW0fYyladQrX7C6bGGNlTE2IBl5hk5w/jJGJRLXki/
         oHwQ==
X-Gm-Message-State: ABuFfoi6VqxrehUXttHAKicsnLDkXzMW8yAkxn8/aBGwmTCbGIcJTuKG
        ZiihJIvGST4l5rx23tdcrA==
X-Google-Smtp-Source: ACcGV613+FJa5N5QpL6W+29rW2RnjjcNDuzMIfgK5NizIuOoNOllYEqXe5fzI0wTWJFc5SR24gE8mA==
X-Received: by 2002:a37:cf04:: with SMTP id e4-v6mr1115171qkj.241.1537889755274;
        Tue, 25 Sep 2018 08:35:55 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p18-v6sm2056304qtp.3.2018.09.25.08.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 08:35:54 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 1/3] Revert "x86/e820: put !E820_TYPE_RAM regions into memblock.reserved"
Date:   Tue, 25 Sep 2018 11:35:30 -0400
Message-Id: <20180925153532.6206-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925153532.6206-1-msys.mizuma@gmail.com>
References: <20180925153532.6206-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into
memblock.reserved") breaks movable_node kernel option because it
changed the memory gap range to reserved memblock. So, the node
is marked as Normal zone even if the SRAT has Hot plaggable affinity.

    =====================================================================
    kernel: BIOS-e820: [mem 0x0000180000000000-0x0000180fffffffff] usable
    kernel: BIOS-e820: [mem 0x00001c0000000000-0x00001c0fffffffff] usable
    ...
    kernel: reserved[0x12]#011[0x0000181000000000-0x00001bffffffffff], 0x000003f000000000 bytes flags: 0x0
    ...
    kernel: ACPI: SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
    kernel: ACPI: SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
    ...
    kernel: Movable zone start for each node
    kernel:  Node 3: 0x00001c0000000000
    kernel: Early memory node ranges
    ...
    =====================================================================

Naoya's v1 patch [*] fixes the original issue and this movable_node
issue doesn't occur.
Let's revert commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM
regions into memblock.reserved") and apply the v1 patch.

[*] https://lkml.org/lkml/2018/6/13/27

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
---
 arch/x86/kernel/e820.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c88c23c..d1f25c8 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1248,7 +1248,6 @@ void __init e820__memblock_setup(void)
 {
 	int i;
 	u64 end;
-	u64 addr = 0;
 
 	/*
 	 * The bootstrap memblock region count maximum is 128 entries
@@ -1265,21 +1264,13 @@ void __init e820__memblock_setup(void)
 		struct e820_entry *entry = &e820_table->entries[i];
 
 		end = entry->addr + entry->size;
-		if (addr < entry->addr)
-			memblock_reserve(addr, entry->addr - addr);
-		addr = end;
 		if (end != (resource_size_t)end)
 			continue;
 
-		/*
-		 * all !E820_TYPE_RAM ranges (including gap ranges) are put
-		 * into memblock.reserved to make sure that struct pages in
-		 * such regions are not left uninitialized after bootup.
-		 */
 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
-			memblock_reserve(entry->addr, entry->size);
-		else
-			memblock_add(entry->addr, entry->size);
+			continue;
+
+		memblock_add(entry->addr, entry->size);
 	}
 
 	/* Throw away partial pages: */
-- 
2.18.0

