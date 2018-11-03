Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1E7C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C563A2081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="WQbuouCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C563A2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbeKDDto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:49:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34174 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbeKDDto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:49:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so4543504ljd.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oibLHzbg3JlPRaoRysBCeN2jQkD87yuFbgEOeu8YCVY=;
        b=WQbuouCMpYNnb6Pp8kdicu4IweINyQ0gcttcH8Lf3ZL6J2bq5h0F07u2p+7XImPYeM
         QTPcoj8D4FxYQW9uS47SU3TonhCCQg3BvuGjh0i5WVBFgnH5hUE2e0XFk4NBDpNJTxLh
         eEUaNf5okaQNKKcOLse9YEY4LrjYJf2YJBsS5iwpIYjL8YMA5JdNSjFjo2fS1pATamUI
         jMP0C3WYMZp080vuGtEMwVdlXPTEqIPBSfZ12sVcEZgC7dvbnUZFHPlHyQMVJSo7zh2l
         6jMnhPPKDSo9ZlB2lynbmsUJneOxASuuustN/NVJ3mcR/NTLkJu6Vx30kimQEQhedTS+
         Pv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oibLHzbg3JlPRaoRysBCeN2jQkD87yuFbgEOeu8YCVY=;
        b=arXd0lRZcSLLhYJ9IvJjvDUhD474b/yLpPYH1t7tUDx0gugs9vJQwGK1TtQK/9OV6S
         GbIiRNkKwMTHYNEMX9xsaetr3QO7715JRNJux/D2C6dat1Oh5TUYBy2H3lFAuFJiSlvU
         Ie+5qoA9J3GRDwjTbey+AzvQwsr3+eUoYXNK/LXlw25uCBWvu5kdHlVP74dOWoWunnQo
         oWkMOXOTuCP7sl0ClUYHsXty/+/v7byBbBXG/GWEr3cA3a/dN8U1uPUBifKJdzOlMWCv
         /IhZUAkVJ8ocgc9WnF6d2rbToUTdwfDRQfusdLwT/1UZVOfUeNqKsthHZGrTPShoJrCc
         og0g==
X-Gm-Message-State: AGRZ1gL7sjjrVy74wyFh4LAEj76WFGAHegwnmAxSAjtsiLEgdVm9kERv
        +fC88JmwxrwP+NqytVf0qF+bxw==
X-Google-Smtp-Source: AJdET5ecKYZe97n+/A7yDlVwZspxlXIicMs8/6TcE3tMLm7imhjw1QVsPj7R7cSIb8VrC5QzMYSsqg==
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr9422585ljc.97.1541270258360;
        Sat, 03 Nov 2018 11:37:38 -0700 (PDT)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id 26-v6sm4794682lje.18.2018.11.03.11.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 11:37:37 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     tony.luck@intel.com, fenghua.yu@intel.com
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@fb.com, =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] ia64: export node_distance function
Date:   Sat,  3 Nov 2018 19:37:16 +0100
Message-Id: <20181103183716.28841-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The numa_slit variable used by node_distance is available to a
module as long as it is linked at compile-time. However, it is
not available to loadable modules. Leading to errors such as:

  ERROR: "numa_slit" [drivers/nvme/host/nvme-core.ko] undefined!

The error above is caused by the nvme multipath code that makes
use of node_distance for its path calculation. When the patch was
added, the lightnvm subsystem would select nvme and always compile
it in, leading to the node_distance call to always succeed.
However, when this requirement was removed, nvme could be compiled
in as a module, which exposed this bug.

This patch extracts node_distance to a function and exports it.
Since ACPI is depending on node_distance being a simple lookup to
numa_slit, the previous behavior is exposed as slit_distance and its
users updated.

Fixes: f333444708f82 "nvme: take node locality into account when selecting a path"
Fixes: 73569e11032f "lightnvm: remove dependencies on BLK_DEV_NVME and PCI"
Signed-off-by: Matias Bjøring <mb@lightnvm.io>
---
 arch/ia64/include/asm/numa.h | 4 +++-
 arch/ia64/kernel/acpi.c      | 6 +++---
 arch/ia64/mm/numa.c          | 6 ++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/include/asm/numa.h b/arch/ia64/include/asm/numa.h
index ebef7f40aabb..c5c253cb9bd6 100644
--- a/arch/ia64/include/asm/numa.h
+++ b/arch/ia64/include/asm/numa.h
@@ -59,7 +59,9 @@ extern struct node_cpuid_s node_cpuid[NR_CPUS];
  */
 
 extern u8 numa_slit[MAX_NUMNODES * MAX_NUMNODES];
-#define node_distance(from,to) (numa_slit[(from) * MAX_NUMNODES + (to)])
+#define slit_distance(from,to) (numa_slit[(from) * MAX_NUMNODES + (to)])
+extern int __node_distance(int from, int to);
+#define node_distance(from,to) __node_distance(from, to)
 
 extern int paddr_to_nid(unsigned long paddr);
 
diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 1dacbf5e9e09..41eb281709da 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -578,8 +578,8 @@ void __init acpi_numa_fixup(void)
 	if (!slit_table) {
 		for (i = 0; i < MAX_NUMNODES; i++)
 			for (j = 0; j < MAX_NUMNODES; j++)
-				node_distance(i, j) = i == j ? LOCAL_DISTANCE :
-							REMOTE_DISTANCE;
+				slit_distance(i, j) = i == j ?
+					LOCAL_DISTANCE : REMOTE_DISTANCE;
 		return;
 	}
 
@@ -592,7 +592,7 @@ void __init acpi_numa_fixup(void)
 			if (!pxm_bit_test(j))
 				continue;
 			node_to = pxm_to_node(j);
-			node_distance(node_from, node_to) =
+			slit_distance(node_from, node_to) =
 			    slit_table->entry[i * slit_table->locality_count + j];
 		}
 	}
diff --git a/arch/ia64/mm/numa.c b/arch/ia64/mm/numa.c
index aa19b7ac8222..5769d4b21270 100644
--- a/arch/ia64/mm/numa.c
+++ b/arch/ia64/mm/numa.c
@@ -36,6 +36,12 @@ struct node_cpuid_s node_cpuid[NR_CPUS] =
  */
 u8 numa_slit[MAX_NUMNODES * MAX_NUMNODES];
 
+int __node_distance(int from, int to)
+{
+	return slit_distance(from, to);
+}
+EXPORT_SYMBOL(__node_distance);
+
 /* Identify which cnode a physical address resides on */
 int
 paddr_to_nid(unsigned long paddr)
-- 
2.17.1

