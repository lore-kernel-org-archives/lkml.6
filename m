Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EkxWC/5HGVtUQQAAmS7hNA
	; Thu, 07 Jun 2018 14:58:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1DD49607E7; Thu,  7 Jun 2018 14:58:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6121A601C3;
	Thu,  7 Jun 2018 14:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6121A601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933606AbeFGO6D (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:58:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41144 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933076AbeFGO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:57:59 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbd-0005Zx-HC; Thu, 07 Jun 2018 15:09:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-00033h-KU; Thu, 07 Jun 2018 15:09:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Corentin Labbe" <clabbe@baylibre.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.961174670@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 238/410] powerpc/pseries: Add empty update_numa_cpu_lookup_table()
 for NUMA=n
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -76,6 +76,9 @@ static inline void sysfs_remove_device_f
 						int nid)
 {
 }
+
+static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node) {}
+
 #endif /* CONFIG_NUMA */
 
 #if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
