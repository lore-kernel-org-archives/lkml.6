Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0446BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B137B217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551162042;
	bh=ND/yCQWbudOgrQb8aQrRgG9n9oBzdQpcoccjeKGXN+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=YuaXmiRseqHHcqt/bJiveJ+Fjha0/JDEYlZtkL63G+7lvSwo+1CfGec6Q+66aBRoY
	 BT7hyqr/lkydiKd+U4FpO/xfIIreJl3L2OYTzRFvXI4hfA5zwmNGZhDuWV+a+GlzNM
	 Vc2QBkBXN+FyDM3RTgYkSbgPqPeSoaSAyweShslM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfBZGUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:20:41 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37182 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfBZGU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:20:29 -0500
Received: by mail-it1-f196.google.com with SMTP id z124so2456519itc.2;
        Mon, 25 Feb 2019 22:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=YCDFMlZ6OP9IJGOtEzgVkXzVk770PyI8XLBa3kIMBdU=;
        b=CVQWjxbM+FwoEg1Y7AfnnL25Ey1zrw/mqKOHZRO1c4CHwLdChn4cabqj+7IcIMPGJv
         R7+ysWozugTc2gSyYkmmcicrcT9kGJPq/RdLEp13t1sOvKnVC2eHqwKdM+qKkrO50JlA
         jW4U7pazlI2CeMcVGXfT/ruzj9Xx31iK4BCSfEHp4pZ9pmqTnouIuNUIbr3DFoA/X/M1
         ryxX82heEIBPO4L+mkJ8IMKtvQDTL/my2/DHO7IbIfSrTna9Auy2oekZGUCqy34nWiZ3
         h46gq8WqsDk11WfKNjXIlWOyYD5Hvn5xY1gsKKbzsYho2H7f75WSlYt/CGGOiKkDPl1y
         2urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=YCDFMlZ6OP9IJGOtEzgVkXzVk770PyI8XLBa3kIMBdU=;
        b=ufkqtagX2L4LW5UTCejb0izZVdf1YRRLJTzauazDKj3lK6a2HybPptDANJB4KIhn6z
         wth9xPg5+Kp4XZYn18ZNccnc8IXRSVkWfg5CBRJY3vaBX2K84OnrEGlxWr16NrHAabsU
         kx2AyCVlCXB2tuTdnApk+DHqtyFedcuNg+bNTl7I2CbRK9uERzrp10CFICpTMvzmr+RK
         TPM/PSJhvzRZqJOs7qyEx2w0LTGodoT1poKpzN5EBGVsSIGK6KRUJ1hppZycYaMsjhVI
         SYsD4w7sHeuukEs1YGmiSZqYyCZGUixmX//bNsh4mhQkA48AFWjaMCVOkPldYxistyXd
         hi/g==
X-Gm-Message-State: AHQUAuZkUfDhm6NYJ6Hu7GUVbc0amv/mrp9MlprY33Fe55tTC3kVIYgE
        myt3g25uZlaZ4HmZF+TMPJA=
X-Google-Smtp-Source: AHgI3IbMo+iG6ghkKR/K5LQTidRCboAhtR0OzfcA7HmnuQ1ChLBIICJ1sd2gCDQrgQFEUdH5a/f06g==
X-Received: by 2002:a24:f801:: with SMTP id a1mr1541532ith.38.1551162027773;
        Mon, 25 Feb 2019 22:20:27 -0800 (PST)
Received: from kbl.lan (h66-222-56-144.cntcnh.dsl.dynamic.tds.net. [66.222.56.144])
        by smtp.gmail.com with ESMTPSA id w8sm6431431ita.21.2019.02.25.22.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:20:27 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 04/14] x86 topology: Add CPUID.1F multi-die/package support
Date:   Tue, 26 Feb 2019 01:20:02 -0500
Message-Id: <204e9bf2afff8e6cb7a8a39d86038075f1bb4ab8.1551160674.git.len.brown@intel.com>
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

Some new systems have multiple software-visible die within each package.

Update Linux parsing of the Intel CPUID "Extended Topology Leaf"
to handle either CPUID.B, or the new CPUID.1F.

Add cpuinfo_x86.die_id and cpuinfo_x86.max_dies to store the result.

die_id will be non-zero only for multi-die/package systems.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/x86/topology.txt   |  4 ++
 arch/x86/include/asm/processor.h |  4 +-
 arch/x86/kernel/cpu/topology.c   | 85 +++++++++++++++++++++++++-------
 arch/x86/kernel/smpboot.c        |  2 +
 4 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/Documentation/x86/topology.txt b/Documentation/x86/topology.txt
index 06b3cdbc4048..8107b6cfc9ea 100644
--- a/Documentation/x86/topology.txt
+++ b/Documentation/x86/topology.txt
@@ -46,6 +46,10 @@ The topology of a system is described in the units of:
 
     The number of cores in a package. This information is retrieved via CPUID.
 
+  - cpuinfo_x86.x86_max_dies:
+
+    The number of dies in a package. This information is retrieved via CPUID.
+
   - cpuinfo_x86.phys_proc_id:
 
     The physical ID of the package. This information is retrieved via CPUID
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 33051436c864..f2856fe03715 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -105,7 +105,8 @@ struct cpuinfo_x86 {
 	int			x86_power;
 	unsigned long		loops_per_jiffy;
 	/* cpuid returned max cores value: */
-	u16			 x86_max_cores;
+	u16			x86_max_cores;
+	u16			x86_max_dies;
 	u16			apicid;
 	u16			initial_apicid;
 	u16			x86_clflush_size;
@@ -117,6 +118,7 @@ struct cpuinfo_x86 {
 	u16			logical_proc_id;
 	/* Core id: */
 	u16			cpu_core_id;
+	u16			cpu_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
 	u32			microcode;
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 8f6c784141d1..4d17e699657d 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -15,33 +15,63 @@
 /* leaf 0xb SMT level */
 #define SMT_LEVEL	0
 
-/* leaf 0xb sub-leaf types */
+/* extended topology sub-leaf types */
 #define INVALID_TYPE	0
 #define SMT_TYPE	1
 #define CORE_TYPE	2
+#define DIE_TYPE	5
 
 #define LEAFB_SUBTYPE(ecx)		(((ecx) >> 8) & 0xff)
 #define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
 #define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
 
-int detect_extended_topology_early(struct cpuinfo_x86 *c)
-{
 #ifdef CONFIG_SMP
+/*
+ * Check if given CPUID extended toplogy "leaf" is implemented
+ */
+static int check_extended_topology_leaf(int leaf)
+{
 	unsigned int eax, ebx, ecx, edx;
 
-	if (c->cpuid_level < 0xb)
+	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
+
+	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE))
 		return -1;
 
-	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
+	return 0;
+}
+/*
+ * Return best CPUID Extended Toplogy Leaf supported
+ */
+static int detect_extended_topology_leaf(struct cpuinfo_x86 *c)
+{
+	if (c->cpuid_level >= 0x1f) {
+		if (check_extended_topology_leaf(0x1f) == 0)
+			return 0x1f;
+	}
 
-	/*
-	 * check if the cpuid leaf 0xb is actually implemented.
-	 */
-	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE))
+	if (c->cpuid_level >= 0xb) {
+		if (check_extended_topology_leaf(0xb) == 0)
+			return 0xb;
+	}
+
+	return -1;
+}
+#endif
+
+int detect_extended_topology_early(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_SMP
+	unsigned int eax, ebx, ecx, edx;
+	int leaf;
+
+	leaf = detect_extended_topology_leaf(c);
+	if (leaf < 0)
 		return -1;
 
 	set_cpu_cap(c, X86_FEATURE_XTOPOLOGY);
 
+	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 	/*
 	 * initial apic id, which also represents 32-bit extended x2apic id.
 	 */
@@ -52,7 +82,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
 }
 
 /*
- * Check for extended topology enumeration cpuid leaf 0xb and if it
+ * Check for extended topology enumeration cpuid leaf, and if it
  * exists, use it for populating initial_apicid and cpu topology
  * detection.
  */
@@ -60,22 +90,28 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
 	unsigned int eax, ebx, ecx, edx, sub_index;
-	unsigned int ht_mask_width, core_plus_mask_width;
+	unsigned int ht_mask_width, core_plus_mask_width, die_plus_mask_width;
 	unsigned int core_select_mask, core_level_siblings;
+	unsigned int die_select_mask, die_level_siblings;
+	int leaf;
 
-	if (detect_extended_topology_early(c) < 0)
+	leaf = detect_extended_topology_leaf(c);
+	if (leaf < 0)
 		return -1;
 
 	/*
 	 * Populate HT related information from sub-leaf level 0.
 	 */
-	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
+	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
+	c->initial_apicid = edx;
 	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
 	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
+	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 
 	sub_index = 1;
 	do {
-		cpuid_count(0xb, sub_index, &eax, &ebx, &ecx, &edx);
+		cpuid_count(leaf, sub_index, &eax, &ebx, &ecx, &edx);
 
 		/*
 		 * Check for the Core type in the implemented sub leaves.
@@ -83,23 +119,34 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 		if (LEAFB_SUBTYPE(ecx) == CORE_TYPE) {
 			core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
 			core_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-			break;
+			die_level_siblings = core_level_siblings;
+			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
+		}
+		if (LEAFB_SUBTYPE(ecx) == DIE_TYPE) {
+			die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
+			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 		}
 
 		sub_index++;
 	} while (LEAFB_SUBTYPE(ecx) != INVALID_TYPE);
 
 	core_select_mask = (~(-1 << core_plus_mask_width)) >> ht_mask_width;
-
-	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid, ht_mask_width)
-						 & core_select_mask;
-	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid, core_plus_mask_width);
+	die_select_mask = (~(-1 << die_plus_mask_width)) >>
+				core_plus_mask_width;
+
+	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid,
+				ht_mask_width) & core_select_mask;
+	c->cpu_die_id = apic->phys_pkg_id(c->initial_apicid,
+				core_plus_mask_width) & die_select_mask;
+	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid,
+				die_plus_mask_width);
 	/*
 	 * Reinit the apicid, now that we have extended initial_apicid.
 	 */
 	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
 
 	c->x86_max_cores = (core_level_siblings / smp_num_siblings);
+	c->x86_max_dies = (die_level_siblings / core_level_siblings);
 #endif
 	return 0;
 }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 19a963890bbe..c70e547b18c2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -393,6 +393,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 		int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
 
 		if (c->phys_proc_id == o->phys_proc_id &&
+		    c->cpu_die_id == o->cpu_die_id &&
 		    per_cpu(cpu_llc_id, cpu1) == per_cpu(cpu_llc_id, cpu2)) {
 			if (c->cpu_core_id == o->cpu_core_id)
 				return topology_sane(c, o, "smt");
@@ -404,6 +405,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 		}
 
 	} else if (c->phys_proc_id == o->phys_proc_id &&
+		   c->cpu_die_id == o->cpu_die_id &&
 		   c->cpu_core_id == o->cpu_core_id) {
 		return topology_sane(c, o, "smt");
 	}
-- 
2.18.0-rc0

