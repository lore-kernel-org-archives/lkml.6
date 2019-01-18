Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846ACC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481802086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="jifH1gww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfARPN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:13:59 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:57906 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfARPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547824435; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5SUMpnsYufCnYUc/6dP1L6P0dlGlODpOD4JhJD66cpQ=;
        b=jifH1gwwWRGIKbqEuT3a7SeFAgrrVRb9Jalk7/JdliKAscKV4YMflcKtpFDYkfmX5gzTFj
        aF5+6IlEG+JthGeEJZAScHqIYk7e3ajS64xtsXy4d6U1plryzJaJDQc8WEbxrVXGSZ3ddK
        8C1W8u/O36avB3P0kUy1Xwzr+24+fqg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/4] memory: jz4780-nemc: Reduce size of const array
Date:   Fri, 18 Jan 2019 12:13:28 -0300
Message-Id: <20190118151329.8040-3-paul@crapouillou.net>
In-Reply-To: <20190118151329.8040-1-paul@crapouillou.net>
References: <20190118151329.8040-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum value found in that array is 15, there's no need to store
these values as uint32_t, a uint8_t is enough.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

v2: Remove casts to uint32_t

 drivers/memory/jz4780-nemc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index bcf06adefc96..66b8b43eaeff 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -161,7 +161,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
 	 * Conversion of tBP and tAW cycle counts to values supported by the
 	 * hardware (round up to the next supported value).
 	 */
-	static const uint32_t convert_tBP_tAW[] = {
+	static const u8 convert_tBP_tAW[] = {
 		0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
 
 		/* 11 - 12 -> 12 cycles */
-- 
2.11.0

