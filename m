Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeE3LXK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:23:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60972 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752511AbeE3LHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:06 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Michael Ellerman" <mpe@ellerman.id.au>,
        "Corentin Labbe" <clabbe@baylibre.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.450532105@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 093/153] powerpc/pseries: Add empty update_numa_cpu_lookup_table()
 for NUMA=n
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Corentin Labbe <clabbe@baylibre.com>

commit c1e150ceb61e4a585bad156da15c33bfe89f5858 upstream.

When CONFIG_NUMA is not set, the build fails with:

  arch/powerpc/platforms/pseries/hotplug-cpu.c:335:4:
  error: déclaration implicite de la fonction « update_numa_cpu_lookup_table »

So we have to add update_numa_cpu_lookup_table() as an empty function
when CONFIG_NUMA is not set.

Fixes: 1d9a090783be ("powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -107,6 +107,9 @@ static inline void sysfs_remove_device_f
 						int nid)
 {
 }
+
+static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node) {}
+
 #endif /* CONFIG_NUMA */
 
 #if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
