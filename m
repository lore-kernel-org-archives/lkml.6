Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A0CC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A245C20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6rlBgXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A245C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeLBDFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:05:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34454 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeLBDFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:05:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so3830149pgg.1;
        Sat, 01 Dec 2018 07:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ce+5YXO6CAGDZqaiRcP6TLFaIe25P1x6FTQjsqXBrTc=;
        b=u6rlBgXwnJgYwUgd2rMJTngCyKjkpo+Y2haxsupsh3YW9gFq84dAWDAnN4tUZOmtYb
         AZxox2q83uhC6kp2dreyeM5s/3i5vIKAoDAGWlUBjpNRLLd02or+n7snA5anqDajN/+6
         e3skrob5M1U3ONjvNazhxCaq2w4JVZCqSZygJ34g+TXO2LtqrGc27RbfrrkYzvj4mJjX
         d6NqZKakV1DX/VDy9EC65GVdocat94q2qcgNGB5CMvvmcsKO5G3ddZhfAfTJinXbIfqr
         AgGcsTXdboYzrcnAUs2CQVaLbAC+aOynEO+hkQvZlFXLrCNogbV4fLExFMr2XsW1AvKR
         /bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ce+5YXO6CAGDZqaiRcP6TLFaIe25P1x6FTQjsqXBrTc=;
        b=C/r9uAvLE11tJDohe5RhbPR4JfF6oA0E3M28eunSQ5jaMPEcB7xv1F3T6vMujIsmeC
         HTJwgsPLWboOmbsit3cQSObt9EnPf3WuJ8aNZUbLuq6VrWVA0Musba7UXGM2YlE3WrA7
         Fv4Jdy670Uhnr42im1+W88OVSwUv9wxMObqahOcBezarYI+eWG6fmPU9H/FfcXCWaLqI
         FAfXeluqTKh8TTgmZurWTu+prBPvZsXKyFdZ2F404tg7L+3VZ/nhq7hMHHJwiQ1W21J8
         O9P5JFMuWNJT/S39JEaCyB8uI1IBMLrFND1b+oOWA504oZz7AFJl/Bj/xx0W3wJ2OnkY
         LQZA==
X-Gm-Message-State: AA+aEWaj/nUlBjjRXt2lyHYWa6pyz6gmI+cGwMWhIygr4RWwjDYRKQMp
        gBwb+5Gixkh9piAI8P6DB6o=
X-Google-Smtp-Source: AFSGD/WzynOxMHliHp119yrsuS1rj3HzqtPFyhWvni9R4AcTndnbhHnzA89+w0IFt+95vWbB3p19Jg==
X-Received: by 2002:a63:6782:: with SMTP id b124mr8292282pgc.151.1543679553188;
        Sat, 01 Dec 2018 07:52:33 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id a10sm10817873pfi.138.2018.12.01.07.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:52:32 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rajneesh.bhardwaj@intel.com, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, andy@infradead.org,
        david.e.box@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 10:52:29 -0500
Message-Id: <20181201155229.8532-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/platform/x86/intel_pmc_core.c         | 46 ++++---------------
 .../platform/x86/intel_telemetry_debugfs.c    | 42 +++--------------
 2 files changed, 14 insertions(+), 74 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 6b31d410cb09..95311ad6ec6f 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -311,7 +311,7 @@ static void pmc_core_display_map(struct seq_file *s, int index,
 		   pf_map[index].bit_mask & pf_reg ? "Off" : "On");
 }
 
-static int pmc_core_ppfear_sts_show(struct seq_file *s, void *unused)
+static int pmc_core_ppfear_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
 	const struct pmc_bit_map *map = pmcdev->map->pfear_sts;
@@ -330,17 +330,7 @@ static int pmc_core_ppfear_sts_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int pmc_core_ppfear_sts_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pmc_core_ppfear_sts_show, inode->i_private);
-}
-
-static const struct file_operations pmc_core_ppfear_ops = {
-	.open           = pmc_core_ppfear_sts_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(pmc_core_ppfear);
 
 /* This function should return link status, 0 means ready */
 static int pmc_core_mtpmc_link_status(void)
@@ -372,7 +362,7 @@ static int pmc_core_send_msg(u32 *addr_xram)
 	return 0;
 }
 
-static int pmc_core_mphy_pg_sts_show(struct seq_file *s, void *unused)
+static int pmc_core_mphy_pg_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
 	const struct pmc_bit_map *map = pmcdev->map->mphy_sts;
@@ -425,17 +415,7 @@ static int pmc_core_mphy_pg_sts_show(struct seq_file *s, void *unused)
 	return err;
 }
 
-static int pmc_core_mphy_pg_sts_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pmc_core_mphy_pg_sts_show, inode->i_private);
-}
-
-static const struct file_operations pmc_core_mphy_pg_ops = {
-	.open           = pmc_core_mphy_pg_sts_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(pmc_core_mphy_pg);
 
 static int pmc_core_pll_show(struct seq_file *s, void *unused)
 {
@@ -472,17 +452,7 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
 	return err;
 }
 
-static int pmc_core_pll_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pmc_core_pll_show, inode->i_private);
-}
-
-static const struct file_operations pmc_core_pll_ops = {
-	.open           = pmc_core_pll_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
 
 static ssize_t pmc_core_ltr_ignore_write(struct file *file, const char __user
 *userbuf, size_t count, loff_t *ppos)
@@ -602,19 +572,19 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 			    &pmc_core_dev_state);
 
 	debugfs_create_file("pch_ip_power_gating_status", 0444, dir, pmcdev,
-			    &pmc_core_ppfear_ops);
+			    &pmc_core_ppfear_fops);
 
 	debugfs_create_file("ltr_ignore", 0644, dir, pmcdev,
 			    &pmc_core_ltr_ignore_ops);
 
 	if (pmcdev->map->pll_sts)
 		debugfs_create_file("pll_status", 0444, dir, pmcdev,
-				    &pmc_core_pll_ops);
+				    &pmc_core_pll_fops);
 
 	if (pmcdev->map->mphy_sts)
 		debugfs_create_file("mphy_core_lanes_power_gating_status",
 				    0444, dir, pmcdev,
-				    &pmc_core_mphy_pg_ops);
+				    &pmc_core_mphy_pg_fops);
 
 	if (pmcdev->map->slps0_dbg_maps) {
 		debugfs_create_file("slp_s0_debug_status", 0444,
diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
index 40bce560eb30..98ba9185a27b 100644
--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@ -466,17 +466,7 @@ static int telem_pss_states_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int telem_pss_state_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, telem_pss_states_show, inode->i_private);
-}
-
-static const struct file_operations telem_pss_ops = {
-	.open		= telem_pss_state_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(telem_pss_states);
 
 static int telem_ioss_states_show(struct seq_file *s, void *unused)
 {
@@ -505,17 +495,7 @@ static int telem_ioss_states_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int telem_ioss_state_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, telem_ioss_states_show, inode->i_private);
-}
-
-static const struct file_operations telem_ioss_ops = {
-	.open		= telem_ioss_state_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(telem_ioss_states);
 
 static int telem_soc_states_show(struct seq_file *s, void *unused)
 {
@@ -664,17 +644,7 @@ static int telem_soc_states_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int telem_soc_state_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, telem_soc_states_show, inode->i_private);
-}
-
-static const struct file_operations telem_socstate_ops = {
-	.open		= telem_soc_state_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(telem_soc_states);
 
 static int telem_s0ix_res_get(void *data, u64 *val)
 {
@@ -960,7 +930,7 @@ static int __init telemetry_debugfs_init(void)
 
 	f = debugfs_create_file("pss_info", S_IFREG | S_IRUGO,
 				debugfs_conf->telemetry_dbg_dir, NULL,
-				&telem_pss_ops);
+				&telem_pss_states_fops);
 	if (!f) {
 		pr_err("pss_sample_info debugfs register failed\n");
 		goto out;
@@ -968,7 +938,7 @@ static int __init telemetry_debugfs_init(void)
 
 	f = debugfs_create_file("ioss_info", S_IFREG | S_IRUGO,
 				debugfs_conf->telemetry_dbg_dir, NULL,
-				&telem_ioss_ops);
+				&telem_ioss_states_fops);
 	if (!f) {
 		pr_err("ioss_sample_info debugfs register failed\n");
 		goto out;
@@ -976,7 +946,7 @@ static int __init telemetry_debugfs_init(void)
 
 	f = debugfs_create_file("soc_states", S_IFREG | S_IRUGO,
 				debugfs_conf->telemetry_dbg_dir,
-				NULL, &telem_socstate_ops);
+				NULL, &telem_soc_states_fops);
 	if (!f) {
 		pr_err("ioss_sample_info debugfs register failed\n");
 		goto out;
-- 
2.17.0

