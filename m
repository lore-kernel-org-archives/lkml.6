Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A621EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45ED723F73
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fBSuqEFt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VXxZ86fQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45ED723F73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753533AbeGFJUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:20:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60760 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbeGFJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:20:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E054860B26; Fri,  6 Jul 2018 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530868842;
        bh=+izTOp1oXxS9rVvLYdQ290l2I2nFVUZe1y/05C/aN5k=;
        h=From:To:Cc:Subject:Date:From;
        b=fBSuqEFtK8hUj5P//917Z96YosEpVA3vVEvEQyY1ekPRdWf1GZOS/JWPflncLhag3
         jFeVicbRovQ+dQ6OmBdJ1+kEZomhINeYgJbuY3y5In5ejf3xCVEbSBcQE1cGrJ2ydG
         okYMljmHeBpGK3vA7Qu7srE84KzX3ofnWxX/WK4M=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CA4E601D9;
        Fri,  6 Jul 2018 09:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530868841;
        bh=+izTOp1oXxS9rVvLYdQ290l2I2nFVUZe1y/05C/aN5k=;
        h=From:To:Cc:Subject:Date:From;
        b=VXxZ86fQPdKg4xbR0kjA5LXcQVMVt0v9V2ZBZUBZHbnYnm4ES9MBLB3GjAMzLKz7Z
         mVM1w7EssIL453rdgIsSCLY8jGC3CM4RNCLOUKoIDi8KC2aBxfvMHYUqpwLt93iud6
         D/EFLxZNsNAndI+5xAGCjzAE5ve0wc14nqiFS/cg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CA4E601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH] arm64: defconfig: Enable CONFIG_MTD_NAND_QCOM for IPQ8074
Date:   Fri,  6 Jul 2018 14:50:30 +0530
Message-Id: <1530868830-19363-1-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM IPQ8074 boards contain NAND flash memory for which
this config needs to be enabled.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6739fc7..339f3dd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -179,6 +179,7 @@ CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_NAND_MARVELL=y
+CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

