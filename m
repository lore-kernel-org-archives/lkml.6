Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6FAC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819342083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RF1A5CN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819342083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeJBVWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:22:21 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:47068 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:22:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id q12-v6so1237786qkl.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UsjZUHavM6O3QeH6tlq9dIQpwA6ici9MyEp6E87EPfo=;
        b=RF1A5CN+VgnkMaCUNY8x/Qy+t4Q5442SjsP3EenwUXh8zrCGg+HOUCFICtLm5kGmZb
         qGEf6eidZUJ7ZFgMWhSC+3rGaQFGmCzaB0IpN0543MRBR0HmX/TuFG07MOl9pjntvn8p
         OTch1tkAsYoKZ9rcoiVYHvaoXJKBWZysu15Q9PCONFnFLqu2CnIVuvT+CshjEjCyAu3K
         21eg1wxq6DMqpDsJlK3cMAPrWMNplkKR5+YMLZ9fFzHzELHmE1BMQBNblCGnNjDiQWVB
         inqcs73RrhZtkY9ezDvzYl/0hVsKmaB02tiyDWE+mEOs1FnOxoQvCoZukHs96J0sYeNB
         9n1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UsjZUHavM6O3QeH6tlq9dIQpwA6ici9MyEp6E87EPfo=;
        b=HvJAeOZn85QIgKwxp5lVvO2kC6Yj+7Nn1N+uBN/rt5HYNUcTMIIxZOMjavWRG8rD8G
         HBA+okH21RaJY2PNLqt5ISvdeh7mi4FMVE1oejqSLrUl5NHDyS7/kPTTsYpXvo1hh8/P
         0F+IbP8p0Rk5DEKhVqnmzJSfbEPIEFYFbyraosPP8p6BcfGyQ4+Gz7WDeo4AU/CASAaF
         fdjOLZbRLI0O+Eh+8/YaQppjUK/ZreFxPWiniRZ/qw3QVQxMzEmBh3NVBgtN1t09hgAr
         Rx0mbcVeVbKpD0ZG0BtScSy/0Z8rFJj1KHqDYCPEScKkflISVucEaDmToKruJz67N3CD
         88mQ==
X-Gm-Message-State: ABuFfoj5XZp3QV+kK43u2SgPfzuFxF73GnL1GstorB9LP8d+UQxHneRF
        81t8w4oXnkllSDW/geGCMw==
X-Google-Smtp-Source: ACcGV62qdUXCmmF9RBUXPUjm/xCQ8TLMaB46gh6IsiSVNksbJm56HscrYo5VCsOvok+vMo9IRX8MDQ==
X-Received: by 2002:a37:a650:: with SMTP id p77-v6mr12032868qke.126.1538491117434;
        Tue, 02 Oct 2018 07:38:37 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y20-v6sm5257538qkb.46.2018.10.02.07.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 07:38:37 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 3/3] Revert "x86/e820: put !E820_TYPE_RAM regions into memblock.reserved"
Date:   Tue,  2 Oct 2018 10:38:21 -0400
Message-Id: <20181002143821.5112-4-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002143821.5112-1-msys.mizuma@gmail.com>
References: <20181002143821.5112-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into
memblock.reserved") breaks movable_node kernel option because it
changed the memory gap range to reserved memblock. So, the node
is marked as Normal zone even if the SRAT has Hot pluggable affinity.

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

The original issue is fixed by the former patches, so let's revert
commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into memblock.reserved").

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

