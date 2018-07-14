Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5924ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D71208CC
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D71208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeGNQxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 12:53:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51016 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeGNQxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 12:53:14 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1feNUC-0000Dm-H3; Sat, 14 Jul 2018 16:33:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vme: ca91cx42: remove redundant variable i
Date:   Sat, 14 Jul 2018 17:33:32 +0100
Message-Id: <20180714163332.11600-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable i is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'i' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/vme/bridges/vme_ca91cx42.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/vme/bridges/vme_ca91cx42.c b/drivers/vme/bridges/vme_ca91cx42.c
index 5dd284008630..53bdc256805f 100644
--- a/drivers/vme/bridges/vme_ca91cx42.c
+++ b/drivers/vme/bridges/vme_ca91cx42.c
@@ -970,7 +970,6 @@ static unsigned int ca91cx42_master_rmw(struct vme_master_resource *image,
 {
 	u32 result;
 	uintptr_t pci_addr;
-	int i;
 	struct ca91cx42_driver *bridge;
 	struct device *dev;
 
@@ -978,7 +977,6 @@ static unsigned int ca91cx42_master_rmw(struct vme_master_resource *image,
 	dev = image->parent->parent;
 
 	/* Find the PCI address that maps to the desired VME address */
-	i = image->number;
 
 	/* Locking as we can only do one of these at a time */
 	mutex_lock(&bridge->vme_rmw);
-- 
2.17.1

