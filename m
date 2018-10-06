Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D0DECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF1F208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF1F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeJGFB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 01:01:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33470 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeJGFBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 01:01:55 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g8uZG-0004Jn-HE; Sat, 06 Oct 2018 21:56:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: mic: scif: remove redundant check on ret < 0
Date:   Sat,  6 Oct 2018 22:56:58 +0100
Message-Id: <20181006215658.31288-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for ret < 0 is redundant as any places prior to this point
where ret is set to an error value the code will exit out of the loop
to the error exit label 'err'.  Remove this redundant dead code.

Detected by CoverityScan, CID#1339528 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/mic/scif/scif_dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_dma.c b/drivers/misc/mic/scif/scif_dma.c
index 03af8b5b7b0d..2d76c200d072 100644
--- a/drivers/misc/mic/scif/scif_dma.c
+++ b/drivers/misc/mic/scif/scif_dma.c
@@ -1035,8 +1035,6 @@ scif_rma_list_dma_copy_unaligned(struct scif_copy_work *work,
 			}
 			dma_async_issue_pending(chan);
 		}
-		if (ret < 0)
-			goto err;
 		offset += loop_len;
 		temp += loop_len;
 		temp_phys += loop_len;
-- 
2.17.1

