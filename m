Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A020C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CFC20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jWQeLDCg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jWQeLDCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfAUVdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:33:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfAUVdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:33:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EBFE26030B; Mon, 21 Jan 2019 21:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548106397;
        bh=pZlb6ZRFE8XQPAADoQpmJw5Ta3I1ieK21GzdBoq7BcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWQeLDCgVzifRE8dS+aMqiDWW5pYIABnxcwLHs4ISFHhzYHQr4UoHBgUUGy4HcEvj
         Aqe9z/ya6YDUxjl5hb1JenH1QTRnsx8YTi4a/oakMj8pUqPHTYJ3rO1LV0mgXh7lYf
         dXe0UWssqCfAqZrVpqbG1TT0yhu07++4BLI7AxLE=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1FD646030B;
        Mon, 21 Jan 2019 21:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548106397;
        bh=pZlb6ZRFE8XQPAADoQpmJw5Ta3I1ieK21GzdBoq7BcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWQeLDCgVzifRE8dS+aMqiDWW5pYIABnxcwLHs4ISFHhzYHQr4UoHBgUUGy4HcEvj
         Aqe9z/ya6YDUxjl5hb1JenH1QTRnsx8YTi4a/oakMj8pUqPHTYJ3rO1LV0mgXh7lYf
         dXe0UWssqCfAqZrVpqbG1TT0yhu07++4BLI7AxLE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1FD646030B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     mark.rutland@arm.com, balbi@kernel.org
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v3 2/3] usb: dwc3: qcom: Add support for MSM8998
Date:   Mon, 21 Jan 2019 14:33:08 -0700
Message-Id: <1548106388-5079-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548106307-4762-1-git-send-email-jhugo@codeaurora.org>
References: <1548106307-4762-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a MSM8998 specific DT compatible so that we can properly bind to the
device and enable the USB controller.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index a6d0203..184df4d 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -595,6 +595,7 @@ static int __maybe_unused dwc3_qcom_runtime_resume(struct device *dev)
 static const struct of_device_id dwc3_qcom_of_match[] = {
 	{ .compatible = "qcom,dwc3" },
 	{ .compatible = "qcom,msm8996-dwc3" },
+	{ .compatible = "qcom,msm8998-dwc3" },
 	{ .compatible = "qcom,sdm845-dwc3" },
 	{ }
 };
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

