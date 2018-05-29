Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935160AbeE2OWV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:22:21 -0400
Received: from smtp4.ccs.ornl.gov ([160.91.203.40]:38208 "EHLO
        smtp4.ccs.ornl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934868AbeE2OWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:22:13 -0400
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>,
        Dmitry Eremin <dmitry.eremin@intel.com>,
        James Simmons <jsimmons@infradead.org>
Subject: [PATCH v2 03/25] staging: lustre: libcfs: rename variable i to cpu
Date: Tue, 29 May 2018 10:21:43 -0400
Message-Id: <1527603725-30560-4-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Eremin <dmitry.eremin@intel.com>

Change the name of the variable i used for for_each_cpu() to cpu
for code readability.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/23303
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
Changelog:

v1) Initial patch
v2) Rebased to handle recent cleanups in libcfs

 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
index 951a9ca..34df7ed 100644
--- a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
@@ -340,7 +340,7 @@ struct cfs_cpt_table *
 cfs_cpt_set_cpumask(struct cfs_cpt_table *cptab, int cpt,
 		    const cpumask_t *mask)
 {
-	int i;
+	int cpu;
 
 	if (!cpumask_weight(mask) ||
 	    cpumask_any_and(mask, cpu_online_mask) >= nr_cpu_ids) {
@@ -349,8 +349,8 @@ struct cfs_cpt_table *
 		return 0;
 	}
 
-	for_each_cpu(i, mask) {
-		if (!cfs_cpt_set_cpu(cptab, cpt, i))
+	for_each_cpu(cpu, mask) {
+		if (!cfs_cpt_set_cpu(cptab, cpt, cpu))
 			return 0;
 	}
 
@@ -362,10 +362,10 @@ struct cfs_cpt_table *
 cfs_cpt_unset_cpumask(struct cfs_cpt_table *cptab, int cpt,
 		      const cpumask_t *mask)
 {
-	int i;
+	int cpu;
 
-	for_each_cpu(i, mask)
-		cfs_cpt_unset_cpu(cptab, cpt, i);
+	for_each_cpu(cpu, mask)
+		cfs_cpt_unset_cpu(cptab, cpt, cpu);
 }
 EXPORT_SYMBOL(cfs_cpt_unset_cpumask);
 
-- 
1.8.3.1
