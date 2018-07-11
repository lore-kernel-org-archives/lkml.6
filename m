Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D15C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CA4208AD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CA4208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbeGKI04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:26:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44984 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeGKI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:26:56 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fdAPa-0005fC-UZ; Wed, 11 Jul 2018 08:23:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH] rapidio: remove redundant pointer md
Date:   Wed, 11 Jul 2018 09:23:46 +0100
Message-Id: <20180711082346.5223-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer md is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'md' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index a8cb8d2f2abb..cbe467ff1aba 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1006,7 +1006,6 @@ static int rio_mport_transfer_ioctl(struct file *filp, void __user *arg)
 static int rio_mport_wait_for_async_dma(struct file *filp, void __user *arg)
 {
 	struct mport_cdev_priv *priv;
-	struct mport_dev *md;
 	struct rio_async_tx_wait w_param;
 	struct mport_dma_req *req;
 	dma_cookie_t cookie;
@@ -1016,7 +1015,6 @@ static int rio_mport_wait_for_async_dma(struct file *filp, void __user *arg)
 	int ret;
 
 	priv = (struct mport_cdev_priv *)filp->private_data;
-	md = priv->md;
 
 	if (unlikely(copy_from_user(&w_param, arg, sizeof(w_param))))
 		return -EFAULT;
-- 
2.17.1

