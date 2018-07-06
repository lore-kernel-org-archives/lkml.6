Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D8AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46FB23F4E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ob6FwVkO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ob6FwVkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46FB23F4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeGFJOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:14:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56468 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbeGFJOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:14:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A3103606AC; Fri,  6 Jul 2018 09:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530868470;
        bh=X/8N60X35VUwYbkUm8EFdMIp/IIDhKGGRNRuPkXkyO4=;
        h=From:To:Cc:Subject:Date:From;
        b=Ob6FwVkONn0E/W4TZ0POn+gjxPJk17kXuwPboOorFdKpdv76gByMFcuhHQAkSnTtY
         6LUNZb58FQnUzA5n/MEjiuCo7PUmKoRkRLVgOcnfL8cDtiZeb7xdgZZeO6FdiFFnmo
         2swdTit2YD+Y5skeoXE8iAUplwEkrSSeYFdAqD00=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BFF456037C;
        Fri,  6 Jul 2018 09:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530868470;
        bh=X/8N60X35VUwYbkUm8EFdMIp/IIDhKGGRNRuPkXkyO4=;
        h=From:To:Cc:Subject:Date:From;
        b=Ob6FwVkONn0E/W4TZ0POn+gjxPJk17kXuwPboOorFdKpdv76gByMFcuhHQAkSnTtY
         6LUNZb58FQnUzA5n/MEjiuCo7PUmKoRkRLVgOcnfL8cDtiZeb7xdgZZeO6FdiFFnmo
         2swdTit2YD+Y5skeoXE8iAUplwEkrSSeYFdAqD00=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFF456037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH] ARM: qcom_defconfig: Enable QCOM NAND related configs
Date:   Fri,  6 Jul 2018 14:44:16 +0530
Message-Id: <1530868456-18792-1-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8064 and IPQ4019 boards contain NAND flash
memory for which these configs need to be enabled.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index dd2a089..6aa7046 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -57,6 +57,8 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

