Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9835AC4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC5621A60
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6KGPCXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC5621A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbeHGDLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:11:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45236 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730834AbeHGDLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:11:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so7650811pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 17:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cSRf+70LKurme3/BfQF5YuMiZQsCYFTMoW03DV75JHc=;
        b=f6KGPCXiwLKH7FCSjVu3s9zfka9jCoDv3JszR3ZsCydaukjHVBvQGOF+t/Aon3qSR3
         00Rc9esOLNMPviI23Wjx3pkQ00cDD8L65j5eDbkFfm+qKcw7Mw/dc3P4C7Uby04MFnXH
         cH+yBV2xhBIYRAFHv8501V0L9jzv1C1HlRlf68hQZ7SfD0fzHJjYaiRWlxHYZzGsYolf
         11QA+K21tkj+Sfak7P0tTMwR55G327DNhytVRLnnpLWgxm8qf7hGubUwX4sYFCpC2NHS
         FmBIIXjzIJlxGK7p1AphwOKAohKs2fcCoMrr//GdsaExEVmsGH7JslD7MIBnPOjvymid
         53LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cSRf+70LKurme3/BfQF5YuMiZQsCYFTMoW03DV75JHc=;
        b=nt3lYo4rV8jnF01/p4oGQzaPU9jcBdFd2IkgcZ3M+9Eq59G6+sKIFq4LY2x6NDe4zG
         /+Hfc09pbGZ30MiDx4c8eat7WSGM+zn4tB+luI3VW4U6DWcVSt1lKVTlXdZ4hWO5HXKK
         p1g9nwgnN8yjsyVLJISBMS4hfcbtVkPUEcm3Urh7eQoyIaf18FPDNTDiXB028M3bG4wc
         HHSkvhyRutbQC1GSXhrckgIrxkpckSIIZNWJRBev6MtPFgUml6OwTl/atZeSCJYsiuSt
         n1W6Obru9FVLbI+ykn8KvN/ydEl41h/0GscovJScKr/82Xh8/p72PhI/mzaG+dOGdbu5
         cuCQ==
X-Gm-Message-State: AOUpUlESW/fqh/XobTet1Owd2I1sSP9gfd/obfp1THYsilrcG2+fACbk
        4CTzwfUoQMcRjcUmwehh7KU=
X-Google-Smtp-Source: AAOMgpckwumuNaIfZrRE33JsrGTZUFs2Q/m8OxmYXb6bhQXVRzFQ77wyjMabVVHDqVm/PeZ5G5158A==
X-Received: by 2002:aa7:824d:: with SMTP id e13-v6mr18133949pfn.97.1533603571951;
        Mon, 06 Aug 2018 17:59:31 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.136])
        by smtp.gmail.com with ESMTPSA id k64-v6sm17380568pgd.47.2018.08.06.17.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 17:59:31 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>
Cc:     kernel-team@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH] proc: add percpu populated pages count to meminfo
Date:   Mon,  6 Aug 2018 17:56:07 -0700
Message-Id: <20180807005607.53950-1-dennisszhou@gmail.com>
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

This patch adds the PercpuPopulated stat to meminfo to more easily
look up how much percpu memory is in use. This new number includes the
cost for all backing pages and not just insight at the a unit, per
chunk level. This stat includes only pages used to back the chunks
themselves excluding metadata. I think excluding metadata is fair
because the backing memory scales with the number of cpus and can
quickly outweigh the metadata. It also makes this calculation light.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
---
 fs/proc/meminfo.c      |  2 ++
 include/linux/percpu.h |  2 ++
 mm/percpu.c            | 29 +++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 2fb04846ed11..ddd5249692e9 100644
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
+	show_val_kb(m, "PercpuPopulated:", pcpu_nr_populated_pages());
 
 #ifdef CONFIG_MEMORY_FAILURE
 	seq_printf(m, "HardwareCorrupted: %5lu kB\n",
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 296bbe49d5d1..1c80be42822c 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -149,4 +149,6 @@ extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
 	(typeof(type) __percpu *)__alloc_percpu(sizeof(type),		\
 						__alignof__(type))
 
+extern int pcpu_nr_populated_pages(void);
+
 #endif /* __LINUX_PERCPU_H */
diff --git a/mm/percpu.c b/mm/percpu.c
index 0b6480979ac7..08a4341f30c5 100644
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
+static int pcpu_nr_populated;
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
+ * pcpu_nr_populated_pages - calculate total number of populated backing pages
+ *
+ * This reflects the number of pages populated to back the chunks.
+ * Metadata is excluded in the number exposed in meminfo as the number of
+ * backing pages scales with the number of cpus and can quickly outweigh the
+ * memory used for metadata.  It also keeps this calculation nice and simple.
+ *
+ * RETURNS:
+ * Total number of populated backing pages in use by the allocator.
+ */
+int pcpu_nr_populated_pages(void)
+{
+	return pcpu_nr_populated * pcpu_nr_units;
+}
+
 /*
  * Percpu allocator is initialized early during boot when neither slab or
  * workqueue is available.  Plug async management until everything is up
-- 
2.17.1

