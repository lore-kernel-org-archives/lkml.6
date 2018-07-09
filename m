Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6ECC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C88C208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kd2ptLTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C88C208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933419AbeGIAHP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 20:07:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40925 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932942AbeGIAHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 20:07:14 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so12320326pfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 17:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F9qL97WIJTDKar0RATFRGa32DomSlp6yFEb0hpSLUU4=;
        b=kd2ptLTQ8wg2U2tCQ4/hsptK683fIZEYs8VbdMmThKMJGU/7s2YCOjFId5Ewr0cgFG
         na5HyqSagqJ14Nb8X02wK9JwQGxkD5nCDp6rwhp9dN8V9QP4Br3yDCbEyUJ0/RcDsGm7
         gBTe/UI6U84Ig8xNsh/WW1TGjLKQaNxovn0xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F9qL97WIJTDKar0RATFRGa32DomSlp6yFEb0hpSLUU4=;
        b=CqJB7B4gkqs+a53NkpHJcIOLPUjZ3ecIa+g/KYn6faFhN+kbZfK9HN266TBFDrrDyN
         9zfpAvT7VmAXRblLw7CoaUSSjh51GfHtweXUskSllGJz8hidbEDlbXij/ErWGEAAp1Ns
         FtrqQjqc3vhV8haGDPXV7vYh/x3cjPzaI81/e5KVytFu4kKvypAawTUCKpmwTY0ucaA+
         8tgYBYliB1/jjLyZAcKgaIDEjxT+3VUFaRrwq14E+b30Y/4/eefbNEg+hEiVWMQIHbsP
         Z+LIqHLKSaFXfUWak1ZHHiYy1Hd3/khZWScRgFvi8UJPVAkOh32MlYPiCzbDOfI65ucw
         nIsA==
X-Gm-Message-State: APt69E03R//4CjxG7zkS59ZooK+UoEhQYpgvO/iPcF64gEJDZGtMYa8I
        BiLZlHdo+l/Ugw26QrO01ynu/g==
X-Google-Smtp-Source: AAOMgpcrG1irlTbZFj0LnRjTzNYrHGLfMuPQXENZyPCdi+zpXzl4C6uTe8hsZO+M7pJ+87jyG1v1sg==
X-Received: by 2002:a62:5486:: with SMTP id i128-v6mr18832326pfb.166.1531094833749;
        Sun, 08 Jul 2018 17:07:13 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id f69-v6sm17703443pfc.23.2018.07.08.17.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 17:07:13 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH v3 1/3] arm64: export memblock_reserve()d regions via /proc/iomem
Date:   Mon,  9 Jul 2018 09:07:48 +0900
Message-Id: <20180709000750.22172-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180709000750.22172-1-takahiro.akashi@linaro.org>
References: <20180709000750.22172-1-takahiro.akashi@linaro.org>
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
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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

