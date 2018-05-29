Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935326AbeE2OWp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:22:45 -0400
Received: from smtp4.ccs.ornl.gov ([160.91.203.40]:38208 "EHLO
        smtp4.ccs.ornl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935293AbeE2OWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:22:41 -0400
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>,
        Dmitry Eremin <dmitry.eremin@intel.com>,
        James Simmons <jsimmons@infradead.org>
Subject: [PATCH v2 22/25] staging: lustre: libcfs: update debug messages in CPT code
Date: Tue, 29 May 2018 10:22:02 -0400
Message-Id: <1527603725-30560-23-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Eremin <dmitry.eremin@intel.com>

Update the debug messages for the CPT table creation code. Place
the passed in string in quotes to make it clear what it is.
Captialize cpu in the debug strings.

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

 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
index 0fc102c..649f7f9 100644
--- a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
@@ -496,7 +496,7 @@ void cfs_cpt_unset_cpu(struct cfs_cpt_table *cptab, int cpt, int cpu)
 
 	} else if (cpt != cptab->ctb_cpu2cpt[cpu]) {
 		CDEBUG(D_INFO,
-		       "CPU %d is not in cpu-partition %d\n", cpu, cpt);
+		       "CPU %d is not in CPU partition %d\n", cpu, cpt);
 		return;
 	}
 
@@ -940,14 +940,14 @@ static struct cfs_cpt_table *cfs_cpt_table_create_pattern(char *pattern)
 	if (!ncpt ||
 	    (node && ncpt > num_online_nodes()) ||
 	    (!node && ncpt > num_online_cpus())) {
-		CERROR("Invalid pattern %s, or too many partitions %d\n",
+		CERROR("Invalid pattern '%s', or too many partitions %d\n",
 		       pattern, ncpt);
 		return NULL;
 	}
 
 	cptab = cfs_cpt_table_alloc(ncpt);
 	if (!cptab) {
-		CERROR("Failed to allocate cpu partition table\n");
+		CERROR("Failed to allocate CPU partition table\n");
 		return NULL;
 	}
 
@@ -978,11 +978,11 @@ static struct cfs_cpt_table *cfs_cpt_table_create_pattern(char *pattern)
 
 		if (!bracket) {
 			if (*str) {
-				CERROR("Invalid pattern %s\n", str);
+				CERROR("Invalid pattern '%s'\n", str);
 				goto failed;
 			}
 			if (c != ncpt) {
-				CERROR("expect %d partitions but found %d\n",
+				CERROR("Expect %d partitions but found %d\n",
 				       ncpt, c);
 				goto failed;
 			}
@@ -990,7 +990,7 @@ static struct cfs_cpt_table *cfs_cpt_table_create_pattern(char *pattern)
 		}
 
 		if (sscanf(str, "%d%n", &cpt, &n) < 1) {
-			CERROR("Invalid cpu pattern %s\n", str);
+			CERROR("Invalid CPU pattern '%s'\n", str);
 			goto failed;
 		}
 
@@ -1007,20 +1007,20 @@ static struct cfs_cpt_table *cfs_cpt_table_create_pattern(char *pattern)
 
 		str = strim(str + n);
 		if (str != bracket) {
-			CERROR("Invalid pattern %s\n", str);
+			CERROR("Invalid pattern '%s'\n", str);
 			goto failed;
 		}
 
 		bracket = strchr(str, ']');
 		if (!bracket) {
-			CERROR("Missing right bracket for partition %d, %s\n",
+			CERROR("Missing right bracket for partition %d in '%s'\n",
 			       cpt, str);
 			goto failed;
 		}
 
 		if (cfs_expr_list_parse(str, (bracket - str) + 1,
 					0, high, &el)) {
-			CERROR("Can't parse number range: %s\n", str);
+			CERROR("Can't parse number range in '%s'\n", str);
 			goto failed;
 		}
 
-- 
1.8.3.1
