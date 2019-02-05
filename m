Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8470C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A838120844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 03:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="hUBZYFdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfBEDxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 22:53:03 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:54478 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfBEDxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 22:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549338778; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=awiFMSIPL2Ydb2/a77PPVGyFLcCgToedvlcOQyvGzH0=;
        b=hUBZYFdtNABeWiv3cuQIaIcWBH73lWwgGg57vEEn0SPf6El/TN5bn8rAWb1maE4MH9CSc0
        u+KeaBcXIhYKmVmD6DJv9bp1QSjA0xXxXi5+JA8WBaC/DYR8Ed0B275CF4TpoXX/X8yHft
        LvpfZiwZFQ5kmkqY/dNal5j50oqU8+o=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 3/4] memory: jz4780-nemc: Reduce size of const array
Date:   Tue,  5 Feb 2019 00:52:39 -0300
Message-Id: <20190205035240.31410-4-paul@crapouillou.net>
In-Reply-To: <20190205035240.31410-1-paul@crapouillou.net>
References: <20190205035240.31410-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum value found in that array is 15, there's no need to store
these values as uint32_t, a uint8_t is enough.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

v2: Remove casts to uint32_t

v3: No change

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

