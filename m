Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B823C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD7D21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550547655;
	bh=tWkZgHETQSPaCzmfjk0YdZOHkJ4kA42th6BwbNx0ypw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=VfB8wcNoTo0JpQVuL/4KHQbCh6h/j3rTKigBSfa7hjP8CWonu/b+S0j2w8Q1UmCYL
	 rjphH2qtiYmKkVdi6aNJ49vaYHa6Chu8kFzLOUqF1ZufgIwh+X1m4w8Z+GwxrxP1Mo
	 2GyMf0n8gG5smodolke1ixJdOrKCU75sMNZ2I8S0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfBSDkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:40:33 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34479 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfBSDka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:40:30 -0500
Received: by mail-qt1-f194.google.com with SMTP id w4so21690310qtc.1;
        Mon, 18 Feb 2019 19:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=CLfh/WUtGvxdVy504t8JDKdret4iaIChUZ+IoIQnZuA=;
        b=A1KRYuliNAk11zEbvbgQuMh37xIYSLFFxZ5QaNj5v36BUIpcVnurHE1JP/WQ0NgSY9
         njxJ4aZqSZ68/gLo2UtdJeZosIAlhc7jDhLhEZGYuaVto1DxSzFtPsMjdMc2188pl5Dj
         Nn2dHGCOeFizbW69GVvh9+5LNgSueFvlOR3seOcRSyyNyNNwxLR5jksI8aJTtfiCZsv+
         JHxmS1mDgO9LMOUL7ziLGMipujg6+xbukgbx/uLqnOnqTwLgSGupo0qkQjbPl/RFv6Nd
         8Obr5gYXpe1nKaHlSozLN6Pa6fVdMhYU3/BA8J/9wzChH8gFYF74ijj6HE3ZUBkChgfj
         DV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=CLfh/WUtGvxdVy504t8JDKdret4iaIChUZ+IoIQnZuA=;
        b=Oe9sV9SO40fOdx2RQnCZ9NJ5/YUIrSLJJPPozlhwfPzuEefa1nXaqZwuHXnIIFXaZ5
         Hmc04AuEqy0InFW25YCJWxeedAWmSz9eRvTqJN8EDUQ0EOxnsimRjMzdRsTFCIM/wcjw
         ft060ic8jICFO40KNGoDnM7wOWm2dZYigxIk4l0sBwI+/8ZHp90CN9UTp3aRD0aTCXlR
         BWcujJKtABcFSCVE+c8K/io/KzmEZ+JF9xUpIknRAClntmdtNhBTkjOMvjd6WDPHez3e
         U59tf+3B9s6mpaK+R+lhLu1m95a14OclgnW/HEpFeBO5cTmPxshsydz4YZbvH+p+Uckk
         +/zQ==
X-Gm-Message-State: AHQUAubcrNVsDCB59skONfJBcn/xfD0B43rR3tSog3Nczgcb/UZaD//j
        kTVXhMSPYRiyLuUlb4xpids=
X-Google-Smtp-Source: AHgI3IZ5Xg39f7XjOJWV3Vx1a4z6XeLwsVddkRL9Yap5Mn4rXP0eyPdIu1kYWpgKtWGN7qRlZNZKaQ==
X-Received: by 2002:aed:2534:: with SMTP id v49mr20805338qtc.90.1550547628760;
        Mon, 18 Feb 2019 19:40:28 -0800 (PST)
Received: from kbl.fios-router.home (pool-96-233-42-17.bstnma.fios.verizon.net. [96.233.42.17])
        by smtp.gmail.com with ESMTPSA id u5sm7327680qtg.37.2019.02.18.19.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 19:40:28 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 05/11] x86 topology: export die_siblings
Date:   Mon, 18 Feb 2019 22:40:07 -0500
Message-Id: <0d54a56186fb9be7a8f622a4625a41dc600dd7a4.1550545163.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

like core_siblings, except it shows which die are in the same package.

This is needed for lscpu(1) to correctly display die topology.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/cputopology.txt   | 10 ++++++++++
 arch/x86/include/asm/smp.h      |  1 +
 arch/x86/include/asm/topology.h |  1 +
 arch/x86/kernel/smpboot.c       | 20 ++++++++++++++++++++
 arch/x86/xen/smp_pv.c           |  1 +
 drivers/base/topology.c         |  6 ++++++
 include/linux/topology.h        |  3 +++
 7 files changed, 42 insertions(+)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index 287213b4517b..7dd2ae3df233 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -56,6 +56,16 @@ core_siblings_list:
 	human-readable list of cpuX's hardware threads within the same
 	die_id.
 
+die_siblings:
+
+	internal kernel map of cpuX's hardware threads within the same
+	physical_package_id.
+
+die_siblings_list:
+
+	human-readable list of cpuX's hardware threads within the same
+	physical_package_id.
+
 book_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 2e95b6c1bca3..39266d193597 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -23,6 +23,7 @@ extern unsigned int num_processors;
 
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
+DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
 /* cpus sharing the last level cache: */
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id);
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 281be6bbc80d..a52a572147ba 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -110,6 +110,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
 #ifdef CONFIG_SMP
+#define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 4250a87f57db..42d37e4a1918 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -90,6 +90,10 @@ EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 
+/* representing HT and core and die siblings of each logical CPU */
+DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
+EXPORT_PER_CPU_SYMBOL(cpu_die_map);
+
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 
 /* Per CPU bogomips and other parameters */
@@ -461,6 +465,12 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  * multicore group inside a NUMA node.  If this happens, we will
  * discard the MC level of the topology later.
  */
+static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
+{
+	if (c->phys_proc_id == o->phys_proc_id)
+		return true;
+	return false;
+}
 static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
 	if (c->cpu_die_id == o->cpu_die_id)
@@ -530,6 +540,7 @@ void set_cpu_sibling_map(int cpu)
 		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
 		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
 		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
+		cpumask_set_cpu(cpu, topology_die_cpumask(cpu));
 		c->booted_cores = 1;
 		return;
 	}
@@ -576,8 +587,12 @@ void set_cpu_sibling_map(int cpu)
 			} else if (i != cpu && !c->booted_cores)
 				c->booted_cores = cpu_data(i).booted_cores;
 		}
+
 		if (match_die(c, o) && !topology_same_node(c, o))
 			x86_has_numa_in_package = true;
+
+		if ((i == cpu) || (has_mp && match_pkg(c, o)))
+			link_mask(topology_die_cpumask, cpu, i);
 	}
 
 	threads = cpumask_weight(topology_sibling_cpumask(cpu));
@@ -1173,6 +1188,7 @@ static __init void disable_smp(void)
 		physid_set_mask_of_physid(0, &phys_cpu_present_map);
 	cpumask_set_cpu(0, topology_sibling_cpumask(0));
 	cpumask_set_cpu(0, topology_core_cpumask(0));
+	cpumask_set_cpu(0, topology_die_cpumask(0));
 }
 
 /*
@@ -1268,6 +1284,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
+		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
 	}
 
@@ -1488,6 +1505,8 @@ static void remove_siblinginfo(int cpu)
 			cpu_data(sibling).booted_cores--;
 	}
 
+	for_each_cpu(sibling, topology_die_cpumask(cpu))
+		cpumask_clear_cpu(cpu, topology_die_cpumask(sibling));
 	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
 	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
@@ -1495,6 +1514,7 @@ static void remove_siblinginfo(int cpu)
 	cpumask_clear(cpu_llc_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
+	cpumask_clear(topology_die_cpumask(cpu));
 	c->cpu_core_id = 0;
 	c->booted_cores = 0;
 	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 145506f9fdbe..ac13b0be8448 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -251,6 +251,7 @@ static void __init xen_pv_smp_prepare_cpus(unsigned int max_cpus)
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
+		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
 	}
 	set_cpu_sibling_map(0);
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 50352cf96f85..5b1317ae3262 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -57,6 +57,10 @@ define_siblings_show_func(core_siblings, core_cpumask);
 static DEVICE_ATTR_RO(core_siblings);
 static DEVICE_ATTR_RO(core_siblings_list);
 
+define_siblings_show_func(die_siblings, die_cpumask);
+static DEVICE_ATTR_RO(die_siblings);
+static DEVICE_ATTR_RO(die_siblings_list);
+
 #ifdef CONFIG_SCHED_BOOK
 define_id_show_func(book_id);
 static DEVICE_ATTR_RO(book_id);
@@ -81,6 +85,8 @@ static struct attribute *default_attrs[] = {
 	&dev_attr_thread_siblings_list.attr,
 	&dev_attr_core_siblings.attr,
 	&dev_attr_core_siblings_list.attr,
+	&dev_attr_die_siblings.attr,
+	&dev_attr_die_siblings_list.attr,
 #ifdef CONFIG_SCHED_BOOK
 	&dev_attr_book_id.attr,
 	&dev_attr_book_siblings.attr,
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 5cc8595dd0e4..47a3e3c08036 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -196,6 +196,9 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_core_cpumask
 #define topology_core_cpumask(cpu)		cpumask_of(cpu)
 #endif
+#ifndef topology_die_cpumask
+#define topology_die_cpumask(cpu)		cpumask_of(cpu)
+#endif
 
 #ifdef CONFIG_SCHED_SMT
 static inline const struct cpumask *cpu_smt_mask(int cpu)
-- 
2.18.0-rc0

