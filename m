Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D65DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E32721848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JfmFVAuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfBZPLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:11:19 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:65488 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfBZPLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551193880; x=1582729880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Y6bN5OYca6nC87kBj0w2sl6iSVD3W+Bqink+e+Gyu/U=;
  b=JfmFVAuXUwr1z+0UGpQQqEX14p1pJMaIzZI5lREkpuVEXrBL9Lx77kzp
   PRuu73V86P8ekoermfY5X90iMprHFA8MPzHb656Zfjz5h4T1H4iWr+aze
   pMxRZO5xxSASvaO0flR9xLHZZUnVDRAGLmRMdW5r/vaCcvp5IqAIZgarL
   2ULtWTu+LoDKGQ7gq7KmioY/PtiHsx6JBE3iHA3fCFDjIhXTqKVHuo2oI
   fRupqpNm4Bs6jWZBXIh/WzNs0P4kVTUMZc4VgchxVC1s6dVtMJEzVzz5r
   z2Lha7VflfYy1sRrqng8SVLOeJRDiJ3+BiMbKHzKee1LPdFc63aeQCUzc
   g==;
X-IronPort-AV: E=Sophos;i="5.58,416,1544457600"; 
   d="scan'208";a="102187797"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2019 23:11:18 +0800
IronPort-SDR: 0V9E6SmB0emdqe8cf5EBn25TJvUyEEysAPNkoZ2s1Wp4bOquept2Cn3J86GdxzC4tjM4lpPu23
 24CAaEvtrwzz97ML/ZdvTU8W6rfGEuiyyCEjbavciL5TCcvXuJfFGHEjU1xB5Q6yB429qRXm6H
 C1VS+usAOLX/4YrWmeSQKJ/O6OT32DvlzVFhxkZWzu4cc+alhkDu54WNik0Wx+im8+75uhYaj0
 vWXrj1peogHAy1Tqy5sPHy/cFaVpUYQGXNzqW0lQkua4+ARKWsSPig1AEX8vINZ97IWgPRJoEm
 NumHAdNxPCJ/UnY8Fep7skiI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Feb 2019 06:49:24 -0800
IronPort-SDR: E/6td9UlJFFecuLvnSHytPEFSuIllZp6hfYmwoYOwd+5MoUjD8suFWQ86251p1GnsFsJHjYSZR
 09rtzSNhIl6ZE7DQL7sN04ICrdXCs3MLEhXpTA427imhGb03wM2YMDap2DCS4X3AS1Ng3xBsaY
 XWOP+V9iPZv/K3y50SDkyxo44KvSJhygmjZrwU1n54MZ9JAX1b/g7orF2YH+u5xq8vEsicNq/y
 LUQwH31qWSFFiQeotrJn7pHHD9Sxkx6Pm5Iw3FPXO+Jf3eXqW8Jsx4dOrqqc3F4Nxw6ualnnf6
 xqE=
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Feb 2019 07:11:09 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 2/2] mmc: core: Add sd discard timeout
Date:   Tue, 26 Feb 2019 17:10:25 +0200
Message-Id: <1551193825-31074-3-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551193825-31074-1-git-send-email-avri.altman@wdc.com>
References: <1551193825-31074-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The busy timeout is 250msec per discard command.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b7367ac..4979d4e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -51,6 +51,7 @@
 
 /* The max erase timeout, used when host->max_busy_timeout isn't specified */
 #define MMC_ERASE_TIMEOUT_MS	(60 * 1000) /* 60 s */
+#define SD_DISCARD_TIMEOUT_MS	(250)
 
 static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
 
@@ -1619,6 +1620,12 @@ static unsigned int mmc_sd_erase_timeout(struct mmc_card *card,
 {
 	unsigned int erase_timeout;
 
+	/* for DISCARD none of the below calculation applies.
+	 * the busy timeout is 250msec per discard command.
+	 */
+	if (arg == SD_DISCARD_ARG)
+		return SD_DISCARD_TIMEOUT_MS;
+
 	if (card->ssr.erase_timeout) {
 		/* Erase timeout specified in SD Status Register (SSR) */
 		erase_timeout = card->ssr.erase_timeout * qty +
-- 
1.9.1

