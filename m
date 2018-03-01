Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033566AbeCARoN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:44:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033523AbeCARoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:44:09 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH v3 2/6] sysctl: Add kdoc comments to do_proc_do{u}intvec_minmax_conv_param
Date: Thu,  1 Mar 2018 12:43:36 -0500
Message-Id: <1519926220-7453-3-git-send-email-longman@redhat.com>
In-Reply-To: <1519926220-7453-1-git-send-email-longman@redhat.com>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kdoc comments are added to the do_proc_dointvec_minmax_conv_param
and do_proc_douintvec_minmax_conv_param structures thare are used
internally for range checking.

The error codes returned by proc_dointvec_minmax() and
proc_douintvec_minmax() are also documented.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sysctl.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f98f28c..d2aa6b4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2500,6 +2500,15 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
 }
 #endif
 
+/**
+ * struct do_proc_dointvec_minmax_conv_param - proc_dointvec_minmax() range checking structure
+ * @min: pointer to minimum allowable value
+ * @max: pointer to maximum allowable value
+ *
+ * The do_proc_dointvec_minmax_conv_param structure provides the
+ * minimum and maximum values for doing range checking for those sysctl
+ * parameters that use the proc_dointvec_minmax() handler.
+ */
 struct do_proc_dointvec_minmax_conv_param {
 	int *min;
 	int *max;
@@ -2543,7 +2552,7 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
  * This routine will ensure the values are within the range specified by
  * table->extra1 (min) and table->extra2 (max).
  *
- * Returns 0 on success.
+ * Returns 0 on success or -EINVAL on write when the range check fails.
  */
 int proc_dointvec_minmax(struct ctl_table *table, int write,
 		  void __user *buffer, size_t *lenp, loff_t *ppos)
@@ -2556,6 +2565,15 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
 				do_proc_dointvec_minmax_conv, &param);
 }
 
+/**
+ * struct do_proc_douintvec_minmax_conv_param - proc_douintvec_minmax() range checking structure
+ * @min: pointer to minimum allowable value
+ * @max: pointer to maximum allowable value
+ *
+ * The do_proc_douintvec_minmax_conv_param structure provides the
+ * minimum and maximum values for doing range checking for those sysctl
+ * parameters that use the proc_douintvec_minmax() handler.
+ */
 struct do_proc_douintvec_minmax_conv_param {
 	unsigned int *min;
 	unsigned int *max;
@@ -2603,7 +2621,7 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
  * check for UINT_MAX to avoid having to support wrap around uses from
  * userspace.
  *
- * Returns 0 on success.
+ * Returns 0 on success or -ERANGE on write when the range check fails.
  */
 int proc_douintvec_minmax(struct ctl_table *table, int write,
 			  void __user *buffer, size_t *lenp, loff_t *ppos)
-- 
1.8.3.1
