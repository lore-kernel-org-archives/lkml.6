Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AEAECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BD220841
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="K5FZglZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BD220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbeGLTpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:45:20 -0400
Received: from mout01.posteo.de ([185.67.36.65]:36298 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbeGLTpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:45:20 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id BC12C212B1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 21:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1531424059; bh=qT1d0o0YKumc2bTeaTW6zgog+62UsuUwdK+Notlz8DA=;
        h=From:To:Cc:Subject:Date:From;
        b=K5FZglZPQUNoaLLbTKzZNAHCF59AkINhCRRCOtnEPubpu/P0uqqWMNOevwxXXcrqx
         rUDVNxluFzSbK0ELSHR/RpYsBQZJARk/KrBWZtyzYHfBoDc+CGqNVuG69FIMiOwnuV
         3gzf0ZKksFGi8s6po04wIY7MxjqkgPXZ589zXlMc/KQo5eEWtS7z/l+9yz8PY1gxMw
         A15TqG45NVaGwWqgu0Rf8/AvNE5wOV351L0Pj0qMVSXh08UfdykVRnMEEW4LkqAE6s
         hobnL3RAw0/J7m885KOldjD+4Q/TpMA4sZhBy30TeHR1cZhhLSCrJ1BoeoAZGQbSlf
         8q3AVjUHp0dVQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41RR2f31NVz9rxb;
        Thu, 12 Jul 2018 21:34:18 +0200 (CEST)
From:   Felix Siegel <felix.siegel@posteo.de>
To:     devel@driverdev.osuosl.org
Cc:     Felix Siegel <felix.siegel@posteo.de>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: gasket: Use __func__ instead of hardcoded string - Style
Date:   Thu, 12 Jul 2018 21:27:15 +0200
Message-Id: <1531423694-22478-4-git-send-email-felix.siegel@posteo.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531423694-22478-1-git-send-email-felix.siegel@posteo.de>
References: <1531423694-22478-1-git-send-email-felix.siegel@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed logging statements to use %s and __func__ instead of hard coding
the function name in a string.

Signed-off-by: Felix Siegel <felix.siegel@posteo.de>
---
 drivers/staging/gasket/apex_driver.c       | 15 ++++++++-------
 drivers/staging/gasket/gasket_core.c       | 11 ++++++-----
 drivers/staging/gasket/gasket_ioctl.c      |  4 ++--
 drivers/staging/gasket/gasket_page_table.c | 13 ++++++++-----
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index ffcc59d..735d43d 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -341,7 +341,7 @@ static int apex_add_dev_cb(struct gasket_dev *gasket_dev)
 	ulong page_table_ready, msix_table_ready;
 	int retries = 0;
 
-	gasket_log_error(gasket_dev, "apex_add_dev_cb.");
+	gasket_log_error(gasket_dev, "%s.", __func__);
 
 	apex_reset(gasket_dev, 0);
 
@@ -422,8 +422,9 @@ static int apex_device_cleanup(struct gasket_dev *gasket_dev)
 
 	gasket_log_info(
 		gasket_dev,
-		"apex_device_cleanup 0x%p hib_error 0x%llx scalar_error "
+		"%s 0x%p hib_error 0x%llx scalar_error "
 		"0x%llx.",
+		__func__,
 		gasket_dev, hib_error, scalar_error);
 
 	if (allow_power_save)
@@ -447,13 +448,13 @@ static int apex_reset(struct gasket_dev *gasket_dev, uint type)
 	if (bypass_top_level)
 		return 0;
 
-	gasket_log_debug(gasket_dev, "apex_reset.");
+	gasket_log_debug(gasket_dev, "%s.", __func__);
 
 	if (!is_gcb_in_reset(gasket_dev)) {
 		/* We are not in reset - toggle the reset bit so as to force
 		 * re-init of custom block
 		 */
-		gasket_log_debug(gasket_dev, "apex_reset: toggle reset.");
+		gasket_log_debug(gasket_dev, "%s: toggle reset.", __func__);
 
 		ret = apex_enter_reset(gasket_dev, type);
 		if (ret)
@@ -472,7 +473,7 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type)
 	if (bypass_top_level)
 		return 0;
 
-	gasket_log_debug(gasket_dev, "apex_enter_reset.");
+	gasket_log_debug(gasket_dev, "%s.", __func__);
 
 	/*
 	 * Software reset:
@@ -534,7 +535,7 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 	if (bypass_top_level)
 		return 0;
 
-	gasket_log_debug(gasket_dev, "apex_quit_reset.");
+	gasket_log_debug(gasket_dev, "%s.", __func__);
 
 	/*
 	 * Disable sleep mode:
@@ -681,7 +682,7 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg)
 			return -EFAULT;
 
 		gasket_log_error(
-			gasket_dev, "apex_clock_gating %llu", ibuf.enable);
+			gasket_dev, "%s %llu", __func__, ibuf.enable);
 
 		if (ibuf.enable) {
 			/* Quiesce AXI, gate GCB clock. */
diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 5eeaae7..b14a956 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -932,7 +932,8 @@ static int gasket_enable_dev(
 		} else {
 			gasket_log_error(
 				gasket_dev,
-				"gasket_enable_dev with no physical device!!");
+				"%s with no physical device!!",
+				__func__);
 			WARN_ON(1);
 			ddev = NULL;
 		}
@@ -2100,9 +2101,9 @@ int gasket_wait_sync(
 		if (diff_nanosec > timeout_ns) {
 			gasket_log_error(
 				gasket_dev,
-				"gasket_wait_sync timeout: reg %llx count %x "
+				"%s timeout: reg %llx count %x "
 				"dma %lld ns\n",
-				offset, count, diff_nanosec);
+				__func__, offset, count, diff_nanosec);
 			return -1;
 		}
 		reg = gasket_dev_read_64(gasket_dev, bar, offset);
@@ -2141,8 +2142,8 @@ int gasket_wait_with_reschedule(
 	if (retries == max_retries) {
 		gasket_log_error(
 			gasket_dev,
-			"gasket_wait_with_reschedule timeout: reg %llx timeout (%llu ms)",
-			offset, max_retries * delay_ms);
+			"%s timeout: reg %llx timeout (%llu ms)",
+			__func__, offset, max_retries * delay_ms);
 		return -EINVAL;
 	}
 	return 0;
diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 832beed..738c56f 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -180,8 +180,8 @@ static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd)
 	alive = (gasket_dev->status == GASKET_STATUS_ALIVE);
 	if (!alive) {
 		gasket_nodev_error(
-			"gasket_ioctl_check_permissions alive %d status %d.",
-			alive, gasket_dev->status);
+			"%s alive %d status %d.",
+			__func__,  alive, gasket_dev->status);
 	}
 
 	root = capable(CAP_SYS_ADMIN);
diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 04ea0d2..8021272 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -445,8 +445,9 @@ int gasket_page_table_map(
 	mutex_unlock(&pg_tbl->mutex);
 
 	gasket_nodev_debug(
-		"gasket_page_table_map done: ha %llx daddr %llx num %d, "
+		"%s done: ha %llx daddr %llx num %d, "
 		"ret %d\n",
+		__func__,
 		(unsigned long long)host_addr,
 		(unsigned long long)dev_addr, num_pages, ret);
 	return ret;
@@ -869,7 +870,7 @@ static int gasket_perform_mapping(
 	for (i = 0; i < num_pages; i++) {
 		page_addr = host_addr + i * PAGE_SIZE;
 		offset = page_addr & (PAGE_SIZE - 1);
-		gasket_nodev_debug("gasket_perform_mapping i %d\n", i);
+		gasket_nodev_debug("%s i %d\n", __func__, i);
 		if (is_coherent(pg_tbl, host_addr)) {
 			u64 off =
 				(u64)host_addr -
@@ -907,17 +908,19 @@ static int gasket_perform_mapping(
 			}
 
 			gasket_nodev_debug(
-				"    gasket_perform_mapping dev %p "
+				"    %s dev %p "
 				"i %d pte %p pfn %p -> mapped %llx\n",
+				__func__,
 				pg_tbl->device, i, &ptes[i],
 				(void *)page_to_pfn(page),
 				(unsigned long long)ptes[i].dma_addr);
 
 			if (ptes[i].dma_addr == -1) {
 				gasket_nodev_error(
-					"gasket_perform_mapping i %d"
+					"%s i %d"
 					" -> fail to map page %llx "
 					"[pfn %p ohys %p]\n",
+					__func__,
 					i,
 					(unsigned long long)ptes[i].dma_addr,
 					(void *)page_to_pfn(page),
@@ -1623,7 +1626,7 @@ int gasket_set_user_virt(
 	pg_tbl = gasket_dev->page_table[0];
 	if (!pg_tbl) {
 		gasket_nodev_error(
-			"gasket_set_user_virt: invalid page table index");
+			"%s: invalid page table index", __func__);
 		return 0;
 	}
 	for (j = 0; j < num_pages; j++) {
-- 
2.7.4

