Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63722C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C67D2151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C67D2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbeHXUMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:12:18 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:35964 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeHXULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:11:34 -0400
Received: from [109.168.11.45] (port=58220 helo=pc-ceresoli.dev.aim)
        by srv-hp10.netsons.net with esmtpa (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1ftF49-00EAi1-Ra; Fri, 24 Aug 2018 18:36:05 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-media@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] media: imx274: fix error in function docs
Date:   Fri, 24 Aug 2018 18:35:23 +0200
Message-Id: <20180824163525.12694-6-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180824163525.12694-1-luca@lucaceresoli.net>
References: <20180824163525.12694-1-luca@lucaceresoli.net>
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

This parameter holds the number of bytes, not bits.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/media/i2c/imx274.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index 6572d5728791..07bc41f537c5 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -668,7 +668,7 @@ static inline int imx274_write_reg(struct stimx274 *priv, u16 addr, u8 val)
  * @addr: Address of the LSB register.  Other registers must be
  *        consecutive, least-to-most significant.
  * @val: Value to be written to the register (cpu endianness)
- * @nbytes: Number of bits to write (range: [1..3])
+ * @nbytes: Number of bytes to write (range: [1..3])
  */
 static int imx274_write_mbreg(struct stimx274 *priv, u16 addr, u32 val,
 			      size_t nbytes)
-- 
2.17.1

