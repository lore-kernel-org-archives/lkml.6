Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889ADC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC7B2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025973;
	bh=6sT0o+68zBOm4nfSnH07N+YIIZ139m1xleIttFOKPfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SUlEqKThiP4YqfYs1mvpSAovLSolS5TvnXZG+TCkjV3vCsxySZ/tobyhE0b1S4Ioa
	 v/2YT1UBO+enlZpdQzKILAczkxXTn9WVOCWl7I8snf5BGNUHIoWNHl9yPofhrHrjaS
	 cUUeezY6ZOHhQoQ5XZ4tlphroaL1D48fuZnnF3Sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389682AbfBMCqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:46:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389092AbfBMCkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6114222CA;
        Wed, 13 Feb 2019 02:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025648;
        bh=6sT0o+68zBOm4nfSnH07N+YIIZ139m1xleIttFOKPfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWv8qVdNuQwGg/IQ5fCzsG9bGJNJGMAivOjD4XgLDat+Jep5WiYjwVBVOIy2tX7vs
         FQayCsvIk3IVvNdKSkCLM2fsoaNVpBC1U6Nst0hzuIRJgbQi7lH++le9eAv7ZQcOe+
         /GCO/xTrvP9ZpHbxw9qVI6ptv4SKlovvqxUqwBb0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com
Subject: [PATCH AUTOSEL 4.9 07/21] mfd: wm5110: Add missing ASRC rate register
Date:   Tue, 12 Feb 2019 21:40:26 -0500
Message-Id: <20190213024040.21740-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213024040.21740-1-sashal@kernel.org>
References: <20190213024040.21740-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 04c801c18ded421845324255e660147a6f58dcd6 ]

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/wm5110-tables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
index 1ee68bd440fb..16c6e2accfaa 100644
--- a/drivers/mfd/wm5110-tables.c
+++ b/drivers/mfd/wm5110-tables.c
@@ -1618,6 +1618,7 @@ static const struct reg_default wm5110_reg_default[] = {
 	{ 0x00000ECD, 0x0000 },    /* R3789  - HPLPF4_2 */
 	{ 0x00000EE0, 0x0000 },    /* R3808  - ASRC_ENABLE */
 	{ 0x00000EE2, 0x0000 },    /* R3810  - ASRC_RATE1 */
+	{ 0x00000EE3, 0x4000 },    /* R3811  - ASRC_RATE2 */
 	{ 0x00000EF0, 0x0000 },    /* R3824  - ISRC 1 CTRL 1 */
 	{ 0x00000EF1, 0x0000 },    /* R3825  - ISRC 1 CTRL 2 */
 	{ 0x00000EF2, 0x0000 },    /* R3826  - ISRC 1 CTRL 3 */
@@ -2869,6 +2870,7 @@ static bool wm5110_readable_register(struct device *dev, unsigned int reg)
 	case ARIZONA_ASRC_ENABLE:
 	case ARIZONA_ASRC_STATUS:
 	case ARIZONA_ASRC_RATE1:
+	case ARIZONA_ASRC_RATE2:
 	case ARIZONA_ISRC_1_CTRL_1:
 	case ARIZONA_ISRC_1_CTRL_2:
 	case ARIZONA_ISRC_1_CTRL_3:
-- 
2.19.1

