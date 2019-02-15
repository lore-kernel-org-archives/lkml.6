Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD3B2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198484;
	bh=qjGRfRjUwd1VDeT5BSEkJb5/S2fGn5cU0GNbhrquwUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gpC0cKo9IqNnwF/fAqjWSHR9UTDewSPyksxErJ8w4oXF8UGdXH6jnwNWy55En2MCo
	 chf13DvHWI1NQBWHGIVAlvrtdHq7tJiM5wpphaMUZLsC4+gVNro5LOtDjDJuo2RDtd
	 Jm+F0fFQwvIQ/WAtONhFvyMd8Ttn62xoibxSRtMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbfBOCJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:09:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388424AbfBOCJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3FA4222A1;
        Fri, 15 Feb 2019 02:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196576;
        bh=qjGRfRjUwd1VDeT5BSEkJb5/S2fGn5cU0GNbhrquwUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goFUJwWQxHJlbh5q8j634wt88pILKUCqKuxMOZ+Zi6s2VDJhwE8rVwrHAkG/Z8bj8
         i4JXJfajhM1Zk8OzTPpPCIF8xKUTP+U1TVY0OWpGr3F0C77xI39H4iXVizepnk5GMT
         Hz5irlkRpCwf9a9B9thHzuGpENolgOAEEGimHFA4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 23/77] ASoC: rt5682: Fix PLL source register definitions
Date:   Thu, 14 Feb 2019 21:08:01 -0500
Message-Id: <20190215020855.176727-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit ee7ea2a9a318a89d21b156dc75e54d53904bdbe5 ]

Fix typo which causes headphone no sound while using BCLK
as PLL source.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index d82a8301fd74..96944cff0ed7 100644
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -849,18 +849,18 @@
 #define RT5682_SCLK_SRC_PLL2			(0x2 << 13)
 #define RT5682_SCLK_SRC_SDW			(0x3 << 13)
 #define RT5682_SCLK_SRC_RCCLK			(0x4 << 13)
-#define RT5682_PLL1_SRC_MASK			(0x3 << 10)
-#define RT5682_PLL1_SRC_SFT			10
-#define RT5682_PLL1_SRC_MCLK			(0x0 << 10)
-#define RT5682_PLL1_SRC_BCLK1			(0x1 << 10)
-#define RT5682_PLL1_SRC_SDW			(0x2 << 10)
-#define RT5682_PLL1_SRC_RC			(0x3 << 10)
-#define RT5682_PLL2_SRC_MASK			(0x3 << 8)
-#define RT5682_PLL2_SRC_SFT			8
-#define RT5682_PLL2_SRC_MCLK			(0x0 << 8)
-#define RT5682_PLL2_SRC_BCLK1			(0x1 << 8)
-#define RT5682_PLL2_SRC_SDW			(0x2 << 8)
-#define RT5682_PLL2_SRC_RC			(0x3 << 8)
+#define RT5682_PLL2_SRC_MASK			(0x3 << 10)
+#define RT5682_PLL2_SRC_SFT			10
+#define RT5682_PLL2_SRC_MCLK			(0x0 << 10)
+#define RT5682_PLL2_SRC_BCLK1			(0x1 << 10)
+#define RT5682_PLL2_SRC_SDW			(0x2 << 10)
+#define RT5682_PLL2_SRC_RC			(0x3 << 10)
+#define RT5682_PLL1_SRC_MASK			(0x3 << 8)
+#define RT5682_PLL1_SRC_SFT			8
+#define RT5682_PLL1_SRC_MCLK			(0x0 << 8)
+#define RT5682_PLL1_SRC_BCLK1			(0x1 << 8)
+#define RT5682_PLL1_SRC_SDW			(0x2 << 8)
+#define RT5682_PLL1_SRC_RC			(0x3 << 8)
 
 
 
-- 
2.19.1

