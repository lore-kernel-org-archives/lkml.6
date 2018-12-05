Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ACDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF8E2087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzyGzeEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF8E2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeLEPNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:13:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36437 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeLEPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:13:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so10164559pfc.3;
        Wed, 05 Dec 2018 07:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t0pTSgQzPOe+pRKtUg2xtfpHJj+iazLyW+zcccLA6Lk=;
        b=GzyGzeEJbN4cAmucz+CPKsPwyr+74MsksbaKcccP7YayRk6gS8IWegHRu9DFUwqDqS
         gk8aIMg3QJI8KhmD9tHMFXALbQFvdDGWzFoZ6iwrCb3VEcFbAqW6OCAAn77VvR9n/FDI
         aFZ3ghQHvwUr4SXrPB0dtDOf05I/ATrQCi59mt4Rd5N4btZx3jYTaXMh22TL+6yIZh7z
         QrXsszXsAaEQClnAo+h1TbeSK9aNcVGqmqCnyZR/lbdWKhIqlYyjZryJOBT+aEZhuxlU
         YfksIi8LKDOa6DhQHurFlGjNz63Z6K1erzIhjHPuCFTAFO9qQFir5lezOy3VtUdjXEmH
         cAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t0pTSgQzPOe+pRKtUg2xtfpHJj+iazLyW+zcccLA6Lk=;
        b=BJCtpC+cnAxii9Dv1c0jKnSCull14GR1ktE+VqH7r5W0/9nBnWkc5sC6dxLbgc1NFA
         4on8XeVrvZr8yro04ROM8o4r/FUW19+DgR/u+94RGOKpJMaygyKUFULWBfCZge5Bav6F
         X5BZ3QTAkfgf3aArlaTBBOv6BunbWh3iBcwgbcyh3HKie0B1ltldd4s1nvL5d5S7MwwE
         /nbKzhdUxLZ+VLHoVrJ0QRnWfldL/SWlcneL2W88JVwBE0ahgiLAIRYJc32L8ey4wqWa
         dIZYoxc12le7WUZNkRFHiLOhAhhmWbm9kNWYNAE79ByE0H6DVJOdrmflYZCsZr/Lh150
         pHoA==
X-Gm-Message-State: AA+aEWZU61fjZV62T8vnwwI6oSj73qOv7yapKs4uVQDvu9XsvwdQaMWC
        BaTe1Bo3o77QjT8A9Ta2tTE=
X-Google-Smtp-Source: AFSGD/WBRkHL8HL0rDpSo6ZStKYeIXjFHcIscSLhzWzdGx7zQ5qVuZfPveWhJ1zofd0wwqWW3VZDDw==
X-Received: by 2002:a62:3141:: with SMTP id x62mr24488423pfx.12.1544022790629;
        Wed, 05 Dec 2018 07:13:10 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id x3sm66083204pgt.45.2018.12.05.07.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 07:13:10 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rajneesh.bhardwaj@intel.com, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/2] platform/x86: intel_telemetry: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Wed,  5 Dec 2018 10:12:55 -0500
Message-Id: <20181205151255.15367-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181205151255.15367-1-tiny.windzz@gmail.com>
References: <20181205151255.15367-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../platform/x86/intel_telemetry_debugfs.c    | 42 +++----------------
 1 file changed, 6 insertions(+), 36 deletions(-)

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

