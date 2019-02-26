Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F3FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0E72173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551162059;
	bh=AtAztDL7+7p8nUfEfFfSoH1wEP5TYqEbRxfTAlZ6z1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=KKKR86WL/rveKFBAg9u9Al2NiJaU5+C3u+mQ5GPn8QpWMkEicmFQQscK9ou/BljdK
	 1glHv7AtNkZdDzcPwZyJ7mop5QvHR6l5WzT/PEHaB2hgSq2v+3vO5ry0RyKBTfAs1i
	 daLMMWw1yNavYnEeIfK8CCEqGkI0N1ozyNg9Fc20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfBZGU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:20:57 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53685 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfBZGUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:20:41 -0500
Received: by mail-it1-f193.google.com with SMTP id v2so2302345ith.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=BjNwn/G+9pD4awESIPsiatYd7sIFG+GkgtYRhzqqgec=;
        b=Y+SG1GOyMlEU/NnW8diTJXqn20frH/ZrAgHP5901fD+yHJMHj4zDzxcuks2PhFKsKt
         lMa7ZSYdXS6rD12oDzXQjPCDoFiyGVEUVTJ7VvXNSrt5ms/8k++BVZeDok56f6hbfb11
         jcaWC6Cbw8G1q1iuN92ovoulx12wzaTXVU7QWzmxHdx1wvPUrFmxVrD5oM/PU/+uf2OG
         kG2fQw8as73RJoYK5U1w1YQi1dog5KK9bm+gPSjBcr+PnPv/kEPGFhpfOPHqlQz9zDGN
         DSa0Cv8lSTjcY+yBPhqMAma6cXBQ2AwezBN+3iIPLJX97huJiXx8KovBE94CN75WMjvA
         tjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=BjNwn/G+9pD4awESIPsiatYd7sIFG+GkgtYRhzqqgec=;
        b=GoyDxSPEtOKwg0a6LxKoKcoJs/7va+lnCYUugAduHJBE/R7LPlldljZF7kwqrDsjkF
         q6KlChqktYFD1SODukwJQDQgnV3q4inqY6jEfEp1QbH2FfBxt9f1YA1rjKNMmqLEsXw2
         qdpUH00h2sZB4a12xoMOw1EC2kjk3m/lq+w3q5B9v1M720gU8dmdrZziTV8hEBpBhA4X
         R7y6QTp9QSexLRqA6YWovcnqdWO9RWDODH6NxJlHzxUnbBI/U3P1ZUdNqX95Or0LtWGl
         a2TVsA4n1jEK0wuF2BC4viQyuecJM5GUqOmUqbRiM2pGk5IsntGJtOmMocTFdTzQVCPY
         hkvg==
X-Gm-Message-State: AHQUAuaRYt2HnVOJDdWr2150jDQ1HFwvNfrabMv3oJnckwSESuVhPkRg
        yEdNe505cI0dDu+G8OQUs1s=
X-Google-Smtp-Source: AHgI3IbG0Y+gB9/99IP31njcj8RAQjpmFH6LgiFFTBLyge/0TxqcXcnxiuUMtbd8dy2Ro6Keexgxdg==
X-Received: by 2002:a02:97ee:: with SMTP id v43mr11836251jaj.67.1551162040051;
        Mon, 25 Feb 2019 22:20:40 -0800 (PST)
Received: from kbl.lan (h66-222-56-144.cntcnh.dsl.dynamic.tds.net. [66.222.56.144])
        by smtp.gmail.com with ESMTPSA id w8sm6431431ita.21.2019.02.25.22.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:20:39 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 14/14] topology: Create die_threads sysfs attribute
Date:   Tue, 26 Feb 2019 01:20:12 -0500
Message-Id: <2a30710fa16d38da4b6dd24ff9cc6d50a16c0c87.1551160674.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

The die_threads show all the logical CPUs that share the same die_id.

Signed-off-by: Len Brown <len.brown@intel.com>
Suggested-by: Brice Goglin <Brice.Goglin@inria.fr>
---
 Documentation/cputopology.txt   | 12 ++++++++++++
 arch/x86/include/asm/smp.h      |  1 +
 arch/x86/include/asm/topology.h |  1 +
 arch/x86/kernel/smpboot.c       | 22 ++++++++++++++++++++++
 arch/x86/xen/smp_pv.c           |  1 +
 drivers/base/topology.c         |  6 ++++++
 include/linux/topology.h        |  3 +++
 7 files changed, 46 insertions(+)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index e67915a8a512..6c25ce682c90 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -56,6 +56,16 @@ package_threads_list:
 	human-readable list of cpuX's hardware threads within the same
 	physical_package_id. (deprecated name: "core_siblings_list")
 
+die_threads:
+
+	internal kernel map of cpuX's hardware threads within the same
+	die_id.
+
+die_threads_list:
+
+	human-readable list of cpuX's hardware threads within the same
+	die_id.
+
 book_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
@@ -92,6 +102,7 @@ these macros in include/asm-XXX/topology.h::
 	#define topology_drawer_id(cpu)
 	#define topology_sibling_cpumask(cpu)
 	#define topology_core_cpumask(cpu)
+	#define topology_die_cpumask(cpu)
 	#define topology_book_cpumask(cpu)
 	#define topology_drawer_cpumask(cpu)
 
@@ -108,6 +119,7 @@ not defined by include/asm-XXX/topology.h:
 2) topology_core_id: 0
 3) topology_sibling_cpumask: just the given CPU
 4) topology_core_cpumask: just the given CPU
+5) topology_die_cpumask: just the given CPU
 
 For architectures that don't support books (CONFIG_SCHED_BOOK) there are no
 default definitions for topology_book_id() and topology_book_cpumask().
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
index 88578f10ae22..c573b0a26e16 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -111,6 +111,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
 #ifdef CONFIG_SMP
+#define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e332d5e59652..d30fd42a3285 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -90,6 +90,10 @@ EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 
+/* representing HT, core, and die siblings of each logical CPU */
+DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
+EXPORT_PER_CPU_SYMBOL(cpu_die_map);
+
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 
 /* Per CPU bogomips and other parameters */
@@ -511,6 +515,15 @@ static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return false;
 }
 
+static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
+{
+	if ((c->phys_proc_id == o->phys_proc_id) &&
+		(c->cpu_die_id == o->cpu_die_id))
+		return true;
+	return false;
+}
+
+
 #if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_MC)
 static inline int x86_sched_itmt_flags(void)
 {
@@ -573,6 +586,7 @@ void set_cpu_sibling_map(int cpu)
 		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
 		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
 		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
+		cpumask_set_cpu(cpu, topology_die_cpumask(cpu));
 		c->booted_cores = 1;
 		return;
 	}
@@ -621,6 +635,9 @@ void set_cpu_sibling_map(int cpu)
 		}
 		if (match_pkg(c, o) && !topology_same_node(c, o))
 			x86_has_numa_in_package = true;
+
+		if ((i == cpu) || (has_mp && match_die(c, o)))
+			link_mask(topology_die_cpumask, cpu, i);
 	}
 
 	threads = cpumask_weight(topology_sibling_cpumask(cpu));
@@ -1216,6 +1233,7 @@ static __init void disable_smp(void)
 		physid_set_mask_of_physid(0, &phys_cpu_present_map);
 	cpumask_set_cpu(0, topology_sibling_cpumask(0));
 	cpumask_set_cpu(0, topology_core_cpumask(0));
+	cpumask_set_cpu(0, topology_die_cpumask(0));
 }
 
 /*
@@ -1311,6 +1329,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
+		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
 	}
 
@@ -1531,6 +1550,8 @@ static void remove_siblinginfo(int cpu)
 			cpu_data(sibling).booted_cores--;
 	}
 
+	for_each_cpu(sibling, topology_die_cpumask(cpu))
+		cpumask_clear_cpu(cpu, topology_die_cpumask(sibling));
 	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
 	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
@@ -1538,6 +1559,7 @@ static void remove_siblinginfo(int cpu)
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
index 73efadf5e6d4..b6d1fec9b6a3 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -61,6 +61,10 @@ define_siblings_show_func(core_siblings, core_cpumask);
 static DEVICE_ATTR_RO(core_siblings);
 static DEVICE_ATTR_RO(core_siblings_list);
 
+define_siblings_show_func(die_threads, die_cpumask);
+static DEVICE_ATTR_RO(die_threads);
+static DEVICE_ATTR_RO(die_threads_list);
+
 define_siblings_show_func(package_threads, core_cpumask);
 static DEVICE_ATTR_RO(package_threads);
 static DEVICE_ATTR_RO(package_threads_list);
@@ -91,6 +95,8 @@ static struct attribute *default_attrs[] = {
 	&dev_attr_core_threads_list.attr,
 	&dev_attr_core_siblings.attr,
 	&dev_attr_core_siblings_list.attr,
+	&dev_attr_die_threads.attr,
+	&dev_attr_die_threads_list.attr,
 	&dev_attr_package_threads.attr,
 	&dev_attr_package_threads_list.attr,
 #ifdef CONFIG_SCHED_BOOK
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

