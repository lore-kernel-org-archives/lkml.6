Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F90C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2304120834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMmmfa1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2304120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeLANDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 08:03:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43190 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLANDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 08:03:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so3631154plb.10;
        Fri, 30 Nov 2018 17:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=soXlMMvTtAfJHvCSJlaG28GRE+ywuNnNclEWi9Rrb0g=;
        b=dMmmfa1C5sY/vHudvcuxk+ISDdt+yn3iHF9BjsL9sqY06CLgmE/fnvDo4q2gcAnjMR
         IeWUIEdfoxwdLigTaMb3+hhSF6+QKv8GXxE58DYvGEvq2R0jBH/eshuFxA1RIZphW19Q
         sw3+zBjgi10o7MfYzWNIJA0ZpIeuRJLClul9ILwb5aLZVsNb0W9O8JdfL5DG6x0b+LTv
         vUzLPP7Xc0ZRu7e7BSoDJizFmzPXbBrO9/xznU86zDsTb2HihBf54sLlHvt+igzi1Xe5
         FVDejlVuoy9vHq73fsvl69N78D9Wh48khTauUmhyJcUmHFSasbXZQdAlr6aqk+pqVgUO
         5Z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=soXlMMvTtAfJHvCSJlaG28GRE+ywuNnNclEWi9Rrb0g=;
        b=MgeJoAhk01PMA06+8V8qHYffFueajF6v5OAsZtf3wM9RgBBrCv16KlvL/akfkfi1b8
         3rgP9ThuEareE/5ZPcBDwjIO4Marl7Tj4AE6CUp63pp3TvEvhcxwQYHI+6mUUZFGSNEV
         RQuAjvTqmrMKapEmbSkOuJ/u3LhG27B3YV3E6p0OcGe2ZgWhzNjmNfIJqx5QTxjtZMo8
         2BryjPEFX/o5JjpqCAE3Kt1J3vpoadDgUrPTTv5NpvK2hRB+yGFae6YC+3cVUSiYd8i3
         TofVum/1Vw2562uSLohF7zkdCH5q5WDld+kHz3L5xf5WkBDZjXoC1E2iWGbjvLHidMoU
         R5Fg==
X-Gm-Message-State: AA+aEWZdmIfsxpe+TU/bBmjz6jIgrD2xw7fsgQ+G/Z43Hvu7Qquv8uT6
        aJZoCvgNvTaL62PzksS+63w=
X-Google-Smtp-Source: AFSGD/Uc4m265ATlkhJmpt3b2O7ea0i1NzN2JE2K6Sro7Lqo/VfWMWAJfdFlf26sveBFE3VSDMKkIw==
X-Received: by 2002:a17:902:8d8e:: with SMTP id v14mr7752207plo.133.1543629117868;
        Fri, 30 Nov 2018 17:51:57 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 196sm20570229pfc.77.2018.11.30.17.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 17:51:56 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, khilman@kernel.org,
        ulf.hansson@linaro.org, pavel@ucw.cz, len.brown@intel.com,
        broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] driver core: remove define_genpd_open_function() and define_genpd_debugfs_fops()
Date:   Fri, 30 Nov 2018 20:51:54 -0500
Message-Id: <20181201015154.4718-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have the DEFINE_SHOW_ATTRIBUTE,There is no need to define such
a macro,so remove define_genpd_open_function and define_genpd_debugfs_fops.
Also use DEFINE_SHOW_ATTRIBUTE to simplify somecode.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/component.c              | 12 +----
 drivers/base/power/domain.c           | 71 +++++++++------------------
 drivers/base/regmap/regcache-rbtree.c | 12 +----
 drivers/base/regmap/regmap-debugfs.c  | 12 +----
 4 files changed, 27 insertions(+), 80 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index e8d676fad0c9..ddcea8739c12 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -85,17 +85,7 @@ static int component_devices_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int component_devices_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, component_devices_show, inode->i_private);
-}
-
-static const struct file_operations component_devices_fops = {
-	.open = component_devices_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(component_devices);
 
 static int __init component_debug_init(void)
 {
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7f38a92b444a..10a61d6147d0 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2671,7 +2671,7 @@ static int genpd_summary_one(struct seq_file *s,
 	return 0;
 }
 
-static int genpd_summary_show(struct seq_file *s, void *data)
+static int summary_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd;
 	int ret = 0;
@@ -2694,7 +2694,7 @@ static int genpd_summary_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_status_show(struct seq_file *s, void *data)
+static int status_show(struct seq_file *s, void *data)
 {
 	static const char * const status_lookup[] = {
 		[GPD_STATE_ACTIVE] = "on",
@@ -2721,7 +2721,7 @@ static int genpd_status_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_sub_domains_show(struct seq_file *s, void *data)
+static int sub_domains_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	struct gpd_link *link;
@@ -2738,7 +2738,7 @@ static int genpd_sub_domains_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_idle_states_show(struct seq_file *s, void *data)
+static int idle_states_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	unsigned int i;
@@ -2767,7 +2767,7 @@ static int genpd_idle_states_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_active_time_show(struct seq_file *s, void *data)
+static int active_time_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	ktime_t delta = 0;
@@ -2787,7 +2787,7 @@ static int genpd_active_time_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_total_idle_time_show(struct seq_file *s, void *data)
+static int total_idle_time_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	ktime_t delta = 0, total = 0;
@@ -2815,7 +2815,7 @@ static int genpd_total_idle_time_show(struct seq_file *s, void *data)
 }
 
 
-static int genpd_devices_show(struct seq_file *s, void *data)
+static int devices_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	struct pm_domain_data *pm_data;
@@ -2841,7 +2841,7 @@ static int genpd_devices_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_perf_state_show(struct seq_file *s, void *data)
+static int perf_state_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 
@@ -2854,37 +2854,14 @@ static int genpd_perf_state_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-#define define_genpd_open_function(name) \
-static int genpd_##name##_open(struct inode *inode, struct file *file) \
-{ \
-	return single_open(file, genpd_##name##_show, inode->i_private); \
-}
-
-define_genpd_open_function(summary);
-define_genpd_open_function(status);
-define_genpd_open_function(sub_domains);
-define_genpd_open_function(idle_states);
-define_genpd_open_function(active_time);
-define_genpd_open_function(total_idle_time);
-define_genpd_open_function(devices);
-define_genpd_open_function(perf_state);
-
-#define define_genpd_debugfs_fops(name) \
-static const struct file_operations genpd_##name##_fops = { \
-	.open = genpd_##name##_open, \
-	.read = seq_read, \
-	.llseek = seq_lseek, \
-	.release = single_release, \
-}
-
-define_genpd_debugfs_fops(summary);
-define_genpd_debugfs_fops(status);
-define_genpd_debugfs_fops(sub_domains);
-define_genpd_debugfs_fops(idle_states);
-define_genpd_debugfs_fops(active_time);
-define_genpd_debugfs_fops(total_idle_time);
-define_genpd_debugfs_fops(devices);
-define_genpd_debugfs_fops(perf_state);
+DEFINE_SHOW_ATTRIBUTE(summary);
+DEFINE_SHOW_ATTRIBUTE(status);
+DEFINE_SHOW_ATTRIBUTE(sub_domains);
+DEFINE_SHOW_ATTRIBUTE(idle_states);
+DEFINE_SHOW_ATTRIBUTE(active_time);
+DEFINE_SHOW_ATTRIBUTE(total_idle_time);
+DEFINE_SHOW_ATTRIBUTE(devices);
+DEFINE_SHOW_ATTRIBUTE(perf_state);
 
 static int __init genpd_debug_init(void)
 {
@@ -2897,7 +2874,7 @@ static int __init genpd_debug_init(void)
 		return -ENOMEM;
 
 	d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
-			genpd_debugfs_dir, NULL, &genpd_summary_fops);
+			genpd_debugfs_dir, NULL, &summary_fops);
 	if (!d)
 		return -ENOMEM;
 
@@ -2907,20 +2884,20 @@ static int __init genpd_debug_init(void)
 			return -ENOMEM;
 
 		debugfs_create_file("current_state", 0444,
-				d, genpd, &genpd_status_fops);
+				d, genpd, &status_fops);
 		debugfs_create_file("sub_domains", 0444,
-				d, genpd, &genpd_sub_domains_fops);
+				d, genpd, &sub_domains_fops);
 		debugfs_create_file("idle_states", 0444,
-				d, genpd, &genpd_idle_states_fops);
+				d, genpd, &idle_states_fops);
 		debugfs_create_file("active_time", 0444,
-				d, genpd, &genpd_active_time_fops);
+				d, genpd, &active_time_fops);
 		debugfs_create_file("total_idle_time", 0444,
-				d, genpd, &genpd_total_idle_time_fops);
+				d, genpd, &total_idle_time_fops);
 		debugfs_create_file("devices", 0444,
-				d, genpd, &genpd_devices_fops);
+				d, genpd, &devices_fops);
 		if (genpd->set_performance_state)
 			debugfs_create_file("perf_state", 0444,
-					    d, genpd, &genpd_perf_state_fops);
+					    d, genpd, &perf_state_fops);
 	}
 
 	return 0;
diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index b1e9aae9a5d0..2e8f0144f9ab 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -177,17 +177,7 @@ static int rbtree_show(struct seq_file *s, void *ignored)
 	return 0;
 }
 
-static int rbtree_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, rbtree_show, inode->i_private);
-}
-
-static const struct file_operations rbtree_fops = {
-	.open		= rbtree_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(rbtree);
 
 static void rbtree_debugfs_init(struct regmap *map)
 {
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 87b562e49a43..19eb454f26c3 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -435,17 +435,7 @@ static int regmap_access_show(struct seq_file *s, void *ignored)
 	return 0;
 }
 
-static int access_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, regmap_access_show, inode->i_private);
-}
-
-static const struct file_operations regmap_access_fops = {
-	.open		= access_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(regmap_access);
 
 static ssize_t regmap_cache_only_write_file(struct file *file,
 					    const char __user *user_buf,
-- 
2.17.0

