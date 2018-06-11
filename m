Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Qy3eMIZeHltcNAAAmS7hNA
	; Mon, 11 Jun 2018 11:36:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 48356607E4; Mon, 11 Jun 2018 11:36:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B4EBA60791;
	Mon, 11 Jun 2018 11:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B4EBA60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbeFKLgU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:36:20 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:33163 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932953AbeFKLgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:36:15 -0400
Received: from [109.168.11.45] (port=54392 helo=pc-ceresoli.dev.aim)
        by srv-hp10.netsons.net with esmtpa (Exim 4.89_1)
        (envelope-from <luca@lucaceresoli.net>)
        id 1fSL7M-00B1A2-W4; Mon, 11 Jun 2018 13:36:13 +0200
From: Luca Ceresoli <luca@lucaceresoli.net>
To: linux-media@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/8] media: imx274: actually use IMX274_DEFAULT_MODE
Date: Mon, 11 Jun 2018 13:35:35 +0200
Message-Id: <1528716939-17015-5-git-send-email-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528716939-17015-1-git-send-email-luca@lucaceresoli.net>
References: <1528716939-17015-1-git-send-email-luca@lucaceresoli.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMX274_DEFAULT_MODE is defined but not used. Start using it, so the
default can be more easily changed without digging into the code.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>

---
Changed v3 -> v4: nothing

Changed v2 -> v3: nothing

Changed v1 -> v2:
 - add "media: " prefix to commit message
---
 drivers/media/i2c/imx274.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index f075715ffced..ceeec97cd330 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -1621,7 +1621,7 @@ static int imx274_probe(struct i2c_client *client,
 	mutex_init(&imx274->lock);
 
 	/* initialize format */
-	imx274->mode = &imx274_formats[IMX274_MODE_3840X2160];
+	imx274->mode = &imx274_formats[IMX274_DEFAULT_MODE];
 	imx274->format.width = imx274->mode->size.width;
 	imx274->format.height = imx274->mode->size.height;
 	imx274->format.field = V4L2_FIELD_NONE;
-- 
2.7.4
