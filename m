Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA3EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6201920B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mRPQatgh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g8znjEBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfBAAyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:54:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53692 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfBAAyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:54:36 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5E79C609B4; Fri,  1 Feb 2019 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548982474;
        bh=cOv1SdLBmv4fsD9RRLAErnqJHBc4ueOGqANHW2pMlig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRPQatghAMxmpSWIZ6sUiDRjWoek32EzK2zTPgRt037Y8b1WDD+y6dd/+7JryyTGw
         MNqx4rDJenvWwAsVn7kRXdL0kgdUk6QeO7Cn8667AhUZ1CmXlDSyEAwCYmZV6Lnurm
         LNkwTgIIWKHat8UapU214FwHWWKNkDpkqJjUOpeM=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED46A60BF5;
        Fri,  1 Feb 2019 00:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548982448;
        bh=cOv1SdLBmv4fsD9RRLAErnqJHBc4ueOGqANHW2pMlig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g8znjEBN+MSX2KR3qLsdlrwrg0tGdZSi2vOS6+IfXeo6/bVaRCKHtTROBrHyoVlMy
         Qy72wdY9OyBd9Ebzyto0Iau6uNetzbFUrDOKkV5i4NydaHu5uprEA8uzBOvIcmim/n
         j94WYcM7qLIm1Tx2O4RxRwfwX1kRrIlJ+FWEyZJ4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED46A60BF5
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
Subject: [PATCHv7 5/6] coresight: etm4x: Add ETM PIDs for SDM845 and MSM8996
Date:   Fri,  1 Feb 2019 06:23:13 +0530
Message-Id: <c050252dc8eb3fea03119cd5efc422ed6e48834e.1548981329.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of overriding the peripheral id(PID) check in AMBA
by hardcoding them in DT, add the PIDs to the ETM4x driver.
Here we use Unique Component Identifier(UCI) for MSM8996
since the ETM and CPU debug module shares the same PIDs.
SDM845 does not support CPU debug module.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

---
For testing, all dependent patches are in below tree:
 * https://github.com/saiprakash-ranjan/linux/tree/coresight-next

This patch depends on UCI support by Mike Leach in below link:
 * https://lore.kernel.org/lkml/20190130234051.2294-1-mike.leach@linaro.org/
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 08ce37c9475d..5819ced2beec 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1078,11 +1078,15 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
 };
 
 static const struct amba_id etm4_ids[] = {
-	CS_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
-	CS_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
-	CS_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
-	CS_AMBA_ID(0x000bb959),		/* Cortex-A73 */
-	CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),	/* Cortex-A35 */
+	CS_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
+	CS_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
+	CS_AMBA_ID(0x000bb95a),			/* Cortex-A72 */
+	CS_AMBA_ID(0x000bb959),			/* Cortex-A73 */
+	CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
+	CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
+	CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
+	CS_AMBA_ID(0x000bb802),			/* Qualcomm Kryo 385 Cortex-A55 */
+	CS_AMBA_ID(0x000bb803),			/* Qualcomm Kryo 385 Cortex-A75 */
 	{},
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

