Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBB8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E7320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="baiDzYw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfAQUjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:39:48 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16647 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbfAQUjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:39:47 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c40e7f40000>; Thu, 17 Jan 2019 12:39:16 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Jan 2019 12:39:47 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 17 Jan 2019 12:39:47 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 17 Jan
 2019 20:39:47 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 17 Jan
 2019 20:39:46 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 17 Jan 2019 20:39:46 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c40e8120000>; Thu, 17 Jan 2019 12:39:46 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1] i2c: tegra: increase transfer timeout
Date:   Thu, 17 Jan 2019 12:39:32 -0800
Message-ID: <1547757572-29075-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547757556; bh=tKX/9B7fnQLWRPPC23IkONvQaMpzZYVtD/vT+rGJw9s=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=baiDzYw8D7+v3Bk9Oq38YNAFPzMBfJMJ4d9MQ6TlQdPfyKh4GnbRoObmpN2cGiHvn
         QmHr041dwQa3hUdFTd9o4esK52pj4bCsPMKFqcBeVUYO1Vz4h5t5d/3ASlQWszeE1E
         oh9gJyyV8bvzXf+w2lg9NaYez+P/xG/BsymKqZOu44eMCB1idlDyoHARYFnTI2jVhy
         +8/r1VjllCfNjbu+bvxWKZgD8OwStMZV/AulljtieAoDqyzxnrKaDMFqYu0enajpo3
         M50rQsmRqa9AkzsZpDxhSR2hlZeTxCxuQcAfQNxTPU8dLTGvr1DopQL9OQUBrUA387
         PE54dEB+tRSLQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

increase transfer timeout to 10s to allow enough time during max
transfer size.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index e417ebf7628c..ca7c581fb4c0 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -25,7 +25,7 @@
 
 #include <asm/unaligned.h>
 
-#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
+#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(10000))
 #define BYTES_PER_FIFO_WORD 4
 
 #define I2C_CNFG				0x000
-- 
2.7.4

