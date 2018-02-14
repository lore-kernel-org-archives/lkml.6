Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967571AbeBNMR6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:17:58 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39215 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967538AbeBNMR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:17:57 -0500
X-Google-Smtp-Source: AH8x226drjq95BEb7ntDyrtPsCBbFmrE1EsiuqK0J7kazdQwzor+ZbS/kXfI/yM9PgoX4R+KwBsM3Q==
From: Corentin Labbe <clabbe@baylibre.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        nfont@linux.vnet.ibm.com, tyreld@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] powerpc: add empty update_numa_cpu_lookup_table for !CONFIG_NUMA
Date: Wed, 14 Feb 2018 12:17:47 +0000
Message-Id: <1518610667-23406-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_NUMA is not set, build fail with:
arch/powerpc/platforms/pseries/hotplug-cpu.c:335:4: error: déclaration implicite de la fonction « update_numa_cpu_lookup_table » [-Werror=implicit-function-declaration]

So we have to add update_numa_cpu_lookup_table as an empty function when CONFIG_NUMA is not set.

Fixes: 1d9a090783be ("powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/powerpc/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 593248110902..9f421641a35c 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -81,6 +81,9 @@ static inline int numa_update_cpu_topology(bool cpus_locked)
 {
 	return 0;
 }
+
+static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node) {}
+
 #endif /* CONFIG_NUMA */
 
 #if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
-- 
2.13.6
