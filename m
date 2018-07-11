Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E71C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5351C208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5351C208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbeGKKnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:43:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47101 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbeGKKnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:43:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fdCXV-00048t-W8; Wed, 11 Jul 2018 10:40:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gasket: remove redundant pointer bar_data
Date:   Wed, 11 Jul 2018 11:40:05 +0100
Message-Id: <20180711104005.30356-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer bar_data is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'bar_data' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/gasket/gasket_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index ad9442a5bb9d..45914ebc8f44 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1610,7 +1610,6 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	bool is_coherent_region;
 	const struct gasket_driver_desc *driver_desc;
 	struct gasket_dev *gasket_dev = (struct gasket_dev *)filp->private_data;
-	struct gasket_bar_data *bar_data;
 	const struct gasket_bar_desc *bar_desc;
 	struct gasket_mappable_region *map_regions = NULL;
 	int num_map_regions = 0;
@@ -1673,8 +1672,6 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	 * Subtract the base of the bar from the raw offset to get the
 	 * memory location within the bar to map.
 	 */
-	bar_data = &gasket_dev->bar_data[bar_index];
-
 	bar_desc = &driver_desc->bar_descriptions[bar_index];
 	permissions = bar_desc->permissions;
 	if (!gasket_mmap_has_permissions(gasket_dev, vma, permissions)) {
-- 
2.17.1

