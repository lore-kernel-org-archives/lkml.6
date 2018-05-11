Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZoBoKtm2beIDZ2xXDFIC9ums+Toej3/iWZsXPvZay30pSX/E25mq+xQKej/LTgiqPq8Z6gR
ARC-Seal: i=1; a=rsa-sha256; t=1526083152; cv=none;
        d=google.com; s=arc-20160816;
        b=07GMKSJXvLG4/BRkIdOEY6TwuYxjXQFnzgBeJlM59cJTxis6NKY1J3g5xz8cKN/+3U
         +InocCZuHaYX19knDI63ohEj3lQe4Ysq46vEoQgaov9GUTreMix6PowIMgZmqiZ5g8kV
         6q3HMLwwnVttkiuzI2+/uEw0f9N/aWhQ4h8zCSU1x1156vQDUll3D3ishIbCapyvjrX7
         h4cnOI71BL6xr18qbHZ/SuNYasgxpnbYRrNhNU6TkoJY7sJen/y6e9r7Cyf4XmwmYyB9
         BcP/aG6WqXUKeh92RvkpKi9OLTgLprCsPE31/AAnWa2UKvr+Gf5QuSUo3HdMa9mKC1dV
         izeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=JSABH0W7fBdkxKXo4odFjXLwETdL48KxN2GO2EGv+5s=;
        b=XKKs9GNHvsHFpZYZMyLZ+vew0oTSIzR6NHie1j8/+k7NUuOweqq3AkQ8L3USX+2JnT
         o9LQ4MBEc1pZZ1OGekGjQuhI1PzSvJyZtFIMsdO+JtTtllbn9qbunUn/dalGHkx5umK6
         yHUUjYwFf4sCb/L1D6PUkdg8hScRMP8uuT4pyEA9y+4G+OF4aCPKYzzo/2fdcmu6NInG
         LyojT/2UuXR1hYcisc8CrffT4ErSzorelIrETqimkN6O6pL7n+Y7ozcNbzlKgAEqCpNY
         uRrFS2BDGc31ifr+X7qOaw6KlOYNFVWRcJry9Bc0lnbu/75J/xuRZ9JUGSabHbzwEeKu
         hKYQ==
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
	jhugo@codeaurora.org,
	ard.biesheuvel@linaro.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v9 09/12] arm64: topology: rename cluster_id
Date: Fri, 11 May 2018 18:58:04 -0500
Message-Id: <20180511235807.30834-10-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180511235807.30834-1-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214167752404192?=
X-GMAIL-MSGID: =?utf-8?q?1600214167752404192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The cluster concept isn't architecturally defined for arm64.
Lets match the name of the arm64 topology field to the kernel macro
that uses it.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Morten Rasmussen <morten.rasmussen@arm.com>
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
