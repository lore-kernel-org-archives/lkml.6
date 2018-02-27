Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeB0UuE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:50:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751748AbeB0UuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:50:01 -0500
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/5] sysctl: Add kdoc comments to do_proc_do{u}intvec_minmax_conv_param
Date: Tue, 27 Feb 2018 15:49:47 -0500
Message-Id: <1519764591-27456-2-git-send-email-longman@redhat.com>
In-Reply-To: <1519764591-27456-1-git-send-email-longman@redhat.com>
References: <1519764591-27456-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kdoc comments are added to the do_proc_dointvec_minmax_conv_param
and do_proc_douintvec_minmax_conv_param structures thare are used
internally for range checking.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sysctl.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f98f28c..52b647a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2500,6 +2500,17 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
 }
 #endif
 
+/**
+ * DOC: do_proc_dointvec_minmax_conv_param
+ *
+ * The do_proc_dointvec_minmax_conv_param structure provides the
+ * minimum and maximum values for doing range checking for those sysctl
+ * parameters that use the proc_dointvec_minmax() handler. The error
+ * code -EINVAL will be returned if the range check fails.
+ *
+ *  min: ptr to minimum allowable value
+ *  max: ptr to maximum allowable value
+ */
 struct do_proc_dointvec_minmax_conv_param {
 	int *min;
 	int *max;
@@ -2556,6 +2567,17 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
 				do_proc_dointvec_minmax_conv, &param);
 }
 
+/**
+ * DOC: do_proc_douintvec_minmax_conv_param
+ *
+ * The do_proc_dointvec_minmax_conv_param structure provides the
+ * minimum and maximum values for doing range checking for those sysctl
+ * parameters that use the proc_douintvec_minmax() handler. The error
+ * code -ERANGE will be returned if the range check fails.
+ *
+ *  min: ptr to minimum allowable value
+ *  max: ptr to maximum allowable value
+ */
 struct do_proc_douintvec_minmax_conv_param {
 	unsigned int *min;
 	unsigned int *max;
-- 
1.8.3.1
