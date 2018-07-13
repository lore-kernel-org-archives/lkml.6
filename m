Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0890EECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1923208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1923208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeGMJuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:50:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59361 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeGMJuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:50:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fduVH-0005o9-Hy; Fri, 13 Jul 2018 09:36:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: u132-hcd: remove redundant variable num_ports
Date:   Fri, 13 Jul 2018 10:36:43 +0100
Message-Id: <20180713093643.16103-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable num_ports is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'num_ports' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/host/u132-hcd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index 032b8652910a..072bd5d5738e 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -3062,7 +3062,6 @@ static int u132_probe(struct platform_device *pdev)
 	int retval;
 	u32 control;
 	u32 rh_a = -1;
-	u32 num_ports;
 
 	msleep(100);
 	if (u132_exiting > 0)
@@ -3077,7 +3076,6 @@ static int u132_probe(struct platform_device *pdev)
 	retval = ftdi_read_pcimem(pdev, roothub.a, &rh_a);
 	if (retval)
 		return retval;
-	num_ports = rh_a & RH_A_NDP;	/* refuse to confuse usbcore */
 	if (pdev->dev.dma_mask)
 		return -EINVAL;
 
-- 
2.17.1

