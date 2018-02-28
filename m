Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AG47ELsyvzB43gHG5gkfKZ8m+cyMNXjIKYxWJMqGkpOF/mRItMzkarAXnsV8ebwSmh+6ybW90XSy
ARC-Seal: i=1; a=rsa-sha256; t=1519855649; cv=none;
        d=google.com; s=arc-20160816;
        b=sAhWMHUOegIoUeZduu4xDcgF2+LaHprUg4XtWty4S3gegVAaUGxRPxYH3QF4+r/j86
         F6nmOBOrHtrKSsqWdFpDJMMrt8wEFHQX4JmxKsPmnmtaOXlfLK/ULQfKvCQJSTygsUVO
         dc4ReK9WRgvAFfJulwJ/ByX+GIujG0/M85IWizYM64GfopRuxGDpESbT4Hd1bi1sbwO+
         vI8/PE6xGmYfGDqcq8YIGp7SjsGBpafXm1ARkbI/WkPHAuyYWmxuVrGkpM6AvIMr19GP
         M/Xnni47XQTkY2zr4FpqvDZwjB1IF8VM75gqd7/tCS1jl696Up168FpEL8QnmbDKn3su
         fJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=rPUi0LT3mxRy7rs8cVc7X4T5aAX2XWfQDXmDyIBHd/A=;
        b=xRO0e0MIQVBQuyxGpNkc+S2qcPa6JzEoN4toSpgpUJ34Bnxphgb31K+2Boe+/t/B8J
         oYg1/NgQjk5AT3aQVrWw/MpUHCdlaBi8tyfy4DEeyO0xfa6r2Fs5lSCrzNeqxi0UJyWh
         +zJYdXw96FpaDD0PkpVl2CkPLeXiad0MLoGJBTRFqLsh8yBXE6hc4p4HkaFvAHIqhUhu
         vmGq/YMVPSb4cvzzZtdV/UKfgxfxm59oI5znCDQhiQRSwo/XxLHBdHPi1W36f4AJXDXe
         SCd5MXVujxUG2eUZC9WZPaHkeiz0y6PzSVzGI+iYfO9aU2OMEl+vbiLjH85ZN/jKf7Ea
         QgGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com,
	lorenzo.pieralisi@arm.com,
	hanjun.guo@linaro.org,
	rjw@rjwysocki.net,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org,
	ahs3@redhat.com,
	dietmar.eggemann@arm.com,
	morten.rasmussen@arm.com,
	palmer@sifive.com,
	lenb@kernel.org,
	john.garry@huawei.com,
	austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v7 10/13] arm64: topology: rename cluster_id
Date: Wed, 28 Feb 2018 16:06:16 -0600
Message-Id: <20180228220619.6992-11-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684158298600286?=
X-GMAIL-MSGID: =?utf-8?q?1593684158298600286?=
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
