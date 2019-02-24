Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D319C10F18
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF77120878
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY5qksCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfBXMfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 07:35:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43678 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfBXMfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 07:35:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so3174830pfh.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 04:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0NMCKN566TqKrSROT1OL4y1pVAJFuioGBAgJ45OiBK4=;
        b=iY5qksCIMpNU389QUSs7IU3yhYB8G0qeGuofPuj7VOiuoUKF3lEIfU0EIj4vIyZGxy
         lfGuvV+dKLpk9vmJOA8iGOZeVGx1R5OoJTYMgUmJp3746nRHEl0S2MLvX5k033Nv//84
         mDo14vacdwcpGP4nPjXiBuFbH4AHdrcqN6IsJBRmpNv+fK1FORzwuFvX/wZKblimKkQP
         H9XH3K4Eom4q4IXXZbXjw3E4kEAZerpxutrYN0lNUcpo3BsJCUHJTK9TcTLXrimeAne8
         2Oy7y5IfhCi+Y+NMgXPpNQ304JNgsNYrJ6xo/gzm0wA6P/YV5Mayp/k+DBLWEA96+TmJ
         7LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0NMCKN566TqKrSROT1OL4y1pVAJFuioGBAgJ45OiBK4=;
        b=SQ8hAsEktWX2Henvyhl96MylWkBmNZGOcpdnOkASLcso5ojYJXvhoV6/uSbwRueCO+
         bxaIH/aNYBLGyBA9UivKz7KApN3MIUSgZJ4lPDIjElHhHnqTehZkXSMxEc0ZqOIntMR+
         XHkBZvsLKjyN3eCZnkysaw9IJJYaLh8/cZaoEhwkbWJ3wLDNmMX4A1LmymzKEEY8pF3B
         H2n0Xtn0FGUdmz8dHI+CXK3gQ4ERbGdjuLFIKFdd/8beBbLjvAp6FGucNvh5/FoAQLoL
         t3gEx9U6YOGGoHSyEqqfF2Ck9O6IKO35UVxgplh68B5Nu1HnqRsvniXDv1y11pHnZIJg
         7oBA==
X-Gm-Message-State: AHQUAuYQhS1tBA8vxbWQATovzfI/o2Jx9ENAJHfxaKlSJd/g9Ao1Xreb
        iN+H6sxPQw+BP2EC45savw==
X-Google-Smtp-Source: AHgI3IYKZHrDENP+56CRPPar4fsatj4I/ajY/II4jFQQaKk4J3r7faH8maH7gEv4Z3POa7YL/eMOUg==
X-Received: by 2002:a63:d814:: with SMTP id b20mr13029128pgh.312.1551011706824;
        Sun, 24 Feb 2019 04:35:06 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v6sm9524634pgb.2.2019.02.24.04.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 04:35:06 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org, linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Vacek <neelx@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] x86/numa: push forward the setup of node to cpumask map
Date:   Sun, 24 Feb 2019 20:34:08 +0800
Message-Id: <1551011649-30103-6-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
References: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present the node to cpumask map is set up until the secondary
cpu boot up. But it is too late for the purpose of building node fall back
list at early boot stage. Considering that init_cpu_to_node() already owns
cpu to node map, it is a good place to set up node to cpumask map too. So
do it by calling numa_add_cpu(cpu) in init_cpu_to_node().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Mel Gorman <mgorman@suse.de>
CC: Joonsoo Kim <iamjoonsoo.kim@lge.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Andi Kleen <ak@linux.intel.com>
CC: Petr Tesarik <ptesarik@suse.cz>
CC: Michal Hocko <mhocko@suse.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Jonathan Corbet <corbet@lwn.net>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: Daniel Vacek <neelx@redhat.com>
CC: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/topology.h | 4 ----
 arch/x86/kernel/setup_percpu.c  | 3 ---
 arch/x86/mm/numa.c              | 5 ++++-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 453cf38..fad77c7 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -73,8 +73,6 @@ static inline const struct cpumask *cpumask_of_node(int node)
 }
 #endif
 
-extern void setup_node_to_cpumask_map(void);
-
 #define pcibus_to_node(bus) __pcibus_to_node(bus)
 
 extern int __node_distance(int, int);
@@ -96,8 +94,6 @@ static inline int early_cpu_to_node(int cpu)
 	return 0;
 }
 
-static inline void setup_node_to_cpumask_map(void) { }
-
 #endif
 
 #include <asm-generic/topology.h>
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index e8796fc..206fa43 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -283,9 +283,6 @@ void __init setup_per_cpu_areas(void)
 	early_per_cpu_ptr(x86_cpu_to_node_map) = NULL;
 #endif
 
-	/* Setup node to cpumask map */
-	setup_node_to_cpumask_map();
-
 	/* Setup cpu initialized, callin, callout masks */
 	setup_cpu_local_masks();
 
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index c8dd7af..8d73e2273 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -110,7 +110,7 @@ void numa_clear_node(int cpu)
  * Note: cpumask_of_node() is not valid until after this is done.
  * (Use CONFIG_DEBUG_PER_CPU_MAPS to check this.)
  */
-void __init setup_node_to_cpumask_map(void)
+static void __init setup_node_to_cpumask_map(void)
 {
 	unsigned int node;
 
@@ -738,6 +738,7 @@ void __init init_cpu_to_node(void)
 	BUG_ON(cpu_to_apicid == NULL);
 	rr = first_node(node_online_map);
 
+	setup_node_to_cpumask_map();
 	for_each_possible_cpu(cpu) {
 		int node = numa_cpu_node(cpu);
 
@@ -750,6 +751,7 @@ void __init init_cpu_to_node(void)
 		 */
 		if (node == NUMA_NO_NODE) {
 			numa_set_node(cpu, rr);
+			numa_add_cpu(cpu);
 			rr = next_node_in(rr, node_online_map);
 			continue;
 		}
@@ -758,6 +760,7 @@ void __init init_cpu_to_node(void)
 			init_memory_less_node(node);
 
 		numa_set_node(cpu, node);
+		numa_add_cpu(cpu);
 	}
 }
 
-- 
2.7.4

