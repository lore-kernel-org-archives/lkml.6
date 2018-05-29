Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935069AbeE2OYJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:24:09 -0400
Received: from smtp4.ccs.ornl.gov ([160.91.203.40]:38208 "EHLO
        smtp4.ccs.ornl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935281AbeE2OWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:22:38 -0400
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>,
        Dmitry Eremin <dmitry.eremin@intel.com>,
        James Simmons <jsimmons@infradead.org>
Subject: [PATCH v2 21/25] staging: lustre: libcfs: report NUMA node instead of just node
Date: Tue, 29 May 2018 10:22:01 -0400
Message-Id: <1527603725-30560-22-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Eremin <dmitry.eremin@intel.com>

Reporting "HW nodes" is too generic. It really is reporting
"HW NUMA nodes". Update the debug message.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/23306
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
Reviewed-by: Olaf Weber <olaf.weber@hpe.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
Changelog:

v1) Initial patch
v2) Rebased patch. No changes in code from earlier patch

 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
index 99a9494..0fc102c 100644
--- a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
@@ -1138,7 +1138,7 @@ int cfs_cpu_init(void)
 
 	put_online_cpus();
 
-	LCONSOLE(0, "HW nodes: %d, HW CPU cores: %d, npartitions: %d\n",
+	LCONSOLE(0, "HW NUMA nodes: %d, HW CPU cores: %d, npartitions: %d\n",
 		 num_online_nodes(), num_online_cpus(),
 		 cfs_cpt_number(cfs_cpt_tab));
 	return 0;
-- 
1.8.3.1
