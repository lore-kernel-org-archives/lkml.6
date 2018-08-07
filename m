Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7944BC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A78F2170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHUCjOcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A78F2170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389787AbeHGVDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:03:25 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37621 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388967AbeHGVDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:03:24 -0400
Received: by mail-pl0-f67.google.com with SMTP id d5-v6so7496727pll.4;
        Tue, 07 Aug 2018 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/kjQV9Fi7YW7q+88XPzYoNpx/7/UdBcNCgqwpklneso=;
        b=NHUCjOcNK53z2YwJT1gLliKOB6QO66/dSIKhfFz0/AyFux4V3ZuCiM8Evqfntlp1Pb
         eG4MZK0Otg3dAHyTKPTRlLWNnkL90pSweqmo08b7nabI5rXca/ZP8X3RHd1p9NGsGbke
         OceMwkQcfa4H9+idoMa7/kq47IdLIn51REhjYc9dOkepX4XfhkjaTtV6Eq8iYnNQgPpC
         kZLzEuaAP/w1A9r8VbFNtcCTmOje0ueJHIy90LTVqGlC66+fwelOfUxNuvHAGyskMDWD
         xnSNi3ufxd2TeI9WpHK7D/oHZqG+iMLOsgX/uZbseKyja4xcyuwzLrQRyyJd5KMcJe3/
         klow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/kjQV9Fi7YW7q+88XPzYoNpx/7/UdBcNCgqwpklneso=;
        b=DoGFTELH9ZDKX2+y1IERrwypQbLcWKTVihgYFcT9o/OamZIsbriIQPsEzawg3UzLV0
         iksu09cLrhoQr7baLBBQq/yUr7xaqRoGCwGMwYLCt7UZInxMAnr9vBLK/1nfLG5+GJsv
         WYJ8T1W7UtYJfln+TPGS43Mjy16asOdVKrAAOXI7pWqfRDvEynHnly6TX0Fi7jie/SwI
         8cDQgglFpqtHyypEN3IfT/+KH4mxmye0/FLMWVS2zr1VqkGavuXE4GAn7eVC1oUAaTy2
         T1U8DcEpPZD9gOBgB/yp4eKlrEQhkMFRJy6J97SId9unp4TrbNfmrYc+avys050uC7J5
         BqxA==
X-Gm-Message-State: AOUpUlGupHmPCj/R53cvc6TDKyuL+V0LHBiEsTy2i1f8DQxXEsKF6Ej7
        RU3XoGcuAHErieY9Kkk/myI=
X-Google-Smtp-Source: AAOMgpfih/6hd8KruJOPHvmWaKxs+qEAGlhnFaDtg9GHjuyGezbUPBxT58tQFCWeipeAcKdvDkiOpQ==
X-Received: by 2002:a17:902:6b4c:: with SMTP id g12-v6mr18502308plt.159.1533667663052;
        Tue, 07 Aug 2018 11:47:43 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.136])
        by smtp.gmail.com with ESMTPSA id e14-v6sm2121609pgv.48.2018.08.07.11.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 11:47:41 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel-team@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH v2] proc: add percpu populated pages count to meminfo
Date:   Tue,  7 Aug 2018 11:47:23 -0700
Message-Id: <20180807184723.74919-1-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

Currently, percpu memory only exposes allocation and utilization
information via debugfs. This more or less is only really useful for
understanding the fragmentation and allocation information at a
per-chunk level with a few global counters. This is also gated behind a
config. BPF and cgroup, for example, have seen an increase use causing
increased use of percpu memory. Let's make it easier for someone to
identify how much memory is being used.

This patch adds the "Percpu" stat to meminfo to more easily look up how
much percpu memory is in use. This number includes the cost for all
allocated backing pages and not just isnight at the a unit, per chunk
level. Metadata is excluded. I think excluding metadata is fair because
the backing memory scales with the numbere of cpus and can quickly
outweigh the metadata. It also makes this calculation light.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
---
 Documentation/filesystems/proc.txt |  3 +++
 fs/proc/meminfo.c                  |  2 ++
 include/linux/percpu.h             |  2 ++
 mm/percpu.c                        | 29 +++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 520f6a84cf50..490f803be1ec 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -870,6 +870,7 @@ Committed_AS:   100056 kB
 VmallocTotal:   112216 kB
 VmallocUsed:       428 kB
 VmallocChunk:   111088 kB
+Percpu:          62080 kB
 AnonHugePages:   49152 kB
 ShmemHugePages:      0 kB
 ShmemPmdMapped:      0 kB
@@ -959,6 +960,8 @@ Committed_AS: The amount of memory presently allocated on the system.
 VmallocTotal: total size of vmalloc memory area
  VmallocUsed: amount of vmalloc area which is used
 VmallocChunk: largest contiguous block of vmalloc area which is free
+      Percpu: Memory allocated to the percpu allocator used to back percpu
+              allocations. This stat excludes the cost of metadata.
 
 ..............................................................................
 
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 2fb04846ed11..edda898714eb 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -7,6 +7,7 @@
 #include <linux/mman.h>
 #include <linux/mmzone.h>
 #include <linux/proc_fs.h>
+#include <linux/percpu.h>
 #include <linux/quicklist.h>
 #include <linux/seq_file.h>
 #include <linux/swap.h>
@@ -121,6 +122,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		   (unsigned long)VMALLOC_TOTAL >> 10);
 	show_val_kb(m, "VmallocUsed:    ", 0ul);
 	show_val_kb(m, "VmallocChunk:   ", 0ul);
+	show_val_kb(m, "Percpu:         ", pcpu_nr_pages());
 
 #ifdef CONFIG_MEMORY_FAILURE
 	seq_printf(m, "HardwareCorrupted: %5lu kB\n",
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 296bbe49d5d1..70b7123f38c7 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -149,4 +149,6 @@ extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
 	(typeof(type) __percpu *)__alloc_percpu(sizeof(type),		\
 						__alignof__(type))
 
+extern unsigned long pcpu_nr_pages(void);
+
 #endif /* __LINUX_PERCPU_H */
diff --git a/mm/percpu.c b/mm/percpu.c
index 0b6480979ac7..a749d4d96e3e 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -169,6 +169,14 @@ static LIST_HEAD(pcpu_map_extend_chunks);
  */
 int pcpu_nr_empty_pop_pages;
 
+/*
+ * The number of populated pages in use by the allocator, protected by
+ * pcpu_lock.  This number is kept per a unit per chunk (i.e. when a page gets
+ * allocated/deallocated, it is allocated/deallocated in all units of a chunk
+ * and increments/decrements this count by 1).
+ */
+static unsigned long pcpu_nr_populated;
+
 /*
  * Balance work is used to populate or destroy chunks asynchronously.  We
  * try to keep the number of populated free pages between
@@ -1232,6 +1240,7 @@ static void pcpu_chunk_populated(struct pcpu_chunk *chunk, int page_start,
 
 	bitmap_set(chunk->populated, page_start, nr);
 	chunk->nr_populated += nr;
+	pcpu_nr_populated += nr;
 
 	if (!for_alloc) {
 		chunk->nr_empty_pop_pages += nr;
@@ -1260,6 +1269,7 @@ static void pcpu_chunk_depopulated(struct pcpu_chunk *chunk,
 	chunk->nr_populated -= nr;
 	chunk->nr_empty_pop_pages -= nr;
 	pcpu_nr_empty_pop_pages -= nr;
+	pcpu_nr_populated -= nr;
 }
 
 /*
@@ -2176,6 +2186,9 @@ int __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 	pcpu_nr_empty_pop_pages = pcpu_first_chunk->nr_empty_pop_pages;
 	pcpu_chunk_relocate(pcpu_first_chunk, -1);
 
+	/* include all regions of the first chunk */
+	pcpu_nr_populated += PFN_DOWN(size_sum);
+
 	pcpu_stats_chunk_alloc();
 	trace_percpu_create_chunk(base_addr);
 
@@ -2745,6 +2758,22 @@ void __init setup_per_cpu_areas(void)
 
 #endif	/* CONFIG_SMP */
 
+/*
+ * pcpu_nr_pages - calculate total number of populated backing pages
+ *
+ * This reflects the number of pages populated to back chunks.  Metadata is
+ * excluded in the number exposed in meminfo as the number of backing pages
+ * scales with the number of cpus and can quickly outweigh the memory used for
+ * metadata.  It also keeps this calculation nice and simple.
+ *
+ * RETURNS:
+ * Total number of populated backing pages in use by the allocator.
+ */
+unsigned long pcpu_nr_pages(void)
+{
+	return pcpu_nr_populated * pcpu_nr_units;
+}
+
 /*
  * Percpu allocator is initialized early during boot when neither slab or
  * workqueue is available.  Plug async management until everything is up
-- 
2.17.1

