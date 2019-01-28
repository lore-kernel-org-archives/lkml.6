Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6B3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61A320881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oIai9uuC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U3g6ucIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfA1TPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:15:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48478 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfA1TPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:15:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 72B1060F91; Mon, 28 Jan 2019 19:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548702951;
        bh=yZSdMMQsRjd1YjqkjkSmmTSz2cf/QMQE0+Krewzebao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oIai9uuCWexslqJS299BNB0YH4vyEnPKVs7m+7XqG5jYCPFdroLbpK6u9xNsxfZuA
         YkOyV4MCUV73lfU8/hVrJfkaFkJKv+XOVAo4H44vp8n8tBbjvpg4hNQ89XLScoVY+G
         SkAPQVsy0keNRPiZZHvIRBYPU1tMKFdvSVVEhb5M=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04FDC60F81;
        Mon, 28 Jan 2019 19:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548702929;
        bh=yZSdMMQsRjd1YjqkjkSmmTSz2cf/QMQE0+Krewzebao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3g6ucIszJH824QzcqJhKX2TigFBUl5J1I0YXFz9GtVPX8djXcYcII4ip9+9ySaG2
         OCnEsA5Guy8kAwotXY1pe8X40G3YbzaDNm8TVYVBdKlMigTD3l8OF7cZaoSLE9RHTC
         Buo7yVpElwuhDGDyP81nkU/M1WYutr6gIY6QwD8I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04FDC60F81
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv5 6/7] coresight: debug: Add Unique Component Identifier (UCI) table
Date:   Tue, 29 Jan 2019 00:44:03 +0530
Message-Id: <1019e6fed1ade6a580f01df9b3f70c2a9df5b3be.1548419933.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UCI table and a helper macro for coresight CPU debug
module. This patch adds the UCI entries for Krypo CPUs
found on MSM8996 which shares the same PIDs as ETMs.

Without this, below error is observed on MSM8996:

[    5.429867] OF: graph: no port node found in /soc/debug@3810000
[    5.429938] coresight-etm4x: probe of 3810000.debug failed with error -22
[    5.435415] coresight-cpu-debug 3810000.debug: Coresight debug-CPU0 initialized
[    5.446474] OF: graph: no port node found in /soc/debug@3910000
[    5.448927] coresight-etm4x: probe of 3910000.debug failed with error -22
[    5.454681] coresight-cpu-debug 3910000.debug: Coresight debug-CPU1 initialized
[    5.487765] OF: graph: no port node found in /soc/debug@3a10000
[    5.488007] coresight-etm4x: probe of 3a10000.debug failed with error -22
[    5.493024] coresight-cpu-debug 3a10000.debug: Coresight debug-CPU2 initialized
[    5.501802] OF: graph: no port node found in /soc/debug@3b10000
[    5.512901] coresight-etm4x: probe of 3b10000.debug failed with error -22
[    5.513192] coresight-cpu-debug 3b10000.debug: Coresight debug-CPU3 initialized

Also add a helper macro to make adding CPU PIDs easier
similar to ETM4X driver.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

---
This patch depends on UCI support by Mike Leach in below link:
 https://lore.kernel.org/lkml/20190121233151.13363-2-mike.leach@linaro.org/
---
 .../hwtracing/coresight/coresight-cpu-debug.c | 41 +++++++++++++------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 45b2460f3166..a126ed0b9a76 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -655,20 +655,35 @@ static int debug_remove(struct amba_device *adev)
 	return 0;
 }
 
+#define DEBUG_AMBA_ID(pid)			\
+	{					\
+		.id	= pid,			\
+		.mask	= 0x000fffff,		\
+	}
+
+static struct amba_cs_uci_id uci_id_debug[] = {
+	{
+		/*  CPU Debug UCI data */
+		.devarch	= 0x47706a15,
+		.devarch_mask	= 0xfff0ffff,
+		.devtype	= 0x00000015,
+	}
+};
+
+#define DEBUG_AMBA_UCI_ID(pid)			\
+	{					\
+		.id	= pid,			\
+		.mask	= 0x000fffff,		\
+		.data	= uci_id_debug,		\
+	}
+
 static const struct amba_id debug_ids[] = {
-	{       /* Debug for Cortex-A53 */
-		.id	= 0x000bbd03,
-		.mask	= 0x000fffff,
-	},
-	{       /* Debug for Cortex-A57 */
-		.id	= 0x000bbd07,
-		.mask	= 0x000fffff,
-	},
-	{       /* Debug for Cortex-A72 */
-		.id	= 0x000bbd08,
-		.mask	= 0x000fffff,
-	},
-	{ 0, 0 },
+	DEBUG_AMBA_ID(0x000bbd03),		/* Cortex-A53 */
+	DEBUG_AMBA_ID(0x000bbd07),		/* Cortex-A57 */
+	DEBUG_AMBA_ID(0x000bbd08),		/* Cortex-A72 */
+	DEBUG_AMBA_UCI_ID(0x000f0205),		/* Qualcomm Kryo */
+	DEBUG_AMBA_UCI_ID(0x000f0211),		/* Qualcomm Kryo */
+	{},
 };
 
 static struct amba_driver debug_driver = {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

