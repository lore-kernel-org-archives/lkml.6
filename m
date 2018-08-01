Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD18C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2418E208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZEXaot6x";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WGVtfibX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2418E208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733229AbeHAHXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:23:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51736 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731897AbeHAHXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:23:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 98AF360B7A; Wed,  1 Aug 2018 05:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533101967;
        bh=kTdXujUNh+/gLe7/yg3WsFY29XtgH3REhfBGhc9a77M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEXaot6xjJauL7A2xTjH8Tgo6ogMQgVDGicdMOHgLbeYYWQCIo352WFJlkSAUq3wR
         2AQrShAvOW53pp3lS1FxVEWmAYseIl7V6Bhgbbl208yaBfuTYpzLyMU8r+F5zYwi7z
         DP8E2KS1aLUaH8FyUoO9hTq5X7t2rsC5ir+nXHf4=
Received: from corebsp04-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mshettel@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D2B360B62;
        Wed,  1 Aug 2018 05:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533101966;
        bh=kTdXujUNh+/gLe7/yg3WsFY29XtgH3REhfBGhc9a77M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGVtfibXXHkA4qvGZyNYSBTymMPUN7CkLbFyoFfvbznEwva1xGLsF4joQ+p8HIqZq
         /1iD9Zpi5IbvXGwbM+5LFYCVPRWtXXLN992ARZ1VyuMrCMFoILWuI/kWdh8fxBHzQs
         Ygm9WDaNfqjUNrHYdwnr7xRRhBpItHsyByLhtLz0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D2B360B62
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mshettel@codeaurora.org
From:   Mike Shettel <mshettel@codeaurora.org>
To:     gregkh@linuxfoundation.org, boris.brezillon@bootlin.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     Mike Shettel <mshettel@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, bjorn.andersson@linaro.org
Subject: [PATCH v1 3/3] MAINTAINERS: Add Qualcomm Generic Interface I3C driver maintainer
Date:   Tue, 31 Jul 2018 23:39:02 -0600
Message-Id: <1533101942-29442-4-git-send-email-mshettel@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
References: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Shettel <mshettel@codeaurora.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 622327b..775829c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10943,6 +10943,14 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/qualcomm/emac/
 
+QUALCOMM GENERIC INTERFACE I3C DRIVER
+M:	Alok Chauhan <alokc@codeaurora.org>
+M:	Mike Shettel <mshettel@codeaurora.org>
+L:	linux-i2c@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Supported
+F:	drivers/i3c/master/i3c-master-qcom-geni.c
+
 QUALCOMM HEXAGON ARCHITECTURE
 M:	Richard Kuo <rkuo@codeaurora.org>
 L:	linux-hexagon@vger.kernel.org
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

