Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0970C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADD620C10
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ccqogdvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADD620C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeHPWmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbeHPWmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:42:42 -0400
Received: from localhost.localdomain (unknown [192.55.54.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF93821480;
        Thu, 16 Aug 2018 19:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534448539;
        bh=vbKdO+tyeqYQl6yRI7HHxqzQ/ynvtYqmJK6qEKKW3u0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ccqogdvm7hsSrHyDggZyYdStNvKkub7gQaxx+KjZ7+w1xZ/c9aPiZLdr87spuE20N
         9NWOy7PWtq7Vht0ad0PkPii0MCqKSf0dBl9iinoRORghLaaK700gUKkcH6kYGTpURH
         R1U8K4XguMxrtaTFwySjG6Q2jSv/Q5/n6O+U6iuY=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 2/2] drivers: fpga: fix two trivial spelling mistakes
Date:   Thu, 16 Aug 2018 14:42:14 -0500
Message-Id: <20180816194214.3462-3-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180816194214.3462-1-atull@kernel.org>
References: <20180816194214.3462-1-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to two spelling mistakes
"execeeded" -> "exceeded"
"Invaild" -> "Invalid"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-afu-dma-region.c | 2 +-
 drivers/fpga/dfl-fme-mgr.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 0e81d33..025aba3 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -70,7 +70,7 @@ static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
 	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
 		incr ? '+' : '-', npages << PAGE_SHIFT,
 		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
-		ret ? "- execeeded" : "");
+		ret ? "- exceeded" : "");
 
 	up_write(&current->mm->mmap_sem);
 
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index b5ef405..9f045d0 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -201,7 +201,7 @@ static int fme_mgr_write(struct fpga_manager *mgr,
 		}
 
 		if (count < 4) {
-			dev_err(dev, "Invaild PR bitstream size\n");
+			dev_err(dev, "Invalid PR bitstream size\n");
 			return -EINVAL;
 		}
 
-- 
2.7.4

