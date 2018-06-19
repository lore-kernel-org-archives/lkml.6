Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22C1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D56820875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmDJlI5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D56820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755989AbeFSGqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:46:10 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45943 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755207AbeFSGoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:44:07 -0400
Received: by mail-pl0-f67.google.com with SMTP id c23-v6so10390266plz.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pz/8CC8YBSFoejKCIh8QPg8R9nqbiIkn1Y//vL6VGqY=;
        b=XmDJlI5cpt8Jvehh2vBfePFAiOA2rGtp7BY6xp3/cmIcbjfogDbdmJvQ2favs88yeC
         RG+/WubooC+BoY0l966+1IOBdZryN8GKoW5a9OHStmsivB/EFiCRz9kdTzFGxvgwvta8
         tC3V5Xp4QMGNWNYPLsJdnsCvTwQIcYgDpF+1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pz/8CC8YBSFoejKCIh8QPg8R9nqbiIkn1Y//vL6VGqY=;
        b=d+sH6uwSt90LGS8xmnkQA6ZZrB6WkPi7R8JOgnv4rG76R+zC516nnMEO8J/l9ri0JH
         TSGyCHHnQHVcsffMW2ZoDq1jQDKiLT4u1KVe4QEPH9ub5J2t3ZDecBh9xBUoV0lSfhtN
         qkKiXOgitbLWClWprOpAmTQRUqGG5UFXtQaXvghpcBFeZGHV1XqIuIv4TV+FvizD4FBm
         lxk/P3Gg8ldJ1WT/YfT0OxhuElhEqsJmXO8zSwEnVXrFIhQLdT1/ow+5oQbmD6Aavymj
         U32PRZn7BeKdHydo2BdnnMu6OlrclguhWJL3Y5+DRAsN3Pn+ESD5LzJbY8/RUeMryn/B
         GM5A==
X-Gm-Message-State: APt69E3Xs6DBT/5MAhJbQBfmmbNxx8LFT07n0CX01MxAJDrb9P1eumsj
        l1uUXpCkKsTDsUof26yPrw6R1A==
X-Google-Smtp-Source: ADUXVKL8m21FzarNC2QeNDz6f4i3C1E8rKFjb0i2s/8k8M1nMv3mNqHBcvnyIjfifymyLzoZ/n9EzA==
X-Received: by 2002:a17:902:bb81:: with SMTP id m1-v6mr17437964pls.117.1529390647314;
        Mon, 18 Jun 2018 23:44:07 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 10-v6sm38423943pfs.111.2018.06.18.23.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 23:44:06 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH v2 1/4] arm64: export memblock_reserve()d regions via /proc/iomem
Date:   Tue, 19 Jun 2018 15:44:21 +0900
Message-Id: <20180619064424.6642-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180619064424.6642-1-takahiro.akashi@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

There has been some confusion around what is necessary to prevent kexec
overwriting important memory regions. memblock: reserve, or nomap?
Only memblock nomap regions are reported via /proc/iomem, kexec's
user-space doesn't know about memblock_reserve()d regions.

Until commit f56ab9a5b73ca ("efi/arm: Don't mark ACPI reclaim memory
as MEMBLOCK_NOMAP") the ACPI tables were nomap, now they are reserved
and thus possible for kexec to overwrite with the new kernel or initrd.
But this was always broken, as the UEFI memory map is also reserved
and not marked as nomap.

Exporting both nomap and reserved memblock types is a nuisance as
they live in different memblock structures which we can't walk at
the same time.

Take a second walk over memblock.reserved and add new 'reserved'
subnodes for the memblock_reserved() regions that aren't already
described by the existing code. (e.g. Kernel Code)

We use reserve_region_with_split() to find the gaps in existing named
regions. This handles the gap between 'kernel code' and 'kernel data'
which is memblock_reserve()d, but already partially described by
request_standard_resources(). e.g.:
| 80000000-dfffffff : System RAM
|   80080000-80ffffff : Kernel code
|   81000000-8158ffff : reserved
|   81590000-8237efff : Kernel data
|   a0000000-dfffffff : Crash kernel
| e00f0000-f949ffff : System RAM

reserve_region_with_split needs kzalloc() which isn't available when
request_standard_resources() is called, use an initcall.

Reported-by: Bhupesh Sharma <bhsharma@redhat.com>
Reported-by: Tyler Baicar <tbaicar@codeaurora.org>
Suggested-by: Akashi Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: James Morse <james.morse@arm.com>
Fixes: d28f6df1305a ("arm64/kexec: Add core kexec support")
CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/setup.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 30ad2f085d1f..5b4fac434c84 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -241,6 +241,44 @@ static void __init request_standard_resources(void)
 	}
 }
 
+static int __init reserve_memblock_reserved_regions(void)
+{
+	phys_addr_t start, end, roundup_end = 0;
+	struct resource *mem, *res;
+	u64 i;
+
+	for_each_reserved_mem_region(i, &start, &end) {
+		if (end <= roundup_end)
+			continue; /* done already */
+
+		start = __pfn_to_phys(PFN_DOWN(start));
+		end = __pfn_to_phys(PFN_UP(end)) - 1;
+		roundup_end = end;
+
+		res = kzalloc(sizeof(*res), GFP_ATOMIC);
+		if (WARN_ON(!res))
+			return -ENOMEM;
+		res->start = start;
+		res->end = end;
+		res->name  = "reserved";
+		res->flags = IORESOURCE_MEM;
+
+		mem = request_resource_conflict(&iomem_resource, res);
+		/*
+		 * We expected memblock_reserve() regions to conflict with
+		 * memory created by request_standard_resources().
+		 */
+		if (WARN_ON_ONCE(!mem))
+			continue;
+		kfree(res);
+
+		reserve_region_with_split(mem, start, end, "reserved");
+	}
+
+	return 0;
+}
+arch_initcall(reserve_memblock_reserved_regions);
+
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
 void __init setup_arch(char **cmdline_p)
-- 
2.17.0

