Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AIpwx4/lIXPsAEuICmVKNDGNy6O6z3gIoJ8pNhrRQ14M7AGtrMgYfrmgaSToVXWC20ghHQh7mZjC
ARC-Seal: i=1; a=rsa-sha256; t=1524702383; cv=none;
        d=google.com; s=arc-20160816;
        b=tSofqSh2+KJpM6SmCx9/Gf793q9ebgAOnIk+BRSA5mobYdlnf99NX7AfmcaVRuTh3d
         //tmjeNcdIdaKwuupi/sn1Oq5vMr3q6vDD/BtadirWnaix5Te95QiE8QW/ALgv9aSkz7
         mYSPTixRPgNKHD8YO6OxUyuBTUOQCrFhXf560k8gzvQAbUx6iPEpsVxX1xg3GSOVyxyt
         lOe9DgdXO1FnkcMXriTG9BJVE7Q+BOsoBytEjKA4UOV1NRhmzExjc+y6r0j71w+ewskM
         lTrJusm7giI80hCmah9Rjn8m7CwzeDy2QdoWJvM1xO33EdW9UY30R9P05EnARfj3FqVv
         YPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=rPUi0LT3mxRy7rs8cVc7X4T5aAX2XWfQDXmDyIBHd/A=;
        b=z/bO+TLvVcgcZwUhquoM6ChrbK00y4EsQq5eRjAKKc9uphLoElH6Th/Wp3kDXwWB/G
         eDJn0nARo6SZl8vTxSWeoKgpaZ63cbZF4FXLFSsJyUChUc/YGpZe5wHrGPQVAo/wgrx1
         cWUaGzDqUcWLNaBM7/S/GO5SgvvGNOh4ZYQ3f+WcTAMNl/M6LixqeLnPOBBUJfDF7gaP
         mM3Wn3hQ/GD4qeVEb21qnnEGytNeA/1Z3VhTfrhDSxQBJLC9+wpsZitzSFd1IoX6+GTA
         PSda4eekPqwvBYx9xk3F+HdPmteT8d6MXFufs41k4Dfw5OVsKzJhjnMpd64zhHRK/H1G
         matA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: Sudeep.Holla@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo.Pieralisi@arm.com,
	hanjun.guo@linaro.org,
	rjw@rjwysocki.net,
	Will.Deacon@arm.com,
	Catalin.Marinas@arm.com,
	gregkh@linuxfoundation.org,
	Mark.Rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org,
	ahs3@redhat.com,
	Dietmar.Eggemann@arm.com,
	Morten.Rasmussen@arm.com,
	palmer@sifive.com,
	lenb@kernel.org,
	john.garry@huawei.com,
	austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com,
	jhugo@qti.qualcomm.com,
	timur@qti.qualcomm.com,
	ard.biesheuvel@linaro.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v8 10/13] arm64: topology: rename cluster_id
Date: Wed, 25 Apr 2018 18:31:18 -0500
Message-Id: <20180425233121.13270-11-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766326590040185?=
X-GMAIL-MSGID: =?utf-8?q?1598766326590040185?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Lets match the name of the arm64 topology field
to the kernel macro that uses it.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/topology.h |  4 ++--
 arch/arm64/kernel/topology.c      | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index c4f2d50491eb..6b10459e6905 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -7,14 +7,14 @@
 struct cpu_topology {
 	int thread_id;
 	int core_id;
-	int cluster_id;
+	int package_id;
 	cpumask_t thread_sibling;
 	cpumask_t core_sibling;
 };
 
 extern struct cpu_topology cpu_topology[NR_CPUS];
 
-#define topology_physical_package_id(cpu)	(cpu_topology[cpu].cluster_id)
+#define topology_physical_package_id(cpu)	(cpu_topology[cpu].package_id)
 #define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
 #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
 #define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 21868530018e..dc18b1e53194 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -47,7 +47,7 @@ static int __init get_cpu_for_node(struct device_node *node)
 	return cpu;
 }
 
-static int __init parse_core(struct device_node *core, int cluster_id,
+static int __init parse_core(struct device_node *core, int package_id,
 			     int core_id)
 {
 	char name[10];
@@ -63,7 +63,7 @@ static int __init parse_core(struct device_node *core, int cluster_id,
 			leaf = false;
 			cpu = get_cpu_for_node(t);
 			if (cpu >= 0) {
-				cpu_topology[cpu].cluster_id = cluster_id;
+				cpu_topology[cpu].package_id = package_id;
 				cpu_topology[cpu].core_id = core_id;
 				cpu_topology[cpu].thread_id = i;
 			} else {
@@ -85,7 +85,7 @@ static int __init parse_core(struct device_node *core, int cluster_id,
 			return -EINVAL;
 		}
 
-		cpu_topology[cpu].cluster_id = cluster_id;
+		cpu_topology[cpu].package_id = package_id;
 		cpu_topology[cpu].core_id = core_id;
 	} else if (leaf) {
 		pr_err("%pOF: Can't get CPU for leaf core\n", core);
@@ -101,7 +101,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 	bool leaf = true;
 	bool has_cores = false;
 	struct device_node *c;
-	static int cluster_id __initdata;
+	static int package_id __initdata;
 	int core_id = 0;
 	int i, ret;
 
@@ -140,7 +140,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 			}
 
 			if (leaf) {
-				ret = parse_core(c, cluster_id, core_id++);
+				ret = parse_core(c, package_id, core_id++);
 			} else {
 				pr_err("%pOF: Non-leaf cluster with core %s\n",
 				       cluster, name);
@@ -158,7 +158,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 		pr_warn("%pOF: empty cluster\n", cluster);
 
 	if (leaf)
-		cluster_id++;
+		package_id++;
 
 	return 0;
 }
@@ -194,7 +194,7 @@ static int __init parse_dt_topology(void)
 	 * only mark cores described in the DT as possible.
 	 */
 	for_each_possible_cpu(cpu)
-		if (cpu_topology[cpu].cluster_id == -1)
+		if (cpu_topology[cpu].package_id == -1)
 			ret = -EINVAL;
 
 out_map:
@@ -224,7 +224,7 @@ static void update_siblings_masks(unsigned int cpuid)
 	for_each_possible_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
 
-		if (cpuid_topo->cluster_id != cpu_topo->cluster_id)
+		if (cpuid_topo->package_id != cpu_topo->package_id)
 			continue;
 
 		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
@@ -245,7 +245,7 @@ void store_cpu_topology(unsigned int cpuid)
 	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
 	u64 mpidr;
 
-	if (cpuid_topo->cluster_id != -1)
+	if (cpuid_topo->package_id != -1)
 		goto topology_populated;
 
 	mpidr = read_cpuid_mpidr();
@@ -259,19 +259,19 @@ void store_cpu_topology(unsigned int cpuid)
 		/* Multiprocessor system : Multi-threads per core */
 		cpuid_topo->thread_id  = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2) |
+		cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 2) |
 					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 8;
 	} else {
 		/* Multiprocessor system : Single-thread per core */
 		cpuid_topo->thread_id  = -1;
 		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 1) |
+		cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 1) |
 					 MPIDR_AFFINITY_LEVEL(mpidr, 2) << 8 |
 					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 16;
 	}
 
 	pr_debug("CPU%u: cluster %d core %d thread %d mpidr %#016llx\n",
-		 cpuid, cpuid_topo->cluster_id, cpuid_topo->core_id,
+		 cpuid, cpuid_topo->package_id, cpuid_topo->core_id,
 		 cpuid_topo->thread_id, mpidr);
 
 topology_populated:
@@ -287,7 +287,7 @@ static void __init reset_cpu_topology(void)
 
 		cpu_topo->thread_id = -1;
 		cpu_topo->core_id = 0;
-		cpu_topo->cluster_id = -1;
+		cpu_topo->package_id = -1;
 
 		cpumask_clear(&cpu_topo->core_sibling);
 		cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
-- 
2.13.6
