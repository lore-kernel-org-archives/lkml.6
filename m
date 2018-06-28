Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8324DC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5E127036
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5E127036
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934272AbeF1HdR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:33:17 -0400
Received: from foss.arm.com ([217.140.101.70]:42238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934216AbeF1HdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:33:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15A7318A;
        Thu, 28 Jun 2018 00:33:11 -0700 (PDT)
Received: from sugar.kfn.arm.com (unknown [10.45.48.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65E2D3F5C0;
        Thu, 28 Jun 2018 00:33:09 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] crypto: ccree: remove dead legacy code
Date:   Thu, 28 Jun 2018 08:32:54 +0100
Message-Id: <1530171175-31960-5-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530171175-31960-1-git-send-email-gilad@benyossef.com>
References: <1530171175-31960-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove legacy code no longer used by anything.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_cipher.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index 3af44a5..8204c87 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -730,12 +730,6 @@ static int cc_cipher_process(struct skcipher_request *req,
 	cc_req.user_cb = (void *)cc_cipher_complete;
 	cc_req.user_arg = (void *)req;
 
-#ifdef ENABLE_CYCLE_COUNT
-	cc_req.op_type = (direction == DRV_CRYPTO_DIRECTION_DECRYPT) ?
-		STAT_OP_TYPE_DECODE : STAT_OP_TYPE_ENCODE;
-
-#endif
-
 	/* Setup request context */
 	req_ctx->gen_ctx.op_type = direction;
 
-- 
2.7.4

