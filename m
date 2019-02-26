Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE92C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740242173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551162089;
	bh=pt6xs2U1Eb/X2vUZbeqGFxXI9K7N3DOe9bOogCRxgaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=vhV83Z2PTGFj7wJFglAw7LsjNRPw9cT/tLvj8yghiy7NuHvwFKlA1ojlBbgwZP6ZN
	 CnIkLRyQSvrnziE9gDV9Nho7ZKFqe/dEA6vyg5N++3TjtaAUHzvoEzdWJkZBWZ2IFl
	 vodwJPegZetPHiDyM25PTQYpm2HHkkx+M0+MRC7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfBZGUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:20:33 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33490 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBZGUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:20:31 -0500
Received: by mail-io1-f66.google.com with SMTP id e186so9658419ioa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=5s4iaUk5G4BKW5d0ZfE1BNqmDfJkUUMMRvl82HR6uYU=;
        b=MMfSO6VfcbihoZJz07B3ohISpNJv7R848wPhSem6PuV/zmqu0KBK4cHIoxj4Ec/Osf
         pfWtKU3o8bn+HzfPbwH+WfVm46zgudCVtwuUvqUX4KgnU2V5FUqo4wlZfCLTYhjtgfbi
         pcCdcBUakNE/Z6lTtZwz7tfsrSI4zZtg3nZmgpnmgK7pLC/9CXI924MZdJICA5NKhmZ5
         ajrGGSSSTRcxnVIYPlWlmjJmcaMcPg6Qb4HQ5sz9V5+R/it+Zn9tdIcP7jlTdjl04xLQ
         jsqtfirrrWHHFDRhf4laWUNioFdaE9JUw3WtzqOkCAmwt/s8RVbq2Ut5qYvJHmu+SLlE
         dHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=5s4iaUk5G4BKW5d0ZfE1BNqmDfJkUUMMRvl82HR6uYU=;
        b=iqWYuUwnX9RsA+HIPiqREvdRuChEtJxNlHQMwqrdFLlvbDTELjNttAzkF8OJAJyh4S
         9IxctdQv6LFgGfnLyg9e+C9u2z/mwdducQTUIM/bv0LGl889G/6spnvP0DHyFR7GbiSG
         nhtTv1HTWpWITAjKxq9oIZA8eyuZIu3BKAAokAsNpzUZMUvUK5sSIA8Hdh+oYdCxIeNh
         2vdWYoR0f3ftydtkJLtNamxp6/9a/Tu1bXajUhqRFNlKpLhFSYgkBxpJkYU+LETnblA5
         TWn5JGGGSyTp1vbUoo5klxo5TJsy/FySdw08yzzw0dZERZi3AaETvDKhCrynAfCmlGSy
         J23A==
X-Gm-Message-State: AHQUAubVCXCa+QBBv281uLIw7HE/sh64wgBtjGTdXYlWJzZKrx5Jt9Bn
        u4iQFVUyyARQXH29xv3lvzE=
X-Google-Smtp-Source: AHgI3IaLIjsBO87VPp6mnqu4h0YNHmSg6mUvbnf4ra3FKdLsesTHpScJ1YZMceCbkBINLsJoPW90Jw==
X-Received: by 2002:a5e:dc4c:: with SMTP id s12mr2898088iop.304.1551162030038;
        Mon, 25 Feb 2019 22:20:30 -0800 (PST)
Received: from kbl.lan (h66-222-56-144.cntcnh.dsl.dynamic.tds.net. [66.222.56.144])
        by smtp.gmail.com with ESMTPSA id w8sm6431431ita.21.2019.02.25.22.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:20:29 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 06/14] x86 topology: Define topology_logical_die_id()
Date:   Tue, 26 Feb 2019 01:20:04 -0500
Message-Id: <37c6d731ce06497d2ba246f3bc9b764bdebd51c7.1551160674.git.len.brown@intel.com>
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

Define topology_logical_die_id() ala
existing topology_logical_package_id()

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/include/asm/topology.h  |  3 +++
 arch/x86/kernel/smpboot.c        | 43 ++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index f2856fe03715..ee34ff34889d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -119,6 +119,7 @@ struct cpuinfo_x86 {
 	/* Core id: */
 	u16			cpu_core_id;
 	u16			cpu_die_id;
+	u16			logical_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
 	u32			microcode;
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 281be6bbc80d..88578f10ae22 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -106,6 +106,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
+#define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
@@ -125,6 +126,7 @@ static inline int topology_max_smt_threads(void)
 
 int topology_update_package_map(unsigned int apicid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
+int topology_phys_to_logical_die(unsigned int die);
 bool topology_is_primary_thread(unsigned int cpu);
 bool topology_smt_supported(void);
 #else
@@ -132,6 +134,7 @@ bool topology_smt_supported(void);
 static inline int
 topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
+static inline int topology_phys_to_logical_die(unsigned int die) { return 0; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
 static inline bool topology_smt_supported(void) { return false; }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c70e547b18c2..e332d5e59652 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -100,6 +100,7 @@ EXPORT_PER_CPU_SYMBOL(cpu_info);
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
 static unsigned int logical_packages __read_mostly;
+static unsigned int logical_die __read_mostly;
 
 /* Maximum number of SMT threads on any online core */
 int __read_mostly __max_smt_threads = 1;
@@ -306,6 +307,24 @@ int topology_phys_to_logical_pkg(unsigned int phys_pkg)
 	return -1;
 }
 EXPORT_SYMBOL(topology_phys_to_logical_pkg);
+/**
+ * topology_phys_to_logical_die - Map a physical die id to logical
+ *
+ * Returns logical die id or -1 if not found
+ */
+int topology_phys_to_logical_die(unsigned int die_id)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct cpuinfo_x86 *c = &cpu_data(cpu);
+
+		if (c->initialized && c->cpu_die_id == die_id)
+			return c->logical_proc_id;
+	}
+	return -1;
+}
+EXPORT_SYMBOL(topology_phys_to_logical_die);
 
 /**
  * topology_update_package_map - Update the physical to logical package map
@@ -330,6 +349,29 @@ int topology_update_package_map(unsigned int pkg, unsigned int cpu)
 	cpu_data(cpu).logical_proc_id = new;
 	return 0;
 }
+/**
+ * topology_update_die_map - Update the physical to logical die map
+ * @die:	The die id as retrieved via CPUID
+ * @cpu:	The cpu for which this is updated
+ */
+int topology_update_die_map(unsigned int die, unsigned int cpu)
+{
+	int new;
+
+	/* Already available somewhere? */
+	new = topology_phys_to_logical_pkg(die);
+	if (new >= 0)
+		goto found;
+
+	new = logical_die++;
+	if (new != die) {
+		pr_info("CPU %u Converting physical %u to logical die %u\n",
+			cpu, die, new);
+	}
+found:
+	cpu_data(cpu).logical_die_id = new;
+	return 0;
+}
 
 void __init smp_store_boot_cpu_info(void)
 {
@@ -339,6 +381,7 @@ void __init smp_store_boot_cpu_info(void)
 	*c = boot_cpu_data;
 	c->cpu_index = id;
 	topology_update_package_map(c->phys_proc_id, id);
+	topology_update_die_map(c->cpu_die_id, id);
 	c->initialized = true;
 }
 
-- 
2.18.0-rc0

